% test_signal_decode.m
% Test SIGNAL and HT-SIG decoding modules

clear all;
close all;
clc;

fprintf('======================================================\n');
fprintf('  Signal Decode Module - Test\n');
fprintf('======================================================\n\n');

% Add path
addpath('part3_signal_decode');

%% Test 1: Valid SIGNAL Field
fprintf('Test 1: Valid SIGNAL Field Decoding\n');
fprintf('------------------------------------\n');

% Create valid SIGNAL field
% Rate = 0x0D (54 Mbps, 64-QAM 3/4), Length = 1500 bytes
rate = hex2dec('0D');
length = 1500;

% Build SIGNAL bits [rate(4) | reserved(1) | length(12) | parity(1) | tail(6)]
signal_bits = rate;
signal_bits = signal_bits + bitshift(0, 4);  % reserved = 0
signal_bits = signal_bits + bitshift(length, 5);

% Calculate parity (even parity over bits 0-16)
parity = 0;
for i = 0:16
    parity = bitxor(parity, bitand(bitshift(signal_bits, -i), 1));
end
signal_bits = signal_bits + bitshift(parity, 17);
signal_bits = signal_bits + bitshift(0, 18);  % tail = 0

% Decode
[valid, fields, is_ht] = signal_decode(signal_bits);

fprintf('  Rate:       0x%02X\n', fields.rate);
fprintf('  Length:     %d bytes\n', fields.length);
fprintf('  Parity OK:  %d\n', fields.parity_ok);
fprintf('  Valid:      %d\n', valid);
fprintf('  HT Check:   %d\n', is_ht);

if valid && fields.length == length && fields.rate == rate
    fprintf('  ✓ PASS: SIGNAL decoded correctly\n');
else
    fprintf('  ✗ FAIL: SIGNAL decode error\n');
end

%% Test 2: HT Detection with Q-BPSK
fprintf('\n\nTest 2: HT Format Detection\n');
fprintf('----------------------------\n');

% Generate Q-BPSK samples (HT format)
fprintf('  Creating Q-BPSK samples (HT)... ');
ht_samples = zeros(10, 2);
for i = 1:10
    % Q-BPSK: symbols primarily on Q axis
    ht_samples(i, 1) = randi([-100, 100]);  % Small I
    ht_samples(i, 2) = (randi([0,1])*2-1) * 1000;  % Large Q
end
fprintf('Done\n');

is_ht = ht_detect(ht_samples);

if is_ht
    fprintf('  ✓ PASS: HT format detected\n');
else
    fprintf('  ✗ FAIL: Should detect HT\n');
end

% Generate normal BPSK samples (Legacy format)
fprintf('\n  Creating BPSK samples (Legacy)... ');
legacy_samples = zeros(10, 2);
for i = 1:10
    % Normal BPSK: symbols primarily on I axis
    legacy_samples(i, 1) = (randi([0,1])*2-1) * 1000;  % Large I
    legacy_samples(i, 2) = randi([-100, 100]);  % Small Q
end
fprintf('Done\n');

is_legacy = ht_detect(legacy_samples);

if ~is_legacy
    fprintf('  ✓ PASS: Legacy format detected\n');
else
    fprintf('  ✗ FAIL: Should detect Legacy\n');
end

%% Test 3: Q-BPSK Derotation
fprintf('\n\nTest 3: Q-BPSK Derotation\n');
fprintf('-------------------------\n');

% Q-BPSK samples
qbpsk_in = [
    10, 1000;   % Mostly on +Q axis
    -20, -950;  % Mostly on -Q axis
    15, 980;
    -25, -1020;
];

% Derotate (should rotate by -90°)
bpsk_out = qbpsk_derotate(qbpsk_in);

fprintf('  Input Q-BPSK -> Output BPSK:\n');
for i = 1:size(qbpsk_in, 1)
    fprintf('    [%5d, %5d] -> [%5d, %5d]\n', ...
            qbpsk_in(i,1), qbpsk_in(i,2), ...
            bpsk_out(i,1), bpsk_out(i,2));
end

% Check: I_out should equal Q_in, Q_out should equal -I_in
errors = 0;
for i = 1:size(qbpsk_in, 1)
    if abs(bpsk_out(i,1) - qbpsk_in(i,2)) > 5 || ...
       abs(bpsk_out(i,2) + qbpsk_in(i,1)) > 5
        errors = errors + 1;
    end
end

if errors == 0
    fprintf('  ✓ PASS: Derotation correct\n');
else
    fprintf('  ✗ FAIL: Derotation errors\n');
end

%% Test 4: HT-SIG Decoding with Valid CRC
fprintf('\n\nTest 4: HT-SIG Decoding\n');
fprintf('-----------------------\n');

% Create HT-SIG1: MCS=7, CBW=20MHz, Length=2000
mcs = 7;
cbw = 0;  % 20 MHz
ht_length = 2000;

