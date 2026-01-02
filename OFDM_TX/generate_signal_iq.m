function [l_sig_iq, ht_sig_iq] = generate_signal_iq(config)
% GENERATE_SIGNAL_IQ - Generates IQ samples for L-SIG and HT-SIG fields
%
% This function mimics the Verilog behavior in states S3_L_SIG and S3_HT_SIG
% by processing SIGNAL field bits through the complete TX chain.
%
% Inputs:
%   config - Configuration structure from read_plcp_config()
%            Must contain: PKT_TYPE, RATE, PSDU_BIT_LEN, MCS, HT_AGGR, S_GI
%
% Outputs:
%   l_sig_iq  - Legacy SIGNAL IQ samples (80 samples: 16 CP + 64 IFFT)
%   ht_sig_iq - HT SIGNAL IQ samples (160 samples: 16+16 CP + 64+64 IFFT)
%               Returns empty [] if PKT_TYPE is LEGACY

%% Constants
LEGACY = 0;
HT = 1;
RATE_6MBPS = bin2dec('01011'); % L-SIG always uses 6 Mbps (BPSK 1/2)

%% Generate L-SIG Field (24 bits)
l_sig_bits = generate_l_sig_bits(config);

%% Process L-SIG through TX chain
% 1. Scrambling (initialize with all-zero for SIGNAL field in 802.11)
scrambler_seed = zeros(1, 7); % Reset state
[~, ~, l_sig_scrambled] = Scrambler(scrambler_seed, l_sig_bits, false);

% 2. Convolutional Encoding (Rate 1/2 -> 48 bits output)
l_sig_encoded = conv_encoder_80211(l_sig_scrambled, true);

% 3. Puncturing & Interleaving (BPSK 1/2, 48 CBPS for Legacy)
% Symbol index 0 corresponds to L-SIG field
l_sig_interleaved = dot11_punc_interlv(l_sig_encoded, RATE_6MBPS, 0, LEGACY);

% 4. Modulation (BPSK -> N_BPSC = 1)
l_sig_modulated = modulate_signal(l_sig_interleaved, 1);

% 5. IFFT (48 data subcarriers + 4 pilots + DC/guards)
l_sig_ifft = perform_ifft_with_pilots(l_sig_modulated, 48, LEGACY);

% 6. Add Cyclic Prefix (16 samples for normal GI)
l_sig_iq = add_cyclic_prefix(l_sig_ifft, 16);

%% Generate HT-SIG Field (48 bits for 2 symbols)
if config.PKT_TYPE == HT
    ht_sig_bits = generate_ht_sig_bits(config);
    
    % Process HT-SIG through TX chain
    % 1. Scrambling (same seed continuation from L-SIG)
    [~, ~, ht_sig_scrambled] = Scrambler(scrambler_seed, ht_sig_bits, false);
    
    % 2. Convolutional Encoding (Rate 1/2 -> 96 bits output)
    ht_sig_encoded = conv_encoder_80211(ht_sig_scrambled, true);
    
    % Split into two OFDM symbols (48 bits each)
    ht_sig_sym1_bits = ht_sig_encoded(1:48);
    ht_sig_sym2_bits = ht_sig_encoded(49:96);
    
    % 3. Puncturing & Interleaving for Symbol 1 (QPSK 1/2, index 1 = L-SIG+1)
    ht_sig_sym1_interleaved = dot11_punc_interlv(ht_sig_sym1_bits, RATE_6MBPS, 1, HT);
    
    % 4. Modulation Symbol 1 (QPSK -> N_BPSC = 2)
    ht_sig_sym1_modulated = modulate_signal(ht_sig_sym1_interleaved, 2);
    
    % 5. IFFT Symbol 1 (48 subcarriers for Legacy compatibility)
    ht_sig_sym1_ifft = perform_ifft_with_pilots(ht_sig_sym1_modulated, 48, LEGACY);
    
    % 6. Add CP to Symbol 1
    ht_sig_sym1_iq = add_cyclic_prefix(ht_sig_sym1_ifft, 16);
    
    % Repeat for Symbol 2 (index 2)
    ht_sig_sym2_interleaved = dot11_punc_interlv(ht_sig_sym2_bits, RATE_6MBPS, 2, HT);
    ht_sig_sym2_modulated = modulate_signal(ht_sig_sym2_interleaved, 2);
    ht_sig_sym2_ifft = perform_ifft_with_pilots(ht_sig_sym2_modulated, 48, LEGACY);
    ht_sig_sym2_iq = add_cyclic_prefix(ht_sig_sym2_ifft, 16);
    
    % Concatenate both symbols
    ht_sig_iq = [ht_sig_sym1_iq; ht_sig_sym2_iq];
