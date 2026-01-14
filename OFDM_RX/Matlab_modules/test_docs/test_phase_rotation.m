% test_phase_rotation.m
% Detailed test for phase rotation modules
% Tests phase calculation and rotation accuracy

clear all;
close all;
clc;

fprintf('======================================================\n');
fprintf('  Phase Rotation Module - Detailed Test\n');
fprintf('======================================================\n\n');

% Add path
addpath('part1_phase_rotation');

%% Test 1: Phase Calculation Accuracy
fprintf('Test 1: Phase Calculation Accuracy\n');
fprintf('-----------------------------------\n');

% Test angles
test_angles = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, ...
               5*pi/6, pi, -pi/6, -pi/4, -pi/3, -pi/2];
test_labels = {'0', 'π/6', 'π/4', 'π/3', 'π/2', '2π/3', '3π/4', ...
               '5π/6', 'π', '-π/6', '-π/4', '-π/3', '-π/2'};

% Initialize
state = struct();
state.div_state.pipeline = zeros(36, 1);
state.pipeline = zeros(40, 4);

results = zeros(size(test_angles));
errors = zeros(size(test_angles));

for i = 1:length(test_angles)
    angle = test_angles(i);
    
    % Create complex sample at this angle
    magnitude = 1000;
    I = round(magnitude * cos(angle));
    Q = round(magnitude * sin(angle));
    
    % Process through phase module (fill pipeline)
    for k = 1:50
        [phase_out, state] = phase(I, Q, state);
    end
    
    % Convert output to radians
    phase_radians = double(phase_out) / 512;
    results(i) = phase_radians;
    errors(i) = abs(phase_radians - angle);
    
    fprintf('  %-6s: Expected=%7.4f, Got=%7.4f, Error=%7.4f rad\n', ...
            test_labels{i}, angle, phase_radians, errors(i));
end

fprintf('\nStatistics:\n');
fprintf('  Mean Error:    %.4f radians (%.2f degrees)\n', mean(errors), rad2deg(mean(errors)));
fprintf('  Max Error:     %.4f radians (%.2f degrees)\n', max(errors), rad2deg(max(errors)));
fprintf('  RMS Error:     %.4f radians (%.2f degrees)\n', rms(errors), rad2deg(rms(errors)));

if max(errors) < 0.1
    fprintf('  ✓ PASS: Phase accuracy within tolerance\n');
else
    fprintf('  ✗ FAIL: Phase error too large\n');
end

%% Test 2: Rotation Accuracy
fprintf('\n\nTest 2: Rotation Accuracy\n');
fprintf('-------------------------\n');

% Test rotation by various angles
rotate_angles = [0, pi/4, pi/2, pi, -pi/2];
rotate_labels = {'0', 'π/4', 'π/2', 'π', '-π/2'};

rot_state = struct();
rot_state.mult_state.pipeline = zeros(5, 2);
rot_state.in_delay = zeros(4, 2);
rot_state.phase_pipeline = zeros(4, 3);

for i = 1:length(rotate_angles)
    angle = rotate_angles(i);
    phase_scaled = round(angle * 512);
    
    % Original sample
    orig_i = 1000;
    orig_q = 500;
    
    % Expected after rotation
    expected_i = orig_i * cos(angle) - orig_q * sin(angle);
    expected_q = orig_i * sin(angle) + orig_q * cos(angle);
    
    % Process through rotate module
    for k = 1:20
        [out_i, out_q, rot_state] = rotate(orig_i, orig_q, phase_scaled, rot_state);
    end
    
    % Calculate error
    error_i = abs(out_i - expected_i);
    error_q = abs(out_q - expected_q);
    
    fprintf('  %-6s: I_err=%6.1f, Q_err=%6.1f', rotate_labels{i}, error_i, error_q);
    
    if error_i < 50 && error_q < 50
        fprintf(' ✓ PASS\n');
    else
        fprintf(' ✗ FAIL\n');
    end
end

%% Test 3: Phase + Rotate Integration (CFO Correction)
fprintf('\n\nTest 3: CFO Correction (Phase + Rotate)\n');
fprintf('---------------------------------------\n');

% Simulate carrier frequency offset
cfo_hz = 1000; % 1 kHz offset
fs = 20e6;     % 20 MHz sample rate
N = 100;

phase_state = struct();
phase_state.div_state.pipeline = zeros(36, 1);
phase_state.pipeline = zeros(40, 4);

