function [rot_cos, rot_sin] = load_rot_lut()
% LOAD_ROT_LUT Load rotation lookup table
%
% Outputs:
%   rot_cos: Cosine values (512 entries, Q0.11 format, scaled by 2048)
%   rot_sin: Sine values (512 entries, Q0.11 format, scaled by 2048)
%
% LUT contains cos/sin values for angles [0, π/4]
% Address mapping: angle = (address / 512) * (π/4)

    persistent lut_cos lut_sin
    
    % Load only once
    if isempty(lut_cos)
        % Get path relative to this file
        script_dir = fileparts(mfilename('fullpath'));
        lut_file = fullfile(script_dir, '../../Data/rot_lut.txt');
        
        % Load LUT data
        lut_data = load(lut_file);
        
        % Split into cos and sin
        lut_cos = int16(lut_data(:, 1));
        lut_sin = int16(lut_data(:, 2));
        
        fprintf('✓ Loaded ROT_LUT: %d entries\n', length(lut_cos));
        fprintf('  Cos range: [%d, %d]\n', min(lut_cos), max(lut_cos));
        fprintf('  Sin range: [%d, %d]\n', min(lut_sin), max(lut_sin));
    end
    
    rot_cos = lut_cos;
    rot_sin = lut_sin;
end
