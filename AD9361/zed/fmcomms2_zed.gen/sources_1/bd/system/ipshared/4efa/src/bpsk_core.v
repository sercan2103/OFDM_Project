`timescale 1ns / 1ps
// =============================================================================
// bpsk_core.v  –  BPSK Modulator Core
//
// Produces a continuous 64-bit AXI-Stream of I/Q samples compatible with the
// Analog Devices util_ad9361_dac_upack input format:
//   tdata[15: 0] = I0  (TX channel 1, BPSK symbol)
//   tdata[31:16] = Q0  (TX channel 1, always 0 for BPSK)
//   tdata[47:32] = I1  (TX channel 2, copied or zeroed via cfg_ch_sel)
//   tdata[63:48] = Q1  (TX channel 2, always 0 for BPSK)
//
// Symbol mapping:
//   data bit = 0  →  I = cfg_i_pos (default 0x7FFF, +full scale)
//   data bit = 1  →  I = cfg_i_neg (default 0x8001, –full scale)
//   Q           = 0x0000 (pure real baseband; AD9361 NCO mixes to RF)
//
// Bit sources (cfg_src_sel):
//   2'b00  Alternating: 0,1,0,1,… (test)
//   2'b01  32-bit register pattern from cfg_pat_data, cycled MSB-first
//   2'b10  AXI-Stream 1-bit serial: one bit per beat via s_axis_bits
//   2'b11  Same as 00
//
// Symbol rate = aclk_freq / cfg_sym_div  (minimum cfg_sym_div = 1)
// =============================================================================

module bpsk_core (
    input  wire        aclk,
    input  wire        aresetn,

    // ---- Configuration (same clock domain as aclk) -------------------------
    input  wire        cfg_enable,
    input  wire [1:0]  cfg_src_sel,
    input  wire        cfg_ch_sel,    // 0 = TX1 only;  1 = TX1+TX2 same symbol
    input  wire [15:0] cfg_sym_div,   // clocks per symbol (≥1)
    input  wire [15:0] cfg_i_pos,     // I value when data bit = 0
    input  wire [15:0] cfg_i_neg,     // I value when data bit = 1
    input  wire [31:0] cfg_pat_data,  // 32-bit pattern for SRC_SEL=01

    // ---- AXI-Stream bit input (SRC_SEL = 2'b10) ----------------------------
    // One bit per beat; only tdata[0] is used.
    // tready is asserted for exactly one clock per symbol period.
    input  wire [7:0]  s_axis_bits_tdata,
    input  wire        s_axis_bits_tvalid,
    output wire        s_axis_bits_tready,

    // ---- AXI-Stream DMA bypass input ---------------------------------------
    // Passed straight through to m_axis when cfg_enable = 0.
    // Silently consumed (tready=1) when cfg_enable = 1 so the DMA does
    // not stall – simply stop the DMA before enabling BPSK.
    input  wire [63:0] s_axis_dma_tdata,
    input  wire        s_axis_dma_tvalid,
    output wire        s_axis_dma_tready,
    input  wire        s_axis_dma_tlast,
    input  wire [7:0]  s_axis_dma_tkeep,

    // ---- AXI-Stream DAC output (to util_ad9361_dac_upack) ------------------
    output reg  [63:0] m_axis_dac_tdata,
    output reg         m_axis_dac_tvalid,
    input  wire        m_axis_dac_tready,
    output wire        m_axis_dac_tlast,
    output wire [7:0]  m_axis_dac_tkeep,

    // ---- Diagnostics -------------------------------------------------------
    output reg  [39:0] sym_count        // 40-bit transmitted symbol counter
);

    // =========================================================================
    // Symbol-rate divider counter
    // Counts cfg_sym_div clocks between symbols.
    // Advances only when the downstream is ready (backpressure aware).
    // =========================================================================
    reg  [15:0] div_cnt;
    wire        sym_tick; // one-cycle pulse: time to output the next symbol

    always @(posedge aclk) begin
        if (!aresetn || !cfg_enable) begin
            div_cnt <= 16'd0;
        end else if (m_axis_dac_tready) begin
            if (div_cnt == 16'd0)
                div_cnt <= (cfg_sym_div > 16'd1) ? cfg_sym_div - 16'd1 : 16'd0;
            else
                div_cnt <= div_cnt - 16'd1;
        end
    end

    assign sym_tick = cfg_enable && m_axis_dac_tready && (div_cnt == 16'd0);

    // =========================================================================
    // Bit source 0 – alternating test pattern
    // =========================================================================
    reg alt_bit;

    always @(posedge aclk) begin
        if (!aresetn)  alt_bit <= 1'b0;
        else if (sym_tick) alt_bit <= ~alt_bit;
    end

    // =========================================================================
    // Bit source 1 – 32-bit AXI-Lite register pattern (MSB first, repeating)
    // =========================================================================
    reg [4:0] pat_idx;   // index into cfg_pat_data, counts 31 → 0 → 31 → …

    always @(posedge aclk) begin
        if (!aresetn) begin
            pat_idx <= 5'd31;
        end else if (sym_tick && (cfg_src_sel == 2'b01)) begin
            pat_idx <= (pat_idx == 5'd0) ? 5'd31 : pat_idx - 5'd1;
        end
    end

    wire pat_bit = cfg_pat_data[pat_idx];

    // =========================================================================
    // Bit source 2 – AXI-Stream serial input (1 bit per beat)
    // Accept one new bit on each sym_tick where src_sel = 2.
    // If tvalid is not asserted when we need a bit, repeat last bit.
    // =========================================================================
    reg axis_bit;

    assign s_axis_bits_tready = cfg_enable && (cfg_src_sel == 2'b10) && sym_tick;

    always @(posedge aclk) begin
        if (!aresetn) begin
            axis_bit <= 1'b0;
        end else if (sym_tick && (cfg_src_sel == 2'b10) && s_axis_bits_tvalid) begin
            axis_bit <= s_axis_bits_tdata[0];
        end
    end

    // =========================================================================
    // Bit MUX – select current data bit
    // =========================================================================
    reg current_bit;

    always @(*) begin
        case (cfg_src_sel)
            2'b01:   current_bit = pat_bit;
            2'b10:   current_bit = axis_bit;
            default: current_bit = alt_bit;  // 2'b00 and 2'b11
        endcase
    end

    // =========================================================================
    // BPSK symbol register – holds stable I value between ticks
    // =========================================================================
    reg [15:0] i_hold;

    always @(posedge aclk) begin
        if (!aresetn) begin
            i_hold <= 16'h7FFF;   // default: positive symbol
        end else if (sym_tick) begin
            i_hold <= current_bit ? cfg_i_neg : cfg_i_pos;
        end
    end

    // Pack 64-bit BPSK beat
    wire [63:0] bpsk_beat;
    assign bpsk_beat[15: 0] = i_hold;                            // I0
    assign bpsk_beat[31:16] = 16'h0000;                          // Q0 = 0
    assign bpsk_beat[47:32] = cfg_ch_sel ? i_hold : 16'h0000;    // I1
    assign bpsk_beat[63:48] = 16'h0000;                          // Q1 = 0

    // =========================================================================
    // Output MUX – BPSK or DMA bypass
    // When BPSK is enabled:  drive m_axis from bpsk_beat (always valid)
    //                         silently consume DMA data (tready = 1)
    // When BPSK is disabled: pass DMA stream through with no latency
    // =========================================================================
    assign s_axis_dma_tready = cfg_enable ? 1'b1 : m_axis_dac_tready;

    always @(posedge aclk) begin
        if (!aresetn) begin
            m_axis_dac_tdata  <= 64'd0;
            m_axis_dac_tvalid <= 1'b0;
        end else begin
            if (cfg_enable) begin
                m_axis_dac_tdata  <= bpsk_beat;
                m_axis_dac_tvalid <= 1'b1;      // always streaming when enabled
            end else begin
                m_axis_dac_tdata  <= s_axis_dma_tdata;
                m_axis_dac_tvalid <= s_axis_dma_tvalid;
            end
        end
    end

    // TLAST / TKEEP passthrough (DAC path does not use TLAST; tie 0 in BPSK mode)
    assign m_axis_dac_tlast = cfg_enable ? 1'b0       : s_axis_dma_tlast;
    assign m_axis_dac_tkeep = cfg_enable ? 8'hFF      : s_axis_dma_tkeep;

    // =========================================================================
    // 40-bit symbol counter (wraps)
    // =========================================================================
    always @(posedge aclk) begin
        if (!aresetn || !cfg_enable) begin
            sym_count <= 40'd0;
        end else if (sym_tick) begin
            sym_count <= sym_count + 40'd1;
        end
    end

endmodule
