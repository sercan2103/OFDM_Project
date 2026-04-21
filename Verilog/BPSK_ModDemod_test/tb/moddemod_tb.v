`timescale 1ns / 1ps
// =============================================================================
// moddemod_tb.v  –  BPSK Modulator + Demodulator End-to-End BER Testbench
//
// Chain:
//   LFSR (23-bit) ──► bpsk_core (modulator) ──► [channel] ──► bpsk_demod_core ──► BER
//
// Test flow:
//   Phase 1 – Warmup  : 512 alternating symbols to lock AGC + Costas loops
//   Phase 2 – BER run : 4096 LFSR-generated symbols, TX bits recorded
//   Phase 3 – Analyse : search alignment offset 0–63, report BER at best fit
//
// Parameters tunable at the top of this file:
//   SPS          – samples per symbol (must equal sym_div)
//   N_WARMUP     – warm-up symbols before LFSR test
//   N_TEST       – LFSR test symbols
//   MAX_OFFSET   – maximum delay (symbols) to search during alignment
//   PHASE_ROT_EN – 1 = apply 45° rotation to simulate phase offset (Costas test)
//   ATTN_EN      – 1 = apply 0.5× attenuation (AGC test)
// =============================================================================

// ---- Tuneable parameters ---------------------------------------------------
`define SPS         16    // samples per symbol
`define N_WARMUP    512   // warm-up symbols (alternating)
`define N_TEST      4096  // BER test symbols  (512 received bytes)
`define MAX_OFFSET  64    // alignment search window (symbols)
`define PHASE_ROT_EN 0    // set 1 to inject 45° phase rotation
`define ATTN_EN      0    // set 1 to inject 0.5× attenuation

module moddemod_tb;

    // localparam wrappers for defines (avoids sized-literal cast errors)
    localparam integer SPS        = `SPS;
    localparam integer N_WARMUP   = `N_WARMUP;
    localparam integer N_TEST     = `N_TEST;
    localparam integer MAX_OFFSET = `MAX_OFFSET;

    // =========================================================================
    // Clock / reset
    // =========================================================================
    reg clk    = 0;
    reg resetn = 0;
    always #2 clk = ~clk;   // 250 MHz (4 ns period)

    initial begin
        repeat(20) @(posedge clk);
        resetn = 1;
    end

    // =========================================================================
    // TX LFSR – advances one step per consumed modulator symbol
    // =========================================================================
    wire        lfsr_bit;
    wire [22:0] lfsr_state;
    wire        lfsr_en;   // driven by modulator tready (defined below)

    lfsr #(.SEED(23'h55_5555)) u_lfsr (
        .clk    (clk),
        .resetn (resetn),
        .en     (lfsr_en),
        .bit_out(lfsr_bit),
        .state  (lfsr_state)
    );

    // =========================================================================
    // BPSK Modulator core
    // =========================================================================
    // Configuration wires
    reg        mod_enable    = 1'b0;
    reg [1:0]  mod_src_sel   = 2'b00;  // start with alternating
    reg [15:0] mod_sym_div   = `SPS;

    wire [7:0]  mod_axis_tdata;
    wire        mod_axis_tvalid;
    wire        mod_axis_tready;

    wire [63:0] mod_dac_tdata;
    wire        mod_dac_tvalid;

    // LFSR → modulator AXI-Stream bit interface
    assign mod_axis_tdata  = {7'd0, lfsr_bit};   // bit[0] = LFSR output
    assign mod_axis_tvalid = (mod_src_sel == 2'b10);  // valid when in LFSR mode

    // modulator consumes 1 bit per sym_tick (tready pulse)
    assign lfsr_en = mod_axis_tvalid && mod_axis_tready;

    bpsk_core u_mod (
        .aclk                (clk),
        .aresetn             (resetn),
        .cfg_enable          (mod_enable),
        .cfg_src_sel         (mod_src_sel),
        .cfg_ch_sel          (1'b0),
        .cfg_sym_div         (mod_sym_div),
        .cfg_i_pos           (16'h7FFF),
        .cfg_i_neg           (16'h8001),
        .cfg_pat_data        (32'd0),
        // bit stream input (LFSR mode)
        .s_axis_bits_tdata   (mod_axis_tdata),
        .s_axis_bits_tvalid  (mod_axis_tvalid),
        .s_axis_bits_tready  (mod_axis_tready),
        // DMA bypass – not used
        .s_axis_dma_tdata    (64'd0),
        .s_axis_dma_tvalid   (1'b0),
        .s_axis_dma_tready   (),
        .s_axis_dma_tlast    (1'b0),
        .s_axis_dma_tkeep    (8'hFF),
        // DAC output
        .m_axis_dac_tdata    (mod_dac_tdata),
        .m_axis_dac_tvalid   (mod_dac_tvalid),
        .m_axis_dac_tready   (1'b1),
        .m_axis_dac_tlast    (),
        .m_axis_dac_tkeep    (),
        .sym_count           ()
    );

    // =========================================================================
    // Optional channel impairments
    // =========================================================================
    // Applied to modulator I/Q output before feeding demodulator.
    //
    // PHASE_ROT_EN = 1: rotate by 45° (complex multiply by 0.707 + 0.707j)
    //   I' =  I * cos45 - Q * sin45 =  I * 0.5A82 / 0x7FFF
    //   Q' =  I * sin45 + Q * cos45
    //   (Q=0 for BPSK, so Q' = I * sin45)
    //
    // ATTN_EN = 1: multiply I, Q by 0.5 (right-shift by 1)
    // =========================================================================
    wire signed [15:0] i_raw = $signed(mod_dac_tdata[15:0]);
    wire signed [15:0] q_raw = $signed(mod_dac_tdata[31:16]);
    wire               ch_valid = mod_dac_tvalid;

    // Phase rotation (45°): cos45 = sin45 = 16'h5A82 (Q1.15)
    wire signed [31:0] rot_ii = i_raw * $signed(16'h5A82);
    wire signed [31:0] rot_iq = q_raw * $signed(16'h5A82);
    wire signed [31:0] rot_qi = i_raw * $signed(16'h5A82);
    wire signed [31:0] rot_qq = q_raw * $signed(16'h5A82);

    wire signed [15:0] i_rotated = (rot_ii[30:15] - rot_iq[30:15]);
    wire signed [15:0] q_rotated = (rot_qi[30:15] + rot_qq[30:15]);

    // Select impairments
    wire signed [15:0] i_ch = `PHASE_ROT_EN ? i_rotated :
                               `ATTN_EN      ? {i_raw[15], i_raw[15:1]} :
                                               i_raw;
    wire signed [15:0] q_ch = `PHASE_ROT_EN ? q_rotated :
                               `ATTN_EN      ? {q_raw[15], q_raw[15:1]} :
                                               q_raw;

    // =========================================================================
    // BPSK Demodulator core
    // =========================================================================
    wire [7:0]  demod_byte;
    wire        demod_valid;
    wire        carrier_locked;
    wire        agc_settled;
    wire [15:0] phase_err_out;
    wire [15:0] timing_err_out;
    wire [15:0] agc_gain_out;
    wire [39:0] bit_count;

    bpsk_demod_core u_demod (
        .clk                (clk),
        .resetn             (resetn),
        .adc_valid          (ch_valid),
        .i_in               (i_ch),
        .q_in               (q_ch),
        .cfg_enable         (1'b1),
        .cfg_bypass_agc     (1'b0),
        .cfg_bypass_costas  (1'b0),
        .cfg_bypass_timing  (1'b0),
        .cfg_sps            (SPS[7:0]),
        .cfg_agc_target     (16'h2000),
        .cfg_agc_ki_shift   (4'd4),
        .cfg_costas_kp      (16'h0040),
        .cfg_costas_ki      (16'h0008),
        .cfg_timing_kp      (16'h0020),
        .cfg_timing_ki      (16'h0004),
        .bits_tdata         (demod_byte),
        .bits_tvalid        (demod_valid),
        .bits_tready        (1'b1),
        .phase_err_out      (phase_err_out),
        .timing_err_out     (timing_err_out),
        .agc_gain_out       (agc_gain_out),
        .carrier_locked     (carrier_locked),
        .agc_settled        (agc_settled),
        .bit_count          (bit_count)
    );

    // =========================================================================
    // TX bit recording buffer
    // =========================================================================
    localparam N_BUF = `N_TEST + `MAX_OFFSET + 64;

    reg tx_bits [0 : N_BUF-1];
    integer tx_ptr = 0;

    // Record each TX bit at the sym_tick that actually modulates it.
    // axis_bit is the registered copy of the last accepted lfsr_bit — this is
    // the value that drives i_hold (and hence the DAC output) for the current
    // symbol, so it is the bit the demodulator will see.
    always @(posedge clk) begin
        if (mod_src_sel == 2'b10 && mod_axis_tready && mod_axis_tvalid) begin
            if (tx_ptr < N_BUF) begin
                tx_bits[tx_ptr] <= u_mod.axis_bit;
                tx_ptr          <= tx_ptr + 1;
            end
        end
    end

    // =========================================================================
    // RX bit extraction buffer
    // =========================================================================
    // Demodulator outputs MSB-first bytes. Bit 7 is the first received symbol.
    //   rx_bits[8*byte_k + j] = tdata[7-j]  for j = 0..7

    // Buffer big enough for warmup bits + Phase-2 bits + alignment headroom
    reg rx_bits [0 : `N_WARMUP + `N_TEST + `MAX_OFFSET + 63];
    integer rx_ptr   = 0;
    integer rx_start = 0;   // set to rx_ptr at Phase-2 start (avoids reset race)

    always @(posedge clk) begin
        if (demod_valid) begin : unpack
            integer j;
            for (j = 0; j < 8; j = j + 1) begin
                if (rx_ptr + j < `N_WARMUP + `N_TEST + `MAX_OFFSET + 64)
                    rx_bits[rx_ptr + j] <= demod_byte[7 - j];
            end
            rx_ptr <= rx_ptr + 8;
        end
    end

    // =========================================================================
    // BER analysis task
    // =========================================================================
    // Returns ber_errors for a given alignment offset.
    // Compares tx_bits[k+offset] with rx_bits[rx_start+k] for k=0..n_compare-1.
    task count_errors;
        input integer offset;
        input integer n_compare;
        output integer errors;
        integer k;
        integer err_normal;
        integer err_invert;
        begin
            err_normal = 0;
            err_invert = 0;
            for (k = 0; k < n_compare; k = k + 1) begin
                if (tx_bits[k] !== rx_bits[rx_start + k + offset])
                    err_normal = err_normal + 1;
                if (tx_bits[k] !== ~rx_bits[rx_start + k + offset])
                    err_invert = err_invert + 1;
            end
            if (err_invert < err_normal)
                errors = err_invert;
            else
                errors = err_normal;
        end
    endtask

    // =========================================================================
    // Stimulus + measurement
    // =========================================================================
    integer sym_i;
    integer best_offset, best_errors, best_n;
    integer off, errs, n_cmp;
    real    ber;

    initial begin
        // ---- Wait for reset release -----------------------------------------
        @(posedge resetn);
        repeat(10) @(posedge clk);

        // =====================================================================
        // Phase 1: Warm-up with alternating bits
        // =====================================================================
        $display("[%0t] Phase 1: warm-up (%0d symbols, alternating)", $time, `N_WARMUP);
        mod_src_sel <= 2'b00;    // alternating pattern
        mod_enable  <= 1'b1;

        // wait for AGC + carrier lock or N_WARMUP symbols
        sym_i = 0;
        while (sym_i < `N_WARMUP) begin
            @(posedge clk);
            if (u_mod.sym_tick) sym_i = sym_i + 1;
        end

        $display("[%0t] Warmup done: agc_settled=%b carrier_locked=%b agc_gain=0x%04X",
                 $time, agc_settled, carrier_locked, agc_gain_out);

        // =====================================================================
        // Phase 2: LFSR BER test
        // =====================================================================
        $display("[%0t] Phase 2: LFSR BER test (%0d symbols)", $time, `N_TEST);
        // Wait for the last warmup byte to flush through the demodulator pipeline.
        // rx_ptr reaches N_WARMUP once all 64 warmup bytes have been output.
        while (rx_ptr < `N_WARMUP) @(posedge clk);
        rx_start = rx_ptr;   // = N_WARMUP, points just after all warmup bits
        tx_ptr   = 0;        // safe: tx always-block gated on mod_src_sel==10

        @(posedge clk);
        mod_src_sel <= 2'b10;    // LFSR (AXI-Stream) mode

        // Send N_TEST symbols and wait for enough RX bytes
        sym_i = 0;
        while (sym_i < `N_TEST) begin
            @(posedge clk);
            if (u_mod.sym_tick) sym_i = sym_i + 1;
        end

        // Extra time to flush the pipeline (2× SPS × 8 symbols extra)
        repeat(`SPS * 20) @(posedge clk);

        // =====================================================================
        // Phase 3: Alignment search + BER
        // =====================================================================
        $display("[%0t] Phase 3: alignment search (offset 0..%0d)",
                 $time, `MAX_OFFSET - 1);

        best_errors = `N_TEST + 1;
        best_offset = 0;
        // compare N_TEST - MAX_OFFSET bits to stay within both buffers
        n_cmp = `N_TEST - `MAX_OFFSET;

        for (off = 0; off < `MAX_OFFSET; off = off + 1) begin
            count_errors(off, n_cmp, errs);
            $display("  offset=%3d  errors=%5d / %5d  BER=%e",
                     off, errs, n_cmp, (1.0 * errs) / n_cmp);
            if (errs < best_errors) begin
                best_errors = errs;
                best_offset = off;
                best_n      = n_cmp;
            end
        end

        ber = (1.0 * best_errors) / best_n;

        $display("  tx_ptr=%0d  rx_ptr=%0d  rx_start=%0d", tx_ptr, rx_ptr, rx_start);

        // Quick sanity: print first 32 TX bits and RX bits at best offset
        begin : dbg_bits
            integer bi;
            $write("TX[0..31]: ");
            for (bi = 0; bi < 32; bi = bi + 1) $write("%b", tx_bits[bi]);
            $write("\n");
            $write("RX[rs..rs+31]: ");
            for (bi = 0; bi < 32; bi = bi + 1) $write("%b", rx_bits[rx_start + bi]);
            $write("\n");
            $write("RX@best  : ");
            for (bi = 0; bi < 32; bi = bi + 1) $write("%b", rx_bits[rx_start + best_offset + bi]);
            $write("\n");
        end

        $display("");
        $display("============================================================");
        $display("  Best alignment offset : %0d symbols", best_offset);
        $display("  Bit errors            : %0d / %0d", best_errors, best_n);
        $display("  BER                   : %e", ber);
        $display("  carrier_locked        : %b", carrier_locked);
        $display("  agc_settled           : %b", agc_settled);
        $display("  agc_gain (Q4.12)      : 0x%04X  (%f)", agc_gain_out,
                 $itor(agc_gain_out) / 4096.0);
        $display("  phase_err             : %d", $signed(phase_err_out));
        $display("  timing_err            : %d", $signed(timing_err_out));
        $display("  total decoded bits    : %0d", bit_count);
        $display("");
        if (best_errors == 0)
            $display("  RESULT: PERFECT  – BER = 0 (zero bit errors)");
        else if (ber < 1e-3)
            $display("  RESULT: GOOD     – BER < 1e-3");
        else
            $display("  RESULT: DEGRADED – BER >= 1e-3 (check loop parameters)");
        $display("============================================================");

        #5000;
        $finish;
    end

    // =========================================================================
    // Waveform dump
    // =========================================================================
    initial begin
        $dumpfile("moddemod_tb.vcd");
        $dumpvars(0, moddemod_tb);
    end

    // =========================================================================
    // Watchdog (abort if stuck)
    // =========================================================================
    initial begin
        #50_000_000;   // 50 ms simulation limit
        $display("WATCHDOG: simulation timeout");
        $finish;
    end

endmodule
