function [eq_i, eq_q, eq_out_strobe, csi_valid] = ...
    equalizer(fft_i, fft_q, fft_strobe, sync_long_detected, demod_is_ongoing, ht_mode, ht_next, reset)
% EQUALIZER Channel equalization and pilot tracking
%
% IEEE 802.11a/g/n single-tap frequency-domain equalizer
% Uses long preamble for initial channel estimate
% Tracks phase with pilot subcarriers (-21, -7, +7, +21)
%
% Inputs:
%   fft_i, fft_q: FFT output (52 for Legacy, 56 for HT), int16
%   fft_strobe: Valid signal for FFT output
%   sync_long_detected: Trigger from sync_long
%   demod_is_ongoing: High during demodulation
%   ht_mode: 1=HT (802.11n), 0=Legacy (802.11a/g)
%   ht_next: Signal that HT-LTS coming (switch to HT mode)
%   reset: Reset state
%
% Outputs:
%   eq_i, eq_q: Equalized symbols (48 for Legacy, 52 for HT), int16
%   eq_out_strobe: Valid signal for equalized output
%   csi_valid: Channel state information valid flag
%
% Subcarrier mapping:
%   Legacy (52 total): 48 data + 4 pilots at -21, -7, +7, +21
%   HT (56 total): 52 data + 4 pilots at -21, -7, +7, +21
%
% Processing:
%   1. Estimate channel from long preamble (2 symbols)
%   2. Invert channel response: H_inv = conj(H) / |H|^2
%   3. Equalize data: Y_eq = Y * H_inv
%   4. Track phase with pilots and apply correction

    persistent state;
    persistent channel_est_i channel_est_q; % Channel estimate (52/56 subcarriers)
    persistent lts_count; % Long training symbol count
    persistent pilot_phase; % Accumulated pilot phase
    persistent symbol_idx;
    persistent ht; % HT mode flag
    persistent ht_lts_count; % HT-LTS symbol count
    persistent lts_ref; % Current LTS reference pattern
    
    % Determine number of subcarriers based on mode
    if isempty(ht)
        ht = 0;
    end
    
    % Update HT mode when new packet detected
    if sync_long_detected
        ht = ht_mode;
    end
    
    num_subcarriers = 52; % Legacy default
    num_data_subcarriers = 48;
    
    if ht
        num_subcarriers = 56; % HT format
        num_data_subcarriers = 52;
    end
    
    % IEEE 802.11 pilot subcarrier positions
    % Legacy (52): -26:-1 → indices 1:26, +1:+26 → indices 27:52
    % HT (56): -28:-1 → indices 1:28, +1:+28 → indices 29:56
    % Pilots at -21, -7, +7, +21
    if ht
        PILOT_INDICES = [8, 22, 36, 50]; % HT: adjusted for 56-carrier array
    else
        PILOT_INDICES = [6, 20, 34, 48]; % Legacy: 52-carrier array
    end
    
    % HT pilot polarity (from Verilog: HT_POLARITY = 4'b1000)
    % Legacy uses standard scrambled sequence
    if ht
        PILOT_POLARITY = [0, 0, 0, 1]; % HT polarity
    else
        PILOT_POLARITY = [1, 1, 1, -1]; % Legacy (simplified)
    end
    
    if isempty(state) || reset
        state = 0;
        channel_est_i = zeros(56, 1); % Max size for HT
        channel_est_q = zeros(56, 1);
        lts_count = 0;
        pilot_phase = 0;
        symbol_idx = 0;
        ht = 0;
        ht_lts_count = 0;
        lts_ref = 0; % 0=Legacy LTS, 1=HT-LTS
    end
    
    % Default outputs (size depends on mode)
    eq_i = zeros(num_data_subcarriers, 1, 'int16');
    eq_q = zeros(num_data_subcarriers, 1, 'int16');
    eq_out_strobe = 0;
    csi_valid = 0;
    
    % State machine
    switch state
        case 0 % IDLE
            if sync_long_detected
                state = 1;
                lts_count = 0;
                symbol_idx = 0;
                lts_ref = 0; % Start with Legacy LTS
            end
            
        case 1 % ESTIMATE_CHANNEL
            if fft_strobe
                lts_count = lts_count + 1;
                
                % Known LTS sequence in frequency domain
                % Legacy: 2 LTS symbols (standard)
                % HT: 2 HT-LTS symbols after L-LTS
                % For now, use first LTS symbol as channel estimate
                if lts_count == 1
                    % First LTS: Initialize channel estimate
                    channel_est_i(1:num_subcarriers) = double(fft_i(1:num_subcarriers));
                    channel_est_q(1:num_subcarriers) = double(fft_q(1:num_subcarriers));
                elseif lts_count == 2
                    % Second LTS: Average with first
                    channel_est_i(1:num_subcarriers) = (channel_est_i(1:num_subcarriers) + double(fft_i(1:num_subcarriers))) / 2;
                    channel_est_q(1:num_subcarriers) = (channel_est_q(1:num_subcarriers) + double(fft_q(1:num_subcarriers))) / 2;
                    
                    % Channel estimate complete
                    csi_valid = 1;
                    state = 2;
                end
            end
            
        case 2 % EQUALIZE
            % Check for ht_next signal: switch to HT mode
            if ~ht && ht_next
                ht = 1;
                lts_ref = 1; % Switch to HT-LTS reference
                ht_lts_count = 0;
                state = 5; % S_HT_LTS
                fprintf('[EQUALIZER] Switching to HT mode, processing HT-LTS\n');
                return;
            end
            
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
                
                % Equalize all subcarriers (52 for Legacy, 56 for HT)
                eq_full_i = zeros(num_subcarriers, 1);
                eq_full_q = zeros(num_subcarriers, 1);
                
                for k = 1:num_subcarriers
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
                
                for k = 1:num_subcarriers
                    i_temp = eq_full_i(k);
                    q_temp = eq_full_q(k);
                    eq_full_i(k) = i_temp * cos_phase - q_temp * sin_phase;
                    eq_full_q(k) = i_temp * sin_phase + q_temp * cos_phase;
                end
                
                % Extract data subcarriers (remove pilots)
                % Legacy: 48 data from 52 total
                % HT: 52 data from 56 total
                data_mask = true(num_subcarriers, 1);
                data_mask(PILOT_INDICES) = false;
                
                eq_i = int16(eq_full_i(data_mask));
                eq_q = int16(eq_full_q(data_mask));
                eq_out_strobe = 1;
                csi_valid = 1;
                
            elseif ~demod_is_ongoing
                % Return to idle
                state = 0;
            end
            
        case 5 % S_HT_LTS - Process HT Long Training Symbols
            if fft_strobe
                ht_lts_count = ht_lts_count + 1;
                
                % HT-LTS: 2 symbols for HT channel estimation
                % Update channel estimate with HT-LTS pattern
                if ht_lts_count == 1
                    % First HT-LTS: Update channel estimate
                    channel_est_i(1:num_subcarriers) = double(fft_i(1:num_subcarriers));
                    channel_est_q(1:num_subcarriers) = double(fft_q(1:num_subcarriers));
                elseif ht_lts_count == 2
                    % Second HT-LTS: Average with first
                    channel_est_i(1:num_subcarriers) = (channel_est_i(1:num_subcarriers) + double(fft_i(1:num_subcarriers))) / 2;
                    channel_est_q(1:num_subcarriers) = (channel_est_q(1:num_subcarriers) + double(fft_q(1:num_subcarriers))) / 2;
                    
                    % HT-LTS complete, ready for data
                    csi_valid = 1;
                    state = 2; % Back to EQUALIZE
                    fprintf('[EQUALIZER] HT-LTS complete, HT channel estimated\n');
                end
            end
    end
end
