# RF Loopback with OFDM — Step-by-Step Guide

This guide walks you through everything you need to do to run the full OFDM RF cable loopback test on your ZedBoard + FMCOMMS3 setup. The test transmits a 100-byte 802.11 BPSK 1/2 packet through the real analog RF chain (TX1A → SMA cable → RX1A), decodes it, and reports PER + BER.

---

## What You Need

### Hardware
- ZedBoard (Zynq-7020)
- FMCOMMS3 daughter card plugged into the FMC-LPC connector
- **1 m SMA jumper cable** — this is the cable that physically connects TX1A to RX1A on the FMCOMMS3 board
- USB-to-UART cable (for UART console output from the board)
- JTAG cable (for programming the FPGA and running the ELF)
- PC running Linux or Windows with Vivado 2022.2 + Vitis 2022.2 installed

### Software (already in this repo)
- `v2/boards/zed_fmcs3/` — bitstream sources
- `v2/sw/stage2b4/` — C software including vendored AD9361 no-OS driver
- `build_adi_lib.tcl` — ADI IP packaging script

---

## Overview of What Will Happen

The test runs two phases automatically in sequence:

1. **Phase 1 — BIST loopback (chip-internal digital path):**  
   OFDM samples loop inside the AD9361 chip. Proves the digital path works before touching RF. Runs 100 packets, reports PER + BER.

2. **Phase 2 — RF cable loopback (real analog path):**  
   BIST is disabled. The OFDM signal goes: DAC → mixer → TX1A (SMA output) → your cable → RX1A (SMA input) → mixer → ADC → decoder. Runs 100 packets, reports PER + BER.

You do not write separate code for Stage 4 RF loopback. The `main.c` in `stage2b4/` already contains both phases. The SMA cable must be connected before you start.

---

## Step 1 — Physical Setup

**Before touching software, set up the board:**

1. Mount the FMCOMMS3 card onto the ZedBoard's FMC-LPC connector. Press firmly until the connector is fully seated.

2. Connect the **1 m SMA cable** between **TX1A** and **RX1A** on the FMCOMMS3 board.
   - TX1A is the transmit output port (labeled on the board silkscreen).
   - RX1A is the receive input port (labeled on the board silkscreen).
   - Both are SMA female connectors on the FMCOMMS3.
   - **This cable must be in place before the RF loopback phase runs.** If it is not connected, Phase 2 will fail but Phase 1 (BIST) will still pass.

3. Connect the USB-UART cable to the ZedBoard's PS UART port (the micro-USB labeled "UART" near the USB hub chip, not the OTG port).

4. Connect the JTAG cable (Xilinx Platform Cable USB or Digilent JTAG-HS) to the JTAG header.

5. Set the ZedBoard boot-mode jumpers to **JTAG boot** (all jumpers to GND / position 0):
   - MIO4 = 0, MIO5 = 0 (JTAG mode).

6. Power on the ZedBoard. Do not run any software yet.

---

## Step 2 — One-Time ADI IP Setup (Skip if Already Done)

This step packages the `axi_ad9361` Vivado IP from the Analog Devices HDL library. You only do this once per machine.

### 2a. Clone the ADI HDL library

Clone it as a sibling directory to this repo (i.e., next to `open_ofdm_phy-hw-clean-ofdm-rebuild/`):

```bash
cd /home/kemal/Desktop/OFDMPROJECTCURRENT
git clone https://github.com/analogdevicesinc/hdl.git adi-hdl
```

Your directory layout must look like this after cloning:

```
OFDMPROJECTCURRENT/
├── open_ofdm_phy-hw-clean-ofdm-rebuild/   ← this project
└── adi-hdl/                               ← ADI library (just cloned)
```

### 2b. Package the IP

```bash
cd /home/kemal/Desktop/OFDMPROJECTCURRENT/open_ofdm_phy-hw-clean-ofdm-rebuild
vivado -mode batch -source build_adi_lib.tcl
```

This takes about 2–3 minutes. It only needs to run once. It produces a packaged `axi_ad9361` IP that Vivado can find during the bitstream build.

**If you already did this in a previous session, skip to Step 3.**

---

## Step 3 — Build the FPGA Bitstream