else
    ht_sig_iq = [];
end

end

%% Helper Functions

function bits = generate_l_sig_bits(config)
    % Generate 24-bit L-SIG field according to 802.11-2016 Section 17.3.4
    % Format: RATE(4) | Reserved(1) | LENGTH(12) | Parity(1) | Tail(6)
    
    % RATE field (4 bits) - map from config.RATE
    rate_map = containers.Map(...
        [bin2dec('01011'), bin2dec('01111'), bin2dec('01010'), bin2dec('01110'), ...
         bin2dec('01001'), bin2dec('01101'), bin2dec('01000'), bin2dec('01100')], ...
        {[1 1 0 1], [1 1 1 1], [0 1 0 1], [0 1 1 1], ...
         [1 0 0 1], [1 1 0 1], [0 0 0 1], [0 1 0 1]});
    
    if isKey(rate_map, config.RATE)
        rate_bits = rate_map(config.RATE);
    else
        rate_bits = [1 1 0 1]; % Default: 6 Mbps
    end
    
    % LENGTH field (12 bits) - PSDU length in bytes
    length_bytes = config.PSDU_BIT_LEN / 8;
    length_bits = fliplr(de2bi(length_bytes, 12));
    
    % Parity bit (even parity over RATE + LENGTH)
    parity = mod(sum([rate_bits, length_bits]), 2);
    
    % Tail bits (6 zeros)
    tail_bits = zeros(1, 6);
    
    % Reserved bit (always 0)
    reserved = 0;
    
    % Concatenate all fields
    bits = [rate_bits, reserved, length_bits, parity, tail_bits];
end

function bits = generate_ht_sig_bits(config)
    % Generate 48-bit HT-SIG field according to 802.11n
    % HT-SIG1 (24 bits) + HT-SIG2 (24 bits)
    
    % HT-SIG1 fields:
    % MCS(7) | CBW(1) | HT-Length(16)
    mcs_bits = fliplr(de2bi(config.MCS, 7));
    cbw_bit = 0; % Always 20 MHz in this implementation
    ht_length_bits = fliplr(de2bi(config.PSDU_BIT_LEN / 8, 16));
    
    ht_sig1 = [mcs_bits, cbw_bit, ht_length_bits];
    
    % HT-SIG2 fields:
    % Smoothing(1) | Not Sounding(1) | Reserved(1) | Aggregation(1) | 
    % STBC(2) | FEC Coding(1) | Short GI(1) | Num ESS(2) | 
    % CRC(8) | Tail(6)
    smoothing = 0;
    not_sounding = 1;
    reserved = 0;
    aggregation = config.HT_AGGR;
    stbc_bits = [0 0];
    fec_coding = 0; % BCC
    short_gi = config.S_GI;
    num_ess_bits = [0 0]; % Single spatial stream
    
    % CRC-8 over HT-SIG1 and first 10 bits of HT-SIG2
    ht_sig2_pre_crc = [smoothing, not_sounding, reserved, aggregation, ...
                       stbc_bits, fec_coding, short_gi, num_ess_bits];
    crc_input = [ht_sig1, ht_sig2_pre_crc];
    crc_bits = calculate_crc8(crc_input);
    
    tail_bits = zeros(1, 6);
    
    ht_sig2 = [ht_sig2_pre_crc, crc_bits, tail_bits];
    
    bits = [ht_sig1, ht_sig2];
end

