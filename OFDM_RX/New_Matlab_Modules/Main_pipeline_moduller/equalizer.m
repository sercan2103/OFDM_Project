function [eq_i, eq_q, eq_out_strobe, csi_valid] = ...
    equalizer(fft_i, fft_q, fft_strobe, sync_long_detected, demod_is_ongoing, reset)
% EQUALIZER Channel equalization and pilot tracking
%
% IEEE 802.11 single-tap frequency-domain equalizer
% Uses long preamble for initial channel estimate
% Tracks phase with pilot subcarriers (-21, -7, +7, +21)
%
% Inputs:
%   fft_i, fft_q: FFT output (52 subcarriers), int16
%   fft_strobe: Valid signal for FFT output
%   sync_long_detected: Trigger from sync_long
%   demod_is_ongoing: High during demodulation
%   reset: Reset state
%
% Outputs:
%   eq_i, eq_q: Equalized symbols (48 data subcarriers), int16
%   eq_out_strobe: Valid signal for equalized output
%   csi_valid: Channel state information valid flag
%
% Subcarrier mapping (52 total):
%   Data: 48 subcarriers (indices excluding pilots)
%   Pilots: 4 subcarriers at positions -21, -7, +7, +21 (BPSK)
%
% Processing:
%   1. Estimate channel from long preamble (2 symbols)
%   2. Invert channel response: H_inv = conj(H) / |H|^2
%   3. Equalize data: Y_eq = Y * H_inv
%   4. Track phase with pilots and apply correction

    persistent state;
    persistent channel_est_i channel_est_q; % Channel estimate (52 subcarriers)
    persistent lts_count; % Long training symbol count
    persistent pilot_phase; % Accumulated pilot phase
    persistent symbol_idx;
    
    % IEEE 802.11 pilot subcarrier positions (in 52-subcarrier array)
    % Mapping: -26:-1 → indices 1:26, +1:+26 → indices 27:52
    % Pilots at -21, -7, +7, +21 → indices 6, 20, 34, 48
    PILOT_INDICES = [6, 20, 34, 48];
    
    % Known pilot sequence (BPSK: +1, -1, +1, -1 in polarity)
    PILOT_POLARITY = [1, 1, 1, -1]; % Simplified (actual is scrambled)
    
    if isempty(state) || reset
        state = 0;
        channel_est_i = zeros(52, 1);
        channel_est_q = zeros(52, 1);
        lts_count = 0;
        pilot_phase = 0;
        symbol_idx = 0;
    end
    
    % Default outputs
    eq_i = zeros(48, 1, 'int16');
    eq_q = zeros(48, 1, 'int16');
    eq_out_strobe = 0;
    csi_valid = 0;
    
    % State machine
    switch state
        case 0 % IDLE
            if sync_long_detected
                state = 1;
                lts_count = 0;
                symbol_idx = 0;
            end
            
        case 1 % ESTIMATE_CHANNEL
            if fft_strobe
                lts_count = lts_count + 1;
                
                % Known LTS sequence in frequency domain (simplified)
                % Actual LTS: BPSK modulated with specific pattern
                % For now, use first LTS symbol as channel estimate
                if lts_count == 1
                    % First LTS: Initialize channel estimate
                    channel_est_i = double(fft_i);
                    channel_est_q = double(fft_q);
                elseif lts_count == 2
                    % Second LTS: Average with first
                    channel_est_i = (channel_est_i + double(fft_i)) / 2;
                    channel_est_q = (channel_est_q + double(fft_q)) / 2;
                    
                    % Channel estimate complete
                    csi_valid = 1;
                    state = 2;
                end
            end
            
        case 2 % EQUALIZE
            if demod_is_ongoing && fft_strobe
                symbol_idx = symbol_idx + 1;
                
                % Extract pilot subcarriers for phase tracking
                pilot_i = double(fft_i(PILOT_INDICES));
                pilot_q = double(fft_q(PILOT_INDICES));
                
                % Compute phase error from pilots
                % Compare received pilots with expected (after channel correction)
                phase_error = 0;
                for p = 1:4
                    idx = PILOT_INDICES(p);
                    
                    % Expected pilot (BPSK, scaled by channel)
                    h_i = channel_est_i(idx);
                    h_q = channel_est_q(idx);
                    h_mag_sq = h_i^2 + h_q^2;
                    
                    if h_mag_sq > 1e-6
                        % Equalize pilot
                        eq_pilot_i = (pilot_i(p) * h_i + pilot_q(p) * h_q) / h_mag_sq;
                        eq_pilot_q = (pilot_q(p) * h_i - pilot_i(p) * h_q) / h_mag_sq;
                        
                        % Phase error: atan2(Q, I)
                        % Expected: BPSK → Q should be ~0
                        phase_error = phase_error + eq_pilot_q;
                    end
                end
                phase_error = phase_error / 4; % Average
                
                % Update pilot phase (integrate error)
                pilot_phase = pilot_phase + phase_error * 0.01; % Loop filter
                
                % Equalize all subcarriers
                eq_full_i = zeros(52, 1);
                eq_full_q = zeros(52, 1);
                
                for k = 1:52
                    y_i = double(fft_i(k));
                    y_q = double(fft_q(k));
                    h_i = channel_est_i(k);
                    h_q = channel_est_q(k);
                    
                    % Channel inversion: Y * conj(H) / |H|^2
                    h_mag_sq = h_i^2 + h_q^2;
                    
                    if h_mag_sq > 1e-6
                        % Complex division: (y_i + j*y_q) * (h_i - j*h_q) / h_mag_sq
                        eq_full_i(k) = (y_i * h_i + y_q * h_q) / h_mag_sq;
                        eq_full_q(k) = (y_q * h_i - y_i * h_q) / h_mag_sq;
                    else
                        eq_full_i(k) = 0;
                        eq_full_q(k) = 0;
                    end
                end
                
                % Apply pilot phase correction
                cos_phase = cos(-pilot_phase);
                sin_phase = sin(-pilot_phase);
                
                for k = 1:52
                    i_temp = eq_full_i(k);
                    q_temp = eq_full_q(k);
                    eq_full_i(k) = i_temp * cos_phase - q_temp * sin_phase;
                    eq_full_q(k) = i_temp * sin_phase + q_temp * cos_phase;
                end
                
                % Extract data subcarriers (remove pilots)
                data_mask = true(52, 1);
                data_mask(PILOT_INDICES) = false;
                
                eq_i = int16(eq_full_i(data_mask));
                eq_q = int16(eq_full_q(data_mask));
                eq_out_strobe = 1;
                csi_valid = 1;
                
            elseif ~demod_is_ongoing
                % Return to idle
                state = 0;
            end
    end
end
