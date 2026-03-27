# BPSK Demodulator IP — Tutorial

This guide covers everything needed to build, simulate, package, and integrate
the BPSK Demodulator IP into the FMCOMM2 ZED reference design.

---

## Table of Contents

1. [Overview](#1-overview)
2. [Demodulation Chain](#2-demodulation-chain)
3. [File Structure](#3-file-structure)
4. [Register Map](#4-register-map)
5. [Vivado Project Setup](#5-vivado-project-setup)
6. [Simulation](#6-simulation)
7. [Synthesis and IP Packaging](#7-synthesis-and-ip-packaging)
8. [Block Design Integration (ZED)](#8-block-design-integration-zed)
9. [Software Control (Zynq PS)](#9-software-control-zynq-ps)
10. [Tuning the Loops](#10-tuning-the-loops)
11. [Troubleshooting](#11-troubleshooting)

---

## 1. Overview

The BPSK Demodulator IP receives I/Q samples from the AD9361 ADC data path
and recovers the transmitted bit stream using a fully conventional DSP chain:

```
AD9361 → util_ad9361_adc_pack ──┬──→ axi_ad9361_adc_dma  (existing, unchanged)
                                 │
                                 └──→ bpsk_demod_v1_0  ← TAP (this IP)
                                          │
                                          ▼
                                    M_AXIS_BITS
                                   (decoded bytes)
```

The demodulator is a **non-intrusive parallel tap** — it reads `packed_fifo_wr_data`
and `packed_fifo_wr_en` from `util_ad9361_adc_pack` without breaking the
existing connection to `axi_ad9361_adc_dma`.

### Key Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| Base address | `0x43C0_0000` | AXI4-Lite register base |
| AXI clock | 100 MHz | `S_AXI_ACLK` = `sys_cpu_clk` |
| Data clock | ~245 MHz | `aclk` = `util_ad9361_divclk` |
| Default SPS | 8 | Samples per BPSK symbol |
| Output | AXI4-Stream | 8-bit packed bytes, MSB-first |

---

## 2. Demodulation Chain

```
I_in, Q_in (16-bit signed, Q1.15 from AD9361)
    │
    ▼
┌─────────┐
│   AGC   │  Normalises amplitude.  gain = Q4.12 IIR integrator.
│         │  Taxicab metric: amplitude = |I| + |Q|
│         │  gain += (target − amplitude) >>> ki_shift
└────┬────┘
     │ I_agc, Q_agc
     ▼
┌─────────────────────────────────────────────┐
│  Costas Loop (carrier phase + freq tracking) │
│                                             │
│  NCO: 32-bit phase acc, 256-entry sin/cos LUT│
│       freq_word = freq_int + Kp * phase_err  │
│       freq_int += Ki * phase_err  (per symbol)│
│                                             │
│  Mixer: I_mix =  I*cos + Q*sin              │
│         Q_mix = -I*sin + Q*cos              │
│                                             │
│  Phase error: e = sign(I_mix) * Q_mix       │
│               (BPSK Costas discriminant)    │
└────┬────────────────────────────────────────┘
     │ I_mix
     ▼
┌────────────────────────────────────────────┐
│  Matched Filter + Symbol Timing (M&M TED)  │
│                                            │
│  Integrate-and-dump: sum I_mix over SPS    │
│  Mueller-Müller error:                     │
│    e = I_prev*sign(I_curr) - I_curr*sign(I_prev) │
│  Timing PI: sps_eff adjusted ±1 per symbol │
└────┬───────────────────────────────────────┘
     │ I_dump (soft symbol value)
     ▼
┌──────────────────────┐
│  Decision + Bit Pack │  bit = sign(I_dump); pack 8 → byte
└──────────┬───────────┘
           │
           ▼
    M_AXIS_BITS (AXI4-Stream, 8-bit)
```

---

## 3. File Structure

```
BPSK_Demodulator/
├── src/
│   ├── bpsk_demod_nco.v       32-bit NCO with 256-entry sin/cos LUT
│   ├── bpsk_demod_agc.v       Automatic Gain Control (Q4.12 gain)
│   ├── bpsk_demod_core.v      Full demodulation chain
│   └── bpsk_demod_v1_0.v      AXI4-Lite wrapper (IP top-level)
├── tb/
│   └── bpsk_demod_tb.v        5-scenario simulation testbench
├── constraints/
│   └── bpsk_demod.xdc         CDC false-path constraints
├── vivado/
│   ├── create_project.tcl     Creates Vivado project
│   └── package_ip.tcl         Packages HDL as reusable IP
└── TUTORIAL.md                This file
```

---

## 4. Register Map

Base address: **`0x43C0_0000`** (assign in Vivado Address Editor, 64 KB range)

| Offset | Name | R/W | Reset | Description |
|--------|------|-----|-------|-------------|
| `0x00` | CTRL | R/W | `0x0` | `[0]` ENABLE · `[1]` BYPASS_AGC · `[2]` BYPASS_COSTAS · `[3]` BYPASS_TIMING |
| `0x04` | STATUS | RO | `0x1` | `[0]` READY · `[1]` ACTIVE · `[2]` CARRIER_LOCKED · `[3]` AGC_SETTLED |
| `0x08` | SPS | R/W | `8` | `[7:0]` Samples per symbol (2–128) |
| `0x0C` | AGC_TARGET | R/W | `0x2000` | `[15:0]` Target amplitude (Q1.15) |
| `0x10` | AGC_CTRL | R/W | `0x0A1000` | `[19:16]` ki_shift · `[15:0]` current gain (RO, Q4.12) |
| `0x14` | COSTAS_KP | R/W | `0x0040` | `[15:0]` Costas proportional gain |
| `0x18` | COSTAS_KI | R/W | `0x0008` | `[15:0]` Costas integral gain |
| `0x1C` | TIMING_KP | R/W | `0x0020` | `[15:0]` Timing proportional gain |
| `0x20` | TIMING_KI | R/W | `0x0004` | `[15:0]` Timing integral gain |
| `0x24` | PHASE_ERR | RO | — | `[15:0]` Costas phase error (signed, diagnostic) |
| `0x28` | TIMING_ERR | RO | — | `[15:0]` M&M timing error (signed, diagnostic) |
| `0x2C` | BIT_CNT_LO | RO | `0` | `[31:0]` Decoded bit counter, lower 32 bits |
| `0x30` | BIT_CNT_HI | RO | `0` | `[7:0]` Decoded bit counter, upper 8 bits |
| `0x34` | IP_VERSION | RO | `0x0001_0000` | Version 1.0.0 |

**CTRL field details:**

| Bit | Name | Description |
|-----|------|-------------|
| 0 | ENABLE | 1 = demodulator active; 0 = all loops idle, no output |
| 1 | BYPASS_AGC | 1 = skip AGC (pass I/Q at raw ADC amplitude) |
| 2 | BYPASS_COSTAS | 1 = skip Costas loop (no phase/freq correction) |
| 3 | BYPASS_TIMING | 1 = skip timing recovery (fixed symbol dump at SPS) |

---

## 5. Vivado Project Setup

### Prerequisites
- Vivado 2022.2 (or later)
- Target device: `xc7z020clg484-1` (ZED board)

### Steps

1. Open Vivado and switch to the Tcl console (`Window → Tcl Console`).

2. Navigate to the script directory and run:
   ```tcl
   cd /home/kemal/Desktop/FMCOMM2andos/BPSK_Demodulator/vivado
   source create_project.tcl
   ```

3. Vivado creates the project at `vivado/project/bpsk_demodulator.xpr`.
   The project opens automatically. You can also reopen it via
   `File → Open Project`.

---

## 6. Simulation

Run all 5 test cases in the Vivado simulator:

```tcl
# In Vivado Tcl console (project already open):
set_property top bpsk_demod_tb [get_filesets sim_1]
update_compile_order -fileset sim_1
launch_simulation
run all
```

Expected output:
```
=== TC1: Perfect BPSK (no offset, SPS=8) ===
  PASS – all bytes matched 0x55 after settling
=== TC2: Phase rotation 45° (Costas lock required) ===
  PASS – Costas loop corrected 45 deg phase rotation
=== TC3: Attenuated signal (0.25x amp) – AGC correction ===
  PASS – AGC corrected attenuated signal
=== TC4: Frequency offset – Costas frequency tracking ===
  PASS – Costas loop tracked frequency offset
=== TC5: Combined attenuation + phase rotation ===
  PASS – Combined loops settled
============================================================
  Results: 5 / 5 tests passed
  ALL TESTS PASSED
============================================================
```

### Testbench signals to observe in waveform viewer

| Signal | Description |
|--------|-------------|
| `dut/u_demod_core/i_agc` | AGC-corrected I channel |
| `dut/u_demod_core/i_mix` | Costas-derotated I channel |
| `dut/u_demod_core/phase_err_p` | Costas phase error (should → 0 when locked) |
| `dut/u_demod_core/integrate_acc` | Integrate accumulator |
| `dut/u_demod_core/i_dump` | Soft symbol at dump strobe |
| `dut/m_tdata` | Decoded byte output |
| `dut/m_tvalid` | Byte ready flag |

---

## 7. Synthesis and IP Packaging

```tcl
# 1. Run synthesis (required before packaging)
launch_runs synth_1 -jobs 4
wait_on_run synth_1

# 2. Package IP
source /home/kemal/Desktop/FMCOMM2andos/BPSK_Demodulator/vivado/package_ip.tcl
```

Expected: `IP integrity check PASSED`

The packaged IP is placed at:
```
BPSK_Demodulator/ip_repo/bpsk_demodulator_v1_0/
```

---

## 8. Block Design Integration (ZED)

### Step 1 — Add IP repository

In the FMCOMM2 ZED Vivado project:

1. `Tools → Settings → IP → Repository`
2. Click `+` and add:
   ```
   /home/kemal/Desktop/FMCOMM2andos/BPSK_Demodulator/ip_repo
   ```
3. Click `OK` then `Refresh IP Catalog`.

### Step 2 — Expand the AXI Interconnect

The `axi_cpu_interconnect` currently has 12 master ports (M00–M11).
The demodulator needs a new port M12.

In the block design, double-click `axi_cpu_interconnect` and set:
```
NUM_MI = 13
```

> **Note:** If the BPSK Modulator was also added (at M12), set `NUM_MI = 14`
> and use M13 for the demodulator.

### Step 3 — Add the demodulator IP

1. Right-click in the block design canvas → `Add IP`
2. Search for `BPSK Demodulator v1.0` and double-click to add it.

### Step 4 — Connect clocks and resets

| IP Port | Connect To | Notes |
|---------|-----------|-------|
| `aclk` | `util_ad9361_divclk` | ~245 MHz ADC/DAC data clock |
| `aresetn` | `sys_cpu_resetn` | Active-low system reset |
| `S_AXI_ACLK` | `sys_cpu_clk` | 100 MHz PS AXI bus clock |
| `S_AXI_ARESETN` | `sys_cpu_resetn` | Same reset for AXI domain |

### Step 5 — Connect ADC data tap

The demodulator reads the ADC output bus **without breaking** the existing
`axi_ad9361_adc_dma` connection.

In the block design, create net connections:

| Demodulator Port | Source | Notes |
|-----------------|--------|-------|
| `adc_data[63:0]` | `util_ad9361_adc_pack/packed_fifo_wr_data` | All 4 channels; IP uses `[31:0]` (I0/Q0) |
| `adc_valid` | `util_ad9361_adc_pack/packed_fifo_wr_en` | ADC sample valid |

> Both signals already drive `axi_ad9361_adc_dma` — simply add a second
> fanout connection. The existing DMA connection is **not modified**.

### Step 6 — Connect AXI4-Lite

Connect `S_AXI_*` to the new master port on `axi_cpu_interconnect`:
```
axi_cpu_interconnect/M12_AXI  →  bpsk_demod_v1_0/S_AXI
```

In the **Address Editor** tab, assign:
- **Offset address:** `0x43C0_0000`
- **Range:** `64K`

### Step 7 — Connect bit output (optional)

**Option A — Dedicated DMA (recommended for continuous streaming):**
1. Add a second `axi_dmac` IP instance (copy settings from `axi_ad9361_adc_dma`
   but set `DMA_DATA_WIDTH_DEST = 8`).
2. Connect `M_AXIS_BITS_*` → `axi_dmac/s_axis`.
3. Connect the new DMA to the AXI interconnect (add another master port).
4. Assign a new memory address in the Address Editor.

**Option B — Tie TREADY high (polling / discard):**

If you want to read bits by polling `BIT_CNT_LO` only:
1. Add a Constant IP: value = `1`, width = `1`.
2. Connect its output to `M_AXIS_BITS_TREADY`.
3. Leave `M_AXIS_BITS_TDATA` and `M_AXIS_BITS_TVALID` unconnected (no DMA).

### Step 8 — Validate and generate

1. Click `Validate Design` (F6) — resolve any DRC issues.
2. `Generate Bitstream`.

---

## 9. Software Control (Zynq PS)

### Bare-metal C example

```c
#include <stdint.h>

#define DEMOD_BASE      0x43C00000UL

#define DEMOD_CTRL      (*(volatile uint32_t*)(DEMOD_BASE + 0x00))
#define DEMOD_STATUS    (*(volatile uint32_t*)(DEMOD_BASE + 0x04))
#define DEMOD_SPS       (*(volatile uint32_t*)(DEMOD_BASE + 0x08))
#define DEMOD_AGC_TGT   (*(volatile uint32_t*)(DEMOD_BASE + 0x0C))
#define DEMOD_AGC_CTRL  (*(volatile uint32_t*)(DEMOD_BASE + 0x10))
#define DEMOD_COSTAS_KP (*(volatile uint32_t*)(DEMOD_BASE + 0x14))
#define DEMOD_COSTAS_KI (*(volatile uint32_t*)(DEMOD_BASE + 0x18))
#define DEMOD_TIMING_KP (*(volatile uint32_t*)(DEMOD_BASE + 0x1C))
#define DEMOD_TIMING_KI (*(volatile uint32_t*)(DEMOD_BASE + 0x20))
#define DEMOD_PHASE_ERR (*(volatile uint32_t*)(DEMOD_BASE + 0x24))
#define DEMOD_TIMING_ERR (*(volatile uint32_t*)(DEMOD_BASE + 0x28))
#define DEMOD_BIT_LO    (*(volatile uint32_t*)(DEMOD_BASE + 0x2C))
#define DEMOD_BIT_HI    (*(volatile uint32_t*)(DEMOD_BASE + 0x30))
#define DEMOD_VERSION   (*(volatile uint32_t*)(DEMOD_BASE + 0x34))

/* CTRL bits */
#define CTRL_ENABLE          (1 << 0)
#define CTRL_BYPASS_AGC      (1 << 1)
#define CTRL_BYPASS_COSTAS   (1 << 2)
#define CTRL_BYPASS_TIMING   (1 << 3)

/* STATUS bits */
#define STATUS_READY          (1 << 0)
#define STATUS_ACTIVE         (1 << 1)
#define STATUS_CARRIER_LOCKED (1 << 2)
#define STATUS_AGC_SETTLED    (1 << 3)

/* Configure and start the demodulator */
void bpsk_demod_init(uint8_t sps)
{
    /* Disable first */
    DEMOD_CTRL = 0;

    /* Configure loops */
    DEMOD_SPS       = sps;
    DEMOD_AGC_TGT   = 0x2000;          /* target 0.25 FS */
    DEMOD_AGC_CTRL  = (10 << 16);      /* ki_shift = 10 */
    DEMOD_COSTAS_KP = 0x0040;
    DEMOD_COSTAS_KI = 0x0008;
    DEMOD_TIMING_KP = 0x0020;
    DEMOD_TIMING_KI = 0x0004;

    /* Enable */
    DEMOD_CTRL = CTRL_ENABLE;
}

/* Wait for AGC and carrier lock */
int bpsk_demod_wait_lock(uint32_t timeout_ms)
{
    uint32_t mask = STATUS_CARRIER_LOCKED | STATUS_AGC_SETTLED;
    while (timeout_ms--) {
        if ((DEMOD_STATUS & mask) == mask)
            return 0;   /* locked */
        /* insert 1 ms delay */
    }
    return -1;   /* timeout */
}

/* Read total decoded bit count */
uint64_t bpsk_demod_bit_count(void)
{
    uint32_t lo = DEMOD_BIT_LO;
    uint32_t hi = DEMOD_BIT_HI & 0xFF;
    return ((uint64_t)hi << 32) | lo;
}

/* Read diagnostic values (useful for tuning) */
void bpsk_demod_diagnostics(int16_t *phase_err, int16_t *timing_err,
                             uint16_t *agc_gain)
{
    *phase_err  = (int16_t)(DEMOD_PHASE_ERR  & 0xFFFF);
    *timing_err = (int16_t)(DEMOD_TIMING_ERR & 0xFFFF);
    *agc_gain   = (uint16_t)(DEMOD_AGC_CTRL  & 0xFFFF);
}

/* Example main */
int main(void)
{
    /* Check IP version */
    if (DEMOD_VERSION != 0x00010000) {
        /* version mismatch */
        return -1;
    }

    /* Start with SPS=8 (match transmitter) */
    bpsk_demod_init(8);

    /* Wait up to 1000 ms for lock */
    if (bpsk_demod_wait_lock(1000) != 0) {
        /* failed to lock – check signal, adjust gains */
    }

    /* Demodulated bits now flowing on M_AXIS_BITS / DMA */

    return 0;
}
```

### Linux mmap example

```c
#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stdint.h>

#define MAP_SIZE  0x10000   /* 64 KB */
#define MAP_MASK  (MAP_SIZE - 1)
#define BASE_ADDR 0x43C00000UL

int main(void)
{
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    void *base = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE,
                      MAP_SHARED, fd, BASE_ADDR & ~MAP_MASK);

    volatile uint32_t *regs = (volatile uint32_t *)base;

    /* Read version */
    printf("IP Version: 0x%08X\n", regs[0x34/4]);

    /* Enable demodulator */
    regs[0x00/4] = 0x1;

    /* Poll status */
    printf("Status: 0x%08X\n", regs[0x04/4]);

    /* Read bit count */
    uint64_t cnt = (uint64_t)(regs[0x30/4] & 0xFF) << 32 | regs[0x2C/4];
    printf("Decoded bits: %llu\n", (unsigned long long)cnt);

    munmap(base, MAP_SIZE);
    close(fd);
    return 0;
}
```

---

## 10. Tuning the Loops

### AGC

The AGC uses a first-order IIR integrator. The gain step per sample is:
```
Δgain = (target − |I| − |Q|) / 2^ki_shift
```

| ki_shift | Convergence speed | Risk |
|----------|------------------|------|
| 6–8 | Fast | May overshoot (oscillate) |
| 10 (default) | Medium | Good for most conditions |
| 12–14 | Slow | Stable but takes many symbols |

The `AGC_TARGET` (default `0x2000` = 0.25 FS) should match the expected
receive amplitude. Reduce it if the ADC is saturating.

### Costas Loop

The phase error is `sign(I_mix) * Q_mix`. Stability requires:
```
Kp > 0,  Ki ≥ 0,  Kp >> Ki
```

| Scenario | Adjustment |
|----------|-----------|
| Slow phase convergence | Increase `COSTAS_KP` |
| Frequency drift not tracked | Increase `COSTAS_KI` |
| Loop unstable / jitter | Reduce `COSTAS_KP` |
| Lock takes too long | Set `BYPASS_COSTAS=1` first, check signal levels |

Monitor `PHASE_ERR` register — it should approach 0 when locked.

### Mueller-Müller Timing

The M&M error is `I_prev*sign(I_curr) − I_curr*sign(I_prev)`. This is
zero when the sampling point is at the optimal symbol eye centre.

| Scenario | Adjustment |
|----------|-----------|
| Bit errors but locked carrier | Adjust `TIMING_KP` |
| Timing drifts slowly | Increase `TIMING_KI` |
| Timing oscillates ±1 sample | Reduce `TIMING_KP` |
| Test with fixed timing | Set `BYPASS_TIMING=1` |

Set `SPS` to match the transmitter's `SYM_DIV` value (samples per symbol).

---

## 11. Troubleshooting

### No output on M_AXIS_BITS

1. Verify `CTRL[0] = 1` (ENABLE).
2. Check `STATUS[0] = 1` (READY).
3. Confirm `adc_valid` toggles — read `BIT_CNT_LO` twice with ~100 ms gap;
   if it does not increase, the ADC tap is not connected.
4. Tie `M_AXIS_BITS_TREADY = 1` if there is no downstream DMA.

### All bits are wrong (0xFF or 0x00)

- Check BPSK phase: if all bits are inverted, the signal has a 180° phase
  ambiguity (normal for BPSK). Use differential encoding in the application
  protocol, or check the modulator polarity.
- Try `BYPASS_COSTAS=1` and `BYPASS_TIMING=1` to test the decision logic
  in isolation with a clean signal.

### Costas loop does not lock

1. Verify signal amplitude — check `AGC_GAIN` register:
   - `0x1000` = 1.0 (unity gain, amplitude already at target)
   - Very large (> `0x8000`) → received signal very weak
2. Reduce `COSTAS_KP` by half and retry.
3. Increase `AGC_TARGET` if signal is weaker than expected.
4. Monitor `PHASE_ERR` — if it is large and varying slowly, increase `COSTAS_KI`.

### IP not appearing in IP catalog

1. Confirm packaging completed: `ip_repo/bpsk_demodulator_v1_0/component.xml`
   must exist.
2. In `Settings → IP → Repository`, remove and re-add the path.
3. Click `Refresh IP Catalog`.

### Synthesis error: "top module not found"

If `set_property top` fails in `create_project.tcl`, the compile order was
not refreshed. This is handled by the script (`update_compile_order` runs
before `set_property top`). If it still fails, run manually in Vivado:
```tcl
update_compile_order -fileset sources_1
set_property top bpsk_demod_v1_0 [get_filesets sources_1]
```

### Address conflict / no register response

Verify the address assignment in the Vivado Address Editor:
- BPSK Demodulator: `0x43C0_0000`, range 64 KB
- BPSK Modulator (if present): `0x4380_0000`, range 64 KB
- These must not overlap with other peripherals.
