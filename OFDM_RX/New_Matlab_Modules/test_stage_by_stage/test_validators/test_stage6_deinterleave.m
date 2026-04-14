function result = test_stage6_deinterleave(soft_bits, rate, params, expected)
% TEST_STAGE6_DEINTERLEAVE - Test deinterleave module
%
% Tests deinterleave.m for frequency-domain deinterleaving
%
% Inputs:
%   soft_bits: Soft decision bits from demodulator
%   rate: Data rate (for interleaver pattern)
%   params: Test parameters
%   expected: Expected outputs (optional)
%
% Outputs:
%   result.pass: Boolean test result
%   result.deinterleaved: Deinterleaved bits
%   result.message: Test message

    result = struct();
    result.pass = false;
    result.message = '';
    
    fprintf('\n=== STAGE 6: Deinterleave ===\n');
    
    %% Initialize module
    addpath('../');
    
    %% Run deinterleave
    num_bits = length(soft_bits);
    fprintf('[Stage 6] Processing %d soft bits\n', num_bits);
    fprintf('[Stage 6] Rate: %d\n', rate);
    
    % Initialize module state
    reset = true;  % Reset on first call
    
    deinterleaved_vec = [];
    deint_out_strobe_vec = [];
    
    % Process soft bits
    for n = 1:num_bits
        bit_val = soft_bits(n);
        input_strobe = true;
        
        % Call deinterleave with correct signature
        [deint_bit, erase, output_strobe] = ...
            deinterleave(bit_val, rate, input_strobe, reset);
        
        % Store outputs
        if output_strobe
            deinterleaved_vec = [deinterleaved_vec; deint_bit];
            deint_out_strobe_vec = [deint_out_strobe_vec; true];
        end
        
        reset = false;  % Only reset on first call
    end
    
    %% Validate result
    result.deinterleaved = deinterleaved_vec;
    
    % Check if deinterleaving produced outputs
    if ~isempty(deinterleaved_vec)
        num_deint = length(deinterleaved_vec);
        fprintf('[Stage 6] Deinterleaved bits: %d\n', num_deint);
        
        % Validate output count matches input count
        if num_deint == num_bits
            result.pass = true;
            result.message = sprintf('PASS: Deinterleaved %d bits', num_deint);
            fprintf('[Stage 6] Bit count preserved: %d in, %d out\n', num_bits, num_deint);
        else
            result.pass = false;
            result.message = sprintf('FAIL: Bit count mismatch: %d in, %d out', ...
                                    num_bits, num_deint);
        end
        
        % Validate soft bit range preserved (0-7)
        max_deint = max(deinterleaved_vec(:));
        min_deint = min(deinterleaved_vec(:));
        max_input = max(soft_bits);
        min_input = min(soft_bits);
        fprintf('[Stage 6] Soft bit range: input=[%d, %d], output=[%.2f, %.2f]\n', ...
                min_input, max_input, min_deint, max_deint);
        
        % Soft bits should be in 0-7 range (not hardened to 0-1)
        if max_deint <= 7 && min_deint >= 0
            fprintf('[Stage 6] Soft bits preserved correctly (0-7 range)\n');
        else
            result.pass = false;
            fprintf('[Stage 6] WARNING: Soft bits corrupted (out of 0-7 range)\n');
            result.message = [result.message, ' | Soft bits out of range'];
        end
        
        % Check against expected
        if nargin >= 4 && ~isempty(expected) && isfield(expected, 'deinterleaved')
            % Compare deinterleaved bits
            if length(result.deinterleaved) == length(expected.deinterleaved)
                % Correlation check
                corr_val = corr(double(result.deinterleaved), double(expected.deinterleaved));
                fprintf('[Stage 6] Correlation with expected: %.6f\n', corr_val);
                
                if abs(corr_val) > 0.95  % High correlation
                    fprintf('[Stage 6] Good match with expected\n');
                else
                    result.pass = false;
                    result.message = [result.message, sprintf(' | Low correlation: %.6f', corr_val)];
                end
            end
        end
    else
        result.pass = false;
        result.message = 'FAIL: No deinterleaved bits';
    end
    
    %% Generate diagnostic plot
    if isfield(params, 'plot') && params.plot && ~isempty(result.deinterleaved)
        figure('Name', 'Stage 6: Deinterleave');
        
        subplot(2,2,1);
        plot(soft_bits);
        title('Input Soft Bits');
        xlabel('Bit Index');
        ylabel('Soft Value');
        grid on;
        
        subplot(2,2,2);
        plot(result.deinterleaved);
        title('Deinterleaved Soft Bits');
        xlabel('Bit Index');
        ylabel('Soft Value');
        grid on;
        
        subplot(2,2,3);
        plot(soft_bits - result.deinterleaved);
        title('Difference (Input - Output)');
        xlabel('Bit Index');
        ylabel('Difference');
        grid on;
        
        subplot(2,2,4);
        scatter(1:length(soft_bits), soft_bits, 'b', 'DisplayName', 'Input');
        hold on;
        scatter(1:length(result.deinterleaved), result.deinterleaved, 'r.', 'DisplayName', 'Output');
        title('Bit Reordering');
        xlabel('Index');
        ylabel('Soft Value');
        legend;
        grid on;
        hold off;
    end
    
    fprintf('[Stage 6] Test complete: %s\n', result.message);
end
