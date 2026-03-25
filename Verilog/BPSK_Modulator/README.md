# BPSK Modulator IP — Installation & Integration Guide

This IP implements a Binary Phase-Shift Keying (BPSK) modulator for the
**Analog Devices FMCOMM2 / AD9361** RF transceiver on the **Xilinx ZED board** (xc7z020clg484-1).

It inserts into the existing AD9361 DAC data path and replaces the DMA
AXI-Stream source with a hardware BPSK signal generator.

---

## Table of Contents

1. [What the IP Does](#what-the-ip-does)
2. [Repository Layout](#repository-layout)
3. [Step 1 — Build the IP (Vivado)](#step-1--build-the-ip-vivado)
4. [Step 2 — Add IP Repository to ZED Project](#step-2--add-ip-repository-to-zed-project)
5. [Step 3 — Insert IP into Block Design](#step-3--insert-ip-into-block-design)
6. [Step 4 — Pin / Interface Connections](#step-4--pin--interface-connections)
7. [Step 5 — Address Assignment](#step-5--address-assignment)
8. [Step 6 — Regenerate Bitstream](#step-6--regenerate-bitstream)
9. [Register Map](#register-map)
10. [Software Control (Linux / IIO)](#software-control-linux--iio)
11. [Simulation / Testbench](#simulation--testbench)
12. [Block Diagram](#block-diagram)

---

## What the IP Does

The BPSK Modulator generates a continuous baseband I/Q signal:

| Data Bit | I (In-phase) | Q (Quadrature) |
|----------|-------------|----------------|
| `0`      | `+0x7FFF` (+full scale) | `0x0000` |
| `1`      | `+0x8001` (−full scale) | `0x0000` |

The AD9361 NCO mixes this baseband signal up to the configured RF carrier
frequency. No external modulation hardware is needed.

**Output format** (64-bit AXI-Stream, compatible with `util_ad9361_dac_upack`):

```
Bits [15: 0]  =  I0  — TX channel 1, BPSK symbol
Bits [31:16]  =  Q0  — TX channel 1, always 0
Bits [47:32]  =  I1  — TX channel 2 (copy of I0 if CH_SEL=1, else 0)
Bits [63:48]  =  Q1  — TX channel 2, always 0
```

**Three bit sources** are selectable at run time via register:

| SRC_SEL | Source |
|---------|--------|
| `00`    | Alternating 0/1 test tone (square wave) |
| `01`    | 32-bit repeating pattern from `PAT_DATA` register, MSB-first |
| `10`    | AXI-Stream serial input (`S_AXIS_BITS`) — one bit per beat |

When **ENABLE = 0** the IP passes the DAC DMA stream through unchanged,
so the original IIO / libiio playback path continues to work.

---

## Repository Layout

```
BPSK_Modulator/
├── README.md                        ← this file
├── src/
│   ├── bpsk_core.v                  ← modulation core (symbol gen, mux)
│   └── bpsk_modulator_v1_0.v        ← AXI4-Lite + AXI-Stream top-level
├── tb/
│   └── bpsk_tb.v                    ← 9-test simulation testbench
├── constraints/
│   └── bpsk_modulator.xdc           ← CDC false-path constraints
├── vivado/
│   ├── create_project.tcl           ← creates Vivado project
│   ├── package_ip.tcl               ← packages as reusable IP core
│   └── project/                     ← generated project (after running scripts)
└── ip_repo/
    └── bpsk_modulator_v1_0/         ← packaged IP (after packaging step)
        ├── component.xml
        ├── src/
        └── xgui/
```

---

## Step 1 — Build the IP (Vivado)

> Skip this step if `ip_repo/bpsk_modulator_v1_0/component.xml` already exists.

Open Vivado 2022.2, then in the Tcl console:

```tcl
cd /home/kemal/Desktop/FMCOMM2andos/BPSK_Modulator/vivado
source create_project.tcl

launch_runs synth_1 -jobs 4
wait_on_run synth_1

source package_ip.tcl
```

Expected last lines:
```
INFO: IP integrity check PASSED
IP core packaged successfully.
Location: .../ip_repo/bpsk_modulator_v1_0
```

---

## Step 2 — Add IP Repository to ZED Project

1. Open the **fmcomms2_zed** project in Vivado.
2. Go to **Tools → Settings → IP → Repository**.
3. Click the **+** button and browse to:
   ```
   /home/kemal/Desktop/FMCOMM2andos/BPSK_Modulator/ip_repo
   ```
4. Click **Select** → **OK**.
5. Vivado will say *"1 IP(s) added"* — click **OK**.
6. Click **OK** to close Settings.

If the IP still does not appear, run in the Tcl console:
```tcl
update_ip_catalog -rebuild
```
Then search for **"bpsk"** in the IP Catalog (Flow Navigator → IP Catalog).

---

## Step 3 — Insert IP into Block Design

Open `system.bd` (double-click it in Sources), then follow these steps:

### 3a. Expand the AXI Interconnect master count

The existing `axi_cpu_interconnect` has ports M00–M10 (11 master ports).
You need to add one more:

1. Double-click `axi_cpu_interconnect` in the block design.
2. Change **Number of Master Interfaces** from `11` to `12`.
3. Click **OK**.

### 3b. Add the BPSK Modulator IP

1. Right-click an empty area → **Add IP**.
2. Search for **BPSK Modulator** → double-click to instantiate.
3. The block appears with these interfaces:

| Interface | Type | Direction |
|-----------|------|-----------|
| `S_AXI` | AXI4-Lite | slave (register access) |
| `S_AXI_ACLK` | clock | input |
| `S_AXI_ARESETN` | reset | input |
| `aclk` | clock | input |
| `aresetn` | reset | input |
| `S_AXIS_DMA` | AXI4-Stream 64-bit | slave (DMA bypass in) |
| `M_AXIS_DAC` | AXI4-Stream 64-bit | master (DAC data out) |
| `S_AXIS_BITS` | AXI4-Stream 8-bit | slave (optional bit input) |

### 3c. Reconnect the DAC stream

The original path is:
```
axi_ad9361_dac_dma (M_AXIS)  →  util_ad9361_dac_upack (S_AXIS)
```

You need to insert the BPSK IP between them:

1. **Delete** the wire between `axi_ad9361_dac_dma/M_AXIS` and
   `util_ad9361_dac_upack/S_AXIS` (right-click the wire → Delete).
2. Connect `axi_ad9361_dac_dma/M_AXIS`        → `bpsk_modulator_v1_0/S_AXIS_DMA`
3. Connect `bpsk_modulator_v1_0/M_AXIS_DAC`   → `util_ad9361_dac_upack/S_AXIS`

---

## Step 4 — Pin / Interface Connections

Connect every port of the BPSK IP as follows:

### Clocks

| BPSK IP Port | Connect To | Net Name | Freq |
|---|---|---|---|
| `S_AXI_ACLK` | `sys_ps7/FCLK_CLK0` | `sys_cpu_clk` | 100 MHz |
| `aclk` | `util_ad9361_divclk/clk_out` | `util_ad9361_divclk` | ~245 MHz |

> **Why two clocks?**
> `S_AXI_ACLK` runs at 100 MHz (same as the CPU AXI bus).
> `aclk` must match the clock that drives `util_ad9361_dac_upack` — which is the AD9361 divided receive clock (~245 MHz). Using the same clock on both sides of the connection avoids timing violations in the DAC data path.

### Resets

| BPSK IP Port | Connect To | Net Name |
|---|---|---|
| `S_AXI_ARESETN` | `sys_rstgen/peripheral_aresetn[0]` | `sys_cpu_resetn` |
| `aresetn` | `sys_rstgen/peripheral_aresetn[0]` | `sys_cpu_resetn` |

> Both resets can share `sys_cpu_resetn`. The 2-FF synchronizers inside the IP ensure the data-path reset is properly re-synchronized to `aclk`.

### AXI4-Lite (register access)

| BPSK IP Port | Connect To |
|---|---|
| `S_AXI` (all signals) | `axi_cpu_interconnect/M11_AXI` (new master port) |

### AXI4-Stream (data path)

| BPSK IP Port | Connect To | Was connected to |
|---|---|---|
| `S_AXIS_DMA` | `axi_ad9361_dac_dma/M_AXIS` | (was directly to upack) |
| `M_AXIS_DAC` | `util_ad9361_dac_upack/S_AXIS` | (was directly from dma) |
| `S_AXIS_BITS` | Leave **unconnected** (or tie to a second DMA) | — |

---

## Step 5 — Address Assignment

1. In the block design, click the **Address Editor** tab (Window → Address Editor).
2. Find `bpsk_modulator_v1_0 / S_AXI`.
3. Set:
   - **Base Address**: `0x4380_0000`
   - **Range**: `64K` (0x10000)
   - **High Address**: `0x4380_FFFF`

This address is in the free range of the GP0 AXI address map and does not
conflict with any existing peripheral in the fmcomms2_zed reference design.

---

## Step 6 — Regenerate Bitstream

1. Click **Validate Design** (F6) — resolve any critical warnings.
2. Run **Generate Block Design** (Generate Output Products).
3. Run **Generate Bitstream**.
4. Export hardware (File → Export → Export Hardware, include bitstream).
5. Program the board.

---

## Register Map

Base address in Linux: `/sys/bus/platform/devices/43800000.bpsk_modulator/` (UIO)
or access directly via `/dev/mem` at physical address `0x4380_0000`.

All registers are 32-bit, word-addressed.

| Offset | Name | R/W | Reset | Description |
|--------|------|-----|-------|-------------|
| `0x00` | `CTRL` | R/W | `0x00000000` | Control register |
| | `[0]` ENABLE | | | `1` = BPSK active, `0` = DMA bypass |
| | `[2:1]` SRC_SEL | | | Bit source (see table above) |
| | `[3]` CH_SEL | | | `0` = TX1 only, `1` = TX1 + TX2 |
| `0x04` | `STATUS` | RO | `0x00000001` | Status |
| | `[0]` READY | | | Always 1 (IP operational) |
| | `[1]` ACTIVE | | | 1 when ENABLE=1 and streaming |
| `0x08` | `SYM_DIV` | R/W | `0x00000008` | Symbol period (clocks per symbol) |
| | `[15:0]` DIVIDER | | | Symbol rate = aclk_freq ÷ DIVIDER |
| `0x0C` | `AMPLITUDE` | R/W | `0x7FFF8001` | I-channel symbol amplitudes |
| | `[15:0]` I_NEG | | | I value for bit=1 (default `0x8001`) |
| | `[31:16]` I_POS | | | I value for bit=0 (default `0x7FFF`) |
| `0x10` | `PAT_DATA` | R/W | `0x55AA55AA` | 32-bit repeating bit pattern (SRC_SEL=01) |
| `0x18` | `SYM_CNT_LO` | RO | — | Transmitted symbol counter [31:0] |
| `0x1C` | `SYM_CNT_HI` | RO | — | Transmitted symbol counter [39:32] |
| `0x20` | `IP_VERSION` | RO | `0x00010000` | Version 1.0.0 |

### Symbol rate examples (aclk = 245.76 MHz)

| DIVIDER | Symbol Rate |
|---------|-------------|
| `1`     | 245.76 Msym/s |
| `8`     | 30.72 Msym/s (1 symbol per DAC sample) |
| `16`    | 15.36 Msym/s |
| `246`   | ~1.00 Msym/s |
| `2457`  | ~100 ksym/s |

---

## Software Control (Linux / IIO)

Using `/dev/mem` (simplest approach):

```c
#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>

#define BPSK_BASE  0x43800000UL
#define MAP_SIZE   0x10000

volatile uint32_t *bpsk;

// Open and map
int fd = open("/dev/mem", O_RDWR | O_SYNC);
bpsk = mmap(NULL, MAP_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, BPSK_BASE);

// Enable BPSK, alternating pattern, TX1 only, divider=8
bpsk[0x00/4] = 0x00000001;   // CTRL: ENABLE=1, SRC_SEL=00
bpsk[0x08/4] = 8;            // SYM_DIV = 8

// Send custom 32-bit pattern
bpsk[0x10/4] = 0xA3C5F0B1;  // PAT_DATA
bpsk[0x00/4] = 0x00000003;  // CTRL: ENABLE=1, SRC_SEL=01

// Read symbol counter
uint32_t cnt_lo = bpsk[0x18/4];
uint32_t cnt_hi = bpsk[0x1C/4];
uint64_t symbols = ((uint64_t)cnt_hi << 32) | cnt_lo;

// Disable (returns to DMA / IIO playback mode)
bpsk[0x00/4] = 0x00000000;
```

---

## Simulation / Testbench

The testbench `tb/bpsk_tb.v` covers 9 test cases:

| TC | Test |
|----|------|
| 1  | IP version register + reset state |
| 2  | SRC_SEL=00 alternating pattern, Q=0 check |
| 3  | SRC_SEL=01 register pattern (0xA5A5A5A5) |
| 4  | SRC_SEL=10 AXI-Stream bit input |
| 5  | CH_SEL=1 BPSK replicated on TX2 |
| 6  | DMA bypass when ENABLE=0 |
| 7  | Backpressure (tready=0 pauses symbol counter) |
| 8  | Symbol counter increments and reads back |
| 9  | Custom amplitude registers |

To run in the BPSK Modulator Vivado project:

```tcl
set_property top bpsk_tb [get_filesets sim_1]
launch_simulation
run all
```

---

## Block Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                     ZED Board (Zynq-7020)                       │
│                                                                 │
│  ┌──────────────┐   AXI4-Lite (100 MHz)                         │
│  │  Cortex-A9   │──────────────────────────────────┐            │
│  │  (sys_ps7)   │                                  │            │
│  └──────┬───────┘                                  ▼            │
│         │ HP1 (64-bit, 100 MHz)    ┌───────────────────────┐    │
│         ▼                          │   BPSK Modulator v1.0  │   │
│  ┌─────────────┐  M_AXIS           │  ┌─────────────────┐  │   │
│  │  DAC DMA    │──────────────────►│  │  S_AXIS_DMA     │  │   │
│  │  (dac_dma)  │                   │  └────────┬────────┘  │   │
│  └─────────────┘                   │           │ (bypass    │   │
│                                    │           │  or BPSK)  │   │
│                                    │  ┌────────▼────────┐  │   │
│                                    │  │  M_AXIS_DAC     │  │   │
│                                    │  └────────┬────────┘  │   │
│                                    └───────────┼───────────┘   │
│                                                │ 64-bit AXI-S   │
│                                                ▼                │
│                                    ┌───────────────────┐        │
│                                    │  dac_upack        │        │
│                                    │  (4×16-bit I/Q)   │        │
│                                    └─────────┬─────────┘        │
│                                              │                  │
│                                    ┌─────────▼─────────┐        │
│                                    │  dac_fifo         │        │
│                                    │  (clock crossing) │        │
│                                    └─────────┬─────────┘        │
│                                              │ ~245 MHz         │
│                                    ┌─────────▼─────────┐        │
│                                    │  axi_ad9361       │        │
│                                    │  (parallel I/F)   │        │
│                                    └─────────┬─────────┘        │
└──────────────────────────────────────────────┼──────────────────┘
                                               │ FMC LPC
                                               ▼
                                    ┌───────────────────┐
                                    │  AD9361  (FMCOMM2) │
                                    │  RF output         │
                                    └───────────────────┘
```

---

## Troubleshooting

**"IP not found in catalog"**
- Confirm `ip_repo/bpsk_modulator_v1_0/component.xml` exists.
- In ZED project: Tools → Settings → IP → Repository → add the `ip_repo` folder.
- Run `update_ip_catalog -rebuild` in Tcl console.
- Search for "bpsk" (not "BPSK Modulator") in case of case sensitivity.

**"No output from AD9361 when ENABLE=1"**
- Verify `aclk` is connected to `util_ad9361_divclk` (not sys_cpu_clk).
- Verify `SYM_DIV` ≥ 1 (a value of 0 stalls the counter).
- Check the AD9361 NCO is configured to the desired TX frequency via libiio.

**"DMA playback broken after adding IP"**
- When ENABLE=0 the DMA stream passes through unchanged.
- Ensure `aresetn` and `S_AXI_ARESETN` are driven; floating resets cause lockup.

**"Bitstream build fails with clock constraint errors"**
- The `constraints/bpsk_modulator.xdc` file sets `set_clock_groups -asynchronous`
  between `S_AXI_ACLK` and `aclk`. Verify it is included in the IP's file group
  and marked `USED_IN out_of_context`.
