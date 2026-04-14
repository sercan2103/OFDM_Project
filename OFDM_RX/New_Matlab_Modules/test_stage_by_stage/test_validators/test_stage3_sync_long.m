function result = test_stage3_sync_long(samples_i, samples_q, phase_correction, params, expected)
% TEST_STAGE3_SYNC_LONG - Test sync_long module
%
% Tests sync_long.m for fine timing, channel estimation, FFT
%
% Inputs:
%   samples_i, samples_q: Input I/Q samples (int16)
%   phase_correction: Phase from sync_short
%   params: Test parameters
%   expected: Expected outputs (optional)
%
% Outputs:
%   result.pass: Boolean test result
%   result.freq_est: Channel frequency response
%   result.fft_out: FFT output subcarriers
%   result.message: Test message

    result = struct();
    result.pass = false;
    result.message = '';
    
    fprintf('\n=== STAGE 3: Sync Long ===\n');
    
    %% Initialize module
    addpath('../');
    
    % Parameters
    if nargin < 3 || isempty(params)
        params = struct();
    end
    if ~isfield(params, 'num_symbols'), params.num_symbols = 10; end
    
    %% Run sync_long
    num_samples = length(samples_i);
    fprintf('[Stage 3] Processing %d samples\n', num_samples);
    
    % Initialize module state
    enable = true;
    reset = false;
    
    % Storage for outputs
    freq_est_i_vec = [];
    freq_est_q_vec = [];
    freq_est_sample_vec = [];
    fft_out_i_vec = [];
    fft_out_q_vec = [];
    
    % Process samples
    for n = 1:num_samples
        i_val = samples_i(n);
        q_val = samples_q(n);
        
        % Call sync_long with correct signature:
        % [fft_out_i, fft_out_q, sync_long_out, sync_long_out_strobe, sto_out] = 
        %   sync_long(sample_i, sample_q, demod_is_ongoing, short_preamble_detected, ht_mode, short_gi, reset)
        
        demod_is_ongoing = 1;  % Always active during processing
        short_preamble_detected = (n <= 320);  % Trigger only during preamble region
        ht_mode = 0;  % Legacy mode for now
        short_gi = 0;
        
        [fft_out_i, fft_out_q, sync_long_out, sync_long_out_strobe, sto_out] = ...
            sync_long(i_val, q_val, demod_is_ongoing, short_preamble_detected, ht_mode, short_gi, false);
        
        % Store FFT outputs when valid
        if sync_long_out_strobe
            fft_out_i_vec = [fft_out_i_vec; fft_out_i];
            fft_out_q_vec = [fft_out_q_vec; fft_out_q];
            freq_est_i_vec = [freq_est_i_vec; fft_out_i];  % Use FFT as freq estimate
            freq_est_q_vec = [freq_est_q_vec; fft_out_q];
        end
        
        % Exit after capturing enough symbols
        if length(fft_out_i_vec) >= params.num_symbols * 64
            break;
        end
    end
    
    %% Validate result
    result.freq_est = complex(double(freq_est_i_vec), double(freq_est_q_vec));
    result.fft_out = complex(double(fft_out_i_vec), double(fft_out_q_vec));
    
    % Check if channel estimation completed
    if ~isempty(freq_est_i_vec)
        fprintf('[Stage 3] Channel estimation: %d subcarriers\n', length(freq_est_i_vec));
        
        % Validate channel estimates are non-zero
        channel_power = abs(result.freq_est).^2;
        avg_channel_power = mean(channel_power);
        
        if avg_channel_power > 100  % Reasonable channel power
            result.pass = true;
            result.message = sprintf('PASS: Channel estimated, avg power: %.2e', avg_channel_power);
        else
            result.pass = false;
            result.message = sprintf('FAIL: Channel power too low: %.2e', avg_channel_power);
        end
        
        % Check FFT outputs
        if ~isempty(fft_out_i_vec)
            num_fft_outputs = length(fft_out_i_vec);
            fprintf('[Stage 3] FFT outputs: %d samples\n', num_fft_outputs);
            
            % Expected: at least SIGNAL + some DATA symbols
            expected_min_outputs = 64;  % At least 1 OFDM symbol
            if num_fft_outputs >= expected_min_outputs
                fprintf('[Stage 3] Sufficient FFT outputs captured\n');
            else
                result.pass = false;
                result.message = [result.message, sprintf(' | Insufficient FFT outputs: %d (min: %d)', ...
                                num_fft_outputs, expected_min_outputs)];
            end
        else
            result.pass = false;
            result.message = 'FAIL: No FFT outputs';
        end
        
        % Check against expected
        if nargin >= 5 && ~isempty(expected) && isfield(expected, 'freq_est')
            % Compare channel estimates
            if length(result.freq_est) == length(expected.freq_est)
                corr_val = abs(sum(result.freq_est .* conj(expected.freq_est))) / ...
                          sqrt(sum(abs(result.freq_est).^2) * sum(abs(expected.freq_est).^2));
                fprintf('[Stage 3] Channel correlation with expected: %.4f\n', corr_val);
                
                if corr_val > 0.9  % High correlation
                    fprintf('[Stage 3] Good match with expected channel\n');
                else
                    result.pass = false;
                    result.message = [result.message, sprintf(' | Channel mismatch: corr=%.4f', corr_val)];
                end
            end
        end
    else
        result.pass = false;
        result.message = 'FAIL: No channel estimation';
    end
    
    %% Generate diagnostic plot
    if isfield(params, 'plot') && params.plot
        if ~isempty(result.freq_est)
            figure('Name', 'Stage 3: Sync Long');
            
            subplot(2,2,1);
            plot(abs(result.freq_est));
            title('Channel Magnitude');
            xlabel('Subcarrier Index');
            ylabel('Magnitude');
            grid on;
            
            subplot(2,2,2);
            plot(angle(result.freq_est));
            title('Channel Phase');
            xlabel('Subcarrier Index');
            ylabel('Phase (rad)');
            grid on;
            
            subplot(2,2,3);
            plot(real(result.fft_out(1:min(64, end))));
            title('FFT Output (Real, first symbol)');
            xlabel('Sample Index');
            ylabel('Amplitude');
            grid on;
            
            subplot(2,2,4);
            plot(imag(result.fft_out(1:min(64, end))));
            title('FFT Output (Imag, first symbol)');
            xlabel('Sample Index');
            ylabel('Amplitude');
            grid on;
        end
    end
    
    % DEBUG OUTPUT
    fprintf('[DEBUG] fft_out length: %d\n', length(result.fft_out));
    fprintf('[DEBUG] fft_out type: %s\n', class(result.fft_out));
    fprintf('[DEBUG] fft_out size: ');
    disp(size(result.fft_out));
    fprintf('[DEBUG] freq_est length: %d\n', length(result.freq_est));
    
    fprintf('[Stage 3] Test complete: %s\n', result.message);
end
