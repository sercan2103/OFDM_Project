%% equalizer_block.m
% Complete Equalizer Block Test Function
% This tests the complete channel estimation and equalization as ONE block
%
% Simulates complete equalizer pipeline:
%   LTS1 + LTS2 → Calculate CSI → Equalize Data → Output
%
% USAGE:
%   [equalized_data, csi] = equalizer_block(lts1, lts2, data_symbols);

function [equalized_data, csi] = equalizer_block(lts1, lts2, data_symbols)
% equalizer_block - Complete channel estimation and equalization block
%
% INPUTS:
%   lts1         - First Long Training Symbol [64x2] [I, Q]
%   lts2         - Second Long Training Symbol [64x2] [I, Q]
%   data_symbols - Data symbols to equalize [Nx2] [I, Q]
%
% OUTPUTS:
%   equalized_data - Equalized output symbols [Nx2] [I, Q]
%   csi           - Channel State Information [64x2] [I, Q]

    % Add module path
    addpath('../equalizer_modules');
    
    NUM_SUBCARRIERS = 64;
    
    % Initialize equalizer state
    persistent eq_state
    
    if isempty(eq_state)
        % Initialize empty state - equalizer will initialize internally
        eq_state = struct();
    end
    
    fprintf('  [Equalizer Block] Processing LTS and data...\n');
    
    % Combine LTS1 + LTS2 + Data into one stream
    % First 64 samples: LTS1
    % Next 64 samples: LTS2  
    % Remaining: Data symbols
    
    total_samples = 64 + 64 + size(data_symbols, 1);
    all_samples = zeros(total_samples, 2);
    all_samples(1:64, :) = lts1;
    all_samples(65:128, :) = lts2;
    all_samples(129:end, :) = data_symbols;
    
    % Process through equalizer sample by sample
    equalized_data = [];
    
    for idx = 1:total_samples
        % Create sample_in: [I; Q] format (2x1 vector)
        sample_in = [all_samples(idx, 1); all_samples(idx, 2)];
        
        % sample_in_strobe: always 1 (data valid)
        sample_in_strobe = 1;
        
        % ht_next: 0 for Legacy mode
        ht_next = 0;
        
        % Call equalizer
        [sample_out, eq_state] = equalizer(sample_in, sample_in_strobe, ht_next, eq_state);
        
        % Collect equalized outputs (after LTS processing)
        if idx > 128  % After both LTS symbols
            % sample_out is [I; Q] format
            equalized_data(end+1, :) = [sample_out(1), sample_out(2)];
        end
    end
    
    % Extract CSI (dummy - not directly accessible from this interface)
    csi = zeros(NUM_SUBCARRIERS, 2);
    
    fprintf('  [Equalizer Block] Complete: %d symbols processed\n', size(equalized_data, 1));
end
    NUM_SUBCARRIERS = 64;
    
    state = struct();
    state.state = 0;  % IDLE
    state.sample_count = 0;
    state.do_csi = 0;
    state.do_mean = 0;
    state.do_equalize = 0;
    state.do_pilot = 0;
    state.input_i_buf = 0;
    state.input_q_buf = 0;
    state.addr_buf = 0;
    state.rot_addr_buf = 0;
    state.rot_addr_out = 0;
    state.prod_i_buf = 0;
    state.prod_q_buf = 0;
    state.csi_buf_i = 0;
    state.csi_buf_q = 0;
    state.pilot_buf_i = 0;
    state.pilot_buf_q = 0;
    state.csi_i_p1 = 0;
    state.csi_q_p1 = 0;
    state.csi_mag_sq_p1 = 0;
    state.mean_state.pipeline = zeros(3, 1);
    state.ram_lts1_i.ram = zeros(NUM_SUBCARRIERS, 1, 'int32');
    state.ram_lts1_q.ram = zeros(NUM_SUBCARRIERS, 1, 'int32');
    state.ram_lts2_i.ram = zeros(NUM_SUBCARRIERS, 1, 'int32');
    state.ram_lts2_q.ram = zeros(NUM_SUBCARRIERS, 1, 'int32');
    state.ram_csi_i.ram = zeros(NUM_SUBCARRIERS, 1, 'int32');
    state.ram_csi_q.ram = zeros(NUM_SUBCARRIERS, 1, 'int32');
end
