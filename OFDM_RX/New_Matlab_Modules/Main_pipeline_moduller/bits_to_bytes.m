function [byte_out, output_strobe] = bits_to_bytes(bit_in, input_strobe, reset)
% BITS_TO_BYTES Convert bit stream to bytes
%
% Verilog equivalent: bits_to_bytes.v
% Latency: 8 bits (accumulation time)
%
% Inputs:
%   bit_in: Input bit (1-bit)
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   byte_out: Output byte (8-bit)
%   output_strobe: Output valid signal

    persistent shift_reg bit_count
    
    if nargin < 3
        reset = 0;
    end
    
    % Initialize
    if isempty(shift_reg) || reset
        shift_reg = zeros(8, 1);
        bit_count = 0;
    end
    
    % Default outputs
    byte_out = 0;
    output_strobe = 0;
    
    if ~input_strobe
        return;
    end
    
    % Shift in new bit
    shift_reg = [bit_in; shift_reg(1:7)];
    bit_count = bit_count + 1;
    
    % Output byte when we have 8 bits
    if bit_count >= 8
        % Convert bit array to byte
        byte_val = 0;
        for k = 1:8
            if shift_reg(k)
                byte_val = bitset(byte_val, k);
            end
        end
        
        byte_out = byte_val;
        output_strobe = 1;
        bit_count = 0;
    end
end
