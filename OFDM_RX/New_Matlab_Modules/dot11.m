function [byte_out, byte_valid, fcs_ok, pkt_info, debug_signals] = ...
    dot11(sample_i, sample_q, sample_strobe, enable, reset, params)
% DOT11 Top-level IEEE 802.11a/g/n OFDM receiver
%
% This is the MAIN top-level module integrating the complete RX pipeline:
%   1. Power trigger
%   2. Sync short (CFO estimation)
%   3. Sync long (FFT + channel estimation)
%   4. Equalizer (channel correction + pilot tracking)
%   5. OFDM decoder wrapper:
%      - Demodulate
%      - Deinterleave
%      - Viterbi decode
%      - Descramble
%      - Bits to bytes
%   6. CRC-32 validation
%
% Inputs:
%   sample_i, sample_q: 16-bit signed I/Q samples
%   sample_strobe: Valid signal for input samples
%   enable: Enable receiver processing
%   reset: Reset all modules
%   params: Struct with receiver parameters (optional)
%           .power_thres: Power detection threshold
%           .power_window: Moving average window size
%           .min_plateau: Minimum plateau for sync_short
%
% Outputs:
%   byte_out: Decoded byte (8-bit)
%   byte_valid: Valid signal for byte output
%   fcs_ok: CRC-32 check result
%   pkt_info: Struct with packet info (rate, length, etc.)
%   debug_signals: Struct with internal signals for debugging
%
% This matches the Verilog dot11.v top module

    % Add module paths
    addpath('../Modules/BasicModules');
    addpath('../Modules/MainPipeline');
    addpath('../Modules/LUTs');
    
    persistent state;
    persistent power_thres power_window_shift min_plateau;
    persistent pkt_rate pkt_len signal_decoded;
    persistent byte_count;
    persistent pkt_ht; % HT format flag
    persistent ht_mcs ht_cbw ht_sgi; % HT-SIG parameters
    persistent signal_bits ht_sig_bits; % Signal field accumulators
    persistent ht_next; % Signal to equalizer for HT-LTS
    persistent eq_sample_count; % Count equalizer outputs
    persistent rot_eq_count normal_eq_count; % HT detection counters
    persistent ht_sig1 ht_sig2; % HT-SIG fields
    persistent eq_i_buf eq_q_buf; % Buffer for rotated symbols
    
    % Default parameters
    if nargin < 6 || isempty(params)
        params = struct();
    end
    if ~isfield(params, 'power_thres')
        params.power_thres = 200000;
    end
    if ~isfield(params, 'power_window')
        params.power_window = 16;
    end
    if ~isfield(params, 'min_plateau')
        params.min_plateau = 100;
    end
    
    if isempty(state) || reset
        state = 0; % State machine
        power_thres = params.power_thres;
        power_window_shift = log2(params.power_window);
        min_plateau = params.min_plateau;
        pkt_rate = 0;
        pkt_len = 0;
        signal_decoded = 0;
        byte_count = 0;
        pkt_ht = 0;
        ht_mcs = 0;
        ht_cbw = 0;
        ht_sgi = 0;
        signal_bits = [];
        ht_sig_bits = [];
        ht_next = 0;
        eq_sample_count = 0;
        rot_eq_count = 0;
        normal_eq_count = 0;
        ht_sig1 = uint32(0);
        ht_sig2 = uint32(0);
        eq_i_buf = [];
        eq_q_buf = [];
        
        % Reset all modules
        power_trigger(0, 0, 0, power_thres, power_window_shift, 0, 1);
        sync_short(0, 0, 0, min_plateau, 1);
        sync_long(0, 0, 0, 0, 0, 0, 1);
        equalizer(zeros(56,1,'int16'), zeros(56,1,'int16'), 0, 0, 0, 0, 0, 1);
        ofdm_decoder(zeros(52,1,'int16'), zeros(52,1,'int16'), 0, 6, 1, 1);
        crc32(0, 0, 1);
    end
    
    % Default outputs
    byte_out = uint8(0);
    byte_valid = 0;
    fcs_ok = 0;
    pkt_info = struct('rate', pkt_rate, 'length', pkt_len, 'state', state, ...
                      'ht', pkt_ht, 'mcs', ht_mcs, 'cbw', ht_cbw, 'sgi', ht_sgi);
    debug_signals = struct();
    
    % Only process if enabled and have valid sample
    if ~enable || ~sample_strobe
        return;
    end
    
    %% State Machine
    % States (matching Verilog):
    % 0 = IDLE
    % 1 = POWER_TRIGGER
    % 2 = SYNC_SHORT
    % 3 = SYNC_LONG
    % 4 = DECODE_SIGNAL (Legacy SIGNAL field)
    % 5 = DETECT_HT (Check for BPSK rotation → HT detection)
    % 6 = HT_SIGNAL (Decode HT-SIG with 90° rotation)
    % 7 = CHECK_HT_SIG_CRC (Validate CRC-8)
    % 8 = CHECK_HT_SIG (Validate fields: MCS, CBW, etc.)
    % 9 = HT_STS (Skip HT Short Training - 64 samples)
    % 10 = HT_LTS (Process HT Long Training - 128 samples)
    % 11 = DECODE_DATA
    % 12 = CHECK_FCS
    
    %% Stage 1: Power Trigger
    [trigger, power_state] = power_trigger(sample_i, sample_q, 1, ...
                                           power_thres, power_window_shift, 0, 0);
    debug_signals.power_trigger = trigger;
    debug_signals.power_state = power_state;
    
    %% Stage 2: Short Preamble Synchronization
    sync_short_enable = (state >= 1);
    [metric, cfo_phase, sync_short_state, sto] = ...
        sync_short(sample_i, sample_q, sync_short_enable, min_plateau, 0);
    
    short_detected = (sync_short_state == 2);
    debug_signals.sync_short_metric = metric;
    debug_signals.cfo_phase = cfo_phase;
    debug_signals.sync_short_state = sync_short_state;
    debug_signals.sto_short = sto;
    
    %% Stage 3: Long Preamble Synchronization + FFT
    demod_ongoing = (state >= 4 && state <= 6);
    [fft_i, fft_q, sync_long_out, sync_long_strobe, sto_long] = ...
        sync_long(sample_i, sample_q, demod_ongoing, short_detected, pkt_ht, ht_sgi, 0);
    
    long_detected = sync_long_out;
    debug_signals.sync_long_detected = long_detected;
    debug_signals.sync_long_strobe = sync_long_strobe;
    debug_signals.sto_long = sto_long;
    
    %% Stage 4: Equalizer
    [eq_i, eq_q, eq_strobe, csi_valid] = ...
        equalizer(fft_i, fft_q, sync_long_strobe, long_detected, demod_ongoing, pkt_ht, ht_next, 0);
    
    debug_signals.eq_strobe = eq_strobe;
    debug_signals.csi_valid = csi_valid;
    
    %% Stage 5: OFDM Decoder (5 sub-modules)
    % Decoder contains: demodulate → deinterleave → viterbi → descramble → bits_to_bytes
    
    % Default rate (will be extracted from SIGNAL field in real implementation)
    if signal_decoded
        rate = pkt_rate;
    else
        rate = 6; % BPSK, rate 1/2 for SIGNAL field
    end
    
    do_descramble = 1; % Always descramble data
    
    [decoder_byte, decoder_byte_valid, demod_debug, deinter_debug, vit_debug, descram_debug] = ...
        ofdm_decoder(eq_i, eq_q, eq_strobe, rate, do_descramble, 0);
    
    debug_signals.demod_out = demod_debug;
    debug_signals.deinter_out = deinter_debug;
    debug_signals.viterbi_out = vit_debug;
    debug_signals.descram_out = descram_debug;
    
    %% Stage 6: CRC-32 Validation
    if decoder_byte_valid
        [fcs_result, fcs_strobe] = crc32(decoder_byte, decoder_byte_valid, 0);
        
        byte_out = decoder_byte;
        byte_valid = decoder_byte_valid;
        byte_count = byte_count + 1;
        
        if fcs_strobe
            fcs_ok = fcs_result;
        end
    end
    
    %% State Machine Logic
    switch state
        case 0 % IDLE
            if trigger
                state = 1;
                byte_count = 0;
                signal_decoded = 0;
                fprintf('[DOT11] Power trigger detected\n');
            end
            
        case 1 % POWER_TRIGGER
            if short_detected
                state = 2;
                fprintf('[DOT11] Short preamble detected (CFO phase: %.3f)\n', cfo_phase);
            end
            
        case 2 % SYNC_SHORT
            if long_detected
                state = 3;
                fprintf('[DOT11] Long preamble detected\n');
            end
            
        case 3 % SYNC_LONG
            if eq_strobe && csi_valid
                state = 4;
                fprintf('[DOT11] Channel estimated, decoding SIGNAL field\n');
            end
            
        case 4 % DECODE_SIGNAL (Legacy SIGNAL field)
            % Decode SIGNAL field (24 bits = 3 bytes)
            % Format: [RATE(4) | RSVD(1) | LENGTH(12) | PARITY(1) | TAIL(6)]
            
            if decoder_byte_valid
                signal_bits = [signal_bits; decoder_byte];
            end
            
            % Check for Legacy SIGNAL (first 3 bytes)
            if length(signal_bits) >= 3
                % Parse Legacy SIGNAL field
                sig_byte1 = signal_bits(1);
                sig_byte2 = signal_bits(2);
                sig_byte3 = signal_bits(3);
                
                % Extract rate field (4 bits)
                rate_field = bitand(sig_byte1, 15); % Lower 4 bits
                
                % Extract length (12 bits across bytes)
                len_low = bitshift(sig_byte1, -4); % Upper 4 bits of byte 1
                len_high = sig_byte2; % All 8 bits of byte 2
                pkt_len = bitor(len_low, bitshift(len_high, 4));
                
                % Map rate field to Mbps (Legacy rates)
                rate_map = [0, 0, 0, 0, 0, 0, 0, 0, 48, 24, 12, 6, 54, 36, 18, 9];
                pkt_rate = rate_map(rate_field + 1);
                
                fprintf('[DOT11] Legacy SIGNAL decoded: Rate field=0x%X, Rate=%d Mbps, Length=%d bytes\n', ...
                        rate_field, pkt_rate, pkt_len);
                
                % Transition to HT detection
                signal_decoded = 1;
                rot_eq_count = 0;
                normal_eq_count = 0;
                state = 5; % S_DETECT_HT
            end
            
        case 5 % DETECT_HT - Check for BPSK rotation (HT vs Legacy)
            % HT-SIG uses 90° clockwise rotation (Q dominant)
            % Legacy data uses normal BPSK (I dominant)
            % Count 4-8 symbols to determine format
            
            if eq_strobe
                % Get absolute values
                abs_eq_i = abs(eq_i(1));
                abs_eq_q = abs(eq_q(1));
                
                % Check if rotated (Q > I) or normal (I > Q)
                if abs_eq_q > abs_eq_i
                    rot_eq_count = rot_eq_count + 1; % HT indicator
                else
                    normal_eq_count = normal_eq_count + 1; % Legacy indicator
                end
                
                % Decide after 4+ symbols
                if rot_eq_count >= 4
                    pkt_ht = 1;
                    ht_sig_bits = [];
                    state = 6; % S_HT_SIGNAL
                    fprintf('[DOT11] HT format detected (rotation count: %d)\n', rot_eq_count);
                elseif normal_eq_count >= 4
                    pkt_ht = 0;
                    state = 11; % S_DECODE_DATA (Legacy)
                    fprintf('[DOT11] Legacy format confirmed\n');
                end
            end
            
        case 6 % HT_SIGNAL - Decode HT-SIG with 90° rotation
            % HT-SIG: 48 bits (6 bytes) with clockwise 90° rotation
            % Rotation: (I, Q) → (Q, -I)
            
            if eq_strobe
                % Apply 90° clockwise rotation: new_I = Q, new_Q = -I
                eq_i_rotated = eq_q;
                eq_q_rotated = -eq_i;
                
                % Store rotated symbols for decoder
                eq_i_buf = [eq_i_buf; eq_i_rotated];
                eq_q_buf = [eq_q_buf; eq_q_rotated];
            end
            
            % Feed rotated symbols to decoder (BPSK rate)
            % Note: This is simplified - actual implementation needs proper symbol feeding
            if decoder_byte_valid
                ht_sig_bits = [ht_sig_bits; decoder_byte];
            end
            
            % Check for complete HT-SIG (6 bytes)
            if length(ht_sig_bits) >= 6
                % Parse HT-SIG1 (24 bits)
                ht_sig1_byte1 = ht_sig_bits(1);
                ht_sig1_byte2 = ht_sig_bits(2);
                ht_sig1_byte3 = ht_sig_bits(3);
                
                % HT-SIG2 (24 bits)
                ht_sig2_byte1 = ht_sig_bits(4);
                ht_sig2_byte2 = ht_sig_bits(5);
                ht_sig2_byte3 = ht_sig_bits(6);
                
                % Extract fields from HT-SIG1
                ht_mcs = bitand(ht_sig1_byte1, 127); % Bits [6:0]
                ht_cbw = bitshift(ht_sig1_byte1, -7); % Bit [7]
                
                % HT Length (16 bits)
                pkt_len = bitor(ht_sig1_byte2, bitshift(ht_sig1_byte3, 8));
                
                % Extract fields from HT-SIG2
                ht_sgi = bitget(ht_sig2_byte1, 8); % Bit [7]
                
                % Extract CRC from HT-SIG2 bytes 1-2
                crc_received = bitand(bitshift(ht_sig2_byte2, 8) + ht_sig2_byte1, 255);
                
                fprintf('[DOT11] HT-SIG decoded: MCS=%d, CBW=%d, Len=%d, SGI=%d, CRC=0x%02X\n', ...
                        ht_mcs, ht_cbw, pkt_len, ht_sgi, crc_received);
                
                state = 7; % S_CHECK_HT_SIG_CRC
            end
            
        case 7 % CHECK_HT_SIG_CRC - Validate CRC-8
            % Compute CRC-8 over 34 bits: HT-SIG1[23:0] + HT-SIG2[9:0]
            
            % Prepare bit stream for CRC (34 bits)
            crc_bits = [];
            
            % HT-SIG1: 24 bits
            for i = 1:3
                byte_val = ht_sig_bits(i);
                for b = 0:7
                    crc_bits = [crc_bits; bitget(byte_val, b+1)];
                end
            end
            
            % HT-SIG2: First 10 bits
            for i = 1:2
                byte_val = ht_sig_bits(3+i);
                bits_to_add = 8;
                if i == 2
                    bits_to_add = 2; % Only 2 bits from second byte
                end
                for b = 0:(bits_to_add-1)
                    crc_bits = [crc_bits; bitget(byte_val, b+1)];
                end
            end
            
            % Compute CRC
            addpath('Main_pipeline_moduller');
            crc_computed = ht_sig_crc(crc_bits, 0);
            
            % Extract received CRC (8 bits from HT-SIG2)
            crc_received = bitshift(bitand(ht_sig_bits(5), 63), 2); % Bits [5:0] from byte 5
            crc_received = bitor(crc_received, bitshift(ht_sig_bits(6), -6)); % Bits [7:6] from byte 6
            
            if crc_computed == crc_received
                fprintf('[DOT11] ✓ HT-SIG CRC valid\n');
                state = 8; % S_CHECK_HT_SIG
            else
                fprintf('[DOT11] ✗ HT-SIG CRC error (computed=0x%02X, received=0x%02X)\n', ...
                        crc_computed, crc_received);
                state = 0; % Return to IDLE (packet error)
            end
            
        case 8 % CHECK_HT_SIG - Validate HT-SIG fields
            % Check for supported/unsupported features
            
            if ht_mcs > 7
                fprintf('[DOT11] ✗ Unsupported MCS %d (max 7)\n', ht_mcs);
                state = 0;
            elseif ht_cbw ~= 0
                fprintf('[DOT11] ✗ Unsupported bandwidth (40 MHz not supported)\n');
                state = 0;
            else
                fprintf('[DOT11] ✓ HT-SIG validated\n');
                eq_sample_count = 0;
                state = 9; % S_HT_STS
            end
            
        case 9 % HT_STS - Skip HT Short Training (64 samples)
            if sync_long_strobe
                eq_sample_count = eq_sample_count + 1;
            end
            
            if eq_sample_count >= 64
                fprintf('[DOT11] HT-STS skipped\n');
                eq_sample_count = 0;
                ht_next = 1; % Signal equalizer: HT-LTS coming
                state = 10; % S_HT_LTS
            end
            
        case 10 % HT_LTS - Process HT Long Training (128 samples = 2 symbols)
            if sync_long_strobe
                eq_sample_count = eq_sample_count + 1;
            end
            
            if eq_sample_count >= 64
                ht_next = 0; % Clear signal
                fprintf('[DOT11] HT-LTS processed, starting data decode\n');
                
                % Set HT rate encoding (MSB = 1 for HT)
                pkt_rate = bitor(128, ht_mcs); % Bit 7 = 1, bits[6:0] = MCS
                
                state = 11; % S_DECODE_DATA
            end
            
        case 11 % DECODE_DATA
            % Continue decoding until packet length reached
            if byte_count >= (3 + pkt_len + 4) % SIGNAL + DATA + FCS
                state = 12;
            end
            
        case 12 % CHECK_FCS
            % FCS checked, return to idle
            if fcs_ok
                fprintf('[DOT11] ✓ Packet decoded successfully (FCS OK)\n');
            else
                fprintf('[DOT11] ✗ Packet decode failed (FCS ERROR)\n');
            end
            state = 0;
    end
    
    % Update packet info
    pkt_info.rate = pkt_rate;
    pkt_info.length = pkt_len;
    pkt_info.state = state;
    pkt_info.byte_count = byte_count;
    pkt_info.signal_decoded = signal_decoded;
    pkt_info.ht = pkt_ht;
    pkt_info.mcs = ht_mcs;
    pkt_info.cbw = ht_cbw;
    pkt_info.sgi = ht_sgi;
end
