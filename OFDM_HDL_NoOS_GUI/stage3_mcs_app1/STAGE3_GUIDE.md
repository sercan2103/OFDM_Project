# Stage 3 — Multi-MCS BER vs SNR Test Guide

This guide explains everything you need to do to run the multi-MCS test from scratch.
The test sends 1000 packets at each of 12 SNR points for all 8 802.11a rates
(BPSK 1/2 up to 64QAM 3/4) over an RF cable loopback and prints a waterfall table.

---

## What this test does

- Initialises the AD9361 RF chip at 40 MSPS
- Automatically finds the correct CDC timing (polarity + skip) using MCS 0 (BPSK 1/2)
- For each of the 8 rates (MCS 0–7): sends 5 test packets to confirm decoding works,
  then runs an AWGN noise sweep from shift=4 (very noisy) to shift=15 (clean)
- At each noise point it sends 1000 packets and records how many decoded correctly
- Prints a per-MCS table and a final summary waterfall showing the SNR threshold for each rate

**Estimated runtime: ~40 minutes** (8 rates × 12 SNR points × 1000 pkts × 25 ms each)

---

## Physical setup

1. Connect an SMA cable from **TX1A** to **RX1A** on the FMCOMMS3 board.
   This is an RF cable loopback — the transmitter feeds directly into the receiver.
2. Do **not** connect any antenna.
3. Make sure the ZedBoard is powered and connected to your PC via USB-UART (115200 baud).

---

## Step 1 — Rebuild the FPGA bitstream

The bitstream must be rebuilt because the TX ROM and system_top.v were changed to support
multi-MCS. The existing `stage1c.bit` from the stage2b4 project **will not work**.

### What changed in the HDL
- `tx_packet_rom.v` replaced by `tx_packet_rom_mcs.v` — a 1024-word ROM with 8 separate
  64-word blocks, one per 802.11a rate. GPIO pins 0–2 select which block is used.
- `system_top.v` updated — adds `mcs_sel[2:0]` wires from `gpio_o[2:0]` and offsets the
  ROM address by `mcs_sel × 64`.
- `build.tcl` updated — references `tx_packet_rom_mcs.v` instead of `tx_packet_rom.v`.

### How to rebuild

Open a terminal on your PC (not the ZedBoard) and run:

```bash
cd /home/kemal/Desktop/OFDMPROJECTCURRENT/open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3

vivado -mode batch -source build.tcl
```

This will:
- Delete and recreate the `stage1c/` project folder
- Synthesise, implement, and write the bitstream
- Export `stage1c/stage1c.xsa` (hardware description for Vitis)

**This takes approximately 45–60 minutes.**

When it finishes you should see:
```
==== Stage 1C build complete ====
Bitstream: ./stage1c/stage1c.runs/impl_1/system_top.bit
XSA:       ./stage1c/stage1c.xsa
```

---

## Step 2 — Create the Vitis platform project

You need to create a new platform from the new XSA file.
Do this in Vitis (the 2022.x IDE, not Vitis HLS).

1. Open Vitis. Set your workspace to:
   ```
   /home/kemal/Desktop/OFDMPROJECTCURRENT
   ```

2. Go to **File → New → Platform Project**.

3. Name it: `stage3_mcs_platform`

4. Click **Browse** next to "XSA File" and select:
   ```
   /home/kemal/Desktop/OFDMPROJECTCURRENT/open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3/stage1c/stage1c.xsa
   ```

5. Operating system: **standalone**  
   Processor: **ps7_cortexa9_0**  
   Click **Finish**.

6. In the Explorer panel, right-click `stage3_mcs_platform` → **Build Platform**.
   Wait for it to finish (a few minutes).

---

## Step 3 — Create the Vitis application project

1. Go to **File → New → Application Project**.

2. Click **Next** past the intro screen.

3. On the platform screen, select `stage3_mcs_platform`. Click **Next**.

4. Name the application: `stage3_mcs_app`  
   Leave the domain as `standalone on ps7_cortexa9_0`. Click **Next**.

5. On the template screen, select **Empty Application (C)**. Click **Finish**.

---

## Step 4 — Add the source files

The application needs the same no-OS AD9361 driver sources that stage2b4 uses,
plus the `main.c` already written for stage3.

### 4a — Copy sources from stage2b4_app

The easiest way: copy the entire `src/` folder content from the stage2b4 project.

In a terminal:

