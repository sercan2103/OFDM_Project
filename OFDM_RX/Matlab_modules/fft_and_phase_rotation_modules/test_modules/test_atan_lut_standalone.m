%% test_atan_lut_standalone.m
% Standalone test for atan_lut ROM module
% NO dependencies required

clear all;
close all;
clc;

fprintf('========================================\n');
fprintf('  Testing: atan_lut (STANDALONE ROM)\n');
fprintf('========================================\n');

% Test 1: atan(0) should be 0
fprintf('\nTest 1: atan(0) = 0...\n');
val = atan_lut(0);
if val == 0
    fprintf('  ✓ PASS: atan(0) = 0\n');
else
    fprintf('  ✗ FAIL: Expected 0, got %d\n', val);
end

% Test 2: atan(1) = π/4
fprintf('\nTest 2: atan(1) ≈ π/4 * 512...\n');
val = atan_lut(255);  % addr 255 = input 1.0
expected = round(pi/4 * 512);  % ≈ 402
error = abs(val - expected);
if error <= 2
    fprintf('  ✓ PASS: atan(1) = %d (expected %d, error %d)\n', val, expected, error);
else
    fprintf('  ✗ FAIL: atan(1) = %d, expected %d\n', val, expected);
end

% Test 3: atan(0.5)
fprintf('\nTest 3: atan(0.5)...\n');
val = atan_lut(128);  % addr 128 = input 0.5
expected = round(atan(0.5) * 512);  % ≈ 232
error = abs(val - expected);
if error <= 2
    fprintf('  ✓ PASS: atan(0.5) = %d (expected %d)\n', val, expected);
else
    fprintf('  ✗ FAIL\n');
end

% Test 4: Monotonicity check
fprintf('\nTest 4: Monotonically increasing...\n');
monotonic = true;
prev = atan_lut(0);
for addr = 1:255
    curr = atan_lut(addr);
    if curr < prev
        monotonic = false;
        break;
    end
    prev = curr;
end

if monotonic
    fprintf('  ✓ PASS: LUT is monotonically increasing\n');
else
    fprintf('  ✗ FAIL: LUT not monotonic at addr %d\n', addr);
end

% Test 5: Range check
fprintf('\nTest 5: Output range [0, ~402]...\n');
max_val = 0;
for addr = 0:255
    val = atan_lut(addr);
    if val > max_val
        max_val = val;
    end
end

if max_val >= 400 && max_val <= 405
    fprintf('  ✓ PASS: Max value = %d (expected ~402)\n', max_val);
else
    fprintf('  ✗ FAIL: Max value = %d\n', max_val);
end

fprintf('\n========================================\n');
fprintf('  atan_lut module: ALL TESTS COMPLETE\n');
fprintf('========================================\n');
