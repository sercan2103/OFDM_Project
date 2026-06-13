// tx_packet_rom_ht_mcs.v -- 1024 x 64-bit synchronous ROM for 802.11n HT-MF.
//
// Stores 8 HT-MF packets, one per 802.11n MCS 0-7, in consecutive 64-word
// blocks.  mcs_sel[2:0] (gpio_o[2:0]) is multiplied by 64 as a base-address
// offset so openofdm_tx always reads sequential addresses 0,1,2,...
//
// Block layout (each block = 64 words; only first 16 used):
//   word[base+0]  = L-SIG word:  rate=0x0B (6 Mbps), length=100, parity=0,
//                                bit[24]=1 (PKT_TYPE=HT triggers dot11_tx.v
//                                to enter S1_HT_SIG state after L-SIG)
//   word[base+1]  = HT-SIG bits: bram_din[23:0]  = ht_sig1[23:0]
//                                                   [6:0]=MCS, [7]=CBW=0,
//                                                   [23:8]=HT-LENGTH=100
//                                bram_din[47:24] = ht_sig2[23:0]
//                                                   [2:0]={Rsvd,NotSnd,Smooth}
//                                                   = 3'b111 (Rsvd MUST=1),
//                                                   [17:10]=CRC8 (pre-computed)
//                                Transmitted raw: dot11_tx.v reads
//                                bram_din[plcp_bit_cnt] for bits 0..47.
//   word[base+2]  = first 8 PSDU bytes (same pattern as legacy ROM word 2)
//   word[base+3..14] = remaining PSDU bytes (same pattern as legacy)
//   word[base+15] = FCS placeholder (openofdm_tx CRC engine overwrites)
//
// HT-SIG CRC algorithm: 8-bit, polynomial 0x07 over ht_sig1[23:0] (24 bits)
// + ht_sig2[9:0] (10 bits), init=0xFF, output=bit-reversed complement.
// CRC pre-computed for HT-LENGTH=100, Smooth=1, NotSnd=1, Rsvd=1, all else 0.
//
// HT pkt_rate reported by openofdm_rx: {1'b1, ht_mcs[6:0]} = 0x80|mcs_index.
//
// Read latency: 1 clock (data_out is registered), same as tx_packet_rom_mcs.v.

`timescale 1ns / 1ps

module tx_packet_rom_ht_mcs #(
  parameter ADDR_WIDTH = 10,
  parameter DATA_WIDTH = 64
) (
  input  wire                   clk,
  input  wire [ADDR_WIDTH-1:0]  addr,
  output reg  [DATA_WIDTH-1:0]  data_out
);

  (* ram_style = "block" *) reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

  // Common L-SIG word for all HT blocks:
  //   rate=0x0B, length=100, parity=0  → lower 32 bits = 0x00000C8B
  //   bit[24] = PKT_TYPE = 1           → lower 32 bits = 0x01000C8B
  localparam [63:0] W_LSIG_HT = 64'h00000000_01000C8B;

  // PSDU data words (bytes 0x09..0x68, 96 bytes = 12 words of 8 bytes).
  // Identical to tx_packet_rom_mcs.v words 2..13.
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
    // Block 0 -- MCS 0: BPSK 1/2, 6.5 Mbps
    //   ht_sig1: MCS=0, CBW=0, HT-LENGTH=100  → 0x006400
    //   ht_sig2: Smooth=1, NotSnd=1, Rsvd=1, Aggr=0, STBC=0, FEC=0,
    //            SGI=0, NumExt=0, CRC=0x3F, Tail=0  → 0x00FC07
    //   word1 = {0x0000, ht_sig2[23:0], ht_sig1[23:0]}
    //         = 64'h000000FC07006400
    // ----------------------------------------------------------------
    base = 0 * 64;
    mem[base +  0] = W_LSIG_HT;
    mem[base +  1] = 64'h000000FC07006400;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;
    // mem[base+14] and beyond = 0 (FCS computed by openofdm_tx)

    // ----------------------------------------------------------------
    // Block 1 -- MCS 1: QPSK 1/2, 13.0 Mbps
    //   ht_sig1: MCS=1  → 0x006401
    //   CRC=0x1C → ht_sig2 = 0x007007
    //   word1 = 64'h0000007007006401
    // ----------------------------------------------------------------
    base = 1 * 64;
    mem[base +  0] = W_LSIG_HT;
    mem[base +  1] = 64'h0000007007006401;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 2 -- MCS 2: QPSK 3/4, 19.5 Mbps
    //   ht_sig1: MCS=2  → 0x006402
    //   CRC=0x79 → word1 = 64'h000001E407006402
    // ----------------------------------------------------------------
    base = 2 * 64;
    mem[base +  0] = W_LSIG_HT;
    mem[base +  1] = 64'h000001E407006402;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 3 -- MCS 3: 16-QAM 1/2, 26.0 Mbps
    //   ht_sig1: MCS=3  → 0x006403
    //   CRC=0x5A → word1 = 64'h0000016807006403
    // ----------------------------------------------------------------
    base = 3 * 64;
    mem[base +  0] = W_LSIG_HT;
    mem[base +  1] = 64'h0000016807006403;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 4 -- MCS 4: 16-QAM 3/4, 39.0 Mbps
    //   ht_sig1: MCS=4  → 0x006404
    //   CRC=0xB3 → word1 = 64'h000002CC07006404
    // ----------------------------------------------------------------
    base = 4 * 64;
    mem[base +  0] = W_LSIG_HT;
    mem[base +  1] = 64'h000002CC07006404;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 5 -- MCS 5: 64-QAM 2/3, 52.0 Mbps
    //   ht_sig1: MCS=5  → 0x006405
    //   CRC=0x90 → word1 = 64'h0000024007006405
    // ----------------------------------------------------------------
    base = 5 * 64;
    mem[base +  0] = W_LSIG_HT;
    mem[base +  1] = 64'h0000024007006405;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 6 -- MCS 6: 64-QAM 3/4, 58.5 Mbps
    //   ht_sig1: MCS=6  → 0x006406
    //   CRC=0xF5 → word1 = 64'h000003D407006406
    // ----------------------------------------------------------------
    base = 6 * 64;
    mem[base +  0] = W_LSIG_HT;
    mem[base +  1] = 64'h000003D407006406;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;

    // ----------------------------------------------------------------
    // Block 7 -- MCS 7: 64-QAM 5/6, 65.0 Mbps
    //   ht_sig1: MCS=7  → 0x006407
    //   CRC=0xD6 → word1 = 64'h0000035807006407
    // ----------------------------------------------------------------
    base = 7 * 64;
    mem[base +  0] = W_LSIG_HT;
    mem[base +  1] = 64'h0000035807006407;
    mem[base +  2] = W_D00; mem[base +  3] = W_D08;
    mem[base +  4] = W_D16; mem[base +  5] = W_D24;
    mem[base +  6] = W_D32; mem[base +  7] = W_D40;
    mem[base +  8] = W_D48; mem[base +  9] = W_D56;
    mem[base + 10] = W_D64; mem[base + 11] = W_D72;
    mem[base + 12] = W_D80; mem[base + 13] = W_D88;
  end

  always @(posedge clk) data_out <= mem[addr];

endmodule
