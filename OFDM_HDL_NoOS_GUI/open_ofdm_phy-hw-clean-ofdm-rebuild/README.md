# OFDM TX/RX over RF cable on ZedBoard + FMCOMMS3

End-to-end 802.11 OFDM PHY (BPSK 1/2, 6 Mbps) running on a ZedBoard with an
FMCOMMS3 daughter card. Generates a fixed test packet in HDL via
`openofdm_tx`, sends it through the AD9361 chip data port (BIST loopback) or
the analog RF chain (cable loopback TX1A → RX1A), decodes via `dot11` /
`openofdm_rx`, and reports `fcs_ok` + per-byte BER over the wire.

This branch (`hw/clean-ofdm-rebuild`) is the **clean v2 rebuild** — only the
working v2 codebase is tracked here. The earlier simulation/exploration
project lives on `main` and `hw/bpsk-sanity-check`.

**Latest result on hardware (HEAD = `fb30007`):**

| Stage | Path | PER over 100 packets | Data BER over 76,800 bits |
|---|---|---|---|
| 2B-4 | Chip BIST mode 1 (digital data port loopback) | 0% | 0 ppm |
| 4    | RF cable (DAC → mixer → SMA → mixer → ADC) | 0% | 0 ppm |

100-byte PSDU per packet. Runtime-tunable dot11 parameters
(`soft_decoding`, `min_plateau`, `fft_win_shift`, etc.) are exposed via
GPIO bits — no bitstream rebuild needed to sweep them.

---

## Hardware

- **ZedBoard** (Zynq-7020, `xc7z020clg484-1`)
- **FMCOMMS3** (AD9361) on the FMC-LPC connector
- 1 m SMA jumper between **TX1A** and **RX1A** on the FMCOMMS3 (Stage 4 only)
- USB serial cable to PS UART (115200 8N1) for `xil_printf` output

## Software requirements

- **Vivado 2022.2** (must match `xc7z020clg484-1`). Other versions probably work but are untested.
- **Vitis 2022.2** for the bare-metal app build + flash
- **Git, bash** (for cloning the single dependency: `adi-hdl`)

## Build flow

### 1. Clone the dependency

Only `adi-hdl/` is required for the bitstream build. Clone it at the
same level as the project root:

```
parent/
├── bpsk-fresh/          ← this repo (this branch)
└── adi-hdl/             ← ADI HDL library (used: axi_ad9361 only)
```

```bash
git clone https://github.com/analogdevicesinc/hdl.git    adi-hdl
```

