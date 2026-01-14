# MATLAB Validation Modules for OpenOFDM Verilog Design

This directory contains MATLAB functions that correspond to each Verilog module in your workspace. Each MATLAB function implements the same functionality as its Verilog counterpart for validation and testing purposes.

## Directory Structure

```
matlab_validation/
├── part1_phase_rotation/     # FFT and Phase Rotation modules
├── part2_equalizer/           # Equalizer (CSI, Noise Estimation) modules
├── part3_signal_decode/       # SIGNAL and HT-SIG decoding modules
└── README.md                  # This file
```

---

## Part 1: FFT and Phase Rotation Modules

**Location**: `part1_phase_rotation/`

These modules handle phase calculation and rotation for frequency offset correction.

### 1.1 Basic Building Blocks

| MATLAB File | Verilog Module | Description | Pipeline |
|------------|----------------|-------------|----------|
| `delayT.m` | `delayT.v` | Shift register delay line | Configurable |
| `complex_mult.m` | `complex_mult.v` | Complex multiplication | 5 cycles |
| `divider.m` | `divider.v` | Integer division | 36 cycles |

### 1.2 Lookup Tables (ROMs)

| MATLAB File | Verilog Module | Description | Size |
|------------|----------------|-------------|------|
| `atan_lut.m` | `atan_lut ROM` | Arctangent lookup table | 256 entries |
| `rot_lut.m` | `rot_lut ROM` | Rotation (cos/sin) lookup table | 512 entries |

### 1.3 Phase Processing

| MATLAB File | Verilog Module | Description | Pipeline |
|------------|----------------|-------------|----------|
| `phase.m` | `phase.v` | Calculate phase angle (atan2) | 40 cycles |
| `rotate.m` | `rotate.v` | Rotate complex sample by phase | 8 cycles |

**Usage Example**:
```matlab
% Initialize
state = phase_init();
% Calculate phase of complex sample
[phase_angle, state] = phase(i_sample, q_sample, state);

% Rotate sample
rot_state = rotate_init();
[out_i, out_q, rot_state] = rotate(in_i, in_q, phase_angle, rot_state);
```

---

## Part 2: Equalizer Modules

**Location**: `part2_equalizer/`

These modules implement channel estimation, frequency offset correction, and equalization.

### 2.1 Supporting Modules

| MATLAB File | Verilog Module | Description | Pipeline |
|------------|----------------|-------------|----------|
| `calc_mean.m` | `calc_mean.v` | Signed mean of two values | 3 cycles |
| `ram_2port.m` | `ram_2port.v` | Dual-port RAM | 1 cycle |

### 2.2 Main Equalizer

| MATLAB File | Verilog Module | Description | States |
|------------|----------------|-------------|--------|
| `equalizer.m` | `equalizer.v` | Complete equalizer with CSI estimation | 6 states |

**Equalizer States**:
- `S_FIRST_LTS` (0): Store first Long Training Sequence
- `S_SECOND_LTS` (1): Average two LTS for CSI estimation
- `S_GET_POLARITY` (2): Prepare pilot polarity sequence
- `S_CALC_FREQ_OFFSET` (3): Calculate residual CFO from pilots
- `S_ADJUST_FREQ_OFFSET` (4): Apply CFO correction and equalization
- `S_HT_LTS` (5): Process HT-LTS (802.11n)

**Usage Example**:
```matlab
% Initialize
state = equalizer_init();

% Process LTS symbols (128 samples)
for i = 1:128
    [out, state] = equalizer(lts_samples(:,i), 1, 0, state);
end

% Process data symbols
for i = 1:num_symbols
    [eq_out, state] = equalizer(data_samples(:,i), 1, 0, state);
    % eq_out contains 48 (legacy) or 52 (HT) equalized subcarriers
end
```

---

## Part 3: SIGNAL and HT-SIG Decode Modules

**Location**: `part3_signal_decode/`

These modules decode and validate the SIGNAL and HT-SIG fields.

### 3.1 CRC Modules

| MATLAB File | Verilog Module | Description |
|------------|----------------|-------------|
| `ht_sig_crc.m` | `ht_sig_crc.v` | CRC-8 for HT-SIG validation |
| `crc32.m` | `crc32.v` | CRC-32 for FCS (Frame Check Sequence) |

### 3.2 Decode and Validation

