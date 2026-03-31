# BPSK Loopback Test — Complete Run Guide

Everything you need to do, in order, from a freshly built Vivado project
to seeing **BER = 0** printed on the UART console.

---

## Checklist Overview

```
[ ] Step 1  — Hardware connections (cable + board)
[ ] Step 2  — Package BPSK Modulator IP
[ ] Step 3  — Package BPSK Demodulator IP
[ ] Step 4  — Vivado block design: add IPs and wire them
[ ] Step 5  — Generate bitstream
[ ] Step 6  — Export hardware to Vitis
[ ] Step 7  — Create/update Vitis platform and application
[ ] Step 8  — Verify base addresses match Address Editor
[ ] Step 9  — Build and program
[ ] Step 10 — Read UART output and interpret results
```

---

## Step 1 — Hardware Connections

### RF loopback cable
Connect an SMA cable between **TX1A** and **RX1A** on the FMCOMM2 board.
Insert a **15–20 dB SMA attenuator** in the cable to protect the RX input.

```
FMCOMM2
  TX1A ──[SMA cable]──[20 dB attenuator]──► RX1A
```

> **Why the attenuator?** The AD9361 TX output can be up to +5 dBm.
> The RX input maximum is −2 dBm. Without attenuation the RX front-end
> will saturate and the AGC will not settle correctly.

### UART connection
Connect a USB-to-UART cable to the ZED board UART header (J14).
Default baud rate: **115200 8-N-1**.

Open a terminal (minicom, PuTTY, TeraTerm) and keep it visible — all
test output appears here.

### Power
Power the ZED board. Do not program anything yet.

---

## Step 2 — Package BPSK Modulator IP

*Skip if already done in a previous session.*

```tcl
# In Vivado Tcl console:
cd /home/kemal/Desktop/FMCOMM2andos/BPSK_Modulator/vivado
source create_project.tcl
launch_runs synth_1 -jobs 4
wait_on_run synth_1
source package_ip.tcl
```

Expected last line: `IP integrity check PASSED`

Output directory: `BPSK_Modulator/ip_repo/bpsk_modulator_v1_0/`

---

## Step 3 — Package BPSK Demodulator IP

*Skip if already done in a previous session.*

```tcl
cd /home/kemal/Desktop/FMCOMM2andos/BPSK_Demodulator/vivado
source create_project.tcl
launch_runs synth_1 -jobs 4
wait_on_run synth_1
source package_ip.tcl
```

Expected last line: `IP integrity check PASSED`

Output directory: `BPSK_Demodulator/ip_repo/bpsk_demodulator_v1_0/`

---

## Step 4 — Vivado Block Design

Open the FMCOMM2 ZED Vivado project.

### 4.1 — Add IP repositories

`Tools → Settings → IP → Repository → + (Add)`

Add both paths:
```
/home/kemal/Desktop/FMCOMM2andos/BPSK_Modulator/ip_repo
/home/kemal/Desktop/FMCOMM2andos/BPSK_Demodulator/ip_repo
```

Click **OK → Refresh IP Catalog**.

---

### 4.2 — Expand AXI CPU Interconnect

Double-click **`axi_cpu_interconnect`**.

Increase **NUM_MI** to accommodate the new peripherals:

| Port | Peripheral | Note |
|------|-----------|------|
| M00–M11 | existing | do not change |
| M12 | bpsk_modulator_v1_0 | new |
| M13 | bpsk_demodulator_v1_0 | new |
| M14 | axi_dmac_bits | new |

Set `NUM_MI = 15` (or higher if you already added other peripherals).

---

### 4.3 — Add BPSK Modulator IP

Right-click canvas → **Add IP** → search `BPSK Modulator` → double-click.

**Connect ports:**

| Modulator port | Connect to |
|---------------|-----------|
| `aclk` | `util_ad9361_divclk` |
| `aresetn` | `sys_cpu_resetn` |
| `S_AXI_ACLK` | `sys_cpu_clk` |
| `S_AXI_ARESETN` | `sys_cpu_resetn` |
| `S_AXI_*` | `axi_cpu_interconnect/M12_AXI` |
| `S_AXIS_DMA_*` | `axi_ad9361_dac_dma/M_AXIS` (disconnect from upack first) |
| `M_AXIS_DAC_*` | `util_ad9361_dac_upack/S_AXIS` |

