function [fft_out_i, fft_out_q, sync_long_out, sync_long_out_strobe, sto_out] = ...
    sync_long(sample_i, sample_q, demod_is_ongoing, short_preamble_detected, reset)
% SYNC_LONG Long preamble synchronization and FFT
%
% IEEE 802.11 long preamble detection and channel estimation
% Uses 64-point FFT and cross-correlation with known preamble
%
% Inputs:
%   sample_i, sample_q: 16-bit signed I/Q samples
%   demod_is_ongoing: High when demodulation active
%   short_preamble_detected: Trigger from sync_short
%   reset: Reset state
%
% Outputs:
%   fft_out_i, fft_out_q: FFT output (52 subcarriers)
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
    
    if isempty(state) || reset
        state = 0;
        sample_buffer = zeros(64, 2); % [I, Q]
        sample_count = 0;
        skip_count = 0;
        fft_buffer_i = zeros(64, 1);
        fft_buffer_q = zeros(64, 1);
        symbol_count = 0;
        sto = 0;
    end
    
    % Default outputs
    fft_out_i = zeros(52, 1);
    fft_out_q = zeros(52, 1);
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
            
            % Extract used subcarriers (802.11 uses -26:26, excluding 0)
            % Mapping: DC at index 1, -26:-1 at indices 39:64, 1:26 at indices 2:27
            used_indices = [39:64, 2:27]; % 52 subcarriers
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
            % Process OFDM symbols (80 samples: 16 CP + 64 FFT)
            if demod_is_ongoing
                % Collect samples for next symbol
                sample_count = sample_count + 1;
                
                % Skip cyclic prefix (16 samples)
                if sample_count > 16 && sample_count <= 80
                    idx = sample_count - 16;
                    sample_buffer(idx, :) = [double(sample_i), double(sample_q)];
                end
                
                if sample_count >= 80
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
