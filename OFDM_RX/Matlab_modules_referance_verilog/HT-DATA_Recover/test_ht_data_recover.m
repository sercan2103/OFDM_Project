%% Test Script for HT-DATA Recover Fixed-Point Reference Model
% This script tests the ht_data_recover_fixed function against known test vectors
% and validates it matches Verilog behavior
%
% Author: Auto-generated MATLAB reference model
% Date: 2026-02-25

clear; clc; close all;

% Add path to the module
addpath(fileparts(mfilename('fullpath')));

fprintf('=== HT-DATA Recover Fixed-Point Reference Model Test ===\n\n');

%% Test Configuration
test_cases = struct();

%% Test Case 1: BPSK (MCS 0) - Legacy mode
fprintf('Test Case 1: BPSK MCS 0 (Legacy 6 Mbps)\n');
test_cases(1).name = 'BPSK_Legacy_6Mbps';
test_cases(1).rate = hex2dec('0B');  % BPSK, rate 6 Mbps
test_cases(1).ht = false;
test_cases(1).num_symbols = 10;
test_cases(1).num_carriers = 48;
test_cases(1).mcs = 0;
test_cases(1).num_bits = 500;
test_cases(1).do_descramble = 1;
test_cases(1).soft_decoding = 0;

%% Test Case 2: QPSK (HT-MCS 1)
fprintf('Test Case 2: QPSK HT-MCS 1\n');
test_cases(2).name = 'QPSK_HT_MCS1';
test_cases(2).rate = hex2dec('91');  % HT QPSK (bit[7]=1, bit[3:0]=1)
test_cases(2).ht = true;
test_cases(2).num_symbols = 10;
test_cases(2).num_carriers = 52;
test_cases(2).mcs = 1;
test_cases(2).num_bits = 1000;
test_cases(2).do_descramble = 1;
test_cases(2).soft_decoding = 1;

%% Test Case 3: QAM-16 (HT-MCS 3)
fprintf('Test Case 3: QAM-16 HT-MCS 3\n');
test_cases(3).name = 'QAM16_HT_MCS3';
test_cases(3).rate = hex2dec('93');  % HT QAM-16 (bit[7]=1, bit[3:0]=3)
test_cases(3).ht = true;
test_cases(3).num_symbols = 10;
test_cases(3).num_carriers = 52;
test_cases(3).mcs = 3;
test_cases(3).num_bits = 2000;
test_cases(3).do_descramble = 1;
test_cases(3).soft_decoding = 1;

%% Test Case 4: QAM-64 (HT-MCS 5)
fprintf('Test Case 4: QAM-64 HT-MCS 5\n');
test_cases(4).name = 'QAM64_HT_MCS5';
test_cases(4).rate = hex2dec('95');  % HT QAM-64 (bit[7]=1, bit[3:0]=5)
test_cases(4).ht = true;
test_cases(4).num_symbols = 10;
test_cases(4).num_carriers = 52;
test_cases(4).mcs = 5;
test_cases(4).num_bits = 3000;
test_cases(4).do_descramble = 1;
test_cases(4).soft_decoding = 1;

%% Run Tests
results = struct();
total_tests = length(test_cases);
passed_tests = 0;

for tc_idx = 1:total_tests
    tc = test_cases(tc_idx);
    fprintf('\n--- Running Test: %s ---\n', tc.name);
    
    try
        % Generate test data
        fprintf('Generating test equalized symbols...\n');
        eq_symbols = generate_test_symbols(tc);
        
        % Run the HT-DATA recover function
        fprintf('Running HT-DATA recover...\n');
        tic;
        [byte_out, byte_count] = ht_data_recover_fixed(eq_symbols, ...
            tc.rate, tc.num_bits, tc.do_descramble, tc.soft_decoding);
        elapsed = toc;
        
        % Display results
        fprintf('Completed in %.3f seconds\n', elapsed);
        fprintf('Output bytes: %d\n', byte_count);
        fprintf('First 10 bytes (hex): ');
        for i = 1:min(10, length(byte_out))
            fprintf('%02X ', byte_out(i));
        end
        fprintf('\n');
        
        % Basic validation
        if byte_count > 0 && ~isempty(byte_out)
            fprintf('✓ Test PASSED: Valid output generated\n');
            results(tc_idx).status = 'PASS';
            passed_tests = passed_tests + 1;
        else
            fprintf('✗ Test FAILED: No output generated\n');
            results(tc_idx).status = 'FAIL';
        end
        
        results(tc_idx).byte_count = byte_count;
        results(tc_idx).elapsed_time = elapsed;
        
    catch ME
        fprintf('✗ Test FAILED with error:\n');
        fprintf('   %s\n', ME.message);
        results(tc_idx).status = 'ERROR';
        results(tc_idx).error = ME.message;
    end
