%% Test Script for hex_to_ofdm_ht.m
% This script demonstrates the conversion of hexadecimal data to 
% IEEE 802.11n HT-mixed format OFDM symbols

clear; clc; close all;

fprintf('========================================\n');
fprintf('Testing hex_to_ofdm_ht Function\n');
fprintf('========================================\n\n');

%% Test Case 1: Short hex data with MCS 3 (16-QAM 1/2)
fprintf('Test Case 1: 16 bytes hex data, MCS 3 (16-QAM 1/2)\n');
fprintf('----------------------------------------\n');

% Input parameters
hex_data = 'DEADBEEFCAFEBABE1234567890ABCDEF';
rate = 11;               % 6 Mbps for L-SIG (binary: 01011)
mcs = 3;                 % MCS 3: 16-QAM 1/2
n_bpsc = 4;              % 16-QAM uses 4 bits per subcarrier
n_dbps = 104;            % Data bits per OFDM symbol for MCS 3
psdu_length_bytes = 16;  % PSDU length for L-SIG field

% Generate OFDM symbols
tic;
iq_samples_1 = hex_to_ofdm_ht(hex_data, rate, mcs, n_bpsc, n_dbps, psdu_length_bytes);
elapsed = toc;

fprintf('\nTest Case 1 completed in %.3f seconds\n', elapsed);
fprintf('Total IQ samples generated: %d\n\n', length(iq_samples_1));

%% Test Case 2: Different MCS (MCS 5: 64-QAM 2/3)
fprintf('Test Case 2: 8 bytes hex data, MCS 5 (64-QAM 2/3)\n');
fprintf('----------------------------------------\n');

hex_data_2 = '0123456789ABCDEF';
rate_2 = 11;
mcs_2 = 5;
n_bpsc_2 = 6;     % 64-QAM uses 6 bits per subcarrier
n_dbps_2 = 208;   % Data bits per OFDM symbol for MCS 5
psdu_length_2 = 8;

tic;
iq_samples_2 = hex_to_ofdm_ht(hex_data_2, rate_2, mcs_2, n_bpsc_2, n_dbps_2, psdu_length_2);
elapsed_2 = toc;

fprintf('\nTest Case 2 completed in %.3f seconds\n', elapsed_2);
fprintf('Total IQ samples generated: %d\n\n', length(iq_samples_2));

%% Test Case 3: MCS 0 (BPSK 1/2) - Minimum complexity
fprintf('Test Case 3: 8 bytes hex data, MCS 0 (BPSK 1/2)\n');
fprintf('----------------------------------------\n');

hex_data_3 = 'FFFFFFFFFFFFFFFF';
rate_3 = 11;
mcs_3 = 0;
n_bpsc_3 = 1;     % BPSK uses 1 bit per subcarrier
n_dbps_3 = 26;    % Data bits per OFDM symbol for MCS 0
psdu_length_3 = 8;

tic;
iq_samples_3 = hex_to_ofdm_ht(hex_data_3, rate_3, mcs_3, n_bpsc_3, n_dbps_3, psdu_length_3);
elapsed_3 = toc;

fprintf('\nTest Case 3 completed in %.3f seconds\n', elapsed_3);
fprintf('Total IQ samples generated: %d\n\n', length(iq_samples_3));

%% Visualization
fprintf('Generating visualization plots...\n');

figure('Name', '802.11n HT-Mixed OFDM Symbol Generation', 'Position', [50, 50, 1400, 900]);

% Test Case 1 Visualization
subplot(3, 3, 1);
plot(real(iq_samples_1), 'b', 'LineWidth', 1);
hold on;
plot(imag(iq_samples_1), 'r', 'LineWidth', 1);
title('Test 1: Time Domain (MCS 3)');
xlabel('Sample Index');
ylabel('Amplitude');
legend('I', 'Q');
grid on;
xlim([1, length(iq_samples_1)]);

subplot(3, 3, 2);
scatter(real(iq_samples_1), imag(iq_samples_1), 5, 'filled', 'MarkerFaceAlpha', 0.3);
title('Test 1: Constellation (MCS 3)');
xlabel('I (In-phase)');
ylabel('Q (Quadrature)');
grid on;
axis equal;

subplot(3, 3, 3);
psd_1 = abs(fft(iq_samples_1)).^2;
freq_axis_1 = linspace(-10, 10, length(psd_1));
plot(freq_axis_1, 10*log10(fftshift(psd_1)), 'LineWidth', 1.5);
title('Test 1: Power Spectral Density');
xlabel('Frequency (MHz)');
ylabel('Power (dB)');
grid on;
xlim([-10, 10]);

