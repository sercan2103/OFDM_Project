%% test_qbpsk_derotate_standalone.m
% Standalone test for qbpsk_derotate module
% Converts Q-BPSK (used in HT-SIG) to BPSK
% NO dependencies required

clear all;
close all;
clc;

fprintf('========================================\n');
fprintf('  Testing: qbpsk_derotate (STANDALONE)\n');
fprintf('  Q-BPSK to BPSK conversion\n');
fprintf('========================================\n');

%% Test 1: Basic Q-BPSK rotation
fprintf('\nTest 1: Basic Q-BPSK derotation...\n');

% Q-BPSK: data alternates between two states with 90° rotation
% Symbol k: (+1, 0) or (-1, 0)
% Symbol k+1: (0, +1) or (0, -1) [rotated by 90°]

% Test even symbol (no rotation needed)
sym_i = 1000;
sym_q = 0;
index = 0;  % Even index
[derot_i, derot_q] = qbpsk_derotate(sym_i, sym_q, index);

fprintf('  Even[0]: In=(%d,%d) → Out=(%d,%d)\n', sym_i, sym_q, derot_i, derot_q);
if abs(derot_i - sym_i) < 10 && abs(derot_q) < 10
    fprintf('  ✓ PASS: Even index preserves symbol\n');
else
    fprintf('  ✗ FAIL: Even index rotation error\n');
end

%% Test 2: Odd index (needs -90° rotation)
fprintf('\nTest 2: Odd index derotation...\n');

% Odd symbol: received as (0, +j), should become (+1, 0)
sym_i = 0;
sym_q = 1000;
index = 1;  % Odd index
[derot_i, derot_q] = qbpsk_derotate(sym_i, sym_q, index);

fprintf('  Odd[1]: In=(%d,%d) → Out=(%d,%d)\n', sym_i, sym_q, derot_i, derot_q);
% After -90° rotation: (0,1000) → (1000, 0)
if abs(derot_i - 1000) < 50 && abs(derot_q) < 50
    fprintf('  ✓ PASS: Odd index rotates -90°\n');
else
    fprintf('  ✗ FAIL: Odd index rotation error\n');
end

%% Test 3: Alternating sequence
fprintf('\nTest 3: Alternating Q-BPSK sequence...\n');

% Create alternating pattern: [+1, -1, +1, -1] in BPSK
% In Q-BPSK this becomes: [(+1,0), (0,-1), (+1,0), (0,-1)]
qbpsk_symbols = [
    1000, 0;      % Index 0: +1
    0, -1000;     % Index 1: -1 (as Q-BPSK)
    1000, 0;      % Index 2: +1
    0, -1000;     % Index 3: -1 (as Q-BPSK)
];

derot_symbols = zeros(4, 2);
for k = 0:3
    [derot_i, derot_q] = qbpsk_derotate(qbpsk_symbols(k+1,1), ...
                                        qbpsk_symbols(k+1,2), k);
    derot_symbols(k+1, :) = [derot_i, derot_q];
end

fprintf('  Derotated sequence:\n');
for k = 0:3
    fprintf('    [%d]: (%5d, %5d)\n', k, derot_symbols(k+1,1), derot_symbols(k+1,2));
end

% Check if all derotated symbols are on I-axis (Q ≈ 0)
all_on_i_axis = all(abs(derot_symbols(:,2)) < 100);
if all_on_i_axis
    fprintf('  ✓ PASS: All symbols derotated to I-axis\n');
else
    fprintf('  ✗ FAIL: Some symbols not on I-axis\n');
end

%% Test 4: Full HT-SIG sequence (48 symbols)
fprintf('\nTest 4: Full HT-SIG derotation (48 symbols)...\n');

% Generate 48 Q-BPSK symbols
num_symbols = 48;
qbpsk_seq = zeros(num_symbols, 2);

