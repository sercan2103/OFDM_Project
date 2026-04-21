// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Tue Apr 21 15:50:01 2026
// Host        : kemal-EXCALIBUR-G770 running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/kemal/Desktop/FMCOMM2andos/zed/fmcomms2_zed.gen/sources_1/bd/system/ip/system_bpsk_modulator_0_0/system_bpsk_modulator_0_0_sim_netlist.v
// Design      : system_bpsk_modulator_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_bpsk_modulator_0_0,bpsk_modulator_v1_0,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "bpsk_modulator_v1_0,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module system_bpsk_modulator_0_0
   (aclk,
    aresetn,
    S_AXI_ACLK,
    S_AXI_ARESETN,
    S_AXI_AWADDR,
    S_AXI_AWPROT,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARPROT,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    S_AXIS_BITS_TDATA,
    S_AXIS_BITS_TVALID,
    S_AXIS_BITS_TREADY,
    S_AXIS_DMA_TDATA,
    S_AXIS_DMA_TVALID,
    S_AXIS_DMA_TREADY,
    S_AXIS_DMA_TLAST,
    S_AXIS_DMA_TKEEP,
    M_AXIS_DAC_TDATA,
    M_AXIS_DAC_TVALID,
    M_AXIS_DAC_TREADY,
    M_AXIS_DAC_TLAST,
    M_AXIS_DAC_TKEEP);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF S_AXIS_BITS:S_AXIS_DMA:M_AXIS_DAC, ASSOCIATED_RESET aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, INSERT_VIP 0" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S_AXI_ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI_ACLK, ASSOCIATED_BUSIF S_AXI, ASSOCIATED_RESET S_AXI_ARESETN, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_sys_ps7_0_FCLK_CLK0, INSERT_VIP 0" *) input S_AXI_ACLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S_AXI_ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI_ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input S_AXI_ARESETN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *) input [7:0]S_AXI_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWPROT" *) input [2:0]S_AXI_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *) input S_AXI_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *) output S_AXI_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WDATA" *) input [31:0]S_AXI_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *) input [3:0]S_AXI_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *) input S_AXI_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *) output S_AXI_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *) output [1:0]S_AXI_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *) output S_AXI_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *) input S_AXI_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *) input [7:0]S_AXI_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARPROT" *) input [2:0]S_AXI_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *) input S_AXI_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *) output S_AXI_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *) output [31:0]S_AXI_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *) output [1:0]S_AXI_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *) output S_AXI_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 8, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN system_sys_ps7_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input S_AXI_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_BITS TDATA" *) input [7:0]S_AXIS_BITS_TDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_BITS TVALID" *) input S_AXIS_BITS_TVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_BITS TREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_BITS, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, LAYERED_METADATA undef, INSERT_VIP 0" *) output S_AXIS_BITS_TREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_DMA TDATA" *) input [63:0]S_AXIS_DMA_TDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_DMA TVALID" *) input S_AXIS_DMA_TVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_DMA TREADY" *) output S_AXIS_DMA_TREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_DMA TLAST" *) input S_AXIS_DMA_TLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_DMA TKEEP" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_DMA, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, LAYERED_METADATA undef, INSERT_VIP 0" *) input [7:0]S_AXIS_DMA_TKEEP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_DAC TDATA" *) output [63:0]M_AXIS_DAC_TDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_DAC TVALID" *) output M_AXIS_DAC_TVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_DAC TREADY" *) input M_AXIS_DAC_TREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_DAC TLAST" *) output M_AXIS_DAC_TLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_DAC TKEEP" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_DAC, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, LAYERED_METADATA undef, INSERT_VIP 0" *) output [7:0]M_AXIS_DAC_TKEEP;

  wire \<const0> ;
  wire [63:0]M_AXIS_DAC_TDATA;
  wire [7:0]M_AXIS_DAC_TKEEP;
  wire M_AXIS_DAC_TLAST;
  wire M_AXIS_DAC_TREADY;
  wire M_AXIS_DAC_TVALID;
  wire [7:0]S_AXIS_BITS_TDATA;
  wire S_AXIS_BITS_TREADY;
  wire S_AXIS_BITS_TVALID;
  wire [63:0]S_AXIS_DMA_TDATA;
  wire [7:0]S_AXIS_DMA_TKEEP;
  wire S_AXIS_DMA_TLAST;
  wire S_AXIS_DMA_TREADY;
  wire S_AXIS_DMA_TVALID;
  wire S_AXI_ACLK;
  wire [7:0]S_AXI_ARADDR;
  wire S_AXI_ARESETN;
  wire S_AXI_ARREADY;
  wire S_AXI_ARVALID;
  wire [7:0]S_AXI_AWADDR;
  wire S_AXI_AWREADY;
  wire S_AXI_AWVALID;
  wire S_AXI_BREADY;
  wire S_AXI_BVALID;
  wire [31:0]S_AXI_RDATA;
  wire S_AXI_RREADY;
  wire S_AXI_RVALID;
  wire [31:0]S_AXI_WDATA;
  wire S_AXI_WREADY;
  wire [3:0]S_AXI_WSTRB;
  wire S_AXI_WVALID;
  wire aclk;
  wire aresetn;

  assign S_AXI_BRESP[1] = \<const0> ;
  assign S_AXI_BRESP[0] = \<const0> ;
  assign S_AXI_RRESP[1] = \<const0> ;
  assign S_AXI_RRESP[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  system_bpsk_modulator_0_0_bpsk_modulator_v1_0 inst
       (.M_AXIS_DAC_TDATA(M_AXIS_DAC_TDATA),
        .M_AXIS_DAC_TKEEP(M_AXIS_DAC_TKEEP),
        .M_AXIS_DAC_TLAST(M_AXIS_DAC_TLAST),
        .M_AXIS_DAC_TREADY(M_AXIS_DAC_TREADY),
        .M_AXIS_DAC_TVALID(M_AXIS_DAC_TVALID),
        .S_AXIS_BITS_TDATA(S_AXIS_BITS_TDATA[0]),
        .S_AXIS_BITS_TREADY(S_AXIS_BITS_TREADY),
        .S_AXIS_BITS_TVALID(S_AXIS_BITS_TVALID),
        .S_AXIS_DMA_TDATA(S_AXIS_DMA_TDATA),
        .S_AXIS_DMA_TKEEP(S_AXIS_DMA_TKEEP),
        .S_AXIS_DMA_TLAST(S_AXIS_DMA_TLAST),
        .S_AXIS_DMA_TREADY(S_AXIS_DMA_TREADY),
        .S_AXIS_DMA_TVALID(S_AXIS_DMA_TVALID),
        .S_AXI_ACLK(S_AXI_ACLK),
        .S_AXI_ARADDR(S_AXI_ARADDR[7:2]),
        .S_AXI_ARESETN(S_AXI_ARESETN),
        .S_AXI_ARREADY(S_AXI_ARREADY),
        .S_AXI_ARVALID(S_AXI_ARVALID),
        .S_AXI_AWADDR(S_AXI_AWADDR[7:2]),
        .S_AXI_AWREADY(S_AXI_AWREADY),
        .S_AXI_AWVALID(S_AXI_AWVALID),
        .S_AXI_BREADY(S_AXI_BREADY),
        .S_AXI_RDATA(S_AXI_RDATA),
        .S_AXI_RREADY(S_AXI_RREADY),
        .S_AXI_RVALID(S_AXI_RVALID),
        .S_AXI_WDATA(S_AXI_WDATA),
        .S_AXI_WREADY(S_AXI_WREADY),
        .S_AXI_WSTRB(S_AXI_WSTRB),
        .S_AXI_WVALID(S_AXI_WVALID),
        .aclk(aclk),
        .aresetn(aresetn),
        .axi_bvalid_reg_0(S_AXI_BVALID));
endmodule

(* ORIG_REF_NAME = "bpsk_core" *) 
module system_bpsk_modulator_0_0_bpsk_core
   (SS,
    D,
    S_AXIS_BITS_TREADY,
    M_AXIS_DAC_TDATA,
    M_AXIS_DAC_TVALID,
    aclk,
    Q,
    core_enable,
    aresetn,
    axis_bit_reg_0,
    M_AXIS_DAC_TREADY,
    \i_hold_reg[15]_0 ,
    \i_hold_reg[15]_1 ,
    core_ch_sel,
    \i_hold_reg[15]_i_4_0 ,
    S_AXIS_DMA_TDATA,
    S_AXIS_BITS_TDATA,
    S_AXIS_BITS_TVALID,
    S_AXIS_DMA_TVALID);
  output [0:0]SS;
  output [39:0]D;
  output S_AXIS_BITS_TREADY;
  output [63:0]M_AXIS_DAC_TDATA;
  output M_AXIS_DAC_TVALID;
  input aclk;
  input [15:0]Q;
  input core_enable;
  input aresetn;
  input [1:0]axis_bit_reg_0;
  input M_AXIS_DAC_TREADY;
  input [15:0]\i_hold_reg[15]_0 ;
  input [15:0]\i_hold_reg[15]_1 ;
  input core_ch_sel;
  input [31:0]\i_hold_reg[15]_i_4_0 ;
  input [63:0]S_AXIS_DMA_TDATA;
  input [0:0]S_AXIS_BITS_TDATA;
  input S_AXIS_BITS_TVALID;
  input S_AXIS_DMA_TVALID;

  wire [39:0]D;
  wire [63:0]M_AXIS_DAC_TDATA;
  wire M_AXIS_DAC_TREADY;
  wire M_AXIS_DAC_TVALID;
  wire [15:0]Q;
  wire [0:0]SS;
  wire [0:0]S_AXIS_BITS_TDATA;
  wire S_AXIS_BITS_TREADY;
  wire S_AXIS_BITS_TREADY_INST_0_i_2_n_0;
  wire S_AXIS_BITS_TREADY_INST_0_i_3_n_0;
  wire S_AXIS_BITS_TREADY_INST_0_i_4_n_0;
  wire S_AXIS_BITS_TREADY_INST_0_i_5_n_0;
  wire S_AXIS_BITS_TVALID;
  wire [63:0]S_AXIS_DMA_TDATA;
  wire S_AXIS_DMA_TVALID;
  wire aclk;
  wire alt_bit;
  wire alt_bit_i_1_n_0;
  wire aresetn;
  wire axis_bit;
  wire axis_bit_i_1_n_0;
  wire [1:0]axis_bit_reg_0;
  wire core_ch_sel;
  wire core_enable;
  wire [15:1]data1;
  wire [15:0]div_cnt;
  wire div_cnt0_carry__0_i_1_n_0;
  wire div_cnt0_carry__0_i_2_n_0;
  wire div_cnt0_carry__0_i_3_n_0;
  wire div_cnt0_carry__0_i_4_n_0;
  wire div_cnt0_carry__0_n_0;
  wire div_cnt0_carry__0_n_1;
  wire div_cnt0_carry__0_n_2;
  wire div_cnt0_carry__0_n_3;
  wire div_cnt0_carry__1_i_1_n_0;
  wire div_cnt0_carry__1_i_2_n_0;
  wire div_cnt0_carry__1_i_3_n_0;
  wire div_cnt0_carry__1_i_4_n_0;
  wire div_cnt0_carry__1_n_0;
  wire div_cnt0_carry__1_n_1;
  wire div_cnt0_carry__1_n_2;
  wire div_cnt0_carry__1_n_3;
  wire div_cnt0_carry__2_i_1_n_0;
  wire div_cnt0_carry__2_i_2_n_0;
  wire div_cnt0_carry__2_i_3_n_0;
  wire div_cnt0_carry__2_n_2;
  wire div_cnt0_carry__2_n_3;
  wire div_cnt0_carry_i_1_n_0;
  wire div_cnt0_carry_i_2_n_0;
  wire div_cnt0_carry_i_3_n_0;
  wire div_cnt0_carry_i_4_n_0;
  wire div_cnt0_carry_n_0;
  wire div_cnt0_carry_n_1;
  wire div_cnt0_carry_n_2;
  wire div_cnt0_carry_n_3;
  wire [15:1]div_cnt1;
  wire div_cnt1_carry__0_i_1_n_0;
  wire div_cnt1_carry__0_i_2_n_0;
  wire div_cnt1_carry__0_i_3_n_0;
  wire div_cnt1_carry__0_i_4_n_0;
  wire div_cnt1_carry__0_n_0;
  wire div_cnt1_carry__0_n_1;
  wire div_cnt1_carry__0_n_2;
  wire div_cnt1_carry__0_n_3;
  wire div_cnt1_carry__1_i_1_n_0;
  wire div_cnt1_carry__1_i_2_n_0;
  wire div_cnt1_carry__1_i_3_n_0;
  wire div_cnt1_carry__1_i_4_n_0;
  wire div_cnt1_carry__1_n_0;
  wire div_cnt1_carry__1_n_1;
  wire div_cnt1_carry__1_n_2;
  wire div_cnt1_carry__1_n_3;
  wire div_cnt1_carry__2_i_1_n_0;
  wire div_cnt1_carry__2_i_2_n_0;
  wire div_cnt1_carry__2_i_3_n_0;
  wire div_cnt1_carry__2_n_2;
  wire div_cnt1_carry__2_n_3;
  wire div_cnt1_carry_i_1_n_0;
  wire div_cnt1_carry_i_2_n_0;
  wire div_cnt1_carry_i_3_n_0;
  wire div_cnt1_carry_i_4_n_0;
  wire div_cnt1_carry_n_0;
  wire div_cnt1_carry_n_1;
  wire div_cnt1_carry_n_2;
  wire div_cnt1_carry_n_3;
  wire \div_cnt[15]_i_1_n_0 ;
  wire \div_cnt[15]_i_3_n_0 ;
  wire \div_cnt[15]_i_4_n_0 ;
  wire \div_cnt[15]_i_5_n_0 ;
  wire \div_cnt[15]_i_6_n_0 ;
  wire \div_cnt[15]_i_7_n_0 ;
  wire \div_cnt_reg_n_0_[0] ;
  wire \div_cnt_reg_n_0_[10] ;
  wire \div_cnt_reg_n_0_[11] ;
  wire \div_cnt_reg_n_0_[12] ;
  wire \div_cnt_reg_n_0_[13] ;
  wire \div_cnt_reg_n_0_[14] ;
  wire \div_cnt_reg_n_0_[15] ;
  wire \div_cnt_reg_n_0_[1] ;
  wire \div_cnt_reg_n_0_[2] ;
  wire \div_cnt_reg_n_0_[3] ;
  wire \div_cnt_reg_n_0_[4] ;
  wire \div_cnt_reg_n_0_[5] ;
  wire \div_cnt_reg_n_0_[6] ;
  wire \div_cnt_reg_n_0_[7] ;
  wire \div_cnt_reg_n_0_[8] ;
  wire \div_cnt_reg_n_0_[9] ;
  wire [15:0]i_hold;
  wire \i_hold[0]_i_1_n_0 ;
  wire \i_hold[10]_i_1_n_0 ;
  wire \i_hold[11]_i_1_n_0 ;
  wire \i_hold[12]_i_1_n_0 ;
  wire \i_hold[13]_i_1_n_0 ;
  wire \i_hold[14]_i_1_n_0 ;
  wire \i_hold[15]_i_10_n_0 ;
  wire \i_hold[15]_i_11_n_0 ;
  wire \i_hold[15]_i_12_n_0 ;
  wire \i_hold[15]_i_13_n_0 ;
  wire \i_hold[15]_i_14_n_0 ;
  wire \i_hold[15]_i_15_n_0 ;
  wire \i_hold[15]_i_1_n_0 ;
  wire \i_hold[15]_i_2_n_0 ;
  wire \i_hold[15]_i_3_n_0 ;
  wire \i_hold[15]_i_8_n_0 ;
  wire \i_hold[15]_i_9_n_0 ;
  wire \i_hold[1]_i_1_n_0 ;
  wire \i_hold[2]_i_1_n_0 ;
  wire \i_hold[3]_i_1_n_0 ;
  wire \i_hold[4]_i_1_n_0 ;
  wire \i_hold[5]_i_1_n_0 ;
  wire \i_hold[6]_i_1_n_0 ;
  wire \i_hold[7]_i_1_n_0 ;
  wire \i_hold[8]_i_1_n_0 ;
  wire \i_hold[9]_i_1_n_0 ;
  wire [15:0]\i_hold_reg[15]_0 ;
  wire [15:0]\i_hold_reg[15]_1 ;
  wire [31:0]\i_hold_reg[15]_i_4_0 ;
  wire \i_hold_reg[15]_i_4_n_0 ;
  wire \i_hold_reg[15]_i_5_n_0 ;
  wire \i_hold_reg[15]_i_6_n_0 ;
  wire \i_hold_reg[15]_i_7_n_0 ;
  wire \m_axis_dac_tdata[0]_i_1_n_0 ;
  wire \m_axis_dac_tdata[10]_i_1_n_0 ;
  wire \m_axis_dac_tdata[11]_i_1_n_0 ;
  wire \m_axis_dac_tdata[12]_i_1_n_0 ;
  wire \m_axis_dac_tdata[13]_i_1_n_0 ;
  wire \m_axis_dac_tdata[14]_i_1_n_0 ;
  wire \m_axis_dac_tdata[15]_i_2_n_0 ;
  wire \m_axis_dac_tdata[1]_i_1_n_0 ;
  wire \m_axis_dac_tdata[2]_i_1_n_0 ;
  wire \m_axis_dac_tdata[32]_i_1_n_0 ;
  wire \m_axis_dac_tdata[33]_i_1_n_0 ;
  wire \m_axis_dac_tdata[34]_i_1_n_0 ;
  wire \m_axis_dac_tdata[35]_i_1_n_0 ;
  wire \m_axis_dac_tdata[36]_i_1_n_0 ;
  wire \m_axis_dac_tdata[37]_i_1_n_0 ;
  wire \m_axis_dac_tdata[38]_i_1_n_0 ;
  wire \m_axis_dac_tdata[39]_i_1_n_0 ;
  wire \m_axis_dac_tdata[3]_i_1_n_0 ;
  wire \m_axis_dac_tdata[40]_i_1_n_0 ;
  wire \m_axis_dac_tdata[41]_i_1_n_0 ;
  wire \m_axis_dac_tdata[42]_i_1_n_0 ;
  wire \m_axis_dac_tdata[43]_i_1_n_0 ;
  wire \m_axis_dac_tdata[44]_i_1_n_0 ;
  wire \m_axis_dac_tdata[45]_i_1_n_0 ;
  wire \m_axis_dac_tdata[46]_i_1_n_0 ;
  wire \m_axis_dac_tdata[47]_i_1_n_0 ;
  wire \m_axis_dac_tdata[47]_i_2_n_0 ;
  wire \m_axis_dac_tdata[4]_i_1_n_0 ;
  wire \m_axis_dac_tdata[5]_i_1_n_0 ;
  wire \m_axis_dac_tdata[63]_i_1_n_0 ;
  wire \m_axis_dac_tdata[6]_i_1_n_0 ;
  wire \m_axis_dac_tdata[7]_i_1_n_0 ;
  wire \m_axis_dac_tdata[8]_i_1_n_0 ;
  wire \m_axis_dac_tdata[9]_i_1_n_0 ;
  wire m_axis_dac_tvalid_i_1_n_0;
  wire p_3_in;
  wire [4:0]pat_idx;
  wire pat_idx0;
  wire \pat_idx[0]_i_1_n_0 ;
  wire \pat_idx[1]_i_1_n_0 ;
  wire \pat_idx[2]_i_1_n_0 ;
  wire \pat_idx[3]_i_1_n_0 ;
  wire \pat_idx[4]_i_2_n_0 ;
  wire \sym_count[0]_i_2_n_0 ;
  wire \sym_count_reg[0]_i_1_n_0 ;
  wire \sym_count_reg[0]_i_1_n_1 ;
  wire \sym_count_reg[0]_i_1_n_2 ;
  wire \sym_count_reg[0]_i_1_n_3 ;
  wire \sym_count_reg[0]_i_1_n_4 ;
  wire \sym_count_reg[0]_i_1_n_5 ;
  wire \sym_count_reg[0]_i_1_n_6 ;
  wire \sym_count_reg[0]_i_1_n_7 ;
  wire \sym_count_reg[12]_i_1_n_0 ;
  wire \sym_count_reg[12]_i_1_n_1 ;
  wire \sym_count_reg[12]_i_1_n_2 ;
  wire \sym_count_reg[12]_i_1_n_3 ;
  wire \sym_count_reg[12]_i_1_n_4 ;
  wire \sym_count_reg[12]_i_1_n_5 ;
  wire \sym_count_reg[12]_i_1_n_6 ;
  wire \sym_count_reg[12]_i_1_n_7 ;
  wire \sym_count_reg[16]_i_1_n_0 ;
  wire \sym_count_reg[16]_i_1_n_1 ;
  wire \sym_count_reg[16]_i_1_n_2 ;
  wire \sym_count_reg[16]_i_1_n_3 ;
  wire \sym_count_reg[16]_i_1_n_4 ;
  wire \sym_count_reg[16]_i_1_n_5 ;
  wire \sym_count_reg[16]_i_1_n_6 ;
  wire \sym_count_reg[16]_i_1_n_7 ;
  wire \sym_count_reg[20]_i_1_n_0 ;
  wire \sym_count_reg[20]_i_1_n_1 ;
  wire \sym_count_reg[20]_i_1_n_2 ;
  wire \sym_count_reg[20]_i_1_n_3 ;
  wire \sym_count_reg[20]_i_1_n_4 ;
  wire \sym_count_reg[20]_i_1_n_5 ;
  wire \sym_count_reg[20]_i_1_n_6 ;
  wire \sym_count_reg[20]_i_1_n_7 ;
  wire \sym_count_reg[24]_i_1_n_0 ;
  wire \sym_count_reg[24]_i_1_n_1 ;
  wire \sym_count_reg[24]_i_1_n_2 ;
  wire \sym_count_reg[24]_i_1_n_3 ;
  wire \sym_count_reg[24]_i_1_n_4 ;
  wire \sym_count_reg[24]_i_1_n_5 ;
  wire \sym_count_reg[24]_i_1_n_6 ;
  wire \sym_count_reg[24]_i_1_n_7 ;
  wire \sym_count_reg[28]_i_1_n_0 ;
  wire \sym_count_reg[28]_i_1_n_1 ;
  wire \sym_count_reg[28]_i_1_n_2 ;
  wire \sym_count_reg[28]_i_1_n_3 ;
  wire \sym_count_reg[28]_i_1_n_4 ;
  wire \sym_count_reg[28]_i_1_n_5 ;
  wire \sym_count_reg[28]_i_1_n_6 ;
  wire \sym_count_reg[28]_i_1_n_7 ;
  wire \sym_count_reg[32]_i_1_n_0 ;
  wire \sym_count_reg[32]_i_1_n_1 ;
  wire \sym_count_reg[32]_i_1_n_2 ;
  wire \sym_count_reg[32]_i_1_n_3 ;
  wire \sym_count_reg[32]_i_1_n_4 ;
  wire \sym_count_reg[32]_i_1_n_5 ;
  wire \sym_count_reg[32]_i_1_n_6 ;
  wire \sym_count_reg[32]_i_1_n_7 ;
  wire \sym_count_reg[36]_i_1_n_1 ;
  wire \sym_count_reg[36]_i_1_n_2 ;
  wire \sym_count_reg[36]_i_1_n_3 ;
  wire \sym_count_reg[36]_i_1_n_4 ;
  wire \sym_count_reg[36]_i_1_n_5 ;
  wire \sym_count_reg[36]_i_1_n_6 ;
  wire \sym_count_reg[36]_i_1_n_7 ;
  wire \sym_count_reg[4]_i_1_n_0 ;
  wire \sym_count_reg[4]_i_1_n_1 ;
  wire \sym_count_reg[4]_i_1_n_2 ;
  wire \sym_count_reg[4]_i_1_n_3 ;
  wire \sym_count_reg[4]_i_1_n_4 ;
  wire \sym_count_reg[4]_i_1_n_5 ;
  wire \sym_count_reg[4]_i_1_n_6 ;
  wire \sym_count_reg[4]_i_1_n_7 ;
  wire \sym_count_reg[8]_i_1_n_0 ;
  wire \sym_count_reg[8]_i_1_n_1 ;
  wire \sym_count_reg[8]_i_1_n_2 ;
  wire \sym_count_reg[8]_i_1_n_3 ;
  wire \sym_count_reg[8]_i_1_n_4 ;
  wire \sym_count_reg[8]_i_1_n_5 ;
  wire \sym_count_reg[8]_i_1_n_6 ;
  wire \sym_count_reg[8]_i_1_n_7 ;
  wire [3:2]NLW_div_cnt0_carry__2_CO_UNCONNECTED;
  wire [3:3]NLW_div_cnt0_carry__2_O_UNCONNECTED;
  wire [3:2]NLW_div_cnt1_carry__2_CO_UNCONNECTED;
  wire [3:3]NLW_div_cnt1_carry__2_O_UNCONNECTED;
  wire [3:3]\NLW_sym_count_reg[36]_i_1_CO_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h20)) 
    S_AXIS_BITS_TREADY_INST_0
       (.I0(p_3_in),
        .I1(axis_bit_reg_0[0]),
        .I2(axis_bit_reg_0[1]),
        .O(S_AXIS_BITS_TREADY));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    S_AXIS_BITS_TREADY_INST_0_i_1
       (.I0(S_AXIS_BITS_TREADY_INST_0_i_2_n_0),
        .I1(S_AXIS_BITS_TREADY_INST_0_i_3_n_0),
        .I2(S_AXIS_BITS_TREADY_INST_0_i_4_n_0),
        .I3(S_AXIS_BITS_TREADY_INST_0_i_5_n_0),
        .I4(M_AXIS_DAC_TREADY),
        .I5(core_enable),
        .O(p_3_in));
  LUT4 #(
    .INIT(16'hFFFE)) 
    S_AXIS_BITS_TREADY_INST_0_i_2
       (.I0(\div_cnt_reg_n_0_[1] ),
        .I1(\div_cnt_reg_n_0_[0] ),
        .I2(\div_cnt_reg_n_0_[3] ),
        .I3(\div_cnt_reg_n_0_[2] ),
        .O(S_AXIS_BITS_TREADY_INST_0_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    S_AXIS_BITS_TREADY_INST_0_i_3
       (.I0(\div_cnt_reg_n_0_[5] ),
        .I1(\div_cnt_reg_n_0_[4] ),
        .I2(\div_cnt_reg_n_0_[7] ),
        .I3(\div_cnt_reg_n_0_[6] ),
        .O(S_AXIS_BITS_TREADY_INST_0_i_3_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    S_AXIS_BITS_TREADY_INST_0_i_4
       (.I0(\div_cnt_reg_n_0_[10] ),
        .I1(\div_cnt_reg_n_0_[9] ),
        .I2(\div_cnt_reg_n_0_[11] ),
        .I3(\div_cnt_reg_n_0_[8] ),
        .O(S_AXIS_BITS_TREADY_INST_0_i_4_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    S_AXIS_BITS_TREADY_INST_0_i_5
       (.I0(\div_cnt_reg_n_0_[15] ),
        .I1(\div_cnt_reg_n_0_[14] ),
        .I2(\div_cnt_reg_n_0_[13] ),
        .I3(\div_cnt_reg_n_0_[12] ),
        .O(S_AXIS_BITS_TREADY_INST_0_i_5_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    alt_bit_i_1
       (.I0(alt_bit),
        .O(alt_bit_i_1_n_0));
  FDRE alt_bit_reg
       (.C(aclk),
        .CE(p_3_in),
        .D(alt_bit_i_1_n_0),
        .Q(alt_bit),
        .R(SS));
  LUT6 #(
    .INIT(64'hFFBFFFFF00800000)) 
    axis_bit_i_1
       (.I0(S_AXIS_BITS_TDATA),
        .I1(S_AXIS_BITS_TVALID),
        .I2(p_3_in),
        .I3(axis_bit_reg_0[0]),
        .I4(axis_bit_reg_0[1]),
        .I5(axis_bit),
        .O(axis_bit_i_1_n_0));
  FDRE axis_bit_reg
       (.C(aclk),
        .CE(1'b1),
        .D(axis_bit_i_1_n_0),
        .Q(axis_bit),
        .R(SS));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 div_cnt0_carry
       (.CI(1'b0),
        .CO({div_cnt0_carry_n_0,div_cnt0_carry_n_1,div_cnt0_carry_n_2,div_cnt0_carry_n_3}),
        .CYINIT(\div_cnt_reg_n_0_[0] ),
        .DI({\div_cnt_reg_n_0_[4] ,\div_cnt_reg_n_0_[3] ,\div_cnt_reg_n_0_[2] ,\div_cnt_reg_n_0_[1] }),
        .O(data1[4:1]),
        .S({div_cnt0_carry_i_1_n_0,div_cnt0_carry_i_2_n_0,div_cnt0_carry_i_3_n_0,div_cnt0_carry_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 div_cnt0_carry__0
       (.CI(div_cnt0_carry_n_0),
        .CO({div_cnt0_carry__0_n_0,div_cnt0_carry__0_n_1,div_cnt0_carry__0_n_2,div_cnt0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({\div_cnt_reg_n_0_[8] ,\div_cnt_reg_n_0_[7] ,\div_cnt_reg_n_0_[6] ,\div_cnt_reg_n_0_[5] }),
        .O(data1[8:5]),
        .S({div_cnt0_carry__0_i_1_n_0,div_cnt0_carry__0_i_2_n_0,div_cnt0_carry__0_i_3_n_0,div_cnt0_carry__0_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry__0_i_1
       (.I0(\div_cnt_reg_n_0_[8] ),
        .O(div_cnt0_carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry__0_i_2
       (.I0(\div_cnt_reg_n_0_[7] ),
        .O(div_cnt0_carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry__0_i_3
       (.I0(\div_cnt_reg_n_0_[6] ),
        .O(div_cnt0_carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry__0_i_4
       (.I0(\div_cnt_reg_n_0_[5] ),
        .O(div_cnt0_carry__0_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 div_cnt0_carry__1
       (.CI(div_cnt0_carry__0_n_0),
        .CO({div_cnt0_carry__1_n_0,div_cnt0_carry__1_n_1,div_cnt0_carry__1_n_2,div_cnt0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({\div_cnt_reg_n_0_[12] ,\div_cnt_reg_n_0_[11] ,\div_cnt_reg_n_0_[10] ,\div_cnt_reg_n_0_[9] }),
        .O(data1[12:9]),
        .S({div_cnt0_carry__1_i_1_n_0,div_cnt0_carry__1_i_2_n_0,div_cnt0_carry__1_i_3_n_0,div_cnt0_carry__1_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry__1_i_1
       (.I0(\div_cnt_reg_n_0_[12] ),
        .O(div_cnt0_carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry__1_i_2
       (.I0(\div_cnt_reg_n_0_[11] ),
        .O(div_cnt0_carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry__1_i_3
       (.I0(\div_cnt_reg_n_0_[10] ),
        .O(div_cnt0_carry__1_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry__1_i_4
       (.I0(\div_cnt_reg_n_0_[9] ),
        .O(div_cnt0_carry__1_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 div_cnt0_carry__2
       (.CI(div_cnt0_carry__1_n_0),
        .CO({NLW_div_cnt0_carry__2_CO_UNCONNECTED[3:2],div_cnt0_carry__2_n_2,div_cnt0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\div_cnt_reg_n_0_[14] ,\div_cnt_reg_n_0_[13] }),
        .O({NLW_div_cnt0_carry__2_O_UNCONNECTED[3],data1[15:13]}),
        .S({1'b0,div_cnt0_carry__2_i_1_n_0,div_cnt0_carry__2_i_2_n_0,div_cnt0_carry__2_i_3_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry__2_i_1
       (.I0(\div_cnt_reg_n_0_[15] ),
        .O(div_cnt0_carry__2_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry__2_i_2
       (.I0(\div_cnt_reg_n_0_[14] ),
        .O(div_cnt0_carry__2_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry__2_i_3
       (.I0(\div_cnt_reg_n_0_[13] ),
        .O(div_cnt0_carry__2_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry_i_1
       (.I0(\div_cnt_reg_n_0_[4] ),
        .O(div_cnt0_carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry_i_2
       (.I0(\div_cnt_reg_n_0_[3] ),
        .O(div_cnt0_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry_i_3
       (.I0(\div_cnt_reg_n_0_[2] ),
        .O(div_cnt0_carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt0_carry_i_4
       (.I0(\div_cnt_reg_n_0_[1] ),
        .O(div_cnt0_carry_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 div_cnt1_carry
       (.CI(1'b0),
        .CO({div_cnt1_carry_n_0,div_cnt1_carry_n_1,div_cnt1_carry_n_2,div_cnt1_carry_n_3}),
        .CYINIT(Q[0]),
        .DI(Q[4:1]),
        .O(div_cnt1[4:1]),
        .S({div_cnt1_carry_i_1_n_0,div_cnt1_carry_i_2_n_0,div_cnt1_carry_i_3_n_0,div_cnt1_carry_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 div_cnt1_carry__0
       (.CI(div_cnt1_carry_n_0),
        .CO({div_cnt1_carry__0_n_0,div_cnt1_carry__0_n_1,div_cnt1_carry__0_n_2,div_cnt1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(Q[8:5]),
        .O(div_cnt1[8:5]),
        .S({div_cnt1_carry__0_i_1_n_0,div_cnt1_carry__0_i_2_n_0,div_cnt1_carry__0_i_3_n_0,div_cnt1_carry__0_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry__0_i_1
       (.I0(Q[8]),
        .O(div_cnt1_carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry__0_i_2
       (.I0(Q[7]),
        .O(div_cnt1_carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry__0_i_3
       (.I0(Q[6]),
        .O(div_cnt1_carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry__0_i_4
       (.I0(Q[5]),
        .O(div_cnt1_carry__0_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 div_cnt1_carry__1
       (.CI(div_cnt1_carry__0_n_0),
        .CO({div_cnt1_carry__1_n_0,div_cnt1_carry__1_n_1,div_cnt1_carry__1_n_2,div_cnt1_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI(Q[12:9]),
        .O(div_cnt1[12:9]),
        .S({div_cnt1_carry__1_i_1_n_0,div_cnt1_carry__1_i_2_n_0,div_cnt1_carry__1_i_3_n_0,div_cnt1_carry__1_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry__1_i_1
       (.I0(Q[12]),
        .O(div_cnt1_carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry__1_i_2
       (.I0(Q[11]),
        .O(div_cnt1_carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry__1_i_3
       (.I0(Q[10]),
        .O(div_cnt1_carry__1_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry__1_i_4
       (.I0(Q[9]),
        .O(div_cnt1_carry__1_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 div_cnt1_carry__2
       (.CI(div_cnt1_carry__1_n_0),
        .CO({NLW_div_cnt1_carry__2_CO_UNCONNECTED[3:2],div_cnt1_carry__2_n_2,div_cnt1_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,Q[14:13]}),
        .O({NLW_div_cnt1_carry__2_O_UNCONNECTED[3],div_cnt1[15:13]}),
        .S({1'b0,div_cnt1_carry__2_i_1_n_0,div_cnt1_carry__2_i_2_n_0,div_cnt1_carry__2_i_3_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry__2_i_1
       (.I0(Q[15]),
        .O(div_cnt1_carry__2_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry__2_i_2
       (.I0(Q[14]),
        .O(div_cnt1_carry__2_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry__2_i_3
       (.I0(Q[13]),
        .O(div_cnt1_carry__2_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry_i_1
       (.I0(Q[4]),
        .O(div_cnt1_carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry_i_2
       (.I0(Q[3]),
        .O(div_cnt1_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry_i_3
       (.I0(Q[2]),
        .O(div_cnt1_carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    div_cnt1_carry_i_4
       (.I0(Q[1]),
        .O(div_cnt1_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h0F11)) 
    \div_cnt[0]_i_1 
       (.I0(Q[0]),
        .I1(\div_cnt[15]_i_4_n_0 ),
        .I2(\div_cnt_reg_n_0_[0] ),
        .I3(\div_cnt[15]_i_3_n_0 ),
        .O(div_cnt[0]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[10]_i_1 
       (.I0(data1[10]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[10]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[10]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[11]_i_1 
       (.I0(data1[11]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[11]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[11]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[12]_i_1 
       (.I0(data1[12]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[12]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[12]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[13]_i_1 
       (.I0(data1[13]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[13]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[13]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[14]_i_1 
       (.I0(data1[14]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[14]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[14]));
  LUT2 #(
    .INIT(4'h7)) 
    \div_cnt[15]_i_1 
       (.I0(core_enable),
        .I1(aresetn),
        .O(\div_cnt[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[15]_i_2 
       (.I0(data1[15]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[15]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[15]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \div_cnt[15]_i_3 
       (.I0(S_AXIS_BITS_TREADY_INST_0_i_5_n_0),
        .I1(S_AXIS_BITS_TREADY_INST_0_i_4_n_0),
        .I2(S_AXIS_BITS_TREADY_INST_0_i_3_n_0),
        .I3(S_AXIS_BITS_TREADY_INST_0_i_2_n_0),
        .O(\div_cnt[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \div_cnt[15]_i_4 
       (.I0(\div_cnt[15]_i_5_n_0 ),
        .I1(\div_cnt[15]_i_6_n_0 ),
        .I2(\div_cnt[15]_i_7_n_0 ),
        .I3(Q[8]),
        .I4(Q[15]),
        .I5(Q[11]),
        .O(\div_cnt[15]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \div_cnt[15]_i_5 
       (.I0(Q[6]),
        .I1(Q[1]),
        .I2(Q[7]),
        .I3(Q[2]),
        .O(\div_cnt[15]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \div_cnt[15]_i_6 
       (.I0(Q[5]),
        .I1(Q[3]),
        .I2(Q[10]),
        .I3(Q[9]),
        .O(\div_cnt[15]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \div_cnt[15]_i_7 
       (.I0(Q[12]),
        .I1(Q[4]),
        .I2(Q[14]),
        .I3(Q[13]),
        .O(\div_cnt[15]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[1]_i_1 
       (.I0(data1[1]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[1]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[1]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[2]_i_1 
       (.I0(data1[2]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[2]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[2]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[3]_i_1 
       (.I0(data1[3]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[3]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[3]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[4]_i_1 
       (.I0(data1[4]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[4]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[4]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[5]_i_1 
       (.I0(data1[5]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[5]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[5]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[6]_i_1 
       (.I0(data1[6]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[6]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[6]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[7]_i_1 
       (.I0(data1[7]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[7]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[7]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[8]_i_1 
       (.I0(data1[8]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[8]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[8]));
  LUT4 #(
    .INIT(16'h88B8)) 
    \div_cnt[9]_i_1 
       (.I0(data1[9]),
        .I1(\div_cnt[15]_i_3_n_0 ),
        .I2(div_cnt1[9]),
        .I3(\div_cnt[15]_i_4_n_0 ),
        .O(div_cnt[9]));
  FDRE \div_cnt_reg[0] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[0]),
        .Q(\div_cnt_reg_n_0_[0] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[10] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[10]),
        .Q(\div_cnt_reg_n_0_[10] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[11] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[11]),
        .Q(\div_cnt_reg_n_0_[11] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[12] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[12]),
        .Q(\div_cnt_reg_n_0_[12] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[13] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[13]),
        .Q(\div_cnt_reg_n_0_[13] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[14] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[14]),
        .Q(\div_cnt_reg_n_0_[14] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[15] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[15]),
        .Q(\div_cnt_reg_n_0_[15] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[1] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[1]),
        .Q(\div_cnt_reg_n_0_[1] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[2] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[2]),
        .Q(\div_cnt_reg_n_0_[2] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[3] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[3]),
        .Q(\div_cnt_reg_n_0_[3] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[4] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[4]),
        .Q(\div_cnt_reg_n_0_[4] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[5] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[5]),
        .Q(\div_cnt_reg_n_0_[5] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[6] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[6]),
        .Q(\div_cnt_reg_n_0_[6] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[7] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[7]),
        .Q(\div_cnt_reg_n_0_[7] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[8] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[8]),
        .Q(\div_cnt_reg_n_0_[8] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \div_cnt_reg[9] 
       (.C(aclk),
        .CE(M_AXIS_DAC_TREADY),
        .D(div_cnt[9]),
        .Q(\div_cnt_reg_n_0_[9] ),
        .R(\div_cnt[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[0]_i_1 
       (.I0(\i_hold_reg[15]_0 [0]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [0]),
        .O(\i_hold[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[10]_i_1 
       (.I0(\i_hold_reg[15]_0 [10]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [10]),
        .O(\i_hold[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[11]_i_1 
       (.I0(\i_hold_reg[15]_0 [11]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [11]),
        .O(\i_hold[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[12]_i_1 
       (.I0(\i_hold_reg[15]_0 [12]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [12]),
        .O(\i_hold[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[13]_i_1 
       (.I0(\i_hold_reg[15]_0 [13]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [13]),
        .O(\i_hold[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[14]_i_1 
       (.I0(\i_hold_reg[15]_0 [14]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [14]),
        .O(\i_hold[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[15]_i_1 
       (.I0(\i_hold_reg[15]_0 [15]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [15]),
        .O(\i_hold[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \i_hold[15]_i_10 
       (.I0(\i_hold_reg[15]_i_4_0 [19]),
        .I1(\i_hold_reg[15]_i_4_0 [18]),
        .I2(pat_idx[1]),
        .I3(\i_hold_reg[15]_i_4_0 [17]),
        .I4(pat_idx[0]),
        .I5(\i_hold_reg[15]_i_4_0 [16]),
        .O(\i_hold[15]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \i_hold[15]_i_11 
       (.I0(\i_hold_reg[15]_i_4_0 [23]),
        .I1(\i_hold_reg[15]_i_4_0 [22]),
        .I2(pat_idx[1]),
        .I3(\i_hold_reg[15]_i_4_0 [21]),
        .I4(pat_idx[0]),
        .I5(\i_hold_reg[15]_i_4_0 [20]),
        .O(\i_hold[15]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \i_hold[15]_i_12 
       (.I0(\i_hold_reg[15]_i_4_0 [11]),
        .I1(\i_hold_reg[15]_i_4_0 [10]),
        .I2(pat_idx[1]),
        .I3(\i_hold_reg[15]_i_4_0 [9]),
        .I4(pat_idx[0]),
        .I5(\i_hold_reg[15]_i_4_0 [8]),
        .O(\i_hold[15]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \i_hold[15]_i_13 
       (.I0(\i_hold_reg[15]_i_4_0 [15]),
        .I1(\i_hold_reg[15]_i_4_0 [14]),
        .I2(pat_idx[1]),
        .I3(\i_hold_reg[15]_i_4_0 [13]),
        .I4(pat_idx[0]),
        .I5(\i_hold_reg[15]_i_4_0 [12]),
        .O(\i_hold[15]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \i_hold[15]_i_14 
       (.I0(\i_hold_reg[15]_i_4_0 [3]),
        .I1(\i_hold_reg[15]_i_4_0 [2]),
        .I2(pat_idx[1]),
        .I3(\i_hold_reg[15]_i_4_0 [1]),
        .I4(pat_idx[0]),
        .I5(\i_hold_reg[15]_i_4_0 [0]),
        .O(\i_hold[15]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \i_hold[15]_i_15 
       (.I0(\i_hold_reg[15]_i_4_0 [7]),
        .I1(\i_hold_reg[15]_i_4_0 [6]),
        .I2(pat_idx[1]),
        .I3(\i_hold_reg[15]_i_4_0 [5]),
        .I4(pat_idx[0]),
        .I5(\i_hold_reg[15]_i_4_0 [4]),
        .O(\i_hold[15]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \i_hold[15]_i_2 
       (.I0(\i_hold_reg[15]_i_4_n_0 ),
        .I1(\i_hold_reg[15]_i_5_n_0 ),
        .I2(pat_idx[4]),
        .I3(\i_hold_reg[15]_i_6_n_0 ),
        .I4(pat_idx[3]),
        .I5(\i_hold_reg[15]_i_7_n_0 ),
        .O(\i_hold[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hB282)) 
    \i_hold[15]_i_3 
       (.I0(alt_bit),
        .I1(axis_bit_reg_0[0]),
        .I2(axis_bit_reg_0[1]),
        .I3(axis_bit),
        .O(\i_hold[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \i_hold[15]_i_8 
       (.I0(\i_hold_reg[15]_i_4_0 [27]),
        .I1(\i_hold_reg[15]_i_4_0 [26]),
        .I2(pat_idx[1]),
        .I3(\i_hold_reg[15]_i_4_0 [25]),
        .I4(pat_idx[0]),
        .I5(\i_hold_reg[15]_i_4_0 [24]),
        .O(\i_hold[15]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \i_hold[15]_i_9 
       (.I0(\i_hold_reg[15]_i_4_0 [31]),
        .I1(\i_hold_reg[15]_i_4_0 [30]),
        .I2(pat_idx[1]),
        .I3(\i_hold_reg[15]_i_4_0 [29]),
        .I4(pat_idx[0]),
        .I5(\i_hold_reg[15]_i_4_0 [28]),
        .O(\i_hold[15]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[1]_i_1 
       (.I0(\i_hold_reg[15]_0 [1]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [1]),
        .O(\i_hold[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[2]_i_1 
       (.I0(\i_hold_reg[15]_0 [2]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [2]),
        .O(\i_hold[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[3]_i_1 
       (.I0(\i_hold_reg[15]_0 [3]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [3]),
        .O(\i_hold[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[4]_i_1 
       (.I0(\i_hold_reg[15]_0 [4]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [4]),
        .O(\i_hold[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[5]_i_1 
       (.I0(\i_hold_reg[15]_0 [5]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [5]),
        .O(\i_hold[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[6]_i_1 
       (.I0(\i_hold_reg[15]_0 [6]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [6]),
        .O(\i_hold[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[7]_i_1 
       (.I0(\i_hold_reg[15]_0 [7]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [7]),
        .O(\i_hold[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[8]_i_1 
       (.I0(\i_hold_reg[15]_0 [8]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [8]),
        .O(\i_hold[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEA0000AA2A)) 
    \i_hold[9]_i_1 
       (.I0(\i_hold_reg[15]_0 [9]),
        .I1(\i_hold[15]_i_2_n_0 ),
        .I2(axis_bit_reg_0[0]),
        .I3(axis_bit_reg_0[1]),
        .I4(\i_hold[15]_i_3_n_0 ),
        .I5(\i_hold_reg[15]_1 [9]),
        .O(\i_hold[9]_i_1_n_0 ));
  FDSE \i_hold_reg[0] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[0]_i_1_n_0 ),
        .Q(i_hold[0]),
        .S(SS));
  FDSE \i_hold_reg[10] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[10]_i_1_n_0 ),
        .Q(i_hold[10]),
        .S(SS));
  FDSE \i_hold_reg[11] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[11]_i_1_n_0 ),
        .Q(i_hold[11]),
        .S(SS));
  FDSE \i_hold_reg[12] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[12]_i_1_n_0 ),
        .Q(i_hold[12]),
        .S(SS));
  FDSE \i_hold_reg[13] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[13]_i_1_n_0 ),
        .Q(i_hold[13]),
        .S(SS));
  FDSE \i_hold_reg[14] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[14]_i_1_n_0 ),
        .Q(i_hold[14]),
        .S(SS));
  FDRE \i_hold_reg[15] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[15]_i_1_n_0 ),
        .Q(i_hold[15]),
        .R(SS));
  MUXF7 \i_hold_reg[15]_i_4 
       (.I0(\i_hold[15]_i_8_n_0 ),
        .I1(\i_hold[15]_i_9_n_0 ),
        .O(\i_hold_reg[15]_i_4_n_0 ),
        .S(pat_idx[2]));
  MUXF7 \i_hold_reg[15]_i_5 
       (.I0(\i_hold[15]_i_10_n_0 ),
        .I1(\i_hold[15]_i_11_n_0 ),
        .O(\i_hold_reg[15]_i_5_n_0 ),
        .S(pat_idx[2]));
  MUXF7 \i_hold_reg[15]_i_6 
       (.I0(\i_hold[15]_i_12_n_0 ),
        .I1(\i_hold[15]_i_13_n_0 ),
        .O(\i_hold_reg[15]_i_6_n_0 ),
        .S(pat_idx[2]));
  MUXF7 \i_hold_reg[15]_i_7 
       (.I0(\i_hold[15]_i_14_n_0 ),
        .I1(\i_hold[15]_i_15_n_0 ),
        .O(\i_hold_reg[15]_i_7_n_0 ),
        .S(pat_idx[2]));
  FDSE \i_hold_reg[1] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[1]_i_1_n_0 ),
        .Q(i_hold[1]),
        .S(SS));
  FDSE \i_hold_reg[2] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[2]_i_1_n_0 ),
        .Q(i_hold[2]),
        .S(SS));
  FDSE \i_hold_reg[3] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[3]_i_1_n_0 ),
        .Q(i_hold[3]),
        .S(SS));
  FDSE \i_hold_reg[4] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[4]_i_1_n_0 ),
        .Q(i_hold[4]),
        .S(SS));
  FDSE \i_hold_reg[5] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[5]_i_1_n_0 ),
        .Q(i_hold[5]),
        .S(SS));
  FDSE \i_hold_reg[6] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[6]_i_1_n_0 ),
        .Q(i_hold[6]),
        .S(SS));
  FDSE \i_hold_reg[7] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[7]_i_1_n_0 ),
        .Q(i_hold[7]),
        .S(SS));
  FDSE \i_hold_reg[8] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[8]_i_1_n_0 ),
        .Q(i_hold[8]),
        .S(SS));
  FDSE \i_hold_reg[9] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\i_hold[9]_i_1_n_0 ),
        .Q(i_hold[9]),
        .S(SS));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[0]_i_1 
       (.I0(i_hold[0]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[0]),
        .O(\m_axis_dac_tdata[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[10]_i_1 
       (.I0(i_hold[10]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[10]),
        .O(\m_axis_dac_tdata[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[11]_i_1 
       (.I0(i_hold[11]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[11]),
        .O(\m_axis_dac_tdata[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[12]_i_1 
       (.I0(i_hold[12]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[12]),
        .O(\m_axis_dac_tdata[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[13]_i_1 
       (.I0(i_hold[13]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[13]),
        .O(\m_axis_dac_tdata[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[14]_i_1 
       (.I0(i_hold[14]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[14]),
        .O(\m_axis_dac_tdata[14]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \m_axis_dac_tdata[15]_i_1 
       (.I0(aresetn),
        .O(SS));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[15]_i_2 
       (.I0(i_hold[15]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[15]),
        .O(\m_axis_dac_tdata[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[1]_i_1 
       (.I0(i_hold[1]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[1]),
        .O(\m_axis_dac_tdata[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[2]_i_1 
       (.I0(i_hold[2]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[2]),
        .O(\m_axis_dac_tdata[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[32]_i_1 
       (.I0(i_hold[0]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[32]),
        .O(\m_axis_dac_tdata[32]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[33]_i_1 
       (.I0(i_hold[1]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[33]),
        .O(\m_axis_dac_tdata[33]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[34]_i_1 
       (.I0(i_hold[2]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[34]),
        .O(\m_axis_dac_tdata[34]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[35]_i_1 
       (.I0(i_hold[3]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[35]),
        .O(\m_axis_dac_tdata[35]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[36]_i_1 
       (.I0(i_hold[4]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[36]),
        .O(\m_axis_dac_tdata[36]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[37]_i_1 
       (.I0(i_hold[5]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[37]),
        .O(\m_axis_dac_tdata[37]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[38]_i_1 
       (.I0(i_hold[6]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[38]),
        .O(\m_axis_dac_tdata[38]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[39]_i_1 
       (.I0(i_hold[7]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[39]),
        .O(\m_axis_dac_tdata[39]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[3]_i_1 
       (.I0(i_hold[3]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[3]),
        .O(\m_axis_dac_tdata[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[40]_i_1 
       (.I0(i_hold[8]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[40]),
        .O(\m_axis_dac_tdata[40]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[41]_i_1 
       (.I0(i_hold[9]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[41]),
        .O(\m_axis_dac_tdata[41]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[42]_i_1 
       (.I0(i_hold[10]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[42]),
        .O(\m_axis_dac_tdata[42]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[43]_i_1 
       (.I0(i_hold[11]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[43]),
        .O(\m_axis_dac_tdata[43]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[44]_i_1 
       (.I0(i_hold[12]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[44]),
        .O(\m_axis_dac_tdata[44]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[45]_i_1 
       (.I0(i_hold[13]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[45]),
        .O(\m_axis_dac_tdata[45]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[46]_i_1 
       (.I0(i_hold[14]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[46]),
        .O(\m_axis_dac_tdata[46]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h2F)) 
    \m_axis_dac_tdata[47]_i_1 
       (.I0(core_enable),
        .I1(core_ch_sel),
        .I2(aresetn),
        .O(\m_axis_dac_tdata[47]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[47]_i_2 
       (.I0(i_hold[15]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[47]),
        .O(\m_axis_dac_tdata[47]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[4]_i_1 
       (.I0(i_hold[4]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[4]),
        .O(\m_axis_dac_tdata[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[5]_i_1 
       (.I0(i_hold[5]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[5]),
        .O(\m_axis_dac_tdata[5]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \m_axis_dac_tdata[63]_i_1 
       (.I0(core_enable),
        .I1(aresetn),
        .O(\m_axis_dac_tdata[63]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[6]_i_1 
       (.I0(i_hold[6]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[6]),
        .O(\m_axis_dac_tdata[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[7]_i_1 
       (.I0(i_hold[7]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[7]),
        .O(\m_axis_dac_tdata[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[8]_i_1 
       (.I0(i_hold[8]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[8]),
        .O(\m_axis_dac_tdata[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_axis_dac_tdata[9]_i_1 
       (.I0(i_hold[9]),
        .I1(core_enable),
        .I2(S_AXIS_DMA_TDATA[9]),
        .O(\m_axis_dac_tdata[9]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[0]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[0]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[10] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[10]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[10]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[11] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[11]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[11]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[12] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[12]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[12]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[13] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[13]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[13]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[14] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[14]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[14]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[15] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[15]_i_2_n_0 ),
        .Q(M_AXIS_DAC_TDATA[15]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[16] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[16]),
        .Q(M_AXIS_DAC_TDATA[16]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[17] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[17]),
        .Q(M_AXIS_DAC_TDATA[17]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[18] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[18]),
        .Q(M_AXIS_DAC_TDATA[18]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[19] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[19]),
        .Q(M_AXIS_DAC_TDATA[19]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[1]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[1]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[20] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[20]),
        .Q(M_AXIS_DAC_TDATA[20]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[21] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[21]),
        .Q(M_AXIS_DAC_TDATA[21]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[22] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[22]),
        .Q(M_AXIS_DAC_TDATA[22]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[23] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[23]),
        .Q(M_AXIS_DAC_TDATA[23]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[24] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[24]),
        .Q(M_AXIS_DAC_TDATA[24]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[25] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[25]),
        .Q(M_AXIS_DAC_TDATA[25]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[26] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[26]),
        .Q(M_AXIS_DAC_TDATA[26]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[27] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[27]),
        .Q(M_AXIS_DAC_TDATA[27]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[28] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[28]),
        .Q(M_AXIS_DAC_TDATA[28]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[29] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[29]),
        .Q(M_AXIS_DAC_TDATA[29]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[2]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[2]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[30] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[30]),
        .Q(M_AXIS_DAC_TDATA[30]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[31] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[31]),
        .Q(M_AXIS_DAC_TDATA[31]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[32] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[32]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[32]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[33] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[33]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[33]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[34] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[34]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[34]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[35] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[35]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[35]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[36] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[36]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[36]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[37] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[37]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[37]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[38] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[38]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[38]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[39] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[39]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[39]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[3]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[3]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[40] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[40]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[40]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[41] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[41]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[41]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[42] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[42]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[42]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[43] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[43]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[43]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[44] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[44]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[44]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[45] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[45]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[45]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[46] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[46]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[46]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[47] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[47]_i_2_n_0 ),
        .Q(M_AXIS_DAC_TDATA[47]),
        .R(\m_axis_dac_tdata[47]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[48] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[48]),
        .Q(M_AXIS_DAC_TDATA[48]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[49] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[49]),
        .Q(M_AXIS_DAC_TDATA[49]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[4]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[4]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[50] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[50]),
        .Q(M_AXIS_DAC_TDATA[50]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[51] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[51]),
        .Q(M_AXIS_DAC_TDATA[51]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[52] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[52]),
        .Q(M_AXIS_DAC_TDATA[52]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[53] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[53]),
        .Q(M_AXIS_DAC_TDATA[53]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[54] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[54]),
        .Q(M_AXIS_DAC_TDATA[54]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[55] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[55]),
        .Q(M_AXIS_DAC_TDATA[55]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[56] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[56]),
        .Q(M_AXIS_DAC_TDATA[56]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[57] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[57]),
        .Q(M_AXIS_DAC_TDATA[57]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[58] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[58]),
        .Q(M_AXIS_DAC_TDATA[58]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[59] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[59]),
        .Q(M_AXIS_DAC_TDATA[59]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[5]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[5]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[60] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[60]),
        .Q(M_AXIS_DAC_TDATA[60]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[61] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[61]),
        .Q(M_AXIS_DAC_TDATA[61]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[62] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[62]),
        .Q(M_AXIS_DAC_TDATA[62]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[63] 
       (.C(aclk),
        .CE(1'b1),
        .D(S_AXIS_DMA_TDATA[63]),
        .Q(M_AXIS_DAC_TDATA[63]),
        .R(\m_axis_dac_tdata[63]_i_1_n_0 ));
  FDRE \m_axis_dac_tdata_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[6]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[6]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[7]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[7]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[8] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[8]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[8]),
        .R(SS));
  FDRE \m_axis_dac_tdata_reg[9] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axis_dac_tdata[9]_i_1_n_0 ),
        .Q(M_AXIS_DAC_TDATA[9]),
        .R(SS));
  LUT2 #(
    .INIT(4'hE)) 
    m_axis_dac_tvalid_i_1
       (.I0(S_AXIS_DMA_TVALID),
        .I1(core_enable),
        .O(m_axis_dac_tvalid_i_1_n_0));
  FDRE m_axis_dac_tvalid_reg
       (.C(aclk),
        .CE(1'b1),
        .D(m_axis_dac_tvalid_i_1_n_0),
        .Q(M_AXIS_DAC_TVALID),
        .R(SS));
  LUT1 #(
    .INIT(2'h1)) 
    \pat_idx[0]_i_1 
       (.I0(pat_idx[0]),
        .O(\pat_idx[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \pat_idx[1]_i_1 
       (.I0(pat_idx[0]),
        .I1(pat_idx[1]),
        .O(\pat_idx[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \pat_idx[2]_i_1 
       (.I0(pat_idx[2]),
        .I1(pat_idx[1]),
        .I2(pat_idx[0]),
        .O(\pat_idx[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \pat_idx[3]_i_1 
       (.I0(pat_idx[3]),
        .I1(pat_idx[2]),
        .I2(pat_idx[0]),
        .I3(pat_idx[1]),
        .O(\pat_idx[3]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h20)) 
    \pat_idx[4]_i_1 
       (.I0(p_3_in),
        .I1(axis_bit_reg_0[1]),
        .I2(axis_bit_reg_0[0]),
        .O(pat_idx0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \pat_idx[4]_i_2 
       (.I0(pat_idx[4]),
        .I1(pat_idx[3]),
        .I2(pat_idx[1]),
        .I3(pat_idx[0]),
        .I4(pat_idx[2]),
        .O(\pat_idx[4]_i_2_n_0 ));
  FDSE \pat_idx_reg[0] 
       (.C(aclk),
        .CE(pat_idx0),
        .D(\pat_idx[0]_i_1_n_0 ),
        .Q(pat_idx[0]),
        .S(SS));
  FDSE \pat_idx_reg[1] 
       (.C(aclk),
        .CE(pat_idx0),
        .D(\pat_idx[1]_i_1_n_0 ),
        .Q(pat_idx[1]),
        .S(SS));
  FDSE \pat_idx_reg[2] 
       (.C(aclk),
        .CE(pat_idx0),
        .D(\pat_idx[2]_i_1_n_0 ),
        .Q(pat_idx[2]),
        .S(SS));
  FDSE \pat_idx_reg[3] 
       (.C(aclk),
        .CE(pat_idx0),
        .D(\pat_idx[3]_i_1_n_0 ),
        .Q(pat_idx[3]),
        .S(SS));
  FDSE \pat_idx_reg[4] 
       (.C(aclk),
        .CE(pat_idx0),
        .D(\pat_idx[4]_i_2_n_0 ),
        .Q(pat_idx[4]),
        .S(SS));
  LUT1 #(
    .INIT(2'h1)) 
    \sym_count[0]_i_2 
       (.I0(D[0]),
        .O(\sym_count[0]_i_2_n_0 ));
  FDRE \sym_count_reg[0] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[0]_i_1_n_7 ),
        .Q(D[0]),
        .R(\div_cnt[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \sym_count_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\sym_count_reg[0]_i_1_n_0 ,\sym_count_reg[0]_i_1_n_1 ,\sym_count_reg[0]_i_1_n_2 ,\sym_count_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\sym_count_reg[0]_i_1_n_4 ,\sym_count_reg[0]_i_1_n_5 ,\sym_count_reg[0]_i_1_n_6 ,\sym_count_reg[0]_i_1_n_7 }),
        .S({D[3:1],\sym_count[0]_i_2_n_0 }));
  FDRE \sym_count_reg[10] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[8]_i_1_n_5 ),
        .Q(D[10]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[11] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[8]_i_1_n_4 ),
        .Q(D[11]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[12] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[12]_i_1_n_7 ),
        .Q(D[12]),
        .R(\div_cnt[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \sym_count_reg[12]_i_1 
       (.CI(\sym_count_reg[8]_i_1_n_0 ),
        .CO({\sym_count_reg[12]_i_1_n_0 ,\sym_count_reg[12]_i_1_n_1 ,\sym_count_reg[12]_i_1_n_2 ,\sym_count_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sym_count_reg[12]_i_1_n_4 ,\sym_count_reg[12]_i_1_n_5 ,\sym_count_reg[12]_i_1_n_6 ,\sym_count_reg[12]_i_1_n_7 }),
        .S(D[15:12]));
  FDRE \sym_count_reg[13] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[12]_i_1_n_6 ),
        .Q(D[13]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[14] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[12]_i_1_n_5 ),
        .Q(D[14]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[15] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[12]_i_1_n_4 ),
        .Q(D[15]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[16] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[16]_i_1_n_7 ),
        .Q(D[16]),
        .R(\div_cnt[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \sym_count_reg[16]_i_1 
       (.CI(\sym_count_reg[12]_i_1_n_0 ),
        .CO({\sym_count_reg[16]_i_1_n_0 ,\sym_count_reg[16]_i_1_n_1 ,\sym_count_reg[16]_i_1_n_2 ,\sym_count_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sym_count_reg[16]_i_1_n_4 ,\sym_count_reg[16]_i_1_n_5 ,\sym_count_reg[16]_i_1_n_6 ,\sym_count_reg[16]_i_1_n_7 }),
        .S(D[19:16]));
  FDRE \sym_count_reg[17] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[16]_i_1_n_6 ),
        .Q(D[17]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[18] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[16]_i_1_n_5 ),
        .Q(D[18]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[19] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[16]_i_1_n_4 ),
        .Q(D[19]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[1] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[0]_i_1_n_6 ),
        .Q(D[1]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[20] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[20]_i_1_n_7 ),
        .Q(D[20]),
        .R(\div_cnt[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \sym_count_reg[20]_i_1 
       (.CI(\sym_count_reg[16]_i_1_n_0 ),
        .CO({\sym_count_reg[20]_i_1_n_0 ,\sym_count_reg[20]_i_1_n_1 ,\sym_count_reg[20]_i_1_n_2 ,\sym_count_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sym_count_reg[20]_i_1_n_4 ,\sym_count_reg[20]_i_1_n_5 ,\sym_count_reg[20]_i_1_n_6 ,\sym_count_reg[20]_i_1_n_7 }),
        .S(D[23:20]));
  FDRE \sym_count_reg[21] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[20]_i_1_n_6 ),
        .Q(D[21]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[22] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[20]_i_1_n_5 ),
        .Q(D[22]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[23] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[20]_i_1_n_4 ),
        .Q(D[23]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[24] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[24]_i_1_n_7 ),
        .Q(D[24]),
        .R(\div_cnt[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \sym_count_reg[24]_i_1 
       (.CI(\sym_count_reg[20]_i_1_n_0 ),
        .CO({\sym_count_reg[24]_i_1_n_0 ,\sym_count_reg[24]_i_1_n_1 ,\sym_count_reg[24]_i_1_n_2 ,\sym_count_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sym_count_reg[24]_i_1_n_4 ,\sym_count_reg[24]_i_1_n_5 ,\sym_count_reg[24]_i_1_n_6 ,\sym_count_reg[24]_i_1_n_7 }),
        .S(D[27:24]));
  FDRE \sym_count_reg[25] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[24]_i_1_n_6 ),
        .Q(D[25]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[26] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[24]_i_1_n_5 ),
        .Q(D[26]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[27] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[24]_i_1_n_4 ),
        .Q(D[27]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[28] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[28]_i_1_n_7 ),
        .Q(D[28]),
        .R(\div_cnt[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \sym_count_reg[28]_i_1 
       (.CI(\sym_count_reg[24]_i_1_n_0 ),
        .CO({\sym_count_reg[28]_i_1_n_0 ,\sym_count_reg[28]_i_1_n_1 ,\sym_count_reg[28]_i_1_n_2 ,\sym_count_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sym_count_reg[28]_i_1_n_4 ,\sym_count_reg[28]_i_1_n_5 ,\sym_count_reg[28]_i_1_n_6 ,\sym_count_reg[28]_i_1_n_7 }),
        .S(D[31:28]));
  FDRE \sym_count_reg[29] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[28]_i_1_n_6 ),
        .Q(D[29]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[2] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[0]_i_1_n_5 ),
        .Q(D[2]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[30] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[28]_i_1_n_5 ),
        .Q(D[30]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[31] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[28]_i_1_n_4 ),
        .Q(D[31]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[32] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[32]_i_1_n_7 ),
        .Q(D[32]),
        .R(\div_cnt[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \sym_count_reg[32]_i_1 
       (.CI(\sym_count_reg[28]_i_1_n_0 ),
        .CO({\sym_count_reg[32]_i_1_n_0 ,\sym_count_reg[32]_i_1_n_1 ,\sym_count_reg[32]_i_1_n_2 ,\sym_count_reg[32]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sym_count_reg[32]_i_1_n_4 ,\sym_count_reg[32]_i_1_n_5 ,\sym_count_reg[32]_i_1_n_6 ,\sym_count_reg[32]_i_1_n_7 }),
        .S(D[35:32]));
  FDRE \sym_count_reg[33] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[32]_i_1_n_6 ),
        .Q(D[33]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[34] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[32]_i_1_n_5 ),
        .Q(D[34]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[35] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[32]_i_1_n_4 ),
        .Q(D[35]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[36] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[36]_i_1_n_7 ),
        .Q(D[36]),
        .R(\div_cnt[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \sym_count_reg[36]_i_1 
       (.CI(\sym_count_reg[32]_i_1_n_0 ),
        .CO({\NLW_sym_count_reg[36]_i_1_CO_UNCONNECTED [3],\sym_count_reg[36]_i_1_n_1 ,\sym_count_reg[36]_i_1_n_2 ,\sym_count_reg[36]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sym_count_reg[36]_i_1_n_4 ,\sym_count_reg[36]_i_1_n_5 ,\sym_count_reg[36]_i_1_n_6 ,\sym_count_reg[36]_i_1_n_7 }),
        .S(D[39:36]));
  FDRE \sym_count_reg[37] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[36]_i_1_n_6 ),
        .Q(D[37]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[38] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[36]_i_1_n_5 ),
        .Q(D[38]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[39] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[36]_i_1_n_4 ),
        .Q(D[39]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[3] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[0]_i_1_n_4 ),
        .Q(D[3]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[4] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[4]_i_1_n_7 ),
        .Q(D[4]),
        .R(\div_cnt[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \sym_count_reg[4]_i_1 
       (.CI(\sym_count_reg[0]_i_1_n_0 ),
        .CO({\sym_count_reg[4]_i_1_n_0 ,\sym_count_reg[4]_i_1_n_1 ,\sym_count_reg[4]_i_1_n_2 ,\sym_count_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sym_count_reg[4]_i_1_n_4 ,\sym_count_reg[4]_i_1_n_5 ,\sym_count_reg[4]_i_1_n_6 ,\sym_count_reg[4]_i_1_n_7 }),
        .S(D[7:4]));
  FDRE \sym_count_reg[5] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[4]_i_1_n_6 ),
        .Q(D[5]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[6] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[4]_i_1_n_5 ),
        .Q(D[6]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[7] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[4]_i_1_n_4 ),
        .Q(D[7]),
        .R(\div_cnt[15]_i_1_n_0 ));
  FDRE \sym_count_reg[8] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[8]_i_1_n_7 ),
        .Q(D[8]),
        .R(\div_cnt[15]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \sym_count_reg[8]_i_1 
       (.CI(\sym_count_reg[4]_i_1_n_0 ),
        .CO({\sym_count_reg[8]_i_1_n_0 ,\sym_count_reg[8]_i_1_n_1 ,\sym_count_reg[8]_i_1_n_2 ,\sym_count_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sym_count_reg[8]_i_1_n_4 ,\sym_count_reg[8]_i_1_n_5 ,\sym_count_reg[8]_i_1_n_6 ,\sym_count_reg[8]_i_1_n_7 }),
        .S(D[11:8]));
  FDRE \sym_count_reg[9] 
       (.C(aclk),
        .CE(p_3_in),
        .D(\sym_count_reg[8]_i_1_n_6 ),
        .Q(D[9]),
        .R(\div_cnt[15]_i_1_n_0 ));
endmodule

(* ORIG_REF_NAME = "bpsk_modulator_v1_0" *) 
module system_bpsk_modulator_0_0_bpsk_modulator_v1_0
   (M_AXIS_DAC_TDATA,
    M_AXIS_DAC_TVALID,
    S_AXI_AWREADY,
    S_AXI_WREADY,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXIS_DMA_TREADY,
    M_AXIS_DAC_TLAST,
    S_AXIS_BITS_TREADY,
    M_AXIS_DAC_TKEEP,
    S_AXI_RVALID,
    axi_bvalid_reg_0,
    S_AXI_ACLK,
    aclk,
    S_AXI_WDATA,
    S_AXI_AWADDR,
    S_AXI_WSTRB,
    M_AXIS_DAC_TREADY,
    S_AXIS_DMA_TDATA,
    S_AXIS_DMA_TVALID,
    aresetn,
    S_AXIS_DMA_TLAST,
    S_AXIS_DMA_TKEEP,
    S_AXI_ARESETN,
    S_AXI_ARVALID,
    S_AXI_RREADY,
    S_AXI_WVALID,
    S_AXI_AWVALID,
    S_AXI_ARADDR,
    S_AXIS_BITS_TDATA,
    S_AXIS_BITS_TVALID,
    S_AXI_BREADY);
  output [63:0]M_AXIS_DAC_TDATA;
  output M_AXIS_DAC_TVALID;
  output S_AXI_AWREADY;
  output S_AXI_WREADY;
  output S_AXI_ARREADY;
  output [31:0]S_AXI_RDATA;
  output S_AXIS_DMA_TREADY;
  output M_AXIS_DAC_TLAST;
  output S_AXIS_BITS_TREADY;
  output [7:0]M_AXIS_DAC_TKEEP;
  output S_AXI_RVALID;
  output axi_bvalid_reg_0;
  input S_AXI_ACLK;
  input aclk;
  input [31:0]S_AXI_WDATA;
  input [5:0]S_AXI_AWADDR;
  input [3:0]S_AXI_WSTRB;
  input M_AXIS_DAC_TREADY;
  input [63:0]S_AXIS_DMA_TDATA;
  input S_AXIS_DMA_TVALID;
  input aresetn;
  input S_AXIS_DMA_TLAST;
  input [7:0]S_AXIS_DMA_TKEEP;
  input S_AXI_ARESETN;
  input S_AXI_ARVALID;
  input S_AXI_RREADY;
  input S_AXI_WVALID;
  input S_AXI_AWVALID;
  input [5:0]S_AXI_ARADDR;
  input [0:0]S_AXIS_BITS_TDATA;
  input S_AXIS_BITS_TVALID;
  input S_AXI_BREADY;

  wire [63:0]M_AXIS_DAC_TDATA;
  wire [7:0]M_AXIS_DAC_TKEEP;
  wire M_AXIS_DAC_TLAST;
  wire M_AXIS_DAC_TREADY;
  wire M_AXIS_DAC_TVALID;
  wire [0:0]S_AXIS_BITS_TDATA;
  wire S_AXIS_BITS_TREADY;
  wire S_AXIS_BITS_TVALID;
  wire [63:0]S_AXIS_DMA_TDATA;
  wire [7:0]S_AXIS_DMA_TKEEP;
  wire S_AXIS_DMA_TLAST;
  wire S_AXIS_DMA_TREADY;
  wire S_AXIS_DMA_TVALID;
  wire S_AXI_ACLK;
  wire [5:0]S_AXI_ARADDR;
  wire S_AXI_ARESETN;
  wire S_AXI_ARREADY;
  wire S_AXI_ARVALID;
  wire [5:0]S_AXI_AWADDR;
  wire S_AXI_AWREADY;
  wire S_AXI_AWVALID;
  wire S_AXI_BREADY;
  wire [31:0]S_AXI_RDATA;
  wire S_AXI_RREADY;
  wire S_AXI_RVALID;
  wire [31:0]S_AXI_WDATA;
  wire S_AXI_WREADY;
  wire [3:0]S_AXI_WSTRB;
  wire S_AXI_WVALID;
  wire aclk;
  wire [1:0]active_ff;
  wire aresetn;
  wire \aw_addr_reg_n_0_[5] ;
  wire \aw_addr_reg_n_0_[6] ;
  wire \aw_addr_reg_n_0_[7] ;
  wire aw_done;
  wire aw_done_i_1_n_0;
  wire axi_arready0;
  wire axi_awready0;
  wire axi_awready_i_1_n_0;
  wire axi_bvalid_i_1_n_0;
  wire axi_bvalid_reg_0;
  wire \axi_rdata[0]_i_1_n_0 ;
  wire \axi_rdata[0]_i_2_n_0 ;
  wire \axi_rdata[0]_i_3_n_0 ;
  wire \axi_rdata[10]_i_1_n_0 ;
  wire \axi_rdata[10]_i_2_n_0 ;
  wire \axi_rdata[10]_i_3_n_0 ;
  wire \axi_rdata[11]_i_1_n_0 ;
  wire \axi_rdata[11]_i_2_n_0 ;
  wire \axi_rdata[11]_i_3_n_0 ;
  wire \axi_rdata[12]_i_1_n_0 ;
  wire \axi_rdata[12]_i_2_n_0 ;
  wire \axi_rdata[12]_i_3_n_0 ;
  wire \axi_rdata[13]_i_1_n_0 ;
  wire \axi_rdata[13]_i_2_n_0 ;
  wire \axi_rdata[13]_i_3_n_0 ;
  wire \axi_rdata[14]_i_1_n_0 ;
  wire \axi_rdata[14]_i_2_n_0 ;
  wire \axi_rdata[14]_i_3_n_0 ;
  wire \axi_rdata[15]_i_1_n_0 ;
  wire \axi_rdata[15]_i_2_n_0 ;
  wire \axi_rdata[15]_i_3_n_0 ;
  wire \axi_rdata[16]_i_1_n_0 ;
  wire \axi_rdata[16]_i_2_n_0 ;
  wire \axi_rdata[17]_i_1_n_0 ;
  wire \axi_rdata[17]_i_2_n_0 ;
  wire \axi_rdata[18]_i_1_n_0 ;
  wire \axi_rdata[18]_i_2_n_0 ;
  wire \axi_rdata[19]_i_1_n_0 ;
  wire \axi_rdata[19]_i_2_n_0 ;
  wire \axi_rdata[1]_i_1_n_0 ;
  wire \axi_rdata[1]_i_2_n_0 ;
  wire \axi_rdata[1]_i_3_n_0 ;
  wire \axi_rdata[20]_i_1_n_0 ;
  wire \axi_rdata[20]_i_2_n_0 ;
  wire \axi_rdata[21]_i_1_n_0 ;
  wire \axi_rdata[21]_i_2_n_0 ;
  wire \axi_rdata[22]_i_1_n_0 ;
  wire \axi_rdata[22]_i_2_n_0 ;
  wire \axi_rdata[23]_i_1_n_0 ;
  wire \axi_rdata[23]_i_2_n_0 ;
  wire \axi_rdata[24]_i_1_n_0 ;
  wire \axi_rdata[24]_i_2_n_0 ;
  wire \axi_rdata[25]_i_1_n_0 ;
  wire \axi_rdata[25]_i_2_n_0 ;
  wire \axi_rdata[26]_i_1_n_0 ;
  wire \axi_rdata[26]_i_2_n_0 ;
  wire \axi_rdata[27]_i_1_n_0 ;
  wire \axi_rdata[27]_i_2_n_0 ;
  wire \axi_rdata[28]_i_1_n_0 ;
  wire \axi_rdata[28]_i_2_n_0 ;
  wire \axi_rdata[29]_i_1_n_0 ;
  wire \axi_rdata[29]_i_2_n_0 ;
  wire \axi_rdata[2]_i_1_n_0 ;
  wire \axi_rdata[2]_i_2_n_0 ;
  wire \axi_rdata[2]_i_3_n_0 ;
  wire \axi_rdata[30]_i_1_n_0 ;
  wire \axi_rdata[30]_i_2_n_0 ;
  wire \axi_rdata[31]_i_1_n_0 ;
  wire \axi_rdata[31]_i_2_n_0 ;
  wire \axi_rdata[31]_i_3_n_0 ;
  wire \axi_rdata[3]_i_1_n_0 ;
  wire \axi_rdata[3]_i_2_n_0 ;
  wire \axi_rdata[3]_i_3_n_0 ;
  wire \axi_rdata[3]_i_4_n_0 ;
  wire \axi_rdata[4]_i_1_n_0 ;
  wire \axi_rdata[4]_i_2_n_0 ;
  wire \axi_rdata[4]_i_3_n_0 ;
  wire \axi_rdata[5]_i_1_n_0 ;
  wire \axi_rdata[5]_i_2_n_0 ;
  wire \axi_rdata[5]_i_3_n_0 ;
  wire \axi_rdata[6]_i_1_n_0 ;
  wire \axi_rdata[6]_i_2_n_0 ;
  wire \axi_rdata[6]_i_3_n_0 ;
  wire \axi_rdata[7]_i_1_n_0 ;
  wire \axi_rdata[7]_i_2_n_0 ;
  wire \axi_rdata[7]_i_3_n_0 ;
  wire \axi_rdata[8]_i_1_n_0 ;
  wire \axi_rdata[8]_i_2_n_0 ;
  wire \axi_rdata[8]_i_3_n_0 ;
  wire \axi_rdata[9]_i_1_n_0 ;
  wire \axi_rdata[9]_i_2_n_0 ;
  wire \axi_rdata[9]_i_3_n_0 ;
  wire axi_rvalid_i_1_n_0;
  wire axi_wready0;
  wire axireg_ch_sel;
  wire axireg_enable;
  wire axireg_enable_1;
  wire \axireg_i_neg[15]_i_1_n_0 ;
  wire \axireg_i_neg[7]_i_1_n_0 ;
  wire \axireg_i_pos[15]_i_1_n_0 ;
  wire \axireg_i_pos[15]_i_2_n_0 ;
  wire \axireg_i_pos[7]_i_1_n_0 ;
  wire [31:0]axireg_pat_data;
  wire \axireg_pat_data[15]_i_1_n_0 ;
  wire \axireg_pat_data[23]_i_1_n_0 ;
  wire \axireg_pat_data[31]_i_1_n_0 ;
  wire \axireg_pat_data[7]_i_1_n_0 ;
  wire [1:0]axireg_src_sel;
  wire \axireg_src_sel[1]_i_2_n_0 ;
  wire [15:0]axireg_sym_div;
  wire \axireg_sym_div[15]_i_1_n_0 ;
  wire \axireg_sym_div[7]_i_1_n_0 ;
  wire core_ch_sel;
  wire core_enable;
  wire [15:0]core_i_neg;
  wire [15:0]core_i_pos;
  wire [31:0]core_pat_data;
  wire [1:0]core_src_sel;
  wire [15:0]core_sym_div;
  wire [31:0]data3;
  wire [7:0]data6;
  wire do_write;
  wire [2:0]p_0_in;
  wire [1:0]p_1_in;
  wire p_1_in0;
  wire p_1_in_0;
  wire [15:0]p_2_in;
  wire snap_ch_sel;
  wire snap_enable;
  wire [15:0]snap_i_neg;
  wire [15:0]snap_i_pos;
  wire [31:0]snap_pat_data;
  wire [1:0]snap_src_sel;
  wire [15:0]snap_sym_div;
  wire [39:0]sym_cnt_ff1;
  wire \sym_cnt_ff2_reg_n_0_[0] ;
  wire \sym_cnt_ff2_reg_n_0_[10] ;
  wire \sym_cnt_ff2_reg_n_0_[11] ;
  wire \sym_cnt_ff2_reg_n_0_[12] ;
  wire \sym_cnt_ff2_reg_n_0_[13] ;
  wire \sym_cnt_ff2_reg_n_0_[14] ;
  wire \sym_cnt_ff2_reg_n_0_[15] ;
  wire \sym_cnt_ff2_reg_n_0_[16] ;
  wire \sym_cnt_ff2_reg_n_0_[17] ;
  wire \sym_cnt_ff2_reg_n_0_[18] ;
  wire \sym_cnt_ff2_reg_n_0_[19] ;
  wire \sym_cnt_ff2_reg_n_0_[1] ;
  wire \sym_cnt_ff2_reg_n_0_[20] ;
  wire \sym_cnt_ff2_reg_n_0_[21] ;
  wire \sym_cnt_ff2_reg_n_0_[22] ;
  wire \sym_cnt_ff2_reg_n_0_[23] ;
  wire \sym_cnt_ff2_reg_n_0_[24] ;
  wire \sym_cnt_ff2_reg_n_0_[25] ;
  wire \sym_cnt_ff2_reg_n_0_[26] ;
  wire \sym_cnt_ff2_reg_n_0_[27] ;
  wire \sym_cnt_ff2_reg_n_0_[28] ;
  wire \sym_cnt_ff2_reg_n_0_[29] ;
  wire \sym_cnt_ff2_reg_n_0_[2] ;
  wire \sym_cnt_ff2_reg_n_0_[30] ;
  wire \sym_cnt_ff2_reg_n_0_[31] ;
  wire \sym_cnt_ff2_reg_n_0_[3] ;
  wire \sym_cnt_ff2_reg_n_0_[4] ;
  wire \sym_cnt_ff2_reg_n_0_[5] ;
  wire \sym_cnt_ff2_reg_n_0_[6] ;
  wire \sym_cnt_ff2_reg_n_0_[7] ;
  wire \sym_cnt_ff2_reg_n_0_[8] ;
  wire \sym_cnt_ff2_reg_n_0_[9] ;
  wire [39:0]sym_count_reg;
  wire u_bpsk_core_n_0;
  wire \w_data_reg_n_0_[0] ;
  wire \w_data_reg_n_0_[10] ;
  wire \w_data_reg_n_0_[11] ;
  wire \w_data_reg_n_0_[12] ;
  wire \w_data_reg_n_0_[13] ;
  wire \w_data_reg_n_0_[14] ;
  wire \w_data_reg_n_0_[15] ;
  wire \w_data_reg_n_0_[3] ;
  wire \w_data_reg_n_0_[4] ;
  wire \w_data_reg_n_0_[5] ;
  wire \w_data_reg_n_0_[6] ;
  wire \w_data_reg_n_0_[7] ;
  wire \w_data_reg_n_0_[8] ;
  wire \w_data_reg_n_0_[9] ;
  wire w_done_i_1_n_0;
  wire w_done_reg_n_0;
  wire \w_strb_reg_n_0_[2] ;
  wire \w_strb_reg_n_0_[3] ;
  wire wr_pulse_axi;
  wire wr_pulse_core;
  wire \wr_pulse_sync_reg_n_0_[0] ;

  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \M_AXIS_DAC_TKEEP[0]_INST_0 
       (.I0(core_enable),
        .I1(S_AXIS_DMA_TKEEP[0]),
        .O(M_AXIS_DAC_TKEEP[0]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \M_AXIS_DAC_TKEEP[1]_INST_0 
       (.I0(core_enable),
        .I1(S_AXIS_DMA_TKEEP[1]),
        .O(M_AXIS_DAC_TKEEP[1]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \M_AXIS_DAC_TKEEP[2]_INST_0 
       (.I0(core_enable),
        .I1(S_AXIS_DMA_TKEEP[2]),
        .O(M_AXIS_DAC_TKEEP[2]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \M_AXIS_DAC_TKEEP[3]_INST_0 
       (.I0(core_enable),
        .I1(S_AXIS_DMA_TKEEP[3]),
        .O(M_AXIS_DAC_TKEEP[3]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \M_AXIS_DAC_TKEEP[4]_INST_0 
       (.I0(core_enable),
        .I1(S_AXIS_DMA_TKEEP[4]),
        .O(M_AXIS_DAC_TKEEP[4]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \M_AXIS_DAC_TKEEP[5]_INST_0 
       (.I0(core_enable),
        .I1(S_AXIS_DMA_TKEEP[5]),
        .O(M_AXIS_DAC_TKEEP[5]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \M_AXIS_DAC_TKEEP[6]_INST_0 
       (.I0(core_enable),
        .I1(S_AXIS_DMA_TKEEP[6]),
        .O(M_AXIS_DAC_TKEEP[6]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \M_AXIS_DAC_TKEEP[7]_INST_0 
       (.I0(core_enable),
        .I1(S_AXIS_DMA_TKEEP[7]),
        .O(M_AXIS_DAC_TKEEP[7]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h2)) 
    M_AXIS_DAC_TLAST_INST_0
       (.I0(S_AXIS_DMA_TLAST),
        .I1(core_enable),
        .O(M_AXIS_DAC_TLAST));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'hE)) 
    S_AXIS_DMA_TREADY_INST_0
       (.I0(core_enable),
        .I1(M_AXIS_DAC_TREADY),
        .O(S_AXIS_DMA_TREADY));
  FDRE \active_ff_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(core_enable),
        .Q(active_ff[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \active_ff_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(active_ff[0]),
        .Q(active_ff[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \aw_addr_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[0]),
        .Q(p_0_in[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \aw_addr_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[1]),
        .Q(p_0_in[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \aw_addr_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[2]),
        .Q(p_0_in[2]),
        .R(axi_awready_i_1_n_0));
  FDRE \aw_addr_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[3]),
        .Q(\aw_addr_reg_n_0_[5] ),
        .R(axi_awready_i_1_n_0));
  FDRE \aw_addr_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[4]),
        .Q(\aw_addr_reg_n_0_[6] ),
        .R(axi_awready_i_1_n_0));
  FDRE \aw_addr_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[5]),
        .Q(\aw_addr_reg_n_0_[7] ),
        .R(axi_awready_i_1_n_0));
  LUT5 #(
    .INIT(32'h00E0E0E0)) 
    aw_done_i_1
       (.I0(aw_done),
        .I1(S_AXI_AWVALID),
        .I2(S_AXI_ARESETN),
        .I3(axi_bvalid_reg_0),
        .I4(S_AXI_BREADY),
        .O(aw_done_i_1_n_0));
  FDRE aw_done_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(aw_done_i_1_n_0),
        .Q(aw_done),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    axi_arready_i_1
       (.I0(S_AXI_ARVALID),
        .I1(S_AXI_ARREADY),
        .O(axi_arready0));
  FDRE axi_arready_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axi_arready0),
        .Q(S_AXI_ARREADY),
        .R(axi_awready_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    axi_awready_i_1
       (.I0(S_AXI_ARESETN),
        .O(axi_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    axi_awready_i_2
       (.I0(S_AXI_AWVALID),
        .I1(aw_done),
        .O(axi_awready0));
  FDRE axi_awready_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axi_awready0),
        .Q(S_AXI_AWREADY),
        .R(axi_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'h08F8)) 
    axi_bvalid_i_1
       (.I0(w_done_reg_n_0),
        .I1(aw_done),
        .I2(axi_bvalid_reg_0),
        .I3(S_AXI_BREADY),
        .O(axi_bvalid_i_1_n_0));
  FDRE axi_bvalid_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axi_bvalid_i_1_n_0),
        .Q(axi_bvalid_reg_0),
        .R(axi_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFE200E2)) 
    \axi_rdata[0]_i_1 
       (.I0(\axi_rdata[0]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(\axi_rdata[0]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[3]),
        .I4(\axi_rdata[3]_i_4_n_0 ),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFCFAFC0)) 
    \axi_rdata[0]_i_2 
       (.I0(data3[0]),
        .I1(axireg_sym_div[0]),
        .I2(S_AXI_ARADDR[1]),
        .I3(S_AXI_ARADDR[0]),
        .I4(axireg_enable),
        .O(\axi_rdata[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \axi_rdata[0]_i_3 
       (.I0(data6[0]),
        .I1(\sym_cnt_ff2_reg_n_0_[0] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_pat_data[0]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[10]_i_1 
       (.I0(\axi_rdata[10]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00B8FFFF00B80000)) 
    \axi_rdata[10]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[10] ),
        .I1(S_AXI_ARADDR[1]),
        .I2(axireg_pat_data[10]),
        .I3(S_AXI_ARADDR[0]),
        .I4(S_AXI_ARADDR[2]),
        .I5(\axi_rdata[10]_i_3_n_0 ),
        .O(\axi_rdata[10]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hA808)) 
    \axi_rdata[10]_i_3 
       (.I0(S_AXI_ARADDR[1]),
        .I1(axireg_sym_div[10]),
        .I2(S_AXI_ARADDR[0]),
        .I3(data3[10]),
        .O(\axi_rdata[10]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[11]_i_1 
       (.I0(\axi_rdata[11]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00B8FFFF00B80000)) 
    \axi_rdata[11]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[11] ),
        .I1(S_AXI_ARADDR[1]),
        .I2(axireg_pat_data[11]),
        .I3(S_AXI_ARADDR[0]),
        .I4(S_AXI_ARADDR[2]),
        .I5(\axi_rdata[11]_i_3_n_0 ),
        .O(\axi_rdata[11]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hA808)) 
    \axi_rdata[11]_i_3 
       (.I0(S_AXI_ARADDR[1]),
        .I1(axireg_sym_div[11]),
        .I2(S_AXI_ARADDR[0]),
        .I3(data3[11]),
        .O(\axi_rdata[11]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[12]_i_1 
       (.I0(\axi_rdata[12]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00B8FFFF00B80000)) 
    \axi_rdata[12]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[12] ),
        .I1(S_AXI_ARADDR[1]),
        .I2(axireg_pat_data[12]),
        .I3(S_AXI_ARADDR[0]),
        .I4(S_AXI_ARADDR[2]),
        .I5(\axi_rdata[12]_i_3_n_0 ),
        .O(\axi_rdata[12]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hA808)) 
    \axi_rdata[12]_i_3 
       (.I0(S_AXI_ARADDR[1]),
        .I1(axireg_sym_div[12]),
        .I2(S_AXI_ARADDR[0]),
        .I3(data3[12]),
        .O(\axi_rdata[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[13]_i_1 
       (.I0(\axi_rdata[13]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00B8FFFF00B80000)) 
    \axi_rdata[13]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[13] ),
        .I1(S_AXI_ARADDR[1]),
        .I2(axireg_pat_data[13]),
        .I3(S_AXI_ARADDR[0]),
        .I4(S_AXI_ARADDR[2]),
        .I5(\axi_rdata[13]_i_3_n_0 ),
        .O(\axi_rdata[13]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hA808)) 
    \axi_rdata[13]_i_3 
       (.I0(S_AXI_ARADDR[1]),
        .I1(axireg_sym_div[13]),
        .I2(S_AXI_ARADDR[0]),
        .I3(data3[13]),
        .O(\axi_rdata[13]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000004540)) 
    \axi_rdata[14]_i_1 
       (.I0(S_AXI_ARADDR[3]),
        .I1(\axi_rdata[14]_i_2_n_0 ),
        .I2(S_AXI_ARADDR[2]),
        .I3(\axi_rdata[14]_i_3_n_0 ),
        .I4(S_AXI_ARADDR[4]),
        .I5(S_AXI_ARADDR[5]),
        .O(\axi_rdata[14]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h00B8)) 
    \axi_rdata[14]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[14] ),
        .I1(S_AXI_ARADDR[1]),
        .I2(axireg_pat_data[14]),
        .I3(S_AXI_ARADDR[0]),
        .O(\axi_rdata[14]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hA808)) 
    \axi_rdata[14]_i_3 
       (.I0(S_AXI_ARADDR[1]),
        .I1(axireg_sym_div[14]),
        .I2(S_AXI_ARADDR[0]),
        .I3(data3[14]),
        .O(\axi_rdata[14]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[15]_i_1 
       (.I0(\axi_rdata[15]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00B8FFFF00B80000)) 
    \axi_rdata[15]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[15] ),
        .I1(S_AXI_ARADDR[1]),
        .I2(axireg_pat_data[15]),
        .I3(S_AXI_ARADDR[0]),
        .I4(S_AXI_ARADDR[2]),
        .I5(\axi_rdata[15]_i_3_n_0 ),
        .O(\axi_rdata[15]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hA808)) 
    \axi_rdata[15]_i_3 
       (.I0(S_AXI_ARADDR[1]),
        .I1(axireg_sym_div[15]),
        .I2(S_AXI_ARADDR[0]),
        .I3(data3[15]),
        .O(\axi_rdata[15]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \axi_rdata[16]_i_1 
       (.I0(\axi_rdata[16]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[4]),
        .I3(S_AXI_ARADDR[5]),
        .O(\axi_rdata[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[16]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[16] ),
        .I1(axireg_pat_data[16]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[16]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[16]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \axi_rdata[17]_i_1 
       (.I0(S_AXI_ARADDR[3]),
        .I1(\axi_rdata[17]_i_2_n_0 ),
        .I2(S_AXI_ARADDR[4]),
        .I3(S_AXI_ARADDR[5]),
        .O(\axi_rdata[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[17]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[17] ),
        .I1(axireg_pat_data[17]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[17]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[18]_i_1 
       (.I0(\axi_rdata[18]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[18]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[18] ),
        .I1(axireg_pat_data[18]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[18]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[18]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[19]_i_1 
       (.I0(\axi_rdata[19]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[19]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[19] ),
        .I1(axireg_pat_data[19]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[19]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFE200E2)) 
    \axi_rdata[1]_i_1 
       (.I0(\axi_rdata[1]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(\axi_rdata[1]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[3]),
        .I4(\axi_rdata[3]_i_4_n_0 ),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[1]_i_2 
       (.I0(data3[1]),
        .I1(axireg_sym_div[1]),
        .I2(S_AXI_ARADDR[1]),
        .I3(active_ff[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_src_sel[0]),
        .O(\axi_rdata[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \axi_rdata[1]_i_3 
       (.I0(data6[1]),
        .I1(\sym_cnt_ff2_reg_n_0_[1] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_pat_data[1]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[1]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \axi_rdata[20]_i_1 
       (.I0(S_AXI_ARADDR[3]),
        .I1(\axi_rdata[20]_i_2_n_0 ),
        .I2(S_AXI_ARADDR[4]),
        .I3(S_AXI_ARADDR[5]),
        .O(\axi_rdata[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[20]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[20] ),
        .I1(axireg_pat_data[20]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[20]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[21]_i_1 
       (.I0(\axi_rdata[21]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[21]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[21] ),
        .I1(axireg_pat_data[21]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[21]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[21]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \axi_rdata[22]_i_1 
       (.I0(S_AXI_ARADDR[3]),
        .I1(\axi_rdata[22]_i_2_n_0 ),
        .I2(S_AXI_ARADDR[4]),
        .I3(S_AXI_ARADDR[5]),
        .O(\axi_rdata[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[22]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[22] ),
        .I1(axireg_pat_data[22]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[22]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[23]_i_1 
       (.I0(\axi_rdata[23]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[23]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[23] ),
        .I1(axireg_pat_data[23]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[23]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \axi_rdata[24]_i_1 
       (.I0(S_AXI_ARADDR[3]),
        .I1(\axi_rdata[24]_i_2_n_0 ),
        .I2(S_AXI_ARADDR[4]),
        .I3(S_AXI_ARADDR[5]),
        .O(\axi_rdata[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[24]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[24] ),
        .I1(axireg_pat_data[24]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[24]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[25]_i_1 
       (.I0(\axi_rdata[25]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[25]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[25] ),
        .I1(axireg_pat_data[25]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[25]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[26]_i_1 
       (.I0(\axi_rdata[26]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[26]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[26] ),
        .I1(axireg_pat_data[26]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[26]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[26]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[27]_i_1 
       (.I0(\axi_rdata[27]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[27]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[27] ),
        .I1(axireg_pat_data[27]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[27]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[28]_i_1 
       (.I0(\axi_rdata[28]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[28]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[28] ),
        .I1(axireg_pat_data[28]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[28]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[28]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \axi_rdata[29]_i_1 
       (.I0(S_AXI_ARADDR[3]),
        .I1(\axi_rdata[29]_i_2_n_0 ),
        .I2(S_AXI_ARADDR[4]),
        .I3(S_AXI_ARADDR[5]),
        .O(\axi_rdata[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[29]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[29] ),
        .I1(axireg_pat_data[29]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[29]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFE200E2)) 
    \axi_rdata[2]_i_1 
       (.I0(\axi_rdata[2]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(\axi_rdata[2]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[3]),
        .I4(\axi_rdata[3]_i_4_n_0 ),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \axi_rdata[2]_i_2 
       (.I0(data3[2]),
        .I1(axireg_sym_div[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_src_sel[1]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \axi_rdata[2]_i_3 
       (.I0(data6[2]),
        .I1(\sym_cnt_ff2_reg_n_0_[2] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_pat_data[2]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[30]_i_1 
       (.I0(\axi_rdata[30]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[30]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[30] ),
        .I1(axireg_pat_data[30]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[30]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[31]_i_1 
       (.I0(\axi_rdata[31]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0F000000A0C0A0C0)) 
    \axi_rdata[31]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[31] ),
        .I1(axireg_pat_data[31]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data3[31]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[31]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \axi_rdata[31]_i_3 
       (.I0(S_AXI_ARADDR[5]),
        .I1(S_AXI_ARADDR[4]),
        .O(\axi_rdata[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFE200E2)) 
    \axi_rdata[3]_i_1 
       (.I0(\axi_rdata[3]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(\axi_rdata[3]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[3]),
        .I4(\axi_rdata[3]_i_4_n_0 ),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \axi_rdata[3]_i_2 
       (.I0(data3[3]),
        .I1(axireg_sym_div[3]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_ch_sel),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \axi_rdata[3]_i_3 
       (.I0(data6[3]),
        .I1(\sym_cnt_ff2_reg_n_0_[3] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_pat_data[3]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \axi_rdata[3]_i_4 
       (.I0(S_AXI_ARADDR[0]),
        .I1(S_AXI_ARADDR[1]),
        .I2(S_AXI_ARADDR[2]),
        .O(\axi_rdata[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000004540)) 
    \axi_rdata[4]_i_1 
       (.I0(S_AXI_ARADDR[3]),
        .I1(\axi_rdata[4]_i_2_n_0 ),
        .I2(S_AXI_ARADDR[2]),
        .I3(\axi_rdata[4]_i_3_n_0 ),
        .I4(S_AXI_ARADDR[4]),
        .I5(S_AXI_ARADDR[5]),
        .O(\axi_rdata[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \axi_rdata[4]_i_2 
       (.I0(data6[4]),
        .I1(\sym_cnt_ff2_reg_n_0_[4] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_pat_data[4]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'hA808)) 
    \axi_rdata[4]_i_3 
       (.I0(S_AXI_ARADDR[1]),
        .I1(axireg_sym_div[4]),
        .I2(S_AXI_ARADDR[0]),
        .I3(data3[4]),
        .O(\axi_rdata[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[5]_i_1 
       (.I0(\axi_rdata[5]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \axi_rdata[5]_i_2 
       (.I0(\axi_rdata[5]_i_3_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_sym_div[5]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data3[5]),
        .O(\axi_rdata[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \axi_rdata[5]_i_3 
       (.I0(data6[5]),
        .I1(\sym_cnt_ff2_reg_n_0_[5] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_pat_data[5]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[6]_i_1 
       (.I0(\axi_rdata[6]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \axi_rdata[6]_i_2 
       (.I0(\axi_rdata[6]_i_3_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_sym_div[6]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data3[6]),
        .O(\axi_rdata[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \axi_rdata[6]_i_3 
       (.I0(data6[6]),
        .I1(\sym_cnt_ff2_reg_n_0_[6] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_pat_data[6]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[7]_i_1 
       (.I0(\axi_rdata[7]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \axi_rdata[7]_i_2 
       (.I0(\axi_rdata[7]_i_3_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_sym_div[7]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data3[7]),
        .O(\axi_rdata[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \axi_rdata[7]_i_3 
       (.I0(data6[7]),
        .I1(\sym_cnt_ff2_reg_n_0_[7] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_pat_data[7]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000004540)) 
    \axi_rdata[8]_i_1 
       (.I0(S_AXI_ARADDR[3]),
        .I1(\axi_rdata[8]_i_2_n_0 ),
        .I2(S_AXI_ARADDR[2]),
        .I3(\axi_rdata[8]_i_3_n_0 ),
        .I4(S_AXI_ARADDR[4]),
        .I5(S_AXI_ARADDR[5]),
        .O(\axi_rdata[8]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h00B8)) 
    \axi_rdata[8]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[8] ),
        .I1(S_AXI_ARADDR[1]),
        .I2(axireg_pat_data[8]),
        .I3(S_AXI_ARADDR[0]),
        .O(\axi_rdata[8]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hA808)) 
    \axi_rdata[8]_i_3 
       (.I0(S_AXI_ARADDR[1]),
        .I1(axireg_sym_div[8]),
        .I2(S_AXI_ARADDR[0]),
        .I3(data3[8]),
        .O(\axi_rdata[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEE2)) 
    \axi_rdata[9]_i_1 
       (.I0(\axi_rdata[9]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\axi_rdata[31]_i_3_n_0 ),
        .O(\axi_rdata[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00B8FFFF00B80000)) 
    \axi_rdata[9]_i_2 
       (.I0(\sym_cnt_ff2_reg_n_0_[9] ),
        .I1(S_AXI_ARADDR[1]),
        .I2(axireg_pat_data[9]),
        .I3(S_AXI_ARADDR[0]),
        .I4(S_AXI_ARADDR[2]),
        .I5(\axi_rdata[9]_i_3_n_0 ),
        .O(\axi_rdata[9]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hA808)) 
    \axi_rdata[9]_i_3 
       (.I0(S_AXI_ARADDR[1]),
        .I1(axireg_sym_div[9]),
        .I2(S_AXI_ARADDR[0]),
        .I3(data3[9]),
        .O(\axi_rdata[9]_i_3_n_0 ));
  FDRE \axi_rdata_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[0]_i_1_n_0 ),
        .Q(S_AXI_RDATA[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[10]_i_1_n_0 ),
        .Q(S_AXI_RDATA[10]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[11]_i_1_n_0 ),
        .Q(S_AXI_RDATA[11]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[12]_i_1_n_0 ),
        .Q(S_AXI_RDATA[12]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[13]_i_1_n_0 ),
        .Q(S_AXI_RDATA[13]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[14]_i_1_n_0 ),
        .Q(S_AXI_RDATA[14]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[15]_i_1_n_0 ),
        .Q(S_AXI_RDATA[15]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[16]_i_1_n_0 ),
        .Q(S_AXI_RDATA[16]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[17]_i_1_n_0 ),
        .Q(S_AXI_RDATA[17]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[18]_i_1_n_0 ),
        .Q(S_AXI_RDATA[18]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[19]_i_1_n_0 ),
        .Q(S_AXI_RDATA[19]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[1]_i_1_n_0 ),
        .Q(S_AXI_RDATA[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[20]_i_1_n_0 ),
        .Q(S_AXI_RDATA[20]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[21]_i_1_n_0 ),
        .Q(S_AXI_RDATA[21]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[22]_i_1_n_0 ),
        .Q(S_AXI_RDATA[22]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[23]_i_1_n_0 ),
        .Q(S_AXI_RDATA[23]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[24]_i_1_n_0 ),
        .Q(S_AXI_RDATA[24]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[25]_i_1_n_0 ),
        .Q(S_AXI_RDATA[25]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[26]_i_1_n_0 ),
        .Q(S_AXI_RDATA[26]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[27]_i_1_n_0 ),
        .Q(S_AXI_RDATA[27]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[28]_i_1_n_0 ),
        .Q(S_AXI_RDATA[28]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[29]_i_1_n_0 ),
        .Q(S_AXI_RDATA[29]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[2]_i_1_n_0 ),
        .Q(S_AXI_RDATA[2]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[30]_i_1_n_0 ),
        .Q(S_AXI_RDATA[30]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[31]_i_1_n_0 ),
        .Q(S_AXI_RDATA[31]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[3]_i_1_n_0 ),
        .Q(S_AXI_RDATA[3]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[4]_i_1_n_0 ),
        .Q(S_AXI_RDATA[4]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[5]_i_1_n_0 ),
        .Q(S_AXI_RDATA[5]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[6]_i_1_n_0 ),
        .Q(S_AXI_RDATA[6]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[7]_i_1_n_0 ),
        .Q(S_AXI_RDATA[7]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[8]_i_1_n_0 ),
        .Q(S_AXI_RDATA[8]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_rdata_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[9]_i_1_n_0 ),
        .Q(S_AXI_RDATA[9]),
        .R(axi_awready_i_1_n_0));
  LUT5 #(
    .INIT(32'h00AA2020)) 
    axi_rvalid_i_1
       (.I0(S_AXI_ARESETN),
        .I1(S_AXI_ARREADY),
        .I2(S_AXI_ARVALID),
        .I3(S_AXI_RREADY),
        .I4(S_AXI_RVALID),
        .O(axi_rvalid_i_1_n_0));
  FDRE axi_rvalid_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axi_rvalid_i_1_n_0),
        .Q(S_AXI_RVALID),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    axi_wready_i_1
       (.I0(S_AXI_WVALID),
        .I1(w_done_reg_n_0),
        .O(axi_wready0));
  FDRE axi_wready_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axi_wready0),
        .Q(S_AXI_WREADY),
        .R(axi_awready_i_1_n_0));
  FDRE axireg_ch_sel_reg
       (.C(S_AXI_ACLK),
        .CE(axireg_enable_1),
        .D(\w_data_reg_n_0_[3] ),
        .Q(axireg_ch_sel),
        .R(axi_awready_i_1_n_0));
  FDRE axireg_enable_reg
       (.C(S_AXI_ACLK),
        .CE(axireg_enable_1),
        .D(\w_data_reg_n_0_[0] ),
        .Q(axireg_enable),
        .R(axi_awready_i_1_n_0));
  LUT5 #(
    .INIT(32'h08000000)) 
    \axireg_i_neg[15]_i_1 
       (.I0(p_0_in[0]),
        .I1(p_0_in[1]),
        .I2(p_0_in[2]),
        .I3(\axireg_i_pos[15]_i_2_n_0 ),
        .I4(p_1_in0),
        .O(\axireg_i_neg[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h08000000)) 
    \axireg_i_neg[7]_i_1 
       (.I0(p_0_in[0]),
        .I1(p_0_in[1]),
        .I2(p_0_in[2]),
        .I3(\axireg_i_pos[15]_i_2_n_0 ),
        .I4(p_1_in_0),
        .O(\axireg_i_neg[7]_i_1_n_0 ));
  FDSE \axireg_i_neg_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[0] ),
        .Q(data3[0]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[10] ),
        .Q(data3[10]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[11] ),
        .Q(data3[11]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[12] ),
        .Q(data3[12]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[13] ),
        .Q(data3[13]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[14] ),
        .Q(data3[14]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_i_neg_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[15] ),
        .Q(data3[15]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[7]_i_1_n_0 ),
        .D(p_1_in[0]),
        .Q(data3[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[7]_i_1_n_0 ),
        .D(p_1_in[1]),
        .Q(data3[2]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[3] ),
        .Q(data3[3]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[4] ),
        .Q(data3[4]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[5] ),
        .Q(data3[5]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[6] ),
        .Q(data3[6]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[7] ),
        .Q(data3[7]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[8] ),
        .Q(data3[8]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_i_neg_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_neg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[9] ),
        .Q(data3[9]),
        .R(axi_awready_i_1_n_0));
  LUT5 #(
    .INIT(32'h08000000)) 
    \axireg_i_pos[15]_i_1 
       (.I0(p_0_in[0]),
        .I1(p_0_in[1]),
        .I2(p_0_in[2]),
        .I3(\axireg_i_pos[15]_i_2_n_0 ),
        .I4(\w_strb_reg_n_0_[3] ),
        .O(\axireg_i_pos[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000001000)) 
    \axireg_i_pos[15]_i_2 
       (.I0(\aw_addr_reg_n_0_[7] ),
        .I1(axi_bvalid_reg_0),
        .I2(aw_done),
        .I3(w_done_reg_n_0),
        .I4(\aw_addr_reg_n_0_[6] ),
        .I5(\aw_addr_reg_n_0_[5] ),
        .O(\axireg_i_pos[15]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h08000000)) 
    \axireg_i_pos[7]_i_1 
       (.I0(p_0_in[0]),
        .I1(p_0_in[1]),
        .I2(p_0_in[2]),
        .I3(\axireg_i_pos[15]_i_2_n_0 ),
        .I4(\w_strb_reg_n_0_[2] ),
        .O(\axireg_i_pos[7]_i_1_n_0 ));
  FDSE \axireg_i_pos_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[7]_i_1_n_0 ),
        .D(p_2_in[0]),
        .Q(data3[16]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[15]_i_1_n_0 ),
        .D(p_2_in[10]),
        .Q(data3[26]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[15]_i_1_n_0 ),
        .D(p_2_in[11]),
        .Q(data3[27]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[15]_i_1_n_0 ),
        .D(p_2_in[12]),
        .Q(data3[28]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[15]_i_1_n_0 ),
        .D(p_2_in[13]),
        .Q(data3[29]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[15]_i_1_n_0 ),
        .D(p_2_in[14]),
        .Q(data3[30]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_i_pos_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[15]_i_1_n_0 ),
        .D(p_2_in[15]),
        .Q(data3[31]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[7]_i_1_n_0 ),
        .D(p_2_in[1]),
        .Q(data3[17]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[7]_i_1_n_0 ),
        .D(p_2_in[2]),
        .Q(data3[18]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[7]_i_1_n_0 ),
        .D(p_2_in[3]),
        .Q(data3[19]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[7]_i_1_n_0 ),
        .D(p_2_in[4]),
        .Q(data3[20]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[7]_i_1_n_0 ),
        .D(p_2_in[5]),
        .Q(data3[21]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[7]_i_1_n_0 ),
        .D(p_2_in[6]),
        .Q(data3[22]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[7]_i_1_n_0 ),
        .D(p_2_in[7]),
        .Q(data3[23]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[15]_i_1_n_0 ),
        .D(p_2_in[8]),
        .Q(data3[24]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_i_pos_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_i_pos[15]_i_1_n_0 ),
        .D(p_2_in[9]),
        .Q(data3[25]),
        .S(axi_awready_i_1_n_0));
  LUT4 #(
    .INIT(16'h0800)) 
    \axireg_pat_data[15]_i_1 
       (.I0(p_0_in[2]),
        .I1(\axireg_src_sel[1]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(p_1_in0),
        .O(\axireg_pat_data[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \axireg_pat_data[23]_i_1 
       (.I0(p_0_in[2]),
        .I1(\axireg_src_sel[1]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(\w_strb_reg_n_0_[2] ),
        .O(\axireg_pat_data[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \axireg_pat_data[31]_i_1 
       (.I0(p_0_in[2]),
        .I1(\axireg_src_sel[1]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(\w_strb_reg_n_0_[3] ),
        .O(\axireg_pat_data[31]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \axireg_pat_data[7]_i_1 
       (.I0(p_0_in[2]),
        .I1(\axireg_src_sel[1]_i_2_n_0 ),
        .I2(p_0_in[1]),
        .I3(p_1_in_0),
        .O(\axireg_pat_data[7]_i_1_n_0 ));
  FDRE \axireg_pat_data_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[0] ),
        .Q(axireg_pat_data[0]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[10] ),
        .Q(axireg_pat_data[10]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[11] ),
        .Q(axireg_pat_data[11]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[12] ),
        .Q(axireg_pat_data[12]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[13] ),
        .Q(axireg_pat_data[13]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[14] ),
        .Q(axireg_pat_data[14]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[15] ),
        .Q(axireg_pat_data[15]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[23]_i_1_n_0 ),
        .D(p_2_in[0]),
        .Q(axireg_pat_data[16]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[23]_i_1_n_0 ),
        .D(p_2_in[1]),
        .Q(axireg_pat_data[17]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[23]_i_1_n_0 ),
        .D(p_2_in[2]),
        .Q(axireg_pat_data[18]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[23]_i_1_n_0 ),
        .D(p_2_in[3]),
        .Q(axireg_pat_data[19]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[7]_i_1_n_0 ),
        .D(p_1_in[0]),
        .Q(axireg_pat_data[1]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[23]_i_1_n_0 ),
        .D(p_2_in[4]),
        .Q(axireg_pat_data[20]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[23]_i_1_n_0 ),
        .D(p_2_in[5]),
        .Q(axireg_pat_data[21]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[23]_i_1_n_0 ),
        .D(p_2_in[6]),
        .Q(axireg_pat_data[22]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[23]_i_1_n_0 ),
        .D(p_2_in[7]),
        .Q(axireg_pat_data[23]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[31]_i_1_n_0 ),
        .D(p_2_in[8]),
        .Q(axireg_pat_data[24]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[31]_i_1_n_0 ),
        .D(p_2_in[9]),
        .Q(axireg_pat_data[25]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[31]_i_1_n_0 ),
        .D(p_2_in[10]),
        .Q(axireg_pat_data[26]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[31]_i_1_n_0 ),
        .D(p_2_in[11]),
        .Q(axireg_pat_data[27]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[31]_i_1_n_0 ),
        .D(p_2_in[12]),
        .Q(axireg_pat_data[28]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[31]_i_1_n_0 ),
        .D(p_2_in[13]),
        .Q(axireg_pat_data[29]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[7]_i_1_n_0 ),
        .D(p_1_in[1]),
        .Q(axireg_pat_data[2]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[31]_i_1_n_0 ),
        .D(p_2_in[14]),
        .Q(axireg_pat_data[30]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[31]_i_1_n_0 ),
        .D(p_2_in[15]),
        .Q(axireg_pat_data[31]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[3] ),
        .Q(axireg_pat_data[3]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[4] ),
        .Q(axireg_pat_data[4]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[5] ),
        .Q(axireg_pat_data[5]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[6] ),
        .Q(axireg_pat_data[6]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[7] ),
        .Q(axireg_pat_data[7]),
        .S(axi_awready_i_1_n_0));
  FDSE \axireg_pat_data_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[8] ),
        .Q(axireg_pat_data[8]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_pat_data_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_pat_data[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[9] ),
        .Q(axireg_pat_data[9]),
        .R(axi_awready_i_1_n_0));
  LUT4 #(
    .INIT(16'h0400)) 
    \axireg_src_sel[1]_i_1 
       (.I0(p_0_in[2]),
        .I1(p_1_in_0),
        .I2(p_0_in[1]),
        .I3(\axireg_src_sel[1]_i_2_n_0 ),
        .O(axireg_enable_1));
  LUT5 #(
    .INIT(32'h00000010)) 
    \axireg_src_sel[1]_i_2 
       (.I0(\aw_addr_reg_n_0_[5] ),
        .I1(\aw_addr_reg_n_0_[6] ),
        .I2(do_write),
        .I3(\aw_addr_reg_n_0_[7] ),
        .I4(p_0_in[0]),
        .O(\axireg_src_sel[1]_i_2_n_0 ));
  FDRE \axireg_src_sel_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(axireg_enable_1),
        .D(p_1_in[0]),
        .Q(axireg_src_sel[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_src_sel_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(axireg_enable_1),
        .D(p_1_in[1]),
        .Q(axireg_src_sel[1]),
        .R(axi_awready_i_1_n_0));
  LUT4 #(
    .INIT(16'h0800)) 
    \axireg_sym_div[15]_i_1 
       (.I0(p_1_in0),
        .I1(p_0_in[1]),
        .I2(p_0_in[2]),
        .I3(\axireg_src_sel[1]_i_2_n_0 ),
        .O(\axireg_sym_div[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \axireg_sym_div[7]_i_1 
       (.I0(p_1_in_0),
        .I1(p_0_in[1]),
        .I2(p_0_in[2]),
        .I3(\axireg_src_sel[1]_i_2_n_0 ),
        .O(\axireg_sym_div[7]_i_1_n_0 ));
  FDRE \axireg_sym_div_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[0] ),
        .Q(axireg_sym_div[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[10] ),
        .Q(axireg_sym_div[10]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[11] ),
        .Q(axireg_sym_div[11]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[12] ),
        .Q(axireg_sym_div[12]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[13] ),
        .Q(axireg_sym_div[13]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[14] ),
        .Q(axireg_sym_div[14]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[15] ),
        .Q(axireg_sym_div[15]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[7]_i_1_n_0 ),
        .D(p_1_in[0]),
        .Q(axireg_sym_div[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[7]_i_1_n_0 ),
        .D(p_1_in[1]),
        .Q(axireg_sym_div[2]),
        .R(axi_awready_i_1_n_0));
  FDSE \axireg_sym_div_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[3] ),
        .Q(axireg_sym_div[3]),
        .S(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[4] ),
        .Q(axireg_sym_div[4]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[5] ),
        .Q(axireg_sym_div[5]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[6] ),
        .Q(axireg_sym_div[6]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[7] ),
        .Q(axireg_sym_div[7]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[8] ),
        .Q(axireg_sym_div[8]),
        .R(axi_awready_i_1_n_0));
  FDRE \axireg_sym_div_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_sym_div[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[9] ),
        .Q(axireg_sym_div[9]),
        .R(axi_awready_i_1_n_0));
  FDCE core_ch_sel_reg
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_ch_sel),
        .Q(core_ch_sel));
  FDCE core_enable_reg
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_enable),
        .Q(core_enable));
  FDPE \core_i_neg_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_neg[0]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_neg[0]));
  FDCE \core_i_neg_reg[10] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[10]),
        .Q(core_i_neg[10]));
  FDCE \core_i_neg_reg[11] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[11]),
        .Q(core_i_neg[11]));
  FDCE \core_i_neg_reg[12] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[12]),
        .Q(core_i_neg[12]));
  FDCE \core_i_neg_reg[13] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[13]),
        .Q(core_i_neg[13]));
  FDCE \core_i_neg_reg[14] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[14]),
        .Q(core_i_neg[14]));
  FDPE \core_i_neg_reg[15] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_neg[15]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_neg[15]));
  FDCE \core_i_neg_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[1]),
        .Q(core_i_neg[1]));
  FDCE \core_i_neg_reg[2] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[2]),
        .Q(core_i_neg[2]));
  FDCE \core_i_neg_reg[3] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[3]),
        .Q(core_i_neg[3]));
  FDCE \core_i_neg_reg[4] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[4]),
        .Q(core_i_neg[4]));
  FDCE \core_i_neg_reg[5] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[5]),
        .Q(core_i_neg[5]));
  FDCE \core_i_neg_reg[6] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[6]),
        .Q(core_i_neg[6]));
  FDCE \core_i_neg_reg[7] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[7]),
        .Q(core_i_neg[7]));
  FDCE \core_i_neg_reg[8] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[8]),
        .Q(core_i_neg[8]));
  FDCE \core_i_neg_reg[9] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_neg[9]),
        .Q(core_i_neg[9]));
  FDPE \core_i_pos_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[0]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[0]));
  FDPE \core_i_pos_reg[10] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[10]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[10]));
  FDPE \core_i_pos_reg[11] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[11]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[11]));
  FDPE \core_i_pos_reg[12] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[12]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[12]));
  FDPE \core_i_pos_reg[13] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[13]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[13]));
  FDPE \core_i_pos_reg[14] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[14]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[14]));
  FDCE \core_i_pos_reg[15] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_i_pos[15]),
        .Q(core_i_pos[15]));
  FDPE \core_i_pos_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[1]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[1]));
  FDPE \core_i_pos_reg[2] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[2]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[2]));
  FDPE \core_i_pos_reg[3] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[3]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[3]));
  FDPE \core_i_pos_reg[4] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[4]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[4]));
  FDPE \core_i_pos_reg[5] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[5]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[5]));
  FDPE \core_i_pos_reg[6] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[6]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[6]));
  FDPE \core_i_pos_reg[7] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[7]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[7]));
  FDPE \core_i_pos_reg[8] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[8]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[8]));
  FDPE \core_i_pos_reg[9] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_i_pos[9]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_i_pos[9]));
  FDCE \core_pat_data_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[0]),
        .Q(core_pat_data[0]));
  FDPE \core_pat_data_reg[10] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[10]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[10]));
  FDCE \core_pat_data_reg[11] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[11]),
        .Q(core_pat_data[11]));
  FDPE \core_pat_data_reg[12] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[12]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[12]));
  FDCE \core_pat_data_reg[13] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[13]),
        .Q(core_pat_data[13]));
  FDPE \core_pat_data_reg[14] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[14]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[14]));
  FDCE \core_pat_data_reg[15] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[15]),
        .Q(core_pat_data[15]));
  FDCE \core_pat_data_reg[16] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[16]),
        .Q(core_pat_data[16]));
  FDPE \core_pat_data_reg[17] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[17]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[17]));
  FDCE \core_pat_data_reg[18] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[18]),
        .Q(core_pat_data[18]));
  FDPE \core_pat_data_reg[19] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[19]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[19]));
  FDPE \core_pat_data_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[1]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[1]));
  FDCE \core_pat_data_reg[20] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[20]),
        .Q(core_pat_data[20]));
  FDPE \core_pat_data_reg[21] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[21]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[21]));
  FDCE \core_pat_data_reg[22] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[22]),
        .Q(core_pat_data[22]));
  FDPE \core_pat_data_reg[23] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[23]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[23]));
  FDPE \core_pat_data_reg[24] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[24]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[24]));
  FDCE \core_pat_data_reg[25] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[25]),
        .Q(core_pat_data[25]));
  FDPE \core_pat_data_reg[26] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[26]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[26]));
  FDCE \core_pat_data_reg[27] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[27]),
        .Q(core_pat_data[27]));
  FDPE \core_pat_data_reg[28] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[28]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[28]));
  FDCE \core_pat_data_reg[29] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[29]),
        .Q(core_pat_data[29]));
  FDCE \core_pat_data_reg[2] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[2]),
        .Q(core_pat_data[2]));
  FDPE \core_pat_data_reg[30] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[30]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[30]));
  FDCE \core_pat_data_reg[31] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[31]),
        .Q(core_pat_data[31]));
  FDPE \core_pat_data_reg[3] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[3]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[3]));
  FDCE \core_pat_data_reg[4] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[4]),
        .Q(core_pat_data[4]));
  FDPE \core_pat_data_reg[5] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[5]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[5]));
  FDCE \core_pat_data_reg[6] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[6]),
        .Q(core_pat_data[6]));
  FDPE \core_pat_data_reg[7] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[7]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[7]));
  FDPE \core_pat_data_reg[8] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_pat_data[8]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_pat_data[8]));
  FDCE \core_pat_data_reg[9] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_pat_data[9]),
        .Q(core_pat_data[9]));
  FDCE \core_src_sel_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_src_sel[0]),
        .Q(core_src_sel[0]));
  FDCE \core_src_sel_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_src_sel[1]),
        .Q(core_src_sel[1]));
  FDCE \core_sym_div_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[0]),
        .Q(core_sym_div[0]));
  FDCE \core_sym_div_reg[10] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[10]),
        .Q(core_sym_div[10]));
  FDCE \core_sym_div_reg[11] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[11]),
        .Q(core_sym_div[11]));
  FDCE \core_sym_div_reg[12] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[12]),
        .Q(core_sym_div[12]));
  FDCE \core_sym_div_reg[13] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[13]),
        .Q(core_sym_div[13]));
  FDCE \core_sym_div_reg[14] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[14]),
        .Q(core_sym_div[14]));
  FDCE \core_sym_div_reg[15] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[15]),
        .Q(core_sym_div[15]));
  FDCE \core_sym_div_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[1]),
        .Q(core_sym_div[1]));
  FDCE \core_sym_div_reg[2] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[2]),
        .Q(core_sym_div[2]));
  FDPE \core_sym_div_reg[3] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_sym_div[3]),
        .PRE(u_bpsk_core_n_0),
        .Q(core_sym_div[3]));
  FDCE \core_sym_div_reg[4] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[4]),
        .Q(core_sym_div[4]));
  FDCE \core_sym_div_reg[5] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[5]),
        .Q(core_sym_div[5]));
  FDCE \core_sym_div_reg[6] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[6]),
        .Q(core_sym_div[6]));
  FDCE \core_sym_div_reg[7] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[7]),
        .Q(core_sym_div[7]));
  FDCE \core_sym_div_reg[8] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[8]),
        .Q(core_sym_div[8]));
  FDCE \core_sym_div_reg[9] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(u_bpsk_core_n_0),
        .D(snap_sym_div[9]),
        .Q(core_sym_div[9]));
  FDRE snap_ch_sel_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_ch_sel),
        .Q(snap_ch_sel),
        .R(axi_awready_i_1_n_0));
  FDRE snap_enable_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_enable),
        .Q(snap_enable),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_i_neg_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[0]),
        .Q(snap_i_neg[0]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[10]),
        .Q(snap_i_neg[10]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[11]),
        .Q(snap_i_neg[11]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[12]),
        .Q(snap_i_neg[12]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[13]),
        .Q(snap_i_neg[13]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[14]),
        .Q(snap_i_neg[14]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_i_neg_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[15]),
        .Q(snap_i_neg[15]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[1]),
        .Q(snap_i_neg[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[2]),
        .Q(snap_i_neg[2]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[3]),
        .Q(snap_i_neg[3]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[4]),
        .Q(snap_i_neg[4]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[5]),
        .Q(snap_i_neg[5]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[6]),
        .Q(snap_i_neg[6]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[7]),
        .Q(snap_i_neg[7]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[8]),
        .Q(snap_i_neg[8]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_i_neg_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[9]),
        .Q(snap_i_neg[9]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[16]),
        .Q(snap_i_pos[0]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[26]),
        .Q(snap_i_pos[10]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[27]),
        .Q(snap_i_pos[11]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[28]),
        .Q(snap_i_pos[12]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[29]),
        .Q(snap_i_pos[13]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[30]),
        .Q(snap_i_pos[14]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_i_pos_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[31]),
        .Q(snap_i_pos[15]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[17]),
        .Q(snap_i_pos[1]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[18]),
        .Q(snap_i_pos[2]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[19]),
        .Q(snap_i_pos[3]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[20]),
        .Q(snap_i_pos[4]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[21]),
        .Q(snap_i_pos[5]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[22]),
        .Q(snap_i_pos[6]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[23]),
        .Q(snap_i_pos[7]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[24]),
        .Q(snap_i_pos[8]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_i_pos_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data3[25]),
        .Q(snap_i_pos[9]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[0]),
        .Q(snap_pat_data[0]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[10]),
        .Q(snap_pat_data[10]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[11]),
        .Q(snap_pat_data[11]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[12]),
        .Q(snap_pat_data[12]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[13]),
        .Q(snap_pat_data[13]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[14]),
        .Q(snap_pat_data[14]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[15]),
        .Q(snap_pat_data[15]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[16]),
        .Q(snap_pat_data[16]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[17]),
        .Q(snap_pat_data[17]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[18]),
        .Q(snap_pat_data[18]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[19]),
        .Q(snap_pat_data[19]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[1]),
        .Q(snap_pat_data[1]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[20]),
        .Q(snap_pat_data[20]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[21]),
        .Q(snap_pat_data[21]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[22]),
        .Q(snap_pat_data[22]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[23]),
        .Q(snap_pat_data[23]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[24]),
        .Q(snap_pat_data[24]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[25]),
        .Q(snap_pat_data[25]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[26]),
        .Q(snap_pat_data[26]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[27]),
        .Q(snap_pat_data[27]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[28]),
        .Q(snap_pat_data[28]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[29]),
        .Q(snap_pat_data[29]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[2]),
        .Q(snap_pat_data[2]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[30]),
        .Q(snap_pat_data[30]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[31]),
        .Q(snap_pat_data[31]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[3]),
        .Q(snap_pat_data[3]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[4]),
        .Q(snap_pat_data[4]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[5]),
        .Q(snap_pat_data[5]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[6]),
        .Q(snap_pat_data[6]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[7]),
        .Q(snap_pat_data[7]),
        .S(axi_awready_i_1_n_0));
  FDSE \snap_pat_data_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[8]),
        .Q(snap_pat_data[8]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_pat_data_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_pat_data[9]),
        .Q(snap_pat_data[9]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_src_sel_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_src_sel[0]),
        .Q(snap_src_sel[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_src_sel_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_src_sel[1]),
        .Q(snap_src_sel[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[0]),
        .Q(snap_sym_div[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[10]),
        .Q(snap_sym_div[10]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[11]),
        .Q(snap_sym_div[11]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[12]),
        .Q(snap_sym_div[12]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[13]),
        .Q(snap_sym_div[13]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[14]),
        .Q(snap_sym_div[14]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[15]),
        .Q(snap_sym_div[15]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[1]),
        .Q(snap_sym_div[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[2]),
        .Q(snap_sym_div[2]),
        .R(axi_awready_i_1_n_0));
  FDSE \snap_sym_div_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[3]),
        .Q(snap_sym_div[3]),
        .S(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[4]),
        .Q(snap_sym_div[4]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[5]),
        .Q(snap_sym_div[5]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[6]),
        .Q(snap_sym_div[6]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[7]),
        .Q(snap_sym_div[7]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[8]),
        .Q(snap_sym_div[8]),
        .R(axi_awready_i_1_n_0));
  FDRE \snap_sym_div_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_sym_div[9]),
        .Q(snap_sym_div[9]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[0]),
        .Q(sym_cnt_ff1[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[10]),
        .Q(sym_cnt_ff1[10]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[11]),
        .Q(sym_cnt_ff1[11]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[12]),
        .Q(sym_cnt_ff1[12]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[13]),
        .Q(sym_cnt_ff1[13]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[14]),
        .Q(sym_cnt_ff1[14]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[15]),
        .Q(sym_cnt_ff1[15]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[16]),
        .Q(sym_cnt_ff1[16]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[17]),
        .Q(sym_cnt_ff1[17]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[18]),
        .Q(sym_cnt_ff1[18]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[19]),
        .Q(sym_cnt_ff1[19]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[1]),
        .Q(sym_cnt_ff1[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[20]),
        .Q(sym_cnt_ff1[20]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[21]),
        .Q(sym_cnt_ff1[21]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[22]),
        .Q(sym_cnt_ff1[22]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[23]),
        .Q(sym_cnt_ff1[23]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[24]),
        .Q(sym_cnt_ff1[24]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[25]),
        .Q(sym_cnt_ff1[25]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[26]),
        .Q(sym_cnt_ff1[26]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[27]),
        .Q(sym_cnt_ff1[27]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[28]),
        .Q(sym_cnt_ff1[28]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[29]),
        .Q(sym_cnt_ff1[29]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[2]),
        .Q(sym_cnt_ff1[2]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[30]),
        .Q(sym_cnt_ff1[30]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[31]),
        .Q(sym_cnt_ff1[31]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[32] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[32]),
        .Q(sym_cnt_ff1[32]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[33] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[33]),
        .Q(sym_cnt_ff1[33]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[34] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[34]),
        .Q(sym_cnt_ff1[34]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[35] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[35]),
        .Q(sym_cnt_ff1[35]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[36] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[36]),
        .Q(sym_cnt_ff1[36]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[37] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[37]),
        .Q(sym_cnt_ff1[37]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[38] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[38]),
        .Q(sym_cnt_ff1[38]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[39] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[39]),
        .Q(sym_cnt_ff1[39]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[3]),
        .Q(sym_cnt_ff1[3]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[4]),
        .Q(sym_cnt_ff1[4]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[5]),
        .Q(sym_cnt_ff1[5]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[6]),
        .Q(sym_cnt_ff1[6]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[7]),
        .Q(sym_cnt_ff1[7]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[8]),
        .Q(sym_cnt_ff1[8]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff1_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_count_reg[9]),
        .Q(sym_cnt_ff1[9]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[0]),
        .Q(\sym_cnt_ff2_reg_n_0_[0] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[10]),
        .Q(\sym_cnt_ff2_reg_n_0_[10] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[11]),
        .Q(\sym_cnt_ff2_reg_n_0_[11] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[12]),
        .Q(\sym_cnt_ff2_reg_n_0_[12] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[13]),
        .Q(\sym_cnt_ff2_reg_n_0_[13] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[14]),
        .Q(\sym_cnt_ff2_reg_n_0_[14] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[15]),
        .Q(\sym_cnt_ff2_reg_n_0_[15] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[16]),
        .Q(\sym_cnt_ff2_reg_n_0_[16] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[17]),
        .Q(\sym_cnt_ff2_reg_n_0_[17] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[18]),
        .Q(\sym_cnt_ff2_reg_n_0_[18] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[19]),
        .Q(\sym_cnt_ff2_reg_n_0_[19] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[1]),
        .Q(\sym_cnt_ff2_reg_n_0_[1] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[20]),
        .Q(\sym_cnt_ff2_reg_n_0_[20] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[21]),
        .Q(\sym_cnt_ff2_reg_n_0_[21] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[22]),
        .Q(\sym_cnt_ff2_reg_n_0_[22] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[23]),
        .Q(\sym_cnt_ff2_reg_n_0_[23] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[24]),
        .Q(\sym_cnt_ff2_reg_n_0_[24] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[25]),
        .Q(\sym_cnt_ff2_reg_n_0_[25] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[26]),
        .Q(\sym_cnt_ff2_reg_n_0_[26] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[27]),
        .Q(\sym_cnt_ff2_reg_n_0_[27] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[28]),
        .Q(\sym_cnt_ff2_reg_n_0_[28] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[29]),
        .Q(\sym_cnt_ff2_reg_n_0_[29] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[2]),
        .Q(\sym_cnt_ff2_reg_n_0_[2] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[30]),
        .Q(\sym_cnt_ff2_reg_n_0_[30] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[31]),
        .Q(\sym_cnt_ff2_reg_n_0_[31] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[32] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[32]),
        .Q(data6[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[33] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[33]),
        .Q(data6[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[34] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[34]),
        .Q(data6[2]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[35] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[35]),
        .Q(data6[3]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[36] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[36]),
        .Q(data6[4]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[37] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[37]),
        .Q(data6[5]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[38] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[38]),
        .Q(data6[6]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[39] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[39]),
        .Q(data6[7]),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[3]),
        .Q(\sym_cnt_ff2_reg_n_0_[3] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[4]),
        .Q(\sym_cnt_ff2_reg_n_0_[4] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[5]),
        .Q(\sym_cnt_ff2_reg_n_0_[5] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[6]),
        .Q(\sym_cnt_ff2_reg_n_0_[6] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[7]),
        .Q(\sym_cnt_ff2_reg_n_0_[7] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[8]),
        .Q(\sym_cnt_ff2_reg_n_0_[8] ),
        .R(axi_awready_i_1_n_0));
  FDRE \sym_cnt_ff2_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(sym_cnt_ff1[9]),
        .Q(\sym_cnt_ff2_reg_n_0_[9] ),
        .R(axi_awready_i_1_n_0));
  system_bpsk_modulator_0_0_bpsk_core u_bpsk_core
       (.D(sym_count_reg),
        .M_AXIS_DAC_TDATA(M_AXIS_DAC_TDATA),
        .M_AXIS_DAC_TREADY(M_AXIS_DAC_TREADY),
        .M_AXIS_DAC_TVALID(M_AXIS_DAC_TVALID),
        .Q(core_sym_div),
        .SS(u_bpsk_core_n_0),
        .S_AXIS_BITS_TDATA(S_AXIS_BITS_TDATA),
        .S_AXIS_BITS_TREADY(S_AXIS_BITS_TREADY),
        .S_AXIS_BITS_TVALID(S_AXIS_BITS_TVALID),
        .S_AXIS_DMA_TDATA(S_AXIS_DMA_TDATA),
        .S_AXIS_DMA_TVALID(S_AXIS_DMA_TVALID),
        .aclk(aclk),
        .aresetn(aresetn),
        .axis_bit_reg_0(core_src_sel),
        .core_ch_sel(core_ch_sel),
        .core_enable(core_enable),
        .\i_hold_reg[15]_0 (core_i_pos),
        .\i_hold_reg[15]_1 (core_i_neg),
        .\i_hold_reg[15]_i_4_0 (core_pat_data));
  FDRE \w_data_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[0]),
        .Q(\w_data_reg_n_0_[0] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[10]),
        .Q(\w_data_reg_n_0_[10] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[11]),
        .Q(\w_data_reg_n_0_[11] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[12]),
        .Q(\w_data_reg_n_0_[12] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[13]),
        .Q(\w_data_reg_n_0_[13] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[14]),
        .Q(\w_data_reg_n_0_[14] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[15]),
        .Q(\w_data_reg_n_0_[15] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[16]),
        .Q(p_2_in[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[17]),
        .Q(p_2_in[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[18]),
        .Q(p_2_in[2]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[19]),
        .Q(p_2_in[3]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[1]),
        .Q(p_1_in[0]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[20]),
        .Q(p_2_in[4]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[21]),
        .Q(p_2_in[5]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[22]),
        .Q(p_2_in[6]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[23]),
        .Q(p_2_in[7]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[24]),
        .Q(p_2_in[8]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[25]),
        .Q(p_2_in[9]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[26]),
        .Q(p_2_in[10]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[27]),
        .Q(p_2_in[11]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[28]),
        .Q(p_2_in[12]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[29]),
        .Q(p_2_in[13]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[2]),
        .Q(p_1_in[1]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[30]),
        .Q(p_2_in[14]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[31]),
        .Q(p_2_in[15]),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[3]),
        .Q(\w_data_reg_n_0_[3] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[4]),
        .Q(\w_data_reg_n_0_[4] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[5]),
        .Q(\w_data_reg_n_0_[5] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[6]),
        .Q(\w_data_reg_n_0_[6] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[7]),
        .Q(\w_data_reg_n_0_[7] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[8]),
        .Q(\w_data_reg_n_0_[8] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_data_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[9]),
        .Q(\w_data_reg_n_0_[9] ),
        .R(axi_awready_i_1_n_0));
  LUT5 #(
    .INIT(32'h00E0E0E0)) 
    w_done_i_1
       (.I0(w_done_reg_n_0),
        .I1(S_AXI_WVALID),
        .I2(S_AXI_ARESETN),
        .I3(axi_bvalid_reg_0),
        .I4(S_AXI_BREADY),
        .O(w_done_i_1_n_0));
  FDRE w_done_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(w_done_i_1_n_0),
        .Q(w_done_reg_n_0),
        .R(1'b0));
  FDRE \w_strb_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WSTRB[0]),
        .Q(p_1_in_0),
        .R(axi_awready_i_1_n_0));
  FDRE \w_strb_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WSTRB[1]),
        .Q(p_1_in0),
        .R(axi_awready_i_1_n_0));
  FDRE \w_strb_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WSTRB[2]),
        .Q(\w_strb_reg_n_0_[2] ),
        .R(axi_awready_i_1_n_0));
  FDRE \w_strb_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WSTRB[3]),
        .Q(\w_strb_reg_n_0_[3] ),
        .R(axi_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h40)) 
    wr_pulse_axi_i_1
       (.I0(axi_bvalid_reg_0),
        .I1(aw_done),
        .I2(w_done_reg_n_0),
        .O(do_write));
  FDRE wr_pulse_axi_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(do_write),
        .Q(wr_pulse_axi),
        .R(1'b0));
  FDCE \wr_pulse_sync_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(u_bpsk_core_n_0),
        .D(wr_pulse_axi),
        .Q(\wr_pulse_sync_reg_n_0_[0] ));
  FDCE \wr_pulse_sync_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(u_bpsk_core_n_0),
        .D(\wr_pulse_sync_reg_n_0_[0] ),
        .Q(wr_pulse_core));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
