function [samples_i, samples_q, packet_info] = generate_80211a_packet(config)
% GENERATE_80211A_PACKET - IEEE 802.11a/g paket olustur
%
% TX formatinda RX'e input olacak test verisi olusturur
%
% Packet Structure:
%   1. Short Training (10 symbols, 160 samples)
%   2. Long Training (2.5 symbols, 160 samples)
%   3. SIGNAL field (1 symbol, 80 samples)
%   4. DATA (N symbols, 80*N samples)
%
% Inputs:
%   config.packet_type: 'legacy' or 'ht'
%   config.rate: Data rate (6, 9, 12, 18, 24, 36, 48, 54 Mbps)
%   config.payload_bytes: Number of payload bytes
%
% Outputs:
%   samples_i, samples_q: int16 I/Q samples
%   packet_info: Struct with packet details

    %% Configuration
    if nargin < 1
        config = struct();
    end
    if ~isfield(config, 'packet_type'), config.packet_type = 'legacy'; end
    if ~isfield(config, 'rate'), config.rate = 6; end
    if ~isfield(config, 'payload_bytes'), config.payload_bytes = 100; end
    
    packet_info = struct();
    packet_info.packet_type = config.packet_type;
    packet_info.rate = config.rate;
    packet_info.payload_bytes = config.payload_bytes;
    
    %% 1. Generate Short Training Sequence (STS)
    % 10 repetitions of 16-sample sequence
    sts_freq = [0, 0, 1+1i, 0, 0, 0, -1-1i, 0, 0, 0, ...
                1+1i, 0, 0, 0, -1-1i, 0, 0, 0, -1-1i, 0, 0, 0, ...
                1+1i, 0, 0, 0, 0, 0, 0, 0, -1-1i, 0, 0, 0, ...
                -1-1i, 0, 0, 0, 1+1i, 0, 0, 0, 1+1i, 0, 0, 0, ...
                1+1i, 0, 0, 0, 1+1i, 0, 0];  % 52 subcarriers (simplified)
    
    % 16-point IFFT for short training
    sts_time = ifft(sts_freq(1:16), 16);
    sts_time = sts_time * sqrt(13/6);  % Normalization
    
    % Repeat 10 times
    short_training = repmat(sts_time(:), 10, 1);  % Force column vector
    
    fprintf('[TX] Short training: %d samples\n', length(short_training));
    packet_info.preamble_start = 1;
    packet_info.short_training_len = length(short_training);
    
    %% 2. Generate Long Training Sequence (LTS)
    % 2 symbols + CP (32 + 64 + 64 = 160 samples)
    lts_freq = [1, 1, -1, -1, 1, 1, -1, 1, -1, 1, ...
                1, 1, 1, 1, 1, -1, -1, 1, 1, -1, 1, -1, 1, 1, 1, 1, ...
                0, ...  % DC
                1, -1, -1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, ...
                1, 1, -1, -1, 1, -1, 1, -1, 1, 1, 1, 1];  % 52 subcarriers
    
    % 64-point IFFT
    lts_freq_64 = zeros(1, 64);
    % Map 52 subcarriers (skip DC at position 27)
    % Negative freqs: indices 39-64 (26 subcarriers)
    % Positive freqs: indices 2-27 (26 subcarriers)
    lts_freq_64(39:64) = lts_freq(1:26);   % First 26 (negative freqs)
    lts_freq_64(2:27) = lts_freq(28:53);   % Last 26 (positive freqs), skip DC at 27
    lts_time = ifft(lts_freq_64, 64);
    
    % Add cyclic prefix (32 samples) + 2 symbols
    long_training = [lts_time(end-31:end), lts_time, lts_time];
    long_training = long_training(:);  % Force column vector
    
    fprintf('[TX] Long training: %d samples\n', length(long_training));
    packet_info.long_training_len = length(long_training);
    
    %% 3. Generate SIGNAL Field
    % SIGNAL: 24 bits = RATE(4) + RSVD(1) + LENGTH(12) + PARITY(1) + TAIL(6)
    
    % Rate encoding
    rate_map = containers.Map([6,9,12,18,24,36,48,54], ...
                              [13,15,5,7,9,11,1,3]);  % OFDM rate encoding
    if isKey(rate_map, config.rate)
        rate_field = rate_map(config.rate);
    else
        rate_field = 13;  % Default to 6 Mbps (BPSK 1/2)
    end
    
    % Length in bytes (including SERVICE, PSDU, tail, pad)
    num_data_bits = (config.payload_bytes + 2) * 8;  % +2 for SERVICE
    
    % SIGNAL bits
    signal_bits = zeros(24, 1);
    rate_bits = de2bi(rate_field, 4, 'left-msb');
    signal_bits(1:4) = rate_bits(:);
    signal_bits(5) = 0;  % Reserved
    length_bits = de2bi(config.payload_bytes, 12, 'left-msb');
    signal_bits(6:17) = length_bits(:);
    signal_bits(18) = mod(sum(signal_bits(1:17)), 2);  % Parity
    signal_bits(19:24) = 0;  % Tail
    
    % Encode SIGNAL (BPSK, rate 1/2)
    signal_coded = convolutional_encode(signal_bits);  % 48 coded bits
    signal_symbols = bpsk_modulate(signal_coded);  % 48 BPSK symbols
    
    % OFDM symbol (48 data + 4 pilots)
    signal_ofdm = generate_ofdm_symbol(signal_symbols, 'legacy');
    signal_ofdm = signal_ofdm(:);  % Force column vector
    
    fprintf('[TX] SIGNAL field: %d samples\n', length(signal_ofdm));
    packet_info.signal_len = length(signal_ofdm);
    packet_info.signal_rate = rate_field;
    packet_info.signal_length = config.payload_bytes;
    
    %% 4. Generate DATA Field
    % Generate random payload
    payload_bits = randi([0,1], config.payload_bytes*8, 1);
    
    % Calculate FCS for payload (IEEE 802.11 CRC32)
    fcs_bytes = calculate_fcs(payload_bits);
    fprintf('[TX] FCS calculated: %02X %02X %02X %02X\n', ...
            fcs_bytes(1), fcs_bytes(2), fcs_bytes(3), fcs_bytes(4));
    
    % Convert FCS bytes to bits (MSB first bit order for serial transmission)
    % bits_to_bytes expects bits in order: MSB(bit7) -> LSB(bit0)
    % So we output bits from MSB to LSB
    fcs_bits = zeros(32, 1);
    for i = 1:4
        byte_val = fcs_bytes(i);
        for j = 8:-1:1  % Go from bit 8 (MSB) down to bit 1 (LSB)
            fcs_bits((i-1)*8 + (9-j)) = bitget(byte_val, j);
        end
    end
    
    % Add SERVICE field (16 bits, all zeros)
    service_bits = zeros(16, 1);
    data_bits = [service_bits; payload_bits; fcs_bits];
    
    % Add TAIL (6 bits) and PAD to symbol boundary
    tail_bits = zeros(6, 1);
    data_bits = [data_bits; tail_bits];
    
    % Pad to OFDM symbol boundary
    bits_per_symbol = get_bits_per_symbol(config.rate);
    num_symbols = ceil(length(data_bits) / bits_per_symbol);
    pad_bits = num_symbols * bits_per_symbol - length(data_bits);
    data_bits = [data_bits; zeros(pad_bits, 1)];
    
    fprintf('[TX] Data bits: %d (including SERVICE, TAIL, PAD)\n', length(data_bits));
    fprintf('[TX] Data symbols: %d\n', num_symbols);
    
    % Scramble
    data_scrambled = scramble_data(data_bits);
    
    % Convolutional encode (rate 1/2 → x2 bits)
    data_coded = convolutional_encode(data_scrambled);
    
    % Puncture for higher rates (if needed)
    data_punctured = puncture_data(data_coded, config.rate);
    
    % Interleave
    data_interleaved = interleave_data(data_punctured, config.rate);
    
    % Modulate
    data_symbols = modulate_data(data_interleaved, config.rate);
    
    % Generate OFDM symbols
    data_ofdm = [];
    for sym = 1:num_symbols
        sym_start = (sym-1)*48 + 1;
        sym_end = sym*48;
        sym_data = data_symbols(sym_start:min(sym_end, length(data_symbols)));
        
        % Pad if last symbol incomplete
        if length(sym_data) < 48
            sym_data = [sym_data; zeros(48-length(sym_data), 1)];
        end
        
        ofdm_sym = generate_ofdm_symbol(sym_data, 'legacy');
        ofdm_sym = ofdm_sym(:);  % Force column vector
        data_ofdm = [data_ofdm; ofdm_sym];
    end
    
    fprintf('[TX] DATA field: %d samples\n', length(data_ofdm));
    packet_info.data_len = length(data_ofdm);
    packet_info.num_symbols = num_symbols;
    
    %% 5. Concatenate Full Packet
    packet_complex = [short_training; long_training; signal_ofdm; data_ofdm];
    
    %% 6. Convert to I/Q int16
    % Scale to int16 range
    scale_factor = 5000;  % Adjust for desired SNR
    samples_i = int16(real(packet_complex) * scale_factor);
    samples_q = int16(imag(packet_complex) * scale_factor);
    
    % Add noise (optional)
    snr_db = 20;  % dB
    if snr_db < inf
        noise_power = scale_factor^2 / (10^(snr_db/10));
        noise_i = int16(randn(size(samples_i)) * sqrt(noise_power));
        noise_q = int16(randn(size(samples_q)) * sqrt(noise_power));
        samples_i = samples_i + noise_i;
        samples_q = samples_q + noise_q;
    end
    
    packet_info.total_samples = length(samples_i);
    packet_info.preamble_len = packet_info.short_training_len + packet_info.long_training_len;
    
    fprintf('[TX] Total packet: %d samples\n', packet_info.total_samples);
    fprintf('[TX] SNR: %.1f dB\n', snr_db);