> **DAC path change explained:**
> Before: `dac_dma → upack → ad9361`
> After:  `dac_dma → bpsk_modulator → upack → ad9361`
> When BPSK is enabled the modulator generates its own symbols and
> silently drains the DMA. When disabled it passes DMA data through.

---

### 4.4 — Add BPSK Demodulator IP

Right-click canvas → **Add IP** → search `BPSK Demodulator` → double-click.

**Connect ports:**

| Demodulator port | Connect to |
|----------------|-----------|
| `aclk` | `util_ad9361_divclk` |
| `aresetn` | `sys_cpu_resetn` |
| `S_AXI_ACLK` | `sys_cpu_clk` |
| `S_AXI_ARESETN` | `sys_cpu_resetn` |
| `S_AXI_*` | `axi_cpu_interconnect/M13_AXI` |
| `adc_data[63:0]` | `util_ad9361_adc_pack/packed_fifo_wr_data` |
| `adc_valid` | `util_ad9361_adc_pack/packed_fifo_wr_en` |

> **ADC tap explained:** The demodulator reads the ADC output **in
> parallel** with the existing `axi_ad9361_adc_dma`. The original
> connection is not broken — the demodulator is a second fanout.

---

### 4.5 — Add AXI4-Stream Width Converter

The bits-capture DMA minimum width is 16 bits; the demodulator outputs
8 bits. A width converter bridges the gap.

Right-click canvas → **Add IP** → search `AXI4-Stream Data Width Converter`.

**Settings:**
| Parameter | Value |
|-----------|-------|
| S_TDATA_NUM_BYTES | 1  (8-bit input) |
| M_TDATA_NUM_BYTES | 2  (16-bit output) |

**Connect ports:**

| Width converter port | Connect to |
|--------------------|-----------|
| `aclk` | `util_ad9361_divclk` |
| `aresetn` | `sys_cpu_resetn` |
| `S_AXIS` | `bpsk_demodulator/M_AXIS_BITS` |
| `M_AXIS` | `axi_dmac_bits/s_axis` (next step) |

---

### 4.6 — Add Bits-Capture DMA (ADI axi_dmac)

Right-click canvas → **Add IP** → search `axi_dmac` → double-click.

**Settings (double-click to configure):**

| Parameter | Value |
|-----------|-------|
| DMA_TYPE_SRC | 1 (AXI-Stream) |
| DMA_TYPE_DEST | 0 (Memory-Mapped) |
| DMA_DATA_WIDTH_SRC | 16 |
| DMA_DATA_WIDTH_DEST | 64 |
| CYCLIC | 0 |
| DMA_2D_TRANSFER | 0 |
| MAX_BYTES_PER_BURST | 128 |

**Connect ports:**

| DMA port | Connect to |
|---------|-----------|
| `s_axis_aclk` | `util_ad9361_divclk` |
| `m_dest_axi_aclk` | `sys_cpu_clk` |
| `s_axi_aclk` | `sys_cpu_clk` |
| `s_axi_aresetn` | `sys_cpu_resetn` |
| `s_axis` | `axis_dwidth_converter/M_AXIS` |
| `m_dest_axi` | `processing_system7_0/S_AXI_HP3` |
| `s_axi` | `axi_cpu_interconnect/M14_AXI` |
| `s_axis_xfer_req` | **leave unconnected** |
| `irq` | **leave unconnected** (using polling) |

> **HP3 port:** Double-click `processing_system7_0` →
> **PS-PL Configuration → HP Slave AXI Interface →
> S AXI HP3 interface → enable**.

---

### 4.7 — Address Editor

Click the **Address Editor** tab (next to Diagram tab) or
`Window → Address Editor`.

Right-click each unmapped entry → **Assign Address**, then verify:

