# MATLAB Testing Guide - OpenOFDM Module Validation

## Complete Testing Instructions for All Modules

This guide explains how to use all the test files we created for validating the MATLAB modules against Verilog implementations.

---

## 📁 Directory Structure

```
matlab_validation/
├── part1_phase_rotation/          # Phase rotation modules
│   ├── delayT.m
│   ├── complex_mult.m
│   ├── divider.m
│   ├── atan_lut.m
│   ├── rot_lut.m
│   ├── phase.m
│   └── rotate.m
│
├── part2_equalizer/               # Equalizer modules
│   ├── calc_mean.m
│   ├── ram_2port.m
│   └── equalizer.m
│
├── part3_signal_decode/           # Signal decode modules
│   ├── ht_sig_crc.m
│   ├── crc32.m
│   ├── qbpsk_derotate.m
│   ├── signal_decode.m
│   ├── ht_detect.m
│   └── ht_sig_decode.m
│
├── individual_tests/              # Standalone module tests
│   ├── test_delayT_standalone.m
│   ├── test_complex_mult_standalone.m
│   ├── test_divider_standalone.m
│   ├── test_atan_lut_standalone.m
│   ├── test_rot_lut_standalone.m
│   ├── test_calc_mean_standalone.m
│   ├── test_ram_2port_standalone.m
│   ├── test_equalizer_integration.m
│   ├── test_ht_sig_crc_standalone.m
│   ├── test_crc32_standalone.m
│   ├── test_qbpsk_derotate_standalone.m
│   └── README.md
│
├── block_tests/                   # Block integration tests
│   ├── phase_rotation_block.m
│   ├── test_phase_rotation_block.m
│   ├── equalizer_block.m
│   ├── test_equalizer_block.m
│   ├── signal_decode_block.m
│   ├── ht_sig_decode_block.m
│   └── test_signal_ht_sig_block.m
│
├── test_all_modules.m             # Run all tests
├── test_phase_rotation.m          # Detailed phase tests
├── test_signal_decode.m           # Detailed decode tests
├── README.md                      # Project overview
├── PROJECT_REPORT.md              # Comprehensive report
├── MODULE_REFERENCE.m             # Quick reference
└── TESTING_GUIDE.md               # Testing instructions
```

---

## 🎯 Testing Philosophy: Bottom-Up Approach

We test in **3 levels**:

```
Level 0: Unit Tests          → Test each module alone
Level 1: Module Tests        → Test modules with dependencies
Level 2: Block Tests         → Test complete functional blocks
Level 3: System Tests        → Test integrated system
```

---

## 📋 STEP-BY-STEP TESTING PROCEDURE

### **PHASE 1: Environment Setup**

#### Step 1.1: Navigate to workspace
```matlab
cd /home/fatih/openofdm/matlab_validation
```

#### Step 1.2: Verify directory structure
```matlab
% Check if all directories exist
assert(exist('part1_phase_rotation', 'dir') == 7, 'Missing part1 directory');
assert(exist('part2_equalizer', 'dir') == 7, 'Missing part2 directory');
assert(exist('part3_signal_decode', 'dir') == 7, 'Missing part3 directory');
assert(exist('individual_tests', 'dir') == 7, 'Missing individual_tests directory');
assert(exist('block_tests', 'dir') == 7, 'Missing block_tests directory');

fprintf('✓ All directories found\n');
```

#### Step 1.3: Clear workspace
```matlab
clear all;
close all;
clc;
```

---

### **PHASE 2: Level 0 Tests - Standalone Modules**

**Purpose:** Verify each module works independently with NO dependencies

#### Step 2.1: Test Phase Rotation Modules (Part 1)

```matlab
cd individual_tests

% Test in order (simple → complex)
fprintf('=== Testing Phase Rotation Modules ===\n\n');

% 1. Delay (simplest - shift register)
test_delayT_standalone
pause(1);

% 2. ROMs (lookup tables)
test_atan_lut_standalone
pause(1);
test_rot_lut_standalone
pause(1);

% 3. Arithmetic operations
test_complex_mult_standalone
pause(1);
test_divider_standalone
pause(1);
```

