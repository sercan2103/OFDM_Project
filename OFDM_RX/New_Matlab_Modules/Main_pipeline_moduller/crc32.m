function [crc_out] = crc32(data_in, crc_en, reset)
% CRC32 IEEE 802.11 CRC-32 calculation
%
% Verilog equivalent: crc32.v
%
% Inputs:
%   data_in: Input byte (8-bit)
%   crc_en: Enable signal
%   reset: Reset signal
%
% Output:
%   crc_out: CRC value (32-bit)
%
% Polynomial: 0x04C11DB7
% Initial value: 0xFFFFFFFF
% Expected FCS after correct packet: 0xc704dd7b

    persistent crc_state
    
    % Initialize
    if isempty(crc_state) || reset
        crc_state = uint32(hex2dec('FFFFFFFF'));
    end
    
    if crc_en
        % Process byte (bit-reversed)
        byte_val = data_in;
        
        % Reverse bits in byte (802.11 CRC uses LSB first)
        byte_reversed = 0;
        for k = 0:7
            if bitget(byte_val, k+1)
                byte_reversed = bitset(byte_reversed, 8-k);
            end
        end
        
        % CRC calculation
        for k = 1:8
            bit = bitget(byte_reversed, k);
            feedback = bitxor(bit, bitget(crc_state, 32));
            
            % Shift and apply polynomial
            crc_state = bitshift(crc_state, 1);
            
            if feedback
                crc_state = bitxor(crc_state, uint32(hex2dec('04C11DB7')));
            end
            
            % Keep 32 bits
            crc_state = bitand(crc_state, uint32(hex2dec('FFFFFFFF')));
        end
    end
    
    crc_out = crc_state;
end
