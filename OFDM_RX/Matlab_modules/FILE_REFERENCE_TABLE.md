# File Reference Table - OpenOFDM MATLAB Validation

## Quick Reference: What Each File Does

---

## 📦 PART 1: Phase Rotation Modules (7 files)

| File | Type | Purpose | Dependencies |
|------|------|---------|--------------|
| `delayT.m` | Module | Shift register delay (T clock cycles) | None |
| `complex_mult.m` | Module | Complex multiplication (5-cycle pipeline) | None |
| `divider.m` | Module | Integer division (36-cycle pipeline) | None |
| `atan_lut.m` | Module | Arctangent ROM lookup (256 entries) | None |
| `rot_lut.m` | Module | Rotation ROM lookup (512 entries) | None |
| `phase.m` | Module | Phase calculation from I/Q (40-cycle pipeline) | divider, atan_lut |
| `rotate.m` | Module | Sample rotation by phase (8-cycle pipeline) | rot_lut, complex_mult |

---

## 📦 PART 2: Equalizer Modules (3 files)

| File | Type | Purpose | Dependencies |
|------|------|---------|--------------|
| `calc_mean.m` | Module | Signed mean of 4 values (3-cycle pipeline) | None |
| `ram_2port.m` | Module | Dual-port RAM (64 locations, 16-bit data) | None |
| `equalizer.m` | Module | 6-state FSM: CSI estimation + equalization | calc_mean, ram_2port (6x) |

---

## 📦 PART 3: SIGNAL/HT-SIG Decode Modules (6 files)

| File | Type | Purpose | Dependencies |
|------|------|---------|--------------|
| `ht_sig_crc.m` | Module | CRC-8 for HT-SIG validation | None |
| `crc32.m` | Module | CRC-32 for FCS (Frame Check Sequence) | None |
| `qbpsk_derotate.m` | Module | Q-BPSK to BPSK conversion (rotation) | None |
| `signal_decode.m` | Module | SIGNAL field decoder (Rate + Length) | None |
| `ht_detect.m` | Module | HT vs Legacy packet detection | None |
| `ht_sig_decode.m` | Module | HT-SIG decoder (MCS + BW + Length) | ht_sig_crc |

---

## 🧪 Individual Standalone Tests (11 files)

| File | Tests What | Level | Time |
|------|-----------|-------|------|
| `test_delayT_standalone.m` | Shift register delay | 0 | ~5s |
| `test_complex_mult_standalone.m` | Complex multiplication | 0 | ~5s |
| `test_divider_standalone.m` | Integer division | 0 | ~10s |
| `test_atan_lut_standalone.m` | Arctangent ROM | 0 | ~5s |
| `test_rot_lut_standalone.m` | Rotation ROM | 0 | ~5s |
| `test_calc_mean_standalone.m` | Signed mean calculation | 0 | ~5s |
| `test_ram_2port_standalone.m` | Dual-port RAM operations | 0 | ~10s |
| `test_equalizer_integration.m` | Equalizer state machine | 1 | ~15s |
| `test_ht_sig_crc_standalone.m` | CRC-8 validation | 0 | ~5s |
| `test_crc32_standalone.m` | CRC-32 validation | 0 | ~5s |
| `test_qbpsk_derotate_standalone.m` | Q-BPSK rotation | 0 | ~5s |

---

## 🎯 Block Integration Tests (6 files)

| File | Type | Tests What | Output |
|------|------|-----------|--------|
| `phase_rotation_block.m` | Function | Complete phase correction pipeline | Corrected data |
| `test_phase_rotation_block.m` | Test | FFT + Phase Rotation as one block | 3 plots + metrics |
| `equalizer_block.m` | Function | Complete CSI estimation + equalization | Equalized data |
| `test_equalizer_block.m` | Test | Channel estimation + data equalization | 3 plots + EVM |
| `signal_decode_block.m` | Function | SIGNAL field decode (48 BPSK → Rate/Length) | Rate + Length |
| `ht_sig_decode_block.m` | Function | HT-SIG decode (96 Q-BPSK → MCS/BW/Length) | MCS + BW + Length |
| `test_signal_ht_sig_block.m` | Test | Complete SIGNAL + HT-SIG decoding | 3 plots + decode results |

---

## 📚 Comprehensive Test Suites (3 files)

| File | Purpose | Coverage | Time |
|------|---------|----------|------|
| `test_all_modules.m` | Run all 15+ tests systematically | All modules | ~2 min |
| `test_phase_rotation.m` | Detailed phase/rotation analysis | Part 1 modules | ~30s |
| `test_signal_decode.m` | Detailed signal decode analysis | Part 3 modules | ~30s |

---

## 📖 Documentation Files (5 files)

| File | Type | Content | Audience |
|------|------|---------|----------|
| `README.md` | Overview | Project introduction, structure, usage | All users |
| `PROJECT_REPORT.md` | Report | 10-section comprehensive documentation | Technical review |
| `MODULE_REFERENCE.m` | Reference | Quick API reference with examples | Developers |
| `TESTING_GUIDE.md` | Guide | Testing methodology and troubleshooting | Testers |
| `USAGE_GUIDE.md` | Guide | Step-by-step usage instructions | New users |

---

## 📊 Summary Statistics

| Category | Count | Purpose |
|----------|-------|---------|
| **Module Implementations** | 16 | Core MATLAB functions matching Verilog |
| **Standalone Tests** | 11 | Test individual modules (no dependencies) |
| **Integration Tests** | 6 | Test complete functional blocks |
| **Test Suites** | 3 | Comprehensive testing scripts |
| **Documentation** | 5 | Guides, references, and reports |
| **TOTAL FILES** | 41 | Complete validation framework |

---

## 🎯 File Selection by Use Case

### **"I want to test ONE module"**
→ Use `individual_tests/test_*_standalone.m`

### **"I want to test my complete block"**
→ Use `block_tests/test_*_block.m`

### **"I want to test EVERYTHING"**
→ Use `test_all_modules.m`

### **"I need to understand a module"**
→ Read `MODULE_REFERENCE.m`

### **"I need step-by-step instructions"**
→ Read `USAGE_GUIDE.md`

### **"I need to report results"**
→ Use `PROJECT_REPORT.md` as template

---

## 🔍 Test Level Guide

| Level | Files | Dependencies | Purpose |
|-------|-------|--------------|---------|
| **Level 0** | 10 standalone tests | None | Unit testing |
| **Level 1** | 1 integration test | Uses Level 0 | Module interaction |
| **Level 2** | 6 block tests | Uses Level 0+1 | System behavior |
| **Level 3** | 3 comprehensive tests | All modules | Full validation |

---

## ⚡ Quick Start Commands

```matlab
% Test one module (5 seconds)
cd matlab_validation/individual_tests
test_delayT_standalone

% Test your block (30 seconds)
cd matlab_validation/block_tests
test_phase_rotation_block

% Test everything (2 minutes)
cd matlab_validation
test_all_modules
```

---

**Total: 41 files for complete MATLAB validation of Verilog modules** ✅
