function rot_data = rot_lut(rot_addr)
% rot_lut - Rotation lookup table (ROM) for cos/sin values
%
% Returns [cos(θ), sin(θ)] for θ in [0, π/4]
% Corresponds to rot_lut ROM in Verilog
%
% INPUTS:
%   rot_addr - Address (0 to 511) representing θ = addr * π/4 / 512
%
% OUTPUTS:
%   rot_data - 32-bit value containing [cos(16-bit), sin(16-bit)]
%              Scaled by 2^11 (ROTATE_LUT_SCALE_SHIFT)
%
% USAGE:
%   data = rot_lut(256); % Returns [cos(π/8), sin(π/8)] * 2048
%   cos_val = bitshift(data, -16); % Upper 16 bits
%   sin_val = bitand(data, 0xFFFF); % Lower 16 bits

ROTATE_LUT_SCALE_SHIFT = 11;
ROTATE_LUT_LEN = 512;

% Validate address
rot_addr = mod(round(rot_addr), ROTATE_LUT_LEN);

% Calculate angle for first octant [0, π/4]
theta = double(rot_addr) * (pi/4) / ROTATE_LUT_LEN;

% Calculate cos and sin
cos_val = cos(theta);
sin_val = sin(theta);

% Scale and round to 16-bit signed
cos_scaled = round(cos_val * (2^ROTATE_LUT_SCALE_SHIFT));
sin_scaled = round(sin_val * (2^ROTATE_LUT_SCALE_SHIFT));

% Convert to 16-bit signed representation
cos_16bit = typecast(int16(cos_scaled), 'uint16');
sin_16bit = typecast(int16(sin_scaled), 'uint16');

% Pack into 32-bit word: [cos(31:16), sin(15:0)]
rot_data = bitor(bitshift(uint32(cos_16bit), 16), uint32(sin_16bit));

end
