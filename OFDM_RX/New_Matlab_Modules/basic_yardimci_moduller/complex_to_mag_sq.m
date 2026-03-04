function [mag_sq, mag_sq_strobe] = complex_to_mag_sq(i, q, input_strobe, reset)
% COMPLEX_TO_MAG_SQ Calculate magnitude squared: I^2 + Q^2
%
% Verilog equivalent: complex_to_mag_sq.v
% Latency: 2 cycles
%
% Inputs:
%   i: Real part (16-bit signed, Q0.15)
%   q: Imaginary part (16-bit signed, Q0.15)
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   mag_sq: Magnitude squared (32-bit unsigned)
%   mag_sq_strobe: Output valid signal
%
% Fixed-point format:
%   Input: Q0.15 (16-bit signed)
%   Output: 32-bit (after multiply and add)

    persistent pipeline
    
    if nargin < 4
        reset = 0;
    end
    
    % Initialize pipeline
    if isempty(pipeline) || reset
        pipeline = struct('data', zeros(2,1), 'valid', zeros(2,1));
    end
    
    % Cycle 0: Multiply
    % i and q are Q0.15 format
    % After multiply: need to handle overflow
    i_sq = int32(i) * int32(i);
    q_sq = int32(q) * int32(q);
    mag_sq_calc = i_sq + q_sq;
    
    % Ensure non-negative (magnitude squared)
    if mag_sq_calc < 0
        mag_sq_calc = 0;
    end
    
    % Pipeline stage 0
    pipeline.data(1) = mag_sq_calc;
    pipeline.valid(1) = input_strobe;
    
    % Pipeline stage 1
    pipeline.data(2) = pipeline.data(1);
    pipeline.valid(2) = pipeline.valid(1);
    
    % Output from stage 2
    mag_sq = pipeline.data(2);
    mag_sq_strobe = pipeline.valid(2);
end
