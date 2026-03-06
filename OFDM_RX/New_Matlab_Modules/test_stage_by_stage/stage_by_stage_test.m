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
        fprintf('  Trigger detected at sample: %d\n', stage1_result.trigger_idx);
        fprintf('  Expected range: %d-%d samples\n', ...
                packet_info.preamble_start-10, packet_info.preamble_start+10);
        report.stages{end+1} = struct('name', 'Power Trigger', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
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
    stage2_result = test_stage2_sync_short(samples_i, samples_q, stage1_result, config);
    
    if stage2_result.pass
        fprintf('✓ STAGE 2 PASSED\n');
        fprintf('  Short preamble detected at: %d\n', stage2_result.detection_idx);
        fprintf('  CFO phase: %.4f rad\n', stage2_result.cfo_phase);
        fprintf('  Metric peak: %.2f\n', stage2_result.metric_peak);
        report.stages{end+1} = struct('name', 'Sync Short', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 2 FAILED\n');
        fprintf('  Reason: %s\n', stage2_result.reason);
        report.stages{end+1} = struct('name', 'Sync Short', 'status', 'FAIL', 'reason', stage2_result.reason);
        report.failed_stages = report.failed_stages + 1;
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
        fprintf('  Long preamble detected at: %d\n', stage3_result.detection_idx);
        fprintf('  FFT symbols extracted: %d\n', stage3_result.num_symbols);
        fprintf('  Channel estimate valid: %d\n', stage3_result.channel_valid);
        report.stages{end+1} = struct('name', 'Sync Long', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 3 FAILED\n');
        fprintf('  Reason: %s\n', stage3_result.reason);
        report.stages{end+1} = struct('name', 'Sync Long', 'status', 'FAIL', 'reason', stage3_result.reason);
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
    stage4_result = test_stage4_equalizer(stage3_result, config);
    
    if stage4_result.pass
        fprintf('✓ STAGE 4 PASSED\n');
        fprintf('  Equalized symbols: %d\n', stage4_result.num_symbols);
        fprintf('  Data carriers per symbol: %d\n', stage4_result.num_carriers);
        fprintf('  SNR estimate: %.2f dB\n', stage4_result.snr_db);
        report.stages{end+1} = struct('name', 'Equalizer', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 4 FAILED\n');
        fprintf('  Reason: %s\n', stage4_result.reason);
        report.stages{end+1} = struct('name', 'Equalizer', 'status', 'FAIL', 'reason', stage4_result.reason);
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
    stage5_result = test_stage5_demodulate(stage4_result, config);
    
    if stage5_result.pass
        fprintf('✓ STAGE 5 PASSED\n');
        fprintf('  Demodulated symbols: %d\n', stage5_result.num_symbols);
        fprintf('  Total soft bits: %d\n', stage5_result.total_bits);
        fprintf('  Modulation: %s\n', stage5_result.modulation);
        report.stages{end+1} = struct('name', 'Demodulate', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 5 FAILED\n');
        fprintf('  Reason: %s\n', stage5_result.reason);
        report.stages{end+1} = struct('name', 'Demodulate', 'status', 'FAIL', 'reason', stage5_result.reason);
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
    stage6_result = test_stage6_deinterleave(stage5_result, config);
    
    if stage6_result.pass
        fprintf('✓ STAGE 6 PASSED\n');
        fprintf('  Deinterleaved bits: %d\n', stage6_result.total_bits);
        fprintf('  Erasure count: %d\n', stage6_result.erasure_count);
        report.stages{end+1} = struct('name', 'Deinterleave', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 6 FAILED\n');
        fprintf('  Reason: %s\n', stage6_result.reason);
        report.stages{end+1} = struct('name', 'Deinterleave', 'status', 'FAIL', 'reason', stage6_result.reason);
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
    stage7_result = test_stage7_viterbi(stage6_result, config);
    
    if stage7_result.pass
        fprintf('✓ STAGE 7 PASSED\n');
        fprintf('  Decoded bits: %d\n', stage7_result.decoded_bits);
        fprintf('  BER estimate: %.2e\n', stage7_result.ber_estimate);
        report.stages{end+1} = struct('name', 'Viterbi', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 7 FAILED\n');
        fprintf('  Reason: %s\n', stage7_result.reason);
        report.stages{end+1} = struct('name', 'Viterbi', 'status', 'FAIL', 'reason', stage7_result.reason);
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
    stage8_result = test_stage8_descramble(stage7_result, config);
    
    if stage8_result.pass
        fprintf('✓ STAGE 8 PASSED\n');
        fprintf('  Descrambled bits: %d\n', stage8_result.total_bits);
        fprintf('  Scrambler initialized: %d\n', stage8_result.init_success);
        report.stages{end+1} = struct('name', 'Descramble', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 8 FAILED\n');
        fprintf('  Reason: %s\n', stage8_result.reason);
        report.stages{end+1} = struct('name', 'Descramble', 'status', 'FAIL', 'reason', stage8_result.reason);
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
    stage9_result = test_stage9_bits_to_bytes(stage8_result, config);
    
    if stage9_result.pass
        fprintf('✓ STAGE 9 PASSED\n');
        fprintf('  Total bytes: %d\n', stage9_result.total_bytes);
        fprintf('  Payload bytes: %d (expected: %d)\n', ...
                stage9_result.payload_bytes, config.payload_bytes);
        report.stages{end+1} = struct('name', 'Bits to Bytes', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 9 FAILED\n');
        fprintf('  Reason: %s\n', stage9_result.reason);
        report.stages{end+1} = struct('name', 'Bits to Bytes', 'status', 'FAIL', 'reason', stage9_result.reason);
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
    stage10_result = test_stage10_crc32(stage9_result, config);
    
    if stage10_result.pass
        fprintf('✓ STAGE 10 PASSED\n');
        fprintf('  FCS check: %s\n', stage10_result.fcs_status);
        fprintf('  CRC computed: 0x%08X\n', stage10_result.crc_computed);
        fprintf('  CRC received: 0x%08X\n', stage10_result.crc_received);
        report.stages{end+1} = struct('name', 'CRC32', 'status', 'PASS');
        report.passed_stages = report.passed_stages + 1;
    else
        fprintf('✗ STAGE 10 FAILED\n');
        fprintf('  Reason: %s\n', stage10_result.reason);
        report.stages{end+1} = struct('name', 'CRC32', 'status', 'FAIL', 'reason', stage10_result.reason);
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
generate_html_report(report, 'test_reports/stage_by_stage_report.html');

fprintf('\nReport saved to: test_reports/stage_by_stage_report.html\n');
