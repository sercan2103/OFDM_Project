function [crc, state] = ht_sig_crc(bit, state)
% ht_sig_crc - CRC-8 calculation for HT-SIG field
%
% Implements CRC-8 with polynomial: x^8 + x^7 + x^4 + x^3 + x^2 + 1
% Corresponds to ht_sig_crc.v
%
% INPUTS:
%   bit   - Input bit (0 or 1)
%   state - CRC state structure
%
% OUTPUTS:
%   crc   - Current CRC value (8-bit, bit-reversed and inverted)
%   state - Updated CRC state
%
% USAGE:
%   % Initialize
%   state = ht_sig_crc_init();
%   % Process bits
%   for i = 1:34
%       [crc_val, state] = ht_sig_crc(bits(i), state);
%   end
%   % Final CRC is in crc_val

if nargin < 2
    state = ht_sig_crc_init();
end

% CRC polynomial: x^8 + x^7 + x^4 + x^3 + x^2 + 1
% Generator: 10001110 (bits 7,4,3,2,0)

% Current CRC state
C = state.C;

% Calculate next state
C_new = zeros(1, 8);
fb = bitxor(bit, C(8)); % Feedback bit

C_new(1) = fb;
C_new(2) = bitxor(fb, C(1));
C_new(3) = bitxor(fb, C(2));
C_new(4) = C(3);
C_new(5) = C(4);
C_new(6) = C(5);
C_new(7) = C(6);
C_new(8) = C(7);

% Update state
state.C = C_new;

% Output: bit-reversed and inverted
crc_bits = zeros(1, 8);
for i = 1:8
    crc_bits(i) = ~C_new(9-i) & 1; % Invert and reverse
end

% Convert to 8-bit value
crc = 0;
for i = 1:8
    crc = crc + crc_bits(i) * 2^(i-1);
end

end

function state = ht_sig_crc_init()
% Initialize HT-SIG CRC state (all 1's)
    state = struct();
    state.C = ones(1, 8);
end
