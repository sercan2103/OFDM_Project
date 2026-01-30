function [corrected_samples, cfo_phase, state] = fine_cfo_correction(samples, pilots, pilot_positions, lts_csi, state)
% fine_cfo_correction - Fine Carrier Frequency Offset (CFO) Correction
%
% This function estimates and corrects residual carrier frequency offset
% using pilot subcarriers in OFDM symbols.
%
% INPUTS:
%   samples          - Complex input samples [Nx2] matrix [I, Q] (N=64 subcarriers)
%   pilots           - Expected pilot values [4x2] matrix [I, Q]
%   pilot_positions  - Pilot subcarrier indices (typically [-21, -7, 7, 21])
%   lts_csi          - Channel State Information from LTS [64x2] matrix
%   state            - State structure (optional)
%
% OUTPUTS:
%   corrected_samples - CFO corrected and equalized samples [Mx2] where M is data carriers
%   cfo_phase         - Estimated CFO phase in radians
%   state             - Updated state structure
%
% ALGORITHM:
%   1. Extract pilot subcarriers from input
%   2. Apply channel equalization to pilots using LTS CSI
%   3. Correlate with expected pilots: sum(pilot * conj(expected))
%   4. Calculate phase: angle of correlation sum
%   5. Apply phase rotation to all subcarriers
%   6. Equalize data subcarriers using CSI
%
% USAGE:
%   % Initialize
%   state = fine_cfo_correction_init();
%   
%   % Process one OFDM symbol
%   pilot_vals = [1, 1; 1, 1; 1, 1; -1, -1]; % Example: Legacy pilots with polarity=1
%   pilot_pos = [43, 57, 7, 21]; % Indices for subcarriers -21,-7,7,21
%   [corrected, phase, state] = fine_cfo_correction(samples, pilot_vals, pilot_pos, lts_csi, state);
%
% NOTE:
%   - Pilot positions are 1-based indices (1 to 64)
%   - Phase is in radians (scaled by 512 for fixed-point compatibility)
%   - CSI should be pre-computed from LTS symbols

if nargin < 5
    state = fine_cfo_correction_init();
end

% Constants
PILOT_MASK = hex2dec('0200002000002008'); % Pilot subcarrier mask
DATA_SUBCARRIER_MASK = hex2dec('FFFDFFDFFFFFF7F7'); % Data subcarrier mask (excluding pilots)
SCALE_SHIFT = 10; % Scaling for division

% Number of subcarriers
N = size(samples, 1);

% Step 1: Extract pilots and calculate CFO phase
pilot_sum_i = 0;
pilot_sum_q = 0;

for p = 1:length(pilot_positions)
    idx = pilot_positions(p);
    
    % Get received pilot
    rx_pilot_i = samples(idx, 1);
    rx_pilot_q = samples(idx, 2);
    
    % Get expected pilot (with conjugate for correlation)
    exp_pilot_i = pilots(p, 1);
    exp_pilot_q = -pilots(p, 2); % Conjugate
    
    % Get CSI for this pilot
    csi_i = lts_csi(idx, 1);
    csi_q = lts_csi(idx, 2);
    
    % Complex multiply: pilot * conj(expected) * conj(CSI)
    % This gives us the phase error
    temp_i = rx_pilot_i * exp_pilot_i - rx_pilot_q * exp_pilot_q;
    temp_q = rx_pilot_i * exp_pilot_q + rx_pilot_q * exp_pilot_i;
    
    % Multiply by conj(CSI)
    prod_i = temp_i * csi_i + temp_q * csi_q;
    prod_q = temp_q * csi_i - temp_i * csi_q;
    
    % Accumulate
    pilot_sum_i = pilot_sum_i + prod_i;
    pilot_sum_q = pilot_sum_q + prod_q;
end

% Step 2: Calculate CFO phase
cfo_phase = atan2(pilot_sum_q, pilot_sum_i);

% Step 3: Apply CFO correction and equalization to all subcarriers
corrected_samples = zeros(N, 2);
data_idx = 1;

for k = 1:N
    % Check if this is a data subcarrier
    bit_pos = k - 1;
    is_data = bitget(DATA_SUBCARRIER_MASK, bit_pos + 1);
    
    if is_data
        % Get input sample
        in_i = samples(k, 1);
        in_q = samples(k, 2);
        
        % Apply CFO correction (rotate by -cfo_phase)
        rot_i = in_i * cos(-cfo_phase) - in_q * sin(-cfo_phase);
        rot_q = in_i * sin(-cfo_phase) + in_q * cos(-cfo_phase);
        
        % Get CSI
        csi_i = lts_csi(k, 1);
        csi_q = lts_csi(k, 2);
        
        % Zero-forcing equalization: rotated * conj(CSI) / |CSI|^2
        prod_i = rot_i * csi_i + rot_q * csi_q;
        prod_q = rot_q * csi_i - rot_i * csi_q;
        
        mag_sq = csi_i^2 + csi_q^2;
        
        if mag_sq > 0
            % Normalize
            eq_i = prod_i / mag_sq;
            eq_q = prod_q / mag_sq;
            
            corrected_samples(data_idx, 1) = eq_i;
            corrected_samples(data_idx, 2) = eq_q;
            data_idx = data_idx + 1;
        end
    end
end

% Trim output to actual data carriers
corrected_samples = corrected_samples(1:data_idx-1, :);

end

function state = fine_cfo_correction_init()
% Initialize state structure
state = struct();
state.cfo_phase_history = [];
state.iteration = 0;
end
