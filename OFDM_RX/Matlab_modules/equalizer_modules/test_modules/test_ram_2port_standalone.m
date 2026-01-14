%% test_ram_2port_standalone.m
% Standalone test for ram_2port (dual-port RAM) module
% NO dependencies required - Tests RAM read/write operations

clear all;
close all;
clc;

fprintf('========================================\n');
fprintf('  Testing: ram_2port (STANDALONE)\n');
fprintf('========================================\n');

% RAM Configuration
DATA_WIDTH = 16;
ADDR_WIDTH = 6;  % 64 locations
DEPTH = 2^ADDR_WIDTH;

% Initialize RAM
state = struct();
state.ram = zeros(DEPTH, 1, 'int32');

%% Test 1: Basic write and read
fprintf('\nTest 1: Basic write and read...\n');
write_addr = 10;
write_data = 12345;
write_enable = 1;
read_addr = 10;

% Write data
[read_data, state] = ram_2port(read_addr, write_addr, write_data, write_enable, state);

% Read back (next cycle)
write_enable = 0;
[read_data, state] = ram_2port(read_addr, 0, 0, write_enable, state);

if read_data == write_data
    fprintf('  ✓ PASS: Write/Read at addr %d: wrote %d, read %d\n', write_addr, write_data, read_data);
else
    fprintf('  ✗ FAIL: Expected %d, got %d\n', write_data, read_data);
end

%% Test 2: Multiple locations
fprintf('\nTest 2: Write/Read multiple locations...\n');
state.ram = zeros(DEPTH, 1, 'int32');  % Reset RAM

% Write to multiple addresses
test_data = [100, 200, 300, 400, 500];
test_addrs = [0, 10, 20, 30, 40];

for i = 1:length(test_data)
    [~, state] = ram_2port(0, test_addrs(i), test_data(i), 1, state);
end

% Read back and verify
passed = true;
for i = 1:length(test_data)
    [read_data, state] = ram_2port(test_addrs(i), 0, 0, 0, state);
    if read_data ~= test_data(i)
        fprintf('  ✗ FAIL: Addr %d: Expected %d, got %d\n', test_addrs(i), test_data(i), read_data);
        passed = false;
    end
end

if passed
    fprintf('  ✓ PASS: All %d locations verified\n', length(test_data));
end

%% Test 3: Write enable control
fprintf('\nTest 3: Write enable control...\n');
state.ram = zeros(DEPTH, 1, 'int32');

addr = 5;
original_value = 777;
new_value = 999;

% Write original value
[~, state] = ram_2port(0, addr, original_value, 1, state);

% Try to write new value with write_enable=0 (should NOT write)
[~, state] = ram_2port(0, addr, new_value, 0, state);

% Read back
[read_data, state] = ram_2port(addr, 0, 0, 0, state);

if read_data == original_value
    fprintf('  ✓ PASS: Write enable=0 prevents write (value still %d)\n', original_value);
else
    fprintf('  ✗ FAIL: Write enable failed (got %d, expected %d)\n', read_data, original_value);
end

%% Test 4: Overwrite existing data
fprintf('\nTest 4: Overwrite existing data...\n');
addr = 15;
value1 = 111;
value2 = 222;
value3 = 333;

% Write value1
[~, state] = ram_2port(0, addr, value1, 1, state);
[read_data, state] = ram_2port(addr, 0, 0, 0, state);
fprintf('  Write 1: %d\n', read_data);

% Overwrite with value2
[~, state] = ram_2port(0, addr, value2, 1, state);
[read_data, state] = ram_2port(addr, 0, 0, 0, state);
fprintf('  Write 2: %d\n', read_data);

% Overwrite with value3
[~, state] = ram_2port(0, addr, value3, 1, state);
[read_data, state] = ram_2port(addr, 0, 0, 0, state);
fprintf('  Write 3: %d\n', read_data);

if read_data == value3
    fprintf('  ✓ PASS: Overwrite successful (final value = %d)\n', value3);
