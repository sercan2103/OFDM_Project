function [fft_out_i, fft_out_q, sync_long_out, sync_long_out_strobe, sto_out] = ...
    sync_long(sample_i, sample_q, demod_is_ongoing, short_preamble_detected, ht_mode, short_gi, reset)
% SYNC_LONG Long preamble synchronization and FFT
%
% IEEE 802.11a/g/n long preamble detection and channel estimation
% Uses 64-point FFT and cross-correlation with known preamble
%
% Inputs:
%   sample_i, sample_q: 16-bit signed I/Q samples
%   demod_is_ongoing: High when demodulation active
%   short_preamble_detected: Trigger from sync_short
%   ht_mode: 1=HT format, 0=Legacy format
%   short_gi: Short guard interval flag (HT only)
%   reset: Reset state
%
% Outputs:
%   fft_out_i, fft_out_q: FFT output (52 for Legacy, 56 for HT)
%   sync_long_out: Detection flag (starts symbol processing)
%   sync_long_out_strobe: Valid signal for outputs
%   sto_out: Sample timing offset
%
% States: 0=IDLE, 1=COLLECT_SAMPLES, 2=PROCESS_FFT, 3=CORRELATE, 4=OFDM_SYMBOL
%
% Processing:
%   1. Wait for short preamble trigger
%   2. Collect 64 samples after skip (32 samples CP + 64 samples symbol)
%   3. Perform 64-point FFT
%   4. Cross-correlate with known long preamble
%   5. Detect peak → start OFDM symbol processing

    persistent state;
    persistent sample_buffer; % 64-sample buffer for FFT
    persistent sample_count;
    persistent skip_count;
    persistent fft_buffer_i fft_buffer_q;
    persistent symbol_count;
    persistent sto;
    persistent ht; % HT mode flag
    persistent gi_samples; % Guard interval samples
    
    if isempty(state) || reset
        state = 0;
        sample_buffer = zeros(64, 2); % [I, Q]
        sample_count = 0;
        skip_count = 0;
        fft_buffer_i = zeros(64, 1);
        fft_buffer_q = zeros(64, 1);
        symbol_count = 0;
        sto = 0;
        ht = 0;
        gi_samples = 16; % Default GI
    end
    
    % Determine subcarrier count and GI based on mode
    if short_preamble_detected
        ht = ht_mode;
        if ht && short_gi
            gi_samples = 8; % Short GI for HT
        else
            gi_samples = 16; % Normal GI
        end
    end
    
    num_subcarriers = 52; % Legacy
    if ht
        num_subcarriers = 56; % HT
    end
    
    % Default outputs
    fft_out_i = zeros(num_subcarriers, 1);
    fft_out_q = zeros(num_subcarriers, 1);
    sync_long_out = 0;
    sync_long_out_strobe = 0;
    sto_out = sto;
    
    % State machine
    switch state
        case 0 % IDLE
            if short_preamble_detected
                state = 1;
                sample_count = 0;
                skip_count = 0;
                sto = 0;
            end
            
        case 1 % COLLECT_SAMPLES
            % Skip first 32 samples (short preamble tail + CP)
            if skip_count < 32
                skip_count = skip_count + 1;
            else
                % Collect 64 samples for FFT
                sample_count = sample_count + 1;
                sample_buffer(sample_count, :) = [double(sample_i), double(sample_q)];
                
                if sample_count >= 64
                    state = 2;
                    sample_count = 0;
                end
            end
            sto = sto + 1;
            
        case 2 % PROCESS_FFT
            % Prepare FFT input (normalize to prevent overflow)
            fft_in = (sample_buffer(:,1) + 1j*sample_buffer(:,2)) / 32768;
            
            % 64-point FFT
            fft_result = fft(fft_in, 64);
            
            % Extract used subcarriers (802.11 uses -26:26 for Legacy, -28:28 for HT)
            % Legacy (52): DC at index 1, -26:-1 at 39:64, 1:26 at 2:27
            % HT (56): DC at index 1, -28:-1 at 37:64, 1:28 at 2:29
            if ht
                used_indices = [37:64, 2:29]; % HT: 56 subcarriers
            else
                used_indices = [39:64, 2:27]; % Legacy: 52 subcarriers
            end
            fft_used = fft_result(used_indices);
            
            % Convert back to fixed-point I/Q
            fft_buffer_i = int16(real(fft_used) * 32768);
            fft_buffer_q = int16(imag(fft_used) * 32768);
            
            state = 3;
            
        case 3 % CORRELATE
            % Cross-correlate with known long preamble
            % Known sequence (LTS in frequency domain): BPSK on pilot subcarriers
            % Simplified: Check if we have valid FFT output
            
            % Calculate correlation metric
            fft_power = sum(double(fft_buffer_i).^2 + double(fft_buffer_q).^2);
            
            if fft_power > 1e6 % Threshold
                % Long preamble detected
                sync_long_out = 1;
                sync_long_out_strobe = 1;
                
                % Output FFT result
                fft_out_i = fft_buffer_i;
                fft_out_q = fft_buffer_q;
                
                symbol_count = 0;
                state = 4;
            else
                % Not detected, go back to collecting
                state = 1;
                sample_count = 0;
                skip_count = 0;
            end
            
        case 4 % OFDM_SYMBOL
            % Process OFDM symbols
            % Legacy: 80 samples (16 CP + 64 FFT)
            % HT with short GI: 72 samples (8 CP + 64 FFT)
            symbol_len = gi_samples + 64;
            
            if demod_is_ongoing
                % Collect samples for next symbol
                sample_count = sample_count + 1;
                
                % Skip cyclic prefix
                if sample_count > gi_samples && sample_count <= symbol_len
                    idx = sample_count - gi_samples;
                    sample_buffer(idx, :) = [double(sample_i), double(sample_q)];
                end
                
                if sample_count >= symbol_len
                    % Process symbol
                    fft_in = (sample_buffer(:,1) + 1j*sample_buffer(:,2)) / 32768;
                    fft_result = fft(fft_in, 64);
                    
                    % Extract used subcarriers
                    used_indices = [39:64, 2:27];
                    fft_used = fft_result(used_indices);
                    
                    % Convert to fixed-point
                    fft_out_i = int16(real(fft_used) * 32768);
                    fft_out_q = int16(imag(fft_used) * 32768);
                    
                    sync_long_out_strobe = 1;
                    symbol_count = symbol_count + 1;
                    sample_count = 0;
                end
            else
                % Demod finished, return to idle
                state = 0;
            end
            
            sto = sto + 1;
    end
    
    sto_out = sto;
end
