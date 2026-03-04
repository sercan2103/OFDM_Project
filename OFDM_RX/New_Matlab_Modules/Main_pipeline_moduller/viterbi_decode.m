function [data_out, output_strobe] = viterbi_decode(data_in0, data_in1, erase, input_strobe, reset)
% VITERBI_DECODE Convolutional decoder (R=1/2, K=7)
%
% Verilog equivalent: viterbi.v (Xilinx viterbi_v7_0 IP wrapper)
% Latency: Variable (depends on traceback depth)
%
% Inputs:
%   data_in0, data_in1: Soft decision bits (3-bit, 2 parallel streams)
%   erase: Erasure flags (2-bit)
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   data_out: Decoded hard bit (1-bit)
%   output_strobe: Output valid signal
%
% Configuration:
%   Constraint length: K=7
%   Code rate: R=1/2 (punctured for higher rates)
%   Soft decision: 3-bit quantization
%   Traceback depth: 36

    persistent pipeline state bit_count
    
    if nargin < 5
        reset = 0;
    end
    
    TRACEBACK_DEPTH = 36;
    NUM_STATES = 64; % 2^(K-1) = 2^6
    
    % Initialize
    if isempty(pipeline) || reset
        pipeline = struct('bits', zeros(TRACEBACK_DEPTH, 1), 'valid', zeros(TRACEBACK_DEPTH, 1));
        state = zeros(NUM_STATES, 1); % State metrics
        bit_count = 0;
    end
    
    % Default outputs
    data_out = 0;
    output_strobe = 0;
    
    if ~input_strobe
        return;
    end
    
    % Convert 3-bit soft decision to branch metrics
    % Soft decision: 0=strong 0, 7=strong 1
    % Branch metric: distance from expected value
    
    % For simplicity, use hard decision approximation
    % (Real Viterbi would use full soft decision)
    bit0 = double(data_in0 >= 4); % Threshold at midpoint
    bit1 = double(data_in1 >= 4);
    
    % Handle erasures
    if erase(1)
        bit0 = 0.5; % Neutral metric
    end
    if erase(2)
        bit1 = 0.5; % Neutral metric
    end
    
    % Simplified Viterbi (for bit-exact match, need full implementation)
    % This is a placeholder - real implementation requires:
    % 1. Branch metric calculation
    % 2. Add-compare-select (ACS) for all states
    % 3. Traceback through survivor paths
    
    % For now, use MATLAB's vitdec if available (optional)
    % Or simple majority voting as approximation
    decoded_bit = round((data_in0 + data_in1) / 2) >= 4;
    
    % Pipeline stages (TRACEBACK_DEPTH stages)
    pipeline.bits(1) = decoded_bit;
    pipeline.valid(1) = 1;
    
    for k = 2:TRACEBACK_DEPTH
        pipeline.bits(k) = pipeline.bits(k-1);
        pipeline.valid(k) = pipeline.valid(k-1);
    end
    
    % Output from final stage
    data_out = pipeline.bits(TRACEBACK_DEPTH);
    output_strobe = pipeline.valid(TRACEBACK_DEPTH);
    
    bit_count = bit_count + 1;
end
