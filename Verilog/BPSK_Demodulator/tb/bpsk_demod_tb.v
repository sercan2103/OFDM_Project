`timescale 1ns / 1ps
// =============================================================================
// bpsk_demod_tb.v  –  BPSK Demodulator Testbench
//
// Tests the complete bpsk_demod_v1_0 IP under five scenarios:
//
//  TC1: Perfect BPSK (no noise, no offset), SPS=8           → 100% bit recovery
//  TC2: Phase-rotated signal (45°) → Costas loop corrects   → bits OK after lock
//  TC3: Amplitude-scaled (0.25×)  → AGC corrects            → bits OK after settle
//  TC4: Frequency-offset carrier  → Costas tracks           → frequency error → 0
//  TC5: Combined: attenuation + phase rotation              → both loops settle
//
// All tests share:
//   aclk   = 4 ns period (~245 MHz)
//   S_AXI_ACLK = 10 ns period (100 MHz)
//   SPS    = 8 (8 adc_valid pulses per BPSK symbol)
//   adc_valid toggles every clock (continuous ADC stream)
// =============================================================================

module bpsk_demod_tb;

    // =========================================================================
    // Clock / reset
    // =========================================================================
    reg aclk       = 0;
    reg axi_clk    = 0;
    reg aresetn    = 0;
    reg axi_resetn = 0;

    always #2  aclk    = ~aclk;    // ~245 MHz (4 ns)
    always #5  axi_clk = ~axi_clk; // 100 MHz (10 ns)

    // =========================================================================
    // DUT signals
    // =========================================================================
    reg  [63:0] adc_data  = 64'd0;
    reg         adc_valid = 1'b0;

    // AXI-Lite
    reg  [7:0]  axi_awaddr  = 8'd0;
    reg         axi_awvalid = 1'b0;
    reg  [31:0] axi_wdata   = 32'd0;
    reg  [3:0]  axi_wstrb   = 4'hF;
    reg         axi_wvalid  = 1'b0;
    wire        axi_awready;
    wire        axi_wready;
    wire [1:0]  axi_bresp;
    wire        axi_bvalid;
    reg         axi_bready = 1'b1;
    reg  [7:0]  axi_araddr  = 8'd0;
    reg         axi_arvalid = 1'b0;
    wire [31:0] axi_rdata;
    wire [1:0]  axi_rresp;
    wire        axi_rvalid;
    reg         axi_rready = 1'b1;

    // AXI-Stream output
    wire [7:0]  m_tdata;
    wire        m_tvalid;
    reg         m_tready = 1'b1;

    // =========================================================================
    // DUT instantiation
    // =========================================================================
    bpsk_demod_v1_0 #(
        .C_S_AXI_DATA_WIDTH (32),
        .C_S_AXI_ADDR_WIDTH (8)
    ) dut (
        .aclk               (aclk),
        .aresetn            (aresetn),
        .S_AXI_ACLK         (axi_clk),
        .S_AXI_ARESETN      (axi_resetn),

        .S_AXI_AWADDR       (axi_awaddr),
        .S_AXI_AWPROT       (3'd0),
        .S_AXI_AWVALID      (axi_awvalid),
        .S_AXI_AWREADY      (axi_awready),
        .S_AXI_WDATA        (axi_wdata),
        .S_AXI_WSTRB        (axi_wstrb),
        .S_AXI_WVALID       (axi_wvalid),
        .S_AXI_WREADY       (axi_wready),
        .S_AXI_BRESP        (axi_bresp),
        .S_AXI_BVALID       (axi_bvalid),
        .S_AXI_BREADY       (axi_bready),
        .S_AXI_ARADDR       (axi_araddr),
        .S_AXI_ARPROT       (3'd0),
        .S_AXI_ARVALID      (axi_arvalid),
        .S_AXI_ARREADY      (axi_arready),
        .S_AXI_RDATA        (axi_rdata),
        .S_AXI_RRESP        (axi_rresp),
        .S_AXI_RVALID       (axi_rvalid),
        .S_AXI_RREADY       (axi_rready),

        .adc_data           (adc_data),
        .adc_valid          (adc_valid),

        .M_AXIS_BITS_TDATA  (m_tdata),
        .M_AXIS_BITS_TVALID (m_tvalid),
        .M_AXIS_BITS_TREADY (m_tready)
    );

    // =========================================================================
    // AXI-Lite write helper task
    // =========================================================================
    task axi_write;
        input [7:0]  addr;
        input [31:0] data;
        begin
            @(posedge axi_clk);
            axi_awaddr  <= addr;
            axi_awvalid <= 1'b1;
            axi_wdata   <= data;
            axi_wstrb   <= 4'hF;
            axi_wvalid  <= 1'b1;
            // Wait for both handshakes
            fork
                begin @(posedge axi_clk); while (!axi_awready) @(posedge axi_clk); axi_awvalid <= 1'b0; end
                begin @(posedge axi_clk); while (!axi_wready)  @(posedge axi_clk); axi_wvalid  <= 1'b0; end
            join
            @(posedge axi_clk);
            while (!axi_bvalid) @(posedge axi_clk);
        end
    endtask

    // =========================================================================
    // Bit output collection
    // =========================================================================
    integer bits_received;
    integer bits_correct;
    reg [7:0] expected_byte;

    // Reference bit stream: alternating 0/1 → bytes 0x55 and 0xAA
    // (modulator bit=0 → I_POS=+1, bit=1 → I_NEG=-1, repeating)
    // For the demodulator: bit_out = I_dump[15] (sign bit)
    //   I_dump ≥ 0 → bit=0,  I_dump < 0 → bit=1
    // Alternating stream 01010101... → 0x55

    // =========================================================================
    // BPSK signal generation helper
    // =========================================================================
    // Drives SPS=8 samples of BPSK symbol for given bit value.
    // I amplitude = 16'h4000 (0.5 full-scale), Q=0 (perfect BPSK)
    // Optionally rotates by phase_deg (integer 0–360) for Costas test.
    // Optionally scales by amplitude (Q1.15, 0x7FFF=full scale)

    // Pre-computed cos/sin table for 0,45,90,135,180,225,270,315 degrees
    // Q1.15 values: cos(0)=0x7FFF, cos(45)=0x5A82, cos(90)=0, cos(135)=-0x5A82
    //               cos(180)=0x8001, cos(225)=-0x5A82, cos(270)=0, cos(315)=0x5A82
    function signed [15:0] cos_lut;
        input integer deg_x45;  // 0=0°, 1=45°, 2=90°, ...
        begin
            case (deg_x45 % 8)
                0: cos_lut = 16'h7FFF;
                1: cos_lut = 16'h5A82;
                2: cos_lut = 16'h0000;
                3: cos_lut = 16'hA57E;  // -0x5A82
                4: cos_lut = 16'h8001;
                5: cos_lut = 16'hA57E;
                6: cos_lut = 16'h0000;
                7: cos_lut = 16'h5A82;
                default: cos_lut = 16'h0000;
            endcase
        end
    endfunction

    function signed [15:0] sin_lut;
        input integer deg_x45;
        begin
            case (deg_x45 % 8)
                0: sin_lut = 16'h0000;
                1: sin_lut = 16'h5A82;
                2: sin_lut = 16'h7FFF;
                3: sin_lut = 16'h5A82;
                4: sin_lut = 16'h0000;
                5: sin_lut = 16'hA57E;  // -0x5A82
                6: sin_lut = 16'h8001;
                7: sin_lut = 16'hA57E;
                default: sin_lut = 16'h0000;
            endcase
        end
    endfunction

    // Send N BPSK symbols with given bit pattern and rotation
    // bit_seq: repeating pattern of bits (packed in 32 bits, MSB first)
    // n_sym: number of symbols
    // phase_x45: rotation index (0=0°, 1=45°, 2=90°, ...)
    // i_amp: I amplitude in Q1.15 (e.g., 0x4000 = 0.5)
    // freq_delta_pp: per-sample phase accumulator increment (0 = no frequency offset)
    integer current_phase_acc;  // global phase accumulator for freq offset

    task send_symbols;
        input integer n_sym;
        input [31:0]  bit_pattern;   // up to 32 bits, cycled MSB-first
        input integer phase_x45;     // phase rotation index (0–7)
        input [15:0]  i_amp;         // I amplitude Q1.15
        input integer freq_delta;    // per-sample NCO delta (0=none)
        integer sym_i, samp_i, bit_val;
        integer bit_idx_loop;
        reg signed [15:0] i_rot, q_rot;
        reg signed [31:0] prod_ii, prod_qi;
        begin
            for (sym_i = 0; sym_i < n_sym; sym_i = sym_i + 1) begin
                bit_idx_loop = 31 - (sym_i % 32);
                bit_val = bit_pattern[bit_idx_loop];
                // BPSK: bit=0 → I=+i_amp, bit=1 → I=-i_amp; Q=0
                for (samp_i = 0; samp_i < 8; samp_i = samp_i + 1) begin
                    // Rotate by phase_x45 (complex multiply with 45°-step phasors)
                    // Also add freq_delta to running phase
                    current_phase_acc = current_phase_acc + freq_delta;
                    begin : rot_block
                        reg signed [15:0] i_raw;
                        reg signed [15:0] c_val, s_val;
                        integer ph_idx;
                        i_raw = bit_val ? (~{1'b0, i_amp[14:0]} + 16'd1) : {1'b0, i_amp[14:0]};
                        ph_idx = phase_x45 + (current_phase_acc >>> 24) % 8;
                        c_val = cos_lut(ph_idx);
                        s_val = sin_lut(ph_idx);
                        // I_out = I*cos - Q*sin (Q=0, so = I*cos)
                        // Q_out = I*sin + Q*cos (Q=0, so = I*sin)
                        prod_ii = $signed(i_raw) * $signed(c_val);
                        prod_qi = $signed(i_raw) * $signed(s_val);
                        i_rot = prod_ii[30:15];
                        q_rot = prod_qi[30:15];
                    end
                    @(posedge aclk);
                    adc_data  <= {16'd0, 16'd0, q_rot, i_rot};  // [15:0]=I0, [31:16]=Q0
                    adc_valid <= 1'b1;
                    @(posedge aclk);
                    adc_valid <= 1'b0;  // one valid pulse per "sample clock"
                end
            end
        end
    endtask

    // =========================================================================
    // Pass/fail checker
    // =========================================================================
    integer tc_errors;
    integer total_tests;
    integer total_pass;

    task check_bits;
        input integer expected_n_bytes;
        input [7:0]   expected_pat;   // repeating byte pattern
        input integer settle_sym;     // first N symbols to ignore (settling)
        integer byte_i, timeout_cnt;
        reg [7:0] rcv;
        begin
            byte_i     = 0;
            timeout_cnt = 0;
            tc_errors  = 0;
            bits_received = 0;
            bits_correct  = 0;

            while (byte_i < expected_n_bytes && timeout_cnt < 200000) begin
                @(posedge aclk);
                timeout_cnt = timeout_cnt + 1;
                if (m_tvalid && m_tready) begin
                    rcv = m_tdata;
                    bits_received = bits_received + 1;
                    if (byte_i >= (settle_sym / 8)) begin
                        if (rcv === expected_pat) begin
                            bits_correct = bits_correct + 1;
                        end else begin
                            tc_errors = tc_errors + 1;
                            $display("  BYTE MISMATCH byte#%0d: got 0x%02X expected 0x%02X",
                                     byte_i, rcv, expected_pat);
                        end
                    end
                    byte_i = byte_i + 1;
                end
            end
        end
    endtask

    // =========================================================================
    // Main stimulus
    // =========================================================================
    integer i;

    initial begin
        total_tests = 0;
        total_pass  = 0;
        current_phase_acc = 0;

        // ---- Reset ----------------------------------------------------------
        aresetn    = 0;
        axi_resetn = 0;
        adc_valid  = 0;
        repeat(20) @(posedge aclk);
        aresetn    = 1;
        @(posedge axi_clk);
        axi_resetn = 1;
        repeat(10) @(posedge axi_clk);

        // ==================================================================
        // TC1: Perfect BPSK, SPS=8, no offsets
        //      Alternating 0/1 bits → expected byte = 0x55
        // ==================================================================
        $display("\n=== TC1: Perfect BPSK (no offset, SPS=8) ===");
        total_tests = total_tests + 1;

        // Configure: ENABLE, all loops active, SPS=8, default gains
        axi_write(8'h00, 32'h0000_0001);  // CTRL: ENABLE
        axi_write(8'h08, 32'h0000_0008);  // SPS = 8
        axi_write(8'h0C, 32'h0000_2000);  // AGC_TARGET = 0x2000
        axi_write(8'h14, 32'h0000_0040);  // COSTAS_KP
        axi_write(8'h18, 32'h0000_0008);  // COSTAS_KI
        axi_write(8'h1C, 32'h0000_0020);  // TIMING_KP
        axi_write(8'h20, 32'h0000_0004);  // TIMING_KI

        // Send 200 symbols of alternating 0/1 (= 0x55 bytes)
        // phase=0, amp=0x4000, no freq offset
        fork
            send_symbols(200, 32'hAAAA_AAAA, 0, 16'h4000, 0);
            check_bits(20, 8'h55, 32);
        join

        if (tc_errors == 0) begin
            $display("  PASS – all bytes matched 0x55 after settling");
            total_pass = total_pass + 1;
        end else begin
            $display("  FAIL – %0d byte errors", tc_errors);
        end

        // ==================================================================
        // TC2: Phase-rotated 45° → Costas must correct
        // ==================================================================
        $display("\n=== TC2: Phase rotation 45° (Costas lock required) ===");
        total_tests = total_tests + 1;
        tc_errors   = 0;

        // Reset demodulator (toggle enable)
        axi_write(8'h00, 32'h0000_0000);
        repeat(50) @(posedge aclk);
        current_phase_acc = 0;
        axi_write(8'h00, 32'h0000_0001);

        fork
            send_symbols(400, 32'hAAAA_AAAA, 1, 16'h4000, 0);  // 45° rotation
            check_bits(30, 8'h55, 128);  // allow 128 sym settling
        join

        if (tc_errors == 0) begin
            $display("  PASS – Costas loop corrected 45 deg phase rotation");
            total_pass = total_pass + 1;
        end else begin
            $display("  FAIL – %0d byte errors after Costas settling", tc_errors);
        end

        // ==================================================================
        // TC3: Attenuated signal (0.25× amplitude) → AGC must correct
        // ==================================================================
        $display("\n=== TC3: Attenuated signal (0.25x amp) – AGC correction ===");
        total_tests = total_tests + 1;
        tc_errors   = 0;

        axi_write(8'h00, 32'h0000_0000);
        repeat(50) @(posedge aclk);
        current_phase_acc = 0;
        axi_write(8'h00, 32'h0000_0001);

        // amp = 0x1000 (0.25 × 0x4000)
        fork
            send_symbols(400, 32'hAAAA_AAAA, 0, 16'h1000, 0);
            check_bits(30, 8'h55, 128);
        join

        if (tc_errors == 0) begin
            $display("  PASS – AGC corrected attenuated signal");
            total_pass = total_pass + 1;
        end else begin
            $display("  FAIL – %0d byte errors after AGC settling", tc_errors);
        end

        // ==================================================================
        // TC4: Frequency offset (slow carrier drift) → Costas must track
        // ==================================================================
        $display("\n=== TC4: Frequency offset – Costas frequency tracking ===");
        total_tests = total_tests + 1;
        tc_errors   = 0;

        axi_write(8'h00, 32'h0000_0000);
        repeat(50) @(posedge aclk);
        current_phase_acc = 0;
        axi_write(8'h00, 32'h0000_0001);

        // freq_delta = 0x00400000 → accumulates ~90° every 8 samples at slow rate
        // Use small value to allow tracking
        fork
            send_symbols(500, 32'hAAAA_AAAA, 0, 16'h4000, 32'h00010000);
            check_bits(35, 8'h55, 160);
        join

        if (tc_errors == 0) begin
            $display("  PASS – Costas loop tracked frequency offset");
            total_pass = total_pass + 1;
        end else begin
            $display("  FAIL – %0d byte errors after freq lock", tc_errors);
        end

        // ==================================================================
        // TC5: Combined: attenuation 0.3× + phase rotation 90° + bypass test
        // ==================================================================
        $display("\n=== TC5: Combined attenuation + phase rotation ===");
        total_tests = total_tests + 1;
        tc_errors   = 0;

        axi_write(8'h00, 32'h0000_0000);
        repeat(50) @(posedge aclk);
        current_phase_acc = 0;
        // Boost loop gains slightly for faster convergence
        axi_write(8'h14, 32'h0000_0080);  // COSTAS_KP × 2
        axi_write(8'h18, 32'h0000_0010);  // COSTAS_KI × 2
        axi_write(8'h00, 32'h0000_0001);

        // amp = 0x1800, 90° rotation
        fork
            send_symbols(600, 32'hAAAA_AAAA, 2, 16'h1800, 0);
            check_bits(40, 8'h55, 192);
        join

        if (tc_errors == 0) begin
            $display("  PASS – Combined loops settled");
            total_pass = total_pass + 1;
        end else begin
            $display("  FAIL – %0d byte errors", tc_errors);
        end

        // ==================================================================
        // Summary
        // ==================================================================
        $display("\n============================================================");
        $display("  Results: %0d / %0d tests passed", total_pass, total_tests);
        if (total_pass == total_tests)
            $display("  ALL TESTS PASSED");
        else
            $display("  SOME TESTS FAILED");
        $display("============================================================\n");

        #1000;
        $finish;
    end

    // =========================================================================
    // Watchdog
    // =========================================================================
    initial begin
        #20_000_000;
        $display("TIMEOUT – simulation exceeded 20 ms");
        $finish;
    end

    // =========================================================================
    // Waveform dump
    // =========================================================================
    initial begin
        $dumpfile("bpsk_demod_tb.vcd");
        $dumpvars(0, bpsk_demod_tb);
    end

endmodule
