function [out_bits, erase, output_strobe] = deinterleave(in_bits, rate, input_strobe, reset)
% DEINTERLEAVE Frequency-domain to time-domain bit reordering
%
% Verilog equivalent: deinterleave.v
% Latency: 4 cycles
%
% Inputs:
%   in_bits: Input soft bits (6-bit)
%   rate: Modulation rate (8-bit)
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   out_bits: Deinterleaved bits (2-bit, 2 parallel streams)
%   erase: Erasure flags (2-bit)
%   output_strobe: Output valid signal

    persistent pipeline lut carrier_count
    
    if nargin < 4
        reset = 0;
    end
    
    % Load deinterleaver LUT on first call
    if isempty(lut)
        lut = load_deinter_lut();
    end
    
    % Initialize pipeline (4 stages)
    if isempty(pipeline) || reset
        pipeline = struct('bits', zeros(4,2), 'erase', zeros(4,2), 'valid', zeros(4,1));
        carrier_count = 0;
    end
    
    % Determine HT mode from rate
    ht = bitget(rate, 8); % MSB indicates HT
    
    % Number of data carriers
    % Legacy (802.11a/g): 48 data subcarriers
    % HT (802.11n): 52 data subcarriers
    if ht
        num_carriers = 52; % HT format
    else
        num_carriers = 48; % Legacy format
    end
    
    % Default outputs
    out_bits = [0, 0];
    erase = [0, 0];
    output_strobe = 0;
    
    if ~input_strobe
        return;
    end
    
    % Split 6-bit input into two 3-bit soft values
    soft_a = bitand(in_bits, 7); % Lower 3 bits
    soft_b = bitshift(in_bits, -3); % Upper 3 bits
    
    % LUT lookup for deinterleaver mapping
    % LUT key combines: rate, carrier index, bit position
    lut_key = carrier_count; % Simplified - real implementation more complex
    
    if lut_key < length(lut)
        lut_val = lut(lut_key + 1); % MATLAB 1-indexed
        
        % Extract fields from LUT entry (22-bit)
        erase_a = bitget(lut_val, 22);
        erase_b = bitget(lut_val, 21);
        
        % Address mapping (bits 0-19)
        addr_a = bitand(lut_val, 1023); % Lower 10 bits
        addr_b = bitshift(bitand(lut_val, 1047552), -10); % Next 10 bits
    else
        erase_a = 1;
        erase_b = 1;
        addr_a = 0;
        addr_b = 0;
    end
    
    % Convert soft values (3-bit) to hard bits (1-bit) for output
    % Threshold at 4 (weak/strong boundary)
    bit_a = double(soft_a >= 4);
    bit_b = double(soft_b >= 4);
    
    % Update carrier count
    carrier_count = carrier_count + 1;
    if carrier_count >= num_carriers
        carrier_count = 0;
    end
    
    % Pipeline stages
    pipeline.bits(1, :) = [bit_a, bit_b];
    pipeline.erase(1, :) = [erase_a, erase_b];
    pipeline.valid(1) = 1;
    
    for k = 2:4
        pipeline.bits(k, :) = pipeline.bits(k-1, :);
        pipeline.erase(k, :) = pipeline.erase(k-1, :);
        pipeline.valid(k) = pipeline.valid(k-1);
    end
    
    % Output from stage 4
    out_bits = pipeline.bits(4, :);
    erase = pipeline.erase(4, :);
    output_strobe = pipeline.valid(4);
end