```bash
cd /home/kemal/Desktop/OFDMPROJECTCURRENT/open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3
vivado -mode batch -source build.tcl
```

This runs synthesis, implementation, and bitstream generation. It takes **30–45 minutes**.

When it finishes, two output files are produced:

```
v2/boards/zed_fmcs3/stage2b4/stage2b4.runs/impl_1/system_top.bit   ← FPGA bitstream
v2/boards/zed_fmcs3/stage2b4/stage2b4.xsa                           ← hardware description for Vitis
```

If `build.tcl` fails, the most common causes are:
- `adi-hdl/` is not in the right place (must be a sibling of the project root)
- `build_adi_lib.tcl` was never run (Step 2 was skipped)
- Vivado version mismatch (must be 2022.2)

---

## Step 4 — Build the Bare-Metal Software in Vitis

### 4a. Open Vitis and create a platform

1. Open Vitis 2022.2.
2. Select **File → New → Platform Project**.
3. Name it (e.g., `stage2b4_platform`).
4. Under **Hardware Specification**, click **Browse** and select the `.xsa` file:
   ```
   v2/boards/zed_fmcs3/stage2b4/stage2b4.xsa
   ```
5. Operating system: `standalone`, Processor: `ps7_cortexa9_0`.
6. Click **Finish**. Vitis generates the BSP. Build the platform: right-click the platform project → **Build Project**.

### 4b. Create the application project

1. **File → New → Application Project**.
2. Select the platform you just created.
3. Name the application (e.g., `stage2b4_app`).
4. Template: **Empty Application (C)**. Click **Finish**.

### 4c. Add the source files

In the Vitis Explorer panel, under `stage2b4_app/src/`:

1. Delete the auto-generated `helloworld.c` if it exists.
2. Copy (or import) these files into `src/`:
   - `v2/sw/stage2b4/main.c`
   - `v2/sw/stage2b4/parameters.h`
   - `v2/sw/stage2b4/app_config.h`
3. Copy the entire `v2/sw/stage2b4/noos/` folder into `src/noos/`.
   - In Vitis: right-click `src/` → **Import Sources** → select the `noos/` directory.

### 4d. Add the noos include path

1. Right-click the `stage2b4_app` project → **Properties**.
2. Go to **C/C++ Build → Settings → ARM v7 gcc compiler → Directories**.
3. Add:
   ```
   ${workspace_loc}/stage2b4_app/src/noos
   ```
4. Click **Apply and Close**.

### 4e. Build

Right-click `stage2b4_app` → **Build Project**.

The build should complete with no errors. It produces:
```
stage2b4_app/Debug/stage2b4_app.elf
```

---

## Step 5 — Open a UART Console

Open a serial terminal on your PC before programming the board so you can see output from the start.

- **Port:** the COM port / `/dev/ttyUSB*` that corresponds to the ZedBoard PS UART
- **Baud rate:** 115200
- **Data bits:** 8, **Parity:** None, **Stop bits:** 1 (115200 8N1)

Recommended tools: PuTTY (Windows), minicom or screen (Linux).

```bash
# Linux example:
screen /dev/ttyUSB0 115200
```

---

## Step 6 — Program the FPGA and Run

### 6a. Connect Vivado Hardware Manager to the board

In Vivado (or Vitis System Debugger), open the Hardware Manager:

1. **Flow → Open Hardware Manager → Open Target → Auto Connect**.
2. Vivado finds the Zynq-7020.

### 6b. Program the bitstream

In Hardware Manager:

1. Right-click the device → **Program Device**.
2. Browse to the bitstream:
   ```
   v2/boards/zed_fmcs3/stage2b4/stage2b4.runs/impl_1/system_top.bit
   ```
3. Click **Program**. Takes ~10 seconds.

### 6c. Run the ELF (from Vitis debugger or Vitis System Debugger)

Option A — Vitis Run:
1. Right-click `stage2b4_app` → **Run As → Launch on Hardware (Single Application Debug)**.
2. The app starts and immediately prints to UART.

Option B — Vitis System Debugger (XSCT):
```tcl
connect
targets -set -filter {name =~ "ARM*#0"}
dow path/to/stage2b4_app.elf
run
```

