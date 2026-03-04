function [phase_out, output_strobe] = phase(in_i, in_q, input_strobe, reset)
% PHASE Calculate phase angle atan2(Q, I)
%
% Verilog equivalent: phase.v
% Latency: 40 cycles
%
% Inputs:
%   in_i: Real part (32-bit signed)
%   in_q: Imaginary part (32-bit signed)
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   phase_out: Phase angle (32-bit, scaled by 512, units of π/512)
%   output_strobe: Output valid signal
%
% Implementation:
%   1. Absolute value and quadrant detection (2 cycles)
%   2. Division (36 cycles)
%   3. ATAN LUT lookup (1 cycle)
%   4. Quadrant reconstruction (1 cycle)
%   Total: 40 cycles

    persistent pipeline atan_lut
    
    if nargin < 4
        reset = 0;
    end
    
    % Load ATAN LUT on first call
    if isempty(atan_lut)
        atan_lut = load_atan_lut();
    end
    
    % Initialize pipeline (40 stages)
    if isempty(pipeline) || reset
        pipeline = struct(...
            'abs_i', zeros(40,1), ...
            'abs_q', zeros(40,1), ...
            'quadrant', zeros(40,1), ...
            'ratio', zeros(40,1), ...
            'atan_val', zeros(40,1), ...
            'result', zeros(40,1), ...
            'valid', zeros(40,1));
    end
    
    % Cycle 0-1: Absolute value and quadrant detection
    abs_i = abs(in_i);
    abs_q = abs(in_q);
    
    % Quadrant encoding (3-bit)
    % bit[0]: sign of I
    % bit[1]: sign of Q  
    % bit[2]: |Q| > |I|
    quadrant = 0;
    if in_i < 0
        quadrant = bitset(quadrant, 1);
    end
    if in_q < 0
        quadrant = bitset(quadrant, 2);
    end
    if abs_q > abs_i
        quadrant = bitset(quadrant, 3);
    end
    
    % Cycle 2-37: Division (36 cycles)
    % Divide smaller by larger to get ratio in [0,1]
    if abs_i > abs_q && abs_i ~= 0
        ratio = double(abs_q) / double(abs_i);
    elseif abs_q ~= 0
        ratio = double(abs_i) / double(abs_q);
    else
        ratio = 0;
    end
    
    % Cycle 38: ATAN LUT lookup
    % LUT index: 0-255 for ratio 0-1
    lut_idx = min(255, max(0, floor(ratio * 256)));
    atan_val = atan_lut(lut_idx + 1); % MATLAB 1-indexed
    
    % Cycle 39: Quadrant reconstruction
    % Based on quadrant encoding, reconstruct full angle
    PI = 1608; % π scaled by 512
    PI_2 = PI / 2;
    
    % Decode quadrant
    sign_i = bitget(quadrant, 1);
    sign_q = bitget(quadrant, 2);
    swap = bitget(quadrant, 3);
    
    if swap
        % |Q| > |I|, so we computed atan(|I|/|Q|)
        phase_val = PI_2 - atan_val;
    else
        % |I| >= |Q|, so we computed atan(|Q|/|I|)
        phase_val = atan_val;
    end
    
    % Apply quadrant correction
    if sign_i && ~sign_q
        % Quadrant II
        phase_val = PI - phase_val;
    elseif sign_i && sign_q
        % Quadrant III
        phase_val = -PI + phase_val;
    elseif ~sign_i && sign_q
        % Quadrant IV
        phase_val = -phase_val;
    end
    % Quadrant I: no change
    
    % Pipeline all stages
    pipeline.abs_i(1) = abs_i;
    pipeline.abs_q(1) = abs_q;
    pipeline.quadrant(1) = quadrant;
    pipeline.ratio(1) = ratio;
    pipeline.atan_val(1) = atan_val;
    pipeline.result(1) = phase_val;
    pipeline.valid(1) = input_strobe;
    
    for k = 2:40
        pipeline.abs_i(k) = pipeline.abs_i(k-1);
        pipeline.abs_q(k) = pipeline.abs_q(k-1);
        pipeline.quadrant(k) = pipeline.quadrant(k-1);
        pipeline.ratio(k) = pipeline.ratio(k-1);
        pipeline.atan_val(k) = pipeline.atan_val(k-1);
        pipeline.result(k) = pipeline.result(k-1);
        pipeline.valid(k) = pipeline.valid(k-1);
    end
    
    % Output from stage 40
    phase_out = int32(pipeline.result(40));
    output_strobe = pipeline.valid(40);
end
