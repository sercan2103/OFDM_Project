// tx_packet_rom.v -- 1024 x 64-bit synchronous ROM with hardcoded
// 802.11 OFDM packet. Replaces the PS-writable BRAM in this Stage 1B
// simplified test. Lets openofdm_tx run end-to-end without any AXI
// dependency.
//
// L-rate=0xB (BPSK 1/2, 6 Mbps). Packet length = 100 bytes (PSDU).
//
// Layout (matches openofdm_transceiver_tb.v convention):
//   word[0]  = L-SIG: rate=0xB, length=100, parity=0
//              0x00C8B = bits {tail=0, parity=0, length=100, rsvd=0, rate=0xB}
//   word[1]  = SERVICE field + ignored padding
//              (openofdm_tx consumes the SERVICE bits; PSDU starts at word[2])
//   word[2..13] = 96 bytes of user payload (0x09 .. 0x68)
//   word[14] = first 4 bytes overwritten by openofdm_tx with computed FCS
//
// Read latency: 1 clock (data_out is registered).

`timescale 1ns / 1ps

module tx_packet_rom #(
  parameter ADDR_WIDTH = 10,
  parameter DATA_WIDTH = 64
) (
  input  wire                   clk,
  input  wire [ADDR_WIDTH-1:0]  addr,
  output reg  [DATA_WIDTH-1:0]  data_out
);

  (* ram_style = "block" *) reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

  integer i;
  initial begin
    for (i = 0; i < (1 << ADDR_WIDTH); i = i + 1) mem[i] = 64'h0;
    // L-SIG: length=100, rate=0xB, parity=0 (even).
    mem[0] = 64'h00000000_00000C8B;
    // SERVICE field placeholder + the 8 bytes that historically held
    // the first part of the test pattern. Kept for symmetry with the
    // 24-byte packet ROM; openofdm_tx skips this word and starts PSDU
    // at word[2].
    mem[1] = 64'h08070605_04030201;
    // PSDU bytes 0..95 (96 bytes; openofdm_tx will replace bytes 96..99
    // with the computed FCS). Sequential 0x09..0x68 for easy visual
    // verification.
    mem[2]  = 64'h100F0E0D_0C0B0A09;  // 0x09 .. 0x10
    mem[3]  = 64'h18171615_14131211;  // 0x11 .. 0x18
    mem[4]  = 64'h201F1E1D_1C1B1A19;  // 0x19 .. 0x20
    mem[5]  = 64'h28272625_24232221;  // 0x21 .. 0x28
    mem[6]  = 64'h302F2E2D_2C2B2A29;  // 0x29 .. 0x30
    mem[7]  = 64'h38373635_34333231;  // 0x31 .. 0x38
    mem[8]  = 64'h403F3E3D_3C3B3A39;  // 0x39 .. 0x40
    mem[9]  = 64'h48474645_44434241;  // 0x41 .. 0x48
    mem[10] = 64'h504F4E4D_4C4B4A49;  // 0x49 .. 0x50
    mem[11] = 64'h58575655_54535251;  // 0x51 .. 0x58
    mem[12] = 64'h605F5E5D_5C5B5A59;  // 0x59 .. 0x60
    mem[13] = 64'h68676665_64636261;  // 0x61 .. 0x68
    // mem[14] first 4 bytes overwritten by FCS; rest = 0
  end

  always @(posedge clk) data_out <= mem[addr];

endmodule
