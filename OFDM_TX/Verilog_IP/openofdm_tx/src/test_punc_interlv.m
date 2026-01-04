% Test script for openofdm_tx_punc_interlv

rate_idx = 15; % 9 Mbps
N_DBPS = 36;
encoded_bits = (0:(2*N_DBPS-1))'; % 0 to 71

interleaved_bits = openofdm_tx_punc_interlv(encoded_bits, rate_idx);

% Check idx_i=1 (bits 2 and 3)
% Bit 2 (A1) should be kept. Bit 3 (B1) should be punctured.
% Bit 2 is the 3rd kept bit (k=2).
% k=2 -> j=6.
% So interleaved_bits(7) should be 2.

val = interleaved_bits(7);
fprintf('Value at index 7 (j=6): %d. Expected: 2.\n', val);

if val == 2
    disp('Test Passed for 9 Mbps idx_i=1');
else
    disp('Test Failed');
end

% Check idx_i=0 (bits 0 and 1)
% Bit 0 (A0) -> k=0 -> j=0 -> index 1.
% Bit 1 (B0) -> k=1 -> j=3 -> index 4.

val0 = interleaved_bits(1);
val1 = interleaved_bits(4);
fprintf('Value at index 1 (j=0): %d. Expected: 0.\n', val0);
fprintf('Value at index 4 (j=3): %d. Expected: 1.\n', val1);

if val0 == 0 && val1 == 1
    disp('Test Passed for 9 Mbps idx_i=0');
else
    disp('Test Failed');
end
