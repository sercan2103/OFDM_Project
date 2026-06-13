// tx_packet_rom_mcs.v -- 1024 x 64-bit synchronous ROM, multi-MCS variant.
//
// Stores 8 identical PSDU packets, one per 802.11a legacy rate, in
// consecutive 64-word blocks.  mcs_sel[2:0] (driven from system_top.v) is
// added as a 6-bit left-shifted base address so openofdm_tx always reads
// its sequential addresses 0,1,2,… but lands in the correct block.
//
// Block layout (each block = 64 words; only first 15 used):
//   word[base+0]  = L-SIG: rate, length=100, parity (per IEEE 802.11a spec)
//   word[base+1]  = SERVICE field placeholder (same for all rates)
//   word[base+2..13] = PSDU bytes 0..95 (0x09..0x68, same for all rates)
//   word[base+14] = FCS placeholder (overwritten by openofdm_tx at runtime)
//
// L-SIG bit layout (24 bits, zero-padded to 32 bits in lower half of word):
//   [3:0]  RATE     -- 4-bit IEEE 802.11a rate code
//   [4]    reserved -- must be 0
//   [16:5] LENGTH   -- 12 bits, LSB first, PSDU length in bytes (=100 here)
//   [17]   PARITY   -- even parity over bits [16:0]
//   [23:18] TAIL    -- 6 zeros
//
// For LENGTH=100 (0x64): bits[16:5] = 0x0C80 when combined with rate=0.
// Full base value before rate: bits[16:0] = 0x0C80.
// For each rate R: bits[16:0] = 0x0C80|R, parity = popcount(0x0C80|R) % 2.
//
// Rate table (mcs_sel → IEEE 802.11a rate field → modulation):
//   sel=0  rate=0xB  6 Mbps  BPSK  1/2   parity=0  L-SIG=0x00000C8B
//   sel=1  rate=0xF  9 Mbps  BPSK  3/4   parity=1  L-SIG=0x00020C8F
//   sel=2  rate=0xA 12 Mbps  QPSK  1/2   parity=1  L-SIG=0x00020C8A
//   sel=3  rate=0xE 18 Mbps  QPSK  3/4   parity=0  L-SIG=0x00000C8E
//   sel=4  rate=0x9 24 Mbps 16QAM  1/2   parity=1  L-SIG=0x00020C89
//   sel=5  rate=0xD 36 Mbps 16QAM  3/4   parity=0  L-SIG=0x00000C8D
//   sel=6  rate=0x8 48 Mbps 64QAM  2/3   parity=0  L-SIG=0x00000C88
//   sel=7  rate=0xC 54 Mbps 64QAM  3/4   parity=1  L-SIG=0x00020C8C
//
// Read latency: 1 clock (data_out is registered), same as tx_packet_rom.v.

`timescale 1ns / 1ps

module tx_packet_rom_mcs #(
  parameter ADDR_WIDTH = 10,
  parameter DATA_WIDTH = 64
) (
  input  wire                   clk,
  input  wire [ADDR_WIDTH-1:0]  addr,
  output reg  [DATA_WIDTH-1:0]  data_out
);

  (* ram_style = "block" *) reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

  // Shared PSDU content (bytes 0..95 = 0x09..0x68) + SERVICE word.
  // Words 2..13 carry the payload; word 14 is the FCS placeholder (0).
  // These are identical across all 8 rate blocks.
  localparam [63:0] W_SVC  = 64'h08070605_04030201;
  localparam [63:0] W_D00  = 64'h100F0E0D_0C0B0A09;
  localparam [63:0] W_D08  = 64'h18171615_14131211;
  localparam [63:0] W_D16  = 64'h201F1E1D_1C1B1A19;
  localparam [63:0] W_D24  = 64'h28272625_24232221;
  localparam [63:0] W_D32  = 64'h302F2E2D_2C2B2A29;
  localparam [63:0] W_D40  = 64'h38373635_34333231;
  localparam [63:0] W_D48  = 64'h403F3E3D_3C3B3A39;
  localparam [63:0] W_D56  = 64'h48474645_44434241;
  localparam [63:0] W_D64  = 64'h504F4E4D_4C4B4A49;
  localparam [63:0] W_D72  = 64'h58575655_54535251;
  localparam [63:0] W_D80  = 64'h605F5E5D_5C5B5A59;
  localparam [63:0] W_D88  = 64'h68676665_64636261;

  integer i, base;
  initial begin
    // Zero entire ROM first.
    for (i = 0; i < (1 << ADDR_WIDTH); i = i + 1) mem[i] = 64'h0;

    // ----------------------------------------------------------------
    // Block 0 -- sel=0: rate=0xB  6 Mbps  BPSK  1/2  parity=0
    // ----------------------------------------------------------------
    base = 0 * 64;
    mem[base +  0] = 64'h00000000_00000C8B;
    mem[base +  1] = W_SVC;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;
    // mem[base+14] = 0  (FCS; openofdm_tx overwrites at runtime)

    // ----------------------------------------------------------------
    // Block 1 -- sel=1: rate=0xF  9 Mbps  BPSK  3/4  parity=1
    // ----------------------------------------------------------------
    base = 1 * 64;
    mem[base +  0] = 64'h00000000_00020C8F;
    mem[base +  1] = W_SVC;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 2 -- sel=2: rate=0xA 12 Mbps  QPSK  1/2  parity=1
    // ----------------------------------------------------------------
    base = 2 * 64;
    mem[base +  0] = 64'h00000000_00020C8A;
    mem[base +  1] = W_SVC;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 3 -- sel=3: rate=0xE 18 Mbps  QPSK  3/4  parity=0
    // ----------------------------------------------------------------
    base = 3 * 64;
    mem[base +  0] = 64'h00000000_00000C8E;
    mem[base +  1] = W_SVC;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 4 -- sel=4: rate=0x9 24 Mbps 16QAM  1/2  parity=1
    // ----------------------------------------------------------------
    base = 4 * 64;
    mem[base +  0] = 64'h00000000_00020C89;
    mem[base +  1] = W_SVC;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 5 -- sel=5: rate=0xD 36 Mbps 16QAM  3/4  parity=0
    // ----------------------------------------------------------------
    base = 5 * 64;
    mem[base +  0] = 64'h00000000_00000C8D;
    mem[base +  1] = W_SVC;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 6 -- sel=6: rate=0x8 48 Mbps 64QAM  2/3  parity=0
    // ----------------------------------------------------------------
    base = 6 * 64;
    mem[base +  0] = 64'h00000000_00000C88;
    mem[base +  1] = W_SVC;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 7 -- sel=7: rate=0xC 54 Mbps 64QAM  3/4  parity=1
    // ----------------------------------------------------------------
    base = 7 * 64;
    mem[base +  0] = 64'h00000000_00020C8C;
    mem[base +  1] = W_SVC;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;
  end

  always @(posedge clk) data_out <= mem[addr];

endmodule
