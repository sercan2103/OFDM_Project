function [p_i, p_q, output_strobe] = complex_mult(a_i, a_q, b_i, b_q, input_strobe, reset)
% COMPLEX_MULT Complex multiplication (a_i + j*a_q) * (b_i + j*b_q)
%
% Verilog equivalent: complex_mult.v (Xilinx IP wrapper)
% Latency: 5 cycles
%
% Inputs:
%   a_i, a_q: First complex number (16-bit signed, Q0.15)
%   b_i, b_q: Second complex number (16-bit signed, Q0.15)
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   p_i, p_q: Product (32-bit signed, Q16.15)
%   output_strobe: Output valid signal
%
% Formula:
%   p_i = a_i*b_i - a_q*b_q
%   p_q = a_i*b_q + a_q*b_i

    persistent pipeline
    
    if nargin < 6
        reset = 0;
    end
    
    % Initialize pipeline (5 stages to match Xilinx IP)
    if isempty(pipeline) || reset
        pipeline = struct('data_i', zeros(5,1), 'data_q', zeros(5,1), 'valid', zeros(5,1));
    end
    
    % Cycle 0: Complex multiply
    % Cast to int32 for full precision
    a_i_32 = int32(a_i);
    a_q_32 = int32(a_q);
    b_i_32 = int32(b_i);
    b_q_32 = int32(b_q);
    
    % Real part: a_i*b_i - a_q*b_q
    p_i_calc = a_i_32 * b_i_32 - a_q_32 * b_q_32;
    
    % Imaginary part: a_i*b_q + a_q*b_i
    p_q_calc = a_i_32 * b_q_32 + a_q_32 * b_i_32;
    
    % Pipeline stages (5 stages to match Xilinx complex_multiplier IP)
    pipeline.data_i(1) = p_i_calc;
    pipeline.data_q(1) = p_q_calc;
    pipeline.valid(1) = input_strobe;
    
    for k = 2:5
        pipeline.data_i(k) = pipeline.data_i(k-1);
        pipeline.data_q(k) = pipeline.data_q(k-1);
        pipeline.valid(k) = pipeline.valid(k-1);
    end
    
    % Output from stage 5
    p_i = pipeline.data_i(5);
    p_q = pipeline.data_q(5);
    output_strobe = pipeline.valid(5);
end
