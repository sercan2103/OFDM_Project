function deinter_lut = load_deinter_lut()
% LOAD_DEINTER_LUT Load deinterleaver address mapping table
%
% Output:
%   deinter_lut: Address mapping (2048 entries, 22-bit values)
%
% LUT contains deinterleaver address mapping for both legacy and HT modes

    persistent lut_data
    
    % Load only once
    if isempty(lut_data)
        % Get path relative to this file
        script_dir = fileparts(mfilename('fullpath'));
        lut_file = fullfile(script_dir, '../../Data/deinter_lut.txt');
        
        % Load LUT data
        lut_data = uint32(load(lut_file));
        
        fprintf('✓ Loaded DEINTER_LUT: %d entries\n', length(lut_data));
        fprintf('  Value range: [%d, %d]\n', min(lut_data), max(lut_data));
    end
    
    deinter_lut = lut_data;
end
