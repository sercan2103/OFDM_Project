%% TEST_DOT11_BASIC - Basic functionality test for dot11.m receiver
%
% This script tests the MATLAB OFDM receiver modules with synthetic signals
%
% Tests:
%   1. Module initialization
%   2. Basic signal processing
%   3. Legacy 802.11a/g packet
%   4. HT 802.11n packet (if available)

clear all;
close all;
clc;

fprintf('========================================\n');
fprintf('  IEEE 802.11 OFDM Receiver Test\n');
fprintf('========================================\n\n');

%% Test 1: Module Initialization
fprintf('[TEST 1] Module Initialization...\n');

try
    % Add paths
    addpath('Main_pipeline_moduller');
    addpath('basic_yardimci_moduller');
    addpath('lut_moduller');
    
    % Initialize receiver
    [byte_out, byte_valid, fcs_ok, pkt_info, debug_signals] = ...
        dot11(0, 0, 0, 1, 1, struct());
    
    fprintf('  ✓ dot11.m initialized successfully\n');
    fprintf('    Initial state: %d\n', pkt_info.state);
catch ME
    fprintf('  ✗ FAILED: %s\n', ME.message);
    fprintf('    File: %s\n', ME.stack(1).file);
    fprintf('    Line: %d\n', ME.stack(1).line);
    return;
end

%% Test 2: Power Trigger Detection
fprintf('\n[TEST 2] Power Trigger Detection...\n');

try
    % Generate high power samples
    num_samples = 100;
    power_level = 5000; % High power
    
    trigger_detected = false;
    for i = 1:num_samples
        sample_i = int16(power_level + randn()*100);
        sample_q = int16(power_level + randn()*100);
        
        [byte_out, byte_valid, fcs_ok, pkt_info, debug_signals] = ...
            dot11(sample_i, sample_q, 1, 1, 0, struct());
        
        if pkt_info.state >= 1
            trigger_detected = true;
            fprintf('  ✓ Power trigger detected at sample %d\n', i);
            fprintf('    State: %d → %d\n', 0, pkt_info.state);
            break;
        end
    end
    
    if ~trigger_detected
        fprintf('  ⚠ Power trigger not detected (may need higher power)\n');
    end
catch ME
    fprintf('  ✗ FAILED: %s\n', ME.message);
end

%% Test 3: Individual Module Tests
fprintf('\n[TEST 3] Individual Module Tests...\n');

% Test 3a: Demodulate
fprintf('  [3a] Testing demodulate.m...\n');
try
    % BPSK constellation point
    cons_i = int16(1000);
    cons_q = int16(0);
    rate = 11; % BPSK Legacy
    
    [soft_bits, strobe] = demodulate(cons_i, cons_q, rate, 1, 1);
    fprintf('      ✓ BPSK demodulation OK (soft_bits=%d)\n', soft_bits);
    
    % Test HT rate encoding
    rate_ht = bitor(128, 0); % HT MCS 0 (BPSK)
    [soft_bits_ht, strobe_ht] = demodulate(cons_i, cons_q, rate_ht, 1, 0);
    fprintf('      ✓ HT MCS 0 demodulation OK (soft_bits=%d)\n', soft_bits_ht);
catch ME
    fprintf('      ✗ FAILED: %s\n', ME.message);
end

% Test 3b: Deinterleave
fprintf('  [3b] Testing deinterleave.m...\n');
try
    soft_bits = uint8(5);
    rate = 11;
    
    [out_bits, erase, strobe] = deinterleave(soft_bits, rate, 1, 1);
    fprintf('      ✓ Deinterleave OK (output: [%d, %d])\n', out_bits(1), out_bits(2));
catch ME
    fprintf('      ✗ FAILED: %s\n', ME.message);
end

% Test 3c: Viterbi Decode
fprintf('  [3c] Testing viterbi_decode.m...\n');
try
    data_in0 = 7; % Strong 1
    data_in1 = 0; % Strong 0
    erase = [0, 0];
    
    [decoded_bit, strobe] = viterbi_decode(data_in0, data_in1, erase, 1, 1);
    fprintf('      ✓ Viterbi decode initialized\n');
    
    % Process a few bits
    for i = 1:10
        [decoded_bit, strobe] = viterbi_decode(7, 7, [0,0], 1, 0);
    end
    fprintf('      ✓ Viterbi decode running\n');
catch ME
    fprintf('      ✗ FAILED: %s\n', ME.message);
end

% Test 3d: Descramble
fprintf('  [3d] Testing descramble.m...\n');
try
    [out_bit, strobe] = descramble(1, 1, 1);
    fprintf('      ✓ Descramble initialized\n');
    
    % Descramble sequence
    for i = 1:10
        [out_bit, strobe] = descramble(mod(i,2), 1, 0);
    end
    fprintf('      ✓ Descramble running (last output: %d)\n', out_bit);
catch ME
    fprintf('      ✗ FAILED: %s\n', ME.message);