**Expected Results:**
- All tests should show "✓ PASS"
- No dependencies required
- Each module validates its core functionality

#### Step 2.2: Test Equalizer Modules (Part 2)

```matlab
fprintf('\n=== Testing Equalizer Modules ===\n\n');

% 1. Mean calculation
test_calc_mean_standalone
pause(1);

% 2. Dual-port RAM
test_ram_2port_standalone
pause(1);
```

**Expected Results:**
- calc_mean: Validates signed averaging with 3-cycle pipeline
- ram_2port: Validates read/write operations, 64 locations

#### Step 2.3: Test Signal Decode Modules (Part 3)

```matlab
fprintf('\n=== Testing Signal Decode Modules ===\n\n');

% 1. CRC functions
test_ht_sig_crc_standalone
pause(1);
test_crc32_standalone
pause(1);

% 2. Q-BPSK derotation
test_qbpsk_derotate_standalone
pause(1);
```

**Expected Results:**
- CRC tests validate error detection
- Q-BPSK validates rotation for odd/even indices

---

### **PHASE 3: Level 1 Tests - Module Integration**

**Purpose:** Test modules that use Level 0 modules as dependencies

#### Step 3.1: Test Equalizer Integration

```matlab
fprintf('\n=== Testing Equalizer Integration ===\n\n');

test_equalizer_integration
pause(1);
```

**Expected Results:**
- Validates 6-state FSM (IDLE → STORE_LTS1 → STORE_LTS2 → CALC_CSI → WAIT → EQUALIZE)
- Uses calc_mean and ram_2port internally

---

### **PHASE 4: Level 2 Tests - Complete Blocks**

**Purpose:** Test complete functional subsystems working together

#### Step 4.1: Test Phase Rotation Block

```matlab
cd ../block_tests

fprintf('\n=== Testing Phase Rotation Block ===\n\n');

% Complete phase correction pipeline:
% Input OFDM Symbol → Extract Pilots → Calculate Phase → Rotate Data → Output
test_phase_rotation_block
pause(2);
```

**Expected Results:**
- Combines phase.m + rotate.m (plus their dependencies)
- Tests complete frequency offset correction
- Shows before/after constellation plots
- Improvement should be > 10 dB

**What to observe:**
- Figure 1: Three plots showing before correction, after correction, and error reduction
- Console output: Average Q error before/after
- Improvement in dB

#### Step 4.2: Test Equalizer Block

```matlab
fprintf('\n=== Testing Equalizer Block ===\n\n');

% Complete channel estimation and equalization:
% LTS1 + LTS2 → Calculate CSI → Equalize Data → Output
test_equalizer_block
pause(2);
```

**Expected Results:**
- Complete CSI estimation from two LTS symbols
- Data equalization using CSI
- Channel estimation plot
- Before/after constellation comparison
- EVM calculation

**What to observe:**
- Figure: Three subplots
  1. Channel estimation quality
  2. Received constellation (distorted)
  3. Equalized constellation (corrected)
- Console: CSI magnitude, number of outputs, EVM

#### Step 4.3: Test SIGNAL/HT-SIG Decode Blocks

```matlab
fprintf('\n=== Testing SIGNAL & HT-SIG Decode ===\n\n');

% Complete signal field decoding:
% SIGNAL:  48 BPSK → Decode → Rate + Length
% HT-SIG:  96 Q-BPSK → Derotate → Decode → MCS + Length + BW
test_signal_ht_sig_block
pause(2);
```

**Expected Results:**
- SIGNAL field: Decodes rate (6-54 Mbps) and length
- HT-SIG field: Decodes MCS (0-31), bandwidth (20/40 MHz), length
- CRC validation
- Constellation plots (BPSK, Q-BPSK, derotated)

