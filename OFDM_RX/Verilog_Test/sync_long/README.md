# Sync Long Module - Standalone Vivado Project

## Overview
This is a standalone Vivado project for the `sync_long` module extracted from OpenWiFi's `openofdm_rx` IP core. The sync_long module performs **symbol alignment** by detecting the long preamble in 802.11 OFDM packets and determining precisely where each OFDM symbol starts.

## Module Description

### Functionality
The sync_long module:
- Detects the long preamble following the short preamble in 802.11 packets
- Determines the precise start of each 80-sample OFDM symbol (at 20 MSPS)
- Performs FFT on aligned OFDM symbols
- Applies phase correction using rotation
- Outputs synchronized FFT results for further processing

### Key Features
- Cross-correlation with known long training sequences (LTS)
- Dual-peak detection for precise timing
- Configurable FFT window shift
- Support for both normal and short guard intervals
- Phase offset estimation and correction

## Files Included

### Source Files (src/)
- **sync_long.v** - Main synchronization module (705 lines)
- **rotate.v** - Phase rotation module
- **stage_mult.v** - Multi-stage multiplier for cross-correlation
- **dpram.v** - Dual-port RAM for sample buffering
- **delayT.v** - Configurable delay line
- **complex_to_mag.v** - Complex to magnitude converter
- **complex_mult.v** - Complex multiplier wrapper
- **common_params.v** - Common parameter definitions
- **openofdm_rx_pre_def.v** - Pre-processor definitions
- **sync_long_tb.v** - Testbench for simulation

