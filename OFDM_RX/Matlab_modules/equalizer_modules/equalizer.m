function [sample_out, state] = equalizer(sample_in, sample_in_strobe, ht_next, state)
% equalizer - OFDM Channel Equalizer with CSI Estimation
%
% Implements:
%   - Channel State Information (CSI) estimation using LTS
%   - Residual frequency offset correction using pilots
%   - Zero-forcing equalization
%   - Support for Legacy (48 carriers) and HT (52 carriers)
%
% Corresponds to equalizer.v
%
% INPUTS:
%   sample_in        - Complex input [I; Q] (16-bit each)
%   sample_in_strobe - Valid input flag
%   ht_next          - Switch to HT format flag
%   state            - Equalizer state structure
%
% OUTPUTS:
%   sample_out - Equalized output [I(16-bit); Q(16-bit)]
%   state      - Updated state structure
%
% STATES:
%   S_FIRST_LTS  (0) - Store first LTS
%   S_SECOND_LTS (1) - Average two LTS to get CSI
%   S_GET_POLARITY(2)- Prepare pilot polarity sequence
%   S_CALC_FREQ_OFFSET(3) - Calculate residual CFO from pilots
%   S_ADJUST_FREQ_OFFSET(4) - Apply CFO correction and equalization
%   S_HT_LTS (5) - Process HT-LTS
%
% USAGE:
%   % Initialize
%   state = equalizer_init();
%   % Process LTS and data symbols
%   [out, state] = equalizer(in_sample, strobe, ht_flag, state);

if nargin < 4
    state = equalizer_init();
end

% Constants
S_FIRST_LTS = 0;
S_SECOND_LTS = 1;
S_GET_POLARITY = 2;
S_CALC_FREQ_OFFSET = 3;
S_ADJUST_FREQ_OFFSET = 4;
S_HT_LTS = 5;

% Masks (64-bit, LSB = subcarrier 0)
SUBCARRIER_MASK = hex2dec('FFFFFFF807FFFFFE');
HT_SUBCARRIER_MASK = hex2dec('FFFFFFFFC3FFFFFE');
PILOT_MASK = hex2dec('0200002000002008');
DATA_SUBCARRIER_MASK = bitxor(SUBCARRIER_MASK, PILOT_MASK);
HT_DATA_SUBCARRIER_MASK = bitxor(HT_SUBCARRIER_MASK, PILOT_MASK);

% Reference patterns
LTS_REF = hex2dec('000A66000A60026C');
HT_LTS_REF = hex2dec('000A66001863026C');

% 127-bit polarity sequence (stored as string for easy rotation)
POLARITY_BITS = '1111111000111011000101001011111010101000010110111100111001010110011000001101101011101000110010001000000100100110100111101110000';
HT_POLARITY = '1000'; % 4-bit HT polarity

% Output
sample_out = [0; 0];

