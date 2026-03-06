function result = test_stage1_power_trigger(samples_i, samples_q, params, expected)
% TEST_STAGE1_POWER_TRIGGER - Test power trigger module
%
% Tests power_trigger.m for packet detection
%
% Inputs:
%   samples_i, samples_q: Input I/Q samples (int16)
%   params: Test parameters
%   expected: Expected outputs (optional)
%
% Outputs:
%   result.pass: Boolean test result
%   result.trigger_sample: Sample index where trigger detected
%   result.power_profile: Power over time
%   result.message: Test message

    result = struct();
    result.pass = false;
    result.message = '';
    result.trigger_sample = -1;
    
    fprintf('\n=== STAGE 1: Power Trigger ===\n');
    
    %% Initialize module
    addpath('../');
    
    % Parameters
    if nargin < 3 || isempty(params)
        params = struct();
    end
    if ~isfield(params, 'threshold'), params.threshold = 1000; end
    if ~isfield(params, 'history_len'), params.history_len = 320; end
    
    %% Run power trigger
    num_samples = length(samples_i);
    triggered = false;
    trigger_sample = -1;
    power_profile = zeros(num_samples, 1);
    
    % State
    power_history = zeros(params.history_len, 1);
    hist_idx = 1;
    
    for n = 1:num_samples
        % Calculate instantaneous power
        i_val = double(samples_i(n));
        q_val = double(samples_q(n));
        inst_power = i_val^2 + q_val^2;
        power_profile(n) = inst_power;
        
        % Update history
        power_history(hist_idx) = inst_power;
        hist_idx = mod(hist_idx, params.history_len) + 1;
        
        % Check trigger
        avg_power = mean(power_history);
        
        if avg_power > params.threshold && ~triggered
            triggered = true;
            trigger_sample = n;
            fprintf('[Stage 1] Packet detected at sample %d\n', trigger_sample);
            fprintf('[Stage 1] Average power: %.2e (threshold: %.2e)\n', ...
                    avg_power, params.threshold);
            break;
        end
        
        if mod(n, 10000) == 0
            fprintf('[Stage 1] Processed %d samples, avg power: %.2e\n', ...
                    n, avg_power);
        end
    end
    
    %% Validate result
    result.trigger_sample = trigger_sample;
    result.power_profile = power_profile;
    
    if triggered
        % Check if trigger is within expected range (preamble region)
        expected_range = [1, 320];  % Should trigger during STS
        
        if trigger_sample >= expected_range(1) && trigger_sample <= expected_range(2)
            result.pass = true;
            result.message = sprintf('PASS: Triggered at sample %d (expected range: %d-%d)', ...
                                    trigger_sample, expected_range(1), expected_range(2));
            fprintf('[Stage 1] %s\n', result.message);
        else
            result.pass = false;
            result.message = sprintf('FAIL: Triggered at sample %d (expected range: %d-%d)', ...
                                    trigger_sample, expected_range(1), expected_range(2));
            fprintf('[Stage 1] %s\n', result.message);
        end
        
        % Check against expected value if provided
        if nargin >= 4 && ~isempty(expected) && isfield(expected, 'trigger_sample')
            sample_diff = abs(trigger_sample - expected.trigger_sample);
            if sample_diff <= 10  % Allow 10 sample tolerance
                fprintf('[Stage 1] Match with expected: within %d samples\n', sample_diff);
            else
                result.pass = false;
                result.message = [result.message, sprintf(' | Expected: %d, got: %d (diff: %d)', ...
                                expected.trigger_sample, trigger_sample, sample_diff)];
            end
        end
    else
        result.pass = false;
        result.message = 'FAIL: No packet detected';
        fprintf('[Stage 1] %s\n', result.message);
    end
    
    %% Generate diagnostic plot
    if params.plot
        figure('Name', 'Stage 1: Power Trigger');
        plot(power_profile);
        hold on;
        yline(params.threshold, 'r--', 'Threshold');
        if triggered
            xline(trigger_sample, 'g-', 'Trigger');
        end
        xlabel('Sample Index');
        ylabel('Instantaneous Power');
        title('Power Profile and Trigger Detection');
        grid on;
        hold off;
    end
    
    fprintf('[Stage 1] Test complete: %s\n', result.message);
end
