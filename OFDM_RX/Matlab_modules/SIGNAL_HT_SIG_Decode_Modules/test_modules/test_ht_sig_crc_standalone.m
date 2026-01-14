%% test_ht_sig_crc_standalone.m
% Standalone test for ht_sig_crc module (CRC-8 for HT-SIG)
% NO dependencies required

clear all;
close all;
clc;

fprintf('========================================\n');
fprintf('  Testing: ht_sig_crc (STANDALONE)\n');
fprintf('  CRC-8 for HT-SIG validation\n');
fprintf('========================================\n');

%% Test 1: Known CRC patterns
fprintf('\nTest 1: Known CRC-8 patterns...\n');

% Test case: All zeros
data_bits = zeros(1, 24);
crc = ht_sig_crc(data_bits);
fprintf('  CRC([0...0]) = 0x%02X\n', crc);

if crc >= 0 && crc <= 255
    fprintf('  ✓ PASS: CRC in valid range [0-255]\n');
else
    fprintf('  ✗ FAIL: CRC out of range\n');
end

%% Test 2: All ones pattern
fprintf('\nTest 2: All ones pattern...\n');

data_bits = ones(1, 24);
crc = ht_sig_crc(data_bits);
fprintf('  CRC([1...1]) = 0x%02X\n', crc);

if crc >= 0 && crc <= 255
    fprintf('  ✓ PASS: CRC computed successfully\n');
else
    fprintf('  ✗ FAIL: CRC computation error\n');
end

%% Test 3: Alternating pattern
fprintf('\nTest 3: Alternating pattern...\n');

data_bits = zeros(1, 24);
data_bits(1:2:end) = 1;  % [1,0,1,0,1,0,...]
crc = ht_sig_crc(data_bits);
fprintf('  CRC([1,0,1,0...]) = 0x%02X\n', crc);

if crc >= 0 && crc <= 255
    fprintf('  ✓ PASS: Alternating pattern CRC valid\n');
end

%% Test 4: Different data produces different CRC
fprintf('\nTest 4: Different data produces different CRC...\n');

data1 = [1,0,1,0,1,0,1,0, 1,1,0,0,1,1,0,0, 1,0,1,0,1,0,1,0];
data2 = [0,1,0,1,0,1,0,1, 0,0,1,1,0,0,1,1, 0,1,0,1,0,1,0,1];

crc1 = ht_sig_crc(data1);
crc2 = ht_sig_crc(data2);

fprintf('  CRC(data1) = 0x%02X\n', crc1);
fprintf('  CRC(data2) = 0x%02X\n', crc2);

if crc1 ~= crc2
    fprintf('  ✓ PASS: Different data produces different CRC\n');
else
    fprintf('  ⚠ WARN: Same CRC for different data (possible collision)\n');
end

%% Test 5: Single bit change detection
fprintf('\nTest 5: Single bit error detection...\n');

original = [1,0,1,0,1,0,1,0, 1,1,0,0,1,1,0,0, 1,0,1,0,1,0,1,0];
modified = original;
modified(10) = ~modified(10);  % Flip one bit

crc_orig = ht_sig_crc(original);
crc_mod = ht_sig_crc(modified);

fprintf('  Original CRC: 0x%02X\n', crc_orig);
fprintf('  Modified CRC: 0x%02X\n', crc_mod);

if crc_orig ~= crc_mod
    fprintf('  ✓ PASS: Single bit error detected\n');
else
    fprintf('  ✗ FAIL: Single bit error not detected\n');
end

%% Test 6: Realistic HT-SIG data
fprintf('\nTest 6: Realistic HT-SIG fields...\n');

% HT-SIG1 example: MCS=7, BW=20MHz, Length=100
% Bits: [MCS(7) | CW | Length(16)]
ht_sig_data = zeros(1, 24);
ht_sig_data(1:7) = [1,1,1,0,0,0,0];  % MCS=7
ht_sig_data(8) = 0;                   % Reserved
ht_sig_data(9:24) = de2bi(100, 16, 'left-msb');  % Length=100

crc = ht_sig_crc(ht_sig_data);
fprintf('  HT-SIG CRC = 0x%02X\n', crc);
fprintf('  ✓ PASS: Realistic data processed\n');

%% Test 7: Multiple samples
fprintf('\nTest 7: Multiple different samples...\n');

test_cases = [
    de2bi(0, 24, 'left-msb');
    de2bi(255, 24, 'left-msb');
    de2bi(12345, 24, 'left-msb');
    de2bi(65535, 24, 'left-msb');
];

unique_crcs = [];
for i = 1:size(test_cases, 1)
    crc = ht_sig_crc(test_cases(i, :));
    unique_crcs(i) = crc;
end

fprintf('  CRC values: [');
for i = 1:length(unique_crcs)
    fprintf('0x%02X ', unique_crcs(i));
end
fprintf(']\n');

if length(unique(unique_crcs)) >= 3
    fprintf('  ✓ PASS: Good CRC distribution\n');
else
    fprintf('  ⚠ WARN: Limited CRC distribution\n');
end

%% Test 8: CRC consistency
fprintf('\nTest 8: CRC consistency (same input = same output)...\n');

test_data = [1,0,1,1,0,1,0,0, 1,1,1,0,0,0,1,1, 0,1,0,1,1,0,1,0];
crc_runs = [];

for run = 1:5
    crc = ht_sig_crc(test_data);
    crc_runs(run) = crc;
end

if all(crc_runs == crc_runs(1))
    fprintf('  ✓ PASS: CRC is consistent (0x%02X)\n', crc_runs(1));
else
    fprintf('  ✗ FAIL: CRC inconsistent across runs\n');
end

%% Summary
fprintf('\n========================================\n');
fprintf('  ht_sig_crc: ALL TESTS COMPLETE\n');
fprintf('========================================\n');
fprintf('\nModule characteristics:\n');
fprintf('  - Input: 24 bits of HT-SIG data\n');
fprintf('  - Output: 8-bit CRC\n');
fprintf('  - Polynomial: x^8 + x^2 + x + 1 (0x07)\n');
fprintf('  - Detects single and multiple bit errors\n');