**What to observe:**
- Multiple test cases with different rates/MCS
- Figure: Three constellation plots
  1. BPSK (SIGNAL)
  2. Q-BPSK (HT-SIG before derotation)
  3. After Q-BPSK derotation
- Decoding success rates

---

### **PHASE 5: Comprehensive Testing**

#### Step 5.1: Run All Module Tests

```matlab
cd ..  % Back to matlab_validation/

fprintf('\n=== Running Complete Test Suite ===\n\n');

% This runs all 15+ tests systematically
test_all_modules
```

**Expected Results:**
- Comprehensive test of all modules
- Summary of pass/fail for each module
- Total test count and success rate

#### Step 5.2: Detailed Phase Rotation Analysis

```matlab
fprintf('\n=== Detailed Phase Rotation Analysis ===\n\n');

test_phase_rotation
```

**Expected Results:**
- Accuracy tests for atan_lut and rot_lut
- Phase calculation with various offsets
- Rotation accuracy validation
- Multiple figures with error analysis

#### Step 5.3: Detailed Signal Decode Analysis

```matlab
fprintf('\n=== Detailed Signal Decode Analysis ===\n\n');

test_signal_decode
```

**Expected Results:**
- Q-BPSK derotation validation
- SIGNAL field decode tests
- HT-SIG field decode tests
- Constellation diagrams

---

## 🔍 USAGE ORDER SUMMARY

### **Order 1: Quick Validation** (5 minutes)
For quick sanity check of all modules:

```matlab
cd /home/fatih/openofdm/matlab_validation
test_all_modules
```

### **Order 2: Systematic Validation** (15 minutes)
For thorough module-by-module validation:

```matlab
cd /home/fatih/openofdm/matlab_validation/individual_tests

% Part 1: Phase Rotation (5 standalone tests)
test_delayT_standalone
test_atan_lut_standalone
test_rot_lut_standalone
test_complex_mult_standalone
test_divider_standalone

% Part 2: Equalizer (3 tests)
test_calc_mean_standalone
test_ram_2port_standalone
test_equalizer_integration

% Part 3: Signal Decode (3 standalone tests)
test_ht_sig_crc_standalone
test_crc32_standalone
test_qbpsk_derotate_standalone

cd ../block_tests

% Block tests (3 comprehensive tests)
test_phase_rotation_block
test_equalizer_block
test_signal_ht_sig_block
```

### **Order 3: Block Testing Only** (10 minutes)
For testing complete functional blocks:

```matlab
cd /home/fatih/openofdm/matlab_validation/block_tests

test_phase_rotation_block      % FFT + Phase Rotation
test_equalizer_block           % CSI Estimation + Equalization
test_signal_ht_sig_block       % SIGNAL + HT-SIG Decoding
```

### **Order 4: Your Specific Work** (5 minutes)
For testing only your assigned modules:

```matlab
cd /home/fatih/openofdm/matlab_validation/block_tests

% If you're responsible for Phase Rotation:
test_phase_rotation_block

% If you're responsible for Equalizer:
test_equalizer_block

% If you're responsible for SIGNAL/HT-SIG Decode:
test_signal_ht_sig_block
```

---

## ✅ WHAT TO CHECK IN EACH TEST

### **Standalone Tests:**
- [ ] All tests show "✓ PASS"
- [ ] No errors or warnings
- [ ] Output values are reasonable
- [ ] Module characteristics printed correctly

### **Block Tests:**
- [ ] Figures generated without errors
- [ ] Constellation plots look correct
- [ ] Error metrics (EVM, dB improvement) are reasonable
- [ ] Decode results match expected values
- [ ] No "✗ FAIL" messages

---

## 🚨 TROUBLESHOOTING

