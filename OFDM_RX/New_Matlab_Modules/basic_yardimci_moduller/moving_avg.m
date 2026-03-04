function [data_out, output_strobe] = moving_avg(data_in, input_strobe, window_shift, reset)
% MOVING_AVG Moving average filter
%
% Verilog equivalent: moving_avg.v
% Latency: 2 cycles
%
% Inputs:
%   data_in: Input data (32-bit)
%   input_strobe: Valid signal
%   window_shift: Log2 of window size (default 4, window=16)
%   reset: Reset signal (optional)
%
% Outputs:
%   data_out: Averaged output (32-bit)
%   output_strobe: Output valid signal
%
% Implementation:
%   Average over 2^window_shift samples
%   Uses circular buffer + accumulator

    persistent buffer acc buffer_idx count
    
    if nargin < 3
        window_shift = 4; % Default: 16-sample window
    end
    if nargin < 4
        reset = 0;
    end
    
    window_size = 2^window_shift;
    
    % Initialize
    if isempty(buffer) || reset
        buffer = zeros(window_size, 1);
        acc = 0;
        buffer_idx = 1;
        count = 0;
    end
    
    % Default outputs
    data_out = 0;
    output_strobe = 0;
    
    if input_strobe
        % Remove oldest value from accumulator
        acc = acc - buffer(buffer_idx);
        
        % Add new value
        buffer(buffer_idx) = data_in;
        acc = acc + data_in;
        
        % Update index (circular)
        buffer_idx = buffer_idx + 1;
        if buffer_idx > window_size
            buffer_idx = 1;
        end
        
        % Update count
        if count < window_size
            count = count + 1;
        end
        
        % Output average (divide by window_size = right shift by window_shift)
        % Cast to avoid overflow
        data_out = int32(floor(double(acc) / window_size));
        output_strobe = 1;
    end
end
