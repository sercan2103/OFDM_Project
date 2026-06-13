# OFDM Project — Full Analysis

## What Is This Project?

This is a **hardware implementation of an 802.11 OFDM physical layer (PHY)** running on a **Xilinx ZedBoard FPGA** paired with an **Analog Devices AD9361 RF transceiver** (FMCOMMS3 daughter card). It transmits and receives real wireless 802.11 OFDM packets — using BPSK 1/2 rate modulation (6 Mbps) — and has been verified with 0% packet error rate over both internal chip loopback and a real RF cable connection between the transmit and receive antennas.

**In plain terms:** the FPGA generates an 802.11 WiFi-style packet in hardware, sends it through a real RF chip, receives it back, decodes it, and checks the CRC — all on bare metal with no operating system.

---

## Repository Name

```
open_ofdm_phy-hw-clean-ofdm-rebuild   (branch: hw/clean-ofdm-rebuild)
```

The `v2/` folder is the only active, working version. Earlier attempts are not tracked here.

---

## Top-Level Folder Map

```
OFDMPROJECTCURRENT/
└── open_ofdm_phy-hw-clean-ofdm-rebuild/
    ├── build_adi_lib.tcl          ← Packages the Analog Devices axi_ad9361 IP for Vivado (run once)
    ├── README.md                  ← Original project overview
    └── v2/                        ← The entire working implementation lives here
        ├── README.md              ← Staged development roadmap with pass/fail criteria
        ├── boards/                ← FPGA hardware design (bitstream sources)
        ├── ip/                    ← OFDM IP cores (TX, RX, shared utilities, Xilinx IP)
        ├── sim/                   ← Simulation testbenches (placeholder; TB work on other branches)
        └── sw/                    ← Bare-metal C software for each development stage
```

---

## Directory Deep-Dive

### `v2/boards/zed_fmcs3/` — FPGA Hardware Design

This folder contains everything needed to build the FPGA bitstream in Vivado.

| File | Purpose |
|------|---------|
| `build.tcl` | Master Vivado script — runs synthesis, implementation, ILA insertion, and outputs `.bit` + `.xsa` |
| `system_bd.tcl` | Block Design script — wires up Zynq PS7, AXI smartconnect, axi_ad9361, clocking, GPIO |
| `system_top.v` | Top-level Verilog — instantiates openofdm_tx, openofdm_rx, async FIFOs, rate adapters, GPIO mux |
| `system_constr.xdc` | Pin constraints — maps LVDS lines to FMCOMMS3 connector, EMIO GPIO pins |
| `tx_packet_rom.v` | 100-byte test PSDU hardcoded in BRAM (payload: 0x01–0x18 pattern) |
| `iq_sample_fifo.v` | Legacy synchronous FIFO — kept for reference, not used in v2 active path |

**How the block design is structured:**
- **Zynq PS7** — dual ARM Cortex-A9; runs the C software; accesses AXI peripherals via `M_AXI_GP0`
- **axi_ad9361** — Analog Devices LVDS I/O controller; drives the physical AD9361 chip; generates `l_clk` (AD9361 data clock, ~40 MSPS)
- **proc_sys_reset** — synchronous reset generators for each clock domain
- **AXI Smartconnect** — routes one PS master to two slaves (GPIO + axi_ad9361)

---

### `v2/ip/` — OFDM IP Cores

#### `v2/ip/common/` — Shared Headers
Verilog include files used across TX and RX cores: git revision macros, shared parameters, common definitions.

#### `v2/ip/openofdm_tx/` — Transmitter Core (27 Verilog files + `.mem` LUTs)

This is the 802.11 OFDM **transmitter**. Given a byte payload in BRAM, it outputs a stream of I/Q samples.

| Module | What it does |
|--------|-------------|
| `openofdm_tx.v` | Top-level — reads payload from BRAM, orchestrates the TX pipeline |
| `dot11_tx.v` | 802.11 framer — appends preamble, builds L-SIG header, scrambles payload |
| `convenc.v` | Convolutional encoder — rate 1/2, constraint length K=7 |
| `modulation.v` | Constellation mapper — BPSK / QPSK / 16-QAM / 64-QAM |
| `ifftmain.v` + `ifftstage.v` + `butterfly.v` | 64-point IFFT pipeline — converts frequency-domain subcarriers to time-domain I/Q samples |
| `l_stf_rom.v`, `l_ltf_rom.v` | Legacy STF/LTF training sequences (preamble patterns) |
| `crc32_tx.v` | Computes FCS (CRC-32) over the payload |
| `dpram.v`, `ram_simo.v` | Dual-port BRAM primitives |
| `*.mem` files | Lookup tables for rotations, twiddle factors |

