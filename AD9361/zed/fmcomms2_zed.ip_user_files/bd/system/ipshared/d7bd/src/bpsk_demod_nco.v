`timescale 1ns / 1ps
// =============================================================================
// bpsk_demod_nco.v  –  Numerically Controlled Oscillator
//
// 32-bit phase accumulator with a 256-entry sin/cos ROM.
// ROM is initialised at elaboration using Verilog's $sin() system function
// (supported by Vivado synthesis for ROM inference).
//
// Output format: Q1.15  (16-bit signed, 0x7FFF ≈ +1.0, 0x8001 ≈ −1.0)
//
// Frequency resolution = f_clk / 2^32
//   e.g. 245.76 MHz → ~0.057 Hz/LSB
//
// Phase advances only when valid_in is high (tied to adc_valid so the NCO
// tracks symbol timing correctly regardless of the ADC duty cycle).
// =============================================================================

module bpsk_demod_nco (
    input  wire        clk,
    input  wire        resetn,
    input  wire        valid_in,        // advance phase only on ADC valid sample
    input  wire [31:0] freq_word,       // nominal freq word (0 = baseband)
    input  wire signed [17:0] phase_corr, // per-sample phase correction (signed)
    output reg  signed [15:0] cos_out,
    output reg  signed [15:0] sin_out
);

    // ---- 256-entry sin ROM (Q1.15, signed) ----------------------------------
    reg signed [15:0] sin_rom [0:255];

    integer lut_k;
    initial begin
        for (lut_k = 0; lut_k < 256; lut_k = lut_k + 1)
            sin_rom[lut_k] = $rtoi($sin(lut_k * 6.283185307179586 / 256.0) * 32767.0);
    end

    // ---- 32-bit phase accumulator -------------------------------------------
    reg [31:0] phase_acc;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            phase_acc <= 32'd0;
        else if (valid_in)
            phase_acc <= phase_acc + freq_word + {{14{phase_corr[17]}}, phase_corr};
    end

    // ---- ROM lookup ---------------------------------------------------------
    // cos(x) = sin(x + pi/2) → index offset of 64 entries (256/4 = 64)
    wire [7:0] sin_idx = phase_acc[31:24];
    wire [7:0] cos_idx = phase_acc[31:24] + 8'd64;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            sin_out <= 16'd0;
            cos_out <= 16'd0;
        end else begin
            sin_out <= sin_rom[sin_idx];
            cos_out <= sin_rom[cos_idx];
        end
    end

endmodule