function crc = calculate_crc8(bits)
    % CRC-8 calculation for 802.11 HT-SIG
    % Polynomial: x^8 + x^2 + x + 1 (0x07 in hex)
    
    crc_reg = ones(1, 8); % Initialize with all ones
    
    for i = 1:length(bits)
        feedback = xor(crc_reg(8), bits(i));
        crc_reg(8) = crc_reg(7);
        crc_reg(7) = crc_reg(6);
        crc_reg(6) = crc_reg(5);
        crc_reg(5) = crc_reg(4);
        crc_reg(4) = crc_reg(3);
        crc_reg(3) = crc_reg(2);
        crc_reg(2) = xor(crc_reg(1), feedback);
        crc_reg(1) = xor(crc_reg(0), feedback);
        crc_reg(0) = feedback;
    end
    
    % Invert final CRC
    crc = ~crc_reg;
    crc = double(crc); % Convert logical to double
end

function modulated = modulate_signal(interleaved_bits, N_BPSC)
    % Use existing modulation_model.m to modulate bits
    
    num_subcarriers = length(interleaved_bits) / N_BPSC;
    modulated = zeros(num_subcarriers, 1);
    
    for i = 1:num_subcarriers
        % Extract N_BPSC bits for this subcarrier
        bit_idx = (i-1)*N_BPSC + 1 : i*N_BPSC;
        bits = interleaved_bits(bit_idx);
        
        % Convert bits to integer
        bits_int = 0;
        for b = 1:N_BPSC
            bits_int = bits_int + bits(b) * 2^(b-1);
        end
        
        % Call modulation_model
        [I_val, Q_val] = modulation_model(N_BPSC, bits_int);
        
        % Convert int16 to complex double (normalize to [-1, 1] range)
        % Verilog uses 16384 as unity (0x4000)
        modulated(i) = double(I_val)/16384 + 1j*double(Q_val)/16384;
    end
end

function ifft_out = perform_ifft_with_pilots(modulated, num_data_subcarriers, pkt_type)
    % Map modulated symbols to 64-point IFFT input with pilots
    % Legacy: 48 data + 4 pilots
    % HT: 52 data + 4 pilots (but for SIGNAL fields, use 48 like Legacy)
    
    LEGACY = 0;
    
    % 802.11 subcarrier mapping
    if num_data_subcarriers == 48
        % Legacy mode: indices -26 to -22, -20 to -8, -6 to -1, 1 to 6, 8 to 20, 22 to 26
        % Pilots at -21, -7, 7, 21
        data_indices = [-26:-22, -20:-8, -6:-1, 1:6, 8:20, 22:26];
        pilot_indices = [-21, -7, 7, 21];
    else % 52 data subcarriers (HT data, not used for SIG fields)
        data_indices = [-26:-1, 1:26];
        pilot_indices = [-21, -7, 7, 21];
    end
    
    % Initialize frequency domain input
    freq_input = zeros(1, 64);
    
    % Place data subcarriers
    for i = 1:length(data_indices)
        idx = data_indices(i);
        center_idx = 33; % DC is at index 33 (1-based)
        freq_input(center_idx + idx) = modulated(i);
    end
    
    % Place pilot subcarriers (fixed to +1 for BPSK)
    for i = 1:length(pilot_indices)
        idx = pilot_indices(i);
        center_idx = 33;
        freq_input(center_idx + idx) = 1 + 0j;
    end
    
    % Convert to hardware order (ifftshift)
    freq_input_hw = ifftshift(freq_input);
    
    % Use existing ifft64_model
    ifft_out = ifft64_model.run(freq_input_hw);
    
    % The model output is already in time domain
    % Note: Hardware may have different scaling, adjust if needed
end

function iq_samples = add_cyclic_prefix(ifft_output, cp_length)
    % Add cyclic prefix by copying last cp_length samples to the front
    % Input: ifft_output (64 samples)
    % Output: iq_samples (cp_length + 64 samples)
    
    N = length(ifft_output);
    cp = ifft_output(N-cp_length+1:N);
    iq_samples = [cp; ifft_output];
end
