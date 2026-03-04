function [P_i, P_q, output_strobe] = stage_mult(X0, X1, X2, X3, X4, X5, X6, X7, ...
                                                               Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7, ...
                                                               input_strobe, reset)
% STAGE_MULT 4-stage complex correlation
%
% Verilog equivalent: stage_mult.v
% Latency: 6 cycles
%
% Inputs:
%   X0-X7: 4 complex samples from X (16-bit each: X0=I, X1=Q, X2=I, X3=Q, ...)
%   Y0-Y7: 4 complex samples from Y (16-bit each)
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   P_i, P_q: Sum of 4 complex products (32-bit)
%   output_strobe: Output valid signal
%
% Formula:
%   P = sum(X[k] * conj(Y[k])) for k=0:3

    persistent pipeline
    
    if nargin < 19
        reset = 0;
    end
    
    % Initialize pipeline (6 stages)
    if isempty(pipeline) || reset
        pipeline = struct('p_i', zeros(6,1), 'p_q', zeros(6,1), 'valid', zeros(6,1));
    end
    
    % Cycle 0-2: Four complex multiplications
    % X0+jX1, X2+jX3, X4+jX5, X6+jX7
    % Y0+jY1, Y2+jY3, Y4+jY5, Y6+jY7
    
    % Product 0: (X0+jX1) * conj(Y0+jY1) = (X0+jX1) * (Y0-jY1)
    p0_i = int32(X0) * int32(Y0) + int32(X1) * int32(Y1);
    p0_q = int32(X1) * int32(Y0) - int32(X0) * int32(Y1);
    
    % Product 1: (X2+jX3) * conj(Y2+jY3)
    p1_i = int32(X2) * int32(Y2) + int32(X3) * int32(Y3);
    p1_q = int32(X3) * int32(Y2) - int32(X2) * int32(Y3);
    
    % Product 2: (X4+jX5) * conj(Y4+jY5)
    p2_i = int32(X4) * int32(Y4) + int32(X5) * int32(Y5);
    p2_q = int32(X5) * int32(Y4) - int32(X4) * int32(Y5);
    
    % Product 3: (X6+jX7) * conj(Y6+jY7)
    p3_i = int32(X6) * int32(Y6) + int32(X7) * int32(Y7);
    p3_q = int32(X7) * int32(Y6) - int32(X6) * int32(Y7);
    
    % Cycle 3-5: Sum all products
    sum_i = p0_i + p1_i + p2_i + p3_i;
    sum_q = p0_q + p1_q + p2_q + p3_q;
    
    % Pipeline stages
    pipeline.p_i(1) = sum_i;
    pipeline.p_q(1) = sum_q;
    pipeline.valid(1) = input_strobe;
    
    for k = 2:6
        pipeline.p_i(k) = pipeline.p_i(k-1);
        pipeline.p_q(k) = pipeline.p_q(k-1);
        pipeline.valid(k) = pipeline.valid(k-1);
    end
    
    % Output from stage 6
    P_i = pipeline.p_i(6);
    P_q = pipeline.p_q(6);
    output_strobe = pipeline.valid(6);
end