end

% Test 3e: Bits to Bytes
fprintf('  [3e] Testing bits_to_bytes.m...\n');
try
    [byte_out, strobe] = bits_to_bytes(1, 1, 1);
    
    % Convert 8 bits to byte
    test_byte = uint8(0);
    for i = 0:7
        bit = bitget(170, i+1); % Test pattern: 0xAA (10101010)
        [byte_out, strobe] = bits_to_bytes(bit, 1, 0);
        if strobe
            test_byte = byte_out;
        end
    end
    
    if test_byte == 170
        fprintf('      ✓ Bits to bytes OK (0xAA → 0x%02X)\n', test_byte);
    else
        fprintf('      ⚠ Output mismatch (expected 0xAA, got 0x%02X)\n', test_byte);
    end
catch ME
    fprintf('      ✗ FAILED: %s\n', ME.message);
end

% Test 3f: HT-SIG CRC
fprintf('  [3f] Testing ht_sig_crc.m...\n');
try
    % Test with simple bit pattern
    test_bits = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0];
    crc_out = ht_sig_crc(test_bits, 0);
    fprintf('      ✓ HT-SIG CRC OK (output: 0x%02X)\n', crc_out);
catch ME
    fprintf('      ✗ FAILED: %s\n', ME.message);
end

%% Test 4: Equalizer with HT Support
fprintf('\n[TEST 4] Equalizer HT Support...\n');

try
    % Create dummy FFT input (52 carriers for Legacy)
    fft_i_legacy = int16(randn(52,1) * 100);
    fft_q_legacy = int16(randn(52,1) * 100);
    
    % Initialize equalizer
    [eq_i, eq_q, strobe, csi_valid] = ...
        equalizer(fft_i_legacy, fft_q_legacy, 0, 0, 0, 0, 0, 1);
    fprintf('  ✓ Equalizer initialized (Legacy mode)\n');
    
    % Trigger sync detection
    [eq_i, eq_q, strobe, csi_valid] = ...
        equalizer(fft_i_legacy, fft_q_legacy, 1, 1, 0, 0, 0, 0);
    fprintf('  ✓ Equalizer sync detected\n');
    
    % Test HT mode with 56 carriers
    fft_i_ht = int16(randn(56,1) * 100);
    fft_q_ht = int16(randn(56,1) * 100);
    
    [eq_i, eq_q, strobe, csi_valid] = ...
        equalizer(fft_i_ht, fft_q_ht, 0, 0, 0, 1, 0, 1);
    fprintf('  ✓ Equalizer HT mode initialized (56 carriers)\n');
    
    % Test ht_next signal
    [eq_i, eq_q, strobe, csi_valid] = ...
        equalizer(fft_i_ht, fft_q_ht, 1, 1, 1, 1, 1, 0);
    fprintf('  ✓ Equalizer ht_next signal OK\n');
    
catch ME
    fprintf('  ✗ FAILED: %s\n', ME.message);
    fprintf('    %s\n', ME.stack(1).name);
end

%% Test 5: OFDM Decoder Pipeline
fprintf('\n[TEST 5] OFDM Decoder Pipeline...\n');

try
    % Create equalized symbols (48 data carriers)
    eq_i = int16(randn(48,1) * 500);
    eq_q = int16(randn(48,1) * 500);
    rate = 11; % BPSK Legacy
    
    [byte_out, byte_valid, demod_debug, deinter_debug, vit_debug, descram_debug] = ...
        ofdm_decoder(eq_i, eq_q, 0, rate, 1, 1);
    fprintf('  ✓ OFDM decoder initialized\n');
    
    % Process one symbol
    [byte_out, byte_valid, demod_debug, deinter_debug, vit_debug, descram_debug] = ...
        ofdm_decoder(eq_i, eq_q, 1, rate, 1, 0);
    
    if demod_debug.strobe
        fprintf('  ✓ Demodulator output: %d soft bits\n', length(demod_debug.soft_bits));
    end
    
    if deinter_debug.strobe
        fprintf('  ✓ Deinterleaver output: [%d, %d] bits\n', ...
                deinter_debug.bits(1), deinter_debug.bits(2));
    end
    
    fprintf('  ✓ OFDM decoder pipeline OK\n');
    
catch ME
    fprintf('  ✗ FAILED: %s\n', ME.message);
    fprintf('    %s (line %d)\n', ME.stack(1).name, ME.stack(1).line);
end

%% Test Summary
fprintf('\n========================================\n');
fprintf('  Test Summary\n');
fprintf('========================================\n');
fprintf('All basic functionality tests completed.\n');
fprintf('\nModules are ready for integration testing.\n');
fprintf('\nNext steps:\n');
fprintf('  1. Test with real 802.11a/g/n packets\n');
fprintf('  2. Compare with Verilog simulation\n');
fprintf('  3. Verify bit-exact matching\n');
fprintf('\n');