Option C — standalone bare-metal run (no debugger):
1. Create a `BOOT.bin` from the bitstream + ELF using the Vitis Boot Image wizard.
2. Copy to SD card, set boot mode jumpers to SD, power cycle.

---

## Step 7 — Watch the UART Output

The program runs automatically and prints everything to UART. Total runtime is about 10 seconds.

### What you will see:

#### Startup and AD9361 init
```
=============================================
  Stage 2B-4 -- OFDM through axi_ad9361 (BIST mode 1)
=============================================
[ad9361] init...
[ad9361] init OK
[ad9361] requesting 40 MSPS chain (was 30.72)...
       actual RX = 40000000 Hz, TX = 40000000 Hz
```

#### Bitstream verification probe
```
[probe] verifying new bitstream via gpio_o[41]=1
       last_adc_i0=0xFCAF (expect 0xFCAF+/-16 if NEW bitstream)
       last_adc_q0=0xFBAB (expect 0xFBAB+/-16)
       OK -- new bitstream confirmed.
```
> If this step prints `*** STALE BITSTREAM ***`, you need to rebuild the bitstream (Step 3) and reflash.

#### Phase 1 — BIST loopback sweep and pass
```
[ad9361] enabling BIST mode 1 (chip data-port loopback)...
[ad9361] forcing chip into FDD...
       0x017 STATE = 0x1A  (ENSM bits[3:0] = 0xA -- want 0xA=FDD)

*** sweep pol=0 sel=0 (skip 0) ***
...
*** sweep pol=0 sel=N (skip N) ***
       *** GOOD pol=0 sel=N *** rate=0x0B len=100

  *** PASS *** OFDM round-tripped through axi_ad9361.
              polarity=0 skip_target=N (N adc_valids skipped).

[BER BIST] Data BER: byte_err=0/96  bit_err=0/768  BER=0.000%

[BIST multi-packet] sending 100 packets...
[BIST multi-packet] results over 100 packets:
       Packets decoded OK: 100
       Packets failed:     0
       PER (packet err rate): 0.0%
       Aggregate data BER: 0.0000% (= 0 ppm)
```

#### Phase 2 — RF cable loopback sweep and pass
```
========================================
  Stage 4 -- RF cable loopback
  (connect SMA cable: TX1A -> RX1A on FMCOMMS3)
========================================
[ad9361] disabling BIST loopback...
[ad9361] tuning gains for RF cable...
       0x017 STATE = 0x1A (ENSM bits[3:0] = 0xA)

*** RF sweep pol=0 sel=0 ***
...
*** RF sweep pol=0 sel=N ***
       *** RF GOOD pol=0 sel=N *** rate=0x0B len=100

  *** STAGE 4 PASS *** RF cable loopback decoded.
              polarity=0 skip_target=N

[BER RF] Data BER: byte_err=0/96  bit_err=0/768  BER=0.000%

[RF multi-packet] sending 100 packets...
[RF multi-packet] results over 100 packets:
       Packets decoded OK: 100
       Packets failed:     0
       PER (packet err rate): 0.0%
       Aggregate data BER: 0.0000% (= 0 ppm)

  Hardware OFDM TX/RX loopback complete.
```

After this the board sits idle, printing `.` every 5 seconds. The test is done.

---

## RF Gain Settings (What the Code Uses)

These are already set in `main.c` — you do not need to change anything:

| Phase | TX Attenuation | RX RF Gain |
|-------|---------------|------------|
| BIST (Phase 1) | 30 dB | 10 dB |
| RF cable (Phase 2) | 10 dB | 30 dB |

The RF cable phase uses lower TX attenuation and higher RX gain to compensate for cable path loss. BPSK 1/2 decodes cleanly above ~5 dB SNR.

---

## Troubleshooting

### `*** STALE BITSTREAM ***`
The FPGA has an old bitstream. Rebuild (Step 3) and reflash (Step 6b).

### `*** FAIL *** ad9361_init returned <N>`
AD9361 SPI communication failed. Check:
- FMCOMMS3 is fully seated on the FMC-LPC connector
- Board is powered before the ELF starts (not just the FPGA programmed)
- SPI0 EMIO signals are correctly constrained in `system_constr.xdc`

