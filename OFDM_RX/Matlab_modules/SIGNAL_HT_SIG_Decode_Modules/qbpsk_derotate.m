function [rotated_i, rotated_q] = qbpsk_derotate(sample_i, sample_q, index)
% qbpsk_derotate - Convert Q-BPSK to BPSK by 90° rotation
%
% Rotates Q-BPSK modulated samples back to normal BPSK
% Used for HT-SIG decoding
% Corresponds to rotation logic in dot11.v S_HT_SIGNAL state
%
% INPUTS:
%   sample_i - I component of sample
%   sample_q - Q component of sample  
%   index    - Sample index (0-based, determines rotation)
%
% OUTPUTS:
%   rotated_i - I component after rotation
%   rotated_q - Q component after rotation
%
% ROTATION: 
%   Even index (0, 2, 4, ...): No rotation needed
%   Odd index (1, 3, 5, ...): Clockwise 90° rotation: [I', Q'] = [Q, -I]
%
% USAGE:
%   % Process HT-SIG symbol by symbol
%   for k = 0:95
%       [out_i, out_q] = qbpsk_derotate(in_i(k+1), in_q(k+1), k);
%   end

if nargin < 3
    error('qbpsk_derotate requires (sample_i, sample_q, index)');
end

% Q-BPSK: symbols alternate between I and Q axes
% Even indices: on I-axis (already BPSK)
% Odd indices: on Q-axis (need 90° CCW rotation to move to I-axis)

if mod(index, 2) == 0
    % Even index: no rotation
    rotated_i = sample_i;
    rotated_q = sample_q;
else
    % Odd index: rotate 90° counter-clockwise [I', Q'] = [-Q, I]
    % This moves Q-axis symbols to I-axis
    rotated_i = -sample_q;
    rotated_q = sample_i;
end

end
