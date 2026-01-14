%% test_calc_mean_standalone.m
% Standalone test for calc_mean module
% NO dependencies required - Tests signed mean calculation with pipeline

clear all;
close all;
clc;

fprintf('========================================\n');
fprintf('  Testing: calc_mean (STANDALONE)\n');
fprintf('========================================\n');

% Initialize state
state = struct();
state.pipeline = zeros(3, 1);

%% Test 1: Mean of positive numbers
fprintf('\nTest 1: Mean of positive numbers...\n');
values = [100, 200, 300, 400];
expected_mean = mean(values);  % 250

state.pipeline = zeros(3, 1);
for i = 1:length(values)
    [result, state] = calc_mean(values(i), state);
end

% Fill pipeline completely
for i = 1:5
    [result, state] = calc_mean(100, state);
end

error = abs(result - expected_mean);
if error <= 5
    fprintf('  ✓ PASS: Mean([100,200,300,400]) = %d (expected %.1f)\n', result, expected_mean);
else
    fprintf('  ✗ FAIL: Expected %.1f, got %d (error=%d)\n', expected_mean, result, error);
end

%% Test 2: Mean of negative numbers
fprintf('\nTest 2: Mean of negative numbers...\n');
values = [-100, -200, -300, -400];
expected_mean = mean(values);  % -250

state.pipeline = zeros(3, 1);
for i = 1:length(values)
    [result, state] = calc_mean(values(i), state);
end

% Fill pipeline
for i = 1:5
    [result, state] = calc_mean(-100, state);
end

error = abs(result - expected_mean);
if error <= 5
    fprintf('  ✓ PASS: Mean([-100,-200,-300,-400]) = %d (expected %.1f)\n', result, expected_mean);
else
    fprintf('  ✗ FAIL: Expected %.1f, got %d\n', expected_mean, result);
end

%% Test 3: Mean of mixed sign numbers
fprintf('\nTest 3: Mean of mixed sign numbers...\n');
values = [100, -100, 200, -200];
expected_mean = mean(values);  % 0

state.pipeline = zeros(3, 1);
for i = 1:length(values)
    [result, state] = calc_mean(values(i), state);
end

% Fill pipeline
for i = 1:5
    [result, state] = calc_mean(0, state);
end

error = abs(result - expected_mean);
if error <= 5
    fprintf('  ✓ PASS: Mean([100,-100,200,-200]) = %d (expected %.1f)\n', result, expected_mean);
else
    fprintf('  ✗ FAIL: Expected %.1f, got %d\n', expected_mean, result);
end

%% Test 4: Mean of all zeros
fprintf('\nTest 4: Mean of all zeros...\n');
values = [0, 0, 0, 0];
expected_mean = 0;

state.pipeline = zeros(3, 1);
for i = 1:length(values)
    [result, state] = calc_mean(values(i), state);
end

% Fill pipeline
for i = 1:5
    [result, state] = calc_mean(0, state);
end

if result == expected_mean
    fprintf('  ✓ PASS: Mean([0,0,0,0]) = %d\n', result);
else
    fprintf('  ✗ FAIL: Expected %d, got %d\n', expected_mean, result);
end

%% Test 5: Large values
fprintf('\nTest 5: Mean of large values...\n');
values = [10000, 20000, 30000, 40000];
expected_mean = mean(values);  % 25000

state.pipeline = zeros(3, 1);
for i = 1:length(values)
    [result, state] = calc_mean(values(i), state);
end

% Fill pipeline
for i = 1:5
    [result, state] = calc_mean(10000, state);
end

error = abs(result - expected_mean);
if error <= 50
    fprintf('  ✓ PASS: Mean of large values = %d (expected %.1f)\n', result, expected_mean);
else
    fprintf('  ✗ FAIL: Expected %.1f, got %d (error=%d)\n', expected_mean, result, error);
end

%% Test 6: Pipeline behavior (3-cycle delay)
fprintf('\nTest 6: Pipeline delay verification...\n');
state.pipeline = zeros(3, 1);

% Send sequence: 100, 100, 100, 100
outputs = [];
for i = 1:7
    [result, state] = calc_mean(100, state);
    outputs(i) = result;
end

% After 7 cycles with constant input, output should stabilize
if outputs(end) == 100
    fprintf('  ✓ PASS: Pipeline stabilizes correctly\n');
else
    fprintf('  ✗ FAIL: Pipeline output = %d (expected 100)\n', outputs(end));
end

%% Test 7: Changing inputs (stream test)
fprintf('\nTest 7: Streaming data with changing inputs...\n');
test_sequence = [50, 100, 150, 200, 250, 300, 350, 400];
state.pipeline = zeros(3, 1);

outputs = [];
for i = 1:length(test_sequence)
    [result, state] = calc_mean(test_sequence(i), state);
    outputs(i) = result;
end

% Continue for a few more cycles
for i = 1:5
    [result, state] = calc_mean(400, state);
    outputs(end+1) = result;
end

% Check that output changes (not stuck at zero)
if max(outputs) > 0 && outputs(end) > outputs(1)
    fprintf('  ✓ PASS: Output responds to changing inputs\n');
    fprintf('         Output range: [%d, %d]\n', min(outputs), max(outputs));
else
    fprintf('  ✗ FAIL: Output not responding correctly\n');
end

%% Test 8: Signed arithmetic verification
fprintf('\nTest 8: Signed arithmetic...\n');
values = [1000, -1000, 1000, -1000];
expected_mean = 0;

state.pipeline = zeros(3, 1);
for i = 1:length(values)
    [result, state] = calc_mean(values(i), state);
end

% Fill pipeline
for i = 1:5
    [result, state] = calc_mean(0, state);
end

if abs(result - expected_mean) <= 5
    fprintf('  ✓ PASS: Signed arithmetic handles +/- correctly\n');
else
    fprintf('  ✗ FAIL: Signed arithmetic error (got %d, expected %d)\n', result, expected_mean);
end

%% Summary
fprintf('\n========================================\n');
fprintf('  calc_mean module: ALL TESTS COMPLETE\n');
fprintf('========================================\n');
fprintf('\nModule characteristics:\n');
fprintf('  - 3-cycle pipeline delay\n');
fprintf('  - Computes sum/4 (averages 4 values)\n');
fprintf('  - Signed arithmetic (handles +/- values)\n');
fprintf('  - Output = (in[0] + in[1] + in[2] + in[3]) >> 2\n');