rotate_state = struct();
rotate_state.mult_state.pipeline = zeros(5, 2);
rotate_state.in_delay = zeros(4, 2);
rotate_state.phase_pipeline = zeros(4, 3);

errors_i = [];
errors_q = [];

for n = 1:N
    % Original constellation point
    orig_i = (randi([0,1])*2-1) * 1000;
    orig_q = (randi([0,1])*2-1) * 1000;
    
    % Apply CFO
    phase_error = 2*pi*cfo_hz*n/fs;
    rx_i = round(orig_i * cos(phase_error) - orig_q * sin(phase_error));
    rx_q = round(orig_i * sin(phase_error) + orig_q * cos(phase_error));
    
    % Estimate phase
    [est_phase, phase_state] = phase(rx_i, rx_q, phase_state);
    
    % Correct rotation
    [corr_i, corr_q, rotate_state] = rotate(rx_i, rx_q, -est_phase, rotate_state);
    
    % Calculate error (after pipeline fills)
    if n > 50
        errors_i(end+1) = abs(corr_i - orig_i);
        errors_q(end+1) = abs(corr_q - orig_q);
    end
end

fprintf('  Samples processed: %d\n', N);
fprintf('  Mean I error:      %.1f\n', mean(errors_i));
fprintf('  Mean Q error:      %.1f\n', mean(errors_q));
fprintf('  Max I error:       %.1f\n', max(errors_i));
fprintf('  Max Q error:       %.1f\n', max(errors_q));

if mean(errors_i) < 100 && mean(errors_q) < 100
    fprintf('  ✓ PASS: CFO correction working\n');
else
    fprintf('  ✗ FAIL: CFO correction errors too large\n');
end

%% Test 4: Complex Multiplication Test
fprintf('\n\nTest 4: Complex Multiplication\n');
fprintf('------------------------------\n');

mult_state = struct();
mult_state.pipeline = zeros(5, 2);

test_cases = [
    3, 4, 1, 2, -5, 10;      % (3+4i)*(1+2i) = -5+10i
    5, 0, 2, 0, 10, 0;       % (5+0i)*(2+0i) = 10+0i
    0, 5, 0, 2, -10, 0;      % (0+5i)*(0+2i) = -10+0i
    1, 1, 1, -1, 2, 0;       % (1+1i)*(1-1i) = 2+0i
];

for i = 1:size(test_cases, 1)
    a_i = test_cases(i, 1);
    a_q = test_cases(i, 2);
    b_i = test_cases(i, 3);
    b_q = test_cases(i, 4);
    exp_i = test_cases(i, 5);
    exp_q = test_cases(i, 6);
    
    % Process
    for k = 1:10
        [p_i, p_q, mult_state] = complex_mult(a_i, a_q, b_i, b_q, mult_state);
    end
    
    error_i = abs(p_i - exp_i);
    error_q = abs(p_q - exp_q);
    
    fprintf('  (%d%+di)*(%d%+di) = %d%+di: ', a_i, a_q, b_i, b_q, p_i, p_q);
    
    if error_i < 2 && error_q < 2
        fprintf('✓ PASS\n');
    else
        fprintf('✗ FAIL (expected %d%+di)\n', exp_i, exp_q);
    end
end

%% Visualization
fprintf('\n\nGenerating Plots...\n');

figure('Name', 'Phase Rotation Test Results', 'Position', [100, 100, 1200, 400]);

% Plot 1: Phase accuracy
subplot(1, 3, 1);
plot(test_angles, results, 'bo-', 'LineWidth', 2);
hold on;
plot([-pi, pi], [-pi, pi], 'r--', 'LineWidth', 1);
grid on;
xlabel('Expected Phase (radians)');
ylabel('Measured Phase (radians)');
title('Phase Calculation Accuracy');
legend('Measured', 'Ideal', 'Location', 'northwest');

% Plot 2: Phase errors
subplot(1, 3, 2);
bar(errors * 1000);
set(gca, 'XTickLabel', test_labels);
grid on;
ylabel('Error (milliradians)');
title('Phase Calculation Errors');
xtickangle(45);

% Plot 3: CFO correction errors
subplot(1, 3, 3);
plot(errors_i, 'b.-');
hold on;
plot(errors_q, 'r.-');
grid on;
xlabel('Sample Number');
ylabel('Error Magnitude');
title('CFO Correction Errors');
legend('I Error', 'Q Error', 'Location', 'best');

fprintf('\n✓ Test Complete. Check plots for visual inspection.\n');
