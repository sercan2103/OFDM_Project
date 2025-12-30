% Test script for dot11_punc_interlv

clear; clc;

% Add current directory to path
% Assuming the script is run from the directory containing the functions
% or the functions are in the path.

fprintf('Running tests for dot11_punc_interlv...\n');

% Define rates to test
% Format: {RateID, RateName, PktType, Expected_NDBPS, Expected_NCBPS}
test_cases = {
    11, '6 Mbps', 0, 24, 48;
    15, '9 Mbps', 0, 36, 48;
    10, '12 Mbps', 0, 48, 96;
    14, '18 Mbps', 0, 72, 96;
    9,  '24 Mbps', 0, 96, 192;
    13, '36 Mbps', 0, 144, 192;
    8,  '48 Mbps', 0, 192, 288;
    12, '54 Mbps', 0, 216, 288;
    16, 'MCS0', 1, 26, 52;
    23, 'MCS7', 1, 260, 312;
};

all_passed = true;

for i = 1:size(test_cases, 1)
    rate_id = test_cases{i, 1};
    rate_name = test_cases{i, 2};
    pkt_type = test_cases{i, 3};
    n_dbps = test_cases{i, 4};
    n_cbps = test_cases{i, 5};
    
    fprintf('Testing %s (Rate ID: %d)... ', rate_name, rate_id);
    
    % 1. Test with random data
    input_len = 2 * n_dbps;
    encoded_bits = randi([0 1], input_len, 1);
    
    try
        % Use symbol_index 3 to ensure we are in DATA field logic (not forced to 6Mbps)
        interleaved_bits = dot11_punc_interlv(encoded_bits, rate_id, 3, pkt_type); 
        
        % Check length
        if length(interleaved_bits) ~= n_cbps
            fprintf('FAILED. Expected length %d, got %d\n', n_cbps, length(interleaved_bits));
            all_passed = false;
            continue;
        end
        
        % 2. Test with all ones
        encoded_ones = ones(input_len, 1);
        interleaved_ones = dot11_punc_interlv(encoded_ones, rate_id, 3, pkt_type);
        if ~all(interleaved_ones == 1)
            fprintf('FAILED. Input all ones, output contained zeros.\n');
            all_passed = false;
            continue;
        end
        
        % 3. Test with all zeros
        encoded_zeros = zeros(input_len, 1);
        interleaved_zeros = dot11_punc_interlv(encoded_zeros, rate_id, 3, pkt_type);
        if ~all(interleaved_zeros == 0)
            fprintf('FAILED. Input all zeros, output contained ones.\n');
            all_passed = false;
            continue;
        end
        
        % 4. For non-punctured rates (N_CBPS == 2 * N_DBPS), check permutation
        % Rates with no puncturing: 6Mbps, 12Mbps, 24Mbps, MCS0, etc.
        % Rates with puncturing: 9Mbps (3/4), 18Mbps (3/4), 36Mbps (3/4), 48Mbps (2/3), 54Mbps (3/4)
        if n_cbps == 2 * n_dbps
            % Use a sequence 1:N to check permutation
            input_indices = (1:input_len).';
            output_indices = dot11_punc_interlv(input_indices, rate_id, 3, pkt_type);
            
            % Check if output is a permutation of input
            if ~isequal(sort(output_indices), input_indices)
                fprintf('FAILED. Output is not a permutation of input (lost or duplicated bits).\n');
                all_passed = false;
                continue;
            end
        end
        
        fprintf('PASSED\n');
        
    catch ME
        fprintf('ERROR: %s\n', ME.message);
        fprintf('Stack trace:\n');
        for k = 1:length(ME.stack)
            fprintf('File: %s, Name: %s, Line: %d\n', ME.stack(k).file, ME.stack(k).name, ME.stack(k).line);
        end
        all_passed = false;
    end
end

if all_passed
    fprintf('\nAll tests passed successfully!\n');
else
    fprintf('\nSome tests failed.\n');
end
