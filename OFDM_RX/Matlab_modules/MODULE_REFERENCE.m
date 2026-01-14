% MATLAB Validation Modules - Quick Reference Guide
% Generated for OpenOFDM Verilog Project
% Date: January 2026

%% ========================================================================
%% PART 1: FFT AND PHASE ROTATION (7 modules)
%% Location: matlab_validation/part1_phase_rotation/
%% ========================================================================

%% 1. delayT.m - Shift Register Delay Line
% Implements: Parameterizable delay (shift register)
% Pipeline: Configurable (DELAY parameter)
% Verilog: delayT.v
state = zeros(1, DELAY);
[data_out, state] = delayT(data_in, state, DELAY);

%% 2. complex_mult.m - Complex Multiplication
% Implements: (a_i + j*a_q) * (b_i + j*b_q)
% Pipeline: 5 clock cycles
% Verilog: complex_mult.v
state = complex_mult_init();
[p_i, p_q, state] = complex_mult(a_i, a_q, b_i, b_q, state);

%% 3. divider.m - Integer Division
% Implements: quotient = dividend / divisor
% Pipeline: 36 clock cycles
% Verilog: divider.v
state = divider_init();
[quotient, state] = divider(dividend, divisor, state);

%% 4. atan_lut.m - Arctangent Lookup Table (ROM)
% Returns: arctan(x) for x in [0,1], scaled by 512
% Size: 256 entries
% Verilog: atan_lut ROM
atan_data = atan_lut(atan_addr); % addr: 0-255

%% 5. rot_lut.m - Rotation Lookup Table (ROM)
% Returns: [cos(θ), sin(θ)] for θ in [0, π/4], scaled by 2048
% Size: 512 entries
% Verilog: rot_lut ROM
rot_data = rot_lut(rot_addr); % addr: 0-511

%% 6. phase.m - Phase Angle Calculation
% Implements: atan2(Q, I) using CORDIC-like algorithm
% Pipeline: 40 clock cycles
% Output: Phase in range [-π, π] scaled by 512
% Verilog: phase.v
state = phase_init();
[phase_angle, state] = phase(in_i, in_q, state);

%% 7. rotate.m - Complex Sample Rotation
% Implements: out = in * e^(j*phase)
% Pipeline: 8 clock cycles
% Verilog: rotate.v
state = rotate_init();
[out_i, out_q, state] = rotate(in_i, in_q, phase_angle, state);


%% ========================================================================
%% PART 2: EQUALIZER - CSI AND NOISE ESTIMATION (3 modules)
%% Location: matlab_validation/part2_equalizer/
%% ========================================================================

%% 8. calc_mean.m - Signed Mean Calculator
% Implements: c = sign ? -(a/2 + b/2) : (a/2 + b/2)
% Pipeline: 3 clock cycles
% Used for: Averaging two LTS symbols
% Verilog: calc_mean.v
state = calc_mean_init();
[mean_val, state] = calc_mean(val_a, val_b, sign_flag, state);

%% 9. ram_2port.m - Dual-Port RAM
% Implements: Dual-port RAM with registered outputs
% Latency: 1 cycle read
% Verilog: ram_2port.v

% Initialize
ram = ram_2port_init(64, 2); % 64 words, 2 columns (I,Q)

% Write
ram = ram_2port_write(addr, data, ram);

% Read
[data_out, ram] = ram_2port_read(addr, ram);

%% 10. equalizer.m - Complete OFDM Equalizer
% Implements: CSI estimation, CFO correction, Zero-Forcing equalization
% States: 6 (FIRST_LTS, SECOND_LTS, GET_POLARITY, CALC_FREQ_OFFSET, 
%            ADJUST_FREQ_OFFSET, HT_LTS)
% Verilog: equalizer.v
state = equalizer_init();
[equalized_sample, state] = equalizer(sample_in, strobe, ht_next, state);


%% ========================================================================
%% PART 3: SIGNAL AND HT-SIG DECODE (6 modules)
%% Location: matlab_validation/part3_signal_decode/
%% ========================================================================

%% 11. ht_sig_crc.m - CRC-8 for HT-SIG
% Implements: CRC-8 with polynomial x^8+x^7+x^4+x^3+x^2+1
% Used for: HT-SIG field validation
% Verilog: ht_sig_crc.v
state = ht_sig_crc_init();
for i = 1:num_bits
    [crc_val, state] = ht_sig_crc(bit, state);
end

