function result = test_stage7_viterbi(soft_bits, params, expected)
% TEST_STAGE7_VITERBI - Test viterbi_decode module
%
% Tests viterbi_decode.m for convolutional decoding
%
% Inputs:
%   soft_bits: Deinterleaved soft bits
%   params: Test parameters
%   expected: Expected outputs (optional)
%
% Outputs:
%   result.pass: Boolean test result
%   result.decoded_bits: Hard decoded bits
%   result.message: Test message

    result = struct();
    result.pass = false;
    result.message = '';
    
    fprintf('\n=== STAGE 7: Viterbi Decode ===\n');
    
    %% Initialize module
    addpath('../');
    
    %% Run viterbi decoder
    num_bits = length(soft_bits);
    fprintf('[Stage 7] Processing %d soft bits\n', num_bits);
    
    % Viterbi expects pairs (data_in0, data_in1) for rate 1/2
    if mod(num_bits, 2) ~= 0
        fprintf('[Stage 7] WARNING: Odd number of bits, padding with zero\n');
        soft_bits = [soft_bits; 0];
        num_bits = num_bits + 1;
    end
    
    num_pairs = num_bits / 2;
    
    % Initialize module state
    reset = true;  % Reset first
    erase = [false, false];  % No puncturing initially (2-element array for 2 streams)
    
    decoded_vec = [];
    decoded_out_strobe_vec = [];
    
    % Process soft bit pairs
    for n = 1:num_pairs
        data_in0 = soft_bits(2*n - 1);
        data_in1 = soft_bits(2*n);
        input_strobe = true;
        
        % Call viterbi_decode with correct signature
        try
            [decoded_bit, output_strobe] = ...
                viterbi_decode(data_in0, data_in1, erase, input_strobe, reset);
        catch ME
            fprintf('[Stage 7] ERROR in viterbi_decode call:\n');
            fprintf('[Stage 7] data_in0: %g (type: %s)\n', data_in0, class(data_in0));
            fprintf('[Stage 7] data_in1: %g (type: %s)\n', data_in1, class(data_in1));
            fprintf('[Stage 7] erase: %s (type: %s)\n', mat2str(erase), class(erase));
            fprintf('[Stage 7] Message: %s\n', ME.message);
            rethrow(ME);
        end
        
        reset = false;  % Only reset on first call
        
        % Store outputs
        if output_strobe
            decoded_vec = [decoded_vec; decoded_bit];
            decoded_out_strobe_vec = [decoded_out_strobe_vec; true];
        end
    end
    
    %% Validate result
    result.decoded_bits = decoded_vec;
    
    % Check if decoding produced outputs
    if ~isempty(decoded_vec)
        num_decoded = length(decoded_vec);
        fprintf('[Stage 7] Decoded bits: %d\n', num_decoded);
        
        % Validate decoded bits are binary
        unique_vals = unique(decoded_vec);
        if all(ismember(unique_vals, [0, 1]))
            fprintf('[Stage 7] All outputs are valid binary bits\n');
        else
            fprintf('[Stage 7] WARNING: Non-binary outputs detected\n');
        end
        
        % Expected: approximately half the input (rate 1/2 code)
        expected_decoded = num_pairs;  % Rate 1/2 → num_pairs output bits
        fprintf('[Stage 7] Expected ~%d decoded bits (rate 1/2)\n', expected_decoded);
        
        if num_decoded > 0
            result.pass = true;
            result.message = sprintf('PASS: Decoded %d bits from %d soft bits', ...
                                    num_decoded, num_bits);
        else
            result.pass = false;
            result.message = 'FAIL: No decoded bits';
        end
        
        % Calculate bit statistics
        bit_ones = sum(decoded_vec == 1);
        bit_zeros = sum(decoded_vec == 0);
        fprintf('[Stage 7] Bit statistics: %d ones, %d zeros (%.1f%% ones)\n', ...
                bit_ones, bit_zeros, 100*bit_ones/num_decoded);
        
        % Check against expected
        if nargin >= 3 && ~isempty(expected) && isfield(expected, 'decoded_bits')
            % Compare decoded bits
            min_len = min(length(result.decoded_bits), length(expected.decoded_bits));
            if min_len > 0
                bit_errors = sum(result.decoded_bits(1:min_len) ~= expected.decoded_bits(1:min_len));
                ber = bit_errors / min_len;
                
                fprintf('[Stage 7] BER vs expected: %.6f (%d / %d)\n', ...
                        ber, bit_errors, min_len);
                
                if ber < 0.001  % Less than 0.1% BER
                    fprintf('[Stage 7] Excellent match with expected\n');
                elseif ber < 0.05
                    fprintf('[Stage 7] Good match with expected\n');
                else
                    result.pass = false;
                    result.message = [result.message, sprintf(' | High BER: %.6f', ber)];
                end
            end
        end
    else
        result.pass = false;
        result.message = 'FAIL: No decoded bits';
    end
    
    %% Generate diagnostic plot
    if isfield(params, 'plot') && params.plot && ~isempty(result.decoded_bits)
        figure('Name', 'Stage 7: Viterbi Decode');
        
        subplot(2,2,1);
        plot(soft_bits(1:min(200, end)));
        title('Input Soft Bits (first 200)');
        xlabel('Bit Index');
        ylabel('Soft Value');
        grid on;
        
        subplot(2,2,2);
        plot(result.decoded_bits(1:min(100, end)), '.-');
        title('Decoded Hard Bits (first 100)');
        xlabel('Bit Index');
        ylabel('Bit Value');
        grid on;
        ylim([-0.5, 1.5]);
        
        subplot(2,2,3);
        histogram(soft_bits, 50);
        title('Input Soft Bit Distribution');
        xlabel('Soft Value');
        ylabel('Count');
        grid on;
        
        subplot(2,2,4);
        bar([sum(result.decoded_bits==0), sum(result.decoded_bits==1)]);
        set(gca, 'XTickLabel', {'0', '1'});
        title('Decoded Bit Distribution');
        xlabel('Bit Value');
        ylabel('Count');
        grid on;
    end
    
    fprintf('[Stage 7] Test complete: %s\n', result.message);
end
