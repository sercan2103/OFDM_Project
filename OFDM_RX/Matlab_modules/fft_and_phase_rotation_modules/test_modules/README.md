# Individual Module Testing and Block Integration Guide

This directory contains standalone tests for individual modules and block-level integration tests.

## Directory Structure

```
matlab_validation/
├── individual_tests/          # Standalone tests (NO dependencies)
│   ├── test_delayT_standalone.m
│   ├── test_complex_mult_standalone.m
│   ├── test_divider_standalone.m
│   ├── test_atan_lut_standalone.m
│   ├── test_rot_lut_standalone.m
│   └── ...
│
├── block_tests/               # Integration tests (Combined modules)
│   ├── phase_rotation_block.m           # FFT + Phase Rotation block
│   ├── test_phase_rotation_block.m      # Test for above
│   └── ...
│
├── part1_phase_rotation/      # Module implementations
├── part2_equalizer/
├── part3_signal_decode/
└── test_all_modules.m         # Run all tests
```

---

## Part 1: Testing Individual Modules (Standalone)

### What is "Standalone"?

**Standalone** means the module can be tested **without needing any other custom modules**. Only MATLAB built-in functions are used.

### Level 0 Modules (Truly Independent)

These have **NO dependencies**:

```matlab
cd matlab_validation/individual_tests

% Test each module independently
test_delayT_standalone          % Shift register
test_complex_mult_standalone    % Complex multiplication
test_divider_standalone         % Integer division
test_atan_lut_standalone       % Arctangent ROM
test_rot_lut_standalone        % Rotation ROM
```

### Example: Testing divider Alone

```matlab
>> cd individual_tests
>> test_divider_standalone

========================================
  Testing: divider (STANDALONE)
========================================

Test 1: 1000 / 25 = 40 ✓ PASS
Test 2: 2048 / 2 = 1024 ✓ PASS
Test 3: 500 / 10 = 50 ✓ PASS
...
Results: 8 passed, 0 failed
========================================
```

---

## Part 2: Testing Module Combinations (Block-Level)

### What is "Block-Level Testing"?

**Block-Level Testing** means testing multiple modules together as one functional unit, simulating real system operation.

### Example: Phase Rotation Block

The **Phase Rotation Block** combines:
- `phase.m` (calculates phase offset from pilots)
- `rotate.m` (rotates data to correct offset)
- Plus their dependencies: `divider`, `atan_lut`, `rot_lut`, `complex_mult`

```matlab
cd block_tests

% Test the complete phase rotation pipeline
test_phase_rotation_block

% This simulates:
% Input OFDM Symbol → Extract Pilots → Calculate Phase → Rotate Data → Output
```

### How It Works

```matlab
%% In your test script:

% 1. Create OFDM symbol with known phase error
ofdm_symbol = generate_symbol_with_phase_error(30);  % 30 degrees

% 2. Call the complete block
[corrected_data, phase_offset] = phase_rotation_block(ofdm_symbol, ...
                                                        pilot_indices, ...
                                                        expected_pilots);

% 3. Verify correction
assert(mean(abs(corrected_data(:,2))) < threshold);
```

---

## Part 3: Creating Your Own Block Tests

### Template for Block Integration

```matlab
%% my_custom_block.m
function output = my_custom_block(input)
    % Combine multiple modules into one functional block
    
    persistent module1_state module2_state
    
    if isempty(module1_state)
        module1_state = module1_init();
        module2_state = module2_init();
    end
    
    % Step 1: Process with first module
    [intermediate, module1_state] = module1(input, module1_state);
    
    % Step 2: Process with second module
    [output, module2_state] = module2(intermediate, module2_state);
end
```

### Example: Custom Equalizer Block

