function [out_i, out_q, output_strobe] = rotate(in_i, in_q, phase_in, input_strobe, reset)
% ROTATE Complex rotation by angle theta
%
% Verilog equivalent: rotate.v
% Latency: 8 cycles
%
% Inputs:
%   in_i, in_q: Input complex number (16-bit signed, Q0.15)
%   phase_in: Rotation angle (32-bit, units of π/512)
%   input_strobe: Valid signal
%   reset: Reset signal (optional)
%
% Outputs:
%   out_i, out_q: Rotated output (16-bit signed, Q0.15)
%   output_strobe: Output valid signal
%
% Formula:
%   out = in * e^(j*theta)
%   out_i = in_i * cos(theta) - in_q * sin(theta)
%   out_q = in_i * sin(theta) + in_q * cos(theta)

    persistent pipeline rot_lut
    
    if nargin < 5
        reset = 0;
    end
    
    % Load ROT LUT on first call
    if isempty(rot_lut)
        [rot_cos, rot_sin] = load_rot_lut();
        rot_lut = struct('cos', rot_cos, 'sin', rot_sin);
    end
    
    % Initialize pipeline (8 stages)
    if isempty(pipeline) || reset
        pipeline = struct(...
            'out_i', zeros(8,1), ...
            'out_q', zeros(8,1), ...
            'valid', zeros(8,1));
    end
    
    % Cycle 0-2: Phase normalization to [0, π/4] using quadrant folding
    PI = 1608; % π scaled by 512
    PI_2 = PI / 2;
    PI_4 = PI / 4;
    
    phase = phase_in;
    
    % Normalize to [-π, π]
    while phase > PI
        phase = phase - 2*PI;
    end
    while phase < -PI
        phase = phase + 2*PI;
    end
    
    % Quadrant folding to [0, π/4]
    phase_abs = abs(phase);
    
    % Determine quadrant for later adjustment
    if phase_abs <= PI_4
        % [0, π/4]
        lut_phase = phase_abs;
        quadrant = 0;
    elseif phase_abs <= PI_2
        % [π/4, π/2] -> fold to [0, π/4]
        lut_phase = PI_2 - phase_abs;
        quadrant = 1;
    else
        % [π/2, π] -> fold to [0, π/4]
        lut_phase = phase_abs - PI_2;
        quadrant = 2;
    end
    
    % Handle sign
    if phase < 0
        negate = 1;
    else
        negate = 0;
    end
    
    % Cycle 3: ROT LUT lookup
    % LUT has 512 entries for [0, π/4]
    % LUT address = (phase / (π/4)) * 512 = phase * 512 / (π/4)
    % Since phase is already in units of π/512: phase * 512 / (π/4) = phase * 2
    lut_idx = min(511, max(0, floor(double(lut_phase) * 2)));
    
    cos_val = rot_lut.cos(lut_idx + 1); % MATLAB 1-indexed
    sin_val = rot_lut.sin(lut_idx + 1);
    
    % Cycle 4-5: Sign adjustment based on quadrant
    if quadrant == 1
        % Swap cos and sin
        temp = cos_val;
        cos_val = sin_val;
        sin_val = temp;
    elseif quadrant == 2
        % Swap and negate cos
        temp = cos_val;
        cos_val = -sin_val;
        sin_val = temp;
    end
    
    if negate
        sin_val = -sin_val;
    end
    
    % Cycle 6: Complex multiply
    % out = in * (cos + j*sin)
    % Scaling: cos and sin are Q0.11 (scaled by 2048)
    %          in is Q0.15
    %          Result needs to be scaled back
    
    in_i_32 = int32(in_i);
    in_q_32 = int32(in_q);
    cos_32 = int32(cos_val);
    sin_32 = int32(sin_val);
    
    % Complex multiply
    out_i_calc = in_i_32 * cos_32 - in_q_32 * sin_32;
    out_q_calc = in_i_32 * sin_32 + in_q_32 * cos_32;
    
    % Cycle 7: Scale back (divide by 2048 = right shift 11)
    % cos/sin are scaled by 2048 (Q0.11)
    out_i_scaled = int16(floor(double(out_i_calc) / 2048));
    out_q_scaled = int16(floor(double(out_q_calc) / 2048));
    
    % Saturate to 16-bit
    out_i_scaled = max(-32768, min(32767, out_i_scaled));
    out_q_scaled = max(-32768, min(32767, out_q_scaled));
    
    % Pipeline stages
    pipeline.out_i(1) = out_i_scaled;
    pipeline.out_q(1) = out_q_scaled;
    pipeline.valid(1) = input_strobe;
    
    for k = 2:8
        pipeline.out_i(k) = pipeline.out_i(k-1);
        pipeline.out_q(k) = pipeline.out_q(k-1);
        pipeline.valid(k) = pipeline.valid(k-1);
    end
    
    % Output from stage 8
    out_i = pipeline.out_i(8);
    out_q = pipeline.out_q(8);
    output_strobe = pipeline.valid(8);
end
