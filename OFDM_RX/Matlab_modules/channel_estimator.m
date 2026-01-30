function [csi, state] = channel_estimator(lts1, lts2, lts_reference, mode, state)
% channel_estimator - OFDM Channel State Information (CSI) Estimator
%
% Estimates the channel frequency response using Long Training Symbols (LTS)
% by averaging two consecutive LTS symbols and applying phase correction
% based on known reference pattern.
%
% INPUTS:
%   lts1          - First LTS symbol [64x2] matrix [I, Q]
%   lts2          - Second LTS symbol [64x2] matrix [I, Q]
%   lts_reference - Reference sign pattern (64-bit mask, 1=invert, 0=keep)
%                   Legacy: 0x000A66000A60026C
%                   HT:     0x000A66001863026C
%   mode          - 'legacy' or 'ht' (default: 'legacy')
%   state         - State structure (optional)
%
% OUTPUTS:
%   csi   - Channel State Information [64x2] matrix [I, Q]
%   state - Updated state structure
%
% ALGORITHM:
%   For each subcarrier k:
%     if reference_bit(k) == 0:
%       csi(k) = (lts1(k) + lts2(k)) / 2
%     else:
%       csi(k) = -(lts1(k) + lts2(k)) / 2
%
% USAGE:
%   % Legacy mode
%   state = channel_estimator_init();
%   lts_ref = hex2dec('000A66000A60026C');
%   [csi, state] = channel_estimator(lts1, lts2, lts_ref, 'legacy', state);
%
%   % HT mode
%   lts_ref_ht = hex2dec('000A66001863026C');
%   [csi, state] = channel_estimator(lts1, lts2, lts_ref_ht, 'ht', state);
%
% NOTE:
%   - LTS symbols should be after FFT (frequency domain)
%   - Reference pattern corrects for known phase inversions in LTS
%   - Averaging improves SNR by 3dB

if nargin < 5
    state = channel_estimator_init();
end

if nargin < 4 || isempty(mode)
    mode = 'legacy';
end

% Number of subcarriers
N = 64;

% Initialize output
csi = zeros(N, 2);

% Process each subcarrier
for k = 1:N
    % Get reference bit (LSB first, so bit 0 corresponds to subcarrier 0)
    bit_pos = k - 1;
    ref_bit = bitget(lts_reference, bit_pos + 1);
    
    % Get samples from both LTS
    lts1_i = lts1(k, 1);
    lts1_q = lts1(k, 2);
    lts2_i = lts2(k, 1);
    lts2_q = lts2(k, 2);
    
    % Calculate mean: (lts1 + lts2) / 2
    mean_i = (lts1_i + lts2_i) / 2;
    mean_q = (lts1_q + lts2_q) / 2;
    
    % Apply sign correction based on reference
    if ref_bit == 1
        % Invert
        csi(k, 1) = -mean_i;
        csi(k, 2) = -mean_q;
    else
        % Keep as is
        csi(k, 1) = mean_i;
        csi(k, 2) = mean_q;
    end
end

% Store in state for debugging/analysis
state.csi = csi;
state.mode = mode;
state.lts1 = lts1;
state.lts2 = lts2;

end

function state = channel_estimator_init()
% Initialize state structure
state = struct();
state.csi = [];
state.mode = 'legacy';
state.lts1 = [];
state.lts2 = [];
end
