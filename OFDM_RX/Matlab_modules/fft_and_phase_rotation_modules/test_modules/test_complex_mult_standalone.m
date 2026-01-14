%% test_complex_mult_standalone.m
% Standalone test for complex_mult module
% NO dependencies required

clear all;
close all;
clc;

fprintf('========================================\n');
fprintf('  Testing: complex_mult (STANDALONE)\n');
fprintf('========================================\n');

% Initialize
state = struct();
state.pipeline = zeros(5, 2);

% Test cases: [a_i, a_q, b_i, b_q, expected_i, expected_q]
test_cases = [
    3, 4, 1, 2, -5, 10;          % (3+4i)*(1+2i) = -5+10i
    5, 0, 2, 0, 10, 0;           % (5+0i)*(2+0i) = 10+0i
    0, 5, 0, 2, -10, 0;          % (0+5i)*(0+2i) = -10+0i
    1, 1, 1, -1, 2, 0;           % (1+i)*(1-i) = 2+0i
    100, 200, 3, 4, -500, 1000;  % (100+200i)*(3+4i) = -500+1000i
    -10, 5, 2, -3, -5, 40;       % (-10+5i)*(2-3i) = -5+40i
];

passed = 0;
failed = 0;

for t = 1:size(test_cases, 1)
    a_i = test_cases(t, 1);
    a_q = test_cases(t, 2);
    b_i = test_cases(t, 3);
    b_q = test_cases(t, 4);
    exp_i = test_cases(t, 5);
    exp_q = test_cases(t, 6);
    
    % Fill pipeline (5 cycles)
    for i = 1:10
        [p_i, p_q, state] = complex_mult(a_i, a_q, b_i, b_q, state);
    end
    
    % Check result
    if abs(p_i - exp_i) <= 1 && abs(p_q - exp_q) <= 1
        fprintf('Test %d: (%d%+di)*(%d%+di) = %d%+di ✓ PASS\n', ...
                t, a_i, a_q, b_i, b_q, p_i, p_q);
        passed = passed + 1;
    else
        fprintf('Test %d: FAIL - Expected (%d%+di), Got (%d%+di)\n', ...
                t, exp_i, exp_q, p_i, p_q);
        failed = failed + 1;
    end
end

fprintf('\n========================================\n');
fprintf('  Results: %d passed, %d failed\n', passed, failed);
fprintf('========================================\n');
