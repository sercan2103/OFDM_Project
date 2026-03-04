function [byte_out, byte_valid, fcs_ok] = ...
    ofdm_decoder(sample_i, sample_q, enable, reset)
% OFDM_DECODER Top-level IEEE 802.11 OFDM receiver
%
% Complete OFDM receiver pipeline integrating all modules:
%   Power trigger → Sync short → Sync long → Equalizer → 
%   Demodulate → Deinterleave → Viterbi → Descramble → 
%   Bits to bytes → CRC check
%
% Inputs:
%   sample_i, sample_q: 16-bit signed I/Q samples
%   enable: Start processing
%   reset: Reset all modules
%
% Outputs:
%   byte_out: Decoded bytes (8-bit)
%   byte_valid: Valid signal for byte output
%   fcs_ok: Frame check sequence validation result
%
% This is the top-level module that orchestrates the entire RX pipeline

    % Add module paths
    addpath('../BasicModules');
    addpath('../LUTs');
    
    persistent state;
    persistent power_thres power_window_shift min_plateau;
    
    if isempty(state) || reset
        state = 0;
        
        % Parameters
        power_thres = 200000;
        power_window_shift = 4; % Window size = 16
        min_plateau = 100;
        
        % Reset all modules
        power_trigger(0, 0, 0, power_thres, power_window_shift, 0, 1);
        sync_short(0, 0, 0, min_plateau, 1);
        sync_long(0, 0, 0, 0, 1);
        equalizer(zeros(52,1), zeros(52,1), 0, 0, 0, 1);
        demodulate(zeros(48,1), zeros(48,1), 0, 0, 1);
        deinterleave(0, 0, 0, 1);
        viterbi_decode(zeros(48,1), 0, 1);
        descramble(0, 0, 0, 1);
        bits_to_bytes(0, 0, 1);
        crc32(0, 0, 1);
    end
    
    % Default outputs
    byte_out = uint8(0);
    byte_valid = 0;
    fcs_ok = 0;
    
    % Pipeline connections
    
    % Stage 1: Power trigger
    [trigger, ~] = power_trigger(sample_i, sample_q, enable, ...
                                  power_thres, power_window_shift, 0, 0);
    
    % Stage 2: Short preamble sync
    [~, cfo_phase, sync_short_state, ~] = sync_short(sample_i, sample_q, ...
                                                       trigger, min_plateau, 0);
    short_detected = (sync_short_state == 2);
    
    % Stage 3: Long preamble sync and FFT
    demod_ongoing = (state >= 3 && state <= 7);
    [fft_i, fft_q, sync_long_out, sync_long_strobe, ~] = ...
        sync_long(sample_i, sample_q, demod_ongoing, short_detected, 0);
    
    % Stage 4: Equalizer
    [eq_i, eq_q, eq_strobe, ~] = ...
        equalizer(fft_i, fft_q, sync_long_strobe, sync_long_out, demod_ongoing, 0);
    
    % Stage 5: Demodulate
    % TODO: Need to extract rate info from SIGNAL field
    rate = 6; % Default: BPSK, rate 1/2 (6 Mbps)
    [soft_bits, demod_strobe] = demodulate(eq_i, eq_q, eq_strobe, rate, 0);
    
    % Stage 6: Deinterleave
    for bit_idx = 1:length(soft_bits)
        [deinter_bit, deinter_strobe] = deinterleave(soft_bits(bit_idx), ...
                                                       demod_strobe, rate, 0);
        
        % Stage 7: Viterbi decode
        if deinter_strobe
            [decoded_bit, viterbi_strobe] = viterbi_decode(deinter_bit, deinter_strobe, 0);
            
            % Stage 8: Descramble
            if viterbi_strobe
                [descram_bit, descram_strobe] = descramble(decoded_bit, viterbi_strobe, 0, 0);
                
                % Stage 9: Bits to bytes
                if descram_strobe
                    [byte, byte_strobe] = bits_to_bytes(descram_bit, descram_strobe, 0);
                    
                    % Stage 10: CRC check
                    if byte_strobe
                        [fcs_out, fcs_strobe] = crc32(byte, byte_strobe, 0);
                        
                        byte_out = byte;
                        byte_valid = byte_strobe;
                        fcs_ok = fcs_out;
                    end
                end
            end
        end
    end
    
    % State machine for overall control
    switch state
        case 0 % IDLE
            if trigger
                state = 1;
            end
        case 1 % WAITING_SHORT
            if short_detected
                state = 2;
            end
        case 2 % WAITING_LONG
            if sync_long_out
                state = 3;
            end
        case 3 % PROCESSING
            % Continue until packet done
            % TODO: Add packet length tracking
    end
end
