function [phase_out, state] = phase(in_i, in_q, state)
% phase - Calculate phase angle of complex number using CORDIC-like algorithm
%
% Calculates phase = atan2(Q, I) for complex input (I + jQ)
% Corresponds to phase.v
%
% INPUTS:
%   in_i  - Real part (I) - 32-bit signed
%   in_q  - Imaginary part (Q) - 32-bit signed
%   state - Pipeline state structure
%
% OUTPUTS:
%   phase_out - Phase angle in range [-π, π]
%               Scaled by 2^9 (ATAN_LUT_SCALE_SHIFT = 512)
%               Range: [-1608, 1608] representing [-π, π]
%   state     - Updated pipeline state
%
% ALGORITHM:
%   1. Calculate abs(I), abs(Q) and determine quadrant
%   2. Map to first octant: ratio = min(abs_i,abs_q)/max(abs_i,abs_q)
%   3. Lookup arctan(ratio) from table
%   4. Adjust for original quadrant
%
% PIPELINE: 40 clock cycles (2 + 36 div + 2 LUT/adjust)
%
% USAGE:
%   % Initialize
%   state = phase_init();
%   % Process each sample
%   [phase_angle, state] = phase(i_sample, q_sample, state);

if nargin < 3
    state = struct();
end

% Initialize state if needed
if ~isfield(state, 'div_state')
    state.div_state = struct();
    state.pipeline = zeros(40, 4); % [quadrant, atan_val, valid, reserved]
end

% Constants
ATAN_LUT_SCALE_SHIFT = 9;
ATAN_LUT_LEN_SHIFT = 8;
PI = round(pi * (2^ATAN_LUT_SCALE_SHIFT));      % 1608
PI_2 = bitshift(PI, -1);                         % 804
% PI_4 = bitshift(PI, -2);                       % 402

% Convert to signed 32-bit
in_i = int32(in_i);
in_q = int32(in_q);

% Stage 1: Calculate absolute values
abs_i = abs(in_i);
abs_q = abs(in_q);

% Stage 2: Determine quadrant and min/max
if abs_i >= abs_q
    quadrant = bitor(bitshift(uint32(in_i < 0), 2), bitshift(uint32(in_q < 0), 1));
    max_val = abs_i;
    min_val = abs_q;
else
    quadrant = bitor(bitor(bitshift(uint32(in_i < 0), 2), bitshift(uint32(in_q < 0), 1)), 1);
    max_val = abs_q;
    min_val = abs_i;
end

% Stage 3-38: Division (36 cycles)
if max_val == 0
    quotient = 0;
    state.div_state = struct();
else
    % Divide min by (max >> ATAN_LUT_LEN_SHIFT) to get ratio in [0, 255]
    divisor = bitshift(max_val, -ATAN_LUT_LEN_SHIFT);
    if divisor == 0
        divisor = 1;
    end
    [quotient, state.div_state] = divider(min_val, divisor, state.div_state);
end

% Stage 39: ATAN Lookup
atan_addr = bitand(uint32(quotient), 2^ATAN_LUT_LEN_SHIFT - 1);
atan_val = atan_lut(atan_addr);

% Pipeline: [quadrant(39 cycles ago), atan_val, valid, 0]
state.pipeline = [double(quadrant), double(atan_val), 1, 0; state.pipeline(1:end-1, :)];

% Stage 40: Quadrant adjustment (from pipeline)
quad_delayed = state.pipeline(end, 1);
atan_delayed = state.pipeline(end, 2);

switch quad_delayed
    case 0 % 3'b000: [0, π/4]
        phase_out = atan_delayed;
    case 1 % 3'b001: [π/4, π/2]
        phase_out = PI_2 - atan_delayed;
    case 2 % 3'b010: [-π/4, 0]
        phase_out = -atan_delayed;
    case 3 % 3'b011: [-π/2, -π/4]
        phase_out = atan_delayed - PI_2;
    case 4 % 3'b100: [3π/4, π]
        phase_out = PI - atan_delayed;
    case 5 % 3'b101: [π/2, 3π/4]
        phase_out = PI_2 + atan_delayed;
    case 6 % 3'b110: [-π, -3π/4]
        phase_out = atan_delayed - PI;
    case 7 % 3'b111: [-3π/4, -π/2]
        phase_out = -PI_2 - atan_delayed;
    otherwise
        phase_out = 0;
end

% Convert to signed output
phase_out = int32(phase_out);

end

function state = phase_init()
% Initialize phase module state
    state = struct();
    state.div_state = struct();
    state.div_state.pipeline = zeros(36, 1);
    state.pipeline = zeros(40, 4);
end
