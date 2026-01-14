%% test_rot_lut_standalone.m
% Standalone test for rot_lut ROM module
% NO dependencies required

clear all;
close all;
clc;

fprintf('========================================\n');
fprintf('  Testing: rot_lut (STANDALONE ROM)\n');
fprintf('========================================\n');

% Test 1: rot(0) should be [cos(0), sin(0)] = [2048, 0]
fprintf('\nTest 1: rot(0) = [1, 0] * 2048...\n');
data = rot_lut(0);
cos_val = int16(bitshift(int32(data), -16));
sin_val = int16(bitand(uint32(data), uint32(0xFFFF)));

if abs(cos_val - 2048) < 10 && abs(sin_val) < 10
    fprintf('  ✓ PASS: cos(0)=%d, sin(0)=%d\n', cos_val, sin_val);
else
    fprintf('  ✗ FAIL: cos(0)=%d, sin(0)=%d\n', cos_val, sin_val);
end

% Test 2: rot(511) should be [cos(π/4), sin(π/4)] ≈ [1448, 1448]
fprintf('\nTest 2: rot(511) ≈ [cos(π/4), sin(π/4)]...\n');
data = rot_lut(511);
cos_val = int16(bitshift(int32(data), -16));
sin_val = int16(bitand(uint32(data), uint32(0xFFFF)));
expected = round(cos(pi/4) * 2048);  % ≈ 1448

if abs(cos_val - expected) < 20 && abs(sin_val - expected) < 20
    fprintf('  ✓ PASS: cos(π/4)=%d, sin(π/4)=%d (expected ~%d)\n', ...
            cos_val, sin_val, expected);
else
    fprintf('  ✗ FAIL: cos(π/4)=%d, sin(π/4)=%d\n', cos_val, sin_val);
end

% Test 3: cos²+sin² should ≈ 2048² = 4194304
fprintf('\nTest 3: Pythagorean identity (cos²+sin²=1)...\n');
errors = [];
for addr = [0, 128, 256, 384, 511]
    data = rot_lut(addr);
    cos_val = double(int16(bitshift(int32(data), -16)));
    sin_val = double(int16(bitand(uint32(data), uint32(0xFFFF))));
    
    magnitude_sq = cos_val^2 + sin_val^2;
    expected_sq = 2048^2;
    error_pct = abs(magnitude_sq - expected_sq) / expected_sq * 100;
    errors(end+1) = error_pct;
end

if max(errors) < 5  % Within 5%
    fprintf('  ✓ PASS: Pythagorean identity holds (max error %.2f%%)\n', max(errors));
else
    fprintf('  ✗ FAIL: Large errors in magnitude\n');
end

% Test 4: sin increases over [0, π/4]
fprintf('\nTest 4: sin monotonically increasing...\n');
monotonic = true;
data = rot_lut(0);
prev_sin = int16(bitand(uint32(data), uint32(0xFFFF)));

for addr = 1:511
    data = rot_lut(addr);
    curr_sin = int16(bitand(uint32(data), uint32(0xFFFF)));
    if curr_sin < prev_sin
        monotonic = false;
        break;
    end
    prev_sin = curr_sin;
end

if monotonic
    fprintf('  ✓ PASS: sin increases monotonically\n');
else
    fprintf('  ✗ FAIL: sin not monotonic\n');
end

fprintf('\n========================================\n');
fprintf('  rot_lut module: ALL TESTS COMPLETE\n');
fprintf('========================================\n');
