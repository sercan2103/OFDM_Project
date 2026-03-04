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
        
        % Reset all modules
        power_trigger(0, 0, 0, power_thres, power_window_shift, 0, 1);
        sync_short(0, 0, 0, min_plateau, 1);
        sync_long(0, 0, 0, 0, 1);
        equalizer(zeros(52,1,'int16'), zeros(52,1,'int16'), 0, 0, 0, 1);
        ofdm_decoder(zeros(48,1,'int16'), zeros(48,1,'int16'), 0, 6, 1, 1);
        crc32(0, 0, 1);
    end
    
    % Default outputs
    byte_out = uint8(0);
    byte_valid = 0;
    fcs_ok = 0;
    pkt_info = struct('rate', pkt_rate, 'length', pkt_len, 'state', state);
    debug_signals = struct();
    
    % Only process if enabled and have valid sample
    if ~enable || ~sample_strobe
        return;
    end
    
    %% State Machine
    % States:
    % 0 = IDLE
    % 1 = POWER_TRIGGER
    % 2 = SYNC_SHORT
    % 3 = SYNC_LONG
    % 4 = DECODE_SIGNAL
    % 5 = DECODE_DATA
    % 6 = CHECK_FCS
    
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
        sync_long(sample_i, sample_q, demod_ongoing, short_detected, 0);
    
    long_detected = sync_long_out;
    debug_signals.sync_long_detected = long_detected;
    debug_signals.sync_long_strobe = sync_long_strobe;
    debug_signals.sto_long = sto_long;
    
    %% Stage 4: Equalizer
    [eq_i, eq_q, eq_strobe, csi_valid] = ...
        equalizer(fft_i, fft_q, sync_long_strobe, long_detected, demod_ongoing, 0);
    
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
            
        case 4 % DECODE_SIGNAL
            % First 3 bytes are SIGNAL field (24 bits)
            % Format: [RATE(4) | RSVD(1) | LENGTH(12) | PARITY(1) | TAIL(6)]
            if byte_count >= 3
                % Parse SIGNAL field (simplified)
                % TODO: Implement proper SIGNAL field parsing
                pkt_rate = 6; % Default
                pkt_len = 100; % Default
                signal_decoded = 1;
                state = 5;
                fprintf('[DOT11] SIGNAL decoded: Rate=%d Mbps, Length=%d bytes\n', pkt_rate, pkt_len);
            end
            
        case 5 % DECODE_DATA
            % Continue decoding until packet length reached
            if byte_count >= (3 + pkt_len + 4) % SIGNAL + DATA + FCS
                state = 6;
            end
            
        case 6 % CHECK_FCS
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
end
