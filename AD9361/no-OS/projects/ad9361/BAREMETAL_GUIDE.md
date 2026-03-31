# FMCOMM2 ZED — Bare-Metal Software Guide
## BPSK Modulator + Demodulator + DMA Bit Capture

---

## Table of Contents

1. [System Overview](#1-system-overview)
2. [Address Map](#2-address-map)
3. [BPSK Modulator](#3-bpsk-modulator)
4. [BPSK Demodulator](#4-bpsk-demodulator)
5. [Bit Capture DMA](#5-bit-capture-dma)
6. [Initialization Sequence](#6-initialization-sequence)
7. [Complete Example](#7-complete-example)
8. [Bit Format Reference](#8-bit-format-reference)
9. [Tuning the Demodulator Loops](#9-tuning-the-demodulator-loops)
10. [Troubleshooting](#10-troubleshooting)

---

## 1. System Overview

```
                        PL (FPGA)
 ┌──────────────────────────────────────────────────────────────┐
 │                                                              │
 │   PS DDR ──► axi_ad9361_dac_dma ──► bpsk_modulator          │
 │                                          │ I/Q (DAC)        │
 │                                          ▼                   │
 │                                     axi_ad9361 ◄──────────► │ AD9361
 │                                          │ I/Q (ADC)        │ RF
 │                              util_ad9361_adc_pack            │
 │                                    │           │             │
 │              (existing ADC DMA) ◄──┘           │ (tap)      │
 │                                                ▼             │
 │                                      bpsk_demodulator        │
 │                                          │ M_AXIS_BITS       │
 │                                          ▼                   │
 │                          axis_dwidth_converter (8→16 bit)    │
 │                                          │                   │
 │                                    axi_dmac_bits             │
 │                                          │ M_DEST_AXI        │
 │                                          ▼                   │
 │                                   PS7 S_AXI_HP3              │
 │                                          │                   │
 └──────────────────────────────────────────┼───────────────────┘
                                            ▼
                                        PS DDR
                                    (decoded bit buffer)

 CPU (PS) controls everything via AXI-Lite registers
```

---

## 2. Address Map

> **Important:** Verify these addresses in your Vivado Address Editor.
> Right-click any peripheral in the block design → Highlight Connection
> to confirm. The values below match the design built in this project.

| Peripheral | Base Address | Range | Notes |
|-----------|-------------|-------|-------|
| `bpsk_modulator_v1_0` | `0x4380_0000` | 64 KB | BPSK TX control |
| `bpsk_demodulator_v1_0` | `0x43C0_0000` | 64 KB | BPSK RX control |
| `axi_dmac_bits` | `0x7C44_0000` | 64 KB | Bit capture DMA — **check your Address Editor** |
| `axi_ad9361` | `0x7900_0000` | 64 KB | AD9361 core (existing) |
| `axi_ad9361_adc_dma` | `0x7C40_0000` | 64 KB | ADC raw IQ DMA (existing) |
| `axi_ad9361_dac_dma` | `0x7C42_0000` | 64 KB | DAC DMA (existing) |
| DDR start | `0x0000_0000` | 512 MB | PS DDR memory |
| Suggested bit buffer | `0x1000_0000` | — | Safe uncached DDR region |

---

## 3. BPSK Modulator

### 3.1 Register Map

Base address: `0x4380_0000`

| Offset | Name | R/W | Reset | Description |
|--------|------|-----|-------|-------------|
| `0x00` | CTRL | R/W | `0x0` | Control register (see bits below) |
| `0x04` | STATUS | RO | `0x1` | Status register |
| `0x08` | SYM_DIV | R/W | `0x10` | `[15:0]` Clock divider (samples per symbol) |
| `0x0C` | AMPLITUDE | R/W | `0x7FFF` | `[15:0]` I amplitude for bit=0 (I_POS) |
| `0x10` | PAT_DATA | R/W | `0x0` | `[31:0]` 32-bit pattern (used when SRC_SEL=01) |
| `0x18` | SYM_CNT_LO | RO | `0x0` | `[31:0]` Symbol counter lower 32 bits |
| `0x1C` | SYM_CNT_HI | RO | `0x0` | `[7:0]` Symbol counter upper 8 bits |
| `0x20` | IP_VERSION | RO | `0x0001_0000` | Version 1.0.0 |

**CTRL register bits:**

| Bit | Name | Description |
|-----|------|-------------|
| `[0]` | ENABLE | 1 = modulator active |
| `[2:1]` | SRC_SEL | `00` = alternating 0/1 · `01` = register pattern · `10` = AXI-Stream from DMA |
| `[3]` | CH_SEL | `0` = TX1 only · `1` = TX1+TX2 |

**SRC_SEL modes:**

| Value | Mode | Use case |
|-------|------|----------|
| `2'b00` | Alternating | Loop-back test, loop settling |
| `2'b01` | Pattern | Fixed 32-bit repeating pattern from PAT_DATA |
| `2'b10` | DMA stream | Transmit arbitrary data from PS DDR via DAC DMA |

### 3.2 Register Access Macros

```c
#include "xil_io.h"

#define MOD_BASE        0x43800000UL

#define MOD_CTRL        (MOD_BASE + 0x00)
#define MOD_STATUS      (MOD_BASE + 0x04)
#define MOD_SYM_DIV     (MOD_BASE + 0x08)
#define MOD_AMPLITUDE   (MOD_BASE + 0x0C)
#define MOD_PAT_DATA    (MOD_BASE + 0x10)
#define MOD_SYM_CNT_LO  (MOD_BASE + 0x18)
#define MOD_SYM_CNT_HI  (MOD_BASE + 0x1C)
#define MOD_VERSION     (MOD_BASE + 0x20)

/* CTRL bits */
#define MOD_CTRL_ENABLE         (1 << 0)
#define MOD_CTRL_SRC_ALT        (0 << 1)   /* alternating 0/1 */
#define MOD_CTRL_SRC_PAT        (1 << 1)   /* register pattern */
#define MOD_CTRL_SRC_DMA        (2 << 1)   /* AXI-Stream / DMA */
#define MOD_CTRL_CH_BOTH        (1 << 3)   /* TX1 + TX2 */

#define MOD_REG_WRITE(addr, val)  Xil_Out32(addr, val)
#define MOD_REG_READ(addr)        Xil_In32(addr)
```

### 3.3 API Functions

```c
/* Verify IP is present */
int bpsk_mod_check(void)
{
    return (MOD_REG_READ(MOD_VERSION) == 0x00010000) ? 0 : -1;
}

/* Configure and start modulator in alternating mode (for loop settling) */
void bpsk_mod_start_alternating(uint16_t sym_div)
{
    MOD_REG_WRITE(MOD_CTRL,    0);                    /* disable first */
    MOD_REG_WRITE(MOD_SYM_DIV, sym_div);              /* samples per symbol */
    MOD_REG_WRITE(MOD_AMPLITUDE, 0x7FFF);             /* full amplitude */
    MOD_REG_WRITE(MOD_CTRL, MOD_CTRL_ENABLE | MOD_CTRL_SRC_ALT);
}

/* Switch to fixed pattern mode */
void bpsk_mod_start_pattern(uint32_t pattern, uint16_t sym_div)
{
    MOD_REG_WRITE(MOD_CTRL,    0);
    MOD_REG_WRITE(MOD_SYM_DIV, sym_div);
    MOD_REG_WRITE(MOD_PAT_DATA, pattern);
    MOD_REG_WRITE(MOD_CTRL, MOD_CTRL_ENABLE | MOD_CTRL_SRC_PAT);
}

/* Switch to DMA stream mode (call after DAC DMA is set up) */
void bpsk_mod_start_dma(uint16_t sym_div)
{
    MOD_REG_WRITE(MOD_CTRL,    0);
    MOD_REG_WRITE(MOD_SYM_DIV, sym_div);
    MOD_REG_WRITE(MOD_AMPLITUDE, 0x7FFF);
    MOD_REG_WRITE(MOD_CTRL, MOD_CTRL_ENABLE | MOD_CTRL_SRC_DMA);
}

/* Stop modulator */
void bpsk_mod_stop(void)
{
    MOD_REG_WRITE(MOD_CTRL, 0);
}

/* Read total symbol count (40-bit) */
uint64_t bpsk_mod_sym_count(void)
{
    uint32_t lo = MOD_REG_READ(MOD_SYM_CNT_LO);
    uint32_t hi = MOD_REG_READ(MOD_SYM_CNT_HI) & 0xFF;
    return ((uint64_t)hi << 32) | lo;
}
```

---

## 4. BPSK Demodulator

### 4.1 Register Map

Base address: `0x43C0_0000`

| Offset | Name | R/W | Reset | Description |
|--------|------|-----|-------|-------------|
| `0x00` | CTRL | R/W | `0x0` | Control register |
| `0x04` | STATUS | RO | `0x1` | Status register |
| `0x08` | SPS | R/W | `0x08` | `[7:0]` Samples per symbol — **must match SYM_DIV** |
| `0x0C` | AGC_TARGET | R/W | `0x2000` | `[15:0]` Target amplitude (Q1.15) |
| `0x10` | AGC_CTRL | R/W | `0x0A1000` | `[19:16]` ki_shift · `[15:0]` current gain (RO, Q4.12) |
| `0x14` | COSTAS_KP | R/W | `0x0040` | `[15:0]` Costas proportional gain |
| `0x18` | COSTAS_KI | R/W | `0x0008` | `[15:0]` Costas integral gain |
| `0x1C` | TIMING_KP | R/W | `0x0020` | `[15:0]` Timing proportional gain |
| `0x20` | TIMING_KI | R/W | `0x0004` | `[15:0]` Timing integral gain |
| `0x24` | PHASE_ERR | RO | — | `[15:0]` Costas phase error (signed, diagnostic) |
| `0x28` | TIMING_ERR | RO | — | `[15:0]` M&M timing error (signed, diagnostic) |
| `0x2C` | BIT_CNT_LO | RO | `0` | `[31:0]` Decoded bit counter lower 32 bits |
| `0x30` | BIT_CNT_HI | RO | `0` | `[7:0]` Decoded bit counter upper 8 bits |
| `0x34` | IP_VERSION | RO | `0x0001_0000` | Version 1.0.0 |

**CTRL register bits:**

| Bit | Name | Description |
|-----|------|-------------|
| `[0]` | ENABLE | 1 = demodulator active |
| `[1]` | BYPASS_AGC | 1 = skip amplitude correction |
| `[2]` | BYPASS_COSTAS | 1 = skip phase/frequency correction |
| `[3]` | BYPASS_TIMING | 1 = skip symbol timing recovery |

**STATUS register bits:**

| Bit | Name | Description |
|-----|------|-------------|
| `[0]` | READY | Always 1 when IP is present |
| `[1]` | ACTIVE | 1 when ENABLE=1 and receiving data |
| `[2]` | CARRIER_LOCKED | 1 when Costas loop has locked |
| `[3]` | AGC_SETTLED | 1 when AGC is within 12.5% of target |

**AGC_CTRL register:**

| Bits | Field | Description |
|------|-------|-------------|
| `[15:0]` | AGC_GAIN (RO) | Current AGC gain in Q4.12 format (`0x1000` = 1.0) |
| `[19:16]` | KI_SHIFT (R/W) | AGC integrator speed: `gain_step = error >> ki_shift` |

### 4.2 Register Access Macros

```c
#define DEMOD_BASE          0x43C00000UL

#define DEMOD_CTRL          (DEMOD_BASE + 0x00)
#define DEMOD_STATUS        (DEMOD_BASE + 0x04)
#define DEMOD_SPS           (DEMOD_BASE + 0x08)
#define DEMOD_AGC_TARGET    (DEMOD_BASE + 0x0C)
#define DEMOD_AGC_CTRL      (DEMOD_BASE + 0x10)
#define DEMOD_COSTAS_KP     (DEMOD_BASE + 0x14)
#define DEMOD_COSTAS_KI     (DEMOD_BASE + 0x18)
#define DEMOD_TIMING_KP     (DEMOD_BASE + 0x1C)
#define DEMOD_TIMING_KI     (DEMOD_BASE + 0x20)
#define DEMOD_PHASE_ERR     (DEMOD_BASE + 0x24)
#define DEMOD_TIMING_ERR    (DEMOD_BASE + 0x28)
#define DEMOD_BIT_CNT_LO    (DEMOD_BASE + 0x2C)
#define DEMOD_BIT_CNT_HI    (DEMOD_BASE + 0x30)
#define DEMOD_VERSION       (DEMOD_BASE + 0x34)

/* STATUS bits */
#define DEMOD_STATUS_READY          (1 << 0)
#define DEMOD_STATUS_ACTIVE         (1 << 1)
#define DEMOD_STATUS_CARRIER_LOCKED (1 << 2)
#define DEMOD_STATUS_AGC_SETTLED    (1 << 3)
#define DEMOD_STATUS_LOCKED_MASK    (DEMOD_STATUS_CARRIER_LOCKED | \
                                     DEMOD_STATUS_AGC_SETTLED)

#define DEMOD_REG_WRITE(addr, val)  Xil_Out32(addr, val)
#define DEMOD_REG_READ(addr)        Xil_In32(addr)
```

### 4.3 API Functions

```c
/* Verify IP is present */
int bpsk_demod_check(void)
{
    return (DEMOD_REG_READ(DEMOD_VERSION) == 0x00010000) ? 0 : -1;
}

/* Configure demodulator — call before enabling */
void bpsk_demod_configure(uint8_t sps)
{
    DEMOD_REG_WRITE(DEMOD_CTRL,       0);          /* disable first */
    DEMOD_REG_WRITE(DEMOD_SPS,        sps);        /* must match MOD_SYM_DIV */
    DEMOD_REG_WRITE(DEMOD_AGC_TARGET, 0x2000);     /* 0.25 full-scale */
    DEMOD_REG_WRITE(DEMOD_AGC_CTRL,   (10 << 16)); /* ki_shift = 10 */
    DEMOD_REG_WRITE(DEMOD_COSTAS_KP,  0x0040);
    DEMOD_REG_WRITE(DEMOD_COSTAS_KI,  0x0008);
    DEMOD_REG_WRITE(DEMOD_TIMING_KP,  0x0020);
    DEMOD_REG_WRITE(DEMOD_TIMING_KI,  0x0004);
}

/* Enable demodulator */
void bpsk_demod_enable(void)
{
    DEMOD_REG_WRITE(DEMOD_CTRL, 0x1);
}

/* Disable demodulator */
void bpsk_demod_disable(void)
{
    DEMOD_REG_WRITE(DEMOD_CTRL, 0x0);
}

/* Poll until AGC + carrier locked or timeout (ms) */
int bpsk_demod_wait_lock(uint32_t timeout_ms)
{
    while (timeout_ms--) {
        uint32_t st = DEMOD_REG_READ(DEMOD_STATUS);
        if ((st & DEMOD_STATUS_LOCKED_MASK) == DEMOD_STATUS_LOCKED_MASK)
            return 0;   /* locked */
        usleep(1000);   /* 1 ms — replace with your timer */
    }
    return -1;          /* timeout */
}

/* Read total decoded bit count */
uint64_t bpsk_demod_bit_count(void)
{
    uint32_t lo = DEMOD_REG_READ(DEMOD_BIT_CNT_LO);
    uint32_t hi = DEMOD_REG_READ(DEMOD_BIT_CNT_HI) & 0xFF;
    return ((uint64_t)hi << 32) | lo;
}

/* Read diagnostic values */
typedef struct {
    int16_t  phase_err;     /* Costas phase error — should approach 0 when locked */
    int16_t  timing_err;    /* M&M timing error   — should approach 0 */
    uint16_t agc_gain;      /* Q4.12: 0x1000 = 1.0x */
    float    agc_gain_f;    /* AGC gain as float */
} bpsk_demod_diag_t;

void bpsk_demod_get_diag(bpsk_demod_diag_t *d)
{
    uint32_t agc_reg = DEMOD_REG_READ(DEMOD_AGC_CTRL);
    d->phase_err  = (int16_t)(DEMOD_REG_READ(DEMOD_PHASE_ERR)  & 0xFFFF);
    d->timing_err = (int16_t)(DEMOD_REG_READ(DEMOD_TIMING_ERR) & 0xFFFF);
    d->agc_gain   = (uint16_t)(agc_reg & 0xFFFF);
    d->agc_gain_f = (float)d->agc_gain / 4096.0f;
}
```

---

## 5. Bit Capture DMA

The BPSK demodulator outputs decoded bytes on `M_AXIS_BITS` (8-bit AXI-Stream,
MSB = first decoded bit). An ADI `axi_dmac` connected through a width converter
(8-bit → 16-bit) and PS7 `S_AXI_HP3` writes captured bytes directly into DDR.

### 5.1 Register Map (ADI axi_dmac)

Base address: `0x7C44_0000` *(verify in Address Editor)*

| Offset | Name | R/W | Description |
|--------|------|-----|-------------|
| `0x000` | DMAC_CTRL | R/W | `[0]` ENABLE |
| `0x00C` | START_TRANSFER | WO | Write `1` to start a transfer |
| `0x088` | TRANSFER_DONE | RO | `[0]` = 1 when transfer complete |
| `0x410` | DEST_ADDRESS | R/W | DDR destination address (physical) |
| `0x418` | TRANSFER_LENGTH | R/W | Transfer size in bytes minus 1 |

### 5.2 Register Access Macros

```c
#define DMA_BASE            0x7C440000UL   /* verify in Address Editor */

#define DMA_CTRL            (DMA_BASE + 0x000)
#define DMA_START_XFER      (DMA_BASE + 0x00C)
#define DMA_XFER_DONE       (DMA_BASE + 0x088)
#define DMA_DEST_ADDR       (DMA_BASE + 0x410)
#define DMA_XFER_LENGTH     (DMA_BASE + 0x418)

/* Physical DDR address for captured bits */
/* Must be in a non-cached region — configure in BSP linker script  */
/* or use Xil_SetTlbAttributes() to mark as strongly-ordered        */
#define BIT_BUFFER_PHYS     0x10000000UL   /* 256 MB mark, safe DDR region */
#define BIT_BUFFER_BYTES    4096           /* 4096 bytes = 32768 bits */

#define DMA_REG_WRITE(addr, val)  Xil_Out32(addr, val)
#define DMA_REG_READ(addr)        Xil_In32(addr)
```

### 5.3 DMA API Functions

```c
/* Initialise DMA engine (call once at startup) */
void bpsk_dma_init(void)
{
    DMA_REG_WRITE(DMA_CTRL, 0x1);   /* enable engine */
}

/* Start a capture transfer — non-blocking */
void bpsk_dma_start(uint32_t dest_phys_addr, uint32_t n_bytes)
{
    DMA_REG_WRITE(DMA_DEST_ADDR,    dest_phys_addr);
    DMA_REG_WRITE(DMA_XFER_LENGTH,  n_bytes - 1);
    DMA_REG_WRITE(DMA_START_XFER,   0x1);
}

/* Poll for completion — returns 0 on success, -1 on timeout */
int bpsk_dma_wait_done(uint32_t timeout_ms)
{
    while (timeout_ms--) {
        if (DMA_REG_READ(DMA_XFER_DONE) & 0x1)
            return 0;
        usleep(1000);
    }
    return -1;
}

/* Blocking capture: start + wait */
int bpsk_dma_capture(uint32_t dest_phys_addr, uint32_t n_bytes,
                     uint32_t timeout_ms)
{
    /* Invalidate cache for destination buffer before DMA write */
    Xil_DCacheInvalidateRange(dest_phys_addr, n_bytes);

    bpsk_dma_start(dest_phys_addr, n_bytes);
    return bpsk_dma_wait_done(timeout_ms);
}
```

### 5.4 Reading Decoded Bits from the Buffer

The demodulator packs 8 bits MSB-first into each byte:

```
bits_tdata[7] = first  decoded symbol
bits_tdata[6] = second decoded symbol
...
bits_tdata[0] = eighth decoded symbol
```

```c
/*
 * Extract individual bits from the DMA capture buffer.
 * buf      : pointer to DMA destination buffer
 * n_bytes  : number of bytes captured
 * bit_index: 0-based index of the bit to retrieve (0 = very first bit)
 */
uint8_t get_bit(const uint8_t *buf, uint32_t bit_index)
{
    uint32_t byte_pos = bit_index / 8;
    uint32_t bit_pos  = 7 - (bit_index % 8);   /* MSB first */
    return (buf[byte_pos] >> bit_pos) & 1;
}

/* Print first N bits from buffer */
void print_bits(const uint8_t *buf, uint32_t n_bits)
{
    for (uint32_t i = 0; i < n_bits; i++) {
        xil_printf("%d", get_bit(buf, i));
        if ((i + 1) % 8 == 0) xil_printf(" ");   /* space between bytes */
    }
    xil_printf("\r\n");
}
```

---

## 6. Initialization Sequence

> **Critical rule:** `SPS` (demodulator) must always equal `SYM_DIV` (modulator).
> If they differ, symbol timing will not lock.

```c
#include "xil_io.h"
#include "xil_cache.h"
#include "sleep.h"

/* Capture buffer in DDR (mark as non-cached in BSP or via MMU) */
static uint8_t __attribute__((section(".noinit")))
    bit_buf[BIT_BUFFER_BYTES];

/* Symbol rate — both modulator and demodulator must use this value */
#define SYM_DIV   16   /* 16 ADC samples per BPSK symbol */
                       /* at 245 MHz divclk → symbol rate ~15.3 Msps */

int system_init(void)
{
    int ret;

    /* 1. Verify IPs are present */
    if (bpsk_mod_check()   != 0) { xil_printf("MOD not found\r\n");   return -1; }
    if (bpsk_demod_check() != 0) { xil_printf("DEMOD not found\r\n"); return -1; }

    /* 2. Initialise DMA */
    bpsk_dma_init();

    /* 3. Configure demodulator (disabled for now) */
    bpsk_demod_configure(SYM_DIV);

    /* 4. Start modulator in alternating mode to let loops settle */
    bpsk_mod_start_alternating(SYM_DIV);

    /* 5. Enable demodulator */
    bpsk_demod_enable();

    /* 6. Wait for AGC + carrier lock (up to 2 seconds) */
    ret = bpsk_demod_wait_lock(2000);
    if (ret != 0) {
        xil_printf("WARNING: demod did not lock in 2s — check signal\r\n");
        /* Continue anyway — may still work with weak lock */
    }

    xil_printf("System ready. Status=0x%08X\r\n",
               DEMOD_REG_READ(DEMOD_STATUS));
    return 0;
}
```

---

## 7. Complete Example

### Loopback BER test (modulator → demodulator on same board)

```c
#include "xil_io.h"
#include "xil_cache.h"
#include "sleep.h"
#include "xil_printf.h"

#define SYM_DIV         16
#define CAPTURE_BYTES   4096     /* 32768 bits per capture */
#define CAPTURE_TIMEOUT 5000     /* 5 second DMA timeout */

/* Reference pattern for BER check: 0xAA = alternating 10101010 */
/* Matches MOD_CTRL_SRC_ALT output (bit 0 = I_POS, bit 1 = I_NEG, ...) */
#define EXPECTED_BYTE   0xAA

static uint8_t bit_buf[CAPTURE_BYTES];

int main(void)
{
    int      ret;
    uint32_t errors = 0;
    uint32_t total  = 0;
    float    ber;

    Xil_DCacheDisable();  /* simplest cache handling for bare-metal */

    /* ---- Init ------------------------------------------------------------ */
    ret = system_init();  /* from section 6 */
    if (ret != 0) return ret;

    /* ---- Switch modulator to alternating pattern for BER baseline --------- */
    bpsk_mod_start_alternating(SYM_DIV);
    sleep(1);  /* let loops re-settle after mode switch */

    xil_printf("Starting BER capture (%d bytes = %d bits)...\r\n",
               CAPTURE_BYTES, CAPTURE_BYTES * 8);

    /* ---- Capture bits via DMA -------------------------------------------- */
    ret = bpsk_dma_capture((uint32_t)bit_buf, CAPTURE_BYTES, CAPTURE_TIMEOUT);
    if (ret != 0) {
        xil_printf("ERROR: DMA capture timeout\r\n");
        return -1;
    }

    /* ---- Count bit errors ------------------------------------------------ */
    /* Alternating 0/1 = 0xAA bytes. Compare each captured byte.            */
    /* NOTE: first ~10 bytes may have errors due to pipeline settling.        */
    /* Skip first 16 bytes (128 bits = 8 symbol periods of latency).         */
    for (uint32_t i = 16; i < CAPTURE_BYTES; i++) {
        if (bit_buf[i] != EXPECTED_BYTE) {
            /* Count individual bit errors in this byte */
            uint8_t xor = bit_buf[i] ^ EXPECTED_BYTE;
            errors += __builtin_popcount(xor);
        }
        total += 8;
    }

    ber = (float)errors / (float)total;

    /* ---- Report ---------------------------------------------------------- */
    xil_printf("============================================\r\n");
    xil_printf("BER Test Results\r\n");
    xil_printf("  Bits tested    : %lu\r\n", total);
    xil_printf("  Bit errors     : %lu\r\n", errors);
    xil_printf("  BER            : %e\r\n",  ber);
    xil_printf("  Carrier locked : %d\r\n",
               (DEMOD_REG_READ(DEMOD_STATUS) >> 2) & 1);
    xil_printf("  AGC settled    : %d\r\n",
               (DEMOD_REG_READ(DEMOD_STATUS) >> 3) & 1);

    /* Read diagnostics */
    bpsk_demod_diag_t diag;
    bpsk_demod_get_diag(&diag);
    xil_printf("  AGC gain       : %.3f x (0x%04X)\r\n",
               diag.agc_gain_f, diag.agc_gain);
    xil_printf("  Phase error    : %d\r\n", diag.phase_err);
    xil_printf("  Timing error   : %d\r\n", diag.timing_err);
    xil_printf("  Total bits RX  : %llu\r\n", bpsk_demod_bit_count());

    if (errors == 0)
        xil_printf("  RESULT: PERFECT – BER = 0\r\n");
    else if (ber < 1e-4f)
        xil_printf("  RESULT: GOOD    – BER < 1e-4\r\n");
    else
        xil_printf("  RESULT: POOR    – check loop gains or signal path\r\n");

    xil_printf("============================================\r\n");

    return 0;
}
```

---

## 8. Bit Format Reference

### Modulator output mapping

| Bit value | I sample | Q sample | Note |
|-----------|----------|----------|------|
| `0` | `0x7FFF` (+1.0) | `0x0000` | I_POS |
| `1` | `0x8001` (−1.0) | `0x0000` | I_NEG |

### Demodulator output byte packing

Each DMA byte holds 8 consecutive decoded bits, **MSB = first bit in time**:

```
bit_buf[0] = { bit0, bit1, bit2, bit3, bit4, bit5, bit6, bit7 }
              ^^^^                                         ^^^^
           earliest                                      latest
```

To extract bit `N`:
```c
uint8_t bit = (bit_buf[N/8] >> (7 - N%8)) & 1;
```

### I/Q sample word format (ADC, 64-bit)

```
[15: 0] = I0  (channel 1 in-phase,    used by demodulator)
[31:16] = Q0  (channel 1 quadrature,  used by demodulator)
[47:32] = I1  (channel 2 in-phase,    unused)
[63:48] = Q1  (channel 2 quadrature,  unused)
```

All samples are 16-bit **signed** two's complement, Q1.15 format
(`0x7FFF` = +0.99997, `0x8000` = −1.0).

---

## 9. Tuning the Demodulator Loops

### Symbol rate mismatch — most common issue

```c
/* WRONG: SPS ≠ SYM_DIV */
bpsk_mod_start_alternating(8);    /* 8 clocks per symbol */
bpsk_demod_configure(16);         /* expects 16 — will never lock */

/* CORRECT: SPS = SYM_DIV */
bpsk_mod_start_alternating(16);
bpsk_demod_configure(16);
```

### AGC not settling

| Symptom | Cause | Fix |
|---------|-------|-----|
| `AGC_GAIN >> 0x8000` | Received amplitude too low | Increase AD9361 RX gain (AGC or manual) |
| `AGC_GAIN << 0x0100` | Received amplitude too high | Reduce AD9361 RX gain |
| Gain oscillates | `ki_shift` too small (too aggressive) | Increase `ki_shift` (write `[19:16]` of AGC_CTRL) |

```c
/* Slow down AGC (ki_shift = 12 instead of 10) */
uint32_t agc_val = DEMOD_REG_READ(DEMOD_AGC_CTRL);
agc_val = (agc_val & 0x000FFFFF) | (12 << 16);
DEMOD_REG_WRITE(DEMOD_AGC_CTRL, agc_val);
```

### Costas loop not locking

| Symptom | Cause | Fix |
|---------|-------|-----|
| `PHASE_ERR` large and not decreasing | KP too low | Double `COSTAS_KP` |
| `PHASE_ERR` oscillates ±large value | KP too high | Halve `COSTAS_KP` |
| Slow frequency acquisition | KI too low | Double `COSTAS_KI` |

```c
/* Increase Costas proportional gain */
DEMOD_REG_WRITE(DEMOD_COSTAS_KP, 0x0080);  /* default was 0x0040 */
```

### Testing loops independently

```c
/* Bypass AGC only — test with known amplitude */
DEMOD_REG_WRITE(DEMOD_CTRL, 0x1 | (1<<1));   /* ENABLE | BYPASS_AGC */

/* Bypass Costas loop — test with phase-aligned signal */
DEMOD_REG_WRITE(DEMOD_CTRL, 0x1 | (1<<2));   /* ENABLE | BYPASS_COSTAS */

/* Bypass timing recovery — test with exact SPS match */
DEMOD_REG_WRITE(DEMOD_CTRL, 0x1 | (1<<3));   /* ENABLE | BYPASS_TIMING */

/* All loops active (normal operation) */
DEMOD_REG_WRITE(DEMOD_CTRL, 0x1);
```

---

## 10. Troubleshooting

### DMA capture returns all zeros

1. Confirm `axi_dmac` address — read back `DMA_CTRL` register; if it reads
   `0xFFFFFFFF` the address is wrong.
2. Confirm `M_AXIS_BITS_TVALID` is toggling — enable modulator and check
   `BIT_CNT_LO` is incrementing:
   ```c
   uint64_t c1 = bpsk_demod_bit_count();
   sleep(1);
   uint64_t c2 = bpsk_demod_bit_count();
   /* c2 should be >> c1 if bits are flowing */
   ```
3. Confirm `DEMOD_CTRL[0] = 1` (ENABLE).
4. Confirm cache is disabled or buffer is marked non-cached.

### Carrier never locks (`STATUS[2]` stays 0)

1. Check signal arrives at ADC — scope the `PHASE_ERR` register; if it is
   random noise, no signal is reaching the demodulator.
2. Verify `adc_valid` is connected (`BIT_CNT_LO` must increment).
3. Try `BYPASS_COSTAS=1` — if bits flow correctly then the Costas loop
   gains need tuning.
4. Reduce `COSTAS_KP` by half and retry.

### High BER after lock

1. Check `SPS == SYM_DIV` — this is the most common cause.
2. Monitor `TIMING_ERR` — if non-zero, the M&M loop hasn't settled.
   Increase `TIMING_KP`.
3. BPSK has a 180° phase ambiguity — if all bits are inverted, flip them
   in software or use differential encoding in your protocol.
4. Verify `AGC_SETTLED` flag is set before starting BER measurement.

### IP registers read as 0xDEADBEEF

The peripheral address is wrong in the Address Editor or the AXI
interconnect `NUM_MI` was not increased. Recheck both:
- Vivado Address Editor: peripheral must show green (not yellow/unmapped)
- `axi_cpu_interconnect` parameter `NUM_MI` must be ≥ the master port
  number used + 1
