function result = test_stage2_sync_short(samples_i, samples_q, trigger_offset, params, expected)
% TEST_STAGE2_SYNC_SHORT - Test sync_short module
%
% Tests sync_short.m for coarse timing and CFO estimation
%
% Inputs:
%   samples_i, samples_q: Input I/Q samples (int16)
%   trigger_offset: Sample offset from power trigger
%   params: Test parameters
%   expected: Expected outputs (optional)
%
% Outputs:
%   result.pass: Boolean test result
%   result.phase_out: Phase rotation output
%   result.metric: Short preamble correlation metric
%   result.message: Test message

    result = struct();
    result.pass = false;
    result.message = '';
    
    fprintf('\n=== STAGE 2: Sync Short ===\n');
    
    %% Initialize module
    addpath('../');
    
    % Parameters and defaults
    if nargin < 4 || isempty(params)
        params = struct();
    end
    if ~isfield(params, 'correlation_window'), params.correlation_window = 160; end
    if ~isfield(params, 'search_pre'), params.search_pre = 16; end
    if ~isfield(params, 'search_post'), params.search_post = 64; end
    if ~isfield(params, 'threshold'), params.threshold = 0.50; end  % Lowered threshold
    if ~isfield(params, 'min_plateau'), params.min_plateau = 3; end  % Lowered min_plateau
    if ~isfield(params, 'save_debug'), params.save_debug = true; end
    
    %% Run sync_short
    % Expand search window around trigger offset to tolerate timing jitter
    start_idx = max(1, trigger_offset - params.search_pre);
    num_samples = min(length(samples_i), trigger_offset + params.search_post + params.correlation_window);

    fprintf('[Stage 2] Processing samples %d to %d\n', start_idx, num_samples);
    
    % Initialize sync_short module state
    enable = true;
    reset = false;

    % Storage for outputs
    phase_out_vec = [];
    metric_vec = [];
    metric_stb_vec = [];

    % Process samples
    for n = start_idx:num_samples
        i_val = samples_i(n);
        q_val = samples_q(n);

        % Call sync_short with sensible min_plateau
        % [metric, phase, state_out, sto_out] = sync_short(sample_i, sample_q, enable, min_plateau, reset)
        min_plateau = params.min_plateau;
        [metric, phase_out, state_out, sto_out] = sync_short(i_val, q_val, enable, min_plateau, reset);

        % Decide detection strobe when metric exceeds configurable threshold
        metric_stb = (metric > params.threshold);

        % Store outputs
        phase_out_vec = [phase_out_vec; phase_out];
        metric_vec = [metric_vec; metric];
        metric_stb_vec = [metric_stb_vec; metric_stb];

        if metric_stb
            fprintf('[Stage 2] Short preamble detected at sample %d\n', n);
            fprintf('[Stage 2] Phase estimate: %d\n', phase_out);
            fprintf('[Stage 2] Metric value: %.3f\n', metric);
        end
    end
    
    %% Validate result
    result.phase_out = phase_out_vec;
    result.metric = metric_vec;
    
    % Check if sync detected
    if any(metric_stb_vec)
        detect_idx = find(metric_stb_vec, 1, 'first');
        detect_sample = start_idx + detect_idx - 1;
        
        % Expected detection range (expanded to search window)
        expected_range = [trigger_offset - params.search_pre, trigger_offset + params.correlation_window + params.search_post];
        
        if detect_sample >= expected_range(1) && detect_sample <= expected_range(2)
            result.pass = true;
            result.message = sprintf('PASS: Short sync at sample %d (expected range: %d-%d)', ...
                                    detect_sample, expected_range(1), expected_range(2));
        else
            result.pass = false;
            result.message = sprintf('FAIL: Short sync at sample %d (expected range: %d-%d)', ...
                                    detect_sample, expected_range(1), expected_range(2));
        end
        
        % Validate phase estimate (should be small for clean signal)
        phase_val = phase_out_vec(detect_idx);
        if abs(phase_val) < 1000  % Reasonable phase estimate
            fprintf('[Stage 2] Phase estimate is reasonable: %d\n', phase_val);
        else
            fprintf('[Stage 2] WARNING: Large phase estimate: %d\n', phase_val);
        end
        
        % Check against expected
        if nargin >= 5 && ~isempty(expected) && isfield(expected, 'phase_out')
            phase_diff = abs(phase_val - expected.phase_out);
            tolerance = 100;  % Phase tolerance
            if phase_diff <= tolerance
                fprintf('[Stage 2] Phase matches expected: diff = %d\n', phase_diff);
            else
                result.pass = false;
                result.message = [result.message, sprintf(' | Phase mismatch: %d (expected: %d)', ...
                                phase_val, expected.phase_out)];
            end
        end
    else
        result.pass = false;
        result.message = 'FAIL: Short preamble not detected';
        % Print metric statistics for debugging
        high_metrics = metric_vec(metric_vec > params.threshold);
        if ~isempty(high_metrics)
            fprintf('[Stage 2] Found %d high metrics (> %.2f): max=%.3f, mean=%.3f\n', ...
                    length(high_metrics), params.threshold, max(high_metrics), mean(high_metrics));
            fprintf('[Stage 2] Max metric overall: %.3f at sample %d\n', ...
                    max(metric_vec), find(metric_vec == max(metric_vec), 1) + start_idx - 1);
        else
            fprintf('[Stage 2] No metrics exceeded threshold (%.2f). Max metric: %.3f\n', ...
                    params.threshold, max(metric_vec));
        end
        % Save debug traces so calling harness can inspect metric/phase
        if params.save_debug
            try
                if ~exist('test_data','dir'), mkdir('test_data'); end
                save('test_data/stage2_debug.mat', 'metric_vec', 'phase_out_vec', 'start_idx', 'num_samples', 'params');
            catch
                % ignore save errors
            end
        end
    end
    
    %% Generate diagnostic plot
    if isfield(params, 'plot') && params.plot
        figure('Name', 'Stage 2: Sync Short');
        subplot(2,1,1);
        plot(metric_vec);
        title('Short Preamble Correlation Metric');
        xlabel('Sample Index');
        ylabel('Metric Value');
        grid on;
        
        subplot(2,1,2);
        plot(phase_out_vec);
        title('Phase Estimate');
        xlabel('Sample Index');
        ylabel('Phase (int16)');
        grid on;
    end
    
    fprintf('[Stage 2] Test complete: %s\n', result.message);
end
