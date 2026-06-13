# Clean-slate OFDM TX/RX RF cable loopback

Fresh rebuild on branch `hw/clean-ofdm-rebuild`. No code from the previous attempt is reused — only:

- Existing `adi-hdl/` (ADI HDL library, builds via `build_adi_lib.tcl`)
- Existing `adi-no-os/` (no-OS BSP for AD9361)
- `openwifi-hw/` as a reference (read-only)
- The simulation testbench transceiver as the verification reference

## Goal

OFDM TX/RX chain that decodes packets with `fcs_ok=1` over a real RF cable loopback (TX1A → SMA → RX1A on FMCOMMS3), running on ZedBoard.

## Staged plan

| Stage | What it proves | Loopback path | Status |
|-------|----------------|---------------|--------|
| 0     | Skeleton compiles, board boots, UART prints | empty bitstream + hello-world | TODO |
| 1     | openofdm_tx → openofdm_rx via HDL FIFO mux  | TX FIFO → sync FIFO → RX FIFO (no AD9361) | TODO |
| 2     | axi_ad9361 + ADI ADC/DAC, BIST mode 2 round-trip | dac_data → BIST 2 → adc_data | TODO |
| 4     | Real RF cable loopback, fcs_ok=1            | TX1A → cable → RX1A | TODO |

(Stage 3 — chip-internal analog loopback — is intentionally skipped; the prior project proved BIST mode 1 is unusable.)

**Stage gating:** each stage MUST hit its target before the next is touched.

## Layout

```
v2/
├── README.md                 ← this file (roadmap + per-stage status)
├── boards/zed_fmcs3/         ← top-level system_top.v, BD tcl, constraints
├── ip/                       ← vendored openofdm_tx, openofdm_rx
├── sim/                      ← per-stage testbenches
└── sw/                       ← per-stage Vitis apps (stage0/, stage1/, ...)
```

## Per-stage entry/exit criteria

### Stage 0 — bringup
- **Entry:** clean branch, ADI libs already built.
- **Work:** trivial `system_top.v` (clock/reset/LED/UART), Vitis hello-world.
- **Exit:** UART prints "Hello", LED blinks. Bitstream + .elf flash cleanly.

### Stage 1 — HDL OFDM loopback
- **Entry:** Stage 0 PASSED.
- **Work:** vendor openofdm_tx/rx, add TX BRAM, sync FIFO + steady-rate drain, AXI-Lite slaves, byte-capture FIFO, SW that loads test packet and triggers TX.
- **Exit:** at least one received packet with `fcs_ok=1` and byte-exact payload match.

### Stage 2 — axi_ad9361 BIST loopback
- **Entry:** Stage 1 PASSED.
- **Work:** add `axi_ad9361` + util_ad9361_dac_upack/adc_pack, async FIFO crossings, AD9361 init at 20 MSPS in BIST mode 2.
- **Exit:** `fcs_ok=1` over BIST mode 2. **If high BER persists, capture ILA `rx_rf_fifo_dout` vs `openofdm_tx` output sample-by-sample to identify the residual transformation BEFORE proceeding.**

### Stage 4 — RF cable
- **Entry:** Stage 2 PASSED.
- **Work:** disable BIST, set TX atten 30 dB / RX gain 10 dB, run TX_QUAD + RFDC cals only.
- **Exit:** `fcs_ok=1` with cable, stable across 5+ boots.

## Lessons preserved from the prior project (don't relearn)

- AD9361 must be **20 MSPS native** (no FPGA-side decimation) — the 18 MHz LPF skirt aliases at 40 MSPS.
- All **4 ADC channels enabled** so cpack packs 1 sample/beat (not 2 → effective half-rate).
- `dac_data << 2` to put ±4340 openofdm_tx samples in the upper bits of the chip's 12-bit DAC.
- L-SIG **parity bit must be SW-computed** (dot11_tx.v transmits bit 17 verbatim).
- I/Q ordering: openofdm_rx expects `{I, Q}`. Cpack outputs `{Q, I}`. Swap halves at FIFO din.
- **Don't add RX_QUAD or BBDC cals** — they overcorrect and cancel signal in this setup.
- RF chain itself is proven good (DDS test 2026-04-16) — don't re-debug the cable/PA/LNA.
