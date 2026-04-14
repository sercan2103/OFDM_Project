%% STAGE_BY_STAGE_TEST - RX Pipeline Block-by-Block Verification
%
% Bu script RX pipeline'ini adim adim test eder:
%   1. TX formatinda test data olustur
%   2. Her blogu ayri ayri test et
%   3. Her blok sonrasi output'u analiz et
%   4. Rapor olustur (PASS/FAIL)
%   5. Bir sonraki bloga output'u input olarak ver
%
% Pipeline:
%   RF Samples → Power Trigger → Sync Short → Sync Long → 
%   Equalizer → Demodulate → Deinterleave → Viterbi → 
%   Descramble → Bits to Bytes → CRC32

clear all;
close all;
clc;

% Add paths
addpath('../Main_pipeline_moduller');
addpath('../basic_yardimci_moduller');
addpath('../lut_moduller');
addpath('test_generators');
addpath('test_validators');

fprintf('========================================\n');
fprintf('  RX PIPELINE STAGE-BY-STAGE TEST\n');
fprintf('========================================\n\n');

% Test configuration
config = struct();
config.packet_type = 'legacy';  % 'legacy' or 'ht'
config.rate = 6;                % 6 Mbps (BPSK, rate 1/2)
config.payload_bytes = 100;     % 100 byte payload
config.verbose = true;

% Test report
report = struct();
report.stages = {};
report.total_stages = 10;
report.passed_stages = 0;
report.failed_stages = 0;

% Structured test_results for HTML report
test_results = struct();

%% STAGE 0: Generate TX Data
fprintf('========================================\n');
fprintf('STAGE 0: TX Data Generation\n');
fprintf('========================================\n');

try
    % Generate 802.11a packet (preamble + SIGNAL + DATA)
    [samples_i, samples_q, packet_info] = generate_80211a_packet(config);
    
    fprintf('✓ TX data generated successfully\n');
    fprintf('  Packet type: %s\n', config.packet_type);
    fprintf('  Rate: %d Mbps\n', config.rate);
    fprintf('  Payload: %d bytes\n', config.payload_bytes);
    fprintf('  Total samples: %d\n', length(samples_i));
    fprintf('  Preamble: %d samples\n', packet_info.preamble_len);
    fprintf('  SIGNAL: %d samples\n', packet_info.signal_len);
    fprintf('  DATA: %d samples\n', packet_info.data_len);
    
    report.stages{end+1} = struct('name', 'TX Generation', 'status', 'PASS');
    report.passed_stages = report.passed_stages + 1;
    
    % Save for later analysis
    save('test_data/tx_samples.mat', 'samples_i', 'samples_q', 'packet_info');
    % Populate test_results for reporting
    test_results = struct();
    test_results.tx_generation = struct();
    test_results.tx_generation.packet_info = packet_info;
    test_results.tx_generation.pass = true;
    
catch ME
    fprintf('✗ TX data generation FAILED\n');
    fprintf('  Error: %s\n', ME.message);
    report.stages{end+1} = struct('name', 'TX Generation', 'status', 'FAIL', 'error', ME.message);
    report.failed_stages = report.failed_stages + 1;
    return;
end

%% STAGE 1: Power Trigger
fprintf('\n========================================\n');
fprintf('STAGE 1: Power Trigger Detection\n');
fprintf('========================================\n');

