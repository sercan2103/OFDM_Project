# Fine Packet Offset vs Symbol Timing Estimator Comparison

## Executive Summary

The `compare_testers.m` script successfully compares two timing estimation approaches:

1. **Symbol Timing Estimator** (Custom Verilog-based Model)
2. **Fine Packet Offset** (Official MATLAB wlanSymbolTimingEstimate Wrapper)

### Key Finding

✅ **Official wlanSymbolTimingEstimate (Fine Packet Offset): CORRECT**
- Estimated Offset: **50 samples**
- Reference Offset: **50 samples**  
- Error: **0 samples** ✓

⚠️ **Symbol Timing Estimator: NEEDS REFINEMENT**
- Estimated Offset: **99 samples**
- Reference Offset: **50 samples**
- Error: **49 samples** ✗

---

## Test Configuration

```
SNR: 20.0 dB
Timing Offset (pre-samples): 50
Signal Length: 210 samples
Channel Model: AWGN (No multipath)
```

### Test Signal Structure

```
[50 pre-samples] + [64 LTS samples] + [generated payload]
      ↓                    ↓
   Position 0         Position 50 ← Correct Detection Point
```

---

## Performance Comparison Table

| Metric | Symbol Timing | Fine Packet Offset | Status |
|--------|---|---|---|
| **Detected** | YES | YES ✓ | ✓ PASS |
| **Estimated Offset** | 99 | 50 | ⚠️ FAIL |
| **Reference Offset** | 50 | 50 | ✓ PASS |
| **Estimation Error** | 49 samples | 0 samples | ✓ PASS (Fine) |
| **Execution Time** | 18.8 ms | 23.6 ms | ✓ Similar |
| **Peak Metric** | 29227963 | N/A | - |
| **Peak-to-Avg Ratio** | 5.16 dB | N/A | - |

---

## Detailed Analysis

### Symbol Timing Estimator

**Current Behavior:**
- Successfully detects the presence of the preamble
- Calculates correlation metrics with high peak-to-average ratio (5.16 dB)
- **Issue**: Timing offset estimation is off by 49 samples

**Root Cause Analysis:**
- The offset error of 49 samples suggests the estimator may be detecting a feature late in the LTS window
- Position 99 = Position 50 + 49 (approximately half the LTS length + pre-samples)
- Possible cause: Peak detection algorithm may be detecting maximum correlation near end of LTS rather than start

**Recommendation:**
- Review the peak detection logic in `symbol_timing_estimator.m` (lines 120-160)
- Verify the correlation window positioning matches IEEE 802.11 standard
- Consider adjusting the reference LTS timing or peak search algorithm

### Fine Packet Offset (wlanSymbolTimingEstimate)

**Current Behavior:**
- Returns exactly correct timing offset (50 samples)
- Successfully detects the packet start position
- Execution time comparable to symbol_timing_estimator

**Verification Status:**
- ✅ Returns correct offset (0 error)
- ✅ Detects signal presence (Detected = YES)
- ✅ Compatible with official MATLAB standard

---

## Validation Criterion

The comparison uses the acceptance criterion:
```
IF (offset_difference ≤ 2 samples) THEN PASS
ELSE FAIL (needs investigation)
```

**Current Result:**
```
Offset Difference: |99 - 50| = 49 samples
Status: FAIL - Needs refinement
```

---

## How to Run Comparison

```matlab
% Navigate to Symbol_Timing_Estimator/Simulink_test/ directory
cd Symbol_Timing_Estimator/Simulink_test

% Run comparison script
compare_testers

% Results automatically displayed and saved to workspace:
% >> comparison_results
```

### Output Files Generated

1. **Figures**: 4 comparison figures with matched layouts
   - Figure 1: Correlation Metrics
   - Figure 2: IQ Signal Components
   - Figure 3: Signal Magnitude + Offsets
   - Figure 4: Normalized Metrics

2. **Workspace Variable**: `comparison_results` struct containing:
   - `symbol_timing_estimator`: Full test results
   - `fine_packet_offset`: Full test results
   - `offset_difference`: Absolute difference
   - `pass_criterion`: Boolean (true if ≤ 2 samples)

---

## Files Involved

| File | Purpose | Status |
|------|---------|--------|
| `compare_testers.m` | Main comparison script | ✓ Running |
| `fine_packet_offset_fcn.m` | wlanSymbolTimingEstimate wrapper | ✓ Working |
| `fine_packet_offset_input_generator.m` | Test signal generation | ✓ Working |
| `fine_packet_offset_tester.m` | Fine packet offset test harness | ✓ Working |
| `symbol_timing_estimator.m` | Custom timing estimation | ⚠️ Needs refinement |
| `test_symbol_timing_estimator.m` | Direct symbol_timing test | ✓ Reference |

---

## Next Steps

1. **Investigate Symbol Timing Error**: Why is offset 49 samples late?
2. **Verify LTS Reference Values**: Confirm hardcoded LTS values match IEEE standard
3. **Test with Different SNR**: Run comparison at multiple SNR levels
4. **Test with Different Packet Lengths**: Verify scalability
5. **Compare with Alternative Algorithms**: Test against other timing estimation methods

---

## Technical Notes

### wlanSymbolTimingEstimate Integration

The `fine_packet_offset_fcn.m` wrapper provides a consistent interface:

```matlab
function offset = fine_packet_offset_fcn(rx, coarsePktOffset, simParams)
    % Extract preamble area
    cfgHT = wlanHTConfig('ChannelBandwidth', simParams.channelBandwidth);
    ind = wlanFieldIndices(cfgHT);
    preamble_area = rx(coarsePktOffset+1:coarsePktOffset+ind.LSIG(2), :);
    
    % Call official estimator
    finePktOffset = wlanSymbolTimingEstimate(preamble_area, cfgHT.ChannelBandwidth);
    
    % Return combined offset
    offset = coarsePktOffset + finePktOffset(1);
end
```

This ensures compatibility with:
- IEEE 802.11n/ac standards
- Official MATLAB toolbox specifications
- Standard WLAN field indices and preamble definitions

---

**Generated:** 2026-01-30  
**Test Version:** Compare Script v2.0  
**Platform:** MATLAB R2023+  
**Comparison Status:** ✓ COMPLETE with Findings
