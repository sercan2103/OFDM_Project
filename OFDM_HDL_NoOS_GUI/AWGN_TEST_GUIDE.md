# AWGN Channel Test — Step-by-Step Guide

This guide explains how to build, program, and run the AWGN (Additive White Gaussian Noise)
channel test on your ZedBoard OFDM project. The test measures BER (Bit Error Rate) and PER
(Packet Error Rate) across a range of SNR values from approximately 0 dB to 62 dB.

---

## What Was Added

Three files were changed and one was created:

| File | Change |
|------|--------|
| `v2/boards/zed_fmcs3/awgn_noise_gen.v` | **New.** 8-LFSR Gaussian noise generator |
| `v2/boards/zed_fmcs3/system_top.v` | Instantiates noise gen, injects noise before `dot11`, adds GPIO control |
| `v2/boards/zed_fmcs3/build.tcl` | Adds `awgn_noise_gen.v` to the source file list |
| `v2/sw/stage2b4/main.c` | GPIO pin defines, init, `awgn_set_enable()`, `awgn_set_shift()`, `run_ber_vs_snr()` |

### How it works

```
rx_cdc FIFO  →  [staged_sample]  →  + noise  →  sample_in  →  dot11 decoder
                                      ↑
                              awgn_noise_gen
                          (8 LFSRs, bb_clk domain)
                          scaled by noise_shift GPIO
```

Noise is injected after the ADC receive path but before the OFDM decoder. It does **not**
affect the RF hardware — the BIST and RF cable paths remain unchanged.

### GPIO control bits (new)

| gpio_o bit | PS pin | Name | Function |
|------------|--------|------|---------|
| 59 | 113 | `awgn_enable` | 0 = bypass (default), 1 = inject noise |
| 60 | 114 | `noise_shift[0]` | LSB of 4-bit shift |
| 61 | 115 | `noise_shift[1]` | |
| 62 | 116 | `noise_shift[2]` | |
| 63 | 117 | `noise_shift[3]` | MSB of 4-bit shift |

### SNR vs noise_shift table

| noise_shift | Approx. SNR | Expected behaviour |
|:-----------:|:-----------:|-------------------|
| 0 | -10 dB | Complete noise — decoder never syncs |
| 1 | -4 dB | Almost all packets fail |
| **2** | **+2 dB** | **≈ 0 dB region — sweep starts here** |
| 3 | +8 dB | Near BPSK 1/2 threshold, mix of pass/fail |
| 4 | +14 dB | Reliable decode, measurable BER |
| 5 | +20 dB | Low BER |
| 6 | +26 dB | Very low BER |
| 7 | +32 dB | |
| 8 | +38 dB | |
| 10 | +50 dB | Near floor |
| **12** | **+62 dB** | **Sweep ends here — effectively noiseless** |
| 15 | +80 dB | Zero noise (same as bypass) |

Each +1 step ≈ +6 dB SNR improvement.

---

## Prerequisites

Before running the AWGN test, the following must already be working:

1. ZedBoard boots and UART prints correctly (Stage 0 passed)
2. FPGA bitstream was built and programmed (bitstream from `build.tcl`)
3. AD9361 initialises successfully (`[ad9361] init OK` in UART)
4. BIST loopback passes (`*** PASS ***` in UART)
5. RF cable is connected TX1A → RX1A (for the RF loopback phase)

The AWGN test runs **automatically after** the BIST and RF loopback milestones. You do not
trigger it separately — it is part of the same program run.

---

## Step 1 — Rebuild the FPGA Bitstream

The HDL was changed (`system_top.v` + new `awgn_noise_gen.v`), so the bitstream must be rebuilt.

```bash
export ADI_IGNORE_VERSION_CHECK=1    # only needed if you see a version error

cd /home/kemal/Desktop/OFDMPROJECTCURRENT/open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3
vivado -mode batch -source build.tcl
```

Expected output at the end:
```
==== Stage 1C build complete ====
Bitstream: stage1c/stage1c.runs/impl_1/system_top.bit
XSA:       stage1c/stage1c.xsa
```

Runtime: 30–45 minutes. Do not interrupt.

---

## Step 2 — Rebuild the Software in Vitis

The C code changed (`main.c` has new GPIO pins and new functions). You must rebuild the ELF.

### If you already have the Vitis project open:

1. In Vitis, right-click `stage2b4_app` → **Clean Project**
2. Right-click `stage2b4_app` → **Build Project**

The existing platform and `.xsa` do **not** need to be updated because no AXI peripherals,
memory maps, or PS settings changed — only PL logic changed.

### If you need to create the Vitis project from scratch:

