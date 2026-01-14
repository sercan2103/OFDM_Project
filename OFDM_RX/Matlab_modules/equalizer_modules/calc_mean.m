function [c, state] = calc_mean(a, b, sign, state)
% calc_mean - Calculate signed mean of two values
%
% Computes: c = sign ? -(a/2 + b/2) : (a/2 + b/2)
% Used in equalizer for averaging two LTS symbols
% Corresponds to calc_mean.v
%
% INPUTS:
%   a     - First input (16-bit signed)
%   b     - Second input (16-bit signed)
%   sign  - Sign flag (1 = negate result, 0 = keep positive)
%   state - Pipeline state structure
%
% OUTPUTS:
%   c     - Mean value (16-bit signed)
%   state - Updated pipeline state
%
% PIPELINE: 3 clock cycles
%
% USAGE:
%   % Initialize
%   state = calc_mean_init();
%   % Process each sample
%   [mean_val, state] = calc_mean(val_a, val_b, sign_flag, state);

if nargin < 4
    state = struct();
end

% Initialize state
if ~isfield(state, 'pipeline')
    state.pipeline = zeros(3, 3); % [aa, bb, sign_delayed]
end

% Convert to signed 16-bit
a = int16(a);
b = int16(b);

% Stage 1: Arithmetic right shift by 1 (divide by 2)
aa = bitshift(int32(a), -1);
bb = bitshift(int32(b), -1);

% Stage 2: Add
cc = aa + bb;

% Stage 3: Apply sign
c_final = sign * (-cc) + (1-sign) * cc;

% Pipeline: store intermediate values with sign
state.pipeline = [double(aa), double(bb), double(sign); state.pipeline(1:end-1, :)];

% Calculate output from delayed values
aa_delayed = state.pipeline(end, 1);
bb_delayed = state.pipeline(end, 2);
sign_delayed = state.pipeline(end, 3);

cc_delayed = aa_delayed + bb_delayed;
if sign_delayed
    c = int16(-cc_delayed);
else
    c = int16(cc_delayed);
end

end

function state = calc_mean_init()
% Initialize calc_mean state
    state = struct();
    state.pipeline = zeros(3, 3);
end
