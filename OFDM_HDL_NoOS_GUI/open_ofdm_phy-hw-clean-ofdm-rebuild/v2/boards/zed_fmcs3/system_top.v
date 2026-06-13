// Stage 2B-4 OFDM-through-axi_ad9361 top.
//
// gpio_o[41] = 0  (default, Stage 2B-4 OFDM through axi_ad9361):
//   openofdm_tx samples -> tx_cdc async FIFO (bb_clk -> l_clk) ->
//   dac_data_* -> chip BIST mode 1 data-port loopback -> adc_data_* ->
//   rx_cdc async FIFO (l_clk -> bb_clk) -> 10-cycle drain ->
//   [AWGN injection] -> dot11.
//   Decoder status counters on gpio_i (gpio_o[40] = 0).
//
// gpio_o[41] = 1  (Stage 2B-3 BIST pattern test):
//   Drive constant 0xCAFE/0xBABE on dac_data_*. With chip in the same
//   BIST loopback mode, those patterns appear on adc_data_* (modulo
//   12-bit MSB-justification truncation: ~0xFCAF / 0xFBAB on RX).
//   Last-sample latches on gpio_i (gpio_o[40] = 1).
//
// AWGN channel injection (gpio_o[59:59], gpio_o[63:60]):
//   gpio_o[59]    = awgn_enable    (1=inject noise, 0=bypass)
//   gpio_o[63:60] = noise_shift    (4-bit right-shift applied to raw noise)
//                   0 = max noise (~-10 dB SNR), 15 = near-zero noise
//                   Each +1 step ≈ +6 dB SNR. See awgn_noise_gen.v for table.
//
// Stage 1C path (no AD9361 round-trip) is no longer instantiated;
// the iq_sample_fifo + direct drain has been replaced by the async-
// FIFO bridge so we can validate the digital RF path. To regression-
// test 1C, check out commit ace3e90.
//
// Stage 1C original notes (kept for context on dot11 wiring):
//
// Mirrors the proven simulation testbench
// (ofdmTxRx.srcs/sources_1/new/openofdm_transceiver_tb.v):
//   - openofdm_tx writes 32-bit {I,Q} samples into iq_sample_fifo while
//     phy_tx_started is asserted. result_iq_hold = fifo_full provides
//     backpressure (TX shouldn't fill 4096 deep FIFO for 24B payload).
//   - On phy_tx_done the FIFO switches itself from write-mode to read-mode.
//     rx_started latches and stays high.
//   - A 10-cycle counter drains the FIFO and feeds dot11. sample_in
//     latches the FIFO output every 10 clocks; sample_in_strobe pulses
//     for one clock at clk_count==4.
//   - dot11 + signal_watchdog instantiated directly (bypasses the
//     openofdm_rx AXI wrapper -- config passed as input ports per TB).
//
// Status word on gpio_i[63:0] -- unchanged from earlier Stage 1C draft:
//   [ 7: 0]  fcs_ok_count
//   [15: 8]  bad_pkt_count
//   [23:16]  hdr_valid_count
//   [31:24]  last_pkt_rate
//   [47:32]  last_pkt_len
//   [63:48]  last_byte_count

