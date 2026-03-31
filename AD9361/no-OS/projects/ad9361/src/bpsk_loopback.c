/* =============================================================================
 * bpsk_loopback.c  –  BPSK Modulator / Demodulator Loopback Test
 *
 * Test sequence
 * -------------
 *  1. Verify both IP cores are present (version register check)
 *  2. Configure demodulator loop gains and SPS
 *  3. Start modulator in ALTERNATING mode  (0,1,0,1,...)
 *     → gives the Costas loop a clean signal to lock onto
 *  4. Enable demodulator
 *  5. Poll STATUS until AGC + carrier locked (or timeout)
 *  6. Print diagnostic values (phase error, timing error, AGC gain)
 *  7. Switch modulator to PATTERN mode  (32-bit known pattern)
 *  8. Wait 100 ms for loop to re-settle on the new data
 *  9. Capture BPSK_CAPTURE_BYTES via bits-DMA into DDR buffer
 * 10. Compare captured bytes with expected pattern; count bit errors
 * 11. Print BER result and pass/fail
 * 12. Disable both IPs
 *
 * Physical requirements
 * ----------------------
 *  • Connect TX SMA → RX SMA with a ~20 dB attenuator.
 *  • Both AD9361 LOs must be at the same frequency (set in default_init_param).
 *  • FDD mode must be enabled so TX and RX operate simultaneously.
 * ============================================================================= */

#include "bpsk_loopback.h"

#ifdef XILINX_PLATFORM
#include <xil_io.h>
#include <xil_cache.h>
#include "no_os_delay.h"   /* no_os_mdelay() */
#endif

#include <stdio.h>
#include <stdint.h>
#include <string.h>

/* --------------------------------------------------------------------------
 * Helper macros
 * -------------------------------------------------------------------------- */
#define REG_WR(addr, val)   Xil_Out32((uintptr_t)(addr), (uint32_t)(val))
#define REG_RD(addr)        Xil_In32((uintptr_t)(addr))

/* --------------------------------------------------------------------------
 * Internal: modulator helpers
 * -------------------------------------------------------------------------- */
static void mod_disable(void)
{
    REG_WR(MOD_REG_CTRL, 0);
}

static void mod_start_alternating(void)
{
    REG_WR(MOD_REG_CTRL,    0);
    REG_WR(MOD_REG_SYM_DIV, BPSK_SYM_DIV);
    REG_WR(MOD_REG_AMPLITUDE, 0x7FFF);           /* full amplitude */
    REG_WR(MOD_REG_CTRL, MOD_CTRL_ENABLE | MOD_CTRL_SRC_ALT);
}

static void mod_start_pattern(uint32_t pattern)
{
    /* Do not reset the modulator — keep SYM_DIV and AMPLITUDE; just switch
     * source and load the new pattern.  This avoids a brief signal dropout
     * that could unlock the Costas loop. */
    uint32_t ctrl = REG_RD(MOD_REG_CTRL);
    ctrl = (ctrl & ~MOD_CTRL_SRC_MASK) | MOD_CTRL_SRC_PAT;
    REG_WR(MOD_REG_PAT_DATA, pattern);
    REG_WR(MOD_REG_CTRL, ctrl);
}

/* --------------------------------------------------------------------------
 * Internal: demodulator helpers
 * -------------------------------------------------------------------------- */
static void demod_configure(void)
{
    /* Disable before writing loop parameters */
    REG_WR(DEMOD_REG_CTRL, 0);

    /* SPS must match SYM_DIV */
    REG_WR(DEMOD_REG_SPS,        BPSK_SYM_DIV);

    /* AGC: target 0.25 full-scale; ki_shift=10 (integrator speed) */
    REG_WR(DEMOD_REG_AGC_TARGET, 0x2000u);
    REG_WR(DEMOD_REG_AGC_CTRL,  (10u << 16));    /* bits[19:16] = ki_shift */

    /* Costas loop gains */
    REG_WR(DEMOD_REG_COSTAS_KP, 0x0040u);
    REG_WR(DEMOD_REG_COSTAS_KI, 0x0008u);

    /* Mueller-Müller timing recovery gains */
    REG_WR(DEMOD_REG_TIMING_KP, 0x0020u);
    REG_WR(DEMOD_REG_TIMING_KI, 0x0004u);
}

static void demod_enable(void)
{
    REG_WR(DEMOD_REG_CTRL, 0x1u);
}

static void demod_disable(void)
{
    REG_WR(DEMOD_REG_CTRL, 0);
}