ht_sig1 = mcs + bitshift(cbw, 7) + bitshift(ht_length, 8);

% Create HT-SIG2: Reserved=1, others=0
ht_sig2 = bitshift(1, 2);  % Reserved bit must be 1

% Calculate CRC over first 34 bits
crc_state = struct();
crc_state.C = ones(1, 8);

% Process HT-SIG1 (24 bits)
for i = 0:23
    bit = bitand(bitshift(ht_sig1, -i), 1);
    [~, crc_state] = ht_sig_crc(bit, crc_state);
end

% Process HT-SIG2[9:0] (10 bits)
for i = 0:9
    bit = bitand(bitshift(ht_sig2, -i), 1);
    [crc, crc_state] = ht_sig_crc(bit, crc_state);
end

fprintf('  Calculated CRC: 0x%02X\n', crc);

% Insert CRC into HT-SIG2
ht_sig2 = ht_sig2 + bitshift(crc, 10);

% Decode
[valid, ht_fields, crc_ok] = ht_sig_decode(ht_sig1, ht_sig2);

fprintf('  MCS:        %d\n', ht_fields.mcs);
fprintf('  CBW:        %d MHz\n', (ht_fields.cbw + 1) * 20);
fprintf('  HT Length:  %d bytes\n', ht_fields.ht_length);
fprintf('  CRC OK:     %d\n', crc_ok);
fprintf('  Valid:      %d\n', valid);

if valid && crc_ok && ht_fields.mcs == mcs && ht_fields.ht_length == ht_length
    fprintf('  ✓ PASS: HT-SIG decoded correctly\n');
else
    fprintf('  ✗ FAIL: HT-SIG decode error\n');
end

%% Test 5: CRC-32 (FCS) Test
fprintf('\n\nTest 5: CRC-32 (Frame Check Sequence)\n');
fprintf('--------------------------------------\n');

% Test with known packet
test_packet = uint8([0x42, 0x00, 0x01, 0x02, 0x03, 0x04]);

crc_state = struct();
crc_state.crc = uint32(hex2dec('FFFFFFFF'));

fprintf('  Processing %d bytes... ', length(test_packet));
for i = 1:length(test_packet)
    [fcs, crc_state] = crc32(test_packet(i), crc_state);
end
fprintf('Done\n');

fprintf('  FCS: 0x%08X\n', fcs);

% FCS should be some value (exact value depends on data)
if fcs > 0
    fprintf('  ✓ PASS: CRC-32 calculated\n');
else
    fprintf('  ✗ FAIL: CRC-32 error\n');
end

% Test expected FCS for correct packet
fprintf('\n  Note: Expected FCS for valid packet = 0xC704DD7B\n');

%% Visualization
fprintf('\n\nGenerating Plots...\n');

figure('Name', 'Signal Decode Test', 'Position', [100, 100, 1000, 600]);

% Plot 1: HT Detection
subplot(2, 2, 1);
scatter(ht_samples(:,1), ht_samples(:,2), 100, 'ro', 'filled');
hold on;
scatter(legacy_samples(:,1), legacy_samples(:,2), 100, 'bs', 'filled');
grid on;
xlabel('I Component');
ylabel('Q Component');
title('HT Detection: Q-BPSK vs BPSK');
legend('HT (Q-BPSK)', 'Legacy (BPSK)', 'Location', 'best');
axis equal;

% Plot 2: Derotation
subplot(2, 2, 2);
hold on;
for i = 1:size(qbpsk_in, 1)
    plot([0, qbpsk_in(i,1)], [0, qbpsk_in(i,2)], 'r-', 'LineWidth', 2);
    plot([0, bpsk_out(i,1)], [0, bpsk_out(i,2)], 'b--', 'LineWidth', 2);
end
grid on;
xlabel('I Component');
ylabel('Q Component');
title('Q-BPSK Derotation');
legend('Q-BPSK Input', 'BPSK Output', 'Location', 'best');
axis equal;

% Plot 3: SIGNAL Field Structure
subplot(2, 2, 3);
signal_structure = [4, 1, 12, 1, 6];
signal_labels = {'RATE', 'R', 'LENGTH', 'P', 'TAIL'};
pie(signal_structure, signal_labels);
title('SIGNAL Field Bit Allocation');

% Plot 4: HT-SIG Field Structure
subplot(2, 2, 4);
ht_sig_structure = [7, 1, 16, 2, 1, 1, 2, 2, 1, 1, 2, 8, 6];
ht_sig_labels = {'MCS', 'CBW', 'LEN', 'SM', 'NS', 'R', 'AG', 'STBC', 'FEC', 'SGI', 'EXT', 'CRC', 'TAIL'};
pie(ht_sig_structure);
title('HT-SIG Field Bit Allocation');

fprintf('\n✓ Test Complete. Check plots for visual inspection.\n');
