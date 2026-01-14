function [data_out, ram] = ram_2port_read(addr, ram)
% ram_2port_read - Read from dual-port RAM (single port read)
%
% Simulates one read port of dual-port RAM
% Corresponds to ram_2port.v read operation
%
% INPUTS:
%   addr - Read address
%   ram  - RAM array
%
% OUTPUTS:
%   data_out - Data at specified address
%   ram      - RAM array (unchanged)
%
% USAGE:
%   % Initialize RAM
%   ram = ram_2port_init(64, 32); % 64 words, 32 bits
%   % Write
%   ram = ram_2port_write(addr, data, ram);
%   % Read
%   [data, ram] = ram_2port_read(addr, ram);

if isempty(ram)
    error('RAM not initialized. Use ram_2port_init()');
end

% Read with 1 cycle delay (registered output)
addr = mod(floor(addr), size(ram, 1)) + 1; % Convert to 1-based MATLAB indexing
data_out = ram(addr, :);

end

function ram = ram_2port_write(addr, data, ram)
% ram_2port_write - Write to dual-port RAM
%
% INPUTS:
%   addr - Write address
%   data - Data to write
%   ram  - RAM array
%
% OUTPUTS:
%   ram - Updated RAM array

addr = mod(floor(addr), size(ram, 1)) + 1; % Convert to 1-based
ram(addr, :) = data;

end

function ram = ram_2port_init(depth, width)
% ram_2port_init - Initialize dual-port RAM
%
% INPUTS:
%   depth - Number of words
%   width - Bits per word (for complex: width=2 for I,Q)
%
% OUTPUTS:
%   ram - Initialized RAM array (depth x width)

ram = zeros(depth, width);

end