end

%% Helper Functions
function coded = convolutional_encode(bits)
    % Simplified convolutional encoder (rate 1/2, K=7)
    % Returns 2x bits
    coded = [bits; bits];  % Placeholder - real encoder needed
end

function symbols = bpsk_modulate(bits)
    % BPSK: 0→-1, 1→+1
    symbols = 2*bits - 1;
end

function symbols = modulate_data(bits, rate)
    % Modulate based on rate
    % Simplified - real implementation needed
    symbols = 2*bits - 1;  % BPSK placeholder
end

function ofdm_sym = generate_ofdm_symbol(data_symbols, mode)
    % Generate 80-sample OFDM symbol (16 CP + 64 FFT)
    % 48 data + 4 pilots → 52 subcarriers
    
    % Ensure data_symbols is column vector
    data_symbols = data_symbols(:);
    num_data = length(data_symbols);
    
    % Map to 64-point FFT indices
    % IEEE 802.11: subcarriers -26 to -1, +1 to +26 (skip DC=0)
    % MATLAB indices: 39-64 (negative), 2-27 (positive), 1 (DC)
    freq_domain = zeros(64, 1);
    
    if num_data >= 48
        % Simple mapping: first 24 to negative, last 24 to positive
        freq_domain(41:64) = data_symbols(1:24);   % Negative freqs (24 symbols)
        freq_domain(2:25) = data_symbols(25:48);   % Positive freqs (24 symbols)
    else
        % For smaller symbol counts, just place sequentially
        num_per_side = ceil(num_data / 2);
        
        % Negative freqs
        neg_count = min(num_per_side, 26);
        freq_domain(39:38+neg_count) = data_symbols(1:neg_count);
        
        % Positive freqs
        if num_data > neg_count
            pos_count = min(num_data - neg_count, 26);
            freq_domain(2:1+pos_count) = data_symbols(neg_count+1:neg_count+pos_count);
        end
    end
    
    % IFFT
    time_domain = ifft(freq_domain, 64);
    
    % Add cyclic prefix (16 samples)
    ofdm_sym = [time_domain(end-15:end); time_domain];
