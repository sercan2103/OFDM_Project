function [I, Q] = modulation_model(N_BPSC, bits_in)
% modulation_model - MATLAB model for modulation.v
%
% Inputs:
%   N_BPSC: Number of Bits Per SubCarrier (1, 2, 4, 6)
%   bits_in: Integer representing the input bits
%
% Outputs:
%   I: 16-bit signed integer (In-phase)
%   Q: 16-bit signed integer (Quadrature)

    % Initialize outputs
    I = int16(0);
    Q = int16(0);

    switch N_BPSC
        case 1 % BPSK
            % bits_in[0]
            bit0 = bitget(bits_in, 1);
            if bit0 == 0
                I = int16(-16384); % 0xC000
                Q = int16(0);      % 0x0000
            else
                I = int16(16384);  % 0x4000
                Q = int16(0);      % 0x0000
            end

        case 2 % QPSK
            % bits_in[1:0]
            bits = bitand(bits_in, 3);
            switch bits
                case 0 % 00
                    I = int16(-11585); % 0xD2BF
                    Q = int16(-11585); % 0xD2BF
                case 2 % 10
                    I = int16(-11585); % 0xD2BF
                    Q = int16(11585);  % 0x2D41
                case 1 % 01
                    I = int16(11585);  % 0x2D41
                    Q = int16(-11585); % 0xD2BF
                case 3 % 11
                    I = int16(11585);  % 0x2D41
                    Q = int16(11585);  % 0x2D41
            end

        case 4 % 16-QAM
            % I determined by bits_in[1:0]
            % Q determined by bits_in[3:2]
            
            i_bits = bitand(bits_in, 3);
            q_bits = bitand(bitshift(bits_in, -2), 3);
            
            I = map_16qam(i_bits);
            Q = map_16qam(q_bits);

        case 6 % 64-QAM
            % I determined by bits_in[2:0]
            % Q determined by bits_in[5:3]
            
            i_bits = bitand(bits_in, 7);
            q_bits = bitand(bitshift(bits_in, -3), 7);
            
            I = map_64qam(i_bits);
            Q = map_64qam(q_bits);
            
        otherwise
            error('Invalid N_BPSC');
    end
end

function val = map_16qam(bits)
    switch bits
        case 0 % 00
            val = int16(-15543); % 0xC349
        case 2 % 10
            val = int16(-5181);  % 0xEBC3
        case 3 % 11
            val = int16(5181);   % 0x143D
        case 1 % 01
            val = int16(15543);  % 0x3CB7
        otherwise
            val = int16(0);
    end
end

function val = map_64qam(bits)
    switch bits
        case 0 % 000
            val = int16(-17696); % 0xBAE0
        case 4 % 100
            val = int16(-12640); % 0xCEA0
        case 6 % 110
            val = int16(-7584);  % 0xE260
        case 2 % 010
            val = int16(-2528);  % 0xF620
        case 3 % 011
            val = int16(2528);   % 0x09E0
        case 7 % 111
            val = int16(7584);   % 0x1DA0
        case 5 % 101
            val = int16(12640);  % 0x3160
        case 1 % 001
            val = int16(17696);  % 0x4520
        otherwise
            val = int16(0);
    end
end
