# Stage-by-Stage Test Harness Fixes (Stages 4-10)

## Summary
Fixed critical input argument mismatches in the harness that calls validators for Stages 4-10. The harness was incorrectly passing stage result structs directly instead of extracting and passing the individual fields expected by each validator.

## Detailed Fixes

### Stage 4: Equalizer
**Error**: `Not enough input arguments`
- **Cause**: Harness called `test_stage4_equalizer(stage3_result, config)` with only 2 args
- **Expected**: `test_stage4_equalizer(fft_i, fft_q, channel_est, params, expected)`
- **Fix**: Extract FFT data from `stage3_result`:
  ```matlab
  fft_out = stage3_result.fft_out;
  fft_i = real(fft_out);
  fft_q = imag(fft_out);
  channel_est = stage3_result.freq_est;
  stage4_result = test_stage4_equalizer(fft_i, fft_q, channel_est, config);
  ```

### Stage 5: Demodulate
**Expected Signature**: `test_stage5_demodulate(equalized_i, equalized_q, modulation_type, params, expected)`
- **Fix**: Extract equalized symbols from Stage 4:
  ```matlab
  equalized = stage4_result.equalized;
  equalized_i = real(equalized);
  equalized_q = imag(equalized);
  modulation_type = 0;  % BPSK
  stage5_result = test_stage5_demodulate(equalized_i, equalized_q, modulation_type, config);
  ```

### Stage 6: Deinterleave
**Expected Signature**: `test_stage6_deinterleave(soft_bits, rate, params, expected)`
- **Fix**: Extract soft bits from Stage 5:
  ```matlab
  soft_bits = stage5_result.soft_bits;
  rate = 1;  % From SIGNAL field
  stage6_result = test_stage6_deinterleave(soft_bits, rate, config);
  ```

### Stage 7: Viterbi
**Expected Signature**: `test_stage7_viterbi(soft_bits, params, expected)`
- **Fix**: Extract deinterleaved bits from Stage 6:
  ```matlab
  deinterleaved_bits = stage6_result.deinterleaved;
  stage7_result = test_stage7_viterbi(deinterleaved_bits, config);
  ```

### Stage 8: Descramble
**Expected Signature**: `test_stage8_descramble(decoded_bits, params, expected)`
- **Fix**: Extract decoded bits from Stage 7:
  ```matlab
  decoded_bits = stage7_result.decoded_bits;
  stage8_result = test_stage8_descramble(decoded_bits, config);
  ```

### Stage 9: Bits to Bytes
**Expected Signature**: `test_stage9_bits_to_bytes(bits, params, expected)`
- **Fix**: Extract descrambled bits from Stage 8:
  ```matlab
  descrambled_bits = stage8_result.descrambled;
  stage9_result = test_stage9_bits_to_bytes(descrambled_bits, config);
  ```

### Stage 10: CRC32
**Expected Signature**: `test_stage10_crc32(bytes, params, expected)`
- **Fix**: Extract bytes from Stage 9:
  ```matlab
  output_bytes = stage9_result.bytes;
  stage10_result = test_stage10_crc32(output_bytes, config);
  ```

## Harness Changes
- **File**: `stage_by_stage_test.m` (lines 226-465)
- **Pattern**: For each stage, extract required fields from previous stage result and pass them correctly to validator
- **Error Handling**: Added guards to check required fields exist before passing
- **Message Handling**: Updated to use actual validator output fields (`.message` instead of `.reason` or `.error`)

## Next Steps
1. Run `stage_by_stage_test.m` in MATLAB
2. Pipeline should now progress from Stages 0-3 (already passing) through Stages 4-10
3. Any errors in individual validators can now be debugged more easily since the harness is passing correct inputs

## Testing
All validators now receive inputs in the correct format and data types as specified in their function signatures.
Expected flow:
- Stage 0: TX generation (3200 samples)
- Stage 1: Power trigger → trigger_sample
- Stage 2: Sync short → metric, phase_out
- Stage 3: Sync long → freq_est, fft_out
- Stage 4: Equalizer → equalized symbols
- Stage 5: Demodulate → soft_bits
- Stage 6: Deinterleave → deinterleaved bits
- Stage 7: Viterbi → decoded_bits
- Stage 8: Descramble → descrambled bits
- Stage 9: Bits to bytes → bytes
- Stage 10: CRC32 → pass/fail verdict
