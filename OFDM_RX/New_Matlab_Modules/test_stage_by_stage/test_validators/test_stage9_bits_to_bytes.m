function result = test_stage9_bits_to_bytes(bits, params, expected)
% TEST_STAGE9_BITS_TO_BYTES - Test bits_to_bytes module
%
% Tests bits_to_bytes.m for bit-to-byte conversion
%
% Inputs:
%   bits: Descrambled bits
%   params: Test parameters
%   expected: Expected outputs (optional)
%
% Outputs:
%   result.pass: Boolean test result
%   result.bytes: Output bytes (uint8)
%   result.message: Test message

    result = struct();
    result.pass = false;
    result.message = '';
    
    fprintf('\n=== STAGE 9: Bits to Bytes ===\n');
    
    %% Initialize module
    addpath('../');
    
    %% Run bits_to_bytes
    num_bits = length(bits);
    fprintf('[Stage 9] Processing %d bits\n', num_bits);
    
    % Skip SERVICE field (first 16 bits)
    if num_bits > 16
        data_bits = bits(17:end);
        fprintf('[Stage 9] Skipping SERVICE field, %d data bits remaining\n', length(data_bits));
    else
        fprintf('[Stage 9] ERROR: Not enough bits for SERVICE field\n');
        result.pass = false;
        result.message = 'FAIL: Insufficient bits';
        return;
    end
    
    % Initialize module state
    enable = true;
    reset = true;
    
    bytes_vec = [];
    byte_out_strobe_vec = [];
    
    % Process bits
    for n = 1:length(data_bits)
        in_bit = data_bits(n);
        bit_strobe = true;
        
        % Call bits_to_bytes
        [byte_out, byte_strobe, ~] = ...
            bits_to_bytes(in_bit, bit_strobe, reset);
        
        reset = false;  % Only reset on first call
        
        % Store outputs
        if byte_strobe
            bytes_vec = [bytes_vec; byte_out];
            byte_out_strobe_vec = [byte_out_strobe_vec; true];
        end
    end
    
    %% Validate result
    result.bytes = bytes_vec;
    
    % Check if conversion produced outputs
    if ~isempty(bytes_vec)
        num_bytes = length(bytes_vec);
        fprintf('[Stage 9] Output bytes: %d\n', num_bytes);
        
        % Validate bytes are uint8
        if all(bytes_vec >= 0) && all(bytes_vec <= 255)
            fprintf('[Stage 9] All outputs are valid uint8 bytes\n');
            result.pass = true;
            result.message = sprintf('PASS: Converted to %d bytes', num_bytes);
        else
            fprintf('[Stage 9] WARNING: Out-of-range byte values\n');
            result.pass = false;
            result.message = 'FAIL: Invalid byte values';
        end
        
        % Expected number of bytes
        expected_bytes = floor(length(data_bits) / 8);
        fprintf('[Stage 9] Expected ~%d bytes from %d bits\n', ...
                expected_bytes, length(data_bits));
        
        if num_bytes == expected_bytes
            fprintf('[Stage 9] Byte count correct\n');
        else
            fprintf('[Stage 9] WARNING: Byte count mismatch: expected %d, got %d\n', ...
                    expected_bytes, num_bytes);
        end
        
        % Display first few bytes
        if num_bytes > 0
            fprintf('[Stage 9] First bytes (hex): ');
            for i = 1:min(10, num_bytes)
                fprintf('%02X ', bytes_vec(i));
            end
            fprintf('\n');
        end
        
        % Check against expected
        if nargin >= 3 && ~isempty(expected) && isfield(expected, 'bytes')
            % Compare bytes
            min_len = min(length(result.bytes), length(expected.bytes));
            if min_len > 0
                byte_errors = sum(result.bytes(1:min_len) ~= expected.bytes(1:min_len));
                byte_error_rate = byte_errors / min_len;
                
                fprintf('[Stage 9] Byte error rate vs expected: %.6f (%d / %d)\n', ...
                        byte_error_rate, byte_errors, min_len);
                
                if byte_errors == 0
                    fprintf('[Stage 9] Perfect match with expected\n');
                else
                    result.pass = false;
                    result.message = [result.message, sprintf(' | %d byte errors', byte_errors)];
                end
            end
        end
    else
        result.pass = false;
        result.message = 'FAIL: No output bytes';
    end
    
    %% Generate diagnostic plot
    if isfield(params, 'plot') && params.plot && ~isempty(result.bytes)
        figure('Name', 'Stage 9: Bits to Bytes');
        
        subplot(2,2,1);
        plot(data_bits(1:min(200, end)), '.-');
        title('Input Bits (first 200)');
        xlabel('Bit Index');
        ylabel('Bit Value');
        grid on;
        ylim([-0.5, 1.5]);
        
        subplot(2,2,2);
        plot(result.bytes(1:min(50, end)), '.-');
        title('Output Bytes (first 50)');
        xlabel('Byte Index');
        ylabel('Byte Value');
        grid on;
        
        subplot(2,2,3);
        histogram(result.bytes, 256);
        title('Byte Value Distribution');
        xlabel('Byte Value');
        ylabel('Count');
        grid on;
        
        subplot(2,2,4);
        % Display bytes as text (if printable)
        text_str = '';
        for i = 1:min(100, length(result.bytes))
            if result.bytes(i) >= 32 && result.bytes(i) <= 126
                text_str = [text_str, char(result.bytes(i))];
            else
                text_str = [text_str, '.'];
            end
        end
        text(0.1, 0.5, text_str, 'FontName', 'Courier', 'FontSize', 8);
        title('Bytes as ASCII (first 100)');
        axis off;
    end
    
    fprintf('[Stage 9] Test complete: %s\n', result.message);
end