% Test Case 2 Visualization
subplot(3, 3, 4);
plot(real(iq_samples_2), 'b', 'LineWidth', 1);
hold on;
plot(imag(iq_samples_2), 'r', 'LineWidth', 1);
title('Test 2: Time Domain (MCS 5)');
xlabel('Sample Index');
ylabel('Amplitude');
legend('I', 'Q');
grid on;
xlim([1, length(iq_samples_2)]);

subplot(3, 3, 5);
scatter(real(iq_samples_2), imag(iq_samples_2), 5, 'filled', 'MarkerFaceAlpha', 0.3);
title('Test 2: Constellation (MCS 5)');
xlabel('I (In-phase)');
ylabel('Q (Quadrature)');
grid on;
axis equal;

subplot(3, 3, 6);
psd_2 = abs(fft(iq_samples_2)).^2;
freq_axis_2 = linspace(-10, 10, length(psd_2));
plot(freq_axis_2, 10*log10(fftshift(psd_2)), 'LineWidth', 1.5);
title('Test 2: Power Spectral Density');
xlabel('Frequency (MHz)');
ylabel('Power (dB)');
grid on;
xlim([-10, 10]);

% Test Case 3 Visualization
subplot(3, 3, 7);
plot(real(iq_samples_3), 'b', 'LineWidth', 1);
hold on;
plot(imag(iq_samples_3), 'r', 'LineWidth', 1);
title('Test 3: Time Domain (MCS 0)');
xlabel('Sample Index');
ylabel('Amplitude');
legend('I', 'Q');
grid on;
xlim([1, length(iq_samples_3)]);

subplot(3, 3, 8);
scatter(real(iq_samples_3), imag(iq_samples_3), 5, 'filled', 'MarkerFaceAlpha', 0.3);
title('Test 3: Constellation (MCS 0)');
xlabel('I (In-phase)');
ylabel('Q (Quadrature)');
grid on;
axis equal;

subplot(3, 3, 9);
psd_3 = abs(fft(iq_samples_3)).^2;
freq_axis_3 = linspace(-10, 10, length(psd_3));
plot(freq_axis_3, 10*log10(fftshift(psd_3)), 'LineWidth', 1.5);
title('Test 3: Power Spectral Density');
xlabel('Frequency (MHz)');
ylabel('Power (dB)');
grid on;
xlim([-10, 10]);

%% Detailed Analysis
fprintf('\n========================================\n');
fprintf('Detailed Analysis\n');
fprintf('========================================\n\n');

% Preamble length analysis
preamble_samples = 160 + 160 + 80 + 160 + 80 + 80;  % L-STF + L-LTF + L-SIG + HT-SIG + HT-STF + HT-LTF

fprintf('Preamble Structure:\n');
fprintf('  L-STF:   160 samples (10 x 16 @ 50ns = 8.0 µs)\n');
fprintf('  L-LTF:   160 samples (2 x (16+64) @ 50ns = 8.0 µs)\n');
fprintf('  L-SIG:    80 samples (16+64 @ 50ns = 4.0 µs)\n');
fprintf('  HT-SIG:  160 samples (2 x (16+64) @ 50ns = 8.0 µs)\n');
fprintf('  HT-STF:   80 samples (5 x 16 @ 50ns = 4.0 µs)\n');
fprintf('  HT-LTF:   80 samples (16+64 @ 50ns = 4.0 µs)\n');
fprintf('  Total:   720 samples (36.0 µs)\n\n');

fprintf('Test Case Comparison:\n');
fprintf('  Case 1 (MCS 3): %d total samples, %d DATA samples\n', ...
    length(iq_samples_1), length(iq_samples_1) - preamble_samples);
fprintf('  Case 2 (MCS 5): %d total samples, %d DATA samples\n', ...
    length(iq_samples_2), length(iq_samples_2) - preamble_samples);
fprintf('  Case 3 (MCS 0): %d total samples, %d DATA samples\n', ...
    length(iq_samples_3), length(iq_samples_3) - preamble_samples);

fprintf('\nPower Analysis:\n');
fprintf('  Case 1 Avg Power: %.2f dB\n', 10*log10(mean(abs(iq_samples_1).^2)));
fprintf('  Case 2 Avg Power: %.2f dB\n', 10*log10(mean(abs(iq_samples_2).^2)));
fprintf('  Case 3 Avg Power: %.2f dB\n', 10*log10(mean(abs(iq_samples_3).^2)));

fprintf('\n========================================\n');
fprintf('All tests completed successfully!\n');
fprintf('========================================\n');

%% Save results (optional)
% Uncomment to save IQ samples to .mat file
% save('ofdm_ht_test_results.mat', 'iq_samples_1', 'iq_samples_2', 'iq_samples_3');
% fprintf('Results saved to ofdm_ht_test_results.mat\n');
