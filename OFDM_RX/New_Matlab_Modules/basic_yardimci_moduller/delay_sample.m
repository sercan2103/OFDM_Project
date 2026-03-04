function [sample_out, sample_out_strobe] = delay_sample(sample_in, sample_in_strobe, delay_shift, reset)
% DELAY_SAMPLE Delay I/Q samples using dual-port RAM
%
% Verilog equivalent: delay_sample.v
% Latency: 2^delay_shift cycles
%
% Inputs:
%   sample_in: 32-bit I/Q sample (16-bit I + 16-bit Q)
%   sample_in_strobe: Valid signal
%   delay_shift: Log2 of delay (default 4, delay=16)
%   reset: Reset signal (optional)
%
% Outputs:
%   sample_out: Delayed sample (32-bit)
%   sample_out_strobe: Output valid signal

    persistent buffer write_addr read_addr initialized
    
    if nargin < 3
        delay_shift = 4; % Default: 16-sample delay
    end
    if nargin < 4
        reset = 0;
    end
    
    delay_samples = 2^delay_shift;
    
    % Initialize
    if isempty(buffer) || reset || isempty(initialized)
        buffer = zeros(delay_samples, 1);
        write_addr = 0;
        read_addr = 0;
        initialized = 1;
    end
    
    % Default outputs
    sample_out = 0;
    sample_out_strobe = 0;
    
    if sample_in_strobe
        % Write to buffer
        buffer(write_addr + 1) = sample_in; % MATLAB 1-indexed
        
        % Read from buffer (delayed by delay_samples)
        sample_out = buffer(read_addr + 1);
        sample_out_strobe = 1;
        
        % Update addresses (circular)
        write_addr = mod(write_addr + 1, delay_samples);
        read_addr = mod(read_addr + 1, delay_samples);
    end
end