### BIST phase passes but RF phase fails: `*** STAGE 4 FAIL ***`
Causes in order of likelihood:
1. **SMA cable not connected** — most common. Verify TX1A → RX1A cable is in place.
2. **Wrong connectors** — make sure you used TX1A and RX1A (not TX2A / RX2A).
3. **TX attenuation too high** — try lowering to 0 dB. Edit this line in `main.c`:
   ```c
   ad9361_set_tx_attenuation(phy, 0, 10000);  // 10 dB → try 0
   ```
4. **RX gain too low** — try raising to maximum (76 dB):
   ```c
   ad9361_set_rx_rf_gain(phy, 0, 76);
   ```
5. **ENSM state not FDD** — check that UART shows `ENSM bits[3:0] = 0xA`. If not, the chip is not in transmit mode.

### `hdr_valid bumped but fcs/rate/len off` (during sweep)
The decoder is seeing signal but not decoding cleanly. This means timing is partially right but something else is wrong (rate mismatch, IQ swap, gain). The sweep will continue through all 16 polarity+skip combinations automatically before giving up.

### No decoder activity at all (BIST or RF)
```
  *** FAIL *** No decoder activity. dot11 saw nothing.
```
Check:
- `gpio_o[41]` must be 0 (OFDM mode) — this is the default in the code
- AD9361 ENSM state must be FDD (0xA) before TX is triggered
- The bitstream must be the new 2B-4 build (probe step must pass)

### UART shows nothing
- Wrong COM port selected
- Wrong baud rate — must be 115200
- JTAG boot mode not set — if the board boots from SD it may run a different ELF

---

## What the Code Does Internally (For Reference)

**Phase 1 (BIST):**
1. Inits AD9361 via no-OS driver (`ad9361_init`)
2. Sets chain rate to 40 MSPS (`ad9361_set_rx/tx_sampling_freq`)
3. Sets TX attenuation 30 dB, RX gain 10 dB
4. Enables BIST mode 1 (`ad9361_bist_loopback(phy, 1)`)
5. Forces AD9361 into FDD mode (`ad9361_ensm_force_state`)
6. Sweeps 16 combinations of polarity (0/1) × skip_target (0–7)
7. For each combination: pulses `gpio_o[32]` (phy_tx_start) to trigger TX, waits 100 ms, reads decoder counters via `gpio_i`
8. Finds the combination where `fcs_ok_count` increments with `rate=0x0B` and `len=100`
9. Runs 100-packet stress test, computes PER + BER

**Phase 2 (RF cable):**
1. Disables BIST (`ad9361_bist_loopback(phy, 0)`)
2. Sets TX attenuation 10 dB, RX gain 30 dB
3. Re-forces FDD mode
4. Repeats the same polarity × skip_target sweep against the RF path
5. Runs 100-packet stress test, computes PER + BER

The polarity and skip_target sweep is needed because the relative phase of `l_clk` (40 MSPS, from AD9361) vs `bb_clk` (20 MSPS, from FPGA) is unknown at power-up. The HDL rate adapter has 8 possible phase alignments and 2 polarity options. The sweep finds the one where the OFDM decoder locks.

---

## Pass Criteria

| Check | Expected Value |
|-------|---------------|
| `fcs_ok_count` increments | Yes (at least once per 16-combination sweep) |
| `last_pkt_rate` | `0x0B` (BPSK 1/2 = 6 Mbps) |
| `last_pkt_len` | `100` bytes |
| PER over 100 packets | 0% |
| Data BER over 76,800 bits | 0 ppm |

---

## Files You Should Not Modify for This Test

| File | Why |
|------|-----|
| `v2/sw/stage2b4/main.c` | Already runs both BIST and RF loopback phases |
| `v2/sw/stage2b4/parameters.h` | Correct GPIO/SPI/AXI addresses for v2 BD |
| `v2/boards/zed_fmcs3/system_top.v` | Async FIFO bridge, rate adapter, GPIO mux already correct |
| `v2/boards/zed_fmcs3/system_bd.tcl` | Zynq/AD9361 block design already correct |

The only reason to edit any of these is if you want to change test parameters (packet size, number of packets, gain values) — see the "Tweaking the test" section in the project README.
