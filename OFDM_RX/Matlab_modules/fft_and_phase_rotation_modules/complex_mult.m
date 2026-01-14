function [p_i, p_q, state] = complex_mult(a_i, a_q, b_i, b_q, state)
% complex_mult - Complex multiplication with pipeline delay
%
% Implements: (a_i + j*a_q) * (b_i + j*b_q)
% Result: p_i + j*p_q = (a_i*b_i - a_q*b_q) + j*(a_i*b_q + a_q*b_i)
% Corresponds to complex_mult.v (uses complex_multiplier core)
%
% INPUTS:
%   a_i, a_q - Complex input A (16-bit signed I and Q)
%   b_i, b_q - Complex input B (16-bit signed I and Q)
%   state    - Pipeline state structure
%
% OUTPUTS:
%   p_i, p_q - Complex product (32-bit signed I and Q)
%   state    - Updated pipeline state
%
% PIPELINE: 5 clock cycles (4 for multiplier + 1 register)
%
% USAGE:
%   % Initialize
%   state = complex_mult_init();
%   % Process each sample
%   [out_i, out_q, state] = complex_mult(in_a_i, in_a_q, in_b_i, in_b_q, state);

if nargin < 5
    state = struct();
end

if ~isfield(state, 'pipeline')
    state.pipeline = zeros(5, 2); % 5 stages, 2 values (I, Q)
end

% Convert to signed 16-bit
a_i = int32(int16(a_i));
a_q = int32(int16(a_q));
b_i = int32(int16(b_i));
b_q = int32(int16(b_q));

% Complex multiplication
% (a_i + j*a_q) * (b_i + j*b_q) = (a_i*b_i - a_q*b_q) + j*(a_i*b_q + a_q*b_i)
prod_i_new = a_i * b_i - a_q * b_q;
prod_q_new = a_i * b_q + a_q * b_i;

% Update pipeline (shift register)
state.pipeline = [prod_i_new, prod_q_new; state.pipeline(1:end-1, :)];

% Output from end of pipeline
p_i = state.pipeline(end, 1);
p_q = state.pipeline(end, 2);

end

function state = complex_mult_init()
% Initialize complex_mult state
    state = struct();
    state.pipeline = zeros(5, 2);
end
