function atan_lut = load_atan_lut()
% LOAD_ATAN_LUT Load arctangent lookup table
%
% Output:
%   atan_lut: Arctan values (256 entries, units of π/512)
%
% LUT contains arctan(x) for x in [0, 1]
% Scaled by 512 (represents angle in units of π/512)
% Address mapping: x = address / 256

    persistent lut_data
    
    % Load only once
    if isempty(lut_data)
        % Get path relative to this file
        script_dir = fileparts(mfilename('fullpath'));
        lut_file = fullfile(script_dir, '../../Data/atan_lut.txt');
        
        % Load LUT data
        lut_data = int16(load(lut_file));
        
        fprintf('✓ Loaded ATAN_LUT: %d entries\n', length(lut_data));
        fprintf('  Value range: [%d, %d]\n', min(lut_data), max(lut_data));
        fprintf('  Angle range: [0, %.4f] radians (π/4 = %.4f)\n', ...
                double(max(lut_data)) * pi / 512, pi/4);
    end
    
    atan_lut = lut_data;
end