| MATLAB File | Verilog Module | Description |
|------------|----------------|-------------|
| `signal_decode.m` | `dot11.v (S_CHECK_SIGNAL)` | Decode/validate SIGNAL field |
| `ht_detect.m` | `dot11.v (S_DETECT_HT)` | Detect HT vs Legacy format |
| `qbpsk_derotate.m` | `dot11.v (S_HT_SIGNAL)` | Convert Q-BPSK to BPSK |
| `ht_sig_decode.m` | `dot11.v (S_CHECK_HT_SIG)` | Decode/validate HT-SIG field |

**Usage Example**:
```matlab
% Decode SIGNAL field
signal_bits = 0x0B4D60; % Example: Rate=0xB, Length=0x4D6
[valid, fields, is_ht] = signal_decode(signal_bits);

if is_ht
    % Detect HT by analyzing samples
    is_ht_confirmed = ht_detect(eq_samples);
    
    if is_ht_confirmed
        % Derotate Q-BPSK
        ht_sig_bpsk = qbpsk_derotate(ht_sig_samples);
        
        % Decode HT-SIG (after demodulation to bits)
        [valid, ht_fields, crc_ok] = ht_sig_decode(ht_sig1, ht_sig2);
    end
end
```

---

## Module Summary by Function

### Total Modules Created: 18

**Part 1 - Phase Rotation**: 7 modules
1. `delayT.m`
2. `complex_mult.m`
3. `divider.m`
4. `atan_lut.m`
5. `rot_lut.m`
6. `phase.m`
7. `rotate.m`

**Part 2 - Equalizer**: 3 modules
8. `calc_mean.m`
9. `ram_2port.m`
10. `equalizer.m`

**Part 3 - SIGNAL/HT-SIG Decode**: 6 modules
11. `ht_sig_crc.m`
12. `crc32.m`
13. `signal_decode.m`
14. `ht_detect.m`
15. `qbpsk_derotate.m`
16. `ht_sig_decode.m`

---

## Key Implementation Notes

### 1. Pipeline Delays
All modules maintain cycle-accurate pipeline delays matching the Verilog:
- `phase.m`: 40 cycles (2 + 36 division + 2 LUT)
- `rotate.m`: 8 cycles (4 phase mapping + 4 multiplication)
- `complex_mult.m`: 5 cycles
- `divider.m`: 36 cycles
- `calc_mean.m`: 3 cycles

### 2. Fixed-Point Scaling
MATLAB functions use the same scaling factors as Verilog:
- **ATAN_LUT_SCALE_SHIFT** = 9 (phase scaled by 512)
- **ROTATE_LUT_SCALE_SHIFT** = 11 (rotation values scaled by 2048)
- **CONS_SCALE_SHIFT** = 10 (constellation values scaled by 1024)

### 3. State Management
All stateful modules return and accept a `state` structure:
```matlab
% Initialize once
state = module_init();

% Use in loop
for i = 1:N
    [output, state] = module(input, state);
end
```

### 4. Bit Accuracy
- All arithmetic matches Verilog bit-widths (16-bit, 32-bit)
- Lookup tables use same quantization
- CRC polynomials match IEEE 802.11 exactly

---

## Testing Strategy

### Unit Testing
Test each module independently:
```matlab
% Test phase module
state = phase_init();
for test_case = test_vectors
    [phase_out, state] = phase(test_case.i, test_case.q, state);
    assert(abs(phase_out - test_case.expected) < tolerance);
end
```

### Integration Testing
Test module combinations:
```matlab
% Test rotate-after-phase
phase_state = phase_init();
rotate_state = rotate_init();

[phase_val, phase_state] = phase(pilot_i, pilot_q, phase_state);
[rot_i, rot_q, rotate_state] = rotate(data_i, data_q, -phase_val, rotate_state);
```

### System Testing
Test complete equalizer:
```matlab
% Full equalization test
state = equalizer_init();
% Feed LTS and data
% Compare with expected constellation
```

---

## Known Differences from Verilog

1. **Simplified equalizer.m**: Uses simplified helper functions for phase/rotate/divider at bottom of file for standalone operation. Use actual module files for full accuracy.

2. **CRC32 bit ordering**: MATLAB implementation uses standard bit-reversed CRC-32. Verify against expected FCS = 0xC704DD7B.

3. **RAM timing**: MATLAB `ram_2port.m` has 1-cycle read latency. Verilog may have additional setup/hold requirements.

---

## Contact

For questions about specific modules, refer to the inline comments in each `.m` file which include detailed algorithm explanations and usage examples.

Generated: January 2026
Verilog Source: /home/fatih/openofdm/verilog/