```bash
cp /home/kemal/Desktop/OFDMPROJECTCURRENT/stage2b4_app/src/app_config.h   \
   /home/kemal/Desktop/OFDMPROJECTCURRENT/stage3_mcs_app/src/

cp /home/kemal/Desktop/OFDMPROJECTCURRENT/stage2b4_app/src/parameters.h   \
   /home/kemal/Desktop/OFDMPROJECTCURRENT/stage3_mcs_app/src/

cp /home/kemal/Desktop/OFDMPROJECTCURRENT/stage2b4_app/src/lscript.ld     \
   /home/kemal/Desktop/OFDMPROJECTCURRENT/stage3_mcs_app/src/

cp -r /home/kemal/Desktop/OFDMPROJECTCURRENT/stage2b4_app/src/noos        \
   /home/kemal/Desktop/OFDMPROJECTCURRENT/stage3_mcs_app/src/
```

The `main.c` is already in place:
```
/home/kemal/Desktop/OFDMPROJECTCURRENT/stage3_mcs_app/src/main.c
```

### 4b — Refresh in Vitis

In the Vitis Explorer panel:
- Right-click `stage3_mcs_app` → **Refresh**
- You should now see `main.c`, `app_config.h`, `parameters.h`, and the `noos/` folder

### 4c — Set the linker script

Right-click `stage3_mcs_app/src` → **Generate Linker Script**,
or if `lscript.ld` already appears in the tree it will be picked up automatically.

---

## Step 5 — Build the application

Right-click `stage3_mcs_app` → **Build Project**  
(or press Ctrl+B with the project selected).

Fix any errors before continuing. Common issues:
- **Missing include**: make sure `app_config.h` and `parameters.h` are in `src/`
- **Undefined symbol**: make sure the `noos/` folder was copied and all `.c` files are included
- **Wrong platform**: confirm the project is linked to `stage3_mcs_platform`, not `stage2b4_platform`

A successful build produces:
```
stage3_mcs_app/Debug/stage3_mcs_app.elf
```

---

## Step 6 — Program the board and run

1. Connect the ZedBoard via USB-JTAG.

2. Open a serial terminal at **115200 baud, 8N1** (e.g. minicom, PuTTY, or the Vitis Serial Terminal).
   The USB-UART port is usually `/dev/ttyACM0` on Linux or `COM3` on Windows.

3. In Vitis, right-click `stage3_mcs_app` → **Run As → Launch on Hardware (Single Application Debug)**,
   or use **Xilinx → Program FPGA** first then **Run**.

4. Watch the serial terminal. You should see:

```
=============================================
  Stage 3 -- Multi-MCS RF loopback BER test
  8 rates: BPSK/QPSK/16QAM/64QAM, 1/2..3/4
=============================================

[ad9361] init...
[ad9361] init OK
[ad9361] setting 40 MSPS chain...
       actual RX=40000000 Hz  TX=40000000 Hz
[ad9361] l_clk ~80000000 Hz (want ~80 MHz)
[ad9361] 0x017 ENSM bits[3:0]=0xA (want 0xA=FDD)

[align] RF cable alignment at MCS 0 (BPSK 1/2)...
[align] pol=0 sel=0 ... no decode
[align] pol=0 sel=1 ... GOOD  rate=0x0B len=100

  *** RF ALIGNED *** polarity=0 skip_target=1

...
```

The alignment step tries 16 combinations (2 polarities × 8 skip values).
Once it finds a working combination it moves on automatically.

---

## Step 7 — Reading the output

Each MCS prints a table like this:

```
-----------------------------------------------------------
  MCS 0   6 Mbps  BPSK  1/2  (rate=0x0B)
  SNR range: -21 dB to +45 dB  (shift 4..15)
  Pkts/point: 1000   Est. time: ~300 s
  shift | SNR(dB) | OK pkts | Failed | PER(%) | eff.BER(ppm)
  ------|---------|---------|--------|--------|-------------
  4  | -21 dB | 0    | 1000 | 100.0 | 1000000
  5  | -15 dB | 0    | 1000 | 100.0 | 1000000
  6  |  -9 dB | 0    | 1000 | 100.0 | 1000000
  7  |  -3 dB | 412  | 588  |  58.8 | 588000
  8  |   3 dB | 998  | 2    |   0.2 | 200
  9  |   9 dB | 1000 | 0    |   0.0 | 0
  ...
  AWGN disabled.
```

**Column meanings:**

