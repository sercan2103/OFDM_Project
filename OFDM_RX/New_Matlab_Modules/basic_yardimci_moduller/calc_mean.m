function [mean_out, output_strobe] = calc_mean(data_in, input_strobe, num_samples, reset)
% CALC_MEAN Calculate mean of multiple inputs
%
% Verilog equivalent: calc_mean.v
% Latency: Variable (depends on num_samples + division)
%
% Inputs:
%   data_in: Input data (32-bit)
%   input_strobe: Valid signal
%   num_samples: Number of samples to average
%   reset: Reset signal (optional)
%
% Outputs:
%   mean_out: Mean value (32-bit)
%   output_strobe: Output valid signal

    persistent accumulator count div_pipeline
    
    if nargin < 4
        reset = 0;
    end
    
    % Initialize
    if isempty(accumulator) || reset
        accumulator = 0;
        count = 0;
        div_pipeline = struct('data', zeros(36,1), 'valid', zeros(36,1));
    end
    
    % Default outputs
    mean_out = 0;
    output_strobe = 0;
    
    if input_strobe
        % Accumulate
        accumulator = accumulator + data_in;
        count = count + 1;
        
        % When we have all samples, compute mean
        if count >= num_samples
            % Division with 36-cycle pipeline
            if num_samples ~= 0
                mean_calc = int32(floor(double(accumulator) / double(num_samples)));
            else
                mean_calc = 0;
            end
            
            % Pipeline the division
            div_pipeline.data(1) = mean_calc;
            div_pipeline.valid(1) = 1;
            
            % Reset for next batch
            accumulator = 0;
            count = 0;
        end
    end
    
    % Pipeline stages (36 stages to match divider)
    for k = 2:36
        div_pipeline.data(k) = div_pipeline.data(k-1);
        div_pipeline.valid(k) = div_pipeline.valid(k-1);
    end
    
    % Output from pipeline
    mean_out = div_pipeline.data(36);
    output_strobe = div_pipeline.valid(36);
end
