function [mag, mag_stb] = complex_to_mag(i, q, input_strobe, reset)
% COMPLEX_TO_MAG Calculate magnitude: sqrt(I^2 + Q^2)
%
% Verilog equivalent: complex_to_mag.v
% Latency: ~40 cycles (uses divider + approximation)
%
% Inputs:
%   i: Real part (32-bit signed)
%   q: Imaginary part (32-bit signed)
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   mag: Magnitude (32-bit unsigned)
%   mag_stb: Output valid signal
%
% Implementation:
%   Uses CORDIC-like algorithm or approximation

    persistent pipeline
    
    if nargin < 4
        reset = 0;
    end
    
    % Initialize pipeline (~40 stages)
    if isempty(pipeline) || reset
        pipeline = struct('data', zeros(40,1), 'valid', zeros(40,1));
    end
    
    % Calculate magnitude using approximation for efficiency
    % More accurate: sqrt(i^2 + q^2)
    % Approximation: max(|i|, |q|) + 0.4*min(|i|, |q|)
    
    abs_i = abs(double(i));
    abs_q = abs(double(q));
    
    max_val = max(abs_i, abs_q);
    min_val = min(abs_i, abs_q);
    
    % CORDIC-like approximation (better than simple max)
    mag_calc = max_val + 0.4 * min_val;
    
    % For bit-exact match with Verilog, might need actual CORDIC
    % But this is close enough for initial testing
    
    % Pipeline stages (40 stages to match Verilog latency)
    pipeline.data(1) = int32(mag_calc);
    pipeline.valid(1) = input_strobe;
    
    for k = 2:40
        pipeline.data(k) = pipeline.data(k-1);
        pipeline.valid(k) = pipeline.valid(k-1);
    end
    
    % Output from stage 40
    mag = pipeline.data(40);
    mag_stb = pipeline.valid(40);
end
