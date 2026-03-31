// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Mar 25 18:28:03 2026
// Host        : kemal-EXCALIBUR-G770 running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/kemal/Desktop/FMCOMM2andos/hdl/projects/fmcomms2/zed/fmcomms2_zed.gen/sources_1/bd/system/ip/system_util_ad9361_divclk_0/system_util_ad9361_divclk_0_stub.v
// Design      : system_util_ad9361_divclk_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "util_clkdiv,Vivado 2022.2" *)
module system_util_ad9361_divclk_0(clk, clk_sel, clk_out)
/* synthesis syn_black_box black_box_pad_pin="clk,clk_sel,clk_out" */;
  input clk;
  input clk_sel;
  output clk_out;
endmodule