/* --------------------------------------------------------------------------
 * Internal: wait for AGC + carrier lock
 * Returns 0 if locked before timeout, -1 on timeout.
 * -------------------------------------------------------------------------- */
static int demod_wait_lock(uint32_t timeout_ms)
{
    uint32_t elapsed = 0;
    while (elapsed < timeout_ms) {
        uint32_t st = REG_RD(DEMOD_REG_STATUS);
        if ((st & DEMOD_STATUS_LOCKED_ALL) == DEMOD_STATUS_LOCKED_ALL)
            return 0;
        no_os_mdelay(10);
        elapsed += 10;
    }
    return -1;
}

/* --------------------------------------------------------------------------
 * Internal: bits-DMA capture
 *   dest_addr – physical DDR address (must be cache-line aligned, 64-byte)
 *   n_bytes   – number of bytes to capture
 *   timeout   – milliseconds to wait for completion
 * Returns 0 on success, -1 on timeout.
 * -------------------------------------------------------------------------- */
static int bits_dma_capture(uintptr_t dest_addr, uint32_t n_bytes,
                             uint32_t timeout_ms)
{
    /* Enable DMA engine */
    REG_WR(BITS_DMA_REG_CTRL, 0x1u);

    /* Invalidate cache for the destination range BEFORE the DMA writes */
    Xil_DCacheInvalidateRange(dest_addr, n_bytes);

    /* Set destination and length, then kick off transfer */
    REG_WR(BITS_DMA_REG_DEST_ADDR, (uint32_t)dest_addr);
    REG_WR(BITS_DMA_REG_XFER_LEN,  n_bytes - 1u);
    REG_WR(BITS_DMA_REG_START_XFER, 0x1u);

    /* Poll for completion */
    uint32_t elapsed = 0;
    while (elapsed < timeout_ms) {
        if (REG_RD(BITS_DMA_REG_XFER_DONE) & 0x1u) {
            /* Invalidate again so CPU sees DMA-written data */
            Xil_DCacheInvalidateRange(dest_addr, n_bytes);
            return 0;
        }
        no_os_mdelay(1);
        elapsed += 1;
    }
    return -1;
}

/* --------------------------------------------------------------------------
 * Internal: BER calculation
 *   buf          – pointer to captured byte buffer
 *   n_bytes      – total captured bytes
 *   skip_bytes   – leading bytes to ignore (pipeline latency + loop settling)
 *   bit_errors   – output: number of bit errors
 *   bits_tested  – output: number of bits compared
 *
 * The modulator sends BPSK_TEST_PATTERN bits MSB-first, repeating every
 * 4 bytes.  With the demodulator also packing MSB-first, the received byte
 * stream should be {0xA5, 0xC3, 0xF0, 0xE1} repeating.
 *
 * However, the bit stream may be OFFSET inside the 4-byte pattern window
 * depending on where the demodulator happened to start packing.  We try
 * all 4 byte-alignment offsets and pick the one with the fewest errors.
 * -------------------------------------------------------------------------- */
static void ber_calculate(const uint8_t *buf, uint32_t n_bytes,
                           uint32_t skip_bytes,
                           uint32_t *bit_errors, uint32_t *bits_tested)
{
    uint32_t best_errors = 0xFFFFFFFFu;
    uint32_t best_align  = 0;

    /* Try all 4 pattern-alignment offsets (0, 1, 2, 3 bytes) */
    uint32_t align;
    for (align = 0; align < 4u; align++) {
        uint32_t errs = 0;
        uint32_t i;
        for (i = skip_bytes; i < n_bytes; i++) {
            uint8_t expected = BPSK_EXPECTED_BYTES[(i + align) % 4u];
            uint8_t xorval   = buf[i] ^ expected;
            /* Count set bits (bit errors) using lookup */
            uint8_t v = xorval;
            v = v - ((v >> 1) & 0x55u);
            v = (v & 0x33u) + ((v >> 2) & 0x33u);
            errs += (uint32_t)((v + (v >> 4)) & 0x0Fu);
        }
        if (errs < best_errors) {
            best_errors = errs;
            best_align  = align;
        }
    }

    (void)best_align;   /* available in debugger if needed */
    *bit_errors  = best_errors;
    *bits_tested = (n_bytes - skip_bytes) * 8u;
}

/* ==========================================================================
 * Public entry point
 * ========================================================================== */