| Column | Meaning |
|---|---|
| shift | AWGN noise_shift register value |
| SNR(dB) | Estimated SNR (calibrated: shift=8 → +3 dB for BPSK 1/2) |
| OK pkts | Packets decoded with correct FCS |
| Failed | Packets not decoded (no FCS increment seen) |
| PER(%) | Packet Error Rate = Failed / 1000 |
| eff.BER(ppm) | Effective BER: failed packets counted as 100% bit loss + any bit errors in decoded packets, expressed in parts-per-million |

**What to look for:**
- The transition from 100% PER to 0% PER is the **waterfall point** — the SNR threshold for that rate
- Higher modulation orders (64QAM) need more SNR, so their waterfall shifts right (higher shift value)
- If a rate never decodes at all (stays at 100% PER even at shift=15), check your RF gains

---

## Step 8 — Final summary table

At the end the test prints a summary of all 8 rates:

```
=============================================
  SUMMARY -- Waterfall threshold (first shift with PER < 5%)
  (SNR calibrated: BPSK 1/2 threshold ~ shift=8 = +3 dB)
  MCS | Rate      | Mod   | CR  | thresh.shift | est.SNR
  ----|-----------|-------|-----|--------------|--------
   0  |  6 Mbps  | BPSK  | 1/2 |     8        | 3 dB
   1  |  9 Mbps  | BPSK  | 3/4 |     9        | 9 dB
   2  | 12 Mbps  | QPSK  | 1/2 |     9        | 9 dB
   3  | 18 Mbps  | QPSK  | 3/4 |    10        | 15 dB
   4  | 24 Mbps  | 16QAM | 1/2 |    11        | 21 dB
   5  | 36 Mbps  | 16QAM | 3/4 |    12        | 27 dB
   6  | 48 Mbps  | 64QAM | 2/3 |    13        | 33 dB
   7  | 54 Mbps  | 64QAM | 3/4 |    13        | 33 dB
=============================================
  Multi-MCS test complete.
```

`N/A` in thresh.shift means that rate never reached PER < 5% — either the SNR range
was not wide enough (very unlikely at shift=15) or the rate is not decoding at all.

---

## Troubleshooting

### AD9361 init fails
- Check the FMCOMMS3 is seated properly in the FMC connector
- Confirm the SPI chip-select in `parameters.h` matches your board (should be the same as stage2b4)
- Power-cycle the ZedBoard and try again

### RF alignment fails (all 16 combinations say "no decode")
- Check the SMA cable is connected TX1A → RX1A (not RX1A → TX1A — it is directional)
- Increase RX gain: in `main.c` change `ad9361_set_rx_rf_gain(phy, 0, 30)` to `40`
- Decrease TX attenuation: change `ad9361_set_tx_attenuation(phy, 0, 10000)` to `5000` (5 dB)
- Rebuild and reflash after any change

### MCS 0 aligns but MCS 1–7 never decode (0/5 on verify)
- Higher-order modulations need higher SNR — try increasing RX gain by 10 dB
- The verify step uses no added AWGN (the AWGN block is off during verify),
  so this usually means the RF path quality is marginal

### ENSM not in FDD (0x017 bits != 0xA)
- The AD9361 must be in FDD for simultaneous TX+RX
- Try power-cycling the FMCOMMS3 and re-running

### Output is garbled or missing characters
- Confirm baud rate is exactly 115200
- Do not use format strings with `%+d` or field-width specifiers — `xil_printf` does not support them

### Build errors in Vitis
- If you see "cannot find app_config.h": the file was not copied to `stage3_mcs_app/src/`
- If you see "multiple definition of main": make sure only `stage3_mcs_app/src/main.c` is in the project, not also one from noos/
- Right-click the project → **C/C++ Build Settings** → confirm include paths contain `${workspace_loc:stage3_mcs_app/src}`

---

## File locations reference

| File | Path |
|---|---|
| Main C source | `stage3_mcs_app/src/main.c` |
| TX ROM (HDL) | `open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3/tx_packet_rom_mcs.v` |
| Top-level HDL | `open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3/system_top.v` |
| Build script | `open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3/build.tcl` |
| XSA output | `open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3/stage1c/stage1c.xsa` |
| Bitstream | `open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3/stage1c/stage1c.runs/impl_1/system_top.bit` |

---

## Quick checklist before running

- [ ] SMA cable connected TX1A → RX1A on FMCOMMS3
- [ ] ZedBoard USB-UART connected and serial terminal open at 115200 baud
- [ ] Bitstream rebuilt with `vivado -mode batch -source build.tcl`
- [ ] `stage3_mcs_platform` created from the new `stage1c.xsa`
- [ ] `stage3_mcs_app` built without errors
- [ ] Board programmed with the new bitstream (the one from the new build, not stage2b4)
