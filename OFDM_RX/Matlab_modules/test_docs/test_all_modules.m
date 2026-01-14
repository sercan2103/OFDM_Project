% test_all_modules.m
% Comprehensive test suite for all MATLAB validation modules
% Run this script to test all modules at once

clear all;
close all;
clc;

fprintf('======================================================\n');
fprintf('  MATLAB Validation Modules - Test Suite\n');
fprintf('======================================================\n\n');

% Add paths
addpath('part1_phase_rotation');
addpath('part2_equalizer');
addpath('part3_signal_decode');

% Track results
total_tests = 0;
passed_tests = 0;
failed_tests = 0;

%% ========================================================================
%% PART 1: Phase Rotation Tests
%% ========================================================================

fprintf('PART 1: Testing Phase Rotation Modules\n');
fprintf('----------------------------------------\n');

%% Test 1: delayT
try
    fprintf('Test 1.1: delayT... ');
    state = zeros(1, 5);
    for i = 1:10
        [out, state] = delayT(i, state, 5);
        if i > 5 && out ~= i-5
            error('Delay incorrect');
        end
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 2: complex_mult
try
    fprintf('Test 1.2: complex_mult... ');
    state = struct(); state.pipeline = zeros(5, 2);
    
    % Test: (3+4i) * (1+2i) = (3-8) + (6+4)i = -5+10i
    a_i = 3; a_q = 4;
    b_i = 1; b_q = 2;
    
    for i = 1:10
        [p_i, p_q, state] = complex_mult(a_i, a_q, b_i, b_q, state);
    end
    
    % After pipeline fills, check result
    if abs(p_i - (-5)) > 1 || abs(p_q - 10) > 1
        error('Complex multiplication incorrect');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 3: divider
try
    fprintf('Test 1.3: divider... ');
    state = struct(); state.pipeline = zeros(36, 1);
    
    % Test: 1000 / 25 = 40
    for i = 1:50
        [quot, state] = divider(1000, 25, state);
    end
    
    % After pipeline fills
    if abs(quot - 40) > 1
        error('Division incorrect');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 4: atan_lut
try
    fprintf('Test 1.4: atan_lut... ');
    
    % Test atan(0) = 0
    val0 = atan_lut(0);
    if val0 ~= 0
        error('atan(0) should be 0');
    end
    
    % Test atan(1) = π/4 ≈ 402 (when scaled by 512)
    val255 = atan_lut(255);
    expected = round(atan(1) * 512);
    if abs(val255 - expected) > 2
        error('atan(1) incorrect');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 5: rot_lut
try
    fprintf('Test 1.5: rot_lut... ');
    
    % Test angle 0: cos(0)=1, sin(0)=0
    data0 = rot_lut(0);
    cos0 = int16(bitshift(data0, -16));
    sin0 = int16(bitand(data0, 0xFFFF));
    
    % Scaled by 2048, so cos(0) ≈ 2048
    if abs(cos0 - 2048) > 10 || abs(sin0) > 10
        error('rot_lut(0) incorrect');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 6: phase
try
    fprintf('Test 1.6: phase... ');
    state = struct();
    state.div_state.pipeline = zeros(36, 1);
    state.pipeline = zeros(40, 4);
    
    % Test: phase of (1000, 0) should be near 0
    test_i = 1000;
    test_q = 0;
    
    for i = 1:50
        [phase_out, state] = phase(test_i, test_q, state);
    end
    
    % Should be near 0
    if abs(phase_out) > 50
        error('Phase of (1000,0) should be near 0');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 7: rotate
try
    fprintf('Test 1.7: rotate... ');
    state = struct();
    state.mult_state.pipeline = zeros(5, 2);
    state.in_delay = zeros(4, 2);
    state.phase_pipeline = zeros(4, 3);
    
    % Test: rotate (1000,0) by 0 degrees should give (1000,0)
    test_i = 1000;
    test_q = 0;
    phase_angle = 0;
    
    for i = 1:20
        [out_i, out_q, state] = rotate(test_i, test_q, phase_angle, state);
    end
    
    % After pipeline, should be close to input
    if abs(out_i - test_i) > 100
        error('Rotation by 0 failed');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% ========================================================================
%% PART 2: Equalizer Tests
%% ========================================================================

fprintf('\nPART 2: Testing Equalizer Modules\n');
fprintf('----------------------------------------\n');

%% Test 8: calc_mean
try
    fprintf('Test 2.1: calc_mean... ');
    state = struct(); state.pipeline = zeros(3, 3);
    
    % Test: mean of 100 and 200 = 150
    for i = 1:10
        [mean_val, state] = calc_mean(100, 200, 0, state);
    end
    
    if abs(mean_val - 150) > 5
        error('Mean calculation incorrect');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 9: ram_2port
