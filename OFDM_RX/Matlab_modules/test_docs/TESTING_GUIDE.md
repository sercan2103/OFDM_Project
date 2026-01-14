# MATLAB Module Testing Guide

## Quick Start

To test the MATLAB validation modules, follow these steps:

### 1. Setup MATLAB Path

Open MATLAB and navigate to the validation directory:

```matlab
cd /home/fatih/openofdm/matlab_validation
```

### 2. Run Complete Test Suite

Execute all tests at once:

```matlab
test_all_modules
```

This will test all 18 modules and provide a pass/fail summary.

### 3. Run Individual Test Scripts

For detailed testing of specific subsystems:

#### Test Phase Rotation Modules
```matlab
test_phase_rotation
```

Tests:
- Phase calculation accuracy
- Rotation correctness
- CFO correction
- Complex multiplication
- Includes visualization plots

#### Test Signal Decode Modules
```matlab
test_signal_decode
```

Tests:
- SIGNAL field decoding
- HT format detection
- Q-BPSK derotation
- HT-SIG decoding with CRC
- CRC-32 calculation
- Includes constellation plots

---

## Individual Module Testing

### Testing a Single Module

Example: Test the `phase` module:

```matlab
% Add path
addpath('part1_phase_rotation');

% Initialize
state = struct();
state.div_state.pipeline = zeros(36, 1);
state.pipeline = zeros(40, 4);

% Test case: Calculate phase of (1000, 1000)
% Expected: π/4 ≈ 0.785 radians ≈ 402 (scaled)
test_i = 1000;
test_q = 1000;

% Fill pipeline (40 cycles)
for i = 1:50
    [phase_out, state] = phase(test_i, test_q, state);
end

% Check result
phase_radians = double(phase_out) / 512;
expected = pi/4;
error = abs(phase_radians - expected);

fprintf('Expected: %.4f rad, Got: %.4f rad, Error: %.4f rad\n', ...
        expected, phase_radians, error);

if error < 0.1
    fprintf('✓ PASS\n');
else
    fprintf('✗ FAIL\n');
end
```

### Example Test Templates

#### Template 1: Test with Known Results

```matlab
function test_my_module()
    % Test cases with known answers
    test_cases = [
        % input_a, input_b, expected_output
        100, 200, 150;
        -50, 50, 0;
        1000, 0, 500;
    ];
    
    state = module_init();
    passed = 0;
    
    for i = 1:size(test_cases, 1)
        in_a = test_cases(i, 1);
        in_b = test_cases(i, 2);
        expected = test_cases(i, 3);
        
        [output, state] = my_module(in_a, in_b, state);
        
        if abs(output - expected) < tolerance
            passed = passed + 1;
        end
    end
    
    fprintf('Passed %d/%d tests\n', passed, size(test_cases, 1));
end
```

#### Template 2: Stress Test

```matlab
function stress_test_module()
    state = module_init();
    
    % Test extreme values
    extreme_values = [-32768, -1000, 0, 1000, 32767];
    
    for val = extreme_values
        [output, state] = my_module(val, state);
        
        % Check for overflow, NaN, Inf
        assert(~isnan(output), 'NaN detected');
        assert(~isinf(output), 'Inf detected');
        assert(abs(output) <= 2^31-1, 'Overflow detected');
    end
    
    fprintf('✓ Stress test passed\n');
end
```

#### Template 3: Compare with Verilog

```matlab
function compare_with_verilog()
    % Generate test vectors
    N = 100;
    test_inputs = randi([-1000, 1000], N, 2);
    
    % Run MATLAB version
    matlab_outputs = zeros(N, 1);
    state = module_init();
    
    for i = 1:N
        [matlab_outputs(i), state] = ...
            my_module(test_inputs(i,1), test_inputs(i,2), state);
    end
    
    % Export for Verilog testbench
    writematrix(test_inputs, 'input_vectors.txt');
    writematrix(matlab_outputs, 'expected_outputs.txt');
    
    fprintf('Test vectors exported\n');
    
    % After running Verilog simulation, import results
    % verilog_outputs = readmatrix('verilog_outputs.txt');
    % diff = matlab_outputs - verilog_outputs;
    % max_error = max(abs(diff));
end
```

---

## Debugging Failed Tests

### Step 1: Identify Which Module Failed

Look at the test output to see which module failed:

```
Test 1.6: phase... FAIL: Phase of (1000,0) should be near 0
```

### Step 2: Run That Module in Debug Mode

```matlab
% Add breakpoint before the failing assertion
dbstop in phase at 85

% Re-run the test
test_all_modules
```

### Step 3: Inspect Intermediate Values

```matlab
% Check pipeline state
disp(state.pipeline);

% Check division results
disp(state.div_state.pipeline);

% Trace through one iteration
[output, state] = phase(1000, 0, state);
```

### Step 4: Compare with Theory

```matlab
% What should the output be?
expected = atan2(0, 1000) * 512;  % Should be 0

% What did we get?
actual = output;

fprintf('Expected: %f, Got: %f, Diff: %f\n', expected, actual, expected - actual);
```

---

## Performance Testing

### Measure Execution Time

```matlab
% Test processing speed
N = 10000;
state = phase_init();

tic;
for i = 1:N
    [~, state] = phase(randi(1000), randi(1000), state);
end
elapsed = toc;

fprintf('Processed %d samples in %.3f seconds\n', N, elapsed);
fprintf('Throughput: %.1f ksamples/sec\n', N/elapsed/1000);
```

### Memory Usage

```matlab
% Check state size
state = equalizer_init();
info = whos('state');
fprintf('State memory: %d bytes\n', info.bytes);
```

---

## Creating Custom Tests

### Your Own Test Script

Create a new file `test_my_scenario.m`:

```matlab
% test_my_scenario.m
% Custom test for specific use case

clear all;
addpath('part1_phase_rotation');
addpath('part2_equalizer');
addpath('part3_signal_decode');

% Your test code here
fprintf('Testing my scenario...\n');

% Test step 1
% ...

% Test step 2
% ...

fprintf('✓ All custom tests passed\n');
```

---

## Continuous Integration

### Automated Testing

Create a test runner that can be called from command line:

```matlab
% run_tests.m
function success = run_tests()
    try
        test_all_modules;
        test_phase_rotation;
        test_signal_decode;
        success = true;
    catch ME
        fprintf('Tests failed: %s\n', ME.message);
        success = false;
    end
end
```

Run from terminal:
```bash
matlab -batch "cd /home/fatih/openofdm/matlab_validation; success = run_tests(); exit(~success)"
```

---

## Troubleshooting

### Common Issues

**Issue 1: "Undefined function or variable"**
```matlab
% Solution: Add path to modules
addpath('part1_phase_rotation');
addpath('part2_equalizer');
addpath('part3_signal_decode');
```

**Issue 2: "Index exceeds array bounds"**
```matlab
% Solution: Check if state is initialized
if isempty(state) || ~isfield(state, 'pipeline')
    state = module_init();
end
```

**Issue 3: "Results don't match expected"**
```matlab
% Solution: Wait for pipeline to fill
for warmup = 1:50
    [output, state] = module(input, state);
end
% Now check results
```

---

## Next Steps

After validating MATLAB modules:

1. **Generate test vectors** for Verilog testbench
2. **Run Verilog simulations** with generated vectors
3. **Compare results** between MATLAB and Verilog
4. **Debug discrepancies** using MATLAB as reference
5. **Synthesize** once validation passes

Good luck with testing! 🚀
