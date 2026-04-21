`timescale 1ns / 1ps
// =============================================================================
// bpsk_modulator_v1_0.v  –  BPSK Modulator IP Top-Level
//
// Combines an AXI4-Lite register file with the BPSK modulator core.
// Intended to replace (or MUX with) the DAC DMA AXI-Stream output in the
// FMCOMM2 / AD9361 reference design on the ZED board.
//
// ---- AXI4-Lite Register Map (32-bit, word-addressed) -----------------------
//
//  Offset  Name          Access  Reset          Description
//  ------  ----------    ------  -------------  ----------------------------
//  0x00    CTRL          R/W     0x0000_0000    Control register
//            [0]   ENABLE     Master enable (1 = BPSK active)
//            [2:1] SRC_SEL    Bit source select (see below)
//            [3]   CH_SEL     Channel select (0=TX1 only, 1=TX1+TX2)
//
//  0x04    STATUS        RO      0x0000_0001    Status register
//            [0]   READY      Always 1 (IP is operational)
//            [1]   ACTIVE     1 when ENABLE=1 and outputting symbols
//            [2]   FIFO_REQ   1 when waiting for S_AXIS_BITS data
//
//  0x08    SYM_DIV       R/W     0x0000_0008    Symbol rate divider
//            [15:0] DIVIDER   Symbol period in clock cycles (min 1)
//            Example: 100 MHz / 8 = 12.5 Msym/s
//
//  0x0C    AMPLITUDE     R/W     0x7FFF_8001    I values for BPSK symbols
//            [15: 0] I_NEG    I value for data bit=1 (default 0x8001 = -32767)
//            [31:16] I_POS    I value for data bit=0 (default 0x7FFF = +32767)
//
//  0x10    PAT_DATA      R/W     0x55AA_55AA    32-bit repeating bit pattern
//            [31:0]  PATTERN  Used when SRC_SEL=01, cycled MSB-first
//
//  0x14    FIFO_CTRL     R/W     0x0000_0000    (reserved for future use)
//
//  0x18    SYM_CNT_LO   RO      0x0000_0000    Symbol counter [31:0]
//  0x1C    SYM_CNT_HI   RO      0x0000_0000    Symbol counter [39:32]
//
//  0x20    IP_VERSION   RO      0x0001_0000    Version 1.0.0 (major.minor.patch)
//
// ---- SRC_SEL values --------------------------------------------------------
//  2'b00  Alternating 0/1 test pattern
//  2'b01  32-bit register pattern (PAT_DATA), MSB-first, repeating
//  2'b10  AXI4-Stream serial input (S_AXIS_BITS, 1 bit per beat at tdata[0])
//  2'b11  Same as 00
//
// ---- Integration notes (FMCOMM2 ZED) --------------------------------------
// 1. Connect aclk        → util_ad9361_divclk (same clock as dac_upack)
//    Connect aresetn     → synchronized reset for the above clock domain
//    Connect S_AXI_ACLK  → sys_cpu_clk (100 MHz) — SEPARATE AXI bus clock
//    Connect S_AXI_ARESETN → sys_cpu_resetn
//
//    NOTE: S_AXI runs at 100 MHz; data-path (aclk) runs at ~245 MHz.
//    The register CDC is handled internally via two-FF synchronizers.
//    Assign base address 0x4380_0000 in the Vivado address editor.
//
// 2. Data-path connections:
//    S_AXIS_DMA_*  ← disconnect from axi_ad9361_dac_dma M_AXIS, connect here
//    M_AXIS_DAC_*  → util_ad9361_dac_upack S_AXIS  (replaces DMA direct link)
//
// 3. AXI4-Lite:
//    S_AXI_*  → add new master port on axi_cpu_interconnect (e.g. M11_AXI)
// =============================================================================

module bpsk_modulator_v1_0 #(
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    parameter integer C_S_AXI_ADDR_WIDTH = 8    // covers 0x00..0xFF
)(
    // ---- Data-path clock / reset -------------------------------------------
    // Connect to the same clock that drives util_ad9361_dac_upack S_AXIS.
    // In the ADI reference design this is util_ad9361_divclk (~245 MHz).
    input  wire        aclk,
    input  wire        aresetn,

    // ---- AXI4-Lite slave clock / reset (100 MHz system bus) ----------------
    input  wire        S_AXI_ACLK,
    input  wire        S_AXI_ARESETN,

    // ---- AXI4-Lite write address channel -----------------------------------
    input  wire [C_S_AXI_ADDR_WIDTH-1:0]   S_AXI_AWADDR,
    input  wire [2:0]                       S_AXI_AWPROT,
    input  wire                             S_AXI_AWVALID,
    output wire                             S_AXI_AWREADY,

    // ---- AXI4-Lite write data channel --------------------------------------
    input  wire [C_S_AXI_DATA_WIDTH-1:0]   S_AXI_WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] S_AXI_WSTRB,
    input  wire                             S_AXI_WVALID,
    output wire                             S_AXI_WREADY,

    // ---- AXI4-Lite write response channel ----------------------------------
    output wire [1:0]                       S_AXI_BRESP,
    output wire                             S_AXI_BVALID,
    input  wire                             S_AXI_BREADY,

    // ---- AXI4-Lite read address channel ------------------------------------
    input  wire [C_S_AXI_ADDR_WIDTH-1:0]   S_AXI_ARADDR,
    input  wire [2:0]                       S_AXI_ARPROT,
    input  wire                             S_AXI_ARVALID,
    output wire                             S_AXI_ARREADY,

    // ---- AXI4-Lite read data channel ---------------------------------------
    output wire [C_S_AXI_DATA_WIDTH-1:0]   S_AXI_RDATA,
    output wire [1:0]                       S_AXI_RRESP,
    output wire                             S_AXI_RVALID,
    input  wire                             S_AXI_RREADY,

    // ---- AXI4-Stream: bit input (SRC_SEL = 2'b10, optional) ---------------
    input  wire [7:0]  S_AXIS_BITS_TDATA,   // only tdata[0] used
    input  wire        S_AXIS_BITS_TVALID,
    output wire        S_AXIS_BITS_TREADY,

    // ---- AXI4-Stream: DMA bypass input -------------------------------------
    input  wire [63:0] S_AXIS_DMA_TDATA,
    input  wire        S_AXIS_DMA_TVALID,
    output wire        S_AXIS_DMA_TREADY,
    input  wire        S_AXIS_DMA_TLAST,
    input  wire [7:0]  S_AXIS_DMA_TKEEP,

    // ---- AXI4-Stream: DAC output (to util_ad9361_dac_upack) ---------------
    output wire [63:0] M_AXIS_DAC_TDATA,
    output wire        M_AXIS_DAC_TVALID,
    input  wire        M_AXIS_DAC_TREADY,
    output wire        M_AXIS_DAC_TLAST,
    output wire [7:0]  M_AXIS_DAC_TKEEP
);

    // =========================================================================
    // AXI4-Lite register file  (runs at S_AXI_ACLK = 100 MHz)
    // =========================================================================

    // --- Write FSM registers -------------------------------------------------
    reg                             aw_done;
    reg  [C_S_AXI_ADDR_WIDTH-1:0]  aw_addr;
    reg                             w_done;
    reg  [C_S_AXI_DATA_WIDTH-1:0]  w_data;
    reg  [C_S_AXI_DATA_WIDTH/8-1:0] w_strb;
    reg                             axi_awready;
    reg                             axi_wready;
    reg                             axi_bvalid;
    reg                             axi_arready;
    reg  [C_S_AXI_DATA_WIDTH-1:0]  axi_rdata;
    reg                             axi_rvalid;

    assign S_AXI_AWREADY = axi_awready;
    assign S_AXI_WREADY  = axi_wready;
    assign S_AXI_BRESP   = 2'b00;        // always OKAY
    assign S_AXI_BVALID  = axi_bvalid;
    assign S_AXI_ARREADY = axi_arready;
    assign S_AXI_RDATA   = axi_rdata;
    assign S_AXI_RRESP   = 2'b00;
    assign S_AXI_RVALID  = axi_rvalid;

    // --- R/W config registers (in AXI clock domain) -------------------------
    reg        axireg_enable;
    reg [1:0]  axireg_src_sel;
    reg        axireg_ch_sel;
    reg [15:0] axireg_sym_div;
    reg [15:0] axireg_i_pos;
    reg [15:0] axireg_i_neg;
    reg [31:0] axireg_pat_data;

    // --- AW channel ----------------------------------------------------------
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            axi_awready <= 1'b0;
            aw_done     <= 1'b0;
            aw_addr     <= {C_S_AXI_ADDR_WIDTH{1'b0}};
        end else begin
            if (!aw_done && S_AXI_AWVALID) begin
                axi_awready <= 1'b1;
                aw_addr     <= S_AXI_AWADDR;
                aw_done     <= 1'b1;
            end else begin
                axi_awready <= 1'b0;
            end
            if (axi_bvalid && S_AXI_BREADY)
                aw_done <= 1'b0;
        end
    end

    // --- W channel -----------------------------------------------------------
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            axi_wready <= 1'b0;
            w_done     <= 1'b0;
            w_data     <= {C_S_AXI_DATA_WIDTH{1'b0}};
            w_strb     <= {C_S_AXI_DATA_WIDTH/8{1'b0}};
        end else begin
            if (!w_done && S_AXI_WVALID) begin
                axi_wready <= 1'b1;
                w_data     <= S_AXI_WDATA;
                w_strb     <= S_AXI_WSTRB;
                w_done     <= 1'b1;
            end else begin
                axi_wready <= 1'b0;
            end
            if (axi_bvalid && S_AXI_BREADY)
                w_done <= 1'b0;
        end
    end

    // --- Write apply + B response --------------------------------------------
    wire do_write = aw_done && w_done && !axi_bvalid;

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            axi_bvalid       <= 1'b0;
            axireg_enable    <= 1'b0;
            axireg_src_sel   <= 2'b00;
            axireg_ch_sel    <= 1'b0;
            axireg_sym_div   <= 16'd8;
            axireg_i_pos     <= 16'h7FFF;
            axireg_i_neg     <= 16'h8001;
            axireg_pat_data  <= 32'h55AA_55AA;
        end else begin
            if (do_write) begin
                axi_bvalid <= 1'b1;
                case (aw_addr[7:2])
                    6'h00: begin  // CTRL @ 0x00
                        if (w_strb[0]) begin
                            axireg_enable  <= w_data[0];
                            axireg_src_sel <= w_data[2:1];
                            axireg_ch_sel  <= w_data[3];
                        end
                    end
                    6'h02: begin  // SYM_DIV @ 0x08 (16-bit in [15:0])
                        if (w_strb[0]) axireg_sym_div[7:0]  <= w_data[7:0];
                        if (w_strb[1]) axireg_sym_div[15:8] <= w_data[15:8];
                    end
                    6'h03: begin  // AMPLITUDE @ 0x0C ([15:0]=I_NEG, [31:16]=I_POS)
                        if (w_strb[0]) axireg_i_neg[7:0]  <= w_data[7:0];
                        if (w_strb[1]) axireg_i_neg[15:8] <= w_data[15:8];
                        if (w_strb[2]) axireg_i_pos[7:0]  <= w_data[23:16];
                        if (w_strb[3]) axireg_i_pos[15:8] <= w_data[31:24];
                    end
                    6'h04: begin  // PAT_DATA @ 0x10
                        if (w_strb[0]) axireg_pat_data[7:0]   <= w_data[7:0];
                        if (w_strb[1]) axireg_pat_data[15:8]  <= w_data[15:8];
                        if (w_strb[2]) axireg_pat_data[23:16] <= w_data[23:16];
                        if (w_strb[3]) axireg_pat_data[31:24] <= w_data[31:24];
                    end
                    default: ; // ignore writes to RO / reserved regs
                endcase
            end else if (S_AXI_BREADY) begin
                axi_bvalid <= 1'b0;
            end
        end
    end

    // --- Read channel --------------------------------------------------------
    wire [39:0] sym_count_sync;  // from data-path domain, synchronized below
    wire        active_sync;

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            axi_arready <= 1'b0;
            axi_rvalid  <= 1'b0;
            axi_rdata   <= {C_S_AXI_DATA_WIDTH{1'b0}};
        end else begin
            if (S_AXI_ARVALID && !axi_arready) begin
                axi_arready <= 1'b1;
                axi_rvalid  <= 1'b1;
                case (S_AXI_ARADDR[7:2])
                    6'h00: axi_rdata <= {28'd0, axireg_ch_sel,
                                               axireg_src_sel,
                                               axireg_enable};         // CTRL
                    6'h01: axi_rdata <= {29'd0,                        // STATUS
                                         active_sync,       // [1]
                                         1'b1};             // [0] READY
                    6'h02: axi_rdata <= {16'd0, axireg_sym_div};       // SYM_DIV
                    6'h03: axi_rdata <= {axireg_i_pos, axireg_i_neg};  // AMPLITUDE
                    6'h04: axi_rdata <= axireg_pat_data;               // PAT_DATA
                    6'h05: axi_rdata <= 32'd0;                         // FIFO_CTRL
                    6'h06: axi_rdata <= sym_count_sync[31:0];          // SYM_CNT_LO
                    6'h07: axi_rdata <= {24'd0,sym_count_sync[39:32]}; // SYM_CNT_HI
                    6'h08: axi_rdata <= 32'h0001_0000;                 // IP_VERSION
                    default: axi_rdata <= 32'hDEAD_BEEF;
                endcase
            end else begin
                axi_arready <= 1'b0;
            end
            if (axi_rvalid && S_AXI_RREADY)
                axi_rvalid <= 1'b0;
        end
    end

    // =========================================================================
    // CDC – 2-FF synchronizers: S_AXI_ACLK → aclk (config registers)
    // Multi-bit registers use a write-strobe pulse + double-buffer scheme.
    // =========================================================================

    // Pulse synchronizer for "new config written" (wr_pulse → aclk domain)
    reg  wr_pulse_axi;    // set on any write in AXI domain, clears after 1 cycle
    wire wr_pulse_core;   // received pulse in aclk domain

    always @(posedge S_AXI_ACLK)
        wr_pulse_axi <= do_write;  // 1 cycle wide

    // 2-FF pulse synchronizer
    reg [1:0] wr_pulse_sync;
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) wr_pulse_sync <= 2'b00;
        else          wr_pulse_sync <= {wr_pulse_sync[0], wr_pulse_axi};
    end
    assign wr_pulse_core = wr_pulse_sync[1];

    // Holding registers in AXI domain (stable snapshot)
    reg        snap_enable;
    reg [1:0]  snap_src_sel;
    reg        snap_ch_sel;
    reg [15:0] snap_sym_div;
    reg [15:0] snap_i_pos;
    reg [15:0] snap_i_neg;
    reg [31:0] snap_pat_data;

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            snap_enable   <= 1'b0;
            snap_src_sel  <= 2'b00;
            snap_ch_sel   <= 1'b0;
            snap_sym_div  <= 16'd8;
            snap_i_pos    <= 16'h7FFF;
            snap_i_neg    <= 16'h8001;
            snap_pat_data <= 32'h55AA_55AA;
        end else begin
            snap_enable   <= axireg_enable;
            snap_src_sel  <= axireg_src_sel;
            snap_ch_sel   <= axireg_ch_sel;
            snap_sym_div  <= axireg_sym_div;
            snap_i_pos    <= axireg_i_pos;
            snap_i_neg    <= axireg_i_neg;
            snap_pat_data <= axireg_pat_data;
        end
    end

    // Latch in aclk domain on received write pulse
    reg        core_enable;
    reg [1:0]  core_src_sel;
    reg        core_ch_sel;
    reg [15:0] core_sym_div;
    reg [15:0] core_i_pos;
    reg [15:0] core_i_neg;
    reg [31:0] core_pat_data;

    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            core_enable   <= 1'b0;
            core_src_sel  <= 2'b00;
            core_ch_sel   <= 1'b0;
            core_sym_div  <= 16'd8;
            core_i_pos    <= 16'h7FFF;
            core_i_neg    <= 16'h8001;
            core_pat_data <= 32'h55AA_55AA;
        end else if (wr_pulse_core) begin
            core_enable   <= snap_enable;
            core_src_sel  <= snap_src_sel;
            core_ch_sel   <= snap_ch_sel;
            core_sym_div  <= snap_sym_div;
            core_i_pos    <= snap_i_pos;
            core_i_neg    <= snap_i_neg;
            core_pat_data <= snap_pat_data;
        end
    end

    // =========================================================================
    // CDC – 2-FF synchronizers: aclk → S_AXI_ACLK (status back-sync)
    // =========================================================================
    wire [39:0] sym_count_raw;
    wire        active_raw = core_enable;

    // Simple 2-FF for single-bit active status
    reg [1:0] active_ff;
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) active_ff <= 2'b00;
        else                 active_ff <= {active_ff[0], active_raw};
    end
    assign active_sync = active_ff[1];

    // For sym_count (40-bit), we just sync the 40 bits; small chance of
    // metastability glitch is acceptable for a diagnostic counter.
    reg [39:0] sym_cnt_ff1, sym_cnt_ff2;
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            sym_cnt_ff1 <= 40'd0;
            sym_cnt_ff2 <= 40'd0;
        end else begin
            sym_cnt_ff1 <= sym_count_raw;
            sym_cnt_ff2 <= sym_cnt_ff1;
        end
    end
    assign sym_count_sync = sym_cnt_ff2;

    // =========================================================================
    // BPSK core instantiation
    // =========================================================================
    bpsk_core u_bpsk_core (
        .aclk                   (aclk),
        .aresetn                (aresetn),

        .cfg_enable             (core_enable),
        .cfg_src_sel            (core_src_sel),
        .cfg_ch_sel             (core_ch_sel),
        .cfg_sym_div            (core_sym_div),
        .cfg_i_pos              (core_i_pos),
        .cfg_i_neg              (core_i_neg),
        .cfg_pat_data           (core_pat_data),

        .s_axis_bits_tdata      (S_AXIS_BITS_TDATA),
        .s_axis_bits_tvalid     (S_AXIS_BITS_TVALID),
        .s_axis_bits_tready     (S_AXIS_BITS_TREADY),

        .s_axis_dma_tdata       (S_AXIS_DMA_TDATA),
        .s_axis_dma_tvalid      (S_AXIS_DMA_TVALID),
        .s_axis_dma_tready      (S_AXIS_DMA_TREADY),
        .s_axis_dma_tlast       (S_AXIS_DMA_TLAST),
        .s_axis_dma_tkeep       (S_AXIS_DMA_TKEEP),

        .m_axis_dac_tdata       (M_AXIS_DAC_TDATA),
        .m_axis_dac_tvalid      (M_AXIS_DAC_TVALID),
        .m_axis_dac_tready      (M_AXIS_DAC_TREADY),
        .m_axis_dac_tlast       (M_AXIS_DAC_TLAST),
        .m_axis_dac_tkeep       (M_AXIS_DAC_TKEEP),

        .sym_count              (sym_count_raw)
    );

endmodule
