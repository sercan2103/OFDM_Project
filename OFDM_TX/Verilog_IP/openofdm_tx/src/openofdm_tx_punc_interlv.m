function [interleaved_bits] = openofdm_tx_punc_interlv(encoded_bits, rate_idx)
% OPENOFDM_TX_PUNC_INTERLV Model of the puncturing and interleaving block
%
%   [interleaved_bits] = openofdm_tx_punc_interlv(encoded_bits, rate_idx)
%
%   Inputs:
%       encoded_bits: Column vector of encoded bits (output of convolutional encoder)
%                     Length must be 2 * N_DBPS.
%       rate_idx:     Integer rate index matching the hardware definition.
%                     11: 6 Mbps
%                     15: 9 Mbps
%                     10: 12 Mbps
%                     14: 18 Mbps
%                     9:  24 Mbps
%                     13: 36 Mbps
%                     8:  48 Mbps
%                     12: 54 Mbps
%
%   Outputs:
%       interleaved_bits: Column vector of interleaved bits. Length N_CBPS.

    % Rate parameters mapping
    % rate_idx -> [N_DBPS, N_CBPS, N_BPSC, Rate_Num, Rate_Den]
    switch rate_idx
        case 11 % 6 Mbps (Rate 1/2, BPSK)
            N_DBPS = 24; N_CBPS = 48; N_BPSC = 1; R_num = 1; R_den = 2;
        case 15 % 9 Mbps (Rate 3/4, BPSK)
            N_DBPS = 36; N_CBPS = 48; N_BPSC = 1; R_num = 3; R_den = 4;
        case 10 % 12 Mbps (Rate 1/2, QPSK)
            N_DBPS = 48; N_CBPS = 96; N_BPSC = 2; R_num = 1; R_den = 2;
        case 14 % 18 Mbps (Rate 3/4, QPSK)
            N_DBPS = 72; N_CBPS = 96; N_BPSC = 2; R_num = 3; R_den = 4;
        case 9  % 24 Mbps (Rate 1/2, 16-QAM)
            N_DBPS = 96; N_CBPS = 192; N_BPSC = 4; R_num = 1; R_den = 2;
        case 13 % 36 Mbps (Rate 3/4, 16-QAM)
            N_DBPS = 144; N_CBPS = 192; N_BPSC = 4; R_num = 3; R_den = 4;
        case 8  % 48 Mbps (Rate 2/3, 64-QAM)
            N_DBPS = 192; N_CBPS = 288; N_BPSC = 6; R_num = 2; R_den = 3;
        case 12 % 54 Mbps (Rate 3/4, 64-QAM)
            N_DBPS = 216; N_CBPS = 288; N_BPSC = 6; R_num = 3; R_den = 4;
        otherwise
            error('Invalid rate index: %d', rate_idx);
    end

    % Puncturing Pattern
    % The pattern applies to the stream of encoded bits (A, B, A, B...)
    % 1 means keep, 0 means puncture (discard)
    if R_num == 1 && R_den == 2
        punc_pattern = [1; 1];
    elseif R_num == 2 && R_den == 3
        punc_pattern = [1; 1; 1; 0];
    elseif R_num == 3 && R_den == 4
        punc_pattern = [1; 1; 1; 0; 0; 1];
    else
        error('Unsupported code rate');
    end

    % Validate input length
    expected_len = 2 * N_DBPS;
    if length(encoded_bits) ~= expected_len
        error('Input length mismatch. Expected %d bits for rate index %d, got %d', ...
            expected_len, rate_idx, length(encoded_bits));
    end

    % Apply Puncturing
    % Extend pattern to full length
    pat_len = length(punc_pattern);
    num_repeats = ceil(expected_len / pat_len);
    full_pattern = repmat(punc_pattern, num_repeats, 1);
    full_pattern = full_pattern(1:expected_len);
    
    % Filter bits
    punctured_bits = encoded_bits(full_pattern == 1);
    
    if length(punctured_bits) ~= N_CBPS
        error('Puncturing result length mismatch. Expected %d, got %d', N_CBPS, length(punctured_bits));
    end

    % Interleaving
    % Standard 802.11 interleaver
    
    % k is the index of the bit in the punctured sequence (0 to N_CBPS-1)
    k = (0:N_CBPS-1)';
    
    % First Permutation
    % i = (N_CBPS/16)(k mod 16) + floor(k/16)
    i = (N_CBPS/16) * mod(k, 16) + floor(k/16);
    
    % Second Permutation
    % j = s * floor(i/s) + (i + N_CBPS - floor(16*i/N_CBPS)) mod s
    % s = max(N_BPSC/2, 1)
    s = max(N_BPSC/2, 1);
    j = s * floor(i/s) + mod(i + N_CBPS - floor(16*i/N_CBPS), s);
    
    % Map bits to interleaved positions
    % j is the destination index.
    % interleaved_bits(j) = punctured_bits(k)
    % Note: MATLAB is 1-based
    
    interleaved_bits = zeros(N_CBPS, 1);
    interleaved_bits(j + 1) = punctured_bits;

end