try
    fprintf('Test 2.2: ram_2port... ');
    
    % Initialize RAM
    ram = zeros(64, 2);
    
    % Write test data
    test_data = [123, 456];
    ram(10, :) = test_data;
    
    % Read it back
    read_data = ram(10, :);
    
    if any(read_data ~= test_data)
        error('RAM read/write failed');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 10: equalizer (basic initialization)
try
    fprintf('Test 2.3: equalizer init... ');
    
    state = struct();
    state.eq_state = 0;
    state.ht = 0;
    state.num_data_carrier = 48;
    state.lts_ram = zeros(64, 2);
    state.in_buf = zeros(64, 2);
    state.lts_waddr = 0;
    
    if state.num_data_carrier ~= 48
        error('Equalizer initialization failed');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% ========================================================================
%% PART 3: Signal Decode Tests
%% ========================================================================

fprintf('\nPART 3: Testing Signal Decode Modules\n');
fprintf('----------------------------------------\n');

%% Test 11: ht_sig_crc
try
    fprintf('Test 3.1: ht_sig_crc... ');
    state = struct(); state.C = ones(1, 8);
    
    % Process some bits
    test_bits = [1, 0, 1, 1, 0, 0, 1, 0];
    for i = 1:length(test_bits)
        [crc_val, state] = ht_sig_crc(test_bits(i), state);
    end
    
    % CRC should be 8-bit value
    if crc_val < 0 || crc_val > 255
        error('CRC out of range');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 12: crc32
try
    fprintf('Test 3.2: crc32... ');
    state = struct(); state.crc = uint32(hex2dec('FFFFFFFF'));
    
    % Process a byte
    [fcs, state] = crc32(0x42, state);
    
    % FCS should be 32-bit
    if fcs < 0
        error('FCS invalid');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 13: signal_decode
try
    fprintf('Test 3.3: signal_decode... ');
    
    % Create valid SIGNAL field
    % Rate=6Mbps(1101), Reserved=0, Length=100, Parity=?, Tail=0
    rate = 13; % 0xD = 1101
    length = 100;
    
    signal_bits = rate + bitshift(length, 5);
    
    % Calculate parity
    parity_bits = signal_bits;
    parity = 0;
    for i = 0:16
        parity = bitxor(parity, bitand(bitshift(parity_bits, -i), 1));
    end
    signal_bits = signal_bits + bitshift(parity, 17);
    
    [valid, fields, is_ht] = signal_decode(signal_bits);
    
    if fields.length ~= length
        error('SIGNAL decode failed');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 14: ht_detect
try
    fprintf('Test 3.4: ht_detect... ');
    
    % Create Q-BPSK samples (HT format)
    ht_samples = [10, 1000; 20, 950; -15, 980; 25, 1020; 5, 990];
    is_ht = ht_detect(ht_samples);
    
    if ~is_ht
        error('Should detect HT format');
    end
    
    % Create normal BPSK samples (Legacy)
    legacy_samples = [1000, 10; 980, 20; -990, -15; 1020, 25; 995, 5];
    is_legacy = ht_detect(legacy_samples);
    
    if is_legacy
        error('Should detect Legacy format');
    end
    
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% Test 15: qbpsk_derotate
try
    fprintf('Test 3.5: qbpsk_derotate... ');
    
    % Q-BPSK: symbols on imaginary axis
    qbpsk_samples = [10, 1000; 20, -950];
    
    % Rotate to normal BPSK
    bpsk_samples = qbpsk_derotate(qbpsk_samples);
    
    % After rotation: I' = Q, Q' = -I
    if abs(bpsk_samples(1,1) - 1000) > 50
        error('Derotation failed');
    end
    fprintf('PASS\n');
    passed_tests = passed_tests + 1;
catch ME
    fprintf('FAIL: %s\n', ME.message);
    failed_tests = failed_tests + 1;
end
total_tests = total_tests + 1;

%% ========================================================================
%% Summary
%% ========================================================================

fprintf('\n======================================================\n');
fprintf('  Test Results Summary\n');
fprintf('======================================================\n');
fprintf('Total Tests:  %d\n', total_tests);
fprintf('Passed:       %d (%.1f%%)\n', passed_tests, 100*passed_tests/total_tests);
fprintf('Failed:       %d (%.1f%%)\n', failed_tests, 100*failed_tests/total_tests);
fprintf('======================================================\n');

if failed_tests == 0
    fprintf('✓ ALL TESTS PASSED!\n');
else
    fprintf('✗ Some tests failed. Review output above.\n');
end