end

function bits_per_sym = get_bits_per_symbol(rate)
    % Bits per OFDM symbol for each rate
    rate_map = containers.Map([6,9,12,18,24,36,48,54], ...
                              [24,36,48,72,96,144,192,216]);
    if isKey(rate_map, rate)
        bits_per_sym = rate_map(rate);
    else
        bits_per_sym = 24;  % Default BPSK 1/2
    end
end

function scrambled = scramble_data(bits)
    % 802.11 scrambler (x^7 + x^4 + 1)
    % Simplified - real scrambler needed
    scrambled = bits;
end

function interleaved = interleave_data(bits, rate)
    % Frequency-domain interleaving
    % Simplified
    interleaved = bits;
end

function punctured = puncture_data(bits, rate)
    % Puncturing for rates > 1/2
    % Simplified
    punctured = bits;
end

function fcs_bytes = calculate_fcs(payload_bits)
    % IEEE 802.11 CRC32 calculation for payload
    % Converts bit array to bytes and calculates CRC
    
    % Convert bits to bytes (MSB first for CRC calculation)
    num_bytes = ceil(length(payload_bits) / 8);
    payload_bytes = zeros(num_bytes, 1, 'uint8');
    
    for i = 1:num_bytes
        byte_val = 0;
        for j = 1:8
            idx = (i-1)*8 + j;
            if idx <= length(payload_bits)
                byte_val = bitor(byte_val, bitshift(uint8(payload_bits(idx)), 8-j));
            end
        end
        payload_bytes(i) = byte_val;
    end
    
    % Calculate CRC32
    crc = uint32(hex2dec('FFFFFFFF'));
    for i = 1:length(payload_bytes)
        crc = crc32_step(crc, payload_bytes(i));
    end
    
    % Final XOR
    crc = bitxor(crc, uint32(hex2dec('FFFFFFFF')));
    
    % Convert to bytes (LSB first as per 802.11)
    fcs_bytes = zeros(4, 1, 'uint8');
    fcs_bytes(1) = uint8(bitand(crc, 255));
    fcs_bytes(2) = uint8(bitand(bitshift(crc, -8), 255));
    fcs_bytes(3) = uint8(bitand(bitshift(crc, -16), 255));
    fcs_bytes(4) = uint8(bitand(bitshift(crc, -24), 255));
end

function crc = crc32_step(crc, byte_val)
    % Single step of CRC32 with one byte
    % Using polynomial 0x04C11DB7 (IEEE 802.11)
    
    % Reverse bits in byte
    byte_reversed = 0;
    for k = 0:7
        if bitget(byte_val, k+1)
            byte_reversed = bitset(byte_reversed, 8-k);
        end
    end
    
    % Process 8 bits
    for k = 1:8
        bit = bitget(byte_reversed, k);
        feedback = bitxor(bit, bitget(crc, 32));
        
        % Shift and apply polynomial
        crc = bitshift(crc, 1);
        
        if feedback
            crc = bitxor(crc, uint32(hex2dec('04C11DB7')));
        end
        
        % Keep 32 bits
        crc = bitand(crc, uint32(hex2dec('FFFFFFFF')));
    end
end
