function [out_i, out_q, state] = rotate(in_i, in_q, phase_in, state)
% rotate - Rotate complex sample by given phase angle
%
% Implements complex rotation: out = in * e^(j*phase)
% Corresponds to rotate.v
%
% INPUTS:
%   in_i     - Real part of input (16-bit signed)
%   in_q     - Imaginary part of input (16-bit signed)
%   phase_in - Rotation angle in range [-π, π]
%              Scaled by 2^9 = 512, so range is [-1608, 1608]
%   state    - Pipeline state structure
%
% OUTPUTS:
%   out_i - Real part of output (16-bit signed)
%   out_q - Imaginary part of output (16-bit signed)
%   state - Updated pipeline state
%
% ALGORITHM:
%   1. Map phase to first octant [0, π/4]
%   2. Lookup [cos, sin] from ROM
%   3. Reconstruct for original quadrant using symmetry
%   4. Complex multiply: out = in * (cos + j*sin)
%
% PIPELINE: 8 clock cycles (4 for phase mapping + 4 for multiplication)
%
% USAGE:
%   % Initialize
%   state = rotate_init();
%   % Process each sample
%   [out_i, out_q, state] = rotate(in_i, in_q, phase_angle, state);

if nargin < 4
    state = struct();
end

% Initialize state
if ~isfield(state, 'mult_state')
    state.mult_state = complex_mult_init();
    state.in_delay = zeros(4, 2);     % Delay I,Q by 4 cycles
    state.phase_pipeline = zeros(4, 3); % [quadrant, actual_phase, phase_abs]
end

% Constants
ATAN_LUT_SCALE_SHIFT = 9;
ROTATE_LUT_SCALE_SHIFT = 11;
PI = round(pi * (2^ATAN_LUT_SCALE_SHIFT));
PI_2 = bitshift(PI, -1);
PI_4 = bitshift(PI, -2);
PI_3_4 = PI_2 + PI_4;

% Convert inputs
in_i = int16(in_i);
in_q = int16(in_q);
phase_in = int32(phase_in);

% Cycle 1: Phase absolute value
phase_abs = abs(phase_in);
phase_sign = (phase_in < 0);

% Cycle 2: Map to first octant and determine quadrant
if phase_abs <= PI_4
    quadrant = bitor(bitshift(uint32(phase_sign), 2), 0);
    actual_phase = phase_abs;
elseif phase_abs <= PI_2
    quadrant = bitor(bitshift(uint32(phase_sign), 2), 1);
    actual_phase = PI_2 - phase_abs;
elseif phase_abs <= PI_3_4
    quadrant = bitor(bitshift(uint32(phase_sign), 2), 2);
    actual_phase = phase_abs - PI_2;
else
    quadrant = bitor(bitshift(uint32(phase_sign), 2), 3);
    actual_phase = PI - phase_abs;
end

% Pipeline phase information
state.phase_pipeline = [double(quadrant), double(actual_phase), double(phase_abs); ...
                        state.phase_pipeline(1:end-1, :)];

% Cycle 3: ROM lookup with delayed phase
rot_addr = bitand(uint32(state.phase_pipeline(end, 2)), 2^ATAN_LUT_SCALE_SHIFT - 1);
rot_data = rot_lut(rot_addr);
raw_rot_i = int16(bitshift(int32(rot_data), -16));
raw_rot_q = int16(bitand(uint32(rot_data), uint32(0xFFFF)));

% Cycle 4: Reconstruct from quadrant (using oldest pipeline value)
quadrant_delayed = state.phase_pipeline(end, 1);

switch quadrant_delayed
    case 0 % 3'b000
        rot_i = raw_rot_i;
        rot_q = raw_rot_q;
    case 1 % 3'b001
        rot_i = raw_rot_q;
        rot_q = raw_rot_i;
    case 2 % 3'b010
        rot_i = -raw_rot_q;
        rot_q = raw_rot_i;
    case 3 % 3'b011
        rot_i = -raw_rot_i;
        rot_q = raw_rot_q;
    case 4 % 3'b100
        rot_i = raw_rot_i;
        rot_q = -raw_rot_q;
    case 5 % 3'b101
        rot_i = raw_rot_q;
        rot_q = -raw_rot_i;
    case 6 % 3'b110
        rot_i = -raw_rot_q;
        rot_q = -raw_rot_i;
    case 7 % 3'b111
        rot_i = -raw_rot_i;
        rot_q = -raw_rot_q;
    otherwise
        rot_i = raw_rot_i;
        rot_q = raw_rot_q;
end

% Input delay (4 cycles)
state.in_delay = [double(in_i), double(in_q); state.in_delay(1:end-1, :)];
in_i_delayed = int16(state.in_delay(end, 1));
in_q_delayed = int16(state.in_delay(end, 2));

% Cycle 5-8: Complex multiplication
[p_i, p_q, state.mult_state] = complex_mult(in_i_delayed, in_q_delayed, ...
                                             int16(rot_i), int16(rot_q), ...
                                             state.mult_state);

% Scale down by ROTATE_LUT_SCALE_SHIFT (divide by 2^11)
out_i = int16(bitshift(int32(p_i), -ROTATE_LUT_SCALE_SHIFT));
out_q = int16(bitshift(int32(p_q), -ROTATE_LUT_SCALE_SHIFT));

end

function state = rotate_init()
% Initialize rotate module state
    state = struct();
    state.mult_state = struct();
    state.mult_state.pipeline = zeros(5, 2);
    state.in_delay = zeros(4, 2);
    state.phase_pipeline = zeros(4, 3);
end

function state = complex_mult_init()
% Initialize complex_mult state
    state = struct();
    state.pipeline = zeros(5, 2);
end
