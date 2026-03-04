function crc_out = ht_sig_crc(bit_stream, reset)
% HT_SIG_CRC CRC-8 calculation for HT-SIG validation
%
% IEEE 802.11n HT-SIG CRC-8 calculator
% Polynomial: x^8 + x^7 + x^4 + x^3 + x + 1
% 
% Computes CRC-8 over 34 bits:
%   - HT-SIG1[23:0] (24 bits)
%   - HT-SIG2[9:0] (10 bits)
%
% Verilog equivalent: ht_sig_crc.v
%
% Inputs:
%   bit_stream: Vector of bits to compute CRC over
%   reset: Reset CRC state (optional)
%
% Outputs:
%   crc_out: 8-bit CRC value (uint8)

    persistent C;
    
    if nargin < 2
        reset = 0;
    end
    
    % Initialize CRC register
    if isempty(C) || reset
        C = uint8(255); % Initialize to 0xFF (inverted)
    end
    
    % Process each bit
    for i = 1:length(bit_stream)
        bit = bitand(bit_stream(i), 1);
        
        % CRC-8 polynomial: x^8 + x^7 + x^4 + x^3 + x + 1
        % Feedback: C[7] XOR bit
        feedback = bitxor(bitshift(C, -7), bit);
        feedback = bitand(feedback, 1);
        
        % Shift and apply taps
        C_new = bitshift(C, 1); % Shift left
        C_new = bitand(C_new, 255); % Keep 8 bits
        
        % Apply polynomial taps when feedback = 1
        if feedback
            C_new = bitxor(C_new, 135); % 0x87 = b10000111 (taps at positions 7,4,3,1,0)
        end
        
        C = uint8(C_new);
    end
    
    % Output is bit-reversed and inverted (matching Verilog)
    crc_out = uint8(0);
    for i = 0:7
        bit = bitget(C, 8-i);
        crc_out = bitset(crc_out, i+1, ~bit);
    end
    crc_out = bitand(crc_out, 255);
end
