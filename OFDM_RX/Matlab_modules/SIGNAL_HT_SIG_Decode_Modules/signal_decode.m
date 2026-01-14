function [signal_valid, signal_fields, ht_detected] = signal_decode(signal_bits)
% signal_decode - Decode and validate SIGNAL field (Legacy OFDM)
%
% Decodes the 24-bit SIGNAL field from 802.11a/g/n packets
% Corresponds to SIGNAL decoding logic in dot11.v (S_CHECK_SIGNAL state)
%
% INPUTS:
%   signal_bits - 24-bit SIGNAL field [bits 0:23]
%
% OUTPUTS:
%   signal_valid  - 1 if SIGNAL passes all checks, 0 otherwise
%   signal_fields - Structure containing decoded fields:
%       .rate       - Rate field (4 bits)
%       .reserved   - Reserved bit
%       .length     - Packet length in bytes (12 bits)
%       .parity     - Parity bit
%       .tail       - Tail bits (6 bits)
%       .parity_ok  - Parity check result
%   ht_detected   - 1 if rate=0xB (possible HT format)
%
% SIGNAL Field Structure (24 bits):
%   [3:0]   RATE - Modulation and coding scheme
%   [4]     RESERVED - Must be 0
%   [16:5]  LENGTH - Packet length in bytes
%   [17]    PARITY - Even parity over bits [0:16]
%   [23:18] TAIL - Must be all zeros
%
% USAGE:
%   signal_bits = [rate(4), rsvd(1), length(12), parity(1), tail(6)];
%   signal_value = sum(signal_bits .* 2.^(0:23));
%   [valid, fields, is_ht] = signal_decode(signal_value);

% Extract fields
rate = bitand(signal_bits, 15); % bits [3:0]
reserved = bitand(bitshift(signal_bits, -4), 1); % bit [4]
length = bitand(bitshift(signal_bits, -5), 4095); % bits [16:5]
parity = bitand(bitshift(signal_bits, -17), 1); % bit [17]
tail = bitand(bitshift(signal_bits, -18), 63); % bits [23:18]

% Calculate even parity over bits [0:16]
parity_bits = bitand(signal_bits, 2^17-1); % bits [0:16]
parity_calc = 0;
for i = 0:16
    parity_calc = bitxor(parity_calc, bitand(bitshift(parity_bits, -i), 1));
end
parity_ok = (parity_calc == 0); % Even parity check

% Validation
signal_valid = 1;
if ~parity_ok
    signal_valid = 0;
    fprintf('SIGNAL Error: Parity check failed\n');
end
if reserved ~= 0
    signal_valid = 0;
    fprintf('SIGNAL Error: Reserved bit is not 0\n');
end
if tail ~= 0
    signal_valid = 0;
    fprintf('SIGNAL Error: Tail bits are not all zeros\n');
end

% Check for HT format
ht_detected = (rate == 11); % 0x0B = 11

% Return fields
signal_fields = struct();
signal_fields.rate = rate;
signal_fields.reserved = reserved;
signal_fields.length = length;
signal_fields.parity = parity;
signal_fields.tail = tail;
signal_fields.parity_ok = parity_ok;

end