int bpsk_loopback_test(void)
{
    int      ret;
    uint32_t bit_errors, bits_tested;
    float    ber;

    printf("\r\n");
    printf("============================================================\r\n");
    printf("  BPSK Loopback Test\r\n");
    printf("  SYM_DIV = %u  |  SPS = %u\r\n", BPSK_SYM_DIV, BPSK_SYM_DIV);
    printf("  Test pattern : 0x%08X\r\n", BPSK_TEST_PATTERN);
    printf("  Capture size : %u bytes (%u bits)\r\n",
           BPSK_CAPTURE_BYTES, BPSK_CAPTURE_BYTES * 8u);
    printf("============================================================\r\n");

    /* ------------------------------------------------------------------
     * 1. Verify IP cores are present
     * ------------------------------------------------------------------ */
    uint32_t mod_ver   = REG_RD(MOD_REG_VERSION);
    uint32_t demod_ver = REG_RD(DEMOD_REG_VERSION);

    if (mod_ver != 0x00010000u) {
        printf("ERROR: BPSK Modulator not found at 0x%08X "
               "(read 0x%08X). Check address.\r\n",
               (unsigned)BPSK_MOD_BASEADDR, (unsigned)mod_ver);
        return -1;
    }
    if (demod_ver != 0x00010000u) {
        printf("ERROR: BPSK Demodulator not found at 0x%08X "
               "(read 0x%08X). Check address.\r\n",
               (unsigned)BPSK_DEMOD_BASEADDR, (unsigned)demod_ver);
        return -1;
    }
    printf("[OK] Both IPs detected (version 1.0.0)\r\n");

    /* ------------------------------------------------------------------
     * 2. Configure demodulator (loops disabled for now)
     * ------------------------------------------------------------------ */
    demod_configure();

    /* ------------------------------------------------------------------
     * 3. Start modulator — alternating 0/1 to give loops a clean signal
     * ------------------------------------------------------------------ */
    mod_start_alternating();
    printf("[..] Modulator started (alternating mode). Waiting for lock...\r\n");

    /* ------------------------------------------------------------------
     * 4. Enable demodulator
     * ------------------------------------------------------------------ */
    demod_enable();

    /* ------------------------------------------------------------------
     * 5. Wait for AGC + carrier lock
     * ------------------------------------------------------------------ */
    ret = demod_wait_lock(BPSK_LOCK_TIMEOUT_MS);

    uint32_t status_reg = REG_RD(DEMOD_REG_STATUS);
    printf("    STATUS = 0x%08X  |  AGC_settled=%u  Carrier_locked=%u\r\n",
           (unsigned)status_reg,
           (unsigned)((status_reg >> 3) & 1u),
           (unsigned)((status_reg >> 2) & 1u));

    if (ret != 0) {
        printf("WARNING: Lock timeout after %u ms.\r\n", BPSK_LOCK_TIMEOUT_MS);
        printf("         Continuing anyway — BER may be high.\r\n");
        printf("         Check: TX→RX cable, attenuator (~20 dB), AD9361 LO freq.\r\n");
    } else {
        printf("[OK] Locked.\r\n");
    }

    /* ------------------------------------------------------------------
     * 6. Print diagnostics
     * ------------------------------------------------------------------ */
    uint32_t agc_ctrl   = REG_RD(DEMOD_REG_AGC_CTRL);
    int16_t  phase_err  = (int16_t)(REG_RD(DEMOD_REG_PHASE_ERR)  & 0xFFFFu);
    int16_t  timing_err = (int16_t)(REG_RD(DEMOD_REG_TIMING_ERR) & 0xFFFFu);
    uint16_t agc_gain   = (uint16_t)(agc_ctrl & 0xFFFFu);
    float    gain_f     = (float)agc_gain / 4096.0f;

    printf("    AGC gain     = 0x%04X  (%.3fx)\r\n",
           (unsigned)agc_gain, gain_f);
    printf("    Phase error  = %d\r\n", (int)phase_err);
    printf("    Timing error = %d\r\n", (int)timing_err);

    /* ------------------------------------------------------------------
     * 7. Switch modulator to known 32-bit test pattern
     *    (source switch without restart — keeps loops locked)
     * ------------------------------------------------------------------ */
    mod_start_pattern(BPSK_TEST_PATTERN);
    printf("[..] Modulator switched to pattern 0x%08X\r\n",
           (unsigned)BPSK_TEST_PATTERN);

    /* Short delay: let demodulator pipeline flush and re-settle */
    no_os_mdelay(100);

    /* ------------------------------------------------------------------
     * 8. Capture bits via bits-DMA
     * ------------------------------------------------------------------ */
    printf("[..] Capturing %u bytes via bits-DMA...\r\n", BPSK_CAPTURE_BYTES);

    uintptr_t buf_addr = (uintptr_t)BPSK_BITS_DDR_BASEADDR;
    ret = bits_dma_capture(buf_addr, BPSK_CAPTURE_BYTES, 5000);

    if (ret != 0) {
        printf("ERROR: Bits-DMA capture timeout.\r\n");
        printf("       Check: DMA address (0x%08X), M_AXIS_BITS connected,\r\n",
               (unsigned)BPSK_BITS_DMA_BASEADDR);
        printf("       demodulator ENABLE=1, and bit counter incrementing.\r\n");
        mod_disable();
        demod_disable();
        return -1;
    }
    printf("[OK] Capture done.\r\n");

    /* ------------------------------------------------------------------
     * 9. Calculate BER
     * ------------------------------------------------------------------ */
    uint8_t *buf = (uint8_t *)buf_addr;
    ber_calculate(buf, BPSK_CAPTURE_BYTES, BPSK_SKIP_BYTES,
                  &bit_errors, &bits_tested);
    ber = (bits_tested > 0u) ? ((float)bit_errors / (float)bits_tested) : 1.0f;

    /* Print a hex dump of the first 16 captured bytes for visual check */
    printf("\r\n  First 16 captured bytes: ");
    uint32_t k;
    for (k = 0; k < 16u && k < BPSK_CAPTURE_BYTES; k++)
        printf("%02X ", buf[k]);
    printf("\r\n");
    printf("  Expected pattern  :      A5 C3 F0 E1 A5 C3 F0 E1 (repeating)\r\n");

    /* Re-read diagnostics after test */
    status_reg  = REG_RD(DEMOD_REG_STATUS);
    agc_gain    = (uint16_t)(REG_RD(DEMOD_REG_AGC_CTRL) & 0xFFFFu);
    phase_err   = (int16_t)(REG_RD(DEMOD_REG_PHASE_ERR)  & 0xFFFFu);
    timing_err  = (int16_t)(REG_RD(DEMOD_REG_TIMING_ERR) & 0xFFFFu);
    uint32_t total_bits_lo = REG_RD(DEMOD_REG_BIT_CNT_LO);
    uint32_t total_bits_hi = REG_RD(DEMOD_REG_BIT_CNT_HI) & 0xFFu;
    uint64_t total_bits = ((uint64_t)total_bits_hi << 32) | total_bits_lo;

    printf("\r\n");
    printf("============================================================\r\n");
    printf("  BPSK Loopback Test Results\r\n");
    printf("------------------------------------------------------------\r\n");
    printf("  Bits tested       : %u\r\n", (unsigned)bits_tested);
    printf("  Bit errors        : %u\r\n", (unsigned)bit_errors);
    printf("  BER               : %.2e\r\n", ber);
    printf("  AGC gain (Q4.12)  : 0x%04X  (%.3fx)\r\n",
           (unsigned)agc_gain, (float)agc_gain / 4096.0f);
    printf("  Phase error       : %d\r\n", (int)phase_err);
    printf("  Timing error      : %d\r\n", (int)timing_err);
    printf("  Carrier locked    : %u\r\n",
           (unsigned)((status_reg >> 2) & 1u));
    printf("  AGC settled       : %u\r\n",
           (unsigned)((status_reg >> 3) & 1u));
    printf("  Total demod bits  : %llu\r\n", (unsigned long long)total_bits);
    printf("------------------------------------------------------------\r\n");

    if (bit_errors == 0u) {
        printf("  RESULT:  *** PERFECT ***  BER = 0  (zero bit errors)\r\n");
    } else if (ber < 1e-4f) {
        printf("  RESULT:  GOOD  –  BER < 1e-4\r\n");
    } else if (ber < 1e-2f) {
        printf("  RESULT:  MARGINAL  –  BER = %.2e  (check gains/cable)\r\n",
               ber);
    } else {
        printf("  RESULT:  POOR  –  BER = %.2e\r\n", ber);
        printf("  Tips:\r\n");
        printf("    - Confirm TX→RX cable + ~20 dB attenuator\r\n");
        printf("    - Confirm both LOs at same frequency\r\n");
        printf("    - Increase AD9361 RX gain if AGC_gain > 0x4000\r\n");
        printf("    - Try increasing COSTAS_KP (write 0x80 to 0x%08X)\r\n",
               (unsigned)DEMOD_REG_COSTAS_KP);
    }
    printf("============================================================\r\n\r\n");

    /* ------------------------------------------------------------------
     * 10. Clean up
     * ------------------------------------------------------------------ */
    mod_disable();
    demod_disable();

    return (bit_errors == 0u) ? 0 : 1;   /* 0=perfect, 1=errors, -1=fatal */
}
