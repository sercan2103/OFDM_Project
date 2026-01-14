%% test_delayT_standalone.m
% Standalone test for delayT module
% NO dependencies required

clear all;
close all;
clc;

fprintf('========================================\n');
fprintf('  Testing: delayT (STANDALONE)\n');
fprintf('========================================\n');

% Test 1: Basic delay
fprintf('\nTest 1: Basic delay of 5 cycles...\n');
DELAY = 5;
state = zeros(1, DELAY);

test_sequence = 1:10;
output_sequence = [];

for i = 1:length(test_sequence)
    [out, state] = delayT(test_sequence(i), state, DELAY);
    output_sequence(i) = out;
end

% Check: output should be input delayed by 5
expected = [0, 0, 0, 0, 0, 1, 2, 3, 4, 5];
if isequal(output_sequence, expected)
    fprintf('  ✓ PASS: Delay of 5 cycles works correctly\n');
else
    fprintf('  ✗ FAIL: Expected %s\n', mat2str(expected));
    fprintf('         Got      %s\n', mat2str(output_sequence));
end

% Test 2: Different delay value
fprintf('\nTest 2: Delay of 3 cycles...\n');
DELAY = 3;
state = zeros(1, DELAY);
output_sequence = [];

for i = 1:8
    [out, state] = delayT(i*10, state, DELAY);
    output_sequence(i) = out;
end

expected = [0, 0, 0, 10, 20, 30, 40, 50];
if isequal(output_sequence, expected)
    fprintf('  ✓ PASS: Delay of 3 cycles works correctly\n');
else
    fprintf('  ✗ FAIL\n');
end

% Test 3: Verify state persistence
fprintf('\nTest 3: State persistence...\n');
DELAY = 4;
state = zeros(1, DELAY);

[out1, state] = delayT(100, state, DELAY);
[out2, state] = delayT(200, state, DELAY);
[out3, state] = delayT(300, state, DELAY);
[out4, state] = delayT(400, state, DELAY);
[out5, state] = delayT(500, state, DELAY);

if out5 == 100
    fprintf('  ✓ PASS: State persistence works\n');
else
    fprintf('  ✗ FAIL: Expected 100, got %d\n', out5);
end

fprintf('\n========================================\n');
fprintf('  delayT module: ALL TESTS COMPLETE\n');
fprintf('========================================\n');