% Main state machine
switch state.eq_state
    case S_FIRST_LTS
        % Store first LTS symbol
        if sample_in_strobe
            state.lts_ram = ram_2port_write(state.lts_waddr, double(sample_in'), state.lts_ram);
            state.lts_waddr = state.lts_waddr + 1;
            
            if state.lts_waddr >= 64
                state.lts_waddr = 0;
                state.lts_raddr = 0;
                state.eq_state = S_SECOND_LTS;
            end
        end
        
    case S_SECOND_LTS
        % Average two LTS symbols to estimate CSI
        if sample_in_strobe
            % Read first LTS
            [lts_out, state.lts_ram] = ram_2port_read(state.lts_raddr, state.lts_ram);
            lts_i_out = int16(lts_out(1));
            lts_q_out = int16(lts_out(2));
            
            % Get reference sign
            lts_ref_bit = bitand(bitshift(LTS_REF, -state.lts_raddr), 1);
            
            % Calculate mean with sign
            [new_lts_i, state.calc_mean_i_state] = calc_mean(lts_i_out, sample_in(1), lts_ref_bit, state.calc_mean_i_state);
            [new_lts_q, state.calc_mean_q_state] = calc_mean(lts_q_out, sample_in(2), lts_ref_bit, state.calc_mean_q_state);
            
            % Write averaged LTS back
            state.lts_ram = ram_2port_write(state.lts_waddr, double([new_lts_i, new_lts_q]), state.lts_ram);
            
            state.lts_raddr = state.lts_raddr + 1;
            state.lts_waddr = state.lts_waddr + 1;
            
            if state.lts_waddr >= 64
                state.lts_waddr = 0;
                state.eq_state = S_GET_POLARITY;
            end
        end
        
    case S_GET_POLARITY
        % Prepare pilot polarity for next symbol
        % Rotate polarity sequence
        state.polarity_idx = mod(state.polarity_idx + 1, 127);
        pol_bit = state.POLARITY_BITS(state.polarity_idx + 1) - '0';
        
        if state.ht
            % HT polarity (simplified - actual implementation more complex)
            state.current_polarity = state.HT_POLARITY;
        else
            % Legacy: pilots at -21,-7,7,21 all use same polarity
            state.current_polarity = repmat(pol_bit, 1, 4);
        end
        
        state.pilot_sum_i = 0;
        state.pilot_sum_q = 0;
        state.pilot_count = 0;
        state.in_waddr = 0;
        state.in_raddr = 0;
        state.lts_raddr = 0;
        state.pilot_mask_rot = 0;
        state.eq_state = S_CALC_FREQ_OFFSET;
        
    case S_CALC_FREQ_OFFSET
        % Calculate residual frequency offset using pilots
        if ht_next && ~state.ht
            % Switch to HT mode
            state.ht = 1;
            state.num_data_carrier = 52;
            state.data_subcarrier_mask = HT_DATA_SUBCARRIER_MASK;
            state.lts_waddr = 0;
            state.lts_ref = HT_LTS_REF;
            state.eq_state = S_HT_LTS;
            return;
        end
        
        if sample_in_strobe
            % Store input in buffer
            state.in_buf = ram_2port_write(state.in_waddr, double(sample_in'), state.in_buf);
            state.in_waddr = state.in_waddr + 1;
            
            % Check if this is a pilot subcarrier
            pilot_bit = bitand(bitshift(PILOT_MASK, -state.pilot_mask_rot), 1);
            state.pilot_mask_rot = state.pilot_mask_rot + 1;
            
            if pilot_bit
                % This is a pilot subcarrier
                state.pilot_count = state.pilot_count + 1;
                
                % Get expected pilot (conjugate)
                pol_idx = mod(state.pilot_count - 1, 4) + 1;
                if state.current_polarity(pol_idx) == 0
                    pilot_i = sample_in(1);
                    pilot_q = -sample_in(2);
                else
                    pilot_i = -sample_in(1);
                    pilot_q = sample_in(2);
                end
                
                % Get LTS for this pilot
                [lts_out, state.lts_ram] = ram_2port_read(state.lts_raddr, state.lts_ram);
                
                % Multiply pilot * conj(LTS) (simplified)
                state.pilot_sum_i = state.pilot_sum_i + pilot_i * lts_out(1) + pilot_q * lts_out(2);
                state.pilot_sum_q = state.pilot_sum_q + pilot_i * lts_out(2) - pilot_q * lts_out(1);
                
                if state.pilot_count >= 4
                    % Calculate phase
                    [state.pilot_phase, state.phase_state] = phase(state.pilot_sum_i, state.pilot_sum_q, state.phase_state);
                    state.in_raddr = 0;
                    state.lts_raddr = 0;
                    state.num_output = 0;
                    state.data_mask_rot = 0;
                    state.eq_state = S_ADJUST_FREQ_OFFSET;
                end
            end
            state.lts_raddr = state.lts_raddr + 1;
        end
        
    case S_ADJUST_FREQ_OFFSET
        % Rotate and equalize data subcarriers
        if state.in_raddr < 64
            % Read buffered input
            [in_data, state.in_buf] = ram_2port_read(state.in_raddr, state.in_buf);
            
            % Rotate to compensate CFO
            [rot_i, rot_q, state.rotate_state] = rotate(in_data(1), in_data(2), state.pilot_phase, state.rotate_state);
            
            % Read LTS (CSI)
            [lts_out, state.lts_ram] = ram_2port_read(state.lts_raddr, state.lts_ram);
            
            % Equalize: rotated * conj(LTS) / |LTS|^2
            [prod_i, prod_q, state.mult_state] = complex_mult(rot_i, rot_q, lts_out(1), -lts_out(2), state.mult_state);
            mag_sq = lts_out(1)^2 + lts_out(2)^2;
            
            if mag_sq > 0
                % Scale and divide
                CONS_SCALE_SHIFT = 10;
                [norm_i, state.div_i_state] = divider(bitshift(prod_i, CONS_SCALE_SHIFT), mag_sq, state.div_i_state);
                [norm_q, state.div_q_state] = divider(bitshift(prod_q, CONS_SCALE_SHIFT), mag_sq, state.div_q_state);
                
                % Check if data subcarrier
                data_bit = bitand(bitshift(state.data_subcarrier_mask, -state.data_mask_rot), 1);
                if data_bit
                    sample_out = [int16(norm_i); int16(norm_q)];
                    state.num_output = state.num_output + 1;
                end
            end
            
            state.in_raddr = state.in_raddr + 1;
            state.lts_raddr = state.lts_raddr + 1;
            state.data_mask_rot = state.data_mask_rot + 1;
        end
        
        if state.num_output >= state.num_data_carrier
            state.eq_state = S_GET_POLARITY;
        end
        
    case S_HT_LTS
        % Process HT-LTS
        if sample_in_strobe
            ht_lts_bit = bitand(bitshift(state.lts_ref, -state.lts_waddr), 1);
            if ht_lts_bit == 0
                lts_data = sample_in';
            else
                lts_data = -sample_in';
            end
            
            state.lts_ram = ram_2port_write(state.lts_waddr, double(lts_data), state.lts_ram);
            state.lts_waddr = state.lts_waddr + 1;
            
            if state.lts_waddr >= 64
                state.lts_waddr = 0;
                state.lts_raddr = 0;
                state.eq_state = S_GET_POLARITY;
            end
        end
end

end

function state = equalizer_init()
% Initialize equalizer state
    state = struct();
    state.eq_state = 0; % S_FIRST_LTS
    state.ht = 0;
    state.num_data_carrier = 48;
    state.data_subcarrier_mask = bitxor(hex2dec('FFFFFFF807FFFFFE'), hex2dec('0200002000002008'));
    
    % RAM
    state.lts_ram = ram_2port_init(64, 2); % 64 words, I+Q
    state.in_buf = ram_2port_init(64, 2);
    
    % Addresses
    state.lts_waddr = 0;
    state.lts_raddr = 0;
    state.in_waddr = 0;
    state.in_raddr = 0;
    
    % Reference patterns
    state.lts_ref = hex2dec('000A66000A60026C');
    state.POLARITY_BITS = '1111111000111011000101001011111010101000010110111100111001010110011000001101101011101000110010001000000100100110100111101110000';
    state.HT_POLARITY = '1000';
    state.polarity_idx = 0;
    state.current_polarity = [0 0 0 0];
    
    % Pilots
    state.pilot_sum_i = 0;
    state.pilot_sum_q = 0;
    state.pilot_count = 0;
    state.pilot_phase = 0;
    state.pilot_mask_rot = 0;
    
    % Output
    state.num_output = 0;
    state.data_mask_rot = 0;
    
    % Sub-module states
    state.calc_mean_i_state = calc_mean_init();
    state.calc_mean_q_state = calc_mean_init();
    state.phase_state = phase_init();
    state.rotate_state = rotate_init();
    state.mult_state = complex_mult_init();
    state.div_i_state = divider_init();
    state.div_q_state = divider_init();
end

% Helper initialization functions
function state = calc_mean_init()
    state = struct(); state.pipeline = zeros(3, 3);
end
function state = phase_init()
    state = struct(); state.div_state.pipeline = zeros(36, 1); state.pipeline = zeros(40, 4);
end
function state = rotate_init()
    state = struct(); state.mult_state.pipeline = zeros(5, 2); state.in_delay = zeros(4, 2); state.phase_pipeline = zeros(4, 3);
end
function state = complex_mult_init()
    state = struct(); state.pipeline = zeros(5, 2);
end
function state = divider_init()
    state = struct(); state.pipeline = zeros(36, 1);
end
function ram = ram_2port_init(depth, width)
    ram = zeros(depth, width);
end
function ram = ram_2port_write(addr, data, ram)
    addr = mod(floor(addr), size(ram, 1)) + 1;
    ram(addr, :) = data;
end
function [data_out, ram] = ram_2port_read(addr, ram)
    addr = mod(floor(addr), size(ram, 1)) + 1;
    data_out = ram(addr, :);
end
function [phase_out, state] = phase(in_i, in_q, state)
    % Simplified - use actual phase.m for full implementation
    phase_out = atan2(in_q, in_i) * 512;
end
function [out_i, out_q, state] = rotate(in_i, in_q, phase_in, state)
    % Simplified - use actual rotate.m for full implementation
    angle = double(phase_in) / 512;
    out_i = round(in_i * cos(angle) - in_q * sin(angle));
    out_q = round(in_i * sin(angle) + in_q * cos(angle));
end
function [p_i, p_q, state] = complex_mult(a_i, a_q, b_i, b_q, state)
    % Simplified
    p_i = a_i * b_i - a_q * b_q;
    p_q = a_i * b_q + a_q * b_i;
end
function [quotient, state] = divider(dividend, divisor, state)
    % Simplified
    if divisor == 0, quotient = 0; else, quotient = floor(dividend / divisor); end
end