else
    fprintf('  ✗ FAIL: Expected %d, got %d\n', value3, read_data);
end

%% Test 5: Boundary addresses
fprintf('\nTest 5: Boundary addresses (0 and %d)...\n', DEPTH-1);
state.ram = zeros(DEPTH, 1, 'int32');

% Test address 0
[~, state] = ram_2port(0, 0, 1111, 1, state);
[read_data, state] = ram_2port(0, 0, 0, 0, state);
test_0_pass = (read_data == 1111);

% Test address DEPTH-1
[~, state] = ram_2port(0, DEPTH-1, 2222, 1, state);
[read_data, state] = ram_2port(DEPTH-1, 0, 0, 0, state);
test_max_pass = (read_data == 2222);

if test_0_pass && test_max_pass
    fprintf('  ✓ PASS: Boundary addresses work correctly\n');
else
    fprintf('  ✗ FAIL: Boundary address issue\n');
end

%% Test 6: Simultaneous read and write (different addresses)
fprintf('\nTest 6: Simultaneous read/write different addresses...\n');
state.ram = zeros(DEPTH, 1, 'int32');

% Pre-fill address 25 with data
[~, state] = ram_2port(0, 25, 555, 1, state);

% Simultaneously write to address 35 and read from address 25
[read_data, state] = ram_2port(25, 35, 666, 1, state);

if read_data == 555
    fprintf('  ✓ PASS: Read addr 25 = %d while writing to addr 35\n', read_data);
else
    fprintf('  ✗ FAIL: Simultaneous operation failed\n');
end

% Verify write occurred
[read_data, state] = ram_2port(35, 0, 0, 0, state);
if read_data == 666
    fprintf('  ✓ PASS: Write to addr 35 successful (%d)\n', read_data);
end

%% Test 7: Negative values (signed data)
fprintf('\nTest 7: Signed data (negative values)...\n');
state.ram = zeros(DEPTH, 1, 'int32');

signed_values = [-100, -200, -300, -400];
addrs = [1, 2, 3, 4];

% Write signed values
for i = 1:length(signed_values)
    [~, state] = ram_2port(0, addrs(i), signed_values(i), 1, state);
end

% Read back and verify
passed = true;
for i = 1:length(signed_values)
    [read_data, state] = ram_2port(addrs(i), 0, 0, 0, state);
    if read_data ~= signed_values(i)
        passed = false;
        fprintf('  ✗ FAIL: Addr %d: Expected %d, got %d\n', addrs(i), signed_values(i), read_data);
    end
end

if passed
    fprintf('  ✓ PASS: Signed values stored/retrieved correctly\n');
end

%% Test 8: Full RAM sweep
fprintf('\nTest 8: Full RAM write/read sweep...\n');
state.ram = zeros(DEPTH, 1, 'int32');

% Write incrementing pattern to all locations
for addr = 0:DEPTH-1
    value = addr * 10;
    [~, state] = ram_2port(0, addr, value, 1, state);
end

% Read back and verify
errors = 0;
for addr = 0:DEPTH-1
    expected = addr * 10;
    [read_data, state] = ram_2port(addr, 0, 0, 0, state);
    if read_data ~= expected
        errors = errors + 1;
    end
end

if errors == 0
    fprintf('  ✓ PASS: All %d locations verified in sweep\n', DEPTH);
else
    fprintf('  ✗ FAIL: %d errors found in %d locations\n', errors, DEPTH);
end

%% Summary
fprintf('\n========================================\n');
fprintf('  ram_2port module: ALL TESTS COMPLETE\n');
fprintf('========================================\n');
fprintf('\nModule characteristics:\n');
fprintf('  - Depth: %d locations\n', DEPTH);
fprintf('  - Data width: %d bits (signed)\n', DATA_WIDTH);
fprintf('  - Dual-port: simultaneous read and write\n');
fprintf('  - Write enable control\n');
fprintf('  - Supports signed data\n');