1. Open Vitis 2022.2
2. **File → New → Platform Project** → name it `stage2b4_platform`
3. Hardware: browse to `stage1c/stage1c.xsa`
4. OS: `standalone`, Processor: `ps7_cortexa9_0` → Finish
5. Build the platform (right-click → Build Project)
6. **File → New → Application Project** → select the platform → name it `stage2b4_app`
7. Template: **Empty Application (C)** → Finish
8. In `stage2b4_app/src/`, import:
   - `v2/sw/stage2b4/main.c`
   - `v2/sw/stage2b4/parameters.h`
   - `v2/sw/stage2b4/app_config.h`
   - Entire folder `v2/sw/stage2b4/noos/` → import as `src/noos/`
9. Add include paths (Project Properties → C/C++ Build → Settings → Directories):
   ```
   ${workspace_loc}/stage2b4_app/src
   ${workspace_loc}/stage2b4_app/src/noos
   ```
10. Build

---

## Step 3 — Physical Setup

Before programming the board:

1. FMCOMMS3 card is seated on the FMC-LPC connector
2. **SMA cable connected: TX1A → RX1A** on FMCOMMS3 (required for RF phase)
3. USB-UART cable connected to ZedBoard PS UART (115200 8N1)
4. JTAG cable connected
5. Boot jumpers set to JTAG mode (MIO4=0, MIO5=0)
6. Power on the board

---

## Step 4 — Program FPGA and Run

### 4a. Open UART console

Open a serial terminal at 115200 8N1 before programming so you see all output:

```bash
# Linux
screen /dev/ttyUSB0 115200

# Or use minicom / PuTTY (Windows)
```

### 4b. Program the bitstream

In Vivado Hardware Manager:

1. **Flow → Open Hardware Manager → Open Target → Auto Connect**
2. Right-click device → **Program Device**
3. Bitstream: `v2/boards/zed_fmcs3/stage1c/stage1c.runs/impl_1/system_top.bit`
4. Click **Program**

### 4c. Run the ELF

In Vitis (or XSCT):

```tcl
connect
targets -set -filter {name =~ "ARM*#0"}
dow path/to/stage2b4_app/Debug/stage2b4_app.elf
run
```

Or right-click `stage2b4_app` → **Run As → Launch on Hardware**.

---

## Step 5 — Read the Output

The program runs three phases automatically in sequence. Watch the UART.

### Phase 1 — AD9361 init and BIST loopback

```
=============================================
  Stage 2B-4 -- OFDM through axi_ad9361 (BIST mode 1)
=============================================
[ad9361] init OK
[ad9361] requesting 40 MSPS chain...
       actual RX = 40000000 Hz, TX = 40000000 Hz
[probe] verifying new bitstream via gpio_o[41]=1
       last_adc_i0=0xFCAF  OK -- new bitstream confirmed.
...
  *** PASS *** OFDM round-tripped through axi_ad9361.
[BIST multi-packet] Aggregate data BER: 0.0000% (= 0 ppm)
```

> If the bitstream probe prints `*** STALE BITSTREAM ***`, the old bitstream is still loaded.
> Re-run Step 1 and Step 4b.

### Phase 2 — BIST BER vs SNR sweep

```
=====================================================
  BER vs SNR sweep (BIST)
  SNR range: +2 dB to +62 dB  (shift 2..12)
  Packets per point: 1000
  Estimated runtime: ~275 s
=====================================================
  shift | est.SNR |  OK pkts | Failed pkts |  PER   |  BER (ppm)
  ------|---------|----------|-------------|--------|------------
      2 |  +2 dB |       ~0 |        ~1000| 100.0% | 1000000
      3 |  +8 dB |      ~50 |        ~950 |  95.0% | ...
      4 | +14 dB |     ~900 |         ~100|  10.0% | ...
      5 | +20 dB |    ~1000 |           0 |   0.0% | ...
      6 | +26 dB |    ~1000 |           0 |   0.0% | 0
      ...
     12 | +62 dB |    ~1000 |           0 |   0.0% | 0
  AWGN disabled (bypass restored).
```

The waterfall transition (from 100% PER to 0% PER) should appear somewhere between
shift=3 (+8 dB) and shift=5 (+20 dB) for BPSK 1/2 modulation. This matches the
theoretical BPSK 1/2 threshold of approximately 1.5–3 dB Eb/N0.

### Phase 3 — RF cable loopback + RF BER vs SNR sweep

```
========================================
  Stage 4 -- RF cable loopback
========================================
...
  *** STAGE 4 PASS *** RF cable loopback decoded.

=====================================================
  BER vs SNR sweep (RF)
  ...
```

Same table as BIST, but running through the real analog RF chain.
At high shift (low injected noise), the BER floor reflects RF impairments
(phase noise, IQ imbalance, etc.) rather than the AWGN generator.

---

## Understanding the Results

### BER (Bit Error Rate) column

