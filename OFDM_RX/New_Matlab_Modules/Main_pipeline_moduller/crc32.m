function [crc_out, state] = crc32(data_in, state)
% crc32 - CRC-32 calculation for FCS (Frame Check Sequence)
%
% Implements CRC-32 (IEEE 802.11) for packet FCS validation
% Polynomial: x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + 
%             x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
% Corresponds to crc32.v
%
% INPUTS:
%   data_in - Input byte (8 bits, LSB first)
%   state   - CRC state structure
%
% OUTPUTS:
%   crc_out - Current CRC value (32-bit)
%   state   - Updated CRC state
%
% Expected FCS for correct packet: 0xC704DD7B
%
% USAGE:
%   % Initialize
%   state = struct();
%   state.crc = uint32(hex2dec('FFFFFFFF'));
%   % Process each byte
%   for i = 1:length(packet_bytes)
%       [fcs, state] = crc32(packet_bytes(i), state);
%   end
%   % Check: fcs should equal 0xC704DD7B

if nargin < 2 || isempty(state)
    state = struct();
    state.crc = uint32(hex2dec('FFFFFFFF'));
end

% IEEE 802.11 CRC-32 polynomial
% 0x04C11DB7 (reversed: 0xEDB88320)
poly = uint32(hex2dec('EDB88320'));

% Current CRC state
crc = state.crc;

% Process byte bit-by-bit (LSB first, bit-reversed input)
byte_val = uint8(data_in);
for i = 0:7
    % Reverse bit order for this bit
    bit_pos = 7 - i;
    bit = bitand(bitshift(byte_val, -bit_pos), 1);
    
    % XOR with LSB of CRC
    fb = bitxor(bitand(crc, 1), bit);
    
    % Shift right
    crc = bitshift(crc, -1);
    
    % Apply polynomial if feedback is 1
    if fb
        crc = bitxor(crc, poly);
    end
end

% Update state
state.crc = crc;

% Output (complemented)
crc_out = bitcmp(crc, 'uint32');

end