| Peripheral | Offset Address | Range |
|-----------|---------------|-------|
| `bpsk_modulator_v1_0 / S_AXI` | `0x4380_0000` | 64K |
| `bpsk_demodulator_v1_0 / S_AXI` | `0x43C0_0000` | 64K |
| `axi_dmac_bits / s_axi` | `0x7C44_0000` | 64K |
| `axi_dmac_bits / m_dest_axi` | `0x0000_0000` | 512M |

> If Vivado auto-assigns different addresses for the first three,
> update `parameters.h` to match before building the software.

---

### 4.8 — Validate and Save

Press **F6** (Validate Design). Resolve any critical errors.

Warnings about unconnected `irq` and `s_axis_xfer_req` are harmless —
ignore them.

Save the block design: `Ctrl+S`.

---

## Step 5 — Generate Bitstream

In the Vivado Flow Navigator:

```
Generate Bitstream
```

This runs synthesis → implementation → bitstream generation.
Typical time: 20–40 minutes.

When finished: **Bitstream Generation Completed** dialog appears.
Click **Cancel** (do not open implemented design — you will export next).

---

## Step 6 — Export Hardware to Vitis

```
File → Export → Export Hardware
```

- Select **Include bitstream**
- Output: choose a folder or the default
- Creates a `.xsa` file (hardware description for Vitis)

Note the `.xsa` file path — you will need it in the next step.

---

## Step 7 — Vitis: Create/Update Platform and Application

### 7.1 — Open Vitis

```
Tools → Launch Vitis IDE
```

Or open Vitis separately and point to the same workspace.

### 7.2 — If this is the first time (new workspace)

**Create Platform Project:**
1. `File → New → Platform Project`
2. Name: `fmcomms2_zed_platform`
3. Select **Create from hardware specification (XSA)**
4. Browse to the `.xsa` file exported in Step 6
5. OS: **standalone**  Processor: **ps7_cortexa9_0**
6. Click **Finish** — Vitis generates the BSP

**Create Application Project:**
1. `File → New → Application Project`
2. Select platform: `fmcomms2_zed_platform`
3. Name: `bpsk_loopback_app`
4. Template: **Empty Application (C)**
5. Finish

**Add source files to the application:**
Copy (or add as links) these files into the `src/` folder of your
application project:
```
/home/kemal/Desktop/FMCOMM2andos/ad9361/src/main.c
/home/kemal/Desktop/FMCOMM2andos/ad9361/src/app_config.h
/home/kemal/Desktop/FMCOMM2andos/ad9361/src/parameters.h
/home/kemal/Desktop/FMCOMM2andos/ad9361/src/bpsk_loopback.h
/home/kemal/Desktop/FMCOMM2andos/ad9361/src/bpsk_loopback.c
```

Also add the no-OS AD9361 driver sources referenced in `src.mk`
(ad9361_api.c, axi_dmac.c, etc.) — these come from the ADI no-OS
repository that was already used in the original project.

### 7.3 — If you already have the project (updating hardware)

1. Right-click the **platform** project → **Update Hardware Specification**
2. Browse to the new `.xsa`
3. Right-click platform → **Build**

The application project automatically picks up the new `xparameters.h`.

---

## Step 8 — Verify Base Addresses

Open `xparameters.h` in the BSP (generated by Vitis):
```
fmcomms2_zed_platform / ps7_cortexa9_0 / standalone_domain /
    bsp / ps7_cortexa9_0 / include / xparameters.h
```

Search for your new peripherals and confirm they match `parameters.h`:

| Search term | Expected value in xparameters.h |
|-------------|--------------------------------|
| `BPSK_MODULATOR` or look for `0x43800000` | should exist |
| `BPSK_DEMODULATOR` or `0x43C00000` | should exist |
| `AXI_DMAC` (third instance) or `0x7C440000` | should exist |