%% 12. crc32.m - CRC-32 for Frame Check Sequence
% Implements: IEEE 802.11 CRC-32
% Expected FCS: 0xC704DD7B
% Verilog: crc32.v
state = crc32_init();
for i = 1:length(packet_bytes)
    [fcs, state] = crc32(packet_bytes(i), state);
end

%% 13. signal_decode.m - SIGNAL Field Decoder
% Decodes: 24-bit SIGNAL field (Legacy 802.11a/g/n)
% Validates: Parity, reserved bit, tail bits
% Returns: Rate, Length, HT detection flag
% Verilog: dot11.v (S_CHECK_SIGNAL state)
[valid, fields, is_ht] = signal_decode(signal_bits);

%% 14. ht_detect.m - HT Format Detection
% Detects: HT vs Legacy format by analyzing Q-BPSK rotation
% Algorithm: Count |Q| > |I| vs |I| > |Q|
% Threshold: rot_count >= 4 → HT, normal_count > 4 → Legacy
% Verilog: dot11.v (S_DETECT_HT state)
is_ht = ht_detect(equalized_samples);

%% 15. qbpsk_derotate.m - Q-BPSK to BPSK Conversion
% Rotates: Q-BPSK samples by -90° to convert to BPSK
% Transform: [I', Q'] = [Q, -I]
% Used for: HT-SIG decoding
% Verilog: dot11.v (S_HT_SIGNAL state)
rotated_samples = qbpsk_derotate(qbpsk_samples);

%% 16. ht_sig_decode.m - HT-SIG Field Decoder
% Decodes: 48-bit HT-SIG field (two 24-bit symbols)
% Validates: CRC-8, MCS, bandwidth, STBC, FEC, GI, tail
% Returns: MCS, length, coding parameters
% Verilog: dot11.v (S_CHECK_HT_SIG_CRC, S_CHECK_HT_SIG states)
[valid, ht_fields, crc_ok] = ht_sig_decode(ht_sig1, ht_sig2);


%% ========================================================================
%% COMPLETE WORKFLOW EXAMPLE
%% ========================================================================

%% Example: Process one OFDM packet from LTS to data decoding

% 1. Initialize all modules
eq_state = equalizer_init();
phase_state = phase_init();
rotate_state = rotate_init();

% 2. Process LTS symbols (channel estimation)
for i = 1:128  % Two LTS symbols, 64 samples each
    [~, eq_state] = equalizer(lts_samples(:,i), 1, 0, eq_state);
end

% 3. Process SIGNAL symbol (get equalized output)
signal_samples = zeros(48, 1); % 48 data subcarriers
for i = 1:64  % Full OFDM symbol
    [eq_out, eq_state] = equalizer(signal_input(:,i), 1, 0, eq_state);
    if ~isempty(eq_out)
        signal_samples(sample_idx) = eq_out;
        sample_idx = sample_idx + 1;
    end
end

% 4. Demodulate SIGNAL (BPSK, not shown here)
signal_bits = demodulate_bpsk(signal_samples); % Your demodulator

% 5. Decode and validate SIGNAL
[valid, sig_fields, is_ht_possible] = signal_decode(signal_bits);

if is_ht_possible
    % 6. Get samples for HT detection
    ht_detect_samples = zeros(10, 2); % First 10 samples
    for i = 1:10
        [eq_out, eq_state] = equalizer(next_symbol(:,i), 1, 0, eq_state);
        ht_detect_samples(i,:) = eq_out;
    end
    
    % 7. Detect HT format
    is_ht = ht_detect(ht_detect_samples);
    
    if is_ht
        % 8. Get HT-SIG symbols (Q-BPSK, 2 symbols)
        ht_sig_samples = collect_ht_sig_symbols(eq_state); % Your function
        
        % 9. Derotate Q-BPSK to BPSK
        ht_sig_bpsk = qbpsk_derotate(ht_sig_samples);
        
        % 10. Demodulate HT-SIG
        ht_sig_bits = demodulate_bpsk(ht_sig_bpsk); % Your demodulator
        ht_sig1 = ht_sig_bits(1:24);
        ht_sig2 = ht_sig_bits(25:48);
        
        % 11. Decode and validate HT-SIG
        [valid, ht_fields, crc_ok] = ht_sig_decode(ht_sig1, ht_sig2);
        
        fprintf('MCS: %d, Length: %d bytes\n', ht_fields.mcs, ht_fields.ht_length);
    end
end

% 12. Continue with data decoding...


%% ========================================================================
%% TESTING TEMPLATES
%% ========================================================================

