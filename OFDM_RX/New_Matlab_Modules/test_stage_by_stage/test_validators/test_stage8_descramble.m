function result = test_stage8_descramble(decoded_bits, params, expected)
% TEST_STAGE8_DESCRAMBLE - Test descramble module
%
% Tests descramble.m for data descrambling
%
% Inputs:
%   decoded_bits: Viterbi decoded bits
%   params: Test parameters
%   expected: Expected outputs (optional)
%
% Outputs:
%   result.pass: Boolean test result
%   result.descrambled: Descrambled bits
%   result.message: Test message

    result = struct();
    result.pass = false;
    result.message = '';
    
    fprintf('\n=== STAGE 8: Descramble ===\n');
    
    %% Initialize module
    addpath('../');
    
    %% Run descrambler
    num_bits = length(decoded_bits);
    fprintf('[Stage 8] Processing %d decoded bits\n', num_bits);
    
    % Initialize module state
    reset = true;  % Reset scrambler state
    
    descrambled_vec = [];
    descram_out_strobe_vec = [];
    
    % Process decoded bits
    for n = 1:num_bits
        in_bit = decoded_bits(n);
        input_strobe = true;
        
        % Call descramble with correct signature
        [descram_bit, output_strobe] = ...
            descramble(in_bit, input_strobe, reset);
        
        reset = false;  % Only reset on first call
        
        % Store outputs
        if output_strobe
            descrambled_vec = [descrambled_vec; descram_bit];
            descram_out_strobe_vec = [descram_out_strobe_vec; true];
        end
    end
    
    %% Validate result
    result.descrambled = descrambled_vec;
    
    % Check if descrambling produced outputs
    if ~isempty(descrambled_vec)
        num_descram = length(descrambled_vec);
        fprintf('[Stage 8] Descrambled bits: %d\n', num_descram);
        
        % Validate descrambled bits are binary
        unique_vals = unique(descrambled_vec);
        if all(ismember(unique_vals, [0, 1]))
            fprintf('[Stage 8] All outputs are valid binary bits\n');
            result.pass = true;
            result.message = sprintf('PASS: Descrambled %d bits', num_descram);
        else
            fprintf('[Stage 8] WARNING: Non-binary outputs detected\n');
            result.pass = false;
            result.message = 'FAIL: Non-binary outputs';
        end
        
        % Validate output count matches input count
        if num_descram == num_bits
            fprintf('[Stage 8] Bit count preserved: %d in, %d out\n', num_bits, num_descram);
        else
            fprintf('[Stage 8] WARNING: Bit count changed: %d in, %d out\n', ...
                    num_bits, num_descram);
        end
        
        % Calculate bit statistics
        bit_ones = sum(descrambled_vec == 1);
        bit_zeros = sum(descrambled_vec == 0);
        fprintf('[Stage 8] Bit statistics: %d ones, %d zeros (%.1f%% ones)\n', ...
                bit_ones, bit_zeros, 100*bit_ones/num_descram);
        
        % Check for SERVICE field (first 16 bits should be 0)
        if num_descram >= 16
            service_bits = descrambled_vec(1:16);
            service_zeros = sum(service_bits == 0);
            fprintf('[Stage 8] SERVICE field: %d/16 zeros\n', service_zeros);
            
            if service_zeros == 16
                fprintf('[Stage 8] SERVICE field correct (all zeros)\n');
            else
                fprintf('[Stage 8] WARNING: SERVICE field has non-zero bits\n');
            end
        end
        
        % Check against expected
        if nargin >= 3 && ~isempty(expected) && isfield(expected, 'descrambled')
            % Compare descrambled bits
            min_len = min(length(result.descrambled), length(expected.descrambled));
            if min_len > 0
                bit_errors = sum(result.descrambled(1:min_len) ~= expected.descrambled(1:min_len));
                ber = bit_errors / min_len;
                
                fprintf('[Stage 8] BER vs expected: %.6f (%d / %d)\n', ...
                        ber, bit_errors, min_len);
                
                if ber < 0.001  % Less than 0.1% BER
                    fprintf('[Stage 8] Excellent match with expected\n');
                elseif ber < 0.05
                    fprintf('[Stage 8] Good match with expected\n');
                else
                    result.pass = false;
                    result.message = [result.message, sprintf(' | High BER: %.6f', ber)];
                end
            end
        end
    else
        result.pass = false;
        result.message = 'FAIL: No descrambled bits';
    end
    
    %% Generate diagnostic plot
    if isfield(params, 'plot') && params.plot && ~isempty(result.descrambled)
        figure('Name', 'Stage 8: Descramble');
        
        subplot(2,2,1);
        plot(decoded_bits(1:min(200, end)), '.-');
        title('Input Decoded Bits (first 200)');
        xlabel('Bit Index');
        ylabel('Bit Value');
        grid on;
        ylim([-0.5, 1.5]);
        
        subplot(2,2,2);
        plot(result.descrambled(1:min(200, end)), '.-');
        title('Descrambled Bits (first 200)');
        xlabel('Bit Index');
        ylabel('Bit Value');
        grid on;
        ylim([-0.5, 1.5]);
        
        subplot(2,2,3);
        bar([sum(decoded_bits==0), sum(decoded_bits==1)]);
        set(gca, 'XTickLabel', {'0', '1'});
        title('Input Bit Distribution');
        xlabel('Bit Value');
        ylabel('Count');
        grid on;
        
        subplot(2,2,4);
        bar([sum(result.descrambled==0), sum(result.descrambled==1)]);
        set(gca, 'XTickLabel', {'0', '1'});
        title('Descrambled Bit Distribution');
        xlabel('Bit Value');
        ylabel('Count');
        grid on;
    end
    
    fprintf('[Stage 8] Test complete: %s\n', result.message);
end
