function atan_data = atan_lut(atan_addr)
% atan_lut - Arctangent lookup table (ROM)
%
% Returns arctan(x) for x in [0, 1], mapped to first octant [0, π/4]
% Corresponds to atan_lut ROM in Verilog
%
% INPUTS:
%   atan_addr - Address (0 to 255) representing x = addr/256
%
% OUTPUTS:
%   atan_data - Arctan value scaled by 2^9 (ATAN_LUT_SCALE_SHIFT)
%               Range: [0, π/4 * 512] = [0, 402]
%
% USAGE:
%   phase = atan_lut(128); % Returns atan(0.5) * 512

ATAN_LUT_SCALE_SHIFT = 9;

% Validate address
atan_addr = mod(round(atan_addr), 256);

% Calculate arctan for normalized input [0, 1]
x = double(atan_addr) / 256.0;
atan_val = atan(x);

% Scale and round to match Verilog LUT
atan_data = round(atan_val * (2^ATAN_LUT_SCALE_SHIFT));

% Clip to output range [0, 402]
atan_data = max(0, min(402, atan_data));

end
