function [quotient, state] = divider(dividend, divisor, state)
% divider - Integer divider with pipeline delay
%
% Implements signed integer division: quotient = dividend / divisor
% Corresponds to divider.v (uses div_gen_v3_0 core)
%
% INPUTS:
%   dividend - 32-bit signed dividend
%   divisor  - 24-bit signed divisor
%   state    - Pipeline state structure
%
% OUTPUTS:
%   quotient - 32-bit signed quotient
%   state    - Updated pipeline state
%
% PIPELINE: 36 clock cycles
%
% USAGE:
%   % Initialize
%   state = divider_init();
%   % Process each sample
%   [quot, state] = divider(dividend, divisor, state);

if nargin < 3
    state = struct();
end

if ~isfield(state, 'pipeline')
    state.pipeline = zeros(36, 1);
end

% Convert to signed integers
dividend = int32(dividend);
divisor = int32(int32(divisor) * sign(bitand(divisor, 2^23))); % Sign extend 24-bit

% Perform division (avoid division by zero)
if divisor == 0
    quot_new = 0;
else
    quot_new = idivide(dividend, divisor, 'floor');
end

% Clip to 32-bit signed range
if quot_new > 2^31-1
    quot_new = 2^31-1;
elseif quot_new < -2^31
    quot_new = -2^31;
end

% Update pipeline
state.pipeline = [double(quot_new); state.pipeline(1:end-1)];

% Output from end of pipeline
quotient = state.pipeline(end);

end

function state = divider_init()
% Initialize divider state
    state = struct();
    state.pipeline = zeros(36, 1);
end