%% Unit Test Template
function test_module()
    % Load test vectors
    test_data = load('test_vectors.mat');
    
    % Initialize module
    state = module_init();
    
    % Test each case
    pass_count = 0;
    for i = 1:length(test_data.inputs)
        [output, state] = module_function(test_data.inputs(i), state);
        
        if abs(output - test_data.expected(i)) < tolerance
            pass_count = pass_count + 1;
        else
            fprintf('Test %d failed: expected %f, got %f\n', ...
                    i, test_data.expected(i), output);
        end
    end
    
    fprintf('Passed %d/%d tests\n', pass_count, length(test_data.inputs));
end

%% Integration Test Template
function test_integration()
    % Test phase + rotate pipeline
    phase_state = phase_init();
    rotate_state = rotate_init();
    
    % Generate test signal with known phase offset
    phase_offset = 0.5; % radians
    num_samples = 100;
    
    for i = 1:num_samples
        % Create rotated sample
        original_i = randi([-100, 100]);
        original_q = randi([-100, 100]);
        
        % Apply known rotation
        rotated_i = original_i * cos(phase_offset) - original_q * sin(phase_offset);
        rotated_q = original_i * sin(phase_offset) + original_q * cos(phase_offset);
        
        % Estimate phase
        [est_phase, phase_state] = phase(rotated_i, rotated_q, phase_state);
        
        % Correct rotation
        [corrected_i, corrected_q, rotate_state] = ...
            rotate(rotated_i, rotated_q, -est_phase, rotate_state);
        
        % Verify correction (after pipeline fills)
        if i > 48 % After pipeline delay
            error_i = abs(corrected_i - original_i);
            error_q = abs(corrected_q - original_q);
            assert(error_i < 5 && error_q < 5);
        end
    end
    
    fprintf('Integration test passed\n');
end


%% ========================================================================
%% MODULE DEPENDENCY GRAPH
%% ========================================================================

% delayT (standalone)
% complex_mult → delayT
% divider → delayT
% atan_lut (standalone ROM)
% rot_lut (standalone ROM)
% phase → divider, atan_lut, delayT
% rotate → rot_lut, complex_mult, delayT
% 
% calc_mean (standalone)
% ram_2port (standalone)
% equalizer → calc_mean, ram_2port, phase, rotate, complex_mult, divider
%
% ht_sig_crc (standalone)
% crc32 (standalone)
% signal_decode (standalone)
% ht_detect (standalone)
% qbpsk_derotate (standalone)
% ht_sig_decode → ht_sig_crc


%% ========================================================================
%% KEY CONSTANTS
%% ========================================================================

ATAN_LUT_SCALE_SHIFT = 9;      % Phase scaled by 2^9 = 512
ROTATE_LUT_SCALE_SHIFT = 11;   % Rotation values scaled by 2^11 = 2048
CONS_SCALE_SHIFT = 10;          % Constellation scaled by 2^10 = 1024

PI_SCALED = 1608;               % π * 512
PI_2_SCALED = 804;              % π/2 * 512
PI_4_SCALED = 402;              % π/4 * 512

EXPECTED_FCS = hex2dec('C704DD7B'); % Correct FCS value

% Subcarrier masks (64-bit)
SUBCARRIER_MASK = hex2dec('FFFFFFF807FFFFFE');     % Legacy 52 carriers
HT_SUBCARRIER_MASK = hex2dec('FFFFFFFFC3FFFFFE'); % HT 56 carriers
PILOT_MASK = hex2dec('0200002000002008');          % 4 pilot carriers
DATA_MASK = bitxor(SUBCARRIER_MASK, PILOT_MASK);   % 48 data carriers
HT_DATA_MASK = bitxor(HT_SUBCARRIER_MASK, PILOT_MASK); % 52 data carriers


%% ========================================================================
%% PERFORMANCE NOTES
%% ========================================================================

% Pipeline Latencies (clock cycles):
% - phase: 40 cycles
% - rotate: 8 cycles
% - complex_mult: 5 cycles
% - divider: 36 cycles
% - calc_mean: 3 cycles
% - equalizer per symbol: ~150-200 cycles (varies by state)
%
% Memory Requirements:
% - equalizer LTS RAM: 64 words × 32 bits = 256 bytes
% - equalizer input buffer: 64 words × 32 bits = 256 bytes
% - atan_lut ROM: 256 words × 9 bits = 288 bytes
% - rot_lut ROM: 512 words × 32 bits = 2048 bytes