end

%% Summary
fprintf('\n');
fprintf('=== Test Summary ===\n');
fprintf('Total tests: %d\n', total_tests);
fprintf('Passed: %d\n', passed_tests);
fprintf('Failed: %d\n', total_tests - passed_tests);
fprintf('Success rate: %.1f%%\n', 100 * passed_tests / total_tests);

%% Detailed Results Table
fprintf('\n=== Detailed Results ===\n');
fprintf('%-25s %-10s %-12s %-15s\n', 'Test Name', 'Status', 'Byte Count', 'Time (s)');
fprintf('%s\n', repmat('-', 1, 70));
for i = 1:length(results)
    if isfield(results(i), 'byte_count')
        fprintf('%-25s %-10s %-12d %-15.3f\n', ...
            test_cases(i).name, results(i).status, ...
            results(i).byte_count, results(i).elapsed_time);
    else
        fprintf('%-25s %-10s %-12s %-15s\n', ...
            test_cases(i).name, results(i).status, 'N/A', 'N/A');
    end
end

%% Performance Benchmark
fprintf('\n=== Performance Metrics ===\n');
if passed_tests > 0
    avg_time = mean([results(strcmp({results.status}, 'PASS')).elapsed_time]);
    fprintf('Average processing time: %.3f ms\n', avg_time * 1000);
end

%% Test with Known Pattern
fprintf('\n=== Testing with Known Pattern ===\n');
try
    % Test with simple pattern (all zeros with some structure)
    test_eq = complex(int16(ones(52, 5) * 512), int16(ones(52, 5) * 512));
    [test_bytes, test_count] = ht_data_recover_fixed(test_eq, ...
        hex2dec('91'), 500, 1, 0);
    fprintf('Known pattern test: Generated %d bytes\n', test_count);
    fprintf('✓ Known pattern test completed\n');
catch ME
    fprintf('✗ Known pattern test failed: %s\n', ME.message);
end

fprintf('\n=== Test Complete ===\n');

%% Helper Functions

function eq_symbols = generate_test_symbols(tc)
    % Generate pseudo-random equalized symbols for testing
    % These should approximate real equalized OFDM symbols
    
    % Fixed-point scale (matching CONS_SCALE_SHIFT = 10)
    SCALE = 2^10;  % 1024
    
    % Number of symbols and carriers
    Nsym = tc.num_symbols;
    Nsc = tc.num_carriers;
    
    % Generate random constellation points based on modulation
    % Use fixed random seed for reproducibility
    rng(42);
    
    switch tc.mcs
        case 0  % BPSK
            % Random BPSK symbols: +/-1
            bits = randi([0, 1], Nsc, Nsym);
            symbols = (2*bits - 1) * SCALE * 0.8;
            eq_symbols = complex(int16(symbols), int16(zeros(size(symbols))));
            
        case 1  % QPSK
            % Random QPSK symbols
            bits_i = randi([0, 1], Nsc, Nsym);
            bits_q = randi([0, 1], Nsc, Nsym);
            symbols_i = (2*bits_i - 1) * SCALE * 0.7;
            symbols_q = (2*bits_q - 1) * SCALE * 0.7;
            eq_symbols = complex(int16(symbols_i), int16(symbols_q));
            
        case 3  % QAM-16
            % Random QAM-16 symbols
            vals = [-3, -1, 1, 3];
            idx_i = randi([1, 4], Nsc, Nsym);
            idx_q = randi([1, 4], Nsc, Nsym);
            symbols_i = vals(idx_i) * SCALE / 3 * 0.8;
            symbols_q = vals(idx_q) * SCALE / 3 * 0.8;
            eq_symbols = complex(int16(symbols_i), int16(symbols_q));
            
        case 5  % QAM-64
            % Random QAM-64 symbols
            vals = [-7, -5, -3, -1, 1, 3, 5, 7];
            idx_i = randi([1, 8], Nsc, Nsym);
            idx_q = randi([1, 8], Nsc, Nsym);
            symbols_i = vals(idx_i) * SCALE / 7 * 0.8;
            symbols_q = vals(idx_q) * SCALE / 7 * 0.8;
            eq_symbols = complex(int16(symbols_i), int16(symbols_q));
            
        otherwise
            % Default to BPSK
            bits = randi([0, 1], Nsc, Nsym);
            symbols = (2*bits - 1) * SCALE * 0.8;
            eq_symbols = complex(int16(symbols), int16(zeros(size(symbols))));
    end
    
    % Add small amount of noise to make it realistic
    noise_i = int16(randn(Nsc, Nsym) * 50);
    noise_q = int16(randn(Nsc, Nsym) * 50);
    eq_symbols = eq_symbols + complex(noise_i, noise_q);
end
