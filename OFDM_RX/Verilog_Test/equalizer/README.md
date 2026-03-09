# Equalizer Module - Standalone Project

This is a standalone extraction of the **equalizer** module from the OpenWiFi openofdm_rx project, created for easier development and debugging.

## Project Status: ✅ CREATED SUCCESSFULLY

**Project Location:** `/home/kemal/Desktop/ofdmhdl/openwifi-hw/ip/equalizer/equalizer/equalizer.xpr`

## What is the Equalizer Module?

The equalizer module is a critical component of the OFDM receiver that performs:
- **Channel Estimation**: Estimates the wireless channel response using LTS (Long Training Symbols)
- **Frequency Offset Compensation**: Corrects residual frequency offset
- **Phase Error Correction**: Compensates for common phase error (CPE)
- **Channel Equalization**: Normalizes received signals by the channel response
- **CSI Extraction**: Provides Channel State Information for analysis

## Module Overview

### Inputs
- `sample_in[31:0]`: Input I/Q samples from sync_long module
- `sample_in_strobe`: Valid signal for input samples
- `ht_next`: Indicates HT (802.11n) format packet
- `pkt_ht`: HT packet flag
- `ht_smoothing`: HT smoothing parameter
- `disable_all_smoothing`: Disable channel smoothing

### Outputs
- `sample_out[31:0]`: Equalized I/Q samples
- `sample_out_strobe`: Valid signal for output
- `csi[31:0]`: Channel State Information
- `csi_valid`: CSI valid signal
- `state[3:0]`: Current equalizer state

### States
The equalizer operates in multiple states:
1. **S_FIRST_LTS** (0): Process first LTS
2. **S_SECOND_LTS** (1): Process second LTS and average
3. **S_SMOOTH_ACTSC** (2): Smooth active subcarriers
4. **S_GET_POLARITY** (3): Get pilot polarity
5. **S_CPE_ESTIMATE** (4): Estimate common phase error
6. **S_ALL_SC_PE_CORRECTION** (5): Correct all subcarriers
7. **S_HT_LTS** (6): Process HT-LTS

## Project Structure

```
equalizer/
├── src/
│   ├── equalizer.v              # Main equalizer module
│   ├── equalizer_tb.v           # Testbench
│   ├── calc_mean.v              # Helper: Calculate mean
│   ├── complex_mult.v           # Helper: Complex multiplication wrapper
│   ├── complex_multiplier.v     # Xilinx IP wrapper
│   ├── rotate.v                 # Helper: Phase rotation
│   ├── dpram.v                  # Dual-port RAM
│   ├── divider.v                # Divider wrapper
│   ├── div_gen.v                # Division generator wrapper
│   ├── stage_mult.v             # Stage multiplier
│   ├── delayT.v                 # Delay line
│   ├── complex_to_mag.v         # Complex to magnitude
│   ├── complex_to_mag_sq.v      # Complex to magnitude squared
│   ├── common_defs.v            # Common definitions
│   ├── common_params.v          # Common parameters
│   └── ip_cores/                # Xilinx IP cores directory
│       ├── complex_multiplier/
│       │   └── complex_multiplier.xci
│       ├── div_gen_div_gen_0_0/
│       │   └── div_gen_div_gen_0_0.xci
│       └── div_gen_xlslice_0_0/
│           └── div_gen_xlslice_0_0.xci
├── equalizer.tcl                # Vivado project creation script
├── create_vivado_proj.sh        # Shell wrapper script
└── equalizer/                   # Vivado project directory
    └── equalizer.xpr            # Vivado project file ← OPEN THIS
```

## Module Dependencies

The equalizer module has the following dependencies (all included):

### Verilog Modules
1. **calc_mean.v**: Calculates mean of two values (LTS averaging)
2. **complex_mult.v**: Complex number multiplication wrapper (uses Xilinx IP)
3. **rotate.v**: Phase rotation using lookup table
4. **dpram.v**: Dual-port RAM for buffering
5. **divider.v**: Division operation wrapper
6. **div_gen.v**: Division generator wrapper module
7. **stage_mult.v**: Staged multiplier
8. **delayT.v**: Parameterized delay line
9. **complex_to_mag.v**: Complex to magnitude conversion
10. **complex_to_mag_sq.v**: Complex to magnitude squared
11. **common_defs.v**: Macro definitions
12. **common_params.v**: Parameter definitions

### Xilinx IP Cores (in src/ip_cores/)
1. **complex_multiplier.xci**: Complex Multiplier 6.0 (AXI-Stream interface)
2. **div_gen_div_gen_0_0.xci**: Divider Generator 5.1
3. **div_gen_xlslice_0_0.xci**: Slice 1.0

**Note:** These IP cores will be automatically upgraded to Vivado 2022.2 when you first open or simulate the project.

## How to Open the Project

### Method 1: Direct Open (Recommended)
```bash
cd /home/kemal/Desktop/ofdmhdl/openwifi-hw/ip/equalizer/equalizer
vivado equalizer.xpr
```

### Method 2: Recreate Project
```bash
cd /home/kemal/Desktop/ofdmhdl/openwifi-hw/ip/equalizer
./create_vivado_proj.sh /tools/Xilinx equalizer.tcl zed_fmcs2 100
```

## Running Simulation

### ⚠️ IMPORTANT: First Time Setup
When you first open the project or run simulation, you **MUST** follow these steps:

