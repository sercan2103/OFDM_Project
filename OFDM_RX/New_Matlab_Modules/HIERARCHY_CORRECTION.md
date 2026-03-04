# Module Hierarchy Correction

## Problem
Initially, `ofdm_decoder.m` was incorrectly implemented as the top-level module, but it should be a decoder wrapper containing 5 sub-modules.

## Solution
Corrected the hierarchy to match Verilog structure:

### Verilog Hierarchy
```
dot11.v (TOP-LEVEL)
├── power_trigger
├── sync_short
├── sync_long
├── equalizer
├── ofdm_decoder.v (WRAPPER)
│   ├── demodulate
│   ├── deinterleave
│   ├── viterbi
│   ├── descramble
│   └── bits_to_bytes
└── crc32
```

### MATLAB Hierarchy (Corrected)
```
dot11.m (TOP-LEVEL) ✓
├── power_trigger.m
├── sync_short.m
├── sync_long.m
├── equalizer.m
├── ofdm_decoder.m (WRAPPER) ✓
│   ├── demodulate.m
│   ├── deinterleave.m
│   ├── viterbi_decode.m
│   ├── descramble.m
│   └── bits_to_bytes.m
└── crc32.m
```

## Files Modified

### 1. ofdm_decoder.m
**Changed from:** Top-level orchestrator with all pipeline stages  
**Changed to:** Decoder wrapper containing only 5 decoder sub-modules

**New interface:**
```matlab
function [byte_out, byte_valid, demod_out, deinter_out, viterbi_out, descram_out] = ...
    ofdm_decoder(eq_i, eq_q, eq_strobe, rate, do_descramble, reset)
```

**Purpose:** Wraps the decoder pipeline:
- Takes equalized symbols as input (from equalizer)
- Outputs decoded bytes
- Provides debug outputs for each stage

### 2. dot11.m (NEW)
**Created:** Top-level receiver module

**Interface:**
```matlab
function [byte_out, byte_valid, fcs_ok, pkt_info, debug_signals] = ...
    dot11(sample_i, sample_q, sample_strobe, enable, reset, params)
```

**Purpose:** Complete receiver orchestration:
- Takes raw I/Q samples as input
- Manages state machine for packet detection/decoding
- Coordinates all pipeline stages
- Outputs decoded bytes and FCS result
- Provides packet info and debug signals

**State machine:**
- IDLE → POWER_TRIGGER → SYNC_SHORT → SYNC_LONG → DECODE_SIGNAL → DECODE_DATA → CHECK_FCS

### 3. Documentation Updates
- **README.md:** Updated module categories and hierarchy
- **CONVERSION_SUMMARY.md:** 
  - Added module hierarchy diagram
  - Corrected file counts (now 35 files, was 34)
  - Updated directory structure
  - Added Top-Level Module category

### 4. Test Script Updates
- **run_matlab_simulation.m:** 
  - Now uses `dot11.m` as top-level
  - Updated to show module hierarchy in output
  - Improved sample processing and output display

## Key Differences

| Aspect | ofdm_decoder.m | dot11.m |
|--------|----------------|---------|
| **Level** | Mid-level wrapper | Top-level |
| **Input** | Equalized symbols (48 subcarriers) | Raw I/Q samples |
| **Contains** | 5 decoder modules | 7 pipeline modules + decoder |
| **State Machine** | No | Yes (6 states) |
| **Manages** | Decoder pipeline only | Full receiver |
| **Verilog equivalent** | ofdm_decoder.v | dot11.v |

## Benefits

1. **Correct hierarchy:** Matches Verilog module structure exactly
2. **Modularity:** Each module has clear responsibility
3. **Testability:** Can test decoder separately from sync/equalizer stages
4. **Maintainability:** Easier to understand and debug
5. **Reusability:** ofdm_decoder can be used independently

## Usage Examples

### Using dot11.m (Top-Level)
```matlab
% Initialize
params = struct('power_thres', 200000, 'power_window', 16, 'min_plateau', 100);
dot11(0, 0, 0, 0, 1, params); % Reset

% Process samples
for k = 1:num_samples
    [byte, byte_valid, fcs_ok, pkt_info, debug] = ...
        dot11(sample_i(k), sample_q(k), 1, 1, 0, params);
    
    if byte_valid
        fprintf('Byte: 0x%02X\n', byte);
    end
end
```

### Using ofdm_decoder.m (Decoder Only)
```matlab
% Initialize
ofdm_decoder(zeros(48,1,'int16'), zeros(48,1,'int16'), 0, 6, 1, 1); % Reset

% Process equalized symbols (from equalizer output)
[byte, byte_valid, ~, ~, ~, ~] = ...
    ofdm_decoder(eq_i, eq_q, eq_strobe, rate, do_descramble, 0);
```

## Verification

Total module count: **26 MATLAB modules** (was 25)
- 1 top-level (dot11.m) ← NEW
- 6 main pipeline (power_trigger, sync_short, sync_long, equalizer, ofdm_decoder, crc32)
- 5 decoder sub-modules (demodulate, deinterleave, viterbi, descramble, bits_to_bytes)
- 11 basic modules
- 3 LUT loaders

This now correctly mirrors the Verilog implementation! ✓

---
*Correction made: March 3, 2026*
*Issue reported by: User*
