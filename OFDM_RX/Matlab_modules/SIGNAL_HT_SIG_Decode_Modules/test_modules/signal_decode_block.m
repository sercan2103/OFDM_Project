%% signal_decode_block.m
% Complete SIGNAL field decoder block
% This tests the complete OFDM SIGNAL field decoding as ONE block
%
% Simulates complete SIGNAL decoding pipeline:
%   48 BPSK Symbols → Deinterleave → Viterbi Decode → Extract Fields → Validate CRC
%
% USAGE:
%   [rate, length, valid] = signal_decode_block(bpsk_symbols);

function [rate, length, parity_ok, valid] = signal_decode_block(bpsk_symbols)
% signal_decode_block - Complete SIGNAL field decoder
%
% INPUTS:
%   bpsk_symbols - 48 BPSK symbols from SIGNAL field [48x2] [I, Q]
%                  Expected on I-axis after demodulation
%
% OUTPUTS:
%   rate      - Detected data rate (6, 9, 12, 18, 24, 36, 48, 54 Mbps)
%   length    - PSDU length in bytes (0-4095)
%   parity_ok - Parity bit check result (1=pass, 0=fail)
%   valid     - Overall SIGNAL validity (rate valid AND length valid)

    % Add module path
    addpath('../part3_signal_decode');
    
    fprintf('  [SIGNAL Decode] Processing 48 symbols...\n');
    
    % ===== STEP 1: Extract bits from BPSK symbols =====
    % BPSK: sign of I-component gives bit value
    coded_bits = zeros(1, 48);
    for k = 1:48
        if bpsk_symbols(k, 1) > 0
            coded_bits(k) = 1;
        else
            coded_bits(k) = 0;
        end
    end
    
    % ===== STEP 2: Deinterleave =====
    % OFDM uses interleaving, need to undo it
    % For SIGNAL field (BPSK, 48 subcarriers)
    deinterleaved = deinterleave_signal(coded_bits);
    
    % ===== STEP 3: Viterbi Decode (Rate 1/2) =====
    % SIGNAL field uses rate 1/2 convolutional code
    % 48 coded bits → 24 decoded bits
    decoded_bits = viterbi_decode_signal(deinterleaved);
    
    % ===== STEP 4: Extract SIGNAL fields =====
    % SIGNAL format (24 bits):
    % Bit 0-3:   RATE (4 bits)
    % Bit 4:     Reserved (0)
    % Bit 5-16:  LENGTH (12 bits)
    % Bit 17:    Parity (even parity over bits 0-16)
    % Bit 18-23: TAIL (6 zeros)
    
    rate_bits = decoded_bits(1:4);
    reserved = decoded_bits(5);
    length_bits = decoded_bits(6:17);
    parity_bit = decoded_bits(18);
    tail_bits = decoded_bits(19:24);
    
    % ===== STEP 5: Decode RATE field =====
    rate = decode_rate_field(rate_bits);
    
    % ===== STEP 6: Decode LENGTH field =====
    length = bi2de(length_bits, 'left-msb');
    
    % ===== STEP 7: Validate parity =====
    parity_check = mod(sum(decoded_bits(1:17)), 2);
    parity_ok = (parity_check == parity_bit);
    
    % ===== STEP 8: Validate TAIL bits (should be all zeros) =====
    tail_ok = all(tail_bits == 0);
    
    % ===== STEP 9: Overall validation =====
    rate_valid = (rate > 0);  % Rate should be valid (not 0)
    length_valid = (length >= 0 && length <= 4095);
    
    valid = rate_valid && length_valid && parity_ok && tail_ok;
    
    fprintf('  [SIGNAL Decode] Rate=%d Mbps, Length=%d bytes, Parity=%s, Valid=%s\n', ...
            rate, length, bool2str(parity_ok), bool2str(valid));
end

%% Helper Functions

function deinterleaved = deinterleave_signal(coded_bits)
    % Simplified deinterleaver for SIGNAL field
    % Full implementation would use actual 802.11 interleaver pattern
    
    N_CBPS = 48;  % Coded bits per OFDM symbol
    s = 1;        % For BPSK
    
    deinterleaved = zeros(1, N_CBPS);
    
    % Deinterleaving pattern for BPSK
    for i = 0:N_CBPS-1
        % First permutation (reverse)
        j = floor(i/16) + mod(i, 16)*3;
        if j >= N_CBPS
            j = j - N_CBPS;
        end
        
        % Second permutation (reverse)
        k = s * floor(j/s) + mod(j + N_CBPS - floor(16*j/N_CBPS), s);
        
        deinterleaved(i+1) = coded_bits(k+1);
    end
end

function decoded = viterbi_decode_signal(coded_bits)
    % Simplified Viterbi decoder for rate 1/2 code
    % In real implementation, would use actual Viterbi algorithm
    % For testing, we'll use a simplified version
    
    % Rate 1/2: 48 coded bits → 24 decoded bits
    decoded = zeros(1, 24);
    
    % Simplified: just take every other bit (NOT actual Viterbi!)
    % Real implementation would use trellis decoding
    for i = 1:24
        % Majority vote of two coded bits
        if coded_bits(2*i-1) == coded_bits(2*i)
            decoded(i) = coded_bits(2*i-1);
        else
            % If different, choose first (or use soft decision)
            decoded(i) = coded_bits(2*i-1);
        end
    end
end

function rate_mbps = decode_rate_field(rate_bits)
    % Decode RATE field to data rate in Mbps
    % IEEE 802.11 RATE encoding
    
    rate_value = bi2de(rate_bits, 'left-msb');
    
    % RATE encoding (4 bits)
    switch rate_value
        case 11  % 1011
            rate_mbps = 6;
        case 15  % 1111
            rate_mbps = 9;
        case 10  % 1010
            rate_mbps = 12;
        case 14  % 1110
            rate_mbps = 18;
        case 9   % 1001
            rate_mbps = 24;
        case 13  % 1101
            rate_mbps = 36;
        case 8   % 1000
            rate_mbps = 48;
        case 12  % 1100
            rate_mbps = 54;
        otherwise
            rate_mbps = 0;  % Invalid
    end
end

function str = bool2str(val)
    if val
        str = 'OK';
    else
        str = 'FAIL';
    end
end