1. **Close Vivado completely** if it's currently open
2. **Open the project fresh:**
   ```bash
   cd /home/kemal/Desktop/ofdmhdl/openwifi-hw/ip/equalizer/equalizer
   vivado equalizer.xpr
   ```
3. **Upgrade IP Cores:**
   - Vivado will show a **critical warning** about IP needing upgrade
   - Click **"Report IP Status"**  
   - Click **"Upgrade Selected"** to upgrade all 3 IP cores to Vivado 2022.2
   - Wait for upgrade to complete (~2-3 minutes)
   - If prompted, click **"Generate Output Products"**
   - Select **"Global"** and click **"Generate"**

### Running the Simulation
1. After IP upgrade is complete
2. Go to **Flow Navigator → Simulation → Run Simulation → Run Behavioral Simulation**
3. The testbench `equalizer_tb.v` will load
4. Wait for elaboration to complete
5. Click the **Run** button (▶) to start simulation
6. Check waveforms and console output

**Note:** If you get elaboration errors, make sure you completed the IP upgrade step first!

### Testbench Description

The testbench (`equalizer_tb.v`) provides:
- Clock generation (100 MHz)
- Reset sequence
- Simplified rotation LUT simulation
- Simplified phase calculation
- Test stimulus with LTS samples
- Output monitoring

**Note:** The testbench is simplified. For full system simulation, use the complete openofdm_rx project.

## Key Parameters

From `common_params.v`:
- `ROTATE_LUT_LEN_SHIFT`: Rotation LUT address width
- `CONS_SCALE_SHIFT`: Constellation scaling shift

## Algorithm Details

### LTS Processing
1. First LTS is captured and stored
2. Second LTS is averaged with the first
3. Optional smoothing across subcarriers
4. Inversion to create channel equalization coefficients

### CPE Estimation
- Uses 4 pilot subcarriers (-21, -7, 7, 21)
- Extracts phase error common to all subcarriers
- Corrects frequency offset per OFDM symbol

### Equalization
- Multiplies received signal by conjugate of channel estimate
- Normalizes by channel magnitude squared
- Outputs equalized constellation points

## Integration with OpenWiFi

This module is part of the openofdm_rx chain:
```
sync_short → sync_long → [EQUALIZER] → demodulate → deinterleave → viterbi → descramble
```

### Original Context
In the full openofdm_rx:
- Receives samples from `sync_long` module
- Shares rotation LUT with sync_long
- Shares phase calculation module
- Outputs to demodulator

## Modifications from Original

Changes made for standalone operation:
1. ✅ Copied all dependent modules
2. ✅ Created standalone testbench
3. ✅ Created Vivado project script
4. ✅ Maintained all original functionality

**No modifications to equalizer.v logic** - This is a pure extraction.

## Development Workflow

### 1. Modify the Module
Edit `src/equalizer.v` or related files in the Vivado project

### 2. Run Simulation
Test your changes using the testbench

### 3. Synthesize
Run synthesis to check for timing/resource issues:
```
Flow Navigator → Synthesis → Run Synthesis
```

### 4. Integrate Back
Copy modified `equalizer.v` back to openofdm_rx:
```bash
cp src/equalizer.v ../../openofdm_rx/verilog/
```

## External Connections Required

The equalizer needs these external connections:

### Rotation LUT
- Address output: `rot_addr`
- Data input: `rot_data`
- See `rot_lut` module in openofdm_rx

### Phase Calculation
- Outputs: `phase_in_i`, `phase_in_q`, `phase_in_stb`
- Inputs: `phase_out`, `phase_out_stb`
- See `phase` module in openofdm_rx

## Performance

- **Throughput**: 1 sample per clock cycle (when active)
- **Latency**: ~200 clock cycles for initial LTS processing
- **Clock Frequency**: 100 MHz typical
- **Resources**: ~3000 LUTs, ~2000 FFs, 4 DSP48s, 8 BRAM (estimated)

## Debugging Tips

### In Simulation
1. Monitor `state` signal to track equalizer progression
2. Check `sample_out_strobe` for valid outputs
3. Observe `csi` and `csi_valid` for channel estimates

### Common Issues
- **No output**: Check that input strobes are properly timed
- **Wrong results**: Verify LTS samples are correct 802.11 format
- **Stuck state**: Ensure reset is properly deasserted
- **IP upgrade errors**: When first opening, Vivado will ask to upgrade IP cores - click "Upgrade"
- **Elaboration errors**: If you see "Module not found" errors, make sure all .v files in src/ are added to the project

## References

- **802.11-2016 Standard**: Section 17 (OFDM PHY specification)
- **OpenWiFi Project**: https://github.com/open-sdr/openwifi
- **OpenOFDM Project**: https://github.com/open-sdr/openofdm

## Next Steps

To extract other modules from openofdm_rx:
1. Identify the module and its dependencies
2. Copy source files to new directory
3. Create testbench
4. Create Vivado project script
5. Test independently

**Recommended modules to extract next:**
- `sync_long` - Long preamble synchronization
- `demodulate` - OFDM demodulation
- `ofdm_decoder` - Complete decoder chain

## License

- OpenWiFi: AGPL-3.0-or-later
- This is a derivative work maintaining the same license

## Support

For issues specific to this extracted module, check:
1. Original openofdm_rx implementation
2. OpenWiFi GitHub issues
3. 802.11 standard documentation

---

**Created:** March 9, 2026  
**Based on:** OpenWiFi openofdm_rx (dot11zynq branch)  
**Vivado Version:** 2022.2
