%% test_phase_rotation_block.m
% Test the complete Phase Rotation Block
% This demonstrates testing multiple modules together as one functional block

clear all;
close all;
clc;

fprintf('========================================\n');
fprintf('  Testing: Phase Rotation BLOCK\n');
fprintf('  (Combines phase.m + rotate.m)\n');
fprintf('========================================\n');

% Add paths
addpath('../fft_and_phase_rotation_modules');
addpath('../fft_and_phase_rotation_modules');

%% Test 1: Simple Phase Offset Correction
fprintf('\nTest 1: Correcting 30-degree phase offset...\n');

% Create OFDM symbol with known 30-degree offset
phase_offset_deg = 30;
phase_offset_rad = deg2rad(phase_offset_deg);
N = 64;  % 64 subcarriers

% Original constellation (BPSK on I-axis)
original = zeros(N, 2);
for k = 1:N
    original(k, 1) = (randi([0,1])*2-1) * 1000;  % ±1000
    original(k, 2) = 0;
end

% Apply phase offset (simulate frequency error)
received = zeros(N, 2);
for k = 1:N
    received(k, 1) = original(k, 1) * cos(phase_offset_rad) - ...
                     original(k, 2) * sin(phase_offset_rad);
    received(k, 2) = original(k, 1) * sin(phase_offset_rad) + ...
                     original(k, 2) * cos(phase_offset_rad);
end

% Define pilot indices (standard 802.11 positions: 7, 21, 43, 57)
pilot_indices = [7, 21, 43, 57];

% Expected pilots (all +1 in this case)
expected_pilots = [1000, 0; 1000, 0; 1000, 0; 1000, 0];

% Run phase rotation block multiple times to fill pipeline
fprintf('  Filling pipeline...\n');
for warmup = 1:50
    [corrected, phase_est] = phase_rotation_block(received, pilot_indices, expected_pilots);
end

% Check correction quality
% After correction, Q component should be small
avg_q_error = mean(abs(corrected(:, 2)));
fprintf('  Average Q error after correction: %.1f\n', avg_q_error);

if avg_q_error < 200
    fprintf('  ✓ PASS: Phase correction working\n');
else
    fprintf('  ✗ FAIL: Phase correction insufficient\n');
end

%% Test 2: Multiple Symbols with Varying Offsets
fprintf('\nTest 2: Processing multiple symbols...\n');

num_symbols = 10;
test_offsets = linspace(-pi/4, pi/4, num_symbols);

errors_before = [];
errors_after = [];

for sym = 1:num_symbols
    offset = test_offsets(sym);
    
    % Generate symbol
    orig = zeros(N, 2);
    for k = 1:N
        orig(k, 1) = (randi([0,1])*2-1) * 1000;
        orig(k, 2) = 0;
    end
    
    % Add offset
    rx = zeros(N, 2);
    for k = 1:N
        rx(k, 1) = orig(k, 1) * cos(offset) - orig(k, 2) * sin(offset);
        rx(k, 2) = orig(k, 1) * sin(offset) + orig(k, 2) * cos(offset);
    end
    
    % Measure error before correction
    errors_before(sym) = mean(abs(rx(:, 2)));
    
    % Apply correction
    [corr, ~] = phase_rotation_block(rx, pilot_indices, expected_pilots);
    
    % Measure error after correction
    errors_after(sym) = mean(abs(corr(:, 2)));
end

improvement_db = 10*log10(mean(errors_before) / mean(errors_after));
fprintf('  Average error before: %.1f\n', mean(errors_before));
fprintf('  Average error after:  %.1f\n', mean(errors_after));
fprintf('  Improvement: %.1f dB\n', improvement_db);

if improvement_db > 10
    fprintf('  ✓ PASS: Significant improvement (>10 dB)\n');
else
    fprintf('  ✗ FAIL: Insufficient improvement\n');
end

%% Test 3: Visualization
fprintf('\nGenerating visualization...\n');

figure('Name', 'Phase Rotation Block Test', 'Position', [100, 100, 1200, 400]);

% Plot 1: Before correction
subplot(1, 3, 1);
scatter(received(:, 1), received(:, 2), 50, 'ro', 'filled');
hold on;
scatter(received(pilot_indices, 1), received(pilot_indices, 2), 100, 'bs', 'LineWidth', 2);
grid on;
xlabel('I Component');
ylabel('Q Component');
title('Before Correction (Rotated)');
legend('Data', 'Pilots', 'Location', 'best');
axis equal;

% Plot 2: After correction
subplot(1, 3, 2);
scatter(corrected(:, 1), corrected(:, 2), 50, 'go', 'filled');
hold on;
scatter(corrected(pilot_indices, 1), corrected(pilot_indices, 2), 100, 'bs', 'LineWidth', 2);
grid on;
xlabel('I Component');
ylabel('Q Component');
title('After Correction (Aligned)');
legend('Data', 'Pilots', 'Location', 'best');
axis equal;

% Plot 3: Error reduction
subplot(1, 3, 3);
plot(errors_before, 'r-o', 'LineWidth', 2);
hold on;
plot(errors_after, 'g-o', 'LineWidth', 2);
grid on;
xlabel('Symbol Index');
ylabel('Average Q Error');
title('Error Reduction Per Symbol');
legend('Before', 'After', 'Location', 'best');

fprintf('\n========================================\n');
fprintf('  Phase Rotation Block: COMPLETE\n');
fprintf('========================================\n');
fprintf('\n✓ This demonstrates testing a COMPLETE BLOCK\n');
fprintf('  (phase.m + rotate.m working together)\n');