#### `v2/ip/openofdm_rx/` — Receiver / Decoder Core (17 Verilog files)

This is the 802.11 OFDM **receiver**. Given a stream of I/Q samples, it outputs decoded bytes and a pass/fail CRC flag.

| Module | What it does |
|--------|-------------|
| `openofdm_rx.v` | Top-level — clocks in I/Q samples, orchestrates the RX pipeline |
| `dot11.v` | Main 802.11 decode state machine — runs the full RX sequence |
| `sync_short.v` | Short preamble detector — coarse timing synchronization |
| `sync_long.v` | Long preamble detector — fine timing + phase locking |
| `equalizer.v` | Per-subcarrier channel equalizer — corrects for RF path distortion |
| `demodulate.v` | Constellation demapper — converts I/Q back to bits |
| `deinterleave.v` | Reverses the interleaving done at TX |
| `dec_viterbi.v` | Viterbi convolutional decoder — recovers bits through the rate-1/2 code |
| `descramble.v` | Removes PN scrambling sequence |
| `crc32.v` | FCS checker — verifies CRC-32 at end of packet |
| `phase.v` | Residual carrier phase tracking |
| `signal_watchdog.v` | Detects packet boundaries via power threshold |
| `phy_len_calculation.v` | Extracts payload length from L-SIG header |
| `complex_to_mag.v`, `complex_mult.v`, `rotate.v` | Math primitives |
| `usrp2/` | RAM primitive wrappers (ported from USRP2 reference design) |

#### `v2/ip/xilinx_ip/` — Pre-built Xilinx IP Cores (`.xci` files)

These are Xilinx-generated IP cores locked to Vivado 2022.2. They are called by the openofdm RX core.

| Core | Purpose |
|------|---------|
| `xfft_v9/` | 64-point FFT — converts received time-domain samples to frequency domain |
| `viterbi_v7_0/` | Hardware Viterbi decoder — accelerates convolutional decoding |
| `complex_multiplier/` | Pipelined complex multiplier for equalization math |
| `atan_lut/` | Arctangent lookup table for phase computation |
| `rot_lut/` | Phase rotation lookup table |
| `deinter_lut/` | Deinterleaver address lookup table |
| `div_gen_*/` | Fixed-point dividers (multiple configurations) |

---

### `v2/sw/` — Bare-Metal C Software (Per Stage)

The software is split into **stages** — each stage proves one more subsystem works before moving on. This is a disciplined "breadboard" methodology: never assume something works until you have a dedicated test that proves it.

#### Stage 0 — `sw/stage0/`
**Purpose:** Bringup sanity check.  
**Proves:** UART prints, LED blinks, board is alive.  
**Key file:** `main.c` — hello-world + LED toggle.

#### Stage 1B — `sw/stage1b/`
**Purpose:** HDL-only loopback (no RF chip).  
**Proves:** openofdm_tx → FIFO → dot11 decodes correctly at HDL level.  
**Key file:** `main.c` — pulses TX trigger GPIO, reads FCS status counter.  
**Pass criterion:** `fcs_ok_count >= 1`

#### Stage 2 — `sw/stage2/`
**Purpose:** AD9361 SPI communication bringup.  
**Proves:** SPI bus is alive; chip product ID reads `0x0A`.  
**Key file:** `main.c` — raw SPI register read.

#### Stage 2A.5 — `sw/stage2a5/`
**Purpose:** AXI fabric infrastructure test.  
**Proves:** PS can write/read AXI GPIO peripheral correctly.  
**Key file:** `main.c` — write-read pattern test on axi_gpio.

#### Stage 2B-1 — `sw/stage2b1/`
**Purpose:** axi_ad9361 IP bringup.  
**Proves:** Analog Devices AXI register map is accessible; `PCORE_VERSION` register reads non-zero.  
**Key file:** `main.c` — AXI register readback.