- Reported in ppm (parts per million): 1000 ppm = 0.1%, 1 ppm = 10^-6
- Only counted for packets that passed FCS (successfully decoded)
- If no packets decoded at a given SNR point, BER = 1,000,000 ppm (100%)
- At high SNR (shift ≥ 8), expect 0 ppm (no bit errors in 96 × 1000 = 96,000 data bits)

### PER (Packet Error Rate) column

- Percentage of the 1000 transmitted packets that failed to decode
- Includes both "no sync" failures and "sync but bad FCS" failures
- At shift=2 (+2 dB): expect PER ≈ 100% (below BPSK threshold)
- At shift=4 (+14 dB): expect PER < 10%
- At shift=6 (+26 dB): expect PER ≈ 0%

### Typical waterfall shape

```
  SNR (dB) |  PER (%)
  --------- | --------
      2     |  100.0%    ← all packets fail (below threshold)
      8     |   ~90%     ← near threshold, mostly failing
     14     |   ~10%     ← transition region
     20     |    ~0%     ← reliable decode
     26     |     0%     ← zero packet errors
```

---

## Adjusting the Test

All adjustments are in `v2/sw/stage2b4/main.c`. Only the software needs to be rebuilt
(no bitstream rebuild required) for any of these changes.

### Change number of packets per SNR point

Find both `run_ber_vs_snr` calls and change the last argument:

```c
// Current: 1000 packets per point
run_ber_vs_snr("BIST", 2, 12, 1000);

// Faster run (less accurate BER at low error rates):
run_ber_vs_snr("BIST", 2, 12, 100);

// Higher accuracy (takes longer):
run_ber_vs_snr("BIST", 2, 12, 5000);
```

Timing: each packet takes ~25 ms. `n_packets=1000` per point = 25 s per shift step.

### Change SNR range

The second and third arguments are `shift_start` and `shift_end`:

```c
// Tighter range around the waterfall (faster):
run_ber_vs_snr("BIST", 2, 8, 1000);   // 2 dB to 38 dB

// Wider range (slower, also shows below-threshold behaviour):
run_ber_vs_snr("BIST", 1, 12, 1000);  // -4 dB to 62 dB
```

### Disable the BER sweep (run loopback only)

Comment out the `run_ber_vs_snr` calls:

```c
// run_ber_vs_snr("BIST", 2, 12, 1000);   // commented out = no sweep
```

### Inject noise manually for a fixed SNR point

You can call the helpers directly from `main()` before any `trigger_tx()`:

```c
awgn_set_shift(4);    // +14 dB SNR
awgn_set_enable(1);   // enable noise injection
trigger_tx();
usleep(50000);
// ... read status ...
awgn_set_enable(0);   // disable noise when done
```

### Add more SNR points (finer resolution)

The current step is 6 dB per shift bit. To measure at intermediate SNR values, you would
need to change the noise scaling in `awgn_noise_gen.v` (for example, using a multiplier
instead of a pure right-shift). This requires a bitstream rebuild.

---

## Files Reference

| File | Purpose |
|------|---------|
| `v2/boards/zed_fmcs3/awgn_noise_gen.v` | 8-LFSR Gaussian RNG. LFSRs advance every `bb_clk`. Combinatorial output. |
| `v2/boards/zed_fmcs3/system_top.v` | Instantiates noise gen, adds scaled noise to `sample_in` at `clk_count==9`. |
| `v2/boards/zed_fmcs3/build.tcl` | Vivado build script (includes `awgn_noise_gen.v`). |
| `v2/sw/stage2b4/main.c` | `awgn_set_enable()`, `awgn_set_shift()`, `run_ber_vs_snr()`. |

---

## Troubleshooting

### `*** STALE BITSTREAM ***` at startup

The FPGA has the old bitstream (before the AWGN changes). Rebuild and reflash (Steps 1 + 4b).

### BER sweep shows 100% PER for all shift values

The BIST/RF loopback is not working. The AWGN sweep only runs after a successful decode is
established. Check that the BIST PASS line appeared before the sweep.

### BER floor is non-zero at high SNR (shift=10, 11, 12)

At shift=12 (+62 dB) a few bit errors may remain on the RF cable path due to real RF
impairments (phase noise, DC offset, IQ imbalance). This is expected and physically
meaningful — it shows the noise floor of your RF chain.

On the BIST path (chip digital loopback), expect exactly 0 ppm at shift ≥ 8.

### Sweep takes longer than expected

With 1000 packets × 25 ms = 25 s per shift × 11 points = 275 s ≈ 4.5 minutes. If this
is too long, reduce to 100 or 200 packets per point — this gives BER resolution down to
~100 ppm instead of ~10 ppm.

### UART output is garbled

Make sure your terminal is set to exactly 115200 baud, 8 data bits, no parity, 1 stop bit.
The program does not use hardware flow control (RTS/CTS).