> **If the addresses differ:** Edit these three lines in
> `ad9361/src/parameters.h` to match whatever Vivado assigned:
> ```c
> #define BPSK_MOD_BASEADDR       0x43800000u   // ← update if different
> #define BPSK_DEMOD_BASEADDR     0x43C00000u   // ← update if different
> #define BPSK_BITS_DMA_BASEADDR  0x7C440000u   // ← update if different
> ```
> Rebuild after any change.

---

## Step 9 — Build and Program

### 9.1 — Build

Right-click the application project → **Build Project**

Should complete with **0 errors**.

Common build errors and fixes:

| Error | Fix |
|-------|-----|
| `xil_io.h not found` | XILINX_PLATFORM not defined — check app_config.h |
| `no_os_mdelay undeclared` | Add `no_os_delay.h` include path in BSP settings |
| `bpsk_loopback.c not found` | Add the file to the Vitis src/ folder |
| `BPSK_BITS_DDR_BASEADDR undeclared` | Missing `#ifdef XILINX_PLATFORM` guard — check parameters.h |

### 9.2 — Program bitstream

In Vivado (or Vitis):
```
Open Hardware Manager → Open Target → Auto Connect
→ Program Device → select .bit file → Program
```

The DONE LED on the ZED board lights green when the bitstream is loaded.

### 9.3 — Run application

In Vitis, right-click application project →
**Run As → Launch on Hardware (Single Application Debug)**

Or use **XSCT** console:
```tcl
connect
targets -set -filter {name =~ "ARM*#0"}
rst -processor
dow path/to/bpsk_loopback_app.elf
con
```

---

## Step 10 — UART Output and Results

Open your terminal at **115200 8-N-1** on the ZED UART port.

### Expected output sequence

```
============================================================
  BPSK Loopback Test
  SYM_DIV = 16  |  SPS = 16
  Test pattern : 0xA5C3F0E1
  Capture size : 4096 bytes (32768 bits)
============================================================
[OK] Both IPs detected (version 1.0.0)
[..] Modulator started (alternating mode). Waiting for lock...
    STATUS = 0x0000000F  |  AGC_settled=1  Carrier_locked=1
[OK] Locked.
    AGC gain     = 0x1200  (1.125x)
    Phase error  = 3
    Timing error = -1
[..] Modulator switched to pattern 0xA5C3F0E1
[..] Capturing 4096 bytes via bits-DMA...
[OK] Capture done.

  First 16 captured bytes: A5 C3 F0 E1 A5 C3 F0 E1 A5 C3 F0 E1 A5 C3 F0 E1
  Expected pattern  :      A5 C3 F0 E1 A5 C3 F0 E1 (repeating)

============================================================
  BPSK Loopback Test Results
------------------------------------------------------------
  Bits tested       : 32512
  Bit errors        : 0
  BER               : 0.00e+00
  AGC gain (Q4.12)  : 0x1200  (1.125x)
  Phase error       : 2
  Timing error      : 0
  Carrier locked    : 1
  AGC settled       : 1
  Total demod bits  : 33024
------------------------------------------------------------
  RESULT:  *** PERFECT ***  BER = 0  (zero bit errors)
============================================================
```

### What the values mean

| Value | Good range | Meaning |
|-------|-----------|---------|
| `AGC_settled = 1` | must be 1 | AGC found correct gain |
| `Carrier_locked = 1` | must be 1 | Costas loop phase-locked |
| `AGC gain` | `0x0800`–`0x4000` | 0.5×–4×; outside this range means too weak/strong signal |
| `Phase error` | ±10 | near zero = well locked |
| `Timing error` | ±5 | near zero = symbol timing recovered |
| `BER` | 0 | zero errors expected in clean loopback |

---

## Troubleshooting

### "Both IPs detected" fails / reads 0xDEADBEEF

The base address in `parameters.h` does not match the Address Editor.

1. Check `xparameters.h` for the actual address Vivado assigned
2. Update `BPSK_MOD_BASEADDR` or `BPSK_DEMOD_BASEADDR` in `parameters.h`
3. Rebuild and re-run

---

### Lock timeout — `AGC_settled=0` or `Carrier_locked=0`

**Check in order:**