#### Stage 2B-2 — `sw/stage2b2/`
**Purpose:** AD9361 full initialization via no-OS driver.  
**Proves:** AD9361 driver runs to completion, baseband PLL locks, `l_clk` is running.  
**Key file:** `main.c` — calls `ad9361_init()` with full parameter struct.  
**Dependency:** `noos/` — vendored Analog Devices no-OS driver (61 C files; SPI, calibration, PLL sequencing).

#### Stage 2B-3 — `sw/stage2b3/`
**Purpose:** BIST (Built-In Self-Test) loopback with a constant pattern.  
**Proves:** DAC → chip → ADC path is aligned; LVDS I/O is correct.  
**Method:** Writes constant `0xCAFE` / `0xBABE` to DAC, reads back from ADC in BIST mode 2.  
**Key file:** `main.c` — enables BIST, captures ADC values.

#### Stage 2B-4 — `sw/stage2b4/` ← **Main working stage**
**Purpose:** Full OFDM round-trip through the AD9361 chip (BIST mode 1).  
**Proves:** openofdm_tx → AD9361 → dot11 decoder — complete digital path.  
**Result:** `fcs_ok=1`, `bad_pkt=0`, `last_pkt_len=24` — packet decoded correctly.  
**Key files:**
- `main.c` — inits AD9361, enables BIST, triggers TX, reads GPIO status word
- `parameters.h` — GPIO pin map, AXI base addresses, device IDs
- `app_config.h` — driver compile-time flags
- `noos/` — AD9361 no-OS driver (same as 2b2/2b3)

**Status GPIO word layout read by the ARM processor:**
```
gpio_i[ 7: 0]  = fcs_ok_count       (good packets, saturating)
gpio_i[15: 8]  = bad_pkt_count      (packets with bad FCS)
gpio_i[23:16]  = hdr_valid_count    (packets with valid L-SIG header)
gpio_i[31:24]  = last_pkt_rate      (0x0B = BPSK 1/2)
gpio_i[47:32]  = last_pkt_len       (24 = expected payload length)
gpio_i[63:48]  = last_byte_count    (bytes written by decoder)
```

---

## End-to-End Data Flow

### Digital Loopback (Stages 1B, 2B-4)

```
tx_packet_rom (BRAM)
      │  100-byte payload
      ▼
openofdm_tx  (bb_clk = 20 MSPS)
      │  32-bit {I[15:0], Q[15:0]} @ 20 MSPS
      ▼
tx_cdc async FIFO  (1024-deep, bridges bb_clk → l_clk)
      │
      ▼
dac_data_i0/q0  (l_clk = 40 MSPS, AD9361 fabric clock)
      │
      ▼
  [axi_ad9361 BIST mode 1: DAC output feeds ADC input internally]
      │
      ▼
adc_data_i0/q0  (l_clk domain)
      │
      ▼
rx_cdc async FIFO  (1024-deep, bridges l_clk → bb_clk)
      │
      ▼
10-cycle rate drain  (pace reads: 1 sample every 10 bb_clk cycles = 20 MSPS)
      │
      ▼
openofdm_rx / dot11 decoder  (bb_clk)
      │  sync → FFT → equalize → demod → deinterleave → Viterbi → descramble → FCS
      ▼
fcs_ok, decoded_byte[], pkt_len  →  GPIO → ARM processor
```

### RF Cable Loopback (Stage 4)

Same as above, but BIST is disabled and the AD9361 drives real analog RF:
```
AD9361 DAC → TX1A (SMA output) ──[1m cable]── RX1A (SMA input) → AD9361 ADC
```
TX attenuation ~30 dB, RX gain ~10 dB — comfortably above BPSK SNR threshold (~5 dB).

---

## Clocking Architecture

| Clock | Source | Frequency | Used By |
|-------|--------|-----------|---------|
| `FCLK_CLK0` | Zynq PLL | 100 MHz | AXI fabric, PS peripherals |
| `FCLK_CLK1` | Zynq PLL | 200 MHz | IDELAYCTRL (LVDS I/O calibration) |
| `bb_clk` | FCLK_CLK0 ÷ 8 | ~20 MHz | openofdm TX/RX cores (20 MSPS sample rate) |
| `l_clk` | AD9361 chip output | ~40 MHz | axi_ad9361 DAC/ADC data path (40 MSPS) |

The TX and RX paths cross two clock domains (bb_clk ↔ l_clk) via `xpm_fifo_async` primitives.

---

## Key Technologies & Dependencies