### IP Cores (src/ip_cores/)
- **complex_multiplier/** - Xilinx Complex Multiplier v6.0 (AXI-Stream)
- **xfft_v9/** - Xilinx FFT v9.0 IP core (64-point FFT for OFDM)

## Module Interface

### Inputs
- `clock` - System clock (typically 100 MHz)
- `reset` - Asynchronous reset
- `enable` - Module enable signal
- `reset_dot11` - 802.11 protocol reset
- `sample_in[31:0]` - Input samples {I[15:0], Q[15:0]}
- `sample_in_strobe` - Input data valid strobe
- `short_gi` - Short guard interval flag
- `fft_win_shift[3:0]` - FFT window shift configuration
- `phase_out[15:0]` - Phase from previous stage
- `phase_out_stb` - Phase valid strobe
- `rot_data[31:0]` - Rotation LUT data

### Outputs
- `rot_addr[7:0]` - Rotation LUT address
- `metric[31:0]` - Correlation metric
- `metric_stb` - Metric valid strobe
- `long_preamble_detected` - Long preamble detection flag
- `phase_in_i[31:0]` - Phase input I component
- `phase_in_q[31:0]` - Phase input Q component  
- `phase_in_stb` - Phase input strobe
- `sample_out[31:0]` - FFT output samples
- `sample_out_strobe` - Output data valid strobe
- `num_ofdm_symbol[15:0]` - OFDM symbol counter
- `phase_offset_taken[15:0]` - Applied phase offset
- `ltf_phase_offset[15:0]` - Long training field phase offset
- `state[2:0]` - Current state machine state

## Building the Project

### Prerequisites
- Xilinx Vivado 2022.2 or later
- Xilinx Installation directory (e.g., `/tools/Xilinx`)

### Build Steps

1. **Navigate to the sync_long directory:**
   ```bash
   cd /path/to/openwifi-hw/ip/sync_long
   ```

2. **Run the build script:**
   ```bash
   ./create_vivado_proj.sh /tools/Xilinx sync_long.tcl zed_fmcs2 100
   ```

   Parameters:
   - `/tools/Xilinx` - Xilinx installation directory
   - `sync_long.tcl` - TCL script filename
   - `zed_fmcs2` - Board name
   - `100` - Clock frequency in MHz

3. **The script will:**
   - Create a new Vivado project: `sync_long/sync_long.xpr`
   - Add all source files
   - Add IP cores (complex_multiplier and xfft_v9)
   - Configure simulation settings

### Opening the Project

```bash
vivado ./sync_long/sync_long.xpr
```

## First Time Setup

⚠️ **IMPORTANT**: When opening the project for the first time, the IP cores need to be upgraded and generated:

1. **Open the project** in Vivado
2. **Report IP Status**: In Flow Navigator, click "Report IP Status"
3. **Upgrade IPs**: If IPs show as needing upgrade, click "Upgrade Selected"
4. **Generate Output Products**: 
   - In the Sources window, expand "Design Sources"
   - Right-click on each IP (complex_multiplier, xfft_v9)
   - Select "Generate Output Products"
   - Choose "Out of context per IP" and click "Generate"

## Running Simulation

### Using Vivado GUI

1. **Open the project** in Vivado
2. **Run Behavioral Simulation**:
   - In Flow Navigator, click "Run Simulation" → "Run Behavioral Simulation"
3. **View Waveforms**:
   - Add signals to waveform window
   - Key signals to monitor:
     - `long_preamble_detected` - Detection flag
     - `state` - State machine progression
     - `sample_out` - FFT output
     - `num_ofdm_symbol` - Symbol counter
     - `metric` - Cross-correlation metric

### State Machine States

The sync_long module operates in the following states:
- **S_SKIPPING_TAIL (0)** - Skip short preamble tail samples
- **S_SKIPPING_CP (1)** - Skip cyclic prefix
- **S_WAIT_FOR_FIRST_PEAK (2)** - Detect first LTS peak
- **S_WAIT_FOR_SECOND_PEAK (3)** - Detect second LTS peak
- **S_IDLE (4)** - Idle state
- **S_FFT (5)** - Performing FFT on OFDM symbols

## Technical Details

### FFT Configuration
- **Type**: 64-point FFT (xfft_v9)
- **Transform**: Forward (time to frequency domain)
- **Interface**: AXI-Stream
- **Input Width**: 16-bit I/Q (scaled to 15-bit + sign for FFT)
- **Output Width**: 23-bit (truncated to 16-bit)

### Cross-Correlation
- Uses known LTS sequences for correlation
- 32-sample delay for autocorrelation
- Multi-stage multiplication (stage_mult) for efficiency
- 4-stage pipeline for processing

### Sample Buffer
- 256-sample circular buffer (IN_BUF_LEN_SHIFT=8)
- Dual-port RAM for simultaneous read/write
- Supports guard interval skipping (9 or 17 samples)

## Dependencies

This project depends on:
1. **Xilinx IP Cores**:
   - Complex Multiplier v6.0 (AXI-Stream interface)
   - FFT v9.0 (64-point, AXI-Stream interface)

2. **Custom Modules**:
   - rotate - Phase rotation using CORDIC-like algorithm
   - stage_mult - Efficient multi-stage complex multiplication
   - dpram - Dual-port RAM for buffering
   - delayT - Parameterizable delay
   - complex_to_mag - Magnitude calculation from I/Q
   - complex_mult - Wrapper for Xilinx Complex Multiplier IP

## Troubleshooting

### IP Core Version Mismatch
If you see warnings about IP versions:
1. Click "Report IP Status"
2. Select all IPs and click "Upgrade Selected"
3. Regenerate output products

### Elaboration Errors
If simulation fails to elaborate:
1. Check that all IP cores have generated output products
2. Verify IP Status shows all cores as "Up-to-date"
3. Clean and regenerate simulation files

### Missing Files
If files are not found:
- Ensure all source files are in `src/` directory
- Verify IP cores are in `src/ip_cores/` subdirectories
- Check file permissions (should be readable)

## Reference

This module is part of the OpenWiFi project:
- **OpenWiFi GitHub**: https://github.com/open-sdr/openwifi
- **openofdm_rx Documentation**: https://github.com/jhshi/openofdm

For detailed information about the sync_long algorithm, refer to:
- 802.11-2012 Standard, Section 18 (OFDM PHY)
- openofdm_rx documentation: docs/source/sync_long.rst

## License
This code is part of the OpenWiFi project and follows its licensing terms.
