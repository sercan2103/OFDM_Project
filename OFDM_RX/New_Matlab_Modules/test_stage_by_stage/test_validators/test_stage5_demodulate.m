function result = test_stage5_demodulate(equalized_i, equalized_q, modulation_type, params, expected)
% TEST_STAGE5_DEMODULATE - Test demodulate module
%
% Tests demodulate.m for soft-bit generation
%
% Inputs:
%   equalized_i, equalized_q: Equalized symbols (int16)
%   modulation_type: Modulation scheme (0=BPSK, 1=QPSK, 2=16QAM, 3=64QAM)
%   params: Test parameters
%   expected: Expected outputs (optional)
%
% Outputs:
%   result.pass: Boolean test result
%   result.soft_bits: Soft decision bits
%   result.bit_llr: Log-likelihood ratios
%   result.message: Test message

    result = struct();
    result.pass = false;
    result.message = '';
    
    fprintf('\n=== STAGE 5: Demodulate ===\n');
    
    %% Initialize module
    addpath('../');
    
    %% Run demodulate
    num_symbols = length(equalized_i);
    fprintf('[Stage 5] Processing %d equalized symbols\n', num_symbols);
    fprintf('[Stage 5] Modulation type: %d\n', modulation_type);
    
    % Map modulation type to rate encoding
    % Legacy rates (bit 7 = 0):
    %   BPSK:  0x0B (11 decimal)
    %   QPSK:  0x0A (10 decimal)
    %   16QAM: 0x09 (9 decimal)
    %   64QAM: 0x08 (8 decimal)
    rate_map = [0x0B, 0x0A, 0x09, 0x08];  % BPSK, QPSK, 16QAM, 64QAM
    rate = rate_map(modulation_type + 1);
    fprintf('[Stage 5] Rate encoding: 0x%02X\n', rate);
    
    % Initialize module state
    reset = true;  % Reset on first call
    
    soft_bits_vec = [];
    demod_out_strobe_vec = [];
    
    % Process equalized symbols (demodulate expects single symbol per call)
    for n = 1:num_symbols
        i_val = equalized_i(n);
        q_val = equalized_q(n);
        input_strobe = true;
        
        % Call demodulate with rate encoding (not modulation_type)
        [soft_bits, output_strobe] = ...
            demodulate(i_val, q_val, rate, input_strobe, reset);
        
        % Store outputs
        if output_strobe
            % soft_bits may be a vector for multi-bit modulations
            if isscalar(soft_bits)
                soft_bits_vec = [soft_bits_vec; soft_bits];
            else
                soft_bits_vec = [soft_bits_vec; soft_bits(:)];
            end
            demod_out_strobe_vec = [demod_out_strobe_vec; true];
        end
        
        reset = false;  % Only reset on first call
    end
    
    %% Validate result
    result.soft_bits = soft_bits_vec;
    
    % Check if demodulation produced outputs
    if ~isempty(soft_bits_vec)
        num_bits = length(soft_bits_vec);
        fprintf('[Stage 5] Soft bits: %d\n', num_bits);
        
        % Validate soft bits are in reasonable range
        % Soft bits typically range [0, 7] for confidence levels (3-bit)
        max_soft = max(abs(soft_bits_vec));
        min_soft = min(soft_bits_vec);
        fprintf('[Stage 5] Max soft bit magnitude: %d, Min: %d\n', max_soft, min_soft);
        
        % Check if we got valid soft bits (not all zeros)
        if max_soft > 0 && max_soft <= 7
            result.pass = true;
            result.message = sprintf('PASS: Generated %d soft bits, max=%d', ...
                                    num_bits, max_soft);
        else
            result.pass = false;
            result.message = sprintf('FAIL: Unusual soft bit range: max=%d', max_soft);
        end
        
        % Check expected number of bits per symbol
        bits_per_symbol_map = [1, 2, 4, 6];  % BPSK, QPSK, 16QAM, 64QAM
        if modulation_type >= 0 && modulation_type <= 3
            expected_bits = num_symbols * bits_per_symbol_map(modulation_type + 1);
            if num_bits == expected_bits
                fprintf('[Stage 5] Correct number of bits: %d\n', num_bits);
            else
                fprintf('[Stage 5] WARNING: Expected %d bits, got %d\n', ...
                        expected_bits, num_bits);
            end
        end
        
        % Calculate LLR statistics
        result.bit_llr = double(soft_bits_vec);
        avg_llr = mean(abs(result.bit_llr));
        std_llr = std(result.bit_llr);
        fprintf('[Stage 5] LLR statistics: mean=%.2f, std=%.2f\n', avg_llr, std_llr);
        
        % Check against expected
        if nargin >= 5 && ~isempty(expected) && isfield(expected, 'soft_bits')
            % Compare soft bits
            if length(result.soft_bits) == length(expected.soft_bits)
                % Count bit mismatches (after hard decision)
                hard_bits = sign(result.soft_bits);
                expected_hard = sign(expected.soft_bits);
                bit_errors = sum(hard_bits ~= expected_hard);
                ber = bit_errors / length(hard_bits);
                
                fprintf('[Stage 5] Hard decision BER: %.6f (%d / %d)\n', ...
                        ber, bit_errors, length(hard_bits));
                
                if ber < 0.01  % Less than 1% BER
                    fprintf('[Stage 5] Good match with expected\n');
                else
                    result.pass = false;
                    result.message = [result.message, sprintf(' | High BER: %.6f', ber)];
                end
            end
        end
    else
        result.pass = false;
        result.message = 'FAIL: No demodulated bits';
    end
    
    %% Generate diagnostic plot
    if isfield(params, 'plot') && params.plot && ~isempty(result.soft_bits)
        figure('Name', 'Stage 5: Demodulate');
        
        subplot(2,2,1);
        plot(result.soft_bits);
        title('Soft Bit Values');
        xlabel('Bit Index');
        ylabel('Soft Value');
        grid on;
        
        subplot(2,2,2);
        histogram(result.soft_bits, 50);
        title('Soft Bit Distribution');
        xlabel('Soft Value');
        ylabel('Count');
        grid on;
        
        subplot(2,2,3);
        hard_bits = double(sign(result.soft_bits) > 0);
        plot(hard_bits, '.-');
        title('Hard Decision Bits');
        xlabel('Bit Index');
        ylabel('Bit Value');
        grid on;
        ylim([-0.5, 1.5]);
        
        subplot(2,2,4);
        plot(abs(result.bit_llr));
        title('LLR Magnitude (Confidence)');
        xlabel('Bit Index');
        ylabel('|LLR|');
        grid on;
    end
    
    fprintf('[Stage 5] Test complete: %s\n', result.message);
end
