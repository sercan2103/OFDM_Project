%% Test Script for generate_signal_iq.m
% This script demonstrates how to generate IQ samples for L-SIG and HT-SIG fields
% using the existing TX chain functions.

clear; clc; close all;

fprintf('=== Testing L-SIG and HT-SIG IQ Generation ===\n\n');

%% Test Case 1: Legacy Packet (6 Mbps, 100 bytes)
fprintf('Test 1: Legacy Packet (6 Mbps, 100 bytes)\n');
fprintf('-------------------------------------------\n');

% Create BRAM addresses for Legacy packet
% RATE = 0xB (6 Mbps), LENGTH = 100 bytes, PKT_TYPE = 0 (Legacy)
rate_field = bin2dec('1011');
length_field = 100;
pkt_type = 0;

bram_addr0 = rate_field + bitshift(uint64(length_field), 5) + bitshift(uint64(pkt_type), 24);
bram_addr1 = 0; % Not used for Legacy

% Parse configuration
config = read_plcp_config(bram_addr0, bram_addr1);

% Generate SIGNAL IQ samples
[l_sig_iq, ht_sig_iq] = generate_signal_iq(config);

fprintf('L-SIG IQ Samples: %d samples generated\n', length(l_sig_iq));
fprintf('HT-SIG IQ Samples: %s\n\n', mat2str(size(ht_sig_iq)));

% Verify L-SIG length (should be 80: 16 CP + 64 IFFT)
assert(length(l_sig_iq) == 80, 'L-SIG should have 80 samples');
assert(isempty(ht_sig_iq), 'HT-SIG should be empty for Legacy packets');

%% Test Case 2: HT Packet (MCS3, 200 bytes)
fprintf('Test 2: HT Packet (MCS3, 200 bytes)\n');
fprintf('-------------------------------------------\n');

% Create BRAM addresses for HT packet
% RATE = 0xB (indicates HT when PKT_TYPE=1), LENGTH = dummy, PKT_TYPE = 1
rate_field = bin2dec('1011');
length_field = 0; % Not used for HT
pkt_type = 1;

bram_addr0 = rate_field + bitshift(uint64(length_field), 5) + bitshift(uint64(pkt_type), 24);

% HT-specific fields: MCS=3, HT_LENGTH=200, HT_AGGR=0, S_GI=0
mcs_field = 3;
ht_length = 200;
ht_aggr = 0;
s_gi = 0;

bram_addr1 = mcs_field + bitshift(uint64(ht_length), 8) + bitshift(uint64(ht_aggr), 27) + bitshift(uint64(s_gi), 31);

% Parse configuration
config = read_plcp_config(bram_addr0, bram_addr1);

% Generate SIGNAL IQ samples
[l_sig_iq, ht_sig_iq] = generate_signal_iq(config);

fprintf('L-SIG IQ Samples: %d samples generated\n', length(l_sig_iq));
fprintf('HT-SIG IQ Samples: %d samples generated\n\n', length(ht_sig_iq));

% Verify lengths
assert(length(l_sig_iq) == 80, 'L-SIG should have 80 samples');
assert(length(ht_sig_iq) == 160, 'HT-SIG should have 160 samples (2 symbols)');

%% Visualization
figure('Name', 'L-SIG and HT-SIG IQ Samples', 'Position', [100, 100, 1200, 800]);

% Plot L-SIG
subplot(2, 2, 1);
plot(real(l_sig_iq), 'b', 'LineWidth', 1.5); hold on;
plot(imag(l_sig_iq), 'r', 'LineWidth', 1.5);
title('L-SIG Time Domain (I/Q)');
xlabel('Sample Index');
ylabel('Amplitude');
legend('I (In-phase)', 'Q (Quadrature)');
grid on;
xline(16.5, '--k', 'CP End', 'LabelVerticalAlignment', 'bottom');

% Plot L-SIG Constellation
subplot(2, 2, 2);
scatter(real(l_sig_iq), imag(l_sig_iq), 20, 'filled');
title('L-SIG Constellation');
xlabel('I (In-phase)');
ylabel('Q (Quadrature)');
grid on;
axis equal;

% Plot HT-SIG (if exists)
if ~isempty(ht_sig_iq)
    subplot(2, 2, 3);
    plot(real(ht_sig_iq), 'b', 'LineWidth', 1.5); hold on;
    plot(imag(ht_sig_iq), 'r', 'LineWidth', 1.5);
    title('HT-SIG Time Domain (I/Q)');
    xlabel('Sample Index');
    ylabel('Amplitude');
    legend('I (In-phase)', 'Q (Quadrature)');
    grid on;
    xline(16.5, '--k', 'CP1 End', 'LabelVerticalAlignment', 'bottom');
    xline(80.5, '--k', 'Sym1 End', 'LabelVerticalAlignment', 'top');
    
    % Plot HT-SIG Constellation
    subplot(2, 2, 4);
    scatter(real(ht_sig_iq), imag(ht_sig_iq), 20, 'filled');
    title('HT-SIG Constellation');
    xlabel('I (In-phase)');
    ylabel('Q (Quadrature)');
    grid on;
    axis equal;
end

%% Power Analysis
fprintf('Signal Power Analysis:\n');
fprintf('-------------------------------------------\n');
fprintf('L-SIG Average Power: %.4f\n', mean(abs(l_sig_iq).^2));
fprintf('L-SIG Peak Power: %.4f\n', max(abs(l_sig_iq).^2));

if ~isempty(ht_sig_iq)
    fprintf('HT-SIG Average Power: %.4f\n', mean(abs(ht_sig_iq).^2));
    fprintf('HT-SIG Peak Power: %.4f\n', max(abs(ht_sig_iq).^2));
end

fprintf('\n=== Test Completed Successfully ===\n');
