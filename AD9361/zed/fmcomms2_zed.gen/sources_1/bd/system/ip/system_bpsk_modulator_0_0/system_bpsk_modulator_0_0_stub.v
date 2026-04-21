// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Tue Apr 21 15:50:01 2026
// Host        : kemal-EXCALIBUR-G770 running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/kemal/Desktop/FMCOMM2andos/zed/fmcomms2_zed.gen/sources_1/bd/system/ip/system_bpsk_modulator_0_0/system_bpsk_modulator_0_0_stub.v
// Design      : system_bpsk_modulator_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "bpsk_modulator_v1_0,Vivado 2022.2" *)
module system_bpsk_modulator_0_0(aclk, aresetn, S_AXI_ACLK, S_AXI_ARESETN, 
  S_AXI_AWADDR, S_AXI_AWPROT, S_AXI_AWVALID, S_AXI_AWREADY, S_AXI_WDATA, S_AXI_WSTRB, 
  S_AXI_WVALID, S_AXI_WREADY, S_AXI_BRESP, S_AXI_BVALID, S_AXI_BREADY, S_AXI_ARADDR, 
  S_AXI_ARPROT, S_AXI_ARVALID, S_AXI_ARREADY, S_AXI_RDATA, S_AXI_RRESP, S_AXI_RVALID, 
  S_AXI_RREADY, S_AXIS_BITS_TDATA, S_AXIS_BITS_TVALID, S_AXIS_BITS_TREADY, 
  S_AXIS_DMA_TDATA, S_AXIS_DMA_TVALID, S_AXIS_DMA_TREADY, S_AXIS_DMA_TLAST, 
  S_AXIS_DMA_TKEEP, M_AXIS_DAC_TDATA, M_AXIS_DAC_TVALID, M_AXIS_DAC_TREADY, 
  M_AXIS_DAC_TLAST, M_AXIS_DAC_TKEEP)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,S_AXI_ACLK,S_AXI_ARESETN,S_AXI_AWADDR[7:0],S_AXI_AWPROT[2:0],S_AXI_AWVALID,S_AXI_AWREADY,S_AXI_WDATA[31:0],S_AXI_WSTRB[3:0],S_AXI_WVALID,S_AXI_WREADY,S_AXI_BRESP[1:0],S_AXI_BVALID,S_AXI_BREADY,S_AXI_ARADDR[7:0],S_AXI_ARPROT[2:0],S_AXI_ARVALID,S_AXI_ARREADY,S_AXI_RDATA[31:0],S_AXI_RRESP[1:0],S_AXI_RVALID,S_AXI_RREADY,S_AXIS_BITS_TDATA[7:0],S_AXIS_BITS_TVALID,S_AXIS_BITS_TREADY,S_AXIS_DMA_TDATA[63:0],S_AXIS_DMA_TVALID,S_AXIS_DMA_TREADY,S_AXIS_DMA_TLAST,S_AXIS_DMA_TKEEP[7:0],M_AXIS_DAC_TDATA[63:0],M_AXIS_DAC_TVALID,M_AXIS_DAC_TREADY,M_AXIS_DAC_TLAST,M_AXIS_DAC_TKEEP[7:0]" */;
  input aclk;
  input aresetn;
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input [7:0]S_AXI_AWADDR;
  input [2:0]S_AXI_AWPROT;
  input S_AXI_AWVALID;
  output S_AXI_AWREADY;
  input [31:0]S_AXI_WDATA;
  input [3:0]S_AXI_WSTRB;
  input S_AXI_WVALID;
  output S_AXI_WREADY;
  output [1:0]S_AXI_BRESP;
  output S_AXI_BVALID;
  input S_AXI_BREADY;
  input [7:0]S_AXI_ARADDR;
  input [2:0]S_AXI_ARPROT;
  input S_AXI_ARVALID;
  output S_AXI_ARREADY;
  output [31:0]S_AXI_RDATA;
  output [1:0]S_AXI_RRESP;
  output S_AXI_RVALID;
  input S_AXI_RREADY;
  input [7:0]S_AXIS_BITS_TDATA;
  input S_AXIS_BITS_TVALID;
  output S_AXIS_BITS_TREADY;
  input [63:0]S_AXIS_DMA_TDATA;
  input S_AXIS_DMA_TVALID;
  output S_AXIS_DMA_TREADY;
  input S_AXIS_DMA_TLAST;
  input [7:0]S_AXIS_DMA_TKEEP;
  output [63:0]M_AXIS_DAC_TDATA;
  output M_AXIS_DAC_TVALID;
  input M_AXIS_DAC_TREADY;
  output M_AXIS_DAC_TLAST;
  output [7:0]M_AXIS_DAC_TKEEP;
endmodule
