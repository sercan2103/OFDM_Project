function [rotated_samples] = qbpsk_derotate(samples)
% qbpsk_derotate - Convert Q-BPSK to BPSK by 90° rotation
%
% Rotates Q-BPSK modulated samples back to normal BPSK
% Used for HT-SIG decoding
% Corresponds to rotation logic in dot11.v S_HT_SIGNAL state
%
% INPUTS:
%   samples - Complex samples [N x 2] where each row is [I, Q]
%             Q-BPSK modulated (symbols on imaginary axis)
%
% OUTPUTS:
%   rotated_samples - Rotated samples [N x 2] 
%                     BPSK modulated (symbols on real axis)
%
% ROTATION: Clockwise 90° (or -90°)
%   [I', Q'] = [Q, -I]
%
% USAGE:
%   % HT-SIG samples (Q-BPSK)
%   ht_sig_qbpsk = [eq_i, eq_q];
%   % Convert to BPSK for decoding
%   ht_sig_bpsk = qbpsk_derotate(ht_sig_qbpsk);

if nargin < 1
    error('qbpsk_derotate requires sample matrix [I, Q]');
end

% Extract I and Q
I = samples(:, 1);
Q = samples(:, 2);

% Clockwise 90° rotation: [I', Q'] = [Q, -I]
I_new = Q;
Q_new = -I;

rotated_samples = [I_new, Q_new];

end