try
    stage1_result = test_stage1_power_trigger(samples_i, samples_q, config);
    
    if stage1_result.pass
        fprintf('✓ STAGE 1 PASSED\n');
        % Support multiple possible field names from validator
        if isfield(stage1_result, 'trigger_idx')
            trig_sample = stage1_result.trigger_idx;
        elseif isfield(stage1_result, 'trigger_sample')
            trig_sample = stage1_result.trigger_sample;
        else
            trig_sample = -1;
        end
        fprintf('  Trigger detected at sample: %d\n', trig_sample);
        fprintf('  Expected range: %d-%d samples\n', ...
                packet_info.preamble_start-10, packet_info.preamble_start+10);
        report.stages{end+1} = struct('name', 'Power Trigger', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
        % Update test_results
        test_results.stage1_power_trigger = struct();
        test_results.stage1_power_trigger.pass = true;
        test_results.stage1_power_trigger.trigger_sample = trig_sample;
        test_results.stage1_power_trigger.message = stage1_result.message;
    else
        fprintf('✗ STAGE 1 FAILED\n');
        fprintf('  Reason: %s\n', stage1_result.reason);
        report.stages{end+1} = struct('name', 'Power Trigger', 'status', 'FAIL', 'reason', stage1_result.reason);
        report.failed_stages = report.failed_stages + 1;
        return;
    end
    
    % Save stage output
    save('test_data/stage1_output.mat', 'stage1_result');
    
catch ME
    fprintf('✗ STAGE 1 EXCEPTION\n');
    fprintf('  Error: %s\n', ME.message);
    report.stages{end+1} = struct('name', 'Power Trigger', 'status', 'FAIL', 'error', ME.message);
    report.failed_stages = report.failed_stages + 1;
    return;
end

%% STAGE 2: Sync Short (CFO Estimation)
fprintf('\n========================================\n');
fprintf('STAGE 2: Sync Short (CFO Estimation)\n');
fprintf('========================================\n');

try
    % Pass numeric trigger offset to stage2 validator
    stage2_result = test_stage2_sync_short(samples_i, samples_q, trig_sample, config);
    
    if isstruct(stage2_result) && isfield(stage2_result,'pass') && stage2_result.pass
        fprintf('✓ STAGE 2 PASSED\n');
        % populate test_results (guard fields)
        test_results.stage2_sync_short = struct();
        test_results.stage2_sync_short.pass = true;
        if isfield(stage2_result,'phase_out')
            test_results.stage2_sync_short.phase_out = stage2_result.phase_out;
        end
        if isfield(stage2_result,'metric')
            test_results.stage2_sync_short.metric = stage2_result.metric;
        end
        report.stages{end+1} = struct('name', 'Sync Short', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 2 FAILED\n');
        % Determine a safe reason string regardless of validator return type
        if isstruct(stage2_result) && isfield(stage2_result,'reason')
            reason_str = stage2_result.reason;
        elseif ischar(stage2_result)
            reason_str = stage2_result;
        elseif isstring(stage2_result)
            reason_str = char(stage2_result);
        else
            reason_str = 'Short preamble not detected';
        end
        fprintf('  Reason: %s\n', reason_str);
        report.stages{end+1} = struct('name', 'Sync Short', 'status', 'FAIL', 'reason', reason_str);
        report.failed_stages = report.failed_stages + 1;
        % populate test_results for report
        test_results.stage2_sync_short = struct();
        test_results.stage2_sync_short.pass = false;
        test_results.stage2_sync_short.reason = reason_str;
        return;
    end
    
    save('test_data/stage2_output.mat', 'stage2_result');
    
catch ME
    fprintf('✗ STAGE 2 EXCEPTION\n');
    fprintf('  Error: %s\n', ME.message);
    report.stages{end+1} = struct('name', 'Sync Short', 'status', 'FAIL', 'error', ME.message);
    report.failed_stages = report.failed_stages + 1;
    return;
end

%% STAGE 3: Sync Long (FFT + Channel Estimation)
fprintf('\n========================================\n');
fprintf('STAGE 3: Sync Long (FFT + Channel Est)\n');
fprintf('========================================\n');

try
    stage3_result = test_stage3_sync_long(samples_i, samples_q, stage2_result, config);
    
    if stage3_result.pass
        fprintf('✓ STAGE 3 PASSED\n');
        % Use available fields from validator
        if isfield(stage3_result, 'freq_est')
            num_subcarriers = length(stage3_result.freq_est);
            fprintf('  Channel subcarriers: %d\n', num_subcarriers);
        end
        if isfield(stage3_result, 'fft_out')
            num_fft_samples = length(stage3_result.fft_out);
            fprintf('  FFT symbols extracted: %d\n', floor(num_fft_samples / 64));
        end
        report.stages{end+1} = struct('name', 'Sync Long', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 3 FAILED\n');
        if isfield(stage3_result, 'message')
            fprintf('  Reason: %s\n', stage3_result.message);
        end
        report.stages{end+1} = struct('name', 'Sync Long', 'status', 'FAIL', ...
                                    'reason', getfield(stage3_result, 'message', 'Unknown error'));
        report.failed_stages = report.failed_stages + 1;
        return;
    end
    
    save('test_data/stage3_output.mat', 'stage3_result');
    
catch ME
    fprintf('✗ STAGE 3 EXCEPTION\n');
    fprintf('  Error: %s\n', ME.message);
    report.stages{end+1} = struct('name', 'Sync Long', 'status', 'FAIL', 'error', ME.message);
    report.failed_stages = report.failed_stages + 1;
    return;
end

%% STAGE 4: Equalizer (Channel Correction)
fprintf('\n========================================\n');
fprintf('STAGE 4: Equalizer (Channel Correction)\n');
fprintf('========================================\n');

try
    % Extract FFT outputs and channel estimates from Stage 3 result
    if isfield(stage3_result, 'fft_out') && isfield(stage3_result, 'freq_est')
        fft_out = stage3_result.fft_out;
        % Split complex FFT output into I/Q
        fft_i = real(fft_out);
        fft_q = imag(fft_out);
        channel_est = stage3_result.freq_est;
    else
        error('Stage 3 output missing fft_out or freq_est fields');
    end
    
    % Call Stage 4 equalizer validator
    stage4_result = test_stage4_equalizer(fft_i, fft_q, channel_est, config, []);
    
    if stage4_result.pass
        fprintf('✓ STAGE 4 PASSED\n');
        if isfield(stage4_result, 'equalized')
            fprintf('  Equalized symbols: %d\n', length(stage4_result.equalized));
        end
        if isfield(stage4_result, 'message')
            fprintf('  Message: %s\n', stage4_result.message);
        end
        report.stages{end+1} = struct('name', 'Equalizer', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 4 FAILED\n');
        if isfield(stage4_result, 'message')
            fprintf('  Reason: %s\n', stage4_result.message);
        end
        report.stages{end+1} = struct('name', 'Equalizer', 'status', 'FAIL');
        report.failed_stages = report.failed_stages + 1;
        return;
    end
    
    save('test_data/stage4_output.mat', 'stage4_result');
    
catch ME
    fprintf('✗ STAGE 4 EXCEPTION\n');
    fprintf('  Error: %s\n', ME.message);
    report.stages{end+1} = struct('name', 'Equalizer', 'status', 'FAIL', 'error', ME.message);
    report.failed_stages = report.failed_stages + 1;
    return;
end

%% STAGE 5: Demodulate (Constellation → Soft Bits)
fprintf('\n========================================\n');
fprintf('STAGE 5: Demodulate (Soft Decision)\n');
fprintf('========================================\n');

try
    % Extract equalized symbols from Stage 4 result
    if isfield(stage4_result, 'equalized')
        equalized = stage4_result.equalized;
        equalized_i = real(equalized);
        equalized_q = imag(equalized);
    else
        error('Stage 4 output missing equalized field');
    end
    
    % Determine modulation type from SIGNAL field (hardcoded to BPSK for now)
    modulation_type = 0;  % 0=BPSK
    
    % Call Stage 5 demodulate validator
    stage5_result = test_stage5_demodulate(equalized_i, equalized_q, modulation_type, config, []);
    
    if stage5_result.pass
        fprintf('✓ STAGE 5 PASSED\n');
        if isfield(stage5_result, 'message')
            fprintf('  Message: %s\n', stage5_result.message);
        end
        if isfield(stage5_result, 'soft_bits')
            fprintf('  Soft bits generated: %d\n', length(stage5_result.soft_bits));
        end
        report.stages{end+1} = struct('name', 'Demodulate', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 5 FAILED\n');
        if isfield(stage5_result, 'message')
            fprintf('  Reason: %s\n', stage5_result.message);
        end
        report.stages{end+1} = struct('name', 'Demodulate', 'status', 'FAIL');
        report.failed_stages = report.failed_stages + 1;
        return;
    end
    
    save('test_data/stage5_output.mat', 'stage5_result');
    
catch ME
    fprintf('✗ STAGE 5 EXCEPTION\n');
    fprintf('  Error: %s\n', ME.message);
    report.stages{end+1} = struct('name', 'Demodulate', 'status', 'FAIL', 'error', ME.message);
    report.failed_stages = report.failed_stages + 1;
    return;
end

%% STAGE 6: Deinterleave (Bit Reordering)
fprintf('\n========================================\n');
fprintf('STAGE 6: Deinterleave (Bit Reordering)\n');
fprintf('========================================\n');

try
    % Extract soft bits from Stage 5 result
    if isfield(stage5_result, 'soft_bits')
        soft_bits = stage5_result.soft_bits;
    else
        error('Stage 5 output missing soft_bits field');
    end
    
    % Data rate (from SIGNAL field, hardcoded to rate 1 for now)
    rate = 1;
    
    % Call Stage 6 deinterleave validator
    stage6_result = test_stage6_deinterleave(soft_bits, rate, config, []);
    
    if stage6_result.pass
        fprintf('✓ STAGE 6 PASSED\n');
        if isfield(stage6_result, 'message')
            fprintf('  Message: %s\n', stage6_result.message);
        end
        if isfield(stage6_result, 'deinterleaved')
            fprintf('  Deinterleaved bits: %d\n', length(stage6_result.deinterleaved));
        end
        report.stages{end+1} = struct('name', 'Deinterleave', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 6 FAILED\n');
        if isfield(stage6_result, 'message')
            fprintf('  Reason: %s\n', stage6_result.message);
        end
        report.stages{end+1} = struct('name', 'Deinterleave', 'status', 'FAIL');
        report.failed_stages = report.failed_stages + 1;
        return;
    end
    
    save('test_data/stage6_output.mat', 'stage6_result');
    
catch ME
    fprintf('✗ STAGE 6 EXCEPTION\n');
    fprintf('  Error: %s\n', ME.message);
    report.stages{end+1} = struct('name', 'Deinterleave', 'status', 'FAIL', 'error', ME.message);
    report.failed_stages = report.failed_stages + 1;
    return;
end

%% STAGE 7: Viterbi Decode (Convolutional Decode)
fprintf('\n========================================\n');
fprintf('STAGE 7: Viterbi Decode (FEC)\n');
fprintf('========================================\n');

try
    % Extract deinterleaved bits from Stage 6 result
    if isfield(stage6_result, 'deinterleaved')
        deinterleaved_bits = stage6_result.deinterleaved;
    else
        error('Stage 6 output missing deinterleaved field');
    end
    
    % Call Stage 7 Viterbi validator
    stage7_result = test_stage7_viterbi(deinterleaved_bits, config, []);
    
    if stage7_result.pass
        fprintf('✓ STAGE 7 PASSED\n');
        if isfield(stage7_result, 'message')
            fprintf('  Message: %s\n', stage7_result.message);
        end
        if isfield(stage7_result, 'decoded_bits')
            fprintf('  Decoded bits: %d\n', length(stage7_result.decoded_bits));
        end
        report.stages{end+1} = struct('name', 'Viterbi', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 7 FAILED\n');
        if isfield(stage7_result, 'message')
            fprintf('  Reason: %s\n', stage7_result.message);
        end
        report.stages{end+1} = struct('name', 'Viterbi', 'status', 'FAIL');
        report.failed_stages = report.failed_stages + 1;
        return;
    end
    
    save('test_data/stage7_output.mat', 'stage7_result');
    
catch ME
    fprintf('✗ STAGE 7 EXCEPTION\n');
    fprintf('  Error: %s\n', ME.message);
    report.stages{end+1} = struct('name', 'Viterbi', 'status', 'FAIL', 'error', ME.message);
    report.failed_stages = report.failed_stages + 1;
    return;
end

%% STAGE 8: Descramble (LFSR Descramble)
fprintf('\n========================================\n');
fprintf('STAGE 8: Descramble (LFSR)\n');
fprintf('========================================\n');

try
    % Extract decoded bits from Stage 7 result
    if isfield(stage7_result, 'decoded_bits')
        decoded_bits = stage7_result.decoded_bits;
    else
        error('Stage 7 output missing decoded_bits field');
    end
    
    % Call Stage 8 descramble validator
    stage8_result = test_stage8_descramble(decoded_bits, config, []);
    
    if stage8_result.pass
        fprintf('✓ STAGE 8 PASSED\n');
        if isfield(stage8_result, 'message')
            fprintf('  Message: %s\n', stage8_result.message);
        end
        if isfield(stage8_result, 'descrambled')
            fprintf('  Descrambled bits: %d\n', length(stage8_result.descrambled));
        end
        report.stages{end+1} = struct('name', 'Descramble', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 8 FAILED\n');
        if isfield(stage8_result, 'message')
            fprintf('  Reason: %s\n', stage8_result.message);
        end
        report.stages{end+1} = struct('name', 'Descramble', 'status', 'FAIL');
        report.failed_stages = report.failed_stages + 1;
        return;
    end
    
    save('test_data/stage8_output.mat', 'stage8_result');
    
catch ME
    fprintf('✗ STAGE 8 EXCEPTION\n');
    fprintf('  Error: %s\n', ME.message);
    report.stages{end+1} = struct('name', 'Descramble', 'status', 'FAIL', 'error', ME.message);
    report.failed_stages = report.failed_stages + 1;
    return;
end

%% STAGE 9: Bits to Bytes Conversion
fprintf('\n========================================\n');
fprintf('STAGE 9: Bits to Bytes\n');
fprintf('========================================\n');

try
    % Extract descrambled bits from Stage 8 result
    if isfield(stage8_result, 'descrambled')
        descrambled_bits = stage8_result.descrambled;
    else
        error('Stage 8 output missing descrambled field');
    end
    
    % Call Stage 9 bits_to_bytes validator
    stage9_result = test_stage9_bits_to_bytes(descrambled_bits, config, []);
    
    if stage9_result.pass
        fprintf('✓ STAGE 9 PASSED\n');
        if isfield(stage9_result, 'message')
            fprintf('  Message: %s\n', stage9_result.message);
        end
        if isfield(stage9_result, 'bytes')
            fprintf('  Total bytes: %d\n', length(stage9_result.bytes));
        end
        report.stages{end+1} = struct('name', 'Bits to Bytes', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 9 FAILED\n');
        if isfield(stage9_result, 'message')
            fprintf('  Reason: %s\n', stage9_result.message);
        end
        report.stages{end+1} = struct('name', 'Bits to Bytes', 'status', 'FAIL');
        report.failed_stages = report.failed_stages + 1;
        return;
    end
    
    save('test_data/stage9_output.mat', 'stage9_result');
    
catch ME
    fprintf('✗ STAGE 9 EXCEPTION\n');
    fprintf('  Error: %s\n', ME.message);
    report.stages{end+1} = struct('name', 'Bits to Bytes', 'status', 'FAIL', 'error', ME.message);
    report.failed_stages = report.failed_stages + 1;
    return;
end

%% STAGE 10: CRC32 Validation
fprintf('\n========================================\n');
fprintf('STAGE 10: CRC32 Validation\n');
fprintf('========================================\n');

try
    % Extract bytes from Stage 9 result
    if isfield(stage9_result, 'bytes')
        output_bytes = stage9_result.bytes;
    else
        error('Stage 9 output missing bytes field');
    end
    
    % Call Stage 10 CRC32 validator
    stage10_result = test_stage10_crc32(output_bytes, config, []);
    
    if stage10_result.pass
        fprintf('✓ STAGE 10 PASSED\n');
        if isfield(stage10_result, 'message')
            fprintf('  Message: %s\n', stage10_result.message);
        end
        if isfield(stage10_result, 'payload')
            fprintf('  Payload bytes: %d\n', length(stage10_result.payload));
        end
        report.stages{end+1} = struct('name', 'CRC32', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 10 FAILED\n');
        if isfield(stage10_result, 'message')
            fprintf('  Reason: %s\n', stage10_result.message);
        end
        report.stages{end+1} = struct('name', 'CRC32', 'status', 'FAIL');
        report.failed_stages = report.failed_stages + 1;
        return;
    end
    
    save('test_data/stage10_output.mat', 'stage10_result');
    
catch ME
    fprintf('✗ STAGE 10 EXCEPTION\n');
    fprintf('  Error: %s\n', ME.message);
    report.stages{end+1} = struct('name', 'CRC32', 'status', 'FAIL', 'error', ME.message);
    report.failed_stages = report.failed_stages + 1;
    return;
end

%% Final Report
fprintf('\n========================================\n');
fprintf('  FINAL TEST REPORT\n');
fprintf('========================================\n');

fprintf('Total Stages: %d\n', report.total_stages);
fprintf('Passed: %d\n', report.passed_stages);
fprintf('Failed: %d\n', report.failed_stages);
fprintf('\n');

fprintf('Stage Results:\n');
for i = 1:length(report.stages)
    stage = report.stages{i};
    status_icon = '✓';
    if strcmp(stage.status, 'FAIL')
        status_icon = '✗';
    end
    fprintf('  [%s] %s: %s\n', status_icon, stage.name, stage.status);
    if isfield(stage, 'reason')
        fprintf('      Reason: %s\n', stage.reason);
    end
    if isfield(stage, 'error')
        fprintf('      Error: %s\n', stage.error);
    end
end

fprintf('\n');
if report.failed_stages == 0
    fprintf('✓✓✓ ALL TESTS PASSED! ✓✓✓\n');
else
    fprintf('✗✗✗ %d TESTS FAILED ✗✗✗\n', report.failed_stages);
end

% Save final report
save('test_data/final_report.mat', 'report');
% Generate HTML report from structured test_results
try
    generate_html_report(test_results, 'test_reports/stage_by_stage_report.html');
    fprintf('\nReport saved to: test_reports/stage_by_stage_report.html\n');
catch ME
    fprintf('Failed to generate HTML report: %s\n', ME.message);
end
