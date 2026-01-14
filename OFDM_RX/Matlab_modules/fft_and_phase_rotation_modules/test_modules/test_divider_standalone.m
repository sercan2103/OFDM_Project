%% test_divider_standalone.m
% Standalone test for divider module
% NO dependencies required

clear all;
close all;
clc;

fprintf('========================================\n');
fprintf('  Testing: divider (STANDALONE)\n');
fprintf('========================================\n');

% Initialize
state = struct();
state.pipeline = zeros(36, 1);

% Test cases: [dividend, divisor, expected_quotient]
test_cases = [
    1000, 25, 40;           % 1000/25 = 40
    2048, 2, 1024;          % 2048/2 = 1024
    500, 10, 50;            % 500/10 = 50
    -1000, 10, -100;        % -1000/10 = -100
    1000, -25, -40;         % 1000/-25 = -40
    0, 100, 0;              % 0/100 = 0
    500, 0, 0;              % Division by zero = 0
    12345, 123, 100;        % 12345/123 ≈ 100
];

passed = 0;
failed = 0;

for t = 1:size(test_cases, 1)
    dividend = test_cases(t, 1);
    divisor = test_cases(t, 2);
    expected = test_cases(t, 3);
    
    % Reset state for each test
    state.pipeline = zeros(36, 1);
    
    % Fill pipeline (36 cycles + extra for safety)
    for i = 1:45
        [quotient, state] = divider(dividend, divisor, state);
    end
    
    % Check result (allow small error due to integer division)
    error = abs(quotient - expected);
    if error <= 2
        fprintf('Test %d: %d / %d = %d ✓ PASS\n', ...
                t, dividend, divisor, quotient);
        passed = passed + 1;
    else
        fprintf('Test %d: FAIL - %d / %d: Expected %d, Got %d (error=%d)\n', ...
                t, dividend, divisor, expected, quotient, error);
        failed = failed + 1;
    end
end

fprintf('\n========================================\n');
fprintf('  Results: %d passed, %d failed\n', passed, failed);
fprintf('========================================\n');
