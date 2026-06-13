`timescale 1ns / 1ps
// Gaussian noise generator for OFDM channel simulation.
//
// Method: Central Limit Theorem approximation.
//   Sum of 4 independent 16-bit Fibonacci LFSRs per component (I and Q).
//   Each LFSR is uniform over [0, 65535] (period 2^16 - 1 = 65535).
//   Sum of 4 centered at zero: range [-131072, 131068], 19-bit signed.
//   Arithmetic right-shift by 2 gives 17-bit output [-32768, 32767], σ ≈ 9459.
//
// All 8 LFSRs use the same maximal-length polynomial (x^16+x^15+x^13+x^4+1,
// Xilinx XAPP052 Table 3, period 65535) with distinct seeds. Consecutive
// sequences are the same cycle shifted by different offsets — decorrelated
// for any window << 65535 samples, which satisfies the CLT independence
// requirement across a single OFDM packet (~3500 samples).
//
// LFSRs advance every clock cycle. noise_i and noise_q are combinatorial
// outputs from the current LFSR state; the channel module samples them
// at the precise cycle it latches a new dot11 input sample.
//
// Approximate SNR table (signal amplitude ~4340 = openofdm_tx default;
// P_signal ≈ 9.42e6; P_noise = σ²; σ = σ_raw / 2^noise_shift):
//
//   noise_shift |  σ_noise  |  SNR (dB)
//   ------------|-----------|----------
//       0       |   9459    |  -10  dB  (sync fails — near total noise)
//       1       |   4729    |   -4  dB
//       2       |   2365    |    2  dB  (near BPSK 1/2 threshold)
//       3       |   1182    |    8  dB  (most packets decode, some errors)
//       4       |    591    |   14  dB  (reliable decode, measurable BER)
//       5       |    296    |   20  dB  (low BER)
//       6       |    148    |   26  dB
//       7       |     74    |   32  dB
//       8       |     37    |   38  dB  (very low BER)
//      10       |      9    |   50  dB
//      12       |      2    |   62  dB  (imperceptible)
//      15       |     <1    |  ~80  dB  (effectively noiseless)
//
// Each +1 step in noise_shift ≈ +6 dB SNR improvement.

module awgn_noise_gen (
    input  wire        clk,
    input  wire        rst,
    output wire signed [16:0] noise_i,  // 17-bit Gaussian, σ ≈ 9459
    output wire signed [16:0] noise_q
);

    // ---------------------------------------------------------------
    // 8 Fibonacci LFSRs: polynomial x^16+x^15+x^13+x^4+1
    // (taps at bit positions 15, 14, 12, 3 in 0-indexed notation)
    // feedback = lfsr[15]^lfsr[14]^lfsr[12]^lfsr[3]
    // Update:   lfsr <= {lfsr[14:0], feedback}
    // ---------------------------------------------------------------

    // I-channel LFSRs — four different seeds, well-spread in phase
    reg [15:0] lfsr_i0 = 16'hACE1;
    reg [15:0] lfsr_i1 = 16'h1D72;
    reg [15:0] lfsr_i2 = 16'hBEEF;
    reg [15:0] lfsr_i3 = 16'h57F3;

    // Q-channel LFSRs — four more distinct seeds
    reg [15:0] lfsr_q0 = 16'hCAFE;
    reg [15:0] lfsr_q1 = 16'hF00D;
    reg [15:0] lfsr_q2 = 16'h5A3C;
    reg [15:0] lfsr_q3 = 16'hA196;

    always @(posedge clk) begin
        if (rst) begin
            lfsr_i0 <= 16'hACE1; lfsr_i1 <= 16'h1D72;
            lfsr_i2 <= 16'hBEEF; lfsr_i3 <= 16'h57F3;
            lfsr_q0 <= 16'hCAFE; lfsr_q1 <= 16'hF00D;
            lfsr_q2 <= 16'h5A3C; lfsr_q3 <= 16'hA196;
        end else begin
            lfsr_i0 <= {lfsr_i0[14:0], lfsr_i0[15]^lfsr_i0[14]^lfsr_i0[12]^lfsr_i0[3]};
            lfsr_i1 <= {lfsr_i1[14:0], lfsr_i1[15]^lfsr_i1[14]^lfsr_i1[12]^lfsr_i1[3]};
            lfsr_i2 <= {lfsr_i2[14:0], lfsr_i2[15]^lfsr_i2[14]^lfsr_i2[12]^lfsr_i2[3]};
            lfsr_i3 <= {lfsr_i3[14:0], lfsr_i3[15]^lfsr_i3[14]^lfsr_i3[12]^lfsr_i3[3]};
            lfsr_q0 <= {lfsr_q0[14:0], lfsr_q0[15]^lfsr_q0[14]^lfsr_q0[12]^lfsr_q0[3]};
            lfsr_q1 <= {lfsr_q1[14:0], lfsr_q1[15]^lfsr_q1[14]^lfsr_q1[12]^lfsr_q1[3]};
            lfsr_q2 <= {lfsr_q2[14:0], lfsr_q2[15]^lfsr_q2[14]^lfsr_q2[12]^lfsr_q2[3]};
            lfsr_q3 <= {lfsr_q3[14:0], lfsr_q3[15]^lfsr_q3[14]^lfsr_q3[12]^lfsr_q3[3]};
        end
    end

    // ---------------------------------------------------------------
    // CLT sum: 4 LFSRs, center at zero, divide by 4.
    //
    // Each LFSR is unsigned [0, 65535].
    // Centered:  lfsr_iN - 32768 → signed [-32768, 32767].
    // Sum of 4 centered: signed [-131072, 131068], 19-bit.
    // >> 2 (take bits [18:2]): signed [-32768, 32767], σ ≈ 9459.
    //
    // Using 19-bit intermediate to avoid truncation of the sum.
    // The subtraction 4*32768=131072 is applied as one constant to
    // avoid needing signed arithmetic on 17-bit extended LFSR values.
    // ---------------------------------------------------------------
    wire signed [18:0] sum_i_raw =
        $signed({3'b0, lfsr_i0}) + $signed({3'b0, lfsr_i1}) +
        $signed({3'b0, lfsr_i2}) + $signed({3'b0, lfsr_i3}) - 19'sd131072;

    wire signed [18:0] sum_q_raw =
        $signed({3'b0, lfsr_q0}) + $signed({3'b0, lfsr_q1}) +
        $signed({3'b0, lfsr_q2}) + $signed({3'b0, lfsr_q3}) - 19'sd131072;

    // Bits [18:2] = arithmetic >>2, gives 17-bit signed output.
    assign noise_i = sum_i_raw[18:2];
    assign noise_q = sum_q_raw[18:2];

endmodule
