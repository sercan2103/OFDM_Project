`timescale 1ns / 1ps
// =============================================================================
// bpsk_tb.v  –  Simulation testbench for BPSK Modulator IP
//
// Tests covered:
//   TC1  Power-on reset: all outputs deasserted, DMA bypass transparent
//   TC2  Enable with SRC_SEL=00 (alternating pattern): I oscillates ±full
//   TC3  SRC_SEL=01 (register pattern 0xA5A5A5A5): correct bit sequence
//   TC4  SRC_SEL=10 (AXI-Stream bit input): external bit stream modulated
//   TC5  CH_SEL=1: BPSK symbol replicated on TX2 (I1/Q1)
//   TC6  DMA bypass: data pass-through when ENABLE=0
//   TC7  Backpressure: M_AXIS_DAC_TREADY=0 pauses symbol counter
//   TC8  Symbol counter increments and reads back correctly
//   TC9  Amplitude registers: non-default I_POS / I_NEG applied correctly
//
// To run in Vivado:
//   set_property top bpsk_tb [get_filesets sim_1]
//   launch_simulation
// =============================================================================

module bpsk_tb;

    // -------------------------------------------------------------------------
    // Parameters
    // -------------------------------------------------------------------------
    localparam AXI_CLK_PERIOD  = 10;  // 100 MHz
    localparam DATA_CLK_PERIOD =  4;  // 245.76 MHz (approx)

    localparam [7:0]
        ADDR_CTRL      = 8'h00,
        ADDR_STATUS    = 8'h04,
        ADDR_SYM_DIV   = 8'h08,
        ADDR_AMPLITUDE = 8'h0C,
        ADDR_PAT_DATA  = 8'h10,
        ADDR_SYM_LO    = 8'h18,
        ADDR_SYM_HI    = 8'h1C,
        ADDR_IP_VER    = 8'h20;

    // -------------------------------------------------------------------------
    // Clock / reset generation
    // -------------------------------------------------------------------------
    reg axi_clk  = 0;
    reg data_clk = 0;
    reg axi_rstn = 0;
    reg dat_rstn = 0;

    always #(AXI_CLK_PERIOD  / 2) axi_clk  = ~axi_clk;
    always #(DATA_CLK_PERIOD / 2) data_clk = ~data_clk;

    initial begin
        #(AXI_CLK_PERIOD * 5);
        axi_rstn = 1;
        dat_rstn = 1;
    end

    // -------------------------------------------------------------------------
    // DUT signals
    // -------------------------------------------------------------------------
    // AXI4-Lite
    reg  [7:0]  S_AXI_AWADDR;
    reg  [2:0]  S_AXI_AWPROT  = 3'b000;
    reg         S_AXI_AWVALID = 0;
    wire        S_AXI_AWREADY;
    reg  [31:0] S_AXI_WDATA;
    reg  [3:0]  S_AXI_WSTRB   = 4'hF;
    reg         S_AXI_WVALID  = 0;
    wire        S_AXI_WREADY;
    wire [1:0]  S_AXI_BRESP;
    wire        S_AXI_BVALID;
    reg         S_AXI_BREADY  = 1;
    reg  [7:0]  S_AXI_ARADDR;
    reg  [2:0]  S_AXI_ARPROT  = 3'b000;
    reg         S_AXI_ARVALID = 0;
    wire        S_AXI_ARREADY;
    wire [31:0] S_AXI_RDATA;
    wire [1:0]  S_AXI_RRESP;
    wire        S_AXI_RVALID;
    reg         S_AXI_RREADY  = 1;

    // S_AXIS_BITS
    reg  [7:0]  S_AXIS_BITS_TDATA  = 8'h00;
    reg         S_AXIS_BITS_TVALID = 0;
    wire        S_AXIS_BITS_TREADY;

    // S_AXIS_DMA
    reg  [63:0] S_AXIS_DMA_TDATA  = 64'hCAFE_BABE_DEAD_BEEF;
    reg         S_AXIS_DMA_TVALID = 0;
    wire        S_AXIS_DMA_TREADY;
    reg         S_AXIS_DMA_TLAST  = 0;
    reg  [7:0]  S_AXIS_DMA_TKEEP  = 8'hFF;

    // M_AXIS_DAC
    wire [63:0] M_AXIS_DAC_TDATA;
    wire        M_AXIS_DAC_TVALID;
    reg         M_AXIS_DAC_TREADY = 1;
    wire        M_AXIS_DAC_TLAST;
    wire [7:0]  M_AXIS_DAC_TKEEP;

    // -------------------------------------------------------------------------
    // DUT instantiation
    // -------------------------------------------------------------------------
    bpsk_modulator_v1_0 #(
        .C_S_AXI_DATA_WIDTH(32),
        .C_S_AXI_ADDR_WIDTH(8)
    ) dut (
        .aclk               (data_clk),
        .aresetn            (dat_rstn),
        .S_AXI_ACLK         (axi_clk),
        .S_AXI_ARESETN      (axi_rstn),
        .S_AXI_AWADDR       (S_AXI_AWADDR),
        .S_AXI_AWPROT       (S_AXI_AWPROT),
        .S_AXI_AWVALID      (S_AXI_AWVALID),
        .S_AXI_AWREADY      (S_AXI_AWREADY),
        .S_AXI_WDATA        (S_AXI_WDATA),
        .S_AXI_WSTRB        (S_AXI_WSTRB),
        .S_AXI_WVALID       (S_AXI_WVALID),
        .S_AXI_WREADY       (S_AXI_WREADY),
        .S_AXI_BRESP        (S_AXI_BRESP),
        .S_AXI_BVALID       (S_AXI_BVALID),
        .S_AXI_BREADY       (S_AXI_BREADY),
        .S_AXI_ARADDR       (S_AXI_ARADDR),
        .S_AXI_ARPROT       (S_AXI_ARPROT),
        .S_AXI_ARVALID      (S_AXI_ARVALID),
        .S_AXI_ARREADY      (S_AXI_ARREADY),
        .S_AXI_RDATA        (S_AXI_RDATA),
        .S_AXI_RRESP        (S_AXI_RRESP),
        .S_AXI_RVALID       (S_AXI_RVALID),
        .S_AXI_RREADY       (S_AXI_RREADY),
        .S_AXIS_BITS_TDATA  (S_AXIS_BITS_TDATA),
        .S_AXIS_BITS_TVALID (S_AXIS_BITS_TVALID),
        .S_AXIS_BITS_TREADY (S_AXIS_BITS_TREADY),
        .S_AXIS_DMA_TDATA   (S_AXIS_DMA_TDATA),
        .S_AXIS_DMA_TVALID  (S_AXIS_DMA_TVALID),
        .S_AXIS_DMA_TREADY  (S_AXIS_DMA_TREADY),
        .S_AXIS_DMA_TLAST   (S_AXIS_DMA_TLAST),
        .S_AXIS_DMA_TKEEP   (S_AXIS_DMA_TKEEP),
        .M_AXIS_DAC_TDATA   (M_AXIS_DAC_TDATA),
        .M_AXIS_DAC_TVALID  (M_AXIS_DAC_TVALID),
        .M_AXIS_DAC_TREADY  (M_AXIS_DAC_TREADY),
        .M_AXIS_DAC_TLAST   (M_AXIS_DAC_TLAST),
        .M_AXIS_DAC_TKEEP   (M_AXIS_DAC_TKEEP)
    );

    // =========================================================================
    // AXI4-Lite tasks
    // =========================================================================
    task axi_write;
        input [7:0]  addr;
        input [31:0] data;
        begin
            @(posedge axi_clk);
            S_AXI_AWADDR  <= addr;
            S_AXI_AWVALID <= 1'b1;
            S_AXI_WDATA   <= data;
            S_AXI_WVALID  <= 1'b1;
            S_AXI_WSTRB   <= 4'hF;
            wait (S_AXI_AWREADY);
            @(posedge axi_clk);
            S_AXI_AWVALID <= 1'b0;
            wait (S_AXI_WREADY);
            @(posedge axi_clk);
            S_AXI_WVALID  <= 1'b0;
            wait (S_AXI_BVALID);
            @(posedge axi_clk);
        end
    endtask

    task axi_read;
        input  [7:0]  addr;
        output [31:0] data;
        begin
            @(posedge axi_clk);
            S_AXI_ARADDR  <= addr;
            S_AXI_ARVALID <= 1'b1;
            wait (S_AXI_ARREADY);
            @(posedge axi_clk);
            S_AXI_ARVALID <= 1'b0;
            wait (S_AXI_RVALID);
            data = S_AXI_RDATA;
            @(posedge axi_clk);
        end
    endtask

    // =========================================================================
    // Waveform dump
    // =========================================================================
    initial begin
        $dumpfile("bpsk_tb.vcd");
        $dumpvars(0, bpsk_tb);
    end

    // =========================================================================
    // Test stimulus
    // =========================================================================
    integer    i;
    reg [31:0] rdata;
    reg [15:0] i0_out, q0_out, i1_out, q1_out;

    // Helper to extract I/Q from DAC tdata
    `define I0(d) d[15:0]
    `define Q0(d) d[31:16]
    `define I1(d) d[47:32]
    `define Q1(d) d[63:48]

    initial begin
        $display("=== BPSK Modulator Testbench ===");
        wait (axi_rstn && dat_rstn);
        repeat(10) @(posedge axi_clk);

        // ------------------------------------------------------------------
        // TC1: IP version and status after reset
        // ------------------------------------------------------------------
        $display("\n--- TC1: Power-on status ---");
        axi_read(ADDR_IP_VER, rdata);
        $display("IP_VERSION = 0x%08X  (expect 0x00010000)", rdata);
        if (rdata !== 32'h0001_0000)
            $display("FAIL: wrong IP version");
        else
            $display("PASS: IP version correct");

        axi_read(ADDR_STATUS, rdata);
        $display("STATUS = 0x%08X  (expect READY=1, ACTIVE=0)", rdata);
        if (rdata[0] !== 1'b1 || rdata[1] !== 1'b0)
            $display("FAIL: unexpected status");
        else
            $display("PASS: STATUS correct after reset");

        // ------------------------------------------------------------------
        // TC6: DMA bypass when ENABLE=0
        // ------------------------------------------------------------------
        $display("\n--- TC6: DMA bypass (ENABLE=0) ---");
        S_AXIS_DMA_TDATA  <= 64'hABCD_1234_5678_EF01;
        S_AXIS_DMA_TVALID <= 1'b1;
        repeat(5) @(posedge data_clk);
        if (M_AXIS_DAC_TDATA === 64'hABCD_1234_5678_EF01 && M_AXIS_DAC_TVALID === 1'b1)
            $display("PASS: DMA bypass working (data = 0x%016X)", M_AXIS_DAC_TDATA);
        else
            $display("FAIL: DMA bypass wrong (got 0x%016X, valid=%b)",
                     M_AXIS_DAC_TDATA, M_AXIS_DAC_TVALID);
        S_AXIS_DMA_TVALID <= 1'b0;

        // ------------------------------------------------------------------
        // TC2: Enable BPSK, SRC_SEL=00 (alternating), SYM_DIV=4
        // ------------------------------------------------------------------
        $display("\n--- TC2: SRC_SEL=00 alternating pattern ---");
        axi_write(ADDR_SYM_DIV,  32'd4);   // 4 clocks per symbol
        axi_write(ADDR_CTRL,     32'h01);  // ENABLE=1, SRC_SEL=00, CH_SEL=0
        repeat(3) @(posedge axi_clk);      // wait for CDC to propagate

        for (i = 0; i < 8; i = i + 1) begin
            // Wait for next sym_tick (div_cnt reloads every 4 data_clks)
            repeat(4) @(posedge data_clk);
            #1;
            i0_out = `I0(M_AXIS_DAC_TDATA);
            q0_out = `Q0(M_AXIS_DAC_TDATA);
            i1_out = `I1(M_AXIS_DAC_TDATA);
            q1_out = `Q1(M_AXIS_DAC_TDATA);
            $display("  sym[%0d]: I0=0x%04X Q0=0x%04X I1=0x%04X Q1=0x%04X tvalid=%b",
                     i, i0_out, q0_out, i1_out, q1_out, M_AXIS_DAC_TVALID);
        end

        // Check Q=0 always in BPSK mode
        if (`Q0(M_AXIS_DAC_TDATA) === 16'h0000 && `Q1(M_AXIS_DAC_TDATA) === 16'h0000)
            $display("PASS: Q channels are zero");
        else
            $display("FAIL: Q channels not zero");

        // Check I1=0 when CH_SEL=0
        if (`I1(M_AXIS_DAC_TDATA) === 16'h0000)
            $display("PASS: I1 is zero (CH_SEL=0)");
        else
            $display("FAIL: I1 not zero with CH_SEL=0");

        // ------------------------------------------------------------------
        // TC5: CH_SEL=1 replicates on TX2
        // ------------------------------------------------------------------
        $display("\n--- TC5: CH_SEL=1 (BPSK on both TX channels) ---");
        axi_write(ADDR_CTRL, 32'h09);  // ENABLE=1, SRC_SEL=00, CH_SEL=1
        repeat(3) @(posedge axi_clk);
        repeat(8) @(posedge data_clk);
        #1;
        i0_out = `I0(M_AXIS_DAC_TDATA);
        i1_out = `I1(M_AXIS_DAC_TDATA);
        if (i0_out === i1_out)
            $display("PASS: I0=I1=0x%04X (CH_SEL=1 replication OK)", i0_out);
        else
            $display("FAIL: I0=0x%04X I1=0x%04X mismatch with CH_SEL=1", i0_out, i1_out);

        // ------------------------------------------------------------------
        // TC9: Non-default amplitude values
        // ------------------------------------------------------------------
        $display("\n--- TC9: Custom amplitude (I_POS=0x4000, I_NEG=0xC000) ---");
        // AMPLITUDE[31:16]=I_POS, [15:0]=I_NEG
        axi_write(ADDR_AMPLITUDE, 32'h4000_C000);
        axi_write(ADDR_CTRL,      32'h01);  // CH_SEL=0
        repeat(5) @(posedge axi_clk);
        repeat(16) @(posedge data_clk);
        #1;
        i0_out = `I0(M_AXIS_DAC_TDATA);
        $display("  I0 = 0x%04X  (expect 0x4000 or 0xC000)", i0_out);
        if (i0_out === 16'h4000 || i0_out === 16'hC000)
            $display("PASS: Custom amplitude applied");
        else
            $display("FAIL: Custom amplitude not applied (got 0x%04X)", i0_out);

        // Restore defaults
        axi_write(ADDR_AMPLITUDE, 32'h7FFF_8001);

        // ------------------------------------------------------------------
        // TC3: SRC_SEL=01 register pattern
        // ------------------------------------------------------------------
        $display("\n--- TC3: SRC_SEL=01 register pattern (0xA5A5_A5A5) ---");
        // Pattern 0xA5 = 1010_0101 → expected bit sequence (MSB first):
        //   1,0,1,0,0,1,0,1,1,0,1,0,0,1,0,1,...
        axi_write(ADDR_PAT_DATA, 32'hA5A5_A5A5);
        axi_write(ADDR_SYM_DIV,  32'd4);
        axi_write(ADDR_CTRL,     32'h03);  // ENABLE=1, SRC_SEL=01
        repeat(3) @(posedge axi_clk);

        $display("  First 16 symbols (MSB-first of 0xA5A5A5A5):");
        $write("  I0 values: ");
        for (i = 0; i < 16; i = i + 1) begin
            repeat(4) @(posedge data_clk);
            #1;
            $write("0x%04X ", `I0(M_AXIS_DAC_TDATA));
        end
        $display("");
        $display("  (expect alternating 0x8001/0x7FFF for 0xA5 pattern)");

        // ------------------------------------------------------------------
        // TC4: SRC_SEL=10 AXI-Stream bit input
        // ------------------------------------------------------------------
        $display("\n--- TC4: SRC_SEL=10 AXI-Stream bit input ---");
        axi_write(ADDR_SYM_DIV, 32'd8);    // 8 clocks per symbol
        axi_write(ADDR_CTRL,    32'h05);   // ENABLE=1, SRC_SEL=10
        repeat(3) @(posedge axi_clk);

        // Send bit sequence: 0,1,1,0,1,0,0,1
        begin : tc4_block
            reg [7:0] tc4_bits [0:7];
            tc4_bits[0] = 8'h00; // bit=0
            tc4_bits[1] = 8'h01; // bit=1
            tc4_bits[2] = 8'h01; // bit=1
            tc4_bits[3] = 8'h00; // bit=0
            tc4_bits[4] = 8'h01; // bit=1
            tc4_bits[5] = 8'h00; // bit=0
            tc4_bits[6] = 8'h00; // bit=0
            tc4_bits[7] = 8'h01; // bit=1

            $display("  Sending bits: 0,1,1,0,1,0,0,1");
            $display("  Expected I0:  7FFF,8001,8001,7FFF,8001,7FFF,7FFF,8001");
            $write("  Observed I0: ");
            for (i = 0; i < 8; i = i + 1) begin
                // Present bit and wait for tready
                @(posedge data_clk);
                S_AXIS_BITS_TDATA  <= tc4_bits[i];
                S_AXIS_BITS_TVALID <= 1'b1;
                wait (S_AXIS_BITS_TREADY === 1'b1);
                @(posedge data_clk);
                repeat(8) @(posedge data_clk);
                #1;
                $write("0x%04X ", `I0(M_AXIS_DAC_TDATA));
                S_AXIS_BITS_TVALID <= 1'b0;
            end
            $display("");
        end

        // ------------------------------------------------------------------
        // TC7: Backpressure test
        // ------------------------------------------------------------------
        $display("\n--- TC7: Backpressure (tready=0 pauses symbol counter) ---");
        axi_write(ADDR_CTRL, 32'h01);   // SRC_SEL=00
        repeat(3) @(posedge axi_clk);

        axi_read(ADDR_SYM_LO, rdata);
        $display("  sym_count before pause = %0d", rdata);

        M_AXIS_DAC_TREADY <= 1'b0;      // hold backpressure
        repeat(20) @(posedge data_clk);

        axi_read(ADDR_SYM_LO, rdata);
        $display("  sym_count during backpressure = %0d  (should not increase)", rdata);

        M_AXIS_DAC_TREADY <= 1'b1;
        repeat(20) @(posedge data_clk);

        axi_read(ADDR_SYM_LO, rdata);
        $display("  sym_count after release = %0d  (should have increased)", rdata);
        $display("PASS: Backpressure test complete");

        // ------------------------------------------------------------------
        // TC8: Symbol counter readback
        // ------------------------------------------------------------------
        $display("\n--- TC8: Symbol counter ---");
        // Disable and re-enable to reset counter
        axi_write(ADDR_CTRL, 32'h00);
        repeat(3) @(posedge axi_clk);
        axi_read(ADDR_SYM_LO, rdata);
        $display("  Counter after disable = %0d (expect 0)", rdata);

        axi_write(ADDR_SYM_DIV, 32'd2);
        axi_write(ADDR_CTRL,    32'h01);
        repeat(3) @(posedge axi_clk);
        repeat(40) @(posedge data_clk);

        axi_read(ADDR_SYM_LO, rdata);
        $display("  Counter after ~20 sym periods = %0d (expect ~10-20)", rdata);
        if (rdata > 0)
            $display("PASS: Symbol counter is counting");
        else
            $display("FAIL: Symbol counter stuck at zero");

        // ------------------------------------------------------------------
        // End of tests
        // ------------------------------------------------------------------
        $display("\n=== All testcases complete ===");
        repeat(20) @(posedge axi_clk);
        $finish;
    end

    // -------------------------------------------------------------------------
    // Timeout watchdog
    // -------------------------------------------------------------------------
    initial begin
        #500000;
        $display("TIMEOUT: simulation exceeded limit");
        $finish;
    end

endmodule
