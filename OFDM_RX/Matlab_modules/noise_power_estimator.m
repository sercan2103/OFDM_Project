function [noise_power, snr_db, state] = noise_power_estimator(lts1, lts2, csi, method, state)
% noise_power_estimator - Noise Power Estimation for OFDM
%
% Estimates noise power and SNR using LTS symbols and channel estimates.
% Supports multiple estimation methods.
%
% INPUTS:
%   lts1   - First LTS symbol [64x2] matrix [I, Q]
%   lts2   - Second LTS symbol [64x2] matrix [I, Q]
%   csi    - Channel State Information [64x2] matrix [I, Q]
%   method - Estimation method:
%            'lts_difference' (default): Use difference between two LTS
%            'null_subcarriers': Use null subcarriers (DC and edge)
%            'residual': Use equalization residual error
%   state  - State structure (optional)
%
% OUTPUTS:
%   noise_power - Estimated noise power (linear scale)
%   snr_db      - Estimated Signal-to-Noise Ratio in dB
%   state       - Updated state structure
%
% METHODS:
%   1. LTS Difference: Assumes channel is constant across two LTS
%      noise_power = mean(|lts1 - lts2|^2) / 2
%
%   2. Null Subcarriers: Uses subcarriers that should be zero
%      noise_power = mean(|null_carriers|^2)
%
%   3. Residual: After equalization, measure residual error
%      noise_power = mean(|received - expected|^2)
%
% USAGE:
%   state = noise_power_estimator_init();
%   [noise_pwr, snr, state] = noise_power_estimator(lts1, lts2, csi, 'lts_difference', state);
%   fprintf('Noise Power: %.2f, SNR: %.2f dB\n', noise_pwr, snr);
%
% NOTE:
%   - All power measurements are in linear scale
%   - Only active subcarriers are used (excluding DC and edges)

if nargin < 5
    state = noise_power_estimator_init();
end

if nargin < 4 || isempty(method)
    method = 'lts_difference';
end

% Constants
ACTIVE_SUBCARRIERS = [2:27, 39:64]; % Exclude DC (1) and some edge carriers (28-38)
NULL_SUBCARRIERS = [1, 28:38]; % DC and guard bands

% Initialize
noise_power = 0;
signal_power = 0;

switch method
    case 'lts_difference'
        % Method 1: Use difference between two LTS symbols
        % Assumes channel is constant, so difference is only noise
        diff_samples = lts1 - lts2;
        
        % Calculate power only on active subcarriers
        noise_sum = 0;
        for k = ACTIVE_SUBCARRIERS
            diff_i = diff_samples(k, 1);
            diff_q = diff_samples(k, 2);
            noise_sum = noise_sum + (diff_i^2 + diff_q^2);
        end
        
        % Noise power (divide by 2 since noise in both LTS)
        noise_power = noise_sum / (2 * length(ACTIVE_SUBCARRIERS));
        
        % Signal power from CSI
        signal_sum = 0;
        for k = ACTIVE_SUBCARRIERS
            csi_i = csi(k, 1);
            csi_q = csi(k, 2);
            signal_sum = signal_sum + (csi_i^2 + csi_q^2);
        end
        signal_power = signal_sum / length(ACTIVE_SUBCARRIERS);
        
    case 'null_subcarriers'
        % Method 2: Use null subcarriers
        % These should be zero, so any energy is noise
        noise_sum = 0;
        for k = NULL_SUBCARRIERS
            lts1_i = lts1(k, 1);
            lts1_q = lts1(k, 2);
            lts2_i = lts2(k, 1);
            lts2_q = lts2(k, 2);
            
            noise_sum = noise_sum + (lts1_i^2 + lts1_q^2) + (lts2_i^2 + lts2_q^2);
        end
        noise_power = noise_sum / (2 * length(NULL_SUBCARRIERS));
        
        % Signal power from CSI
        signal_sum = 0;
        for k = ACTIVE_SUBCARRIERS
            csi_i = csi(k, 1);
            csi_q = csi(k, 2);
            signal_sum = signal_sum + (csi_i^2 + csi_q^2);
        end
        signal_power = signal_sum / length(ACTIVE_SUBCARRIERS);
        
    case 'residual'
        % Method 3: Residual error after equalization
        % Compare averaged LTS with individual LTS after channel correction
        lts_avg = (lts1 + lts2) / 2;
        
        residual_sum = 0;
        signal_sum = 0;
        
        for k = ACTIVE_SUBCARRIERS
            % Expected value after equalization
            expected_i = lts_avg(k, 1);
            expected_q = lts_avg(k, 2);
            
            % CSI
            csi_i = csi(k, 1);
            csi_q = csi(k, 2);
            csi_mag_sq = csi_i^2 + csi_q^2;
            
            if csi_mag_sq > 0
                % Equalize lts1
                lts1_i = lts1(k, 1);
                lts1_q = lts1(k, 2);
                eq1_i = (lts1_i * csi_i + lts1_q * csi_q) / csi_mag_sq;
                eq1_q = (lts1_q * csi_i - lts1_i * csi_q) / csi_mag_sq;
                
                % Calculate residual
                res1_i = eq1_i - expected_i;
                res1_q = eq1_q - expected_q;
                residual_sum = residual_sum + (res1_i^2 + res1_q^2);
                
                % Signal power
                signal_sum = signal_sum + (expected_i^2 + expected_q^2);
            end
        end
        
        noise_power = residual_sum / length(ACTIVE_SUBCARRIERS);
        signal_power = signal_sum / length(ACTIVE_SUBCARRIERS);
        
    otherwise
        error('Unknown method: %s', method);
end

% Calculate SNR in dB
if noise_power > 0
    snr_linear = signal_power / noise_power;
    snr_db = 10 * log10(snr_linear);
else
    snr_db = Inf;
end

% Store in state
state.noise_power = noise_power;
state.signal_power = signal_power;
state.snr_db = snr_db;
state.method = method;

end

function state = noise_power_estimator_init()
% Initialize state structure
state = struct();
state.noise_power = 0;
state.signal_power = 0;
state.snr_db = 0;
state.method = 'lts_difference';
state.history = [];
end
