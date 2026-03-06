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
    
    % Initialize module state
    enable = true;
    reset = false;
    equalizer_out_i_vec = [];
    equalizer_out_q_vec = [];
    equalizer_out_strobe_vec = [];
    
    % Process FFT outputs
    for n = 1:num_samples
        i_val = fft_i(n);
        q_val = fft_q(n);
        sample_in_strobe = true;
        
        % Call equalizer (placeholder)
        [eq_i, eq_q, eq_strobe, sig_info, ~] = ...
            equalizer(i_val, q_val, channel_est, sample_in_strobe, enable, reset, params);
        
        % Store outputs
        if eq_strobe
            equalizer_out_i_vec = [equalizer_out_i_vec; eq_i];
            equalizer_out_q_vec = [equalizer_out_q_vec; eq_q];
            equalizer_out_strobe_vec = [equalizer_out_strobe_vec; true];
        end
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
        
        % Reasonable constellation power
        if avg_mag > 10 && avg_mag < 10000
            result.pass = true;
            result.message = sprintf('PASS: Equalized %d symbols, avg mag=%.2f', ...
                                    num_equalized, avg_mag);
        else
            result.pass = false;
            result.message = sprintf('FAIL: Unusual symbol magnitude: %.2f', avg_mag);
        end
        
        % Check SIGNAL field decoding
        if exist('sig_info', 'var') && ~isempty(sig_info)
            result.signal_info = sig_info;
            fprintf('[Stage 4] SIGNAL decoded: rate=%d, length=%d\n', ...
                    sig_info.rate, sig_info.length);
            
            % Validate SIGNAL fields
            if sig_info.rate >= 1 && sig_info.rate <= 15  % Valid rate codes
                fprintf('[Stage 4] Valid SIGNAL rate field\n');
            else
                result.pass = false;
                result.message = [result.message, sprintf(' | Invalid SIGNAL rate: %d', sig_info.rate)];
            end
        else
            fprintf('[Stage 4] WARNING: SIGNAL field not decoded\n');
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
