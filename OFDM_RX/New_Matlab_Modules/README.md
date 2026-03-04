# OpenOFDM MATLAB Implementation

## Overview
This directory contains MATLAB implementations of the OpenOFDM Verilog modules. The goal is to create **bit-exact** models that produce identical outputs to the Verilog simulation when given the same inputs.

## Project Structure
```
matlab/
├── Modules/
│   ├── BasicModules/      # Low-level building blocks
│   ├── MainPipeline/      # RX pipeline stages
│   └── LUTs/              # Lookup table loaders
├── Utils/                 # Helper functions and utilities
├── Tests/                 # Test scripts
└── Data/                  # LUT data and specifications
```

## Module Categories

### 1. Basic Modules (`Modules/BasicModules/`)
Core building blocks used throughout the pipeline:
- `delayT.m` - Shift register delay (configurable cycles)
- `complex_to_mag_sq.m` - I²+Q² calculation (2-cycle pipeline)
- `complex_mult.m` - Complex multiplication (5-cycle pipeline)
- `moving_avg.m` - Moving average with circular buffer
- `delay_sample.m` - Sample delay buffer
- `divider.m` - Fixed-point division (36-cycle pipeline)
- `phase.m` - Phase calculation using CORDIC (40-cycle)
- `rotate.m` - Complex rotation with LUT (8-cycle)
- `calc_mean.m` - Mean calculation with accumulation
- `stage_mult.m` - 4-way correlation (6-cycle)
- `complex_to_mag.m` - Magnitude approximation

### 2. LUT Modules (`Modules/LUTs/`)
Load lookup tables exported from Verilog:
- `load_rot_lut.m` - Rotation coefficients (512 cos/sin pairs)
- `load_atan_lut.m` - Arctangent values (256 entries)
- `load_deinter_lut.m` - Deinterleaver mapping (2048 addresses)

### 3. Main Pipeline (`Modules/MainPipeline/`)
IEEE 802.11 receiver stages:
1. `power_trigger.m` - Packet detection
2. `sync_short.m` - Short preamble sync, CFO estimation
3. `sync_long.m` - Long preamble sync, FFT
4. `equalizer.m` - Channel equalization, pilot tracking
5. `ofdm_decoder.m` - Decoder wrapper (contains 5 sub-modules):
   - `demodulate.m` - Soft-decision demodulation (BPSK/QPSK/QAM16/QAM64)
   - `deinterleave.m` - Frequency-to-time domain reordering
   - `viterbi_decode.m` - Convolutional decoder
   - `descramble.m` - LFSR descrambler
   - `bits_to_bytes.m` - Bit-to-byte conversion
6. `crc32.m` - IEEE 802.11 CRC-32

### 4. Top-Level Module (`Modules/`)
- `dot11.m` - Complete receiver orchestrating all pipeline stages

### 5. Utilities (`Utils/`)
- `load_verilog_input.m` - Load test vectors from Verilog format
- `compare_signals.m` - Compare MATLAB vs Verilog outputs
- `plot_constellation.m` - Visualize constellation diagrams
- `bin2dec_signed.m` - Binary to signed decimal conversion
- `export_luts_simple.py` - Python script to export LUTs from .mif files

### 6. Tests (`Tests/`)
- `test_basic_modules.m` - Unit tests for basic modules
- `run_matlab_simulation.m` - Full receiver simulation

## Fixed-Point Formats

All modules use fixed-point arithmetic matching the Verilog implementation:

| Signal | Format | Bits | Range | Notes |
|--------|--------|------|-------|-------|
| I/Q samples | Q0.15 | 16 | [-1, 1) | Input samples scaled by 32768 |
| Rotation LUT | Q0.11 | 12 | [-1, 1) | cos/sin scaled by 2048 |
| Phase/Angle | Q2.13 | 16 | [-π, π) | Scaled by 8192/π |
| Power | Q16.15 | 32 | [0, 2^16) | Magnitude squared |
| Soft bits | Q3.4 | 8 | [-8, 8) | LLR scaled by 16 |

## Getting Started

### 1. Export LUTs from Verilog
```bash
cd matlab/Utils
python3 export_luts_simple.py
```
This creates:
- `Data/rot_lut.txt` (rotation table)
- `Data/atan_lut.txt` (arctangent table)
- `Data/deinter_lut.txt` (deinterleaver mapping)

### 2. Test Basic Modules
```matlab
cd matlab/Tests
test_basic_modules
```

### 3. Run Full Simulation
```matlab
cd matlab/Tests
run_matlab_simulation
```

### 4. Compare with Verilog
First, run Verilog simulation:
```bash
cd verilog
make simulate
```

Then compare outputs in MATLAB:
```matlab
% Load Verilog outputs
verilog_out = load('../verilog/sim_out/power_trigger.txt');

% Run MATLAB model
matlab_out = my_matlab_function(...);

% Compare
[match, errors] = compare_signals(matlab_out, verilog_out, 'Power Trigger', 0);
```

## Implementation Notes

### Pipeline Depths
All modules maintain cycle-accurate pipeline depths matching Xilinx IP cores:
- Complex multiplier: 5 cycles
- Divider: 36 cycles
- FFT-64: ~70 cycles
- Viterbi decoder: 36 cycles

### State Management
Modules use `persistent` variables for state:
```matlab
persistent state buffer_idx;

if isempty(state) || reset
    state = 0;
    buffer_idx = 1;
end
```

### Fixed-Point Operations
Careful attention to overflow and saturation:
```matlab
% Scale before multiply to prevent overflow
product = (int32(a) * int32(b)) / 2^15;

% Clamp to valid range
if product > 32767
    product = 32767;
elseif product < -32768
    product = -32768;
end
result = int16(product);
```

## Validation Strategy

1. **Module-level**: Test each module independently with known inputs
2. **Integration**: Test pipeline stages together
3. **End-to-end**: Compare full packet decoding with Verilog
4. **Bit-exact**: Zero tolerance for differences in fixed-point calculations

## Known Limitations

1. **Viterbi decoder**: Current implementation is simplified - needs full ACS/traceback
2. **Equalizer**: Pilot tracking simplified - may need refinement
3. **Sync algorithms**: Thresholds may need tuning for different SNR conditions
4. **MATLAB FFT**: Uses built-in `fft()` which may differ from Xilinx IP

## Next Steps

- [ ] Implement full Viterbi decoder with ACS/traceback
- [ ] Add SIGNAL field parsing for rate/length detection
- [ ] Implement all data rates (6, 9, 12, 18, 24, 36, 48, 54 Mbps)
- [ ] Add comprehensive test suite with multiple packets
- [ ] Optimize performance for real-time processing
- [ ] Document bit-exact verification results

## References

- **Verilog source**: `../verilog/`
- **Module specifications**: `Data/module_specifications.md`
- **IEEE 802.11-2012**: Physical layer specification
- **Xilinx IP**: LogiCORE documentation for FFT, Viterbi, etc.

## Contact

For questions about this MATLAB implementation, refer to the original Verilog project:
https://github.com/jhshi/openofdm

---
*Generated for OpenOFDM project - Fixed-point MATLAB modeling of Verilog OFDM receiver*
