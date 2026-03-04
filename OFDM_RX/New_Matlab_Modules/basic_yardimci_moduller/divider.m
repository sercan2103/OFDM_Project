function [quotient, output_strobe] = divider(dividend, divisor, input_strobe, reset)
% DIVIDER Fixed-point division
%
% Verilog equivalent: divider.v (Xilinx div_gen_v3_0 IP wrapper)
% Latency: 36 cycles
%
% Inputs:
%   dividend: 32-bit numerator
%   divisor: 32-bit denominator
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   quotient: 32-bit result
%   output_strobe: Output valid signal

    persistent pipeline
    
    if nargin < 4
        reset = 0;
    end
    
    % Initialize pipeline (36 stages to match Xilinx IP)
    if isempty(pipeline) || reset
        pipeline = struct('data', zeros(36,1), 'valid', zeros(36,1));
    end
    
    % Cycle 0: Division
    if divisor ~= 0
        quot_calc = int32(floor(double(dividend) / double(divisor)));
    else
        quot_calc = 0; % Handle division by zero
    end
    
    % Pipeline stages (36 stages to match Xilinx divider)
    pipeline.data(1) = quot_calc;
    pipeline.valid(1) = input_strobe;
    
    for k = 2:36
        pipeline.data(k) = pipeline.data(k-1);
        pipeline.valid(k) = pipeline.valid(k-1);
    end
    
    % Output from stage 36
    quotient = pipeline.data(36);
    output_strobe = pipeline.valid(36);
end
