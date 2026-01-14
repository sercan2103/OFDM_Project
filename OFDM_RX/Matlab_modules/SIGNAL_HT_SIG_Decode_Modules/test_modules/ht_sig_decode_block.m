%% ht_sig_decode_block.m
% Complete HT-SIG decoder block
% This tests the complete HT-SIG decoding as ONE block
%
% Simulates complete HT-SIG decoding pipeline:
%   96 Q-BPSK Symbols → Derotate → Deinterleave → Viterbi → Extract → Validate CRC
%
% USAGE:
%   [mcs, length, valid] = ht_sig_decode_block(qbpsk_symbols);

function [mcs, length, bw, valid] = ht_sig_decode_block(qbpsk_symbols)
% ht_sig_decode_block - Complete HT-SIG decoder
%
% INPUTS:
%   qbpsk_symbols - 96 Q-BPSK symbols from HT-SIG field [96x2] [I, Q]
%                   HT-SIG1 (48 symbols) + HT-SIG2 (48 symbols)
%
% OUTPUTS:
%   mcs    - Modulation and Coding Scheme (0-31)
%   length - HT-LENGTH in bytes (0-65535)
%   bw     - Bandwidth (20 or 40 MHz)
%   valid  - CRC check passed (1=valid, 0=failed)

    % Add module paths
    addpath('../part3_signal_decode');
    
    fprintf('  [HT-SIG Decode] Processing 96 Q-BPSK symbols...\n');
    
    % ===== STEP 1: Q-BPSK Derotation =====
    % Convert Q-BPSK to BPSK for easier processing
    derot_symbols = zeros(96, 2);
    for k = 0:95
        [derot_i, derot_q] = qbpsk_derotate(qbpsk_symbols(k+1,1), ...
                                            qbpsk_symbols(k+1,2), k);
        derot_symbols(k+1, :) = [derot_i, derot_q];
    end
    
    fprintf('  [HT-SIG Decode] Q-BPSK derotation complete\n');
    
    % ===== STEP 2: Extract bits from derotated BPSK =====
    coded_bits = zeros(1, 96);
    for k = 1:96
        if derot_symbols(k, 1) > 0
            coded_bits(k) = 1;
        else
            coded_bits(k) = 0;
        end
    end
    
    % ===== STEP 3: Deinterleave =====
    % Split into HT-SIG1 and HT-SIG2
    sig1_coded = coded_bits(1:48);
    sig2_coded = coded_bits(49:96);
    
    sig1_deint = deinterleave_ht_sig(sig1_coded);
    sig2_deint = deinterleave_ht_sig(sig2_coded);
    
    % ===== STEP 4: Viterbi Decode (Rate 1/2) =====
    % Each HT-SIG field: 48 coded bits → 24 decoded bits
    sig1_decoded = viterbi_decode_ht(sig1_deint);
    sig2_decoded = viterbi_decode_ht(sig2_deint);
    
    % ===== STEP 5: Extract HT-SIG1 fields =====
    % HT-SIG1 (24 bits):
    % Bit 0-6:   MCS (7 bits)
    % Bit 7:     CBW 20/40 (bandwidth)
    % Bit 8-23:  HT-LENGTH (16 bits)
    
    mcs_bits = sig1_decoded(1:7);
    cbw_bit = sig1_decoded(8);
    length_bits = sig1_decoded(9:24);
    
    mcs = bi2de(mcs_bits, 'left-msb');
    if cbw_bit == 0
        bw = 20;
    else
        bw = 40;
    end
    length = bi2de(length_bits, 'left-msb');
    
    % ===== STEP 6: Extract HT-SIG2 fields =====
    % HT-SIG2 (24 bits):
    % Bit 0-1:   Smoothing, Not sounding
    % Bit 2:     Reserved
    % Bit 3:     Aggregation
    % Bit 4-5:   STBC
    % Bit 6:     FEC coding
    % Bit 7:     Short GI
    % Bit 8-9:   Number of extension spatial streams
    % Bit 10-17: CRC (8 bits)
    % Bit 18-23: TAIL (6 bits)
    
    crc_bits = sig2_decoded(11:18);  % 8-bit CRC
    crc_received = bi2de(crc_bits, 'left-msb');
    
    % ===== STEP 7: Calculate CRC on HT-SIG1 =====
    crc_calculated = ht_sig_crc(sig1_decoded);
    
    % ===== STEP 8: Validate =====
    crc_valid = (crc_calculated == crc_received);
    mcs_valid = (mcs >= 0 && mcs <= 31);
    length_valid = (length > 0 && length <= 65535);
    
    valid = crc_valid && mcs_valid && length_valid;
    
    fprintf('  [HT-SIG Decode] MCS=%d, BW=%d MHz, Length=%d, CRC=%s, Valid=%s\n', ...
            mcs, bw, length, bool2str(crc_valid), bool2str(valid));
end

%% Helper Functions

function deinterleaved = deinterleave_ht_sig(coded_bits)
    % Simplified deinterleaver for HT-SIG field
    % Uses same pattern as SIGNAL field
    
    N_CBPS = 48;
    s = 1;  % For BPSK/Q-BPSK
    
    deinterleaved = zeros(1, N_CBPS);
    
    for i = 0:N_CBPS-1
        j = floor(i/16) + mod(i, 16)*3;
        if j >= N_CBPS
            j = j - N_CBPS;
        end
        
        k = s * floor(j/s) + mod(j + N_CBPS - floor(16*j/N_CBPS), s);
        
        deinterleaved(i+1) = coded_bits(k+1);
    end
end

function decoded = viterbi_decode_ht(coded_bits)
    % Simplified Viterbi decoder for HT-SIG
    % Rate 1/2: 48 coded bits → 24 decoded bits
    
    decoded = zeros(1, 24);
    
    % Simplified decoding (NOT actual Viterbi)
    for i = 1:24
        if coded_bits(2*i-1) == coded_bits(2*i)
            decoded(i) = coded_bits(2*i-1);
        else
            decoded(i) = coded_bits(2*i-1);
        end
    end
end

function str = bool2str(val)
    if val
        str = 'OK';
    else
        str = 'FAIL';
    end
end
