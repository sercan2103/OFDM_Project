function [data_out, state] = delayT(data_in, state, DELAY)
% delayT - Shift register delay line
% 
% Implements a parameterizable delay line (shift register)
% Corresponds to delayT.v
%
% INPUTS:
%   data_in - Input data (can be scalar or vector)
%   state   - Delay line state (array of DELAY elements)
%   DELAY   - Number of clock cycles to delay
%
% OUTPUTS:
%   data_out - Delayed output (data_in delayed by DELAY cycles)
%   state    - Updated delay line state
%
% USAGE:
%   % Initialize
%   state = zeros(1, DELAY);
%   % Process each sample
%   [out, state] = delayT(in, state, DELAY);

if nargin < 3
    error('delayT requires 3 arguments: data_in, state, DELAY');
end

if isempty(state)
    state = zeros(size(data_in), DELAY);
end

% Output is the last element in delay line
data_out = state(:, end);

% Shift register: move data through pipeline
state = [data_in, state(:, 1:end-1)];

end