1. **Is the RF cable connected?**
   Without a cable, no signal reaches the RX — loops will never lock.

2. **Is the attenuator correct?**
   Too much attenuation (>30 dB) → signal too weak → AGC gain will
   saturate. Too little (<10 dB) → RX overloads.
   Read `AGC gain` register:
   - `> 0x8000` → signal too weak, reduce attenuation or increase TX gain
   - `< 0x0400` → signal too strong, add more attenuation

3. **Are both LOs at the same frequency?**
   `default_init_param.rx_synthesizer_frequency_hz` must equal
   `tx_synthesizer_frequency_hz` (both are `2400000000UL` by default).

4. **Is SPS = SYM_DIV?**
   `BPSK_SYM_DIV` in `bpsk_loopback.h` must equal the hardware
   `cfg_sym_div`. Both default to 16.

5. **Try increasing Costas gain temporarily:**
   Add this before calling `bpsk_loopback_test()` in `main.c`:
   ```c
   Xil_Out32(0x43C00014, 0x0080);  // COSTAS_KP × 2
   ```

---

### DMA capture timeout

1. **Verify demodulator is outputting bits:**
   Read `BIT_CNT_LO` twice with a 1-second gap:
   ```c
   printf("cnt1=%u\n", Xil_In32(0x43C0002C));
   no_os_mdelay(1000);
   printf("cnt2=%u\n", Xil_In32(0x43C0002C));
   ```
   If both reads are equal → bits not flowing → demodulator ENABLE bit
   is 0, or `adc_valid` is not connected in the block design.

2. **Verify DMA address:**
   ```c
   printf("dma_ctrl=%08X\n", Xil_In32(0x7C440000));
   ```
   If it returns `0xFFFFFFFF` → wrong address.

3. **Check HP3 is enabled on PS7** in the block design.

---

### BER > 0 after lock

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| ~50% BER | Phase ambiguity (180° flip) | Normal for BPSK — the pattern 0xA5C3F0E1 inverted is 0x5A3C0F1E; check if those bytes appear instead |
| 1–5% BER | Loop not fully settled | Wait longer after pattern switch; increase `no_os_mdelay(100)` to `500` in `bpsk_loopback.c` |
| Random pattern | Timing not locked | Increase `TIMING_KP` (register `0x43C0001C`) |
| All zeros or all 0xFF | DMA buffer not invalidated | Add `Xil_DCacheInvalidateRange` call |

> **Note on 180° phase ambiguity:**
> BPSK cannot distinguish 0° from 180° without a reference.
> If `BER ≈ 100%` and all bits are inverted, the Costas loop locked
> to the wrong phase. This is normal and handled in practice by
> differential encoding (each bit encodes a *change*, not an
> absolute level). For this loopback test you can detect it by
> checking for the inverted pattern `0x5A3C0F1E` in the BER
> calculation — the `ber_calculate()` function already tries all
> 4 byte-alignment offsets but not the 180° inversion. If needed,
> also try XOR-ing each received byte with `0xFF` before comparing.

---

## Quick Reference — Register Cheat Sheet

| Action | Address | Value |
|--------|---------|-------|
| Enable modulator (alternating) | `0x43800000` | `0x00000001` |
| Enable modulator (pattern) | `0x43800000` | `0x00000003` |
| Disable modulator | `0x43800000` | `0x00000000` |
| Write test pattern | `0x43800010` | `0xA5C3F0E1` |
| Enable demodulator | `0x43C00000` | `0x00000001` |
| Disable demodulator | `0x43C00000` | `0x00000000` |
| Read demod status | `0x43C00004` | expect `0xF` when locked |
| Read AGC gain | `0x43C00010` | `0x1000` = 1.0× |
| Read phase error | `0x43C00024` | signed, expect near 0 |
| Read bit count LO | `0x43C0002C` | increments while running |
| Enable bits DMA | `0x7C440000` | `0x00000001` |
| Start bits DMA xfer | `0x7C44000C` | `0x00000001` |
| Check bits DMA done | `0x7C440088` | `1` = done |
