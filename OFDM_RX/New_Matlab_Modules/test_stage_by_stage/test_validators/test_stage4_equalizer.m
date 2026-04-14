function result = test_stage4_equalizer(fft_i, fft_q, channel_est, params, expected)
% TEST_STAGE4_EQUALIZER - Test equalizer module
%
% Tests equalizer.m for channel compensation
%
% Inputs:
%   fft_i, fft_q: FFT output subcarriers (int16)
%   channel_est: Channel estimates (complex)
%   params: Test parameters
%   expected: Expected outputs (optional)
%
% Outputs:
%   result.pass: Boolean test result
%   result.equalized: Equalized symbols (complex)
%   result.signal_info: Decoded SIGNAL field
%   result.message: Test message

    result = struct();
    result.pass = false;
    result.message = '';
    
    fprintf('\n=== STAGE 4: Equalizer ===\n');
    
    %% Initialize module
    addpath('../');
    
    %% Run equalizer
    num_samples = length(fft_i);
    fprintf('[Stage 4] Processing %d FFT outputs\n', num_samples);
    
    % DEBUG OUTPUT
    fprintf('[DEBUG Stage4] fft_i length: %d\n', length(fft_i));
    fprintf('[DEBUG Stage4] fft_i type: %s\n', class(fft_i));
    fprintf('[DEBUG Stage4] fft_i size: ');
    disp(size(fft_i));
    
    % Initialize module state
    reset = true;  % Reset on first call
    equalizer_out_i_vec = [];
    equalizer_out_q_vec = [];
    equalizer_out_strobe_vec = [];
    
    % Equalizer processes blocks of subcarriers (52 for Legacy)
    % We need to group the FFT outputs into blocks of 52 subcarriers
    % Since we have 676 total outputs, that's 13 OFDM symbols (676/52)
    
    num_subcarriers = 52;  % Legacy 802.11a/g (use 52 data subcarriers per OFDM symbol)
    num_symbols = floor(num_samples / num_subcarriers);
    
    for sym = 1:num_symbols
        % Extract one complete OFDM symbol (52 subcarriers)
        start_idx = (sym - 1) * num_subcarriers + 1;
        end_idx = start_idx + num_subcarriers - 1;
        
        i_block = fft_i(start_idx:end_idx);
        q_block = fft_q(start_idx:end_idx);
        
        % Call equalizer with block of subcarriers
        fft_strobe = true;
        sync_long_detected = 1;  % We have completed sync_long
        demod_is_ongoing = 1;  % Currently demodulating
        ht_mode = 0;  % Legacy 802.11a/g (not HT)
        ht_next = 0;  % No HT coming
        
        [eq_i, eq_q, eq_out_strobe, csi_valid] = ...
            equalizer(i_block, q_block, fft_strobe, sync_long_detected, demod_is_ongoing, ht_mode, ht_next, reset);
        
        % Store outputs if valid
        if eq_out_strobe
            equalizer_out_i_vec = [equalizer_out_i_vec; eq_i];
            equalizer_out_q_vec = [equalizer_out_q_vec; eq_q];
            equalizer_out_strobe_vec = [equalizer_out_strobe_vec; true];
        end
        
        reset = false;  % Only reset on first call
    end
    
    %% Validate result
    result.equalized = complex(double(equalizer_out_i_vec), double(equalizer_out_q_vec));
    
    % Check if equalization produced outputs
    if ~isempty(equalizer_out_i_vec)
        num_equalized = length(equalizer_out_i_vec);
        fprintf('[Stage 4] Equalized symbols: %d\n', num_equalized);
        
        % Validate constellation (symbols should cluster around BPSK/QPSK/QAM points)
        eq_mag = abs(result.equalized);
        avg_mag = mean(eq_mag);
        std_mag = std(eq_mag);
        
        fprintf('[Stage 4] Symbol magnitude: mean=%.2f, std=%.2f\n', avg_mag, std_mag);
        
        % Reasonable constellation power (normalized constellations have mag ~1, unnormalized ~100+)
        if avg_mag > 0.5 && avg_mag < 50000
            result.pass = true;
            result.message = sprintf('PASS: Equalized %d symbols, avg mag=%.2f', ...
                                    num_equalized, avg_mag);
        else
            result.pass = false;
            result.message = sprintf('FAIL: Unusual symbol magnitude: %.2f', avg_mag);
        end
        
        % Check against expected
        if nargin >= 5 && ~isempty(expected) && isfield(expected, 'equalized')
            % Compare equalized symbols
            if length(result.equalized) == length(expected.equalized)
                % Normalize and compare
                eq_norm = result.equalized / sqrt(mean(abs(result.equalized).^2));
                exp_norm = expected.equalized / sqrt(mean(abs(expected.equalized).^2));
                
                mse = mean(abs(eq_norm - exp_norm).^2);
                fprintf('[Stage 4] MSE with expected: %.6f\n', mse);
                
                if mse < 0.1  % Low error
                    fprintf('[Stage 4] Good match with expected\n');
                else
                    result.pass = false;
                    result.message = [result.message, sprintf(' | High MSE: %.6f', mse)];
                end
            end
        end
    else
        result.pass = false;
        result.message = 'FAIL: No equalized outputs';
    end
    
    %% Generate diagnostic plot
    if isfield(params, 'plot') && params.plot && ~isempty(result.equalized)
        figure('Name', 'Stage 4: Equalizer');
        
        subplot(2,2,1);
        plot(result.equalized, 'o');
        title('Equalized Constellation');
        xlabel('Real');
        ylabel('Imag');
        grid on;
        axis equal;
        
        subplot(2,2,2);
        plot(abs(result.equalized));
        title('Symbol Magnitude');
        xlabel('Symbol Index');
        ylabel('Magnitude');
        grid on;
        
        subplot(2,2,3);
        plot(angle(result.equalized));
        title('Symbol Phase');
        xlabel('Symbol Index');
        ylabel('Phase (rad)');
        grid on;
        
        subplot(2,2,4);
        histogram(abs(result.equalized), 50);
        title('Magnitude Distribution');
        xlabel('Magnitude');
        ylabel('Count');
        grid on;
    end
    
    fprintf('[Stage 4] Test complete: %s\n', result.message);
end
