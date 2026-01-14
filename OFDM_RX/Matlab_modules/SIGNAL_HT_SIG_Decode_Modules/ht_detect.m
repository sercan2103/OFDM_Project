function [is_ht] = ht_detect(eq_samples)
% ht_detect - Detect HT format by analyzing Q-BPSK rotation
%
% Determines if packet is HT (802.11n) format by counting samples
% with dominant Q component (rotated BPSK) vs dominant I component
% Corresponds to S_DETECT_HT state in dot11.v
%
% INPUTS:
%   eq_samples - Equalized samples [N x 2] where each row is [I, Q]
%                Typically first 8-12 samples of potential HT-SIG symbol
%
% OUTPUTS:
%   is_ht - 1 if HT format detected, 0 if Legacy format
%
% ALGORITHM:
%   HT-SIG uses Q-BPSK (90° rotated BPSK)
%   - HT format: |Q| > |I| (symbols on imaginary axis)
%   - Legacy format: |I| > |Q| (symbols on real axis)
%
% DETECTION THRESHOLDS:
%   - If rot_count >= 4: HT detected
%   - If normal_count > 4: Legacy detected
%
% USAGE:
%   % Get first 8-10 samples after SIGNAL field
%   samples = [eq_i_vals, eq_q_vals]; % [I, Q] pairs
%   is_ht_format = ht_detect(samples);

if nargin < 1
    error('ht_detect requires equalized sample matrix [I, Q]');
end

% Count rotated vs normal BPSK
rot_count = 0;
normal_count = 0;

for i = 1:size(eq_samples, 1)
    eq_i = eq_samples(i, 1);
    eq_q = eq_samples(i, 2);
    
    % Calculate absolute values
    abs_i = abs(eq_i);
    abs_q = abs(eq_q);
    
    % Compare magnitudes
    if abs_q > abs_i
        rot_count = rot_count + 1;      % Q dominant -> rotated
    else
        normal_count = normal_count + 1; % I dominant -> normal
    end
    
    % Early decision (matches Verilog thresholds)
    if rot_count >= 4
        is_ht = 1;
        fprintf('[HT DETECT] HT format detected (rot=%d, normal=%d)\n', rot_count, normal_count);
        return;
    end
    if normal_count > 4
        is_ht = 0;
        fprintf('[HT DETECT] Legacy format detected (rot=%d, normal=%d)\n', rot_count, normal_count);
        return;
    end
end

% If we get here without early return, use final counts
if rot_count >= normal_count
    is_ht = 1;
    fprintf('[HT DETECT] HT format detected (rot=%d, normal=%d)\n', rot_count, normal_count);
else
    is_ht = 0;
    fprintf('[HT DETECT] Legacy format detected (rot=%d, normal=%d)\n', rot_count, normal_count);
end

end
