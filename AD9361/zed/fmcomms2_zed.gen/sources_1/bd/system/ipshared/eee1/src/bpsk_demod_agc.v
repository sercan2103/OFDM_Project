`timescale 1ns / 1ps
// =============================================================================
// bpsk_demod_agc.v  –  Automatic Gain Control
//
// Normalises the received signal amplitude before the Costas loop, compensating
// for RF path attenuation or gain variation.
//
// Algorithm
// ---------
//   amplitude = |I| + |Q|   (taxicab / L1 metric — no multiplier required)
//   error     = target_amp − amplitude   (signed 17-bit)
//   gain_acc += error >>> ki_shift       (first-order IIR integral)
//
// Gain format: Q4.12  (gain_acc[27:12])
//   0x1000 = 1.0 (unity gain)     max ≈ 15.99×     min = 0.0
//
// Gain application: saturation-clipped 16×16 multiply
//   I_out = clip16( (I_in × gain_word) >>> 12 )
//
// Parameters (from AXI-Lite registers, combinatorially applied):
//   target_amp  [15:0]   – desired amplitude (default 0x2000 = 0.25 full-scale)
//   ki_shift    [3:0]    – integral gain exponent: K_i = 2^(−ki_shift)
//                          0 = fastest (unstable!), default 10
//
// Settled flag: asserted when |error| < target_amp/8 for 64 consecutive samples.
// =============================================================================

module bpsk_demod_agc (
    input  wire        clk,
    input  wire        resetn,
    input  wire        valid_in,           // process on ADC valid pulse

    input  wire signed [15:0] i_in,
    input  wire signed [15:0] q_in,

    input  wire [15:0] target_amp,         // target |I|+|Q| amplitude
    input  wire [3:0]  ki_shift,           // integral gain shift (Ki = 2^-ki_shift)
    input  wire        bypass,             // 1 → pass through unmodified

    output reg  signed [15:0] i_out,
    output reg  signed [15:0] q_out,
    output wire [15:0] gain_out,           // current Q4.12 gain (diagnostic)
    output reg         settled             // amplitude within 12.5% of target
);

    // ---- Absolute values (magnitude) ----------------------------------------
    wire [15:0] abs_i = i_in[15] ? (~i_in + 16'd1) : i_in;
    wire [15:0] abs_q = q_in[15] ? (~q_in + 16'd1) : q_in;
    wire [16:0] amplitude = {1'b0, abs_i} + {1'b0, abs_q};

    // ---- Error: target − amplitude (signed 18-bit for headroom) ------------
    wire signed [17:0] error = $signed({2'b00, target_amp}) -
                                $signed({1'b0, amplitude});

    // ---- Integral gain accumulator (Q4.12 in bits [27:12]) ------------------
    // gain_acc[27:12] is the 16-bit gain word (Q4.12)
    // Default: gain = 1.0 = 0x1000 → gain_acc = 0x0100_0000
    reg [31:0] gain_acc;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            gain_acc <= 32'h0100_0000;   // initial gain = 1.0
        end else if (valid_in && !bypass) begin
            // gain_acc += error >> ki_shift
            // error is 18-bit signed; shift right by ki_shift before accumulating
            gain_acc <= gain_acc + ($signed(error) >>> ki_shift);
            // Clamp to avoid negative or overflow
            if (gain_acc[31])            // went negative
                gain_acc <= 32'd0;
        end
    end

    assign gain_out = gain_acc[27:12];   // Q4.12 gain word

    // ---- Apply gain: I_out = clip16((I_in * gain_word) >>> 12) --------------
    wire signed [31:0] prod_i = $signed(i_in) * $signed({4'd0, gain_acc[27:12]});
    wire signed [31:0] prod_q = $signed(q_in) * $signed({4'd0, gain_acc[27:12]});

    // Saturating right-shift by 12
    wire signed [15:0] i_scaled = (prod_i[31:27] == 5'b00000 || prod_i[31:27] == 5'b11111)
                                  ? prod_i[27:12]
                                  : (prod_i[31] ? 16'h8000 : 16'h7FFF);
    wire signed [15:0] q_scaled = (prod_q[31:27] == 5'b00000 || prod_q[31:27] == 5'b11111)
                                  ? prod_q[27:12]
                                  : (prod_q[31] ? 16'h8000 : 16'h7FFF);

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            i_out <= 16'd0;
            q_out <= 16'd0;
        end else if (valid_in) begin
            i_out <= bypass ? i_in : i_scaled;
            q_out <= bypass ? q_in : q_scaled;
        end
    end

    // ---- Settled detector: |error| < target/8 for 64 samples ---------------
    wire [15:0] err_abs  = error[17] ? (~error[15:0] + 16'd1) : error[15:0];
    wire        in_range = (err_abs < {3'd0, target_amp[15:3]});  // < target/8

    reg [5:0]  settle_cnt;
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            settle_cnt <= 6'd0;
            settled    <= 1'b0;
        end else if (valid_in) begin
            if (in_range) begin
                if (settle_cnt == 6'd63) settled <= 1'b1;
                else                     settle_cnt <= settle_cnt + 6'd1;
            end else begin
                settle_cnt <= 6'd0;
                settled    <= 1'b0;
            end
        end
    end

endmodule
