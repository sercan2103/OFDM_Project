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
    addpath('../part2_equalizer');
    
    NUM_SUBCARRIERS = 64;
    
    % Initialize equalizer state (persistent across calls)
    persistent eq_state initialized
    
    if isempty(initialized)
        eq_state = equalizer_init();
        initialized = true;
    end
    
    % ===== STEP 1: Store LTS1 =====
    fprintf('  [Equalizer Block] Storing LTS1...\n');
    eq_state.state = 1;  % STORE_LTS1
    eq_state.sample_count = 0;
    
    for k = 0:NUM_SUBCARRIERS-1
        [~, ~, ~, eq_state] = equalizer(k, lts1(k+1,1), lts1(k+1,2), ...
                                        0, 0, eq_state);
    end
    
    % ===== STEP 2: Store LTS2 =====
    fprintf('  [Equalizer Block] Storing LTS2...\n');
    eq_state.state = 2;  % STORE_LTS2
    eq_state.sample_count = 0;
    
    for k = 0:NUM_SUBCARRIERS-1
        [~, ~, ~, eq_state] = equalizer(k, lts2(k+1,1), lts2(k+1,2), ...
                                        0, 0, eq_state);
    end
    
    % ===== STEP 3: Calculate CSI (Average LTS1 and LTS2) =====
    fprintf('  [Equalizer Block] Calculating CSI...\n');
    eq_state.state = 3;  % CALC_CSI
    eq_state.sample_count = 0;
    
    for k = 0:NUM_SUBCARRIERS-1
        [~, ~, ~, eq_state] = equalizer(k, 0, 0, 0, 0, eq_state);
    end
    
    % Wait state (if needed)
    eq_state.state = 4;  % WAIT
    for k = 0:NUM_SUBCARRIERS-1
        [~, ~, ~, eq_state] = equalizer(k, 0, 0, 0, 0, eq_state);
    end
    
    % Extract CSI for output
    csi = zeros(NUM_SUBCARRIERS, 2);
    for k = 0:NUM_SUBCARRIERS-1
        csi(k+1, 1) = eq_state.ram_csi_i.ram(k+1);
        csi(k+1, 2) = eq_state.ram_csi_q.ram(k+1);
    end
    
    % ===== STEP 4: Equalize Data Symbols =====
    fprintf('  [Equalizer Block] Equalizing %d data symbols...\n', size(data_symbols, 1));
    eq_state.state = 5;  % EQUALIZE
    eq_state.sample_count = 0;
    
    num_data = size(data_symbols, 1);
    equalized_data = zeros(num_data, 2);
    output_count = 0;
    
    % Stream data through equalizer
    % Need extra cycles for pipeline to flush
    for k = 0:num_data+30-1
        if k < num_data
            rot_addr = mod(k, NUM_SUBCARRIERS);
            in_i = data_symbols(k+1, 1);
            in_q = data_symbols(k+1, 2);
        else
            rot_addr = 0;
            in_i = 0;
            in_q = 0;
        end
        
        [prod_i, prod_q, prod_valid, eq_state] = equalizer(rot_addr, 0, 0, ...
                                                            in_i, in_q, eq_state);
        
        if prod_valid && output_count < num_data
            output_count = output_count + 1;
            equalized_data(output_count, 1) = prod_i;
            equalized_data(output_count, 2) = prod_q;
        end
    end
    
    % Truncate if we got more outputs than expected
    if output_count < num_data
        fprintf('  [Warning] Only received %d of %d outputs\n', output_count, num_data);
        equalized_data = equalized_data(1:output_count, :);
    end
    
    fprintf('  [Equalizer Block] Complete: %d symbols equalized\n', output_count);
end

% Helper initialization function
function state = equalizer_init()
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
