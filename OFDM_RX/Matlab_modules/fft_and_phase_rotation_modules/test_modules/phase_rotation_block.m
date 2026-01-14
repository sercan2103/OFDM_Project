%% phase_rotation_block.m
% Combined Phase + Rotation Block Test Function
% This tests FFT + Phase Rotation as ONE complete block
%
% Simulates complete frequency offset correction pipeline:
%   Input OFDM Symbol → Extract Pilots → Calculate Phase → Rotate Data → Output
%
% USAGE:
%   [corrected_data, phase_offset] = phase_rotation_block(ofdm_symbol, pilot_indices);

function [corrected_data, phase_offset] = phase_rotation_block(ofdm_symbol, pilot_indices, expected_pilots)
% phase_rotation_block - Complete phase correction block
%
% INPUTS:
%   ofdm_symbol     - OFDM symbol [Nx2] matrix [I, Q]
%   pilot_indices   - Pilot subcarrier indices (e.g., [7, 21, 43, 57])
%   expected_pilots - Expected pilot values [4x2] (optional, defaults to ±1)
%
% OUTPUTS:
%   corrected_data  - Phase-corrected data
%   phase_offset    - Detected phase offset (in scaled units)

    % Add module path
    addpath('../part1_phase_rotation');
    
    % Initialize module states (persistent for continuous operation)
    persistent phase_state rotate_state initialized
    
    if isempty(initialized)
        phase_state = phase_init();
        rotate_state = rotate_init();
        initialized = true;
    end
    
    % Default expected pilots (BPSK: ±1)
    if nargin < 3
        expected_pilots = [1, 0; 1, 0; 1, 0; 1, 0] * 1000;
    end
    
    % ===== STEP 1: Extract Pilot Subcarriers =====
    pilots = ofdm_symbol(pilot_indices, :);
    
    % ===== STEP 2: Correlate with Expected Pilots =====
    % Multiply by conjugate of expected: pilot * conj(expected)
    pilot_sum_i = 0;
    pilot_sum_q = 0;
    
    for i = 1:length(pilot_indices)
        % Complex conjugate multiplication
        p_i = pilots(i, 1) * expected_pilots(i, 1) + ...
              pilots(i, 2) * expected_pilots(i, 2);
        p_q = pilots(i, 2) * expected_pilots(i, 1) - ...
              pilots(i, 1) * expected_pilots(i, 2);
        
        pilot_sum_i = pilot_sum_i + p_i;
        pilot_sum_q = pilot_sum_q + p_q;
    end
    
    % ===== STEP 3: Calculate Phase Offset using phase.m =====
    [phase_offset, phase_state] = phase(pilot_sum_i, pilot_sum_q, phase_state);
    
    % ===== STEP 4: Rotate All Subcarriers using rotate.m =====
    corrected_data = zeros(size(ofdm_symbol));
    
    for k = 1:size(ofdm_symbol, 1)
        [corr_i, corr_q, rotate_state] = rotate(ofdm_symbol(k,1), ...
                                                  ofdm_symbol(k,2), ...
                                                  -phase_offset, ...
                                                  rotate_state);
        corrected_data(k, :) = [corr_i, corr_q];
    end
    
end

% Helper initialization functions
function state = phase_init()
    state = struct();
    state.div_state.pipeline = zeros(36, 1);
    state.pipeline = zeros(40, 4);
end

function state = rotate_init()
    state = struct();
    state.mult_state.pipeline = zeros(5, 2);
    state.in_delay = zeros(4, 2);
    state.phase_pipeline = zeros(4, 3);
end
