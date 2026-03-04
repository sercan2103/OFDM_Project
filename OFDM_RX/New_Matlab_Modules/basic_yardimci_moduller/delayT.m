function data_out = delayT(data_in, delay_cycles, reset)
% DELAYT Pipeline delay matching module
%
% Inputs:
%   data_in: Input data (any type)
%   delay_cycles: Number of clock cycles to delay
%   reset: Reset signal (optional, default 0)
%
% Output:
%   data_out: Delayed data
%
% Usage:
%   persistent buffer
%   output = delayT(input, 5); % 5 cycle delay

    persistent buffer
    
    % Initialize or reset
    if nargin < 3
        reset = 0;
    end
    
    if isempty(buffer) || reset
        buffer = zeros(delay_cycles, 1);
    end
    
    % Handle different data widths
    if delay_cycles == 0
        data_out = data_in;
        return;
    end
    
    % Shift register: push new data, shift old
    buffer = [data_in; buffer(1:end-1)];
    
    % Output from last stage
    data_out = buffer(end);
end
