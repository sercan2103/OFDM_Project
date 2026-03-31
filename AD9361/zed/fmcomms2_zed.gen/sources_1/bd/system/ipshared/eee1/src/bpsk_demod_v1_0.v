`timescale 1ns / 1ps
// =============================================================================
// bpsk_demod_v1_0.v  –  BPSK Demodulator IP Top-Level
//
// AXI4-Lite register file + CDC + instantiation of bpsk_demod_core.
// Taps the ADC FIFO_WR bus from util_ad9361_adc_pack (proprietary ADI interface)
// and outputs decoded bytes on an AXI4-Stream master port.
//
// ---- AXI4-Lite Register Map (32-bit, word-addressed, base 0x43C0_0000) ------
//
//  Offset  Name          Access  Reset       Description
//  ------  ----------    ------  ----------  ---------------------------------
//  0x00    CTRL          R/W     0x0000_0000  Control register
//            [0]   ENABLE          Master enable
//            [1]   BYPASS_AGC      1 = skip AGC, pass I/Q unchanged
//            [2]   BYPASS_COSTAS   1 = skip Costas loop
//            [3]   BYPASS_TIMING   1 = skip timing recovery
//
//  0x04    STATUS        RO      0x0000_0001  Status register
//            [0]   READY           Always 1
//            [1]   ACTIVE          ENABLE=1 and demodulating
//            [2]   CARRIER_LOCKED  Costas loop locked
//            [3]   AGC_SETTLED     AGC within 12.5% of target
//
//  0x08    SPS           R/W     0x0000_0008  [7:0] Samples per symbol (2–128)
//
//  0x0C    AGC_TARGET    R/W     0x0000_2000  [15:0] AGC target amplitude (Q1.15)
//
//  0x10    AGC_GAIN      RO      —            [15:0] Current AGC gain (Q4.12, 0x1000=1.0)
//            Also [19:16] = ki_shift (write: [19:16] sets AGC integral gain shift)
//
//  0x14    COSTAS_KP     R/W     0x0000_0040  [15:0] Costas proportional gain
//
//  0x18    COSTAS_KI     R/W     0x0000_0008  [15:0] Costas integral gain
//
//  0x1C    TIMING_KP     R/W     0x0000_0020  [15:0] Timing proportional gain
//
//  0x20    TIMING_KI     R/W     0x0000_0004  [15:0] Timing integral gain
//
//  0x24    PHASE_ERR     RO      —            [15:0] Costas phase error (signed, diagnostic)
//
//  0x28    TIMING_ERR    RO      —            [15:0] Timing error (signed, diagnostic)
//
//  0x2C    BIT_CNT_LO    RO      —            [31:0] Decoded bit counter [31:0]
//
//  0x30    BIT_CNT_HI    RO      —            [7:0] Decoded bit counter [39:32]
//
//  0x34    IP_VERSION    RO      0x0001_0000  Version 1.0.0
//
// ---- Integration notes (FMCOMM2 ZED) ----------------------------------------
//  aclk         → util_ad9361_divclk  (~245 MHz, same as adc_pack output)
//  aresetn      → sys_cpu_resetn
//  S_AXI_ACLK   → sys_cpu_clk (100 MHz)
//  S_AXI_ARESETN → sys_cpu_resetn
//  adc_data[63:0] → util_ad9361_adc_pack/packed_fifo_wr_data
//  adc_valid      → util_ad9361_adc_pack/packed_fifo_wr_en
//  S_AXI_*      → axi_cpu_interconnect/M12_AXI
//  Base address : 0x43C0_0000 (64 K range)
// =============================================================================

module bpsk_demod_v1_0 #(
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    parameter integer C_S_AXI_ADDR_WIDTH = 8    // covers 0x00..0xFF
)(
    // ---- Data-path clock / reset (util_ad9361_divclk domain, ~245 MHz) ------
    input  wire        aclk,
    input  wire        aresetn,

    // ---- AXI4-Lite slave clock / reset (sys_cpu_clk, 100 MHz) --------------
    input  wire        S_AXI_ACLK,
    input  wire        S_AXI_ARESETN,

    // ---- AXI4-Lite write address channel ------------------------------------
    input  wire [C_S_AXI_ADDR_WIDTH-1:0]   S_AXI_AWADDR,
    input  wire [2:0]                       S_AXI_AWPROT,
    input  wire                             S_AXI_AWVALID,
    output wire                             S_AXI_AWREADY,

    // ---- AXI4-Lite write data channel ---------------------------------------
    input  wire [C_S_AXI_DATA_WIDTH-1:0]   S_AXI_WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] S_AXI_WSTRB,
    input  wire                             S_AXI_WVALID,
    output wire                             S_AXI_WREADY,

    // ---- AXI4-Lite write response channel -----------------------------------
    output wire [1:0]                       S_AXI_BRESP,
    output wire                             S_AXI_BVALID,
    input  wire                             S_AXI_BREADY,

    // ---- AXI4-Lite read address channel -------------------------------------
    input  wire [C_S_AXI_ADDR_WIDTH-1:0]   S_AXI_ARADDR,
    input  wire [2:0]                       S_AXI_ARPROT,
    input  wire                             S_AXI_ARVALID,
    output wire                             S_AXI_ARREADY,

    // ---- AXI4-Lite read data channel ----------------------------------------
    output wire [C_S_AXI_DATA_WIDTH-1:0]   S_AXI_RDATA,
    output wire [1:0]                       S_AXI_RRESP,
    output wire                             S_AXI_RVALID,
    input  wire                             S_AXI_RREADY,

    // ---- ADC tap (FIFO_WR from util_ad9361_adc_pack) ------------------------
    // Connect without breaking the existing adc_pack → adc_dma link.
    input  wire [63:0] adc_data,   // [15:0]=I0, [31:16]=Q0, [47:32]=I1, [63:48]=Q1
    input  wire        adc_valid,  // packed_fifo_wr_en

    // ---- AXI4-Stream: decoded byte output -----------------------------------
    output wire [7:0]  M_AXIS_BITS_TDATA,
    output wire        M_AXIS_BITS_TVALID,
    input  wire        M_AXIS_BITS_TREADY
);

    // =========================================================================
    // AXI4-Lite register file  (S_AXI_ACLK = 100 MHz)
    // =========================================================================

    // --- Write FSM -----------------------------------------------------------
    reg                              aw_done;
    reg  [C_S_AXI_ADDR_WIDTH-1:0]   aw_addr;
    reg                              w_done;
    reg  [C_S_AXI_DATA_WIDTH-1:0]   w_data;
    reg  [C_S_AXI_DATA_WIDTH/8-1:0] w_strb;
    reg                              axi_awready;
    reg                              axi_wready;
    reg                              axi_bvalid;
    reg                              axi_arready;
    reg  [C_S_AXI_DATA_WIDTH-1:0]   axi_rdata;
    reg                              axi_rvalid;

    assign S_AXI_AWREADY = axi_awready;
    assign S_AXI_WREADY  = axi_wready;
    assign S_AXI_BRESP   = 2'b00;
    assign S_AXI_BVALID  = axi_bvalid;
    assign S_AXI_ARREADY = axi_arready;
    assign S_AXI_RDATA   = axi_rdata;
    assign S_AXI_RRESP   = 2'b00;
    assign S_AXI_RVALID  = axi_rvalid;

    // --- R/W config registers (AXI clock domain) -----------------------------
    reg        axireg_enable;
    reg        axireg_bypass_agc;
    reg        axireg_bypass_costas;
    reg        axireg_bypass_timing;
    reg [7:0]  axireg_sps;
    reg [15:0] axireg_agc_target;
    reg [3:0]  axireg_agc_ki_shift;
    reg [15:0] axireg_costas_kp;
    reg [15:0] axireg_costas_ki;
    reg [15:0] axireg_timing_kp;
    reg [15:0] axireg_timing_ki;

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
            axi_bvalid            <= 1'b0;
            axireg_enable         <= 1'b0;
            axireg_bypass_agc     <= 1'b0;
            axireg_bypass_costas  <= 1'b0;
            axireg_bypass_timing  <= 1'b0;
            axireg_sps            <= 8'd8;
            axireg_agc_target     <= 16'h2000;
            axireg_agc_ki_shift   <= 4'd10;
            axireg_costas_kp      <= 16'h0040;
            axireg_costas_ki      <= 16'h0008;
            axireg_timing_kp      <= 16'h0020;
            axireg_timing_ki      <= 16'h0004;
        end else begin
            if (do_write) begin
                axi_bvalid <= 1'b1;
                case (aw_addr[7:2])
                    6'h00: begin  // CTRL @ 0x00
                        if (w_strb[0]) begin
                            axireg_enable         <= w_data[0];
                            axireg_bypass_agc     <= w_data[1];
                            axireg_bypass_costas  <= w_data[2];
                            axireg_bypass_timing  <= w_data[3];
                        end
                    end
                    6'h02: begin  // SPS @ 0x08
                        if (w_strb[0]) axireg_sps <= w_data[7:0];
                    end
                    6'h03: begin  // AGC_TARGET @ 0x0C
                        if (w_strb[0]) axireg_agc_target[7:0]  <= w_data[7:0];
                        if (w_strb[1]) axireg_agc_target[15:8] <= w_data[15:8];
                    end
                    6'h04: begin  // AGC_GAIN/KI_SHIFT @ 0x10 — write [19:16]=ki_shift
                        if (w_strb[2]) axireg_agc_ki_shift <= w_data[19:16];
                    end
                    6'h05: begin  // COSTAS_KP @ 0x14
                        if (w_strb[0]) axireg_costas_kp[7:0]  <= w_data[7:0];
                        if (w_strb[1]) axireg_costas_kp[15:8] <= w_data[15:8];
                    end
                    6'h06: begin  // COSTAS_KI @ 0x18
                        if (w_strb[0]) axireg_costas_ki[7:0]  <= w_data[7:0];
                        if (w_strb[1]) axireg_costas_ki[15:8] <= w_data[15:8];
                    end
                    6'h07: begin  // TIMING_KP @ 0x1C
                        if (w_strb[0]) axireg_timing_kp[7:0]  <= w_data[7:0];
                        if (w_strb[1]) axireg_timing_kp[15:8] <= w_data[15:8];
                    end
                    6'h08: begin  // TIMING_KI @ 0x20
                        if (w_strb[0]) axireg_timing_ki[7:0]  <= w_data[7:0];
                        if (w_strb[1]) axireg_timing_ki[15:8] <= w_data[15:8];
                    end
                    default: ; // RO / reserved
                endcase
            end else if (S_AXI_BREADY) begin
                axi_bvalid <= 1'b0;
            end
        end
    end

    // =========================================================================
    // CDC – config registers: S_AXI_ACLK → aclk
    // =========================================================================

    // Write-pulse synchronizer
    reg  wr_pulse_axi;
    always @(posedge S_AXI_ACLK)
        wr_pulse_axi <= do_write;

    reg [1:0] wr_pulse_sync;
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) wr_pulse_sync <= 2'b00;
        else          wr_pulse_sync <= {wr_pulse_sync[0], wr_pulse_axi};
    end
    wire wr_pulse_core = wr_pulse_sync[1];

    // Snapshot registers (AXI domain, stable before pulse)
    reg        snap_enable;
    reg        snap_bypass_agc;
    reg        snap_bypass_costas;
    reg        snap_bypass_timing;
    reg [7:0]  snap_sps;
    reg [15:0] snap_agc_target;
    reg [3:0]  snap_agc_ki_shift;
    reg [15:0] snap_costas_kp;
    reg [15:0] snap_costas_ki;
    reg [15:0] snap_timing_kp;
    reg [15:0] snap_timing_ki;

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            snap_enable        <= 1'b0;
            snap_bypass_agc    <= 1'b0;
            snap_bypass_costas <= 1'b0;
            snap_bypass_timing <= 1'b0;
            snap_sps           <= 8'd8;
            snap_agc_target    <= 16'h2000;
            snap_agc_ki_shift  <= 4'd10;
            snap_costas_kp     <= 16'h0040;
            snap_costas_ki     <= 16'h0008;
            snap_timing_kp     <= 16'h0020;
            snap_timing_ki     <= 16'h0004;
        end else begin
            snap_enable        <= axireg_enable;
            snap_bypass_agc    <= axireg_bypass_agc;
            snap_bypass_costas <= axireg_bypass_costas;
            snap_bypass_timing <= axireg_bypass_timing;
            snap_sps           <= axireg_sps;
            snap_agc_target    <= axireg_agc_target;
            snap_agc_ki_shift  <= axireg_agc_ki_shift;
            snap_costas_kp     <= axireg_costas_kp;
            snap_costas_ki     <= axireg_costas_ki;
            snap_timing_kp     <= axireg_timing_kp;
            snap_timing_ki     <= axireg_timing_ki;
        end
    end

    // Core-domain config registers (latched in aclk on write pulse)
    reg        core_enable;
    reg        core_bypass_agc;
    reg        core_bypass_costas;
    reg        core_bypass_timing;
    reg [7:0]  core_sps;
    reg [15:0] core_agc_target;
    reg [3:0]  core_agc_ki_shift;
    reg [15:0] core_costas_kp;
    reg [15:0] core_costas_ki;
    reg [15:0] core_timing_kp;
    reg [15:0] core_timing_ki;

    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            core_enable        <= 1'b0;
            core_bypass_agc    <= 1'b0;
            core_bypass_costas <= 1'b0;
            core_bypass_timing <= 1'b0;
            core_sps           <= 8'd8;
            core_agc_target    <= 16'h2000;
            core_agc_ki_shift  <= 4'd10;
            core_costas_kp     <= 16'h0040;
            core_costas_ki     <= 16'h0008;
            core_timing_kp     <= 16'h0020;
            core_timing_ki     <= 16'h0004;
        end else if (wr_pulse_core) begin
            core_enable        <= snap_enable;
            core_bypass_agc    <= snap_bypass_agc;
            core_bypass_costas <= snap_bypass_costas;
            core_bypass_timing <= snap_bypass_timing;
            core_sps           <= snap_sps;
            core_agc_target    <= snap_agc_target;
            core_agc_ki_shift  <= snap_agc_ki_shift;
            core_costas_kp     <= snap_costas_kp;
            core_costas_ki     <= snap_costas_ki;
            core_timing_kp     <= snap_timing_kp;
            core_timing_ki     <= snap_timing_ki;
        end
    end

    // =========================================================================
    // CDC – status signals: aclk → S_AXI_ACLK
    // =========================================================================
    wire        raw_carrier_locked;
    wire        raw_agc_settled;
    wire [15:0] raw_agc_gain;
    wire [15:0] raw_phase_err;
    wire [15:0] raw_timing_err;
    wire [39:0] raw_bit_count;

    // Single-bit: 2-FF
    reg [1:0] locked_ff, settled_ff;
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            locked_ff  <= 2'b00;
            settled_ff <= 2'b00;
        end else begin
            locked_ff  <= {locked_ff[0],  raw_carrier_locked};
            settled_ff <= {settled_ff[0], raw_agc_settled};
        end
    end
    wire sync_locked  = locked_ff[1];
    wire sync_settled = settled_ff[1];

    // Multi-bit diagnostics: 2-FF (occasional glitch acceptable for diagnostics)
    reg [15:0] agc_gain_ff1,   agc_gain_ff2;
    reg [15:0] phase_err_ff1,  phase_err_ff2;
    reg [15:0] timing_err_ff1, timing_err_ff2;
    reg [39:0] bit_cnt_ff1,    bit_cnt_ff2;

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            agc_gain_ff1   <= 16'h1000; agc_gain_ff2   <= 16'h1000;
            phase_err_ff1  <= 16'd0;    phase_err_ff2  <= 16'd0;
            timing_err_ff1 <= 16'd0;    timing_err_ff2 <= 16'd0;
            bit_cnt_ff1    <= 40'd0;    bit_cnt_ff2    <= 40'd0;
        end else begin
            agc_gain_ff1   <= raw_agc_gain;    agc_gain_ff2   <= agc_gain_ff1;
            phase_err_ff1  <= raw_phase_err;   phase_err_ff2  <= phase_err_ff1;
            timing_err_ff1 <= raw_timing_err;  timing_err_ff2 <= timing_err_ff1;
            bit_cnt_ff1    <= raw_bit_count;   bit_cnt_ff2    <= bit_cnt_ff1;
        end
    end

    // =========================================================================
    // AXI4-Lite read channel
    // =========================================================================
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
                    6'h00: axi_rdata <= {28'd0,
                                         axireg_bypass_timing,  // [3]
                                         axireg_bypass_costas,  // [2]
                                         axireg_bypass_agc,     // [1]
                                         axireg_enable};        // [0]
                    6'h01: axi_rdata <= {28'd0,
                                         sync_settled,          // [3]
                                         sync_locked,           // [2]
                                         axireg_enable,         // [1] ACTIVE
                                         1'b1};                 // [0] READY
                    6'h02: axi_rdata <= {24'd0, axireg_sps};
                    6'h03: axi_rdata <= {16'd0, axireg_agc_target};
                    6'h04: axi_rdata <= {12'd0, axireg_agc_ki_shift, agc_gain_ff2};
                    6'h05: axi_rdata <= {16'd0, axireg_costas_kp};
                    6'h06: axi_rdata <= {16'd0, axireg_costas_ki};
                    6'h07: axi_rdata <= {16'd0, axireg_timing_kp};
                    6'h08: axi_rdata <= {16'd0, axireg_timing_ki};
                    6'h09: axi_rdata <= {16'd0, phase_err_ff2};
                    6'h0A: axi_rdata <= {16'd0, timing_err_ff2};
                    6'h0B: axi_rdata <= bit_cnt_ff2[31:0];
                    6'h0C: axi_rdata <= {24'd0, bit_cnt_ff2[39:32]};
                    6'h0D: axi_rdata <= 32'h0001_0000;   // IP_VERSION 1.0.0
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
    // BPSK Demodulator Core instantiation
    // =========================================================================
    bpsk_demod_core u_demod_core (
        .clk                (aclk),
        .resetn             (aresetn),

        .adc_valid          (adc_valid),
        .i_in               (adc_data[15:0]),    // I0
        .q_in               (adc_data[31:16]),   // Q0

        .cfg_enable         (core_enable),
        .cfg_bypass_agc     (core_bypass_agc),
        .cfg_bypass_costas  (core_bypass_costas),
        .cfg_bypass_timing  (core_bypass_timing),
        .cfg_sps            (core_sps),
        .cfg_agc_target     (core_agc_target),
        .cfg_agc_ki_shift   (core_agc_ki_shift),
        .cfg_costas_kp      (core_costas_kp),
        .cfg_costas_ki      (core_costas_ki),
        .cfg_timing_kp      (core_timing_kp),
        .cfg_timing_ki      (core_timing_ki),

        .bits_tdata         (M_AXIS_BITS_TDATA),
        .bits_tvalid        (M_AXIS_BITS_TVALID),
        .bits_tready        (M_AXIS_BITS_TREADY),

        .phase_err_out      (raw_phase_err),
        .timing_err_out     (raw_timing_err),
        .agc_gain_out       (raw_agc_gain),
        .carrier_locked     (raw_carrier_locked),
        .agc_settled        (raw_agc_settled),
        .bit_count          (raw_bit_count)
    );

endmodule
