function [out_bit, output_strobe] = descramble(in_bit, input_strobe, reset)
% DESCRAMBLE 802.11 descrambler
%
% Verilog equivalent: descramble.v
% Latency: Variable (7 bits for initialization + 1 per bit)
%
% Inputs:
%   in_bit: Input bit (1-bit)
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   out_bit: Descrambled bit (1-bit)
%   output_strobe: Output valid signal
%
% LFSR: x^7 + x^4 + 1
% First 7 bits initialize the scrambler state

    persistent lfsr_state bit_count inited
    
    if nargin < 3
        reset = 0;
    end
    
    % Initialize
    if isempty(lfsr_state) || reset
        lfsr_state = zeros(7, 1);
        bit_count = 0;
        inited = 0;
    end
    
    % Default outputs
    out_bit = 0;
    output_strobe = 0;
    
    if ~input_strobe
        return;
    end
    
    if ~inited
        % First 7 bits initialize the LFSR
        lfsr_state(7 - bit_count) = in_bit;
        bit_count = bit_count + 1;
        
        if bit_count >= 7
            inited = 1;
            bit_count = 0;
        end
        
        % No output during initialization
        output_strobe = 0;
    else
        % Descramble: feedback XOR input
        feedback = xor(lfsr_state(7), lfsr_state(4));
        out_bit = xor(feedback, in_bit);
        
        % Shift LFSR
        lfsr_state = [feedback; lfsr_state(1:6)];
        
        output_strobe = 1;
    end
end