> **No-OS is NOT required.** The AD9361 driver from
> [analogdevicesinc/no-OS](https://github.com/analogdevicesinc/no-OS)
> is already vendored under `v2/sw/stage2b4/noos/` (61 files, sufficient
> for the bare-metal build). Only clone the upstream repo if you want
> to refresh the vendored driver.
>
> For reference while debugging, [openwifi-hw](https://github.com/open-sdr/openwifi-hw)
> is also useful but optional — never imported into the build.

### 2. Package the ADI library IP (one-time)

```bash
cd bpsk-fresh
vivado -mode batch -source build_adi_lib.tcl
```

This packages **only `axi_ad9361`** — the single ADI IP this design
instantiates. `axi_ad9361`'s own packaging script bundles its internal
dependencies (`ad_dds`, `up_axi`, `ad_data_*`, etc.) directly into the
IP, so no separate `util_*` IPs need to be packaged. Vivado then finds
the IP via `ip_repo_paths` in the project's `build.tcl`.

If you ever need additional IPs from `adi-hdl/library/`, edit the IP
list in `build_adi_lib.tcl` and re-run.

### 3. Build the bitstream

```bash
cd v2/boards/zed_fmcs3
vivado -mode batch -source build.tcl
```

`build.tcl` creates a self-contained `stage2b4/` project under
`v2/boards/zed_fmcs3/`. Synthesis + implementation takes ~30–45 minutes
on a typical workstation. Outputs:

```
v2/boards/zed_fmcs3/stage2b4/stage2b4.runs/impl_1/system_top.bit
v2/boards/zed_fmcs3/stage2b4/stage2b4.xsa
```

### 4. Build the Vitis bare-metal app

Open Vitis IDE, point it at the `.xsa` from step 3, import the source
tree (`main.c` + the `noos/` subfolder under `v2/sw/stage2b4/`), build
the ELF, and flash it via JTAG or boot from SD with `BOOT.bin`.

The `noos/` subdirectory under `stage2b4/` contains a vendored copy of
the AD9361 driver from analogdevicesinc/no-OS, so the SW build is
self-contained — no external no-OS clone is required.

### 5. Run

Open a UART terminal at 115200 8N1 on the ZedBoard's PS UART, then power
cycle or hit reset. The app will:

1. Bring up the AD9361 and set the chain rate to 40 MSPS
2. Enable BIST mode 1, sweep alignment params, run 100 packets through
   chip-internal loopback, report PER + BER
3. Disable BIST, configure RF gains for cable loopback, sweep again, run
   100 packets through the analog RF chain, report PER + BER

Total runtime ~10 seconds.

Expected output:

```
*** PASS *** OFDM round-tripped through axi_ad9361.
[BER BIST] Data BER: byte_err=0/96  bit_err=0/768  BER=0.000%
[BIST multi-packet] Aggregate data BER: 0.0000% (= 0 ppm)
*** STAGE 4 PASS *** RF cable loopback decoded.
[BER RF] Data BER: byte_err=0/96  bit_err=0/768  BER=0.000%
[RF multi-packet] Aggregate data BER: 0.0000% (= 0 ppm)
Hardware OFDM TX/RX loopback complete.
```

## Repository layout (this branch)

```
bpsk-fresh/
├── README.md                ← this file
├── build_adi_lib.tcl        ← packages axi_ad9361 from adi-hdl/ (run once)
├── .gitignore               ← excludes Vivado caches, build artifacts
└── v2/
    ├── README.md            ← v2-specific roadmap + per-stage history
    ├── boards/zed_fmcs3/    ← bitstream sources
    │   ├── build.tcl        ← top-level synth/impl entrypoint
    │   ├── system_bd.tcl    ← Block Design (PS, axi_ad9361, GPIO)
    │   ├── system_top.v     ← top-level Verilog: rate adapter, dot11 wiring
    │   ├── system_constr.xdc ← pin constraints (FMCOMMS3, EMIO GPIO)
    │   ├── tx_packet_rom.v  ← 100-byte test packet ROM
    │   └── iq_sample_fifo.v ← legacy sync FIFO (kept for reference)
    ├── ip/                  ← vendored OFDM IP (openofdm_tx/rx + helpers)
    └── sw/stage2b4/         ← Vitis bare-metal app
        ├── main.c           ← BIST + RF + multi-packet + BER test
        └── noos/            ← AD9361 no-OS driver (vendored from adi-no-os)
```

## Key design points

### Rate adapter (chip 40 MSPS ↔ OFDM 20 MSPS)

The AD9361 chain runs at 40 MSPS while `openofdm_tx`/`dot11` operate at
20 MSPS. We bridge in HDL using a free-running mod-2 of `l_clk` (80 MHz)
as a 40 MHz logical clock:

- **TX:** `dac_data` updated only on the 40 MHz boundary, so each value
  is held stable for 2 `l_clk` cycles. Real samples and zeros alternate
  to give a 1:2 zero-stuff pattern. Polarity is SW-tunable
  (`gpio_o[42]`) to handle the chip's unknown sample-phase alignment.
- **RX:** `adc_valid_i0` rising edge is decimated by 2 (`adc_phase`
  toggle) so 40 MSPS → 20 MSPS. A skip count (`gpio_o[50:48]`, 0..7)
  selects which of the 8 phases to lock onto.
- **Capture window:** opens on first TX FIFO read of a packet, closes
  after `CAPTURE_LIMIT = 3500` writes (covers a 100-byte packet's
  ~3,200 IQ samples plus margin).

Detailed analysis lives in the comments at the top of
[`v2/boards/zed_fmcs3/system_top.v`](v2/boards/zed_fmcs3/system_top.v).

### gpio_o map

| Bit | Function | Default |
|---|---|---|
| 32 | `phy_tx_start` (pulse 0→1→0) | 0 |
| 33 | `ad9361_resetb` (driven by no-OS) | – |
| 34 | `ad9361_enable` | 1 |
| 35 | `ad9361_txnrx` | 1 |
| 36 | dot11 `soft_decoding` | 1 |
| 37 | dot11 `force_ht_smoothing` | 0 |
| 38 | dot11 `disable_all_smoothing` | 1 |
| 39 | dot11 `threshold_scale` | 0 |
| 40 | `bist_select` (gpio_i mode bit 0) | 0 |
| 41 | `bist_pat_mode` (DAC mux: 0=OFDM, 1=0xCAFE/0xBABE) | 0 |
| 42 | TX `polarity_invert` | 0 |
| 43 | `byte_view_mode` (gpio_i = rx_byte_buf window) | 0 |
| 44–47 | dot11 `fft_win_shift` (4 bits) | 0x1 |
| 48–50 | rate-adapter `skip_target` (3 bits) | 0 |
| 51–54 | `byte_bank` (4 bits → 16 banks × 8 bytes) | 0 |
| 55–56 | `min_plateau_sel` (4-value mux) | 0b01 → 100 |
| 57–58 | `power_thres_sel` (4-value mux) | 0b00 → 0 |

PS pin = 54 + EMIO bit. `min_plateau_sel`: {00→50, 01→100, 10→200, 11→400}.
`power_thres_sel`: {00→0, 01→100, 10→500, 11→1000}.

## Tweaking the test

- **Packet size:** edit `mem[0]` (L-SIG length + parity) and `mem[2..N]`
  in [`tx_packet_rom.v`](v2/boards/zed_fmcs3/tx_packet_rom.v); update
  `PSDU_BYTES` / `DATA_BYTES` and `expected_bytes[]` in
  [`main.c`](v2/sw/stage2b4/main.c). Bump `CAPTURE_LIMIT` in
  `system_top.v` if the new packet's IQ sample count exceeds 3,500.
- **Number of packets per stage:** edit `NUM_PACKETS` in `main.c`. Keep
  total under 250 to avoid the 8-bit HDL counter wrapping; widen
  counters in `system_top.v` for higher counts.
- **dot11 parameter sweep:** SW writes the relevant `gpio_o` bits and
  re-runs `run_multi_packet`. No bitstream rebuild required.
- **Channel stress:** add an SMA attenuator (e.g., 30 dB) between TX1A
  and RX1A, or replace the cable with antennas. Re-run; expect
  non-zero BER as the SNR approaches the BPSK 1/2 threshold (~5 dB).

## Branch convention

- `hw/clean-ofdm-rebuild` — this branch, v2 only, current working state.
- `main` — older project state (simulation TB, exploration). Use
  `git log main` to find earlier work.
- `hw/bpsk-sanity-check`, `hw/ofdm-loopback-bpsk-port` — historical
  development branches.

## Acknowledgements

- [Analog Devices HDL library](https://github.com/analogdevicesinc/hdl) — `axi_ad9361` and friends
- [Analog Devices no-OS](https://github.com/analogdevicesinc/no-OS) — bare-metal AD9361 driver
- [openofdm](https://github.com/jhshi/openofdm) — `openofdm_tx`, `dot11`
- [openwifi-hw](https://github.com/open-sdr/openwifi-hw) — reference design for AD9361 + OFDM PHY integration
