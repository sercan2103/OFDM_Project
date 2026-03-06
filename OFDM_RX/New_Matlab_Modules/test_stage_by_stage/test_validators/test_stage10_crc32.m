function result = test_stage10_crc32(bytes, params, expected)
% TEST_STAGE10_CRC32 - Test crc32 module
%
% Tests crc32.m for FCS validation
%
% Inputs:
%   bytes: Output bytes from bits_to_bytes
%   params: Test parameters
%   expected: Expected outputs (optional)
%
% Outputs:
%   result.pass: Boolean test result
%   result.crc_ok: CRC validation result
%   result.payload: Payload bytes (without FCS)
%   result.message: Test message

    result = struct();
    result.pass = false;
    result.message = '';
    result.crc_ok = false;
    
    fprintf('\n=== STAGE 10: CRC32 ===\n');
    
    %% Initialize module
    addpath('../');
    
    %% Run CRC32 check
    num_bytes = length(bytes);
    fprintf('[Stage 10] Processing %d bytes\n', num_bytes);
    
    % Need at least 4 bytes for FCS
    if num_bytes < 4
        fprintf('[Stage 10] ERROR: Not enough bytes for FCS\n');
        result.pass = false;
        result.message = 'FAIL: Insufficient bytes for FCS';
        return;
    end
    
    % Split payload and FCS
    payload_bytes = bytes(1:end-4);
    fcs_bytes = bytes(end-3:end);
    
    fprintf('[Stage 10] Payload: %d bytes, FCS: 4 bytes\n', length(payload_bytes));
    fprintf('[Stage 10] FCS (hex): %02X %02X %02X %02X\n', ...
            fcs_bytes(1), fcs_bytes(2), fcs_bytes(3), fcs_bytes(4));
    
    %% Calculate CRC32
    % Initialize module state
    enable = true;
    reset = true;
    
    crc_state = uint32(hex2dec('FFFFFFFF'));  % Initial CRC
    
    % Process payload bytes
    for n = 1:length(payload_bytes)
        byte_val = payload_bytes(n);
        byte_strobe = true;
        
        % Call crc32
        [crc_out, crc_strobe, ~] = ...
            crc32(byte_val, byte_strobe, reset);
        
        reset = false;  % Only reset on first call
        
        if crc_strobe
            crc_state = crc_out;
        end
    end
    
    % Final CRC value
    fprintf('[Stage 10] Calculated CRC: 0x%08X\n', crc_state);
    
    % Convert FCS bytes to uint32
    fcs_value = uint32(fcs_bytes(1)) + ...
                bitshift(uint32(fcs_bytes(2)), 8) + ...
                bitshift(uint32(fcs_bytes(3)), 16) + ...
                bitshift(uint32(fcs_bytes(4)), 24);
    
    fprintf('[Stage 10] Received FCS: 0x%08X\n', fcs_value);
    
    %% Validate CRC
    % Check if CRC matches FCS
    if crc_state == fcs_value
        result.crc_ok = true;
        result.pass = true;
        result.message = sprintf('PASS: CRC correct (0x%08X)', crc_state);
        fprintf('[Stage 10] CRC CHECK PASSED!\n');
    else
        result.crc_ok = false;
        result.pass = false;
        result.message = sprintf('FAIL: CRC mismatch (calc: 0x%08X, recv: 0x%08X)', ...
                                crc_state, fcs_value);
        fprintf('[Stage 10] CRC CHECK FAILED!\n');
    end
    
    result.payload = payload_bytes;
    
    % Display payload info
    fprintf('[Stage 10] Payload bytes: %d\n', length(payload_bytes));
    if length(payload_bytes) > 0
        fprintf('[Stage 10] First payload bytes (hex): ');
        for i = 1:min(16, length(payload_bytes))
            fprintf('%02X ', payload_bytes(i));
        end
        fprintf('\n');
    end
    
    %% Check against expected
    if nargin >= 3 && ~isempty(expected)
        if isfield(expected, 'crc_ok')
            if result.crc_ok == expected.crc_ok
                fprintf('[Stage 10] CRC result matches expected\n');
            else
                result.pass = false;
                result.message = [result.message, ' | CRC result mismatch'];
            end
        end
        
        if isfield(expected, 'payload')
            min_len = min(length(result.payload), length(expected.payload));
            if min_len > 0
                byte_errors = sum(result.payload(1:min_len) ~= expected.payload(1:min_len));
                if byte_errors == 0
                    fprintf('[Stage 10] Payload matches expected perfectly\n');
                else
                    fprintf('[Stage 10] WARNING: %d byte mismatches in payload\n', byte_errors);
                end
            end
        end
    end
    
    %% Generate diagnostic plot
    if isfield(params, 'plot') && params.plot
        figure('Name', 'Stage 10: CRC32');
        
        subplot(2,2,1);
        plot(bytes, '.-');
        title('All Bytes (Payload + FCS)');
        xlabel('Byte Index');
        ylabel('Byte Value');
        grid on;
        
        subplot(2,2,2);
        plot(payload_bytes, '.-');
        title('Payload Bytes Only');
        xlabel('Byte Index');
        ylabel('Byte Value');
        grid on;
        
        subplot(2,2,3);
        histogram(payload_bytes, 256);
        title('Payload Byte Distribution');
        xlabel('Byte Value');
        ylabel('Count');
        grid on;
        
        subplot(2,2,4);
        % Display CRC result
        if result.crc_ok
            text(0.5, 0.6, 'CRC CHECK', 'FontSize', 20, 'FontWeight', 'bold', ...
                 'HorizontalAlignment', 'center', 'Color', 'g');
            text(0.5, 0.4, 'PASSED', 'FontSize', 20, 'FontWeight', 'bold', ...
                 'HorizontalAlignment', 'center', 'Color', 'g');
        else
            text(0.5, 0.6, 'CRC CHECK', 'FontSize', 20, 'FontWeight', 'bold', ...
                 'HorizontalAlignment', 'center', 'Color', 'r');
            text(0.5, 0.4, 'FAILED', 'FontSize', 20, 'FontWeight', 'bold', ...
                 'HorizontalAlignment', 'center', 'Color', 'r');
        end
        text(0.5, 0.2, sprintf('CRC: 0x%08X', crc_state), 'FontSize', 12, ...
             'HorizontalAlignment', 'center');
        axis off;
    end
    
    fprintf('[Stage 10] Test complete: %s\n', result.message);
end
