`timescale 1ns / 1ps
// =============================================================================
// lfsr.v  –  23-bit Maximal-Length LFSR
//
// Polynomial: x^23 + x^18 + 1
// Feedback  : new_bit = state[22] ^ state[17]
// Period    : 2^23 − 1 = 8,388,607 bits
//
// Ports:
//   clk    – clock
//   resetn – active-low synchronous reset  (loads SEED)
//   en     – clock-enable; advances shift register when high
//   bit_out – current MSB (= next output bit)
//   state  – full 23-bit state (for debug / reference copies)
// =============================================================================

module lfsr #(
    parameter [22:0] SEED = 23'h55_5555   // must be non-zero
)(
    input  wire        clk,
    input  wire        resetn,
    input  wire        en,
    output wire        bit_out,
    output reg  [22:0] state
);
    always @(posedge clk) begin
        if (!resetn)
            state <= SEED;
        else if (en)
            state <= {state[21:0], state[22] ^ state[17]};
    end

    assign bit_out = state[22];
endmodule