`timescale 1ns / 1ps

module system_top (
  // ------------ DDR ------------
  inout  wire [14:0] DDR_addr,
  inout  wire [ 2:0] DDR_ba,
  inout  wire        DDR_cas_n,
  inout  wire        DDR_ck_n,
  inout  wire        DDR_ck_p,
  inout  wire        DDR_cke,
  inout  wire        DDR_cs_n,
  inout  wire [ 3:0] DDR_dm,
  inout  wire [31:0] DDR_dq,
  inout  wire [ 3:0] DDR_dqs_n,
  inout  wire [ 3:0] DDR_dqs_p,
  inout  wire        DDR_odt,
  inout  wire        DDR_ras_n,
  inout  wire        DDR_reset_n,
  inout  wire        DDR_we_n,

  // ------------ FIXED_IO ------------
  inout  wire [53:0] FIXED_IO_mio,
  inout  wire        FIXED_IO_ddr_vrn,
  inout  wire        FIXED_IO_ddr_vrp,
  inout  wire        FIXED_IO_ps_srstb,
  inout  wire        FIXED_IO_ps_clk,
  inout  wire        FIXED_IO_ps_porb,

  output wire        led,

  // ------------ Stage 2A: AD9361 SPI + control on FMC LPC ----------
  // SPI is PS SPI0 routed via EMIO. Control pins are EMIO GPIOs.
  output wire        ad9361_spi_clk,
  output wire        ad9361_spi_mosi,
  input  wire        ad9361_spi_miso,
  output wire        ad9361_spi_csn,
  output wire        ad9361_resetb,
  output wire        ad9361_enable,
  output wire        ad9361_txnrx,

  // ------------ Stage 2B-1: AD9361 LVDS data interface ------------
  // Wired to FMC LPC pins (constraints from fmcomms2 zed reference).
  input  wire        rx_clk_in_p,
  input  wire        rx_clk_in_n,
  input  wire        rx_frame_in_p,
  input  wire        rx_frame_in_n,
  input  wire [5:0]  rx_data_in_p,
  input  wire [5:0]  rx_data_in_n,
  output wire        tx_clk_out_p,
  output wire        tx_clk_out_n,
  output wire        tx_frame_out_p,
  output wire        tx_frame_out_n,
  output wire [5:0]  tx_data_out_p,
  output wire [5:0]  tx_data_out_n
);

  wire        bb_clk;
  wire        bb_rstn;
  wire        bb_rst = ~bb_rstn;
  wire [63:0] gpio_o;
  wire [63:0] gpio_i;
  wire [63:0] gpio_t;

  // Stage 2B-3: axi_ad9361 data ports (l_clk domain).
  wire        l_clk;
  wire [15:0] adc_data_i0, adc_data_q0, adc_data_i1, adc_data_q1;
  wire        adc_valid_i0, adc_valid_q0, adc_valid_i1, adc_valid_q1;
  wire        adc_enable_i0, adc_enable_q0, adc_enable_i1, adc_enable_q1;
  wire        dac_valid_i0, dac_valid_q0, dac_valid_i1, dac_valid_q1;
  wire        dac_enable_i0, dac_enable_q0, dac_enable_i1, dac_enable_q1;
  wire [15:0] dac_data_i0, dac_data_q0, dac_data_i1, dac_data_q1;

  // PS SPI0 (EMIO).
  wire        spi0_sclk_o;
  wire        spi0_mosi_o;
  wire        spi0_miso_i;
  wire        spi0_ss_o;

  (* mark_debug = "true", keep = "true" *) wire phy_tx_start;
  assign phy_tx_start = gpio_o[32];

  // AD9361 control: drive directly from EMIO GPIOs.
  assign ad9361_resetb = gpio_o[33];
  assign ad9361_enable = gpio_o[34];
  assign ad9361_txnrx  = gpio_o[35];

  // AD9361 SPI: drive top-level pins from PS SPI0 EMIO outputs.
  assign ad9361_spi_clk  = spi0_sclk_o;
  assign ad9361_spi_mosi = spi0_mosi_o;
  assign ad9361_spi_csn  = spi0_ss_o;
  assign spi0_miso_i     = ad9361_spi_miso;

  // ============================================================
  // BD wrapper.
  // ============================================================
  system_wrapper i_system (
    .DDR_addr(DDR_addr),         .DDR_ba(DDR_ba),
    .DDR_cas_n(DDR_cas_n),       .DDR_ck_n(DDR_ck_n),
    .DDR_ck_p(DDR_ck_p),         .DDR_cke(DDR_cke),
    .DDR_cs_n(DDR_cs_n),         .DDR_dm(DDR_dm),
    .DDR_dq(DDR_dq),             .DDR_dqs_n(DDR_dqs_n),
    .DDR_dqs_p(DDR_dqs_p),       .DDR_odt(DDR_odt),
    .DDR_ras_n(DDR_ras_n),       .DDR_reset_n(DDR_reset_n),
    .DDR_we_n(DDR_we_n),
    .FIXED_IO_mio(FIXED_IO_mio),
    .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
    .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
    .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
    .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
    .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
    .FCLK_CLK0(bb_clk),
    .peripheral_aresetn(bb_rstn),
    .GPIO_O(gpio_o),
    .GPIO_I(gpio_i),
    .GPIO_T(gpio_t),
    .spi0_sclk_o(spi0_sclk_o),
    .spi0_mosi_o(spi0_mosi_o),
    .spi0_miso_i(spi0_miso_i),
    .spi0_ss_o  (spi0_ss_o),
    .rx_clk_in_p(rx_clk_in_p),     .rx_clk_in_n(rx_clk_in_n),
    .rx_frame_in_p(rx_frame_in_p), .rx_frame_in_n(rx_frame_in_n),
    .rx_data_in_p(rx_data_in_p),   .rx_data_in_n(rx_data_in_n),
    .tx_clk_out_p(tx_clk_out_p),   .tx_clk_out_n(tx_clk_out_n),
    .tx_frame_out_p(tx_frame_out_p), .tx_frame_out_n(tx_frame_out_n),
    .tx_data_out_p(tx_data_out_p), .tx_data_out_n(tx_data_out_n),
    .l_clk(l_clk),
    .dac_data_i0(dac_data_i0), .dac_data_q0(dac_data_q0),
    .dac_data_i1(dac_data_i1), .dac_data_q1(dac_data_q1),
    .dac_valid_i0(dac_valid_i0), .dac_valid_q0(dac_valid_q0),
    .dac_valid_i1(dac_valid_i1), .dac_valid_q1(dac_valid_q1),
    .dac_enable_i0(dac_enable_i0), .dac_enable_q0(dac_enable_q0),
    .dac_enable_i1(dac_enable_i1), .dac_enable_q1(dac_enable_q1),
    .adc_data_i0(adc_data_i0), .adc_data_q0(adc_data_q0),
    .adc_data_i1(adc_data_i1), .adc_data_q1(adc_data_q1),
    .adc_valid_i0(adc_valid_i0), .adc_valid_q0(adc_valid_q0),
    .adc_valid_i1(adc_valid_i1), .adc_valid_q1(adc_valid_q1),
    .adc_enable_i0(adc_enable_i0), .adc_enable_q0(adc_enable_q0),
    .adc_enable_i1(adc_enable_i1), .adc_enable_q1(adc_enable_q1),
    // Phase 3: xcvr relay BRAM Port B (system_top drives, BRAM drives dout).
    // Port B is 64-bit / 64-word; byte address = word_addr * 8.
    // Only otx_bram_addr[5:0] (within-block offset 0..63) is used -- the
    // mcs_base offset is irrelevant in relay mode since the whole packet
    // is at BRAM address 0.
    .BRAM_PORTB_XCVR_addr ({otx_bram_addr[5:0], 3'b0}),
    .BRAM_PORTB_XCVR_clk  (bb_clk),
    .BRAM_PORTB_XCVR_din  (64'd0),
    .BRAM_PORTB_XCVR_dout (xcvr_bram_dout),
    .BRAM_PORTB_XCVR_en   (1'b1),
    .BRAM_PORTB_XCVR_rst  (bb_rst),
    .BRAM_PORTB_XCVR_we   (8'd0)
  );

  // ============================================================
  // Stage 2B-4: async-FIFO bridge to/from axi_ad9361 (l_clk domain).
  //
  // Two xpm_fifo_async instances:
  //   tx_cdc:  bb_clk -> l_clk. openofdm_tx writes IQ samples; chip
  //            drains via dac_valid_i0 handshake.
  //   rx_cdc:  l_clk -> bb_clk. Chip writes via adc_valid_i0; the
  //            existing 10-cycle drain pops samples on bb_clk.
  //
  // Mode select gpio_o[41] muxes between OFDM samples (default) and
  // the Stage 2B-3 constant pattern (0xCAFE / 0xBABE) on the DAC side.
  // ============================================================
  wire        bist_pat_mode = gpio_o[41];

  wire        tx_cdc_full;
  wire        tx_cdc_empty;
  wire [31:0] tx_cdc_dout;

  // ============================================================
  // Rate adapter (openwifi-hw style, simplified for our l_clk domain).
  //
  // Run 8 confirmed chip is at 40 MSPS chain (l_clk=80 MHz). Without
  // explicit zero-stuffing on TX and decimation on RX, dot11 sees a
  // mix of real samples and zero slots that destroys L-STF correlation.
  //
  // dac_phase: toggles on every dac_valid_i0. On phase=0 we read one
  // sample from tx_cdc and drive it; on phase=1 we drive zero.
  // -> chip sees [s0, 0, s1, 0, s2, 0, ...] = 1:2 zero-stuffed stream.
  //
  // adc_phase: similar toggle on adc_valid_i0, but starts gated until
  // (a) capture_window opens (first tx_cdc_rd_pulse_l of a packet)
  //     so we don't grab samples between bursts, and
  // (b) skip_target adc_valid_i0 events have passed -- this aligns
  //     us to the chip's data-port loopback pipeline depth and lets
  //     SW pick which phase (real-sample vs zero-slot) to capture.
  // -> rx_cdc receives only the real-sample echoes at 20 MSPS.
  //
  // gpio_o[50:48] = skip_target (0..7). Sweep covers both phase
  // polarities and chip pipeline depths.
  //
  // tx_active rising edge resets all state per-packet so the sweep
  // gets a clean run each iteration.
  // ============================================================
  wire [2:0] skip_target_bb = gpio_o[50:48];
  reg  [2:0] skip_target_l1 = 3'd0, skip_target_l2 = 3'd0;
  always @(posedge l_clk) begin
    skip_target_l1 <= skip_target_bb;
    skip_target_l2 <= skip_target_l1;
  end

  // tx_active CDC (bb_clk -> l_clk) + rising-edge detect.
  reg tx_active_l1 = 1'b0, tx_active_l2 = 1'b0, tx_active_l3 = 1'b0;
  always @(posedge l_clk) begin
    tx_active_l1 <= tx_active;
    tx_active_l2 <= tx_active_l1;
    tx_active_l3 <= tx_active_l2;
  end
  wire tx_active_rise_l = tx_active_l2 & ~tx_active_l3;

  // adc_valid_i0 pulses per chip sample (40 MHz). Use rising-edge.
  reg adc_valid_d = 1'b0;
  always @(posedge l_clk) adc_valid_d <= adc_valid_i0;
  wire adc_valid_rise = adc_valid_i0 & ~adc_valid_d;

  // dac_valid_i0 is a LEVEL signal -- continuously asserted while DAC
  // core is enabled. No per-sample handshake. So we drive dac_data on
  // a free-running 40 MHz logical clock (mod-2 of l_clk), holding each
  // value stable for 2 l_clks so the chip can sample on either l_clk
  // edge phase and see the same value.
  reg clk_div_phase = 1'b0;
  always @(posedge l_clk) clk_div_phase <= ~clk_div_phase;

  // dac_zs_phase: alternates 0/1 at the 40 MHz chip-sample boundary.
  // 0 = real-sample slot, 1 = zero slot.
  reg dac_zs_phase = 1'b0;
  always @(posedge l_clk) begin
    if (!bb_rstn || tx_active_rise_l) dac_zs_phase <= 1'b0;
    else if (clk_div_phase)            dac_zs_phase <= ~dac_zs_phase;
  end

  // SW-tunable polarity invert (gpio_o[42]). The chip samples on a
  // specific phase of its 40 MHz clock; if our dac_zs_phase=0 cycles
  // happen to align with the chip's "between samples" phase, the chip
  // would see only zeros. Inverting flips real-vs-zero slots.
  wire polarity_invert_bb = gpio_o[42];
  reg  polarity_l1 = 1'b0, polarity_l2 = 1'b0;
  always @(posedge l_clk) begin
    polarity_l1 <= polarity_invert_bb;
    polarity_l2 <= polarity_l1;
  end
  wire dac_real_slot = (dac_zs_phase ^ polarity_l2) == 1'b0;

  // tx_cdc_rd: pop one sample per "real-sample slot transition" =
  // once per 4 l_clks = 20 MHz, matching openofdm_tx output rate.
  wire tx_cdc_rd_pulse_l = clk_div_phase & dac_real_slot & ~tx_cdc_empty;

  // RX capture state machine.
  //
  // Run 9 bug: capture_window stayed high forever after first
  // tx_cdc_rd_pulse_l, so rx_cdc filled with thousands of post-burst
  // zeros. Fix = close window after sample-count limit reached.
  // Limit chosen as 1200 (1118 expected + 82 chip-pipeline margin).
  // capture_count is the # of rx_cdc writes within the current burst.
  reg        capture_window  = 1'b0;
  reg        capture_active  = 1'b0;
  reg [3:0]  adc_skip_count  = 4'd0;
  reg        adc_phase       = 1'b0;
  reg [11:0] capture_count   = 12'd0;
  // 100-byte PSDU at BPSK 1/2: ~40 OFDM symbols * 80 samples = 3200 IQ
  // samples + ~100 margin. 12-bit count holds up to 4095.
  localparam integer CAPTURE_LIMIT = 3500;

  wire fresh_echo_arriving =
    capture_window & capture_active & adc_valid_rise & ~adc_phase;

  // Phase 2: detect force_rx rising edge in l_clk domain to re-arm capture.
  reg  force_rx_l_d = 1'b0;
  always @(posedge l_clk) force_rx_l_d <= force_rx_l;
  wire force_rx_rise_l = force_rx_l & ~force_rx_l_d;

  always @(posedge l_clk) begin
    if (!bb_rstn || tx_active_rise_l) begin
      // Full reset on system reset or new TX burst start.
      capture_window <= 1'b0;
      capture_active <= 1'b0;
      adc_skip_count <= 4'd0;
      adc_phase      <= 1'b0;
      capture_count  <= 12'd0;
    end else if (force_rx_rise_l) begin
      // Phase 2: force_rx asserted -- open capture immediately, bypass TX sync.
      capture_window <= 1'b1;
      capture_active <= 1'b1;
      adc_skip_count <= 4'd0;
      adc_phase      <= 1'b0;
      capture_count  <= 12'd0;
    end else begin
      if (tx_cdc_rd_pulse_l && !capture_window && capture_count == 12'd0)
        capture_window <= 1'b1;
      if (adc_valid_rise && capture_window) begin
        if (!capture_active) begin
          if (adc_skip_count == {1'b0, skip_target_l2}) capture_active <= 1'b1;
          else                                          adc_skip_count <= adc_skip_count + 4'd1;
        end
        if (capture_active) adc_phase <= ~adc_phase;
      end
      // Count rx_cdc writes. In force_rx mode keep window open (no CAPTURE_LIMIT).
      if (fresh_echo_arriving & ~rx_cdc_full) begin
        if (!force_rx_l && capture_count == CAPTURE_LIMIT - 1) begin
          capture_window <= 1'b0;
          capture_count  <= capture_count + 12'd1;
        end else begin
          capture_count <= capture_count + 12'd1;
        end
      end
    end
  end

  // ============================================================
  // Phase 2: RX IQ capture buffer (4096 samples, l_clk domain, block RAM).
  // Captures first 4096 IQ samples of each burst (~3500 valid for a
  // 100-byte PSDU; samples 3500-4095 hold stale values from prior burst).
  // Triggered by tx_active_rise_l (loopback) or force_rx rising edge.
  // PS reads via gpio_i after setting 12-bit iq_idx on gpio_o[18:7].
  // ============================================================
  (* ram_style = "block" *) reg [15:0] rx_iq_cap_i [0:4095];
  (* ram_style = "block" *) reg [15:0] rx_iq_cap_q [0:4095];
  reg [11:0] rx_cap_idx    = 12'd0;
  reg        rx_cap_active = 1'b0;

  always @(posedge l_clk) begin
    if (!bb_rstn) begin
      rx_cap_idx    <= 12'd0;
      rx_cap_active <= 1'b0;
    end else begin
      if (tx_active_rise_l || force_rx_rise_l) begin
        rx_cap_active <= 1'b1;
        rx_cap_idx    <= 12'd0;
      end else if (rx_cap_active && fresh_echo_arriving) begin
        rx_iq_cap_i[rx_cap_idx] <= adc_data_i0;
        rx_iq_cap_q[rx_cap_idx] <= adc_data_q0;
        if (rx_cap_idx == 12'd4095) rx_cap_active <= 1'b0;
        else                        rx_cap_idx    <= rx_cap_idx + 12'd1;
      end
    end
  end

  // IQ sample index: PS writes gpio_o[18:7] (12-bit, supports 0..4095).
  // Synchronise to l_clk so RX mux reads a consistent address.
  wire [11:0] iq_idx_bb = gpio_o[18:7];
  reg  [11:0] iq_idx_l1 = 12'd0, iq_idx_l2 = 12'd0;
  always @(posedge l_clk) begin
    iq_idx_l1 <= iq_idx_bb;
    iq_idx_l2 <= iq_idx_l1;
  end

  // Block-RAM synchronous read in l_clk (1 cycle latency).
  // Then 2-FF sync to bb_clk.  Total latency vs PS write: ~3 l_clk cycles
  // << usleep(10) used by PS, so readback is always stable.
  reg [15:0] rx_iq_mux_i = 16'd0;
  reg [15:0] rx_iq_mux_q = 16'd0;
  always @(posedge l_clk) begin
    rx_iq_mux_i <= rx_iq_cap_i[iq_idx_l2];
    rx_iq_mux_q <= rx_iq_cap_q[iq_idx_l2];
  end

  reg [15:0] rx_iq_bb_i_s1 = 16'd0, rx_iq_bb_i_s2 = 16'd0;
  reg [15:0] rx_iq_bb_q_s1 = 16'd0, rx_iq_bb_q_s2 = 16'd0;
  always @(posedge bb_clk) begin
    rx_iq_bb_i_s1 <= rx_iq_mux_i;  rx_iq_bb_i_s2 <= rx_iq_bb_i_s1;
    rx_iq_bb_q_s1 <= rx_iq_mux_q;  rx_iq_bb_q_s2 <= rx_iq_bb_q_s1;
  end

  // tx_cdc: bb_clk -> l_clk async FIFO. Read gated by dac_phase=0 so
  // the rate adapter only pops one sample per 2 dac_valid cycles.
  xpm_fifo_async #(
    .CDC_SYNC_STAGES   (2),
    .DOUT_RESET_VALUE  ("0"),
    .ECC_MODE          ("no_ecc"),
    .FIFO_MEMORY_TYPE  ("auto"),
    .FIFO_READ_LATENCY (0),
    .FIFO_WRITE_DEPTH  (1024),
    .FULL_RESET_VALUE  (0),
    .READ_DATA_WIDTH   (32),
    .READ_MODE         ("fwft"),
    .RELATED_CLOCKS    (0),
    .USE_ADV_FEATURES  ("0707"),
    .WAKEUP_TIME       (0),
    .WRITE_DATA_WIDTH  (32),
    .WR_DATA_COUNT_WIDTH(11),
    .RD_DATA_COUNT_WIDTH(11),
    .PROG_EMPTY_THRESH (10),
    .PROG_FULL_THRESH  (10),
    .SIM_ASSERT_CHK    (0)
  ) tx_cdc (
    .wr_clk        (bb_clk),
    .rst           (bb_rst),
    .din           ({tx_result_i, tx_result_q}),
    .wr_en         (tx_result_iq_valid & tx_active & ~tx_cdc_full),
    .full          (tx_cdc_full),
    .rd_clk        (l_clk),
    .rd_en         (tx_cdc_rd_pulse_l),
    .dout          (tx_cdc_dout),
    .empty         (tx_cdc_empty),
    .almost_full   (), .almost_empty(),
    .wr_data_count (), .rd_data_count(),
    .wr_rst_busy   (), .rd_rst_busy (),
    .data_valid    (), .wr_ack      (),
    .injectsbiterr (1'b0), .injectdbiterr(1'b0),
    .sbiterr       (), .dbiterr     (),
    .overflow      (), .underflow   (),
    .prog_full     (), .prog_empty  (),
    .sleep         (1'b0)
  );

  wire        rx_cdc_full;
  wire        rx_cdc_empty;
  wire [31:0] rx_cdc_dout;
  reg         rx_cdc_rd_en;

  // rx_cdc deeper than tx_cdc to absorb a full burst even if bb-side
  // drain (10-cycle pace = 10 MSPS) lags producer.
  xpm_fifo_async #(
    .CDC_SYNC_STAGES   (2),
    .DOUT_RESET_VALUE  ("0"),
    .ECC_MODE          ("no_ecc"),
    .FIFO_MEMORY_TYPE  ("auto"),
    .FIFO_READ_LATENCY (0),
    .FIFO_WRITE_DEPTH  (4096),
    .FULL_RESET_VALUE  (0),
    .READ_DATA_WIDTH   (32),
    .READ_MODE         ("fwft"),
    .RELATED_CLOCKS    (0),
    .USE_ADV_FEATURES  ("0707"),
    .WAKEUP_TIME       (0),
    .WRITE_DATA_WIDTH  (32),
    .WR_DATA_COUNT_WIDTH(13),
    .RD_DATA_COUNT_WIDTH(13),
    .PROG_EMPTY_THRESH (10),
    .PROG_FULL_THRESH  (10),
    .SIM_ASSERT_CHK    (0)
  ) rx_cdc (
    .wr_clk        (l_clk),
    .rst           (bb_rst),
    .din           ({adc_data_i0, adc_data_q0}),
    .wr_en         (fresh_echo_arriving & ~rx_cdc_full),
    .full          (rx_cdc_full),
    .rd_clk        (bb_clk),
    .rd_en         (rx_cdc_rd_en),
    .dout          (rx_cdc_dout),
    .empty         (rx_cdc_empty),
    .almost_full   (), .almost_empty(),
    .wr_data_count (), .rd_data_count(),
    .wr_rst_busy   (), .rd_rst_busy (),
    .data_valid    (), .wr_ack      (),
    .injectsbiterr (1'b0), .injectdbiterr(1'b0),
    .sbiterr       (), .dbiterr     (),
    .overflow      (), .underflow   (),
    .prog_full     (), .prog_empty  (),
    .sleep         (1'b0)
  );

  // DAC inputs: 1:2 zero-stuffed in OFDM mode. Held stable for 2 l_clks
  // per update so the chip can sample on either l_clk edge phase.
  // Updates land on (clk_div_phase=1 → 0) edges, i.e., every 2 l_clks.
  reg [15:0] dac_data_i_reg = 16'd0;
  reg [15:0] dac_data_q_reg = 16'd0;
  always @(posedge l_clk) begin
    if (!bb_rstn || tx_active_rise_l) begin
      dac_data_i_reg <= 16'd0;
      dac_data_q_reg <= 16'd0;
    end else if (clk_div_phase) begin
      // 40 MHz boundary: latch real or zero based on dac_real_slot.
      // dac_real_slot uses pre-edge dac_zs_phase XOR polarity.
      if (dac_real_slot) begin
        dac_data_i_reg <= tx_cdc_empty ? 16'd0 : tx_cdc_dout[31:16];
        dac_data_q_reg <= tx_cdc_empty ? 16'd0 : tx_cdc_dout[15:0];
      end else begin
        dac_data_i_reg <= 16'd0;
        dac_data_q_reg <= 16'd0;
      end
    end
  end
  assign dac_data_i0 = bist_pat_mode ? 16'hCAFE : dac_data_i_reg;
  assign dac_data_q0 = bist_pat_mode ? 16'hBABE : dac_data_q_reg;
  assign dac_data_i1 = bist_pat_mode ? 16'hDEAD : 16'd0;
  assign dac_data_q1 = bist_pat_mode ? 16'hBEEF : 16'd0;

  // ============================================================
  // Debug counters (bb_clk domain) -- count critical TX-side events
  // so SW can disambiguate "openofdm_tx didn't start" vs
  // "openofdm_tx ran but tx_cdc didn't accept" vs
  // "tx_cdc accepted but rx_cdc never received".
  // ============================================================
  reg [15:0] phy_tx_started_count;
  reg [15:0] phy_tx_done_count;
  reg [15:0] tx_iq_valid_count;
  reg [15:0] tx_cdc_wr_count;
  always @(posedge bb_clk) begin
    if (!bb_rstn) begin
      phy_tx_started_count <= 16'd0;
      phy_tx_done_count    <= 16'd0;
      tx_iq_valid_count    <= 16'd0;
      tx_cdc_wr_count      <= 16'd0;
    end else begin
      if (phy_tx_started)                                phy_tx_started_count <= phy_tx_started_count + 16'd1;
      if (phy_tx_done)                                   phy_tx_done_count    <= phy_tx_done_count + 16'd1;
      if (tx_result_iq_valid)                            tx_iq_valid_count    <= tx_iq_valid_count + 16'd1;
      if (tx_result_iq_valid & tx_active & ~tx_cdc_full) tx_cdc_wr_count      <= tx_cdc_wr_count + 16'd1;
    end
  end

  // l_clk-side counters for rx/tx_cdc activity.
  reg [15:0] tx_cdc_rd_count_lclk = 16'd0;
  reg [15:0] rx_cdc_wr_count_lclk = 16'd0;
  always @(posedge l_clk) begin
    if (tx_cdc_rd_pulse_l) tx_cdc_rd_count_lclk <= tx_cdc_rd_count_lclk + 16'd1;
    if (fresh_echo_arriving & ~rx_cdc_full)
      rx_cdc_wr_count_lclk <= rx_cdc_wr_count_lclk + 16'd1;
  end

  // Capture-content diagnostics.
  //
  // rx_cap_first_i/q: very first sample written to rx_cdc per burst.
  //   Latched once per packet on the first fresh_echo_arriving event.
  //   Cleared on tx_active_rise_l. If rate-adapter alignment is correct
  //   this is the first L-STF preamble sample (large signed magnitude).
  //   If we're capturing zero-stuff slots this stays small.
  //
  // rx_cap_nonzero_cnt: how many of the burst's captures had non-zero
  //   IQ. Real OFDM => approaches 1118; capturing zero-slots => stays
  //   small (a few from chip pipeline transients).
  reg [15:0] rx_cap_first_i  = 16'd0;
  reg [15:0] rx_cap_first_q  = 16'd0;
  reg        rx_cap_first_done = 1'b0;
  reg [15:0] rx_cap_nonzero_cnt = 16'd0;
  always @(posedge l_clk) begin
    if (!bb_rstn || tx_active_rise_l) begin
      rx_cap_first_done  <= 1'b0;
      rx_cap_first_i     <= 16'd0;
      rx_cap_first_q     <= 16'd0;
      rx_cap_nonzero_cnt <= 16'd0;
    end else if (fresh_echo_arriving & ~rx_cdc_full) begin
      if (!rx_cap_first_done) begin
        rx_cap_first_i    <= adc_data_i0;
        rx_cap_first_q    <= adc_data_q0;
        rx_cap_first_done <= 1'b1;
      end
      if ((adc_data_i0 != 16'd0) || (adc_data_q0 != 16'd0))
        rx_cap_nonzero_cnt <= rx_cap_nonzero_cnt + 16'd1;
    end
  end

  // bb_clk-side counter: how many samples the 10-cycle drain popped
  // out of rx_cdc. Incremented when rx_cdc_rd_en pulses.
  reg [15:0] rx_cdc_rd_count_bb = 16'd0;
  always @(posedge bb_clk) begin
    if (rx_cdc_rd_en) rx_cdc_rd_count_bb <= rx_cdc_rd_count_bb + 16'd1;
  end

  // ADC capture in l_clk domain. Latch every cycle adc_valid_i0 ticks.
  reg [15:0] last_adc_i0_lclk;
  reg [15:0] last_adc_q0_lclk;
  reg [15:0] adc_valid_count_lclk;
  reg [15:0] dac_valid_count_lclk;

  always @(posedge l_clk) begin
    if (adc_valid_i0) last_adc_i0_lclk <= adc_data_i0;
    if (adc_valid_q0) last_adc_q0_lclk <= adc_data_q0;
    // adc_valid pulses per chip sample -- count rising edges.
    // dac_valid is a level signal -- count "chip-sample slot" events
    // via the free-running clk_div_phase rising edges.
    if (adc_valid_rise) adc_valid_count_lclk <= adc_valid_count_lclk + 16'd1;
    if (clk_div_phase)  dac_valid_count_lclk <= dac_valid_count_lclk + 16'd1;
  end

  // CDC l_clk -> bb_clk via dual-flop synchronisers on the sampled
  // values. The counts and last-sample latches are slow-moving from
  // bb_clk's perspective, so the standard 2FF sync is fine for the
  // sanity check (no need for full xpm_cdc here).
  reg [15:0] last_adc_i0_s1, last_adc_i0_s2;
  reg [15:0] last_adc_q0_s1, last_adc_q0_s2;
  reg [15:0] adc_cnt_s1,     adc_cnt_s2;
  reg [15:0] dac_cnt_s1,     dac_cnt_s2;
  reg [15:0] tx_rd_cnt_s1,   tx_rd_cnt_s2;
  reg [15:0] rx_wr_cnt_s1,   rx_wr_cnt_s2;
  reg [15:0] cap_first_i_s1, cap_first_i_s2;
  reg [15:0] cap_first_q_s1, cap_first_q_s2;
  reg [15:0] cap_nz_s1,      cap_nz_s2;
  always @(posedge bb_clk) begin
    last_adc_i0_s1 <= last_adc_i0_lclk;     last_adc_i0_s2 <= last_adc_i0_s1;
    last_adc_q0_s1 <= last_adc_q0_lclk;     last_adc_q0_s2 <= last_adc_q0_s1;
    adc_cnt_s1     <= adc_valid_count_lclk; adc_cnt_s2     <= adc_cnt_s1;
    dac_cnt_s1     <= dac_valid_count_lclk; dac_cnt_s2     <= dac_cnt_s1;
    tx_rd_cnt_s1   <= tx_cdc_rd_count_lclk; tx_rd_cnt_s2   <= tx_rd_cnt_s1;
    rx_wr_cnt_s1   <= rx_cdc_wr_count_lclk; rx_wr_cnt_s2   <= rx_wr_cnt_s1;
    cap_first_i_s1 <= rx_cap_first_i;       cap_first_i_s2 <= cap_first_i_s1;
    cap_first_q_s1 <= rx_cap_first_q;       cap_first_q_s2 <= cap_first_q_s1;
    cap_nz_s1      <= rx_cap_nonzero_cnt;   cap_nz_s2      <= cap_nz_s1;
  end

  // ============================================================
  // TX packet ROMs + openofdm_tx.
  //
  // mcs_sel (gpio_o[2:0], PS pins 54-56) selects one of eight rate
  // blocks inside each ROM.  gpio_o[3] (ht_mode, PS pin 57) switches
  // between the legacy 802.11a ROM and the 802.11n HT-MF ROM.
  //
  // Legacy 802.11a (ht_mode=0):
  //   mcs_sel=0  rate=0xB  6 Mbps  BPSK  1/2
  //   mcs_sel=1  rate=0xF  9 Mbps  BPSK  3/4
  //   mcs_sel=2  rate=0xA 12 Mbps  QPSK  1/2
  //   mcs_sel=3  rate=0xE 18 Mbps  QPSK  3/4
  //   mcs_sel=4  rate=0x9 24 Mbps 16QAM  1/2
  //   mcs_sel=5  rate=0xD 36 Mbps 16QAM  3/4
  //   mcs_sel=6  rate=0x8 48 Mbps 64QAM  2/3
  //   mcs_sel=7  rate=0xC 54 Mbps 64QAM  3/4
  //
  // 802.11n HT-MF (ht_mode=1):
  //   mcs_sel=0  MCS 0  6.5 Mbps  BPSK  1/2  pkt_rate=0x80
  //   mcs_sel=1  MCS 1 13.0 Mbps  QPSK  1/2  pkt_rate=0x81
  //   mcs_sel=2  MCS 2 19.5 Mbps  QPSK  3/4  pkt_rate=0x82
  //   mcs_sel=3  MCS 3 26.0 Mbps 16QAM  1/2  pkt_rate=0x83
  //   mcs_sel=4  MCS 4 39.0 Mbps 16QAM  3/4  pkt_rate=0x84
  //   mcs_sel=5  MCS 5 52.0 Mbps 64QAM  2/3  pkt_rate=0x85
  //   mcs_sel=6  MCS 6 58.5 Mbps 64QAM  3/4  pkt_rate=0x86
  //   mcs_sel=7  MCS 7 65.0 Mbps 64QAM  5/6  pkt_rate=0x87
  // ============================================================
  wire [ 9:0] otx_bram_addr;
  wire [63:0] otx_bram_din;

  wire [2:0]  mcs_sel           = gpio_o[2:0];
  wire        ht_mode_bb        = gpio_o[3];
  wire [9:0]  mcs_base          = {1'b0, mcs_sel, 6'b0};  /* mcs_sel * 64 */
  wire [9:0]  otx_bram_addr_mcs = otx_bram_addr + mcs_base;

  // 2-FF CDC synchroniser: ht_mode_bb (PS write, ps_clk domain) -> bb_clk.
  reg ht_mode_s1 = 1'b0, ht_mode_s2 = 1'b0;
  always @(posedge bb_clk) begin
    ht_mode_s1 <= ht_mode_bb;
    ht_mode_s2 <= ht_mode_s1;
  end
  wire ht_mode_sync = ht_mode_s2;

  // 2-FF CDC: xcvr_bram_sel (gpio_o[24], PS pin 78) -> bb_clk.
  // When high, openofdm_tx reads from the AXI-writable xcvr BRAM instead
  // of the static legacy/HT ROMs.  Default = 0 (ROM path, same as Phase 2).
  wire xcvr_bram_sel_bb = gpio_o[24];
  reg  xcvr_sel_s1 = 1'b0, xcvr_sel_s2 = 1'b0;
  always @(posedge bb_clk) begin
    xcvr_sel_s1 <= xcvr_bram_sel_bb;
    xcvr_sel_s2 <= xcvr_sel_s1;
  end
  wire xcvr_bram_sel_sync = xcvr_sel_s2;

  // ============================================================
  // Phase 2: force_rx CDC.
  // gpio_o[4] lets PS assert rx_started independently of TX.
  // Two separate 2-FF synchronisers: one to bb_clk (for rx_started
  // and IQ index), one to l_clk (for capture window control).
  // ============================================================
  wire force_rx_bb = gpio_o[4];

  reg  force_rx_s1 = 1'b0, force_rx_s2 = 1'b0;
  always @(posedge bb_clk) begin
    force_rx_s1 <= force_rx_bb;
    force_rx_s2 <= force_rx_s1;
  end
  wire force_rx_sync = force_rx_s2;

  reg  force_rx_l1 = 1'b0, force_rx_l2 = 1'b0;
  always @(posedge l_clk) begin
    force_rx_l1 <= force_rx_bb;
    force_rx_l2 <= force_rx_l1;
  end
  wire force_rx_l = force_rx_l2;

  (* mark_debug = "true", keep = "true" *) wire signed [15:0] tx_result_i;
  (* mark_debug = "true", keep = "true" *) wire signed [15:0] tx_result_q;
  (* mark_debug = "true", keep = "true" *) wire        tx_result_iq_valid;
  (* mark_debug = "true", keep = "true" *) wire        phy_tx_done;
  (* mark_debug = "true", keep = "true" *) wire        phy_tx_started;

  wire [63:0] legacy_bram_din;
  wire [63:0] ht_bram_din;

  tx_packet_rom_mcs #(
    .ADDR_WIDTH(10),
    .DATA_WIDTH(64)
  ) i_rom_legacy (
    .clk      (bb_clk),
    .addr     (otx_bram_addr_mcs),
    .data_out (legacy_bram_din)
  );

  tx_packet_rom_ht_mcs #(
    .ADDR_WIDTH(10),
    .DATA_WIDTH(64)
  ) i_rom_ht (
    .clk      (bb_clk),
    .addr     (otx_bram_addr_mcs),
    .data_out (ht_bram_din)
  );

  // Phase 3: xcvr relay BRAM read data (from BD BRAM_PORTB_XCVR port).
  // Driven by system_wrapper below.
  wire [63:0] xcvr_bram_dout;

  // bram_din mux (priority: xcvr relay > HT ROM > legacy ROM).
  // xcvr_bram_sel_sync = 0 by default → ROM path preserved (Phase 2 behaviour).
  assign otx_bram_din = xcvr_bram_sel_sync ? xcvr_bram_dout  :
                        ht_mode_sync       ? ht_bram_din      :
                                             legacy_bram_din;

  openofdm_tx #(
    .C_S00_AXI_DATA_WIDTH(32),
    .C_S00_AXI_ADDR_WIDTH(7)
  ) i_openofdm_tx (
    .clk             (bb_clk),
    .phy_tx_arestn   (bb_rstn),
    .phy_tx_start    (phy_tx_start),
    .phy_tx_done     (phy_tx_done),
    .phy_tx_started  (phy_tx_started),
    .bram_din        (otx_bram_din),
    .bram_addr       (otx_bram_addr),
    // Scrambler init -- TB ties both to all-1s; unconnected = 0 = LFSR
    // locks at zero state and pilots/data become unusable.
    .init_pilot_scram_state(7'b1111111),
    .init_data_scram_state (7'b1111111),
    .result_iq_hold  (tx_cdc_full),
    .result_iq_valid (tx_result_iq_valid),
    .result_i        (tx_result_i),
    .result_q        (tx_result_q),
    .s00_axi_aclk    (bb_clk),
    .s00_axi_aresetn (bb_rstn),
    .s00_axi_awaddr  (7'd0), .s00_axi_awprot(3'd0), .s00_axi_awvalid(1'b0),
    .s00_axi_awready (),
    .s00_axi_wdata   (32'd0), .s00_axi_wstrb(4'd0), .s00_axi_wvalid(1'b0),
    .s00_axi_wready  (),
    .s00_axi_bresp   (), .s00_axi_bvalid(), .s00_axi_bready(1'b0),
    .s00_axi_araddr  (7'd0), .s00_axi_arprot(3'd0), .s00_axi_arvalid(1'b0),
    .s00_axi_arready (),
    .s00_axi_rdata   (), .s00_axi_rresp(), .s00_axi_rvalid(),
    .s00_axi_rready  (1'b0)
  );

  // ============================================================
  // Sample FIFO -- write mode while TX runs, read mode after phy_tx_done.
  //
  // phy_tx_started is a 1-cycle pulse (only high during preamble_addr==0
  // of S3_L_STF); phy_tx_done is a 1-cycle pulse at end-of-packet. Latch
  // tx_active between them so wr_valid stays asserted across the whole
  // packet -- matches the TB's STATE_TX_ACTIVE behaviour.
  // ============================================================
  reg tx_active;
  always @(posedge bb_clk) begin
    if (!bb_rstn)            tx_active <= 1'b0;
    else if (phy_tx_started) tx_active <= 1'b1;
    else if (phy_tx_done)    tx_active <= 1'b0;
  end

  // ============================================================
  // Phase 2: TX IQ capture buffer (4096 samples, bb_clk domain, block RAM).
  // Captures first 4096 IQ samples of each TX burst.
  // PS reads via gpio_i after setting 12-bit iq_idx on gpio_o[18:7].
  // ============================================================
  (* ram_style = "block" *) reg [15:0] tx_iq_cap_i [0:4095];
  (* ram_style = "block" *) reg [15:0] tx_iq_cap_q [0:4095];
  reg [11:0] tx_cap_idx    = 12'd0;
  reg        tx_cap_active = 1'b0;

  always @(posedge bb_clk) begin
    if (!bb_rstn) begin
      tx_cap_idx    <= 12'd0;
      tx_cap_active <= 1'b0;
    end else begin
      if (phy_tx_started) begin
        tx_cap_active <= 1'b1;
        tx_cap_idx    <= 12'd0;
      end else if (tx_cap_active && tx_result_iq_valid) begin
        tx_iq_cap_i[tx_cap_idx] <= tx_result_i[15:0];
        tx_iq_cap_q[tx_cap_idx] <= tx_result_q[15:0];
        if (tx_cap_idx == 12'd4095) tx_cap_active <= 1'b0;
        else                        tx_cap_idx    <= tx_cap_idx + 12'd1;
      end
    end
  end

  // ============================================================
  // RX feed: 10-cycle drain (mirrors testbench clk_count gating).
  // After phy_tx_done latches, rx_started stays high. Each 10-cycle
  // window: pop a sample from rx_cdc_fifo, latch into sample_in,
  // pulse sample_in_strobe at clk_count==4.
  //
  // 2B-4 vs 1C: source is the rx_cdc async FIFO (chip echoes) instead
  // of iq_sample_fifo (TX-direct). The 10-cycle pacing is preserved
  // because dot11's symbol timing was tuned around it in 1C.
  // ============================================================
  // rx_started_latch: set by phy_tx_done, stays high for the rest of the
  // session (existing loopback sweep behaviour unchanged).
  // Phase 2: OR with force_rx_sync so PS can assert RX independently.
  reg  rx_started_latch = 1'b0;
  always @(posedge bb_clk) begin
    if (!bb_rstn)         rx_started_latch <= 1'b0;
    else if (phy_tx_done) rx_started_latch <= 1'b1;
  end
  wire rx_started = rx_started_latch | force_rx_sync;

  reg        rx_started_d;
  reg [3:0]  clk_count;
  reg        sample_valid;
  reg [31:0] staged_sample;
  reg        need_new_sample;
  reg [31:0] sample_in;
  reg        sample_in_strobe;

  always @(posedge bb_clk) begin
    if (!bb_rstn) begin
      rx_started_d      <= 1'b0;
      clk_count         <= 4'd0;
      sample_valid      <= 1'b0;
      staged_sample     <= 32'd0;
      need_new_sample   <= 1'b0;
      sample_in         <= 32'd0;
      sample_in_strobe  <= 1'b0;
      rx_cdc_rd_en      <= 1'b0;
    end else begin
      rx_started_d <= rx_started;

      // Default: clear single-cycle pulses.
      rx_cdc_rd_en     <= 1'b0;
      sample_in_strobe <= 1'b0;

      if (rx_started) begin
        // Cycle counter (10 bb_clk's per dot11 sample, matching 1C).
        clk_count <= (clk_count == 4'd9) ? 4'd0 : clk_count + 4'd1;
        sample_in_strobe <= (clk_count == 4'd4);

        // Prime first capture on rx_started rising edge.
        if (!rx_started_d) begin
          need_new_sample <= 1'b1;
        end

        // Pop one sample from rx_cdc when we want one and it's available.
        if (need_new_sample && !rx_cdc_empty && !sample_valid) begin
          rx_cdc_rd_en    <= 1'b1;        // 1-cycle advance pulse
          staged_sample   <= rx_cdc_dout; // FWFT: dout is current head
          sample_valid    <= 1'b1;
          need_new_sample <= 1'b0;
        end

        // Latch the staged sample at end of the 10-cycle window.
        // If no sample is staged (rx_cdc starved), hold previous
        // sample_in -- dot11 keeps consuming whatever it has, and
        // we'll catch up when fresh samples arrive.
        // AWGN injection: noise is sampled here from the combinatorial
        // LFSR outputs, giving one independent noise draw per dot11 sample.
        if (clk_count == 4'd9) begin
          if (sample_valid) begin
            sample_in       <= staged_sample_noisy;  // noise added here
            sample_valid    <= 1'b0;
          end
          need_new_sample <= 1'b1;
        end
      end
    end
  end

  // ============================================================
  // AWGN channel: inject Gaussian noise into sample_in before dot11.
  //
  // The noise generator (awgn_noise_gen) runs 8 LFSRs continuously on
  // bb_clk. Its outputs are combinatorial from the current LFSR state.
  // Noise is sampled and added to staged_sample at the exact cycle
  // sample_in is latched (clk_count == 4'd9), giving one independent
  // noise realisation per dot11 input sample (one every 10 bb_clks).
  //
  // gpio_o[59]    = awgn_enable  (0 = bypass, no bitstream rebuild needed)
  // gpio_o[63:60] = noise_shift  (0 = max noise, 15 = effectively zero)
  // ============================================================
  wire        awgn_enable    = gpio_o[59];
  wire [3:0]  noise_shift    = gpio_o[63:60];

  wire signed [16:0] awgn_raw_i;
  wire signed [16:0] awgn_raw_q;

  awgn_noise_gen i_awgn_gen (
    .clk    (bb_clk),
    .rst    (bb_rst),
    .noise_i(awgn_raw_i),
    .noise_q(awgn_raw_q)
  );

  // Scale: arithmetic right-shift by noise_shift (barrel shifter).
  // Vivado infers a 4-bit variable shift on a 17-bit signed value = 4 LUTs.
  wire signed [16:0] awgn_scaled_i = awgn_raw_i >>> noise_shift;
  wire signed [16:0] awgn_scaled_q = awgn_raw_q >>> noise_shift;

  // Sign-extend 16-bit IQ sample to 17 bits, add scaled noise, get 18-bit.
  // Both inputs are ≤ 17-bit signed so the 18-bit sum cannot overflow.
  wire signed [16:0] staged_i_ext = {staged_sample[31], staged_sample[31:16]};
  wire signed [16:0] staged_q_ext = {staged_sample[15], staged_sample[15:0]};
  wire signed [17:0] noisy_sum_i  = {staged_i_ext[16], staged_i_ext} +
                                     {awgn_scaled_i[16], awgn_scaled_i};
  wire signed [17:0] noisy_sum_q  = {staged_q_ext[16], staged_q_ext} +
                                     {awgn_scaled_q[16], awgn_scaled_q};

  // Saturate 18-bit signed → 16-bit signed.
  // Overflow condition: top 3 bits are not all equal (not 000 or 111).
  wire [2:0] top3_i = noisy_sum_i[17:15];
  wire [2:0] top3_q = noisy_sum_q[17:15];
  wire sat_pos_i = (top3_i != 3'b000) && !noisy_sum_i[17];
  wire sat_neg_i = (top3_i != 3'b111) &&  noisy_sum_i[17];
  wire sat_pos_q = (top3_q != 3'b000) && !noisy_sum_q[17];
  wire sat_neg_q = (top3_q != 3'b111) &&  noisy_sum_q[17];

  wire [15:0] noisy_i_sat = sat_pos_i ? 16'h7FFF :
                            sat_neg_i ? 16'h8000 : noisy_sum_i[15:0];
  wire [15:0] noisy_q_sat = sat_pos_q ? 16'h7FFF :
                            sat_neg_q ? 16'h8000 : noisy_sum_q[15:0];

  // Mux: bypass when awgn_enable=0 (exact pass-through, no noise path).
  wire [31:0] staged_sample_noisy = awgn_enable
                                  ? {noisy_i_sat, noisy_q_sat}
                                  : staged_sample;

  // ============================================================
  // dot11 + signal_watchdog (TB-style direct instantiation).
  // ============================================================
  (* mark_debug = "true", keep = "true" *) wire        rx_pkt_header_valid;
  (* mark_debug = "true", keep = "true" *) wire        rx_pkt_header_valid_strobe;
  (* mark_debug = "true", keep = "true" *) wire [ 7:0] rx_pkt_rate_w;
  (* mark_debug = "true", keep = "true" *) wire [15:0] rx_pkt_len_w;
  (* mark_debug = "true", keep = "true" *) wire        rx_byte_out_strobe;
  (* mark_debug = "true", keep = "true" *) wire [ 7:0] rx_byte_out;
  (* mark_debug = "true", keep = "true" *) wire [15:0] rx_byte_count_w;
  (* mark_debug = "true", keep = "true" *) wire        rx_fcs_out_strobe;
  (* mark_debug = "true", keep = "true" *) wire        rx_fcs_ok;

  wire demod_is_ongoing;
  wire receiver_rst;
  wire sig_valid = rx_pkt_header_valid_strobe & rx_pkt_header_valid;

  signal_watchdog signal_watchdog_inst (
    .clk             (bb_clk),
    .rstn            (bb_rstn),
    .enable          (~demod_is_ongoing & rx_started),
    .i_data          (sample_in[31:16]),
    .q_data          (sample_in[15:0]),
    .iq_valid        (sample_in_strobe),
    .power_trigger   (1'b1),
    .signal_len      (rx_pkt_len_w),
    .sig_valid       (sig_valid),
    .min_signal_len_th(16'd0),
    .max_signal_len_th(16'hFFFF),
    .dc_running_sum_th(8'd65),
    .receiver_rst    (receiver_rst)
  );

  // ----- Runtime-tunable dot11 parameters via gpio_o -----
  // (defaults match the previously-hardcoded values when SW writes the
  // recommended init pattern -- see ps_gpio_init in main.c).
  //
  // Note: gpio_o[54:51] is already used by byte_bank (4-bit), so
  // dot11 param bits start above that.
  //
  //   gpio_o[36]    = soft_decoding          (default 1)
  //   gpio_o[37]    = force_ht_smoothing     (default 0)
  //   gpio_o[38]    = disable_all_smoothing  (default 1)
  //   gpio_o[39]    = threshold_scale        (default 0)
  //   gpio_o[47:44] = fft_win_shift          (default 0x1)
  //   gpio_o[56:55] = min_plateau_sel        (default 0x1 -> 100)
  //   gpio_o[58:57] = power_thres_sel        (default 0x0 -> 0)
  wire        dot11_soft_decoding         = gpio_o[36];
  wire        dot11_force_ht_smoothing    = gpio_o[37];
  wire        dot11_disable_all_smoothing = gpio_o[38];
  wire        dot11_threshold_scale       = gpio_o[39];
  wire [3:0]  dot11_fft_win_shift         = gpio_o[47:44];

  wire [1:0]  min_plateau_sel = gpio_o[56:55];
  wire [31:0] dot11_min_plateau =
      (min_plateau_sel == 2'b00) ? 32'd50 :
      (min_plateau_sel == 2'b01) ? 32'd100 :
      (min_plateau_sel == 2'b10) ? 32'd200 : 32'd400;

  wire [1:0]  power_thres_sel = gpio_o[58:57];
  wire [10:0] dot11_power_thres =
      (power_thres_sel == 2'b00) ? 11'd0 :
      (power_thres_sel == 2'b01) ? 11'd100 :
      (power_thres_sel == 2'b10) ? 11'd500 : 11'd1000;

  dot11 dot11_inst (
    .clock           (bb_clk),
    .enable          (rx_started),
    .reset           (bb_rst | receiver_rst | ~rx_started),
    .reset_without_watchdog(bb_rst | ~rx_started),
    .power_thres     (dot11_power_thres),
    .min_plateau     (dot11_min_plateau),
    .threshold_scale (dot11_threshold_scale),
    .rssi_half_db    (11'sd200),
    .sample_in       (sample_in),
    .sample_in_strobe(sample_in_strobe),
    .soft_decoding   (dot11_soft_decoding),
    .force_ht_smoothing(dot11_force_ht_smoothing),
    .disable_all_smoothing(dot11_disable_all_smoothing),
    .fft_win_shift   (dot11_fft_win_shift),
    .demod_is_ongoing(demod_is_ongoing),
    .pkt_begin       (),
    .pkt_ht          (),
    .pkt_header_valid(rx_pkt_header_valid),
    .pkt_header_valid_strobe(rx_pkt_header_valid_strobe),
    .ht_unsupport    (),
    .pkt_rate        (rx_pkt_rate_w),
    .pkt_len         (rx_pkt_len_w),
    .pkt_len_total   (),
    .byte_out_strobe (rx_byte_out_strobe),
    .byte_out        (rx_byte_out),
    .byte_count_total(),
    .byte_count      (rx_byte_count_w),
    .fcs_out_strobe  (rx_fcs_out_strobe),
    .fcs_ok          (rx_fcs_ok),
    .state           (),
    .status_code     (),
    .state_changed   (),
    .state_history   (),
    .power_trigger   (),
    .short_preamble_detected(),
    .phase_offset    (),
    .sync_long_metric(),
    .sync_long_metric_stb(),
    .long_preamble_detected(),
    .sync_long_out   (),
    .sync_long_out_strobe(),
    .phase_offset_taken(),
    .sync_long_state (),
    .equalizer_out   (),
    .equalizer_out_strobe(),
    .equalizer_state (),
    .ofdm_symbol_eq_out_pulse(),
    .legacy_sig_stb  (),
    .legacy_rate     (),
    .legacy_sig_rsvd (),
    .legacy_len      (),
    .legacy_sig_parity(),
    .legacy_sig_parity_ok(),
    .legacy_sig_tail (),
    .ht_sig_stb      (),
    .ht_mcs          (),
    .ht_cbw          (),
    .ht_len          (),
    .ht_smoothing    (),
    .ht_not_sounding (),
    .ht_aggr         (),
    .ht_aggr_last    (),
    .ht_stbc         (),
    .ht_fec_coding   (),
    .ht_sgi          (),
    .ht_num_ext      (),
    .ht_sig_crc_ok   (),
    .demod_out       (),
    .demod_soft_bits (),
    .demod_soft_bits_pos(),
    .demod_out_strobe(),
    .deinterleave_erase_out(),
    .deinterleave_erase_out_strobe(),
    .conv_decoder_out(),
    .conv_decoder_out_stb(),
    .descramble_out  (),
    .descramble_out_strobe(),
    .n_ofdm_sym      (),
    .n_bit_in_last_sym(),
    .phy_len_valid   (),
    .csi             (),
    .csi_valid       ()
  );

  // ============================================================
  // Decode-status accumulator -> gpio_i.
  // ============================================================
  reg [ 7:0] fcs_ok_count;
  reg [ 7:0] bad_pkt_count;
  reg [ 7:0] hdr_valid_count;
  reg [ 7:0] last_pkt_rate;
  reg [15:0] last_pkt_len;
  reg [15:0] last_byte_count;

  always @(posedge bb_clk) begin
    if (!bb_rstn) begin
      fcs_ok_count    <= 8'd0;
      bad_pkt_count   <= 8'd0;
      hdr_valid_count <= 8'd0;
      last_pkt_rate   <= 8'd0;
      last_pkt_len    <= 16'd0;
      last_byte_count <= 16'd0;
    end else begin
      if (rx_fcs_out_strobe) begin
        if (rx_fcs_ok) fcs_ok_count  <= fcs_ok_count  + 8'd1;
        else           bad_pkt_count <= bad_pkt_count + 8'd1;
        last_byte_count <= rx_byte_count_w;
      end
      if (rx_pkt_header_valid_strobe & rx_pkt_header_valid) begin
        hdr_valid_count <= hdr_valid_count + 8'd1;
        last_pkt_rate   <= rx_pkt_rate_w;
        last_pkt_len    <= rx_pkt_len_w;
      end
    end
  end

  // ============================================================
  // RX byte capture buffer for BER measurement.
  //
  // dot11 outputs each PSDU byte via rx_byte_out_strobe + rx_byte_out.
  // Capture into a 32-byte buffer. TB-style gating (matches
  // openofdm_transceiver_tb.v): a packet_being_received flag is set
  // by rx_pkt_header_valid_strobe (= L-SIG decoded successfully) and
  // cleared by rx_fcs_out_strobe (= packet end). rx_byte_idx resets
  // on the rising edge of packet_being_received. This excludes any
  // L-SIG bytes that dot11 emits via byte_out before pkt_header_valid
  // and skips post-FCS dribble.
  //
  // Buffer is also pre-cleared to 0 on each new packet so stale
  // contents from a prior burst don't leak through if the new packet
  // is shorter.
  // ============================================================
  reg [7:0] rx_byte_buf [0:127];     // up to 128-byte PSDU
  reg [7:0] rx_byte_idx = 8'd0;
  reg       packet_being_received = 1'b0;
  reg       packet_being_received_d = 1'b0;
  wire      packet_rx_start = packet_being_received & ~packet_being_received_d;

  integer bbi;
  initial begin
    for (bbi = 0; bbi < 128; bbi = bbi + 1) rx_byte_buf[bbi] = 8'd0;
  end

  always @(posedge bb_clk) begin
    if (!bb_rstn) begin
      packet_being_received   <= 1'b0;
      packet_being_received_d <= 1'b0;
      rx_byte_idx             <= 8'd0;
    end else begin
      packet_being_received_d <= packet_being_received;

      if (rx_pkt_header_valid_strobe & rx_pkt_header_valid)
        packet_being_received <= 1'b1;
      else if (rx_fcs_out_strobe)
        packet_being_received <= 1'b0;

      if (packet_rx_start) begin
        rx_byte_idx <= 8'd0;
        for (bbi = 0; bbi < 128; bbi = bbi + 1) rx_byte_buf[bbi] <= 8'd0;
      end else if (packet_being_received && rx_byte_out_strobe && rx_byte_idx < 8'd128) begin
        rx_byte_buf[rx_byte_idx] <= rx_byte_out;
        rx_byte_idx              <= rx_byte_idx + 8'd1;
      end
    end
  end

  // 4-bit bank select gives 16 banks * 8 bytes = 128 bytes addressable.
  wire [3:0] byte_bank   = gpio_o[54:51];
  wire [6:0] byte_base   = {byte_bank, 3'b000};
  wire [63:0] gpio_i_bytes = {
    rx_byte_buf[byte_base + 7'd7],
    rx_byte_buf[byte_base + 7'd6],
    rx_byte_buf[byte_base + 7'd5],
    rx_byte_buf[byte_base + 7'd4],
    rx_byte_buf[byte_base + 7'd3],
    rx_byte_buf[byte_base + 7'd2],
    rx_byte_buf[byte_base + 7'd1],
    rx_byte_buf[byte_base + 7'd0]
  };

  // gpio_o[43] = byte_view_mode (overrides bist_select/bist_pat_mode).
  // gpio_o[40], gpio_o[41] = 2-bit mode select for gpio_i:
  //   00  -> Stage 1C decode counters (default, OFDM-through-chip)
  //   01  -> debug TX-pipeline counters (only in OFDM mode)
  //   10  -> Stage 2B-3 BIST capture (last_adc_i0/q0 + dac/adc valid#)
  //   11  -> reserved (same as 10)
  // When gpio_o[43]=1: gpio_i exposes rx_byte_buf[bank*8 ..bank*8+7].
  wire        bist_select     = gpio_o[40];
  wire        byte_view_mode  = gpio_o[43];
  // bist_pat_mode declared earlier

  wire [63:0] gpio_i_1c    = {last_byte_count, last_pkt_len, last_pkt_rate,
                              hdr_valid_count, bad_pkt_count, fcs_ok_count};
  wire [63:0] gpio_i_cap   = {dac_cnt_s2, adc_cnt_s2, last_adc_q0_s2, last_adc_i0_s2};
  // Debug surfaces what's actually being captured into rx_cdc:
  //   [15: 0] tx_cdc_wr_count   -- sanity that openofdm_tx ran
  //   [31:16] rx_cap_nonzero_cnt -- # of captures with non-zero IQ
  //                                  (~1118 if real OFDM, ~0 if zeros)
  //   [47:32] rx_cap_first_i    -- I value of FIRST capture per burst
  //                                  (large signed if aligned to L-STF;
  //                                   tiny if aligned to zero-stuff slot)
  //   [63:48] rx_cap_first_q    -- Q value of FIRST capture per burst
  wire [63:0] gpio_i_debug = {cap_first_q_s2, cap_first_i_s2,
                              cap_nz_s2,      tx_cdc_wr_count};
  wire [63:0] gpio_i_status = bist_pat_mode ? gpio_i_cap : gpio_i_debug;
  wire [63:0] gpio_i_normal = bist_select ? gpio_i_status : gpio_i_1c;

  // ============================================================
  // Phase 2: IQ sample readback.
  // gpio_o[5]    = iq_view_en : redirect gpio_i to IQ sample data
  // gpio_o[6]    = iq_sel_tx  : 0 = RX sample, 1 = TX sample
  // gpio_o[18:7] = iq_idx     : 12-bit index into 4096-deep capture buffer
  //
  // gpio_i[31:16] = I value (signed 16-bit, 2's complement)
  // gpio_i[15:0]  = Q value (signed 16-bit, 2's complement)
  // gpio_i[63:32] = 0
  //
  // Note: RX buffer valid for indices 0..~3499 (CAPTURE_LIMIT samples).
  //       Indices 3500..4095 hold stale data from the prior burst.
  // ============================================================
  wire       iq_view_en = gpio_o[5];
  wire       iq_sel_tx  = gpio_o[6];

  // TX IQ: 2-FF sync iq_idx_bb to bb_clk, then block-RAM registered read.
  reg [11:0] iq_idx_tx_s1 = 12'd0, iq_idx_tx_s2 = 12'd0;
  always @(posedge bb_clk) begin
    iq_idx_tx_s1 <= iq_idx_bb;
    iq_idx_tx_s2 <= iq_idx_tx_s1;
  end
  reg [15:0] tx_iq_out_i = 16'd0;
  reg [15:0] tx_iq_out_q = 16'd0;
  always @(posedge bb_clk) begin
    tx_iq_out_i <= tx_iq_cap_i[iq_idx_tx_s2];
    tx_iq_out_q <= tx_iq_cap_q[iq_idx_tx_s2];
  end

  // Mux TX or RX sample.
  wire [15:0] iq_out_i = iq_sel_tx ? tx_iq_out_i : rx_iq_bb_i_s2;
  wire [15:0] iq_out_q = iq_sel_tx ? tx_iq_out_q : rx_iq_bb_q_s2;

  wire [63:0] gpio_i_iq = {32'h0, iq_out_i, iq_out_q};

  assign gpio_i = byte_view_mode ? gpio_i_bytes  :
                  iq_view_en     ? gpio_i_iq     :
                                   gpio_i_normal;

  // ============================================================
  // PL heartbeat.
  // ============================================================
  reg [25:0] heartbeat = 26'd0;
  always @(posedge bb_clk) heartbeat <= heartbeat + 26'd1;
  assign led = heartbeat[25];

endmodule
