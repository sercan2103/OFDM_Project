function [soft_bits, output_strobe] = demodulate(cons_i, cons_q, rate, input_strobe, reset)
% DEMODULATE Soft-decision demodulation
%
% Verilog equivalent: demodulate.v
% Latency: 3 cycles
%
% Inputs:
%   cons_i, cons_q: Constellation point (16-bit signed, Q0.15)
%   rate: Modulation rate (8-bit)
%         Bit[7]: 0=Legacy, 1=HT
%         Legacy (bit[7]=0): bits[3:0] = rate field
%         HT (bit[7]=1): bits[6:0] = MCS
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   soft_bits: Soft decision bits (6-bit: 0-7 confidence levels)
%   output_strobe: Output valid signal
%
% Rate encoding:
%   Legacy rates (bit[7]=0):
%     11 (0x0B): BPSK (1 bit/symbol)
%     15 (0x0F): BPSK (1 bit/symbol)
%     10 (0x0A): QPSK (2 bits/symbol)
%     14 (0x0E): QPSK (2 bits/symbol)
%     9  (0x09): QAM-16 (4 bits/symbol)
%     13 (0x0D): QAM-16 (4 bits/symbol)
%     8  (0x08): QAM-64 (6 bits/symbol)
%     12 (0x0C): QAM-64 (6 bits/symbol)
%   HT rates (bit[7]=1):
%     MCS 0-1: BPSK
%     MCS 2-3: QPSK
%     MCS 4-5: QAM-16
%     MCS 6-7: QAM-64

    persistent pipeline
    
    if nargin < 5
        reset = 0;
    end
    
    % Initialize pipeline (3 stages)
    if isempty(pipeline) || reset
        pipeline = struct('bits', zeros(3,1), 'valid', zeros(3,1));
    end
    
    % Constants for QAM decision boundaries (Q0.15 format, scaled by 1024)
    MAX = 1024; % 1 << 10
    QAM_16_DIV = floor(MAX * 2 / 3);  % 682
    QAM_64_DIV_0 = floor(MAX * 2 / 7); % 292
    QAM_64_DIV_1 = floor(MAX * 4 / 7); % 585
    QAM_64_DIV_2 = floor(MAX * 6 / 7); % 877
    
    % Get absolute values
    abs_i = abs(cons_i);
    abs_q = abs(cons_q);
    
    % Check if HT format (bit 7 = 1)
    is_ht = bitget(rate, 8);
    
    % Determine modulation type from rate
    bits_out = 0;
    
    if is_ht
        % HT MCS encoding
        mcs = bitand(rate, 127); % Extract MCS [6:0]
        
        if mcs <= 1  % MCS 0-1: BPSK
            % 1 bit: sign of I
            if cons_i >= 0
                bits_out = 7; % Strong 1
            else
                bits_out = 0; % Strong 0
            end
            
        elseif mcs <= 3  % MCS 2-3: QPSK
            % 2 bits: sign of I, sign of Q
            bit0 = 0;
            bit1 = 0;
            
            if cons_i >= 0
                bit0 = 7;
            end
            if cons_q >= 0
                bit1 = 7;
            end
            
            bits_out = bitshift(bit1, 3) + bit0;
            
        elseif mcs <= 5  % MCS 4-5: QAM-16
            % 4 bits
            bits_out = demodulate_qam16(cons_i, cons_q, abs_i, abs_q, QAM_16_DIV);
            
        elseif mcs <= 7  % MCS 6-7: QAM-64
            % 6 bits
            bits_out = demodulate_qam64(cons_i, cons_q, abs_i, abs_q, ...
                                       QAM_64_DIV_0, QAM_64_DIV_1, QAM_64_DIV_2);
        end
        
    else
        % Legacy rate encoding
        if rate == 11 || rate == 15  % BPSK
            % 1 bit: sign of I
            if cons_i >= 0
                bits_out = 7; % Strong 1
            else
                bits_out = 0; % Strong 0
            end
            
        elseif rate == 10 || rate == 14  % QPSK
            % 2 bits: sign of I, sign of Q
            bit0 = 0;
            bit1 = 0;
            
            if cons_i >= 0
                bit0 = 7;
            end
            if cons_q >= 0
                bit1 = 7;
            end
            
            bits_out = bitshift(bit1, 3) + bit0; % Combine into 6 bits
            
        elseif rate == 9 || rate == 13  % QAM-16
            % 4 bits
            bits_out = demodulate_qam16(cons_i, cons_q, abs_i, abs_q, QAM_16_DIV);
            
        elseif rate == 8 || rate == 12  % QAM-64
            % 6 bits
            bits_out = demodulate_qam64(cons_i, cons_q, abs_i, abs_q, ...
                                         QAM_64_DIV_0, QAM_64_DIV_1, QAM_64_DIV_2);
        end
    end
    
    % Pipeline stages
    pipeline.bits(1) = bits_out;
    pipeline.valid(1) = input_strobe;
    
    for k = 2:3
        pipeline.bits(k) = pipeline.bits(k-1);
        pipeline.valid(k) = pipeline.valid(k-1);
    end
    
    % Output from stage 3
    soft_bits = pipeline.bits(3);
    output_strobe = pipeline.valid(3);
end

function bits = demodulate_qam16(cons_i, cons_q, abs_i, abs_q, threshold)
    % QAM-16 demodulation
    % 4 bits: 2 from I, 2 from Q
    
    % I bits
    if cons_i >= 0
        if abs_i >= threshold
            i_bits = 0x7; % 11 strong
        else
            i_bits = 0x4; % 10 weak
        end
    else
        if abs_i >= threshold
            i_bits = 0x0; % 00 strong
        else
            i_bits = 0x3; % 01 weak
        end
    end
    
    % Q bits
    if cons_q >= 0
        if abs_q >= threshold
            q_bits = 0x7; % 11 strong
        else
            q_bits = 0x4; % 10 weak
        end
    else
        if abs_q >= threshold
            q_bits = 0x0; % 00 strong
        else
            q_bits = 0x3; % 01 weak
        end
    end
    
    % Combine (6 bits total: 3 for I, 3 for Q)
    bits = bitshift(q_bits, 3) + i_bits;
end

function bits = demodulate_qam64(cons_i, cons_q, abs_i, abs_q, div0, div1, div2)
    % QAM-64 demodulation
    % 6 bits: 3 from I, 3 from Q
    
    % I bits (3 bits)
    if cons_i >= 0
        if abs_i >= div2
            i_bits = 0x7; % 111
        elseif abs_i >= div1
            i_bits = 0x6; % 110
        elseif abs_i >= div0
            i_bits = 0x4; % 100
        else
            i_bits = 0x5; % 101
        end
    else
        if abs_i >= div2
            i_bits = 0x0; % 000
        elseif abs_i >= div1
            i_bits = 0x1; % 001
        elseif abs_i >= div0
            i_bits = 0x3; % 011
        else
            i_bits = 0x2; % 010
        end
    end
    
    % Q bits (3 bits)
    if cons_q >= 0
        if abs_q >= div2
            q_bits = 0x7; % 111
        elseif abs_q >= div1
            q_bits = 0x6; % 110
        elseif abs_q >= div0
            q_bits = 0x4; % 100
        else
            q_bits = 0x5; % 101
        end
    else
        if abs_q >= div2
            q_bits = 0x0; % 000
        elseif abs_q >= div1
            q_bits = 0x1; % 001
        elseif abs_q >= div0
            q_bits = 0x3; % 011
        else
            q_bits = 0x2; % 010
        end
    end
    
    % Combine into 6 bits
    bits = bitshift(q_bits, 3) + i_bits;
end
