`timescale 1ns / 1ps
// =============================================================================
// bpsk_demod_core.v  –  BPSK Demodulator Core
//
// Implements the complete conventional BPSK demodulation chain:
//
//   ADC I/Q samples
//       │
//       ▼
//   ┌───────┐
//   │  AGC  │  Amplitude equalization (normalises signal power)
//   └───┬───┘
//       ▼
//   ┌──────────────────────────────────────┐
//   │  Costas Loop                          │
//   │  ┌──────┐  complex   ┌────────────┐  │
//   │  │  NCO │ ──────────►│   Mixer    │  │
//   │  └──────┘  rotation  └─────┬──────┘  │
//   │      ▲                     │I_mix    │
//   │      │  freq_word    phase │Q_mix    │
//   │  ┌───┴──────┐       error  ▼         │
//   │  │ PI Filter│◄──── sign(I)·Q         │
//   └──┴──────────┴─────────────────────────┘
//       │ I_mix (phase-corrected)
//       ▼
//   ┌────────────────────────┐
//   │ Matched Filter         │  Integrate-and-dump over SPS samples
//   │ Symbol Timing (M&M)    │  Mueller-Müller TED adjusts dump strobe
//   └────────────┬───────────┘
//                │ I_dump (soft symbol)
//                ▼
//   ┌────────────────────────┐
//   │ Decision + Bit Packer  │  sign(I_dump) → bit, pack 8→byte
//   └────────────┬───────────┘
//                │
//                ▼
//        bits_tdata[7:0] / bits_tvalid
//
// Fixed-point number formats
// --------------------------
//   Data     : Q1.15  (16-bit signed)
//   NCO      : 32-bit phase accumulator
//   sin/cos  : Q1.15 from NCO LUT
//   Loop acc : 32-bit signed
//   AGC gain : Q4.12 (see bpsk_demod_agc.v)
//
// =============================================================================

module bpsk_demod_core (
    input  wire        clk,
    input  wire        resetn,

    // ADC input (from fifo_wr tap on util_ad9361_adc_pack)
    input  wire        adc_valid,
    input  wire signed [15:0] i_in,   // I0 from adc_data[15:0]
    input  wire signed [15:0] q_in,   // Q0 from adc_data[31:16]

    // Configuration (from AXI-Lite domain, already CDC'd)
    input  wire        cfg_enable,
    input  wire        cfg_bypass_agc,
    input  wire        cfg_bypass_costas,
    input  wire        cfg_bypass_timing,
    input  wire [7:0]  cfg_sps,            // samples per symbol (≥ 2)
    input  wire [15:0] cfg_agc_target,
    input  wire [3:0]  cfg_agc_ki_shift,
    input  wire [15:0] cfg_costas_kp,
    input  wire [15:0] cfg_costas_ki,
    input  wire [15:0] cfg_timing_kp,
    input  wire [15:0] cfg_timing_ki,

    // Bit output (AXI-Stream, 8-bit packed, MSB-first)
    output reg  [7:0]  bits_tdata,
    output reg         bits_tvalid,
    input  wire        bits_tready,

    // Diagnostic outputs (back-synced to AXI domain by wrapper)
    output wire [15:0] phase_err_out,
    output wire [15:0] timing_err_out,
    output wire [15:0] agc_gain_out,
    output wire        carrier_locked,
    output wire        agc_settled,
    output reg  [39:0] bit_count
);

    // =========================================================================
    // Stage 1: AGC
    // =========================================================================
    wire signed [15:0] i_agc, q_agc;
    wire [15:0]        agc_gain;
    wire               agc_ok;

    bpsk_demod_agc u_agc (
        .clk        (clk),
        .resetn     (resetn),
        .valid_in   (adc_valid && cfg_enable),
        .i_in       (i_in),
        .q_in       (q_in),
        .target_amp (cfg_agc_target),
        .ki_shift   (cfg_agc_ki_shift),
        .bypass     (cfg_bypass_agc),
        .i_out      (i_agc),
        .q_out      (q_agc),
        .gain_out   (agc_gain),
        .settled    (agc_ok)
    );

    assign agc_gain_out = agc_gain;
    assign agc_settled  = agc_ok;

    // =========================================================================
    // Stage 2: Costas Loop
    // =========================================================================

    // ---- Costas loop filter state -------------------------------------------
    reg  signed [31:0] freq_int;      // integral accumulator
    reg  signed [31:0] freq_word;     // NCO frequency word

    // ---- NCO + complex mixer ------------------------------------------------
    // NCO phase correction: proportional term (17 bits for sign extension into 18)
    wire signed [15:0] phase_err_p;    // defined below after mixer
    wire signed [17:0] phase_corr_nco = 18'sd0; // Proportional term handled in freq_word now

    wire signed [15:0] cos_nco, sin_nco;

    bpsk_demod_nco u_nco (
        .clk        (clk),
        .resetn     (resetn),
        .valid_in   (adc_valid && cfg_enable),
        .freq_word  (freq_word),
        .phase_corr (phase_corr_nco),
        .cos_out    (cos_nco),
        .sin_out    (sin_nco)
    );

    // Complex mixer: rotates I/Q by -θ (de-rotates carrier phase)
    //   I_mix =  I_agc * cos(θ) + Q_agc * sin(θ)
    //   Q_mix = -I_agc * sin(θ) + Q_agc * cos(θ)
    // Pipeline register (1 cycle latency)
    reg adc_valid_d1;
    always @(posedge clk) adc_valid_d1 <= adc_valid && cfg_enable;

    wire signed [31:0] mix_ii = $signed(i_agc) * cos_nco;
    wire signed [31:0] mix_iq = $signed(q_agc) * sin_nco;
    wire signed [31:0] mix_qi = $signed(i_agc) * sin_nco;
    wire signed [31:0] mix_qq = $signed(q_agc) * cos_nco;

    reg signed [15:0] i_mix, q_mix;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            i_mix <= 16'd0;
            q_mix <= 16'd0;
        end else begin
            i_mix <= cfg_bypass_costas ? i_agc : (mix_ii[30:15] + mix_iq[30:15]);
            q_mix <= cfg_bypass_costas ? q_agc : (mix_qq[30:15] - mix_qi[30:15]);
        end
    end

    // ---- Phase error detector (BPSK Costas discriminant) --------------------
    // e = sign(I_mix) * Q_mix
    //   = Q_mix when I_mix ≥ 0
    //   = -Q_mix when I_mix < 0
    assign phase_err_p = i_mix[15] ? (~q_mix + 16'd1) : q_mix;
    assign phase_err_out = phase_err_p;

    // ---- Costas PI loop filter (updated at sample rate) ---------------------
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            freq_int  <= 32'd0;
            freq_word <= 32'd0;
        end else if (adc_valid_d1) begin
            if (!cfg_bypass_costas) begin
                // freq_word needs to be negative feedback! phase_err is > 0 when Q_mix tracks I_mix (phase is advanced) so we should DECREASE freq
                freq_int <= freq_int -
                            (($signed({1'b0, cfg_costas_ki}) * $signed(phase_err_p)) * 16);
                freq_word <= freq_int -
                             (($signed({1'b0, cfg_costas_kp}) * $signed(phase_err_p)) * 16);
            end else begin
                freq_int  <= 32'd0;
                freq_word <= 32'd0;
            end
        end
    end

    // ---- Carrier lock detector ----------------------------------------------
    // Locked when |phase_err| < 256 (small) for 128 consecutive symbol periods
    reg [6:0]  lock_cnt;
    reg        c_locked;
    wire       err_small = (phase_err_p[15] ? (~phase_err_p[15:8] == 8'hFF) : (phase_err_p[15:8] == 8'h00));

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            lock_cnt <= 7'd0;
            c_locked <= 1'b0;
        end else if (adc_valid_d1 && !cfg_bypass_costas) begin
            if (err_small) begin
                if (lock_cnt == 7'd127) c_locked <= 1'b1;
                else                    lock_cnt <= lock_cnt + 7'd1;
            end else begin
                lock_cnt <= 7'd0;
                c_locked <= 1'b0;
            end
        end
    end
    assign carrier_locked = c_locked;

    // =========================================================================
    // Stage 3: Matched Filter + Symbol Timing Recovery (Mueller-Müller TED)
    // =========================================================================

    // ---- Integrate-and-dump counter -----------------------------------------
    // sps_eff = cfg_sps adjusted by timing loop (±1 count insert/delete)
    reg signed [15:0] timing_adj;         // signed timing correction
    reg [7:0]         sps_counter;
    reg signed [15:0] frac_timing;        // fractional timing accumulator
    reg [7:0]         sps_eff;

    // Integrate accumulator
    reg signed [21:0] integrate_acc;
    wire               dump_strobe;

    // Compute effective SPS with timing adjustment
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            sps_eff     <= 8'd8;
            frac_timing <= 16'd0;
        end else if (adc_valid_d1 && cfg_enable) begin
            if (dump_strobe) begin
                if (!cfg_bypass_timing) begin
                    // timing_adj is the combined PI output for frequency offset
                    if (frac_timing > 16384) begin
                        frac_timing <= frac_timing - 32768 + timing_adj;
                        sps_eff     <= (cfg_sps > 8'd2) ? cfg_sps - 8'd1 : cfg_sps;
                    end else if (frac_timing < -16384) begin
                        frac_timing <= frac_timing + 32768 + timing_adj;
                        sps_eff     <= (cfg_sps < 8'd127) ? cfg_sps + 8'd1 : cfg_sps;
                    end else begin
                        frac_timing <= frac_timing + timing_adj;
                        sps_eff     <= cfg_sps;
                    end
                end else begin
                    sps_eff     <= cfg_sps;
                    frac_timing <= 16'd0;
                end
            end
        end else if (!cfg_enable) begin
            sps_eff <= cfg_sps;
        end
    end

    // Dump strobe: one cycle before counter resets
    assign dump_strobe = adc_valid_d1 && cfg_enable &&
                         (sps_counter == sps_eff - 1);

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            sps_counter   <= 8'd0;
            integrate_acc <= 22'd0;
        end else if (adc_valid_d1 && cfg_enable) begin
            if (sps_counter == sps_eff - 1) begin
                sps_counter   <= 8'd0;
                integrate_acc <= {{6{i_mix[15]}}, i_mix};
            end else begin
                sps_counter   <= sps_counter + 8'd1;
                integrate_acc <= integrate_acc + {{6{i_mix[15]}}, i_mix};
            end
        end
    end

    // Dumped symbol value (I_dump): scaled sum ÷ SPS (take top 16 bits of 22-bit acc)
    wire signed [15:0] i_dump = integrate_acc[21:6];

    // ---- Mueller-Müller TED -------------------------------------------------
    // e = I_prev_dump * sign(I_dump) − I_dump * sign(I_prev_dump)
    reg signed [15:0] i_dump_prev;
    reg                i_prev_sign;   // sign of previous dump (1 = negative)

    wire               i_curr_sign = i_dump[15];
    // sign(x): term A is scaled previous dump based on current sign
    wire signed [15:0] mm_term_a = i_curr_sign ? (~i_dump_prev + 16'd1) : i_dump_prev;
    // term B is scaled current dump based on previous sign
    wire signed [15:0] mm_term_b = i_prev_sign ? (~i_dump + 16'd1)      : i_dump;

    // Use error = a - b strictly
            wire signed [15:0] timing_err = mm_term_a - mm_term_b;   // M&M error
    assign timing_err_out = timing_err;

    // Timing PI loop filter (updated each dump strobe)
    reg signed [31:0] timing_int;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            i_dump_prev  <= 16'd0;
            i_prev_sign  <= 1'b0;
            timing_int   <= 32'd0;
            timing_adj   <= 16'd0;
        end else if (dump_strobe) begin
            // Save current dump for M&M
            i_dump_prev <= i_dump;
            i_prev_sign <= i_curr_sign;

            if (!cfg_bypass_timing) begin
                // Timing integral
                timing_int <= timing_int + // MUST BE NEGATIVE FEEDBACK
                              ($signed({1'b0, cfg_timing_ki}) * $signed(timing_err)); // Base integral update

                // Timing adjustment (proportional + integral)
                timing_adj <= (($signed({1'b0, cfg_timing_kp}) * $signed(timing_err)) >>> 8)
                              + $signed(timing_int[31:16]);
            end
        end
    end

    // =========================================================================
    // Stage 4: Decision + 8-bit Packer
    // =========================================================================
    // bit = 0 when I_dump ≥ 0 (matches modulator: bit=0 → I_POS = 0x7FFF)
    // bit = 1 when I_dump < 0
    wire   bit_out   = i_dump[15];   // MSB = sign
    wire   bit_valid = dump_strobe;

    reg [2:0] bit_idx;              // counts 0..7

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            bits_tdata  <= 8'd0;
            bits_tvalid <= 1'b0;
            bit_idx     <= 3'd7;
            bit_count   <= 40'd0;
        end else begin
            bits_tvalid <= 1'b0;     // default de-assert

            if (bit_valid && cfg_enable) begin
                // Pack MSB first
                bits_tdata[bit_idx] <= bit_out;
                bit_count           <= bit_count + 40'd1;

                if (bit_idx == 3'd0) begin
                    bits_tvalid <= 1'b1;
                    bit_idx     <= 3'd7;
                end else begin
                    bit_idx <= bit_idx - 3'd1;
                end
            end

            // Hold tvalid high until tready (simple stall)
            if (bits_tvalid && !bits_tready)
                bits_tvalid <= 1'b1;
        end
    end

endmodule