| Component | Version / Source |
|-----------|-----------------|
| **Xilinx Vivado** | 2022.2 — synthesis, implementation, IP generation |
| **Xilinx Vitis** | 2022.2 — C/C++ baremetal IDE |
| **adi-hdl** | analogdevicesinc/hdl (cloned separately) — provides `axi_ad9361` IP |
| **no-OS driver** | Analog Devices no-OS (vendored into `sw/stage2b*/noos/`) |
| **openofdm** | jhshi/openofdm — source of TX/RX Verilog cores |
| **ZedBoard** | Xilinx Zynq-7020 XC7Z020CLG484-1 |
| **FMCOMMS3** | Analog Devices AD9361, 20 MHz–6 GHz, FMC-LPC connector |

---

## Build Flow

### One-Time Setup
```bash
# 1. Clone ADI HDL next to this repo
cd <parent directory>
git clone https://github.com/analogdevicesinc/hdl.git adi-hdl

# 2. Package axi_ad9361 IP for Vivado
cd open_ofdm_phy-hw-clean-ofdm-rebuild
vivado -mode batch -source build_adi_lib.tcl
```

### Build Bitstream
```bash
cd v2/boards/zed_fmcs3
vivado -mode batch -source build.tcl
# Produces: stage2b4/stage2b4.bit  (FPGA bitstream)
#           stage2b4/stage2b4.xsa  (hardware description for Vitis)
```
Build time: ~30–45 minutes.

### Build Software (Vitis)
1. Open Vitis, create platform from `stage2b4.xsa`
2. Create new C application project
3. Add `v2/sw/stage2b4/main.c`, `parameters.h`, `app_config.h`
4. Add `v2/sw/stage2b4/noos/` folder to project and include paths
5. Build → ELF

### Deploy & Run
1. Program FPGA via JTAG: `program_hw_devices`
2. Download ELF via JTAG: `dow stage2b4.elf`
3. Open USB-UART terminal: 115200 baud, 8N1
4. `run` → observe UART output

### Expected UART Output (Stage 2B-4 BIST)
```
===============================================
Stage 2B-4 -- openofdm_tx -> axi_ad9361 BIST 1
===============================================
[ad9361] init OK
[ad9361] enabling BIST mode 1...
[ad9361] forcing chip into FDD...
       0x017 STATE = 0x1A (ENSM = 0xA = FDD ✓)

*** triggering TX (gpio_o[32]) ***
[AFTER ] gpio_i=0x00180018_0B010001
       fcs_ok=1  bad_pkt=0  hdr_valid=1
       last_pkt_rate=0x0B  last_pkt_len=24  last_byte_count=24

  *** PASS *** OFDM round-tripped through axi_ad9361.
```

---

## Proven Results

| Test | PER | BER | Packets |
|------|-----|-----|---------|
| BIST mode 1 (chip digital loopback) | 0% | 0 ppm | 100 |
| RF cable loopback (TX1A → SMA cable → RX1A) | 0% | 0 ppm | 100 |

---

## Stage-by-Stage Summary

| Stage | Folder | What It Proves |
|-------|--------|---------------|
| 0 | `sw/stage0` | UART + LED blink: board is alive |
| 1B | `sw/stage1b` | OFDM TX→RX HDL loopback (no chip), `fcs_ok=1` |
| 2 | `sw/stage2` | AD9361 SPI: product ID = 0x0A |
| 2A.5 | `sw/stage2a5` | AXI GPIO write-read patterns match |
| 2B-1 | `sw/stage2b1` | axi_ad9361 IP accessible, PCORE_VERSION != 0 |
| 2B-2 | `sw/stage2b2` | AD9361 driver init, BB PLL locks, l_clk running |
| 2B-3 | `sw/stage2b3` | BIST mode 2: constant pattern 0xCAFE/0xBABE round-trips |
| 2B-4 | `sw/stage2b4` | **OFDM through AD9361 BIST, fcs_ok=1** ← main milestone |
| 4 | (same HW) | **OFDM through RF cable, fcs_ok=1** ← final result |

---

## Summary

This is a complete, working, hardware-verified 802.11 OFDM physical layer on an FPGA. The design is implemented entirely in Verilog for the signal-processing pipeline, Tcl for the FPGA build automation, and C for bare-metal hardware control. It follows a rigorous staged-verification methodology — each subsystem is tested in isolation before integration — making it a solid reference for FPGA-based wireless communication research and development.
