/* =============================================================================
 * bpsk_loopback.h  –  BPSK Modulator / Demodulator Loopback Test
 *
 * Register macros and public API for the BPSK IP cores and the bit-capture
 * DMA.  All addresses are accessed via Xil_In32 / Xil_Out32 (no-OS or
 * Xilinx BSP).
 *
 * Physical loopback assumption:
 *   TX SMA ──[attenuator ~20 dB]──► RX SMA
 *   Both LOs set to the same frequency in default_init_param.
 * ============================================================================= */

#ifndef BPSK_LOOPBACK_H_
#define BPSK_LOOPBACK_H_

#include <stdint.h>
#include "parameters.h"   /* for BPSK_*_BASEADDR, BPSK_BITS_DDR_BASEADDR */

/* ---------------------------------------------------------------------------
 * BPSK Modulator registers  (base: BPSK_MOD_BASEADDR)
 * --------------------------------------------------------------------------- */
#define MOD_REG_CTRL        (BPSK_MOD_BASEADDR + 0x00)
#define MOD_REG_STATUS      (BPSK_MOD_BASEADDR + 0x04)
#define MOD_REG_SYM_DIV     (BPSK_MOD_BASEADDR + 0x08)
#define MOD_REG_AMPLITUDE   (BPSK_MOD_BASEADDR + 0x0C)
#define MOD_REG_PAT_DATA    (BPSK_MOD_BASEADDR + 0x10)
#define MOD_REG_SYM_CNT_LO  (BPSK_MOD_BASEADDR + 0x18)
#define MOD_REG_SYM_CNT_HI  (BPSK_MOD_BASEADDR + 0x1C)
#define MOD_REG_VERSION     (BPSK_MOD_BASEADDR + 0x20)

/* CTRL bits */
#define MOD_CTRL_ENABLE      (1u << 0)
#define MOD_CTRL_SRC_ALT     (0u << 1)   /* alternating 0/1 */
#define MOD_CTRL_SRC_PAT     (1u << 1)   /* 32-bit register pattern */
#define MOD_CTRL_SRC_DMA     (2u << 1)   /* AXI-Stream from DAC DMA */
#define MOD_CTRL_SRC_MASK    (3u << 1)

/* ---------------------------------------------------------------------------
 * BPSK Demodulator registers  (base: BPSK_DEMOD_BASEADDR)
 * --------------------------------------------------------------------------- */
#define DEMOD_REG_CTRL        (BPSK_DEMOD_BASEADDR + 0x00)
#define DEMOD_REG_STATUS      (BPSK_DEMOD_BASEADDR + 0x04)
#define DEMOD_REG_SPS         (BPSK_DEMOD_BASEADDR + 0x08)
#define DEMOD_REG_AGC_TARGET  (BPSK_DEMOD_BASEADDR + 0x0C)
#define DEMOD_REG_AGC_CTRL    (BPSK_DEMOD_BASEADDR + 0x10)
#define DEMOD_REG_COSTAS_KP   (BPSK_DEMOD_BASEADDR + 0x14)
#define DEMOD_REG_COSTAS_KI   (BPSK_DEMOD_BASEADDR + 0x18)
#define DEMOD_REG_TIMING_KP   (BPSK_DEMOD_BASEADDR + 0x1C)
#define DEMOD_REG_TIMING_KI   (BPSK_DEMOD_BASEADDR + 0x20)
#define DEMOD_REG_PHASE_ERR   (BPSK_DEMOD_BASEADDR + 0x24)
#define DEMOD_REG_TIMING_ERR  (BPSK_DEMOD_BASEADDR + 0x28)
#define DEMOD_REG_BIT_CNT_LO  (BPSK_DEMOD_BASEADDR + 0x2C)
#define DEMOD_REG_BIT_CNT_HI  (BPSK_DEMOD_BASEADDR + 0x30)
#define DEMOD_REG_VERSION     (BPSK_DEMOD_BASEADDR + 0x34)

/* STATUS bits */
#define DEMOD_STATUS_READY          (1u << 0)
#define DEMOD_STATUS_ACTIVE         (1u << 1)
#define DEMOD_STATUS_CARRIER_LOCKED (1u << 2)
#define DEMOD_STATUS_AGC_SETTLED    (1u << 3)
#define DEMOD_STATUS_LOCKED_ALL     (DEMOD_STATUS_CARRIER_LOCKED | \
                                     DEMOD_STATUS_AGC_SETTLED)

/* ---------------------------------------------------------------------------
 * Bits-capture DMA registers  (ADI axi_dmac, base: BPSK_BITS_DMA_BASEADDR)
 * --------------------------------------------------------------------------- */
#define BITS_DMA_REG_CTRL        (BPSK_BITS_DMA_BASEADDR + 0x000)
#define BITS_DMA_REG_START_XFER  (BPSK_BITS_DMA_BASEADDR + 0x00C)
#define BITS_DMA_REG_XFER_DONE   (BPSK_BITS_DMA_BASEADDR + 0x088)
#define BITS_DMA_REG_DEST_ADDR   (BPSK_BITS_DMA_BASEADDR + 0x410)
#define BITS_DMA_REG_XFER_LEN    (BPSK_BITS_DMA_BASEADDR + 0x418)

/* ---------------------------------------------------------------------------
 * Loopback test parameters
 * --------------------------------------------------------------------------- */
/* Samples per symbol — must match MOD_SYM_DIV in hardware */
#define BPSK_SYM_DIV        16u

/* Known 32-bit repeating test pattern transmitted by the modulator.
 * Expected received bytes (MSB-first): 0xA5, 0xC3, 0xF0, 0xE1, repeating. */
#define BPSK_TEST_PATTERN   0xA5C3F0E1u

/* Expected byte sequence (BPSK_TEST_PATTERN split into bytes, MSB-first) */
static const uint8_t BPSK_EXPECTED_BYTES[4] = {0xA5u, 0xC3u, 0xF0u, 0xE1u};

/* Number of bytes to capture per test run */
#define BPSK_CAPTURE_BYTES  4096u

/* Number of leading bytes to skip (pipeline latency + loop settling) */
#define BPSK_SKIP_BYTES     64u

/* Lock wait timeout in ms */
#define BPSK_LOCK_TIMEOUT_MS  5000u

/* ---------------------------------------------------------------------------
 * Public API
 * --------------------------------------------------------------------------- */
int  bpsk_loopback_test(void);

#endif /* BPSK_LOOPBACK_H_ */