```matlab
%% equalizer_block.m
function [equalized_data] = equalizer_block(lts_symbols, data_symbol)
    % Combines: calc_mean + phase + rotate + complex_mult + divider
    
    % 1. Average two LTS symbols (CSI estimation)
    csi = estimate_channel(lts_symbols);
    
    % 2. Calculate residual frequency offset
    phase_offset = calculate_pilot_phase(data_symbol);
    
    % 3. Rotate and equalize
    equalized_data = rotate_and_divide(data_symbol, csi, phase_offset);
end
```

---

## Dependency Levels Summary

```
Level 0 (Independent):          Level 1 (Uses Level 0):        Level 2 (Integration):
┌──────────────┐               ┌──────────────┐               ┌──────────────┐
│ delayT       │               │ phase        │               │ equalizer    │
│ complex_mult │    →  Used by │  └uses:      │    →  Used by │  └uses:      │
│ divider      │               │   - divider  │               │   - phase    │
│ atan_lut     │               │   - atan_lut │               │   - rotate   │
│ rot_lut      │               │              │               │   - calc_mean│
│ calc_mean    │               │ rotate       │               │   - etc...   │
└──────────────┘               │  └uses:      │               └──────────────┘
                               │   - rot_lut  │
                               │   - cmplx_mul│
                               └──────────────┘
```

---

## Testing Strategy

### Strategy 1: Bottom-Up (Recommended)

Test from simple to complex:

1. **Test Level 0 modules** (standalone)
   ```matlab
   test_divider_standalone
   test_complex_mult_standalone
   ```

2. **Test Level 1 modules** (uses Level 0)
   ```matlab
   test_phase_only
   test_rotate_only
   ```

3. **Test Level 2 blocks** (integration)
   ```matlab
   test_phase_rotation_block
   test_equalizer_block
   ```

### Strategy 2: Top-Down

Test system first, debug downward:

1. Test complete system → **fails**
2. Test subsystems (blocks) → **find which block fails**
3. Test individual modules → **find which module has bug**

### Strategy 3: Your Specific Need

**Test only your work** (Phase Rotation):

```matlab
cd block_tests
test_phase_rotation_block

% This tests YOUR complete subsystem:
% - FFT (if you add it)
% - Phase calculation
% - Rotation correction
% As ONE unit
```

---

## Practical Examples

### Example 1: Test Just Your Module

```matlab
% I only want to test the divider module
cd individual_tests
test_divider_standalone

% No other modules loaded or tested!
```

### Example 2: Test Your Block

```matlab
% I want to test Phase Rotation as one complete block
cd block_tests
test_phase_rotation_block

% This tests phase + rotate together
% (They're designed to work together)
```

### Example 3: Create Custom Test

```matlab
% I want to test a specific scenario
cd block_tests

% Create my_test.m:
clear all;
addpath('../part1_phase_rotation');

% Test my specific case
input_data = load('my_test_data.mat');
output = phase_rotation_block(input_data, ...);

% Verify against my expected results
assert(output_matches_expected);
```

---

## Key Takeaways

### ✅ YES - You CAN test modules independently!

1. **Level 0 modules** = **100% independent**
   - No dependencies at all
   - Test with zero setup

2. **Level 1 modules** = **Independent from peers**
   - `phase` doesn't need `rotate`
   - `rotate` doesn't need `phase`
   - Each only needs its Level 0 dependencies

3. **Block tests** = **Integration testing**
   - Test multiple modules as one unit
   - Simulates real system operation
   - Finds integration bugs

### 🎯 Answer to Your Question

**"Can I test FFT + Phase Rotation together?"**

**YES!** Use `phase_rotation_block.m`:

```matlab
cd block_tests
test_phase_rotation_block
```

This tests the **complete phase correction pipeline** as **ONE functional block**.

You're testing the **system behavior**, not individual modules!

---

## Next Steps

1. **Run standalone tests** to verify each module works
2. **Run block test** to verify they work together
3. **Create your own block tests** for your specific scenarios
4. **Compare with Verilog** once you're confident in MATLAB

Good luck! 🚀
