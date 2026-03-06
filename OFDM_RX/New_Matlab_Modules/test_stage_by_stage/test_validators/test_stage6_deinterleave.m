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
    enable = true;
    reset = false;
    
    deinterleaved_vec = [];
    deint_out_strobe_vec = [];
    
    % Process soft bits
    for n = 1:num_bits
        bit_val = soft_bits(n);
        bit_strobe = true;
        
        % Call deinterleave (placeholder)
        [deint_bit, deint_strobe, ~] = ...
            deinterleave(bit_val, rate, bit_strobe, enable, reset);
        
        % Store outputs
        if deint_strobe
            deinterleaved_vec = [deinterleaved_vec; deint_bit];
            deint_out_strobe_vec = [deint_out_strobe_vec; true];
        end
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
        
        % Validate soft bit range preserved
        max_deint = max(abs(deinterleaved_vec));
        max_input = max(abs(soft_bits));
        fprintf('[Stage 6] Max magnitude: input=%d, output=%d\n', max_input, max_deint);
        
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