for k = 0:num_symbols-1
    if mod(k, 2) == 0
        % Even: data on I-axis
        qbpsk_seq(k+1, :) = [(randi([0,1])*2-1)*1000, 0];
    else
        % Odd: data on Q-axis
        qbpsk_seq(k+1, :) = [0, (randi([0,1])*2-1)*1000];
    end
end

% Derotate all
derot_seq = zeros(num_symbols, 2);
for k = 0:num_symbols-1
    [derot_i, derot_q] = qbpsk_derotate(qbpsk_seq(k+1,1), qbpsk_seq(k+1,2), k);
    derot_seq(k+1, :) = [derot_i, derot_q];
end

% Check all on I-axis
q_errors = abs(derot_seq(:, 2));
max_q_error = max(q_errors);

fprintf('  Max Q-component after derotation: %d\n', max_q_error);
if max_q_error < 100
    fprintf('  ✓ PASS: All 48 symbols derotated correctly\n');
else
    fprintf('  ✗ FAIL: Some symbols have Q-component\n');
end

%% Test 5: Phase rotation angles
fprintf('\nTest 5: Verify rotation angles...\n');

% Even index (k=0): no rotation
[d_i, d_q] = qbpsk_derotate(1000, 0, 0);
fprintf('  Index 0 (no rotation):  (1000,0) → (%d,%d)\n', d_i, d_q);

% Odd index (k=1): -90° rotation
[d_i, d_q] = qbpsk_derotate(0, 1000, 1);
fprintf('  Index 1 (-90° rot):     (0,1000) → (%d,%d)\n', d_i, d_q);

% Check mathematical correctness
% -90° rotation: (x,y) → (y,-x)
test_pass = (abs(d_i - 1000) < 50) && (abs(d_q) < 50);
if test_pass
    fprintf('  ✓ PASS: Rotation math correct\n');
else
    fprintf('  ✗ FAIL: Rotation math error\n');
end

%% Test 6: Negative values
fprintf('\nTest 6: Negative values...\n');

% Test negative on even index
[d_i, d_q] = qbpsk_derotate(-1000, 0, 0);
fprintf('  Even: (-1000,0) → (%d,%d)\n', d_i, d_q);

% Test negative on odd index
[d_i, d_q] = qbpsk_derotate(0, -1000, 1);
fprintf('  Odd:  (0,-1000) → (%d,%d)\n', d_i, d_q);

if abs(d_i + 1000) < 50 && abs(d_q) < 50
    fprintf('  ✓ PASS: Negative values handled correctly\n');
else
    fprintf('  ✗ FAIL: Negative value error\n');
end

%% Test 7: Real HT-SIG constellation
fprintf('\nTest 7: Realistic HT-SIG constellation points...\n');

% IEEE 802.11n HT-SIG uses Q-BPSK with constellation points at ±1
% Scaled by 1024 in fixed-point
constellation_points = [-1024, 1024];

test_results = [];
for idx = 0:9  % Test 10 symbols
    pt = constellation_points(randi([1,2]));
    
    if mod(idx, 2) == 0
        % Even: point on I-axis
        [d_i, d_q] = qbpsk_derotate(pt, 0, idx);
    else
        % Odd: point on Q-axis
        [d_i, d_q] = qbpsk_derotate(0, pt, idx);
    end
    
    test_results(idx+1) = abs(d_q) < 50;  % Q should be near zero
end

if all(test_results)
    fprintf('  ✓ PASS: All constellation points derotated correctly\n');
else
    fprintf('  ✗ FAIL: Some constellation points failed\n');
end

%% Summary
fprintf('\n========================================\n');
fprintf('  qbpsk_derotate: ALL TESTS COMPLETE\n');
fprintf('========================================\n');
fprintf('\nModule characteristics:\n');
fprintf('  - Converts Q-BPSK to BPSK\n');
fprintf('  - Even indices: no rotation\n');
fprintf('  - Odd indices: -90° rotation\n');
fprintf('  - Used for HT-SIG decoding\n');
fprintf('  - Rotation: (I,Q) → (Q,-I) for odd indices\n');