### Problem: "Undefined function or variable"
**Solution:**
```matlab
% Check you're in the right directory
pwd

% Add paths manually
addpath('part1_phase_rotation');
addpath('part2_equalizer');
addpath('part3_signal_decode');
addpath('individual_tests');
addpath('block_tests');
```

### Problem: "Index exceeds array bounds"
**Solution:**
```matlab
% Clear all variables and restart
clear all;
close all;
clc;

% Run test again
```

### Problem: Figures not displaying
**Solution:**
```matlab
% Check figure visibility
set(0, 'DefaultFigureVisible', 'on');

% Or manually open figures
figure(1);
```

### Problem: Test shows "WARN" instead of "PASS"
**Explanation:**
- "WARN" means approximate results due to fixed-point arithmetic
- This is expected in some cases (e.g., phase rotation with noise)
- Not a failure, just indicates precision limitations

---

## 📊 EXPECTED TEST RESULTS

### **All Tests Pass:**
```
========================================
  Testing: delayT (STANDALONE)
========================================
✓ PASS: Delay of 5 cycles works correctly
✓ PASS: Delay of 3 cycles works correctly
✓ PASS: State persistence works
========================================
  delayT module: ALL TESTS COMPLETE
========================================
```

### **Typical Test Output:**
```
Test 1: Phase correction working (Avg Q error: 45.3)
  ✓ PASS: Phase correction working

Test 2: Multiple symbols (Improvement: 15.2 dB)
  ✓ PASS: Significant improvement (>10 dB)

Figure generated: Before/After comparison
```

---

## 📝 TESTING CHECKLIST

Before you start:
- [ ] MATLAB R2019b or later installed
- [ ] All module files present in part1/, part2/, part3/
- [ ] All test files present in individual_tests/ and block_tests/
- [ ] Working directory is `/home/fatih/openofdm/matlab_validation`

After each phase:
- [ ] Record any failures or warnings
- [ ] Save figures if needed (`saveas(gcf, 'test_result.png')`)
- [ ] Document unexpected behavior

Final validation:
- [ ] All standalone tests pass
- [ ] All block tests generate correct figures
- [ ] Decode results match expected values
- [ ] No critical errors

---

## 🎓 UNDERSTANDING TEST LEVELS

**Level 0 (Standalone):**
- Tests ONE module in isolation
- NO dependencies on other modules
- Fast execution (< 5 seconds each)
- Focus: Core functionality

**Level 1 (Module Integration):**
- Tests modules that use Level 0 modules
- Example: `phase.m` uses `divider.m`
- Medium execution (5-15 seconds)
- Focus: Module interaction

**Level 2 (Block Integration):**
- Tests complete functional blocks
- Multiple modules working together
- Longer execution (15-30 seconds)
- Focus: System behavior
- Generates visualization

**Level 3 (System):**
- Complete end-to-end testing
- All blocks working together
- Longest execution (> 1 minute)
- Focus: Full system validation

---

## 🚀 READY TO START

You now have everything needed to test the MATLAB modules!

**Recommended First Steps:**

1. **Quick check** (1 minute):
   ```matlab
   cd /home/fatih/openofdm/matlab_validation/individual_tests
   test_delayT_standalone
   ```

2. **Full validation** (15 minutes):
   ```matlab
   cd /home/fatih/openofdm/matlab_validation
   test_all_modules
   ```

3. **Your specific work** (5 minutes):
   ```matlab
   cd /home/fatih/openofdm/matlab_validation/block_tests
   test_phase_rotation_block      % Your assigned block
   ```

---

## 📞 NEXT STEPS

**After successful testing:**
1. Document any issues found
2. Compare MATLAB results with Verilog simulation
3. Verify fixed-point scaling matches
4. Validate pipeline depths
5. Check cycle-accurate behavior

**For Verilog comparison:**
1. Run corresponding Verilog testbench
2. Export Verilog simulation data
3. Load into MATLAB and compare
4. Check bit-accurate matching

---

**Ready to proceed! Awaiting your order to continue...**
