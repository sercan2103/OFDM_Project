// dec_viterbi.v -- thin port-rename wrapper around viterbi_v7_0.
//
// ofdm_decoder.v (line 124) instantiates `dec_viterbi` with port names
// s_axis_input_t* / m_axis_output_t* but the underlying Xilinx Viterbi
// IP (viterbi_v7_0.xci) uses s_axis_data_t* / m_axis_data_t*. The
// prior project worked around this with an uncommitted BD wrapper; we
// just write the wrapper as plain Verilog here so the vendored
// openofdm_rx RTL stays untouched and the rebuild stays self-contained.

`timescale 1ns / 1ps

module dec_viterbi (
  input  wire        aclk,
  input  wire        aresetn,
  input  wire        s_axis_input_tvalid,
  input  wire [15:0] s_axis_input_tdata,
  input  wire [ 7:0] s_axis_input_tuser,
  output wire        s_axis_input_tready,
  output wire        m_axis_output_tvalid,
  output wire [ 7:0] m_axis_output_tdata
);

  viterbi_v7_0 viterbi_inst (
    .aclk               (aclk),
    .aresetn            (aresetn),
    .aclken             (1'b1),                    // tied: caller has no clock-enable
    .s_axis_data_tvalid (s_axis_input_tvalid),
    .s_axis_data_tdata  (s_axis_input_tdata),
    .s_axis_data_tuser  (s_axis_input_tuser),
    .s_axis_data_tready (s_axis_input_tready),
    .m_axis_data_tvalid (m_axis_output_tvalid),
    .m_axis_data_tdata  (m_axis_output_tdata)
  );

endmodule
