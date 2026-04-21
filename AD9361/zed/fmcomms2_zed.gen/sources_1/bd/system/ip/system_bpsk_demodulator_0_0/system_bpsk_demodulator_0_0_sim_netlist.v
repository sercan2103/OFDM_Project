// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Tue Apr 21 15:50:09 2026
// Host        : kemal-EXCALIBUR-G770 running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/kemal/Desktop/FMCOMM2andos/zed/fmcomms2_zed.gen/sources_1/bd/system/ip/system_bpsk_demodulator_0_0/system_bpsk_demodulator_0_0_sim_netlist.v
// Design      : system_bpsk_demodulator_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_bpsk_demodulator_0_0,bpsk_demod_v1_0,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "bpsk_demod_v1_0,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module system_bpsk_demodulator_0_0
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
    adc_data,
    adc_valid,
    M_AXIS_BITS_TDATA,
    M_AXIS_BITS_TVALID,
    M_AXIS_BITS_TREADY);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF M_AXIS_BITS, ASSOCIATED_RESET aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, INSERT_VIP 0" *) input aclk;
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
  input [63:0]adc_data;
  input adc_valid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_BITS TDATA" *) output [7:0]M_AXIS_BITS_TDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_BITS TVALID" *) output M_AXIS_BITS_TVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_BITS TREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_BITS, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, LAYERED_METADATA undef, INSERT_VIP 0" *) input M_AXIS_BITS_TREADY;

  wire \<const0> ;
  wire [7:0]M_AXIS_BITS_TDATA;
  wire M_AXIS_BITS_TREADY;
  wire M_AXIS_BITS_TVALID;
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
  wire [63:0]adc_data;
  wire adc_valid;
  wire aresetn;
  wire inst_n_0;
  wire inst_n_1;
  wire timing_int0_i_2_n_0;

  assign S_AXI_BRESP[1] = \<const0> ;
  assign S_AXI_BRESP[0] = \<const0> ;
  assign S_AXI_RRESP[1] = \<const0> ;
  assign S_AXI_RRESP[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  system_bpsk_demodulator_0_0_bpsk_demod_v1_0 inst
       (.E(inst_n_0),
        .M_AXIS_BITS_TDATA(M_AXIS_BITS_TDATA),
        .M_AXIS_BITS_TREADY(M_AXIS_BITS_TREADY),
        .M_AXIS_BITS_TVALID(M_AXIS_BITS_TVALID),
        .OPMODE(timing_int0_i_2_n_0),
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
        .S_AXI_WDATA(S_AXI_WDATA[19:0]),
        .S_AXI_WREADY(S_AXI_WREADY),
        .S_AXI_WSTRB(S_AXI_WSTRB[2:0]),
        .S_AXI_WVALID(S_AXI_WVALID),
        .aclk(aclk),
        .adc_data(adc_data[31:0]),
        .adc_valid(adc_valid),
        .aresetn(aresetn),
        .aresetn_0(inst_n_1),
        .axi_bvalid_reg_0(S_AXI_BVALID));
  FDCE timing_int0_i_2
       (.C(aclk),
        .CE(inst_n_0),
        .CLR(inst_n_1),
        .D(1'b1),
        .Q(timing_int0_i_2_n_0));
endmodule

(* ORIG_REF_NAME = "bpsk_demod_agc" *) 
module system_bpsk_demodulator_0_0_bpsk_demod_agc
   (Q,
    D,
    aresetn_0,
    core_bypass_costas_reg,
    \q_out_reg[15]_0 ,
    E,
    \i_out_reg[15]_0 ,
    out,
    adc_data,
    \gain_acc[11]_i_8_0 ,
    aclk,
    \gain_acc[11]_i_3_0 ,
    DI,
    \q_mix_reg[7] ,
    \q_mix_reg[11] ,
    \q_mix_reg[15] ,
    P,
    \q_mix_reg[15]_0 ,
    core_bypass_costas,
    p_1_out,
    adc_valid,
    core_enable,
    core_bypass_agc,
    aresetn,
    \i_mix_reg[3] ,
    \i_mix_reg[7] ,
    \i_mix_reg[11] ,
    \i_mix_reg[15] ,
    \i_mix_reg[15]_0 ,
    \i_mix_reg[15]_1 );
  output [15:0]Q;
  output [0:0]D;
  output aresetn_0;
  output [15:0]core_bypass_costas_reg;
  output [15:0]\q_out_reg[15]_0 ;
  output [0:0]E;
  output [15:0]\i_out_reg[15]_0 ;
  output [15:0]out;
  input [31:0]adc_data;
  input [15:0]\gain_acc[11]_i_8_0 ;
  input aclk;
  input [3:0]\gain_acc[11]_i_3_0 ;
  input [3:0]DI;
  input [3:0]\q_mix_reg[7] ;
  input [3:0]\q_mix_reg[11] ;
  input [2:0]\q_mix_reg[15] ;
  input [0:0]P;
  input [15:0]\q_mix_reg[15]_0 ;
  input core_bypass_costas;
  input [14:0]p_1_out;
  input adc_valid;
  input core_enable;
  input core_bypass_agc;
  input aresetn;
  input [3:0]\i_mix_reg[3] ;
  input [3:0]\i_mix_reg[7] ;
  input [3:0]\i_mix_reg[11] ;
  input [2:0]\i_mix_reg[15] ;
  input [15:0]\i_mix_reg[15]_0 ;
  input [15:0]\i_mix_reg[15]_1 ;

  wire [0:0]D;
  wire [3:0]DI;
  wire [0:0]E;
  wire [0:0]P;
  wire [15:0]Q;
  wire [16:16]aD2M4dsP;
  wire [15:1]abs_i0;
  wire [15:1]abs_q0;
  wire aclk;
  wire [31:0]adc_data;
  wire adc_valid;
  wire aresetn;
  wire aresetn_0;
  wire core_bypass_agc;
  wire core_bypass_costas;
  wire [15:0]core_bypass_costas_reg;
  wire core_enable;
  wire [15:1]err_abs0;
  wire [15:0]err_abs1;
  wire error_carry__0_i_10_n_0;
  wire error_carry__0_i_11_n_0;
  wire error_carry__0_i_12_n_0;
  wire error_carry__0_i_13_n_0;
  wire error_carry__0_i_14_n_0;
  wire error_carry__0_i_14_n_1;
  wire error_carry__0_i_14_n_2;
  wire error_carry__0_i_14_n_3;
  wire error_carry__0_i_15_n_0;
  wire error_carry__0_i_15_n_1;
  wire error_carry__0_i_15_n_2;
  wire error_carry__0_i_15_n_3;
  wire error_carry__0_i_16_n_0;
  wire error_carry__0_i_17_n_0;
  wire error_carry__0_i_18_n_0;
  wire error_carry__0_i_19_n_0;
  wire error_carry__0_i_1_n_0;
  wire error_carry__0_i_20_n_0;
  wire error_carry__0_i_21_n_0;
  wire error_carry__0_i_22_n_0;
  wire error_carry__0_i_23_n_0;
  wire error_carry__0_i_2_n_0;
  wire error_carry__0_i_3_n_0;
  wire error_carry__0_i_4_n_0;
  wire error_carry__0_i_5_n_0;
  wire error_carry__0_i_5_n_1;
  wire error_carry__0_i_5_n_2;
  wire error_carry__0_i_5_n_3;
  wire error_carry__0_i_5_n_4;
  wire error_carry__0_i_5_n_5;
  wire error_carry__0_i_5_n_6;
  wire error_carry__0_i_5_n_7;
  wire error_carry__0_i_6_n_0;
  wire error_carry__0_i_7_n_0;
  wire error_carry__0_i_8_n_0;
  wire error_carry__0_i_9_n_0;
  wire error_carry__0_n_0;
  wire error_carry__0_n_1;
  wire error_carry__0_n_2;
  wire error_carry__0_n_3;
  wire error_carry__1_i_10_n_0;
  wire error_carry__1_i_11_n_0;
  wire error_carry__1_i_12_n_0;
  wire error_carry__1_i_13_n_0;
  wire error_carry__1_i_14_n_0;
  wire error_carry__1_i_14_n_1;
  wire error_carry__1_i_14_n_2;
  wire error_carry__1_i_14_n_3;
  wire error_carry__1_i_15_n_0;
  wire error_carry__1_i_15_n_1;
  wire error_carry__1_i_15_n_2;
  wire error_carry__1_i_15_n_3;
  wire error_carry__1_i_16_n_0;
  wire error_carry__1_i_17_n_0;
  wire error_carry__1_i_18_n_0;
  wire error_carry__1_i_19_n_0;
  wire error_carry__1_i_1_n_0;
  wire error_carry__1_i_20_n_0;
  wire error_carry__1_i_21_n_0;
  wire error_carry__1_i_22_n_0;
  wire error_carry__1_i_23_n_0;
  wire error_carry__1_i_2_n_0;
  wire error_carry__1_i_3_n_0;
  wire error_carry__1_i_4_n_0;
  wire error_carry__1_i_5_n_0;
  wire error_carry__1_i_5_n_1;
  wire error_carry__1_i_5_n_2;
  wire error_carry__1_i_5_n_3;
  wire error_carry__1_i_5_n_4;
  wire error_carry__1_i_5_n_5;
  wire error_carry__1_i_5_n_6;
  wire error_carry__1_i_5_n_7;
  wire error_carry__1_i_6_n_0;
  wire error_carry__1_i_7_n_0;
  wire error_carry__1_i_8_n_0;
  wire error_carry__1_i_9_n_0;
  wire error_carry__1_n_0;
  wire error_carry__1_n_1;
  wire error_carry__1_n_2;
  wire error_carry__1_n_3;
  wire error_carry__2_i_10_n_0;
  wire error_carry__2_i_11_n_0;
  wire error_carry__2_i_12_n_0;
  wire error_carry__2_i_13_n_0;
  wire error_carry__2_i_14_n_2;
  wire error_carry__2_i_14_n_3;
  wire error_carry__2_i_15_n_2;
  wire error_carry__2_i_15_n_3;
  wire error_carry__2_i_16_n_0;
  wire error_carry__2_i_17_n_0;
  wire error_carry__2_i_18_n_0;
  wire error_carry__2_i_19_n_0;
  wire error_carry__2_i_1_n_0;
  wire error_carry__2_i_20_n_0;
  wire error_carry__2_i_21_n_0;
  wire error_carry__2_i_2_n_0;
  wire error_carry__2_i_3_n_0;
  wire error_carry__2_i_4_n_0;
  wire error_carry__2_i_5_n_0;
  wire error_carry__2_i_5_n_1;
  wire error_carry__2_i_5_n_2;
  wire error_carry__2_i_5_n_3;
  wire error_carry__2_i_5_n_4;
  wire error_carry__2_i_5_n_5;
  wire error_carry__2_i_5_n_6;
  wire error_carry__2_i_5_n_7;
  wire error_carry__2_i_6_n_0;
  wire error_carry__2_i_7_n_0;
  wire error_carry__2_i_8_n_0;
  wire error_carry__2_i_9_n_0;
  wire error_carry__2_n_0;
  wire error_carry__2_n_1;
  wire error_carry__2_n_2;
  wire error_carry__2_n_3;
  wire error_carry__3_n_2;
  wire error_carry_i_10_n_0;
  wire error_carry_i_11_n_0;
  wire error_carry_i_12_n_0;
  wire error_carry_i_13_n_0;
  wire error_carry_i_14_n_0;
  wire error_carry_i_14_n_1;
  wire error_carry_i_14_n_2;
  wire error_carry_i_14_n_3;
  wire error_carry_i_15_n_0;
  wire error_carry_i_15_n_1;
  wire error_carry_i_15_n_2;
  wire error_carry_i_15_n_3;
  wire error_carry_i_16_n_0;
  wire error_carry_i_17_n_0;
  wire error_carry_i_18_n_0;
  wire error_carry_i_19_n_0;
  wire error_carry_i_1_n_0;
  wire error_carry_i_20_n_0;
  wire error_carry_i_21_n_0;
  wire error_carry_i_22_n_0;
  wire error_carry_i_23_n_0;
  wire error_carry_i_24_n_0;
  wire error_carry_i_25_n_0;
  wire error_carry_i_2_n_0;
  wire error_carry_i_3_n_0;
  wire error_carry_i_4_n_0;
  wire error_carry_i_5_n_0;
  wire error_carry_i_5_n_1;
  wire error_carry_i_5_n_2;
  wire error_carry_i_5_n_3;
  wire error_carry_i_5_n_4;
  wire error_carry_i_5_n_5;
  wire error_carry_i_5_n_6;
  wire error_carry_i_5_n_7;
  wire error_carry_i_6_n_0;
  wire error_carry_i_7_n_0;
  wire error_carry_i_8_n_0;
  wire error_carry_n_0;
  wire error_carry_n_1;
  wire error_carry_n_2;
  wire error_carry_n_3;
  wire [17:0]error_s32;
  wire [30:0]gain_acc;
  wire gain_acc0;
  wire \gain_acc[11]_i_10_n_0 ;
  wire \gain_acc[11]_i_11_n_0 ;
  wire \gain_acc[11]_i_12_n_0 ;
  wire \gain_acc[11]_i_13_n_0 ;
  wire [3:0]\gain_acc[11]_i_3_0 ;
  wire \gain_acc[11]_i_3_n_0 ;
  wire \gain_acc[11]_i_4_n_0 ;
  wire \gain_acc[11]_i_5_n_0 ;
  wire \gain_acc[11]_i_6_n_0 ;
  wire \gain_acc[11]_i_7_n_0 ;
  wire [15:0]\gain_acc[11]_i_8_0 ;
  wire \gain_acc[11]_i_8_n_0 ;
  wire \gain_acc[11]_i_9_n_0 ;
  wire \gain_acc[15]_i_10_n_0 ;
  wire \gain_acc[15]_i_3_n_0 ;
  wire \gain_acc[15]_i_4_n_0 ;
  wire \gain_acc[15]_i_5_n_0 ;
  wire \gain_acc[15]_i_6_n_0 ;
  wire \gain_acc[15]_i_7_n_0 ;
  wire \gain_acc[15]_i_8_n_0 ;
  wire \gain_acc[15]_i_9_n_0 ;
  wire \gain_acc[19]_i_3_n_0 ;
  wire \gain_acc[19]_i_4_n_0 ;
  wire \gain_acc[19]_i_5_n_0 ;
  wire \gain_acc[19]_i_6_n_0 ;
  wire \gain_acc[19]_i_7_n_0 ;
  wire \gain_acc[23]_i_3_n_0 ;
  wire \gain_acc[23]_i_4_n_0 ;
  wire \gain_acc[23]_i_5_n_0 ;
  wire \gain_acc[23]_i_6_n_0 ;
  wire \gain_acc[27]_i_3_n_0 ;
  wire \gain_acc[27]_i_4_n_0 ;
  wire \gain_acc[27]_i_5_n_0 ;
  wire \gain_acc[27]_i_6_n_0 ;
  wire \gain_acc[30]_i_5_n_0 ;
  wire \gain_acc[30]_i_6_n_0 ;
  wire \gain_acc[30]_i_7_n_0 ;
  wire \gain_acc[3]_i_10_n_0 ;
  wire \gain_acc[3]_i_11_n_0 ;
  wire \gain_acc[3]_i_12_n_0 ;
  wire \gain_acc[3]_i_3_n_0 ;
  wire \gain_acc[3]_i_4_n_0 ;
  wire \gain_acc[3]_i_5_n_0 ;
  wire \gain_acc[3]_i_6_n_0 ;
  wire \gain_acc[3]_i_7_n_0 ;
  wire \gain_acc[3]_i_8_n_0 ;
  wire \gain_acc[3]_i_9_n_0 ;
  wire \gain_acc[7]_i_10_n_0 ;
  wire \gain_acc[7]_i_11_n_0 ;
  wire \gain_acc[7]_i_12_n_0 ;
  wire \gain_acc[7]_i_3_n_0 ;
  wire \gain_acc[7]_i_4_n_0 ;
  wire \gain_acc[7]_i_5_n_0 ;
  wire \gain_acc[7]_i_6_n_0 ;
  wire \gain_acc[7]_i_7_n_0 ;
  wire \gain_acc[7]_i_8_n_0 ;
  wire \gain_acc[7]_i_9_n_0 ;
  wire [30:0]gain_acc_next;
  wire [31:0]gain_acc_next1;
  wire \gain_acc_reg[11]_i_2_n_0 ;
  wire \gain_acc_reg[11]_i_2_n_1 ;
  wire \gain_acc_reg[11]_i_2_n_2 ;
  wire \gain_acc_reg[11]_i_2_n_3 ;
  wire \gain_acc_reg[15]_i_2_n_0 ;
  wire \gain_acc_reg[15]_i_2_n_1 ;
  wire \gain_acc_reg[15]_i_2_n_2 ;
  wire \gain_acc_reg[15]_i_2_n_3 ;
  wire \gain_acc_reg[19]_i_2_n_0 ;
  wire \gain_acc_reg[19]_i_2_n_1 ;
  wire \gain_acc_reg[19]_i_2_n_2 ;
  wire \gain_acc_reg[19]_i_2_n_3 ;
  wire \gain_acc_reg[23]_i_2_n_0 ;
  wire \gain_acc_reg[23]_i_2_n_1 ;
  wire \gain_acc_reg[23]_i_2_n_2 ;
  wire \gain_acc_reg[23]_i_2_n_3 ;
  wire \gain_acc_reg[27]_i_2_n_0 ;
  wire \gain_acc_reg[27]_i_2_n_1 ;
  wire \gain_acc_reg[27]_i_2_n_2 ;
  wire \gain_acc_reg[27]_i_2_n_3 ;
  wire \gain_acc_reg[30]_i_3_n_1 ;
  wire \gain_acc_reg[30]_i_3_n_2 ;
  wire \gain_acc_reg[30]_i_3_n_3 ;
  wire \gain_acc_reg[3]_i_2_n_0 ;
  wire \gain_acc_reg[3]_i_2_n_1 ;
  wire \gain_acc_reg[3]_i_2_n_2 ;
  wire \gain_acc_reg[3]_i_2_n_3 ;
  wire \gain_acc_reg[7]_i_2_n_0 ;
  wire \gain_acc_reg[7]_i_2_n_1 ;
  wire \gain_acc_reg[7]_i_2_n_2 ;
  wire \gain_acc_reg[7]_i_2_n_3 ;
  wire \i_mix[11]_i_6_n_0 ;
  wire \i_mix[11]_i_7_n_0 ;
  wire \i_mix[11]_i_8_n_0 ;
  wire \i_mix[11]_i_9_n_0 ;
  wire \i_mix[15]_i_5_n_0 ;
  wire \i_mix[15]_i_6_n_0 ;
  wire \i_mix[15]_i_7_n_0 ;
  wire \i_mix[15]_i_8_n_0 ;
  wire \i_mix[3]_i_6_n_0 ;
  wire \i_mix[3]_i_7_n_0 ;
  wire \i_mix[3]_i_8_n_0 ;
  wire \i_mix[3]_i_9_n_0 ;
  wire \i_mix[7]_i_6_n_0 ;
  wire \i_mix[7]_i_7_n_0 ;
  wire \i_mix[7]_i_8_n_0 ;
  wire \i_mix[7]_i_9_n_0 ;
  wire [3:0]\i_mix_reg[11] ;
  wire \i_mix_reg[11]_i_1_n_0 ;
  wire \i_mix_reg[11]_i_1_n_1 ;
  wire \i_mix_reg[11]_i_1_n_2 ;
  wire \i_mix_reg[11]_i_1_n_3 ;
  wire [2:0]\i_mix_reg[15] ;
  wire [15:0]\i_mix_reg[15]_0 ;
  wire [15:0]\i_mix_reg[15]_1 ;
  wire \i_mix_reg[15]_i_1_n_1 ;
  wire \i_mix_reg[15]_i_1_n_2 ;
  wire \i_mix_reg[15]_i_1_n_3 ;
  wire [3:0]\i_mix_reg[3] ;
  wire \i_mix_reg[3]_i_1_n_0 ;
  wire \i_mix_reg[3]_i_1_n_1 ;
  wire \i_mix_reg[3]_i_1_n_2 ;
  wire \i_mix_reg[3]_i_1_n_3 ;
  wire [3:0]\i_mix_reg[7] ;
  wire \i_mix_reg[7]_i_1_n_0 ;
  wire \i_mix_reg[7]_i_1_n_1 ;
  wire \i_mix_reg[7]_i_1_n_2 ;
  wire \i_mix_reg[7]_i_1_n_3 ;
  wire \i_out[0]_i_1_n_0 ;
  wire \i_out[10]_i_1_n_0 ;
  wire \i_out[11]_i_1_n_0 ;
  wire \i_out[12]_i_1_n_0 ;
  wire \i_out[13]_i_1_n_0 ;
  wire \i_out[14]_i_1_n_0 ;
  wire \i_out[14]_i_2_n_0 ;
  wire \i_out[15]_i_1_n_0 ;
  wire \i_out[1]_i_1_n_0 ;
  wire \i_out[2]_i_1_n_0 ;
  wire \i_out[3]_i_1_n_0 ;
  wire \i_out[4]_i_1_n_0 ;
  wire \i_out[5]_i_1_n_0 ;
  wire \i_out[6]_i_1_n_0 ;
  wire \i_out[7]_i_1_n_0 ;
  wire \i_out[8]_i_1_n_0 ;
  wire \i_out[9]_i_1_n_0 ;
  wire [15:0]\i_out_reg[15]_0 ;
  wire [0:0]i_scaled;
  wire in_range;
  wire in_range_carry__0_i_10_n_0;
  wire in_range_carry__0_i_11_n_0;
  wire in_range_carry__0_i_12_n_0;
  wire in_range_carry__0_i_13_n_0;
  wire in_range_carry__0_i_1_n_0;
  wire in_range_carry__0_i_2_n_0;
  wire in_range_carry__0_i_3_n_0;
  wire in_range_carry__0_i_4_n_0;
  wire in_range_carry__0_i_5_n_0;
  wire in_range_carry__0_i_6_n_0;
  wire in_range_carry__0_i_7_n_0;
  wire in_range_carry__0_i_8_n_0;
  wire in_range_carry__0_i_8_n_1;
  wire in_range_carry__0_i_8_n_2;
  wire in_range_carry__0_i_8_n_3;
  wire in_range_carry__0_i_9_n_2;
  wire in_range_carry__0_i_9_n_3;
  wire in_range_carry__0_n_1;
  wire in_range_carry__0_n_2;
  wire in_range_carry__0_n_3;
  wire in_range_carry_i_10_n_0;
  wire in_range_carry_i_10_n_1;
  wire in_range_carry_i_10_n_2;
  wire in_range_carry_i_10_n_3;
  wire in_range_carry_i_11_n_0;
  wire in_range_carry_i_12_n_0;
  wire in_range_carry_i_12_n_1;
  wire in_range_carry_i_12_n_2;
  wire in_range_carry_i_12_n_3;
  wire in_range_carry_i_13_n_0;
  wire in_range_carry_i_14_n_0;
  wire in_range_carry_i_15_n_0;
  wire in_range_carry_i_16_n_0;
  wire in_range_carry_i_1_n_0;
  wire in_range_carry_i_2_n_0;
  wire in_range_carry_i_3_n_0;
  wire in_range_carry_i_4_n_0;
  wire in_range_carry_i_5_n_0;
  wire in_range_carry_i_6_n_0;
  wire in_range_carry_i_7_n_0;
  wire in_range_carry_i_8_n_0;
  wire in_range_carry_i_9_n_0;
  wire in_range_carry_n_0;
  wire in_range_carry_n_1;
  wire in_range_carry_n_2;
  wire in_range_carry_n_3;
  wire [15:0]out;
  wire [4:0]p_0_in;
  wire [14:0]p_1_out;
  wire prod_i_n_100;
  wire prod_i_n_101;
  wire prod_i_n_102;
  wire prod_i_n_103;
  wire prod_i_n_104;
  wire prod_i_n_105;
  wire prod_i_n_70;
  wire prod_i_n_71;
  wire prod_i_n_72;
  wire prod_i_n_73;
  wire prod_i_n_79;
  wire prod_i_n_80;
  wire prod_i_n_81;
  wire prod_i_n_82;
  wire prod_i_n_83;
  wire prod_i_n_84;
  wire prod_i_n_85;
  wire prod_i_n_86;
  wire prod_i_n_87;
  wire prod_i_n_88;
  wire prod_i_n_89;
  wire prod_i_n_90;
  wire prod_i_n_91;
  wire prod_i_n_92;
  wire prod_i_n_93;
  wire prod_i_n_94;
  wire prod_i_n_95;
  wire prod_i_n_96;
  wire prod_i_n_97;
  wire prod_i_n_98;
  wire prod_i_n_99;
  wire prod_q_n_100;
  wire prod_q_n_101;
  wire prod_q_n_102;
  wire prod_q_n_103;
  wire prod_q_n_104;
  wire prod_q_n_105;
  wire prod_q_n_70;
  wire prod_q_n_71;
  wire prod_q_n_72;
  wire prod_q_n_73;
  wire prod_q_n_74;
  wire prod_q_n_75;
  wire prod_q_n_76;
  wire prod_q_n_77;
  wire prod_q_n_78;
  wire prod_q_n_79;
  wire prod_q_n_80;
  wire prod_q_n_81;
  wire prod_q_n_82;
  wire prod_q_n_83;
  wire prod_q_n_84;
  wire prod_q_n_85;
  wire prod_q_n_86;
  wire prod_q_n_87;
  wire prod_q_n_88;
  wire prod_q_n_89;
  wire prod_q_n_90;
  wire prod_q_n_91;
  wire prod_q_n_92;
  wire prod_q_n_93;
  wire prod_q_n_94;
  wire prod_q_n_95;
  wire prod_q_n_96;
  wire prod_q_n_97;
  wire prod_q_n_98;
  wire prod_q_n_99;
  wire \q_mix[11]_i_6_n_0 ;
  wire \q_mix[11]_i_7_n_0 ;
  wire \q_mix[11]_i_8_n_0 ;
  wire \q_mix[11]_i_9_n_0 ;
  wire \q_mix[15]_i_5_n_0 ;
  wire \q_mix[15]_i_6_n_0 ;
  wire \q_mix[15]_i_7_n_0 ;
  wire \q_mix[15]_i_8_n_0 ;
  wire \q_mix[3]_i_6_n_0 ;
  wire \q_mix[3]_i_7_n_0 ;
  wire \q_mix[3]_i_8_n_0 ;
  wire \q_mix[3]_i_9_n_0 ;
  wire \q_mix[7]_i_6_n_0 ;
  wire \q_mix[7]_i_7_n_0 ;
  wire \q_mix[7]_i_8_n_0 ;
  wire \q_mix[7]_i_9_n_0 ;
  wire [3:0]\q_mix_reg[11] ;
  wire \q_mix_reg[11]_i_1_n_0 ;
  wire \q_mix_reg[11]_i_1_n_1 ;
  wire \q_mix_reg[11]_i_1_n_2 ;
  wire \q_mix_reg[11]_i_1_n_3 ;
  wire [2:0]\q_mix_reg[15] ;
  wire [15:0]\q_mix_reg[15]_0 ;
  wire \q_mix_reg[15]_i_1_n_1 ;
  wire \q_mix_reg[15]_i_1_n_2 ;
  wire \q_mix_reg[15]_i_1_n_3 ;
  wire \q_mix_reg[3]_i_1_n_0 ;
  wire \q_mix_reg[3]_i_1_n_1 ;
  wire \q_mix_reg[3]_i_1_n_2 ;
  wire \q_mix_reg[3]_i_1_n_3 ;
  wire [3:0]\q_mix_reg[7] ;
  wire \q_mix_reg[7]_i_1_n_0 ;
  wire \q_mix_reg[7]_i_1_n_1 ;
  wire \q_mix_reg[7]_i_1_n_2 ;
  wire \q_mix_reg[7]_i_1_n_3 ;
  wire \q_out[0]_i_1_n_0 ;
  wire \q_out[10]_i_1_n_0 ;
  wire \q_out[11]_i_1_n_0 ;
  wire \q_out[12]_i_1_n_0 ;
  wire \q_out[13]_i_1_n_0 ;
  wire \q_out[14]_i_1_n_0 ;
  wire \q_out[14]_i_2_n_0 ;
  wire \q_out[15]_i_1_n_0 ;
  wire \q_out[1]_i_1_n_0 ;
  wire \q_out[2]_i_1_n_0 ;
  wire \q_out[3]_i_1_n_0 ;
  wire \q_out[4]_i_1_n_0 ;
  wire \q_out[5]_i_1_n_0 ;
  wire \q_out[6]_i_1_n_0 ;
  wire \q_out[7]_i_1_n_0 ;
  wire \q_out[8]_i_1_n_0 ;
  wire \q_out[9]_i_1_n_0 ;
  wire [15:0]\q_out_reg[15]_0 ;
  wire settle_cnt;
  wire \settle_cnt[0]_i_1_n_0 ;
  wire \settle_cnt[1]_i_1_n_0 ;
  wire \settle_cnt[2]_i_1_n_0 ;
  wire \settle_cnt[3]_i_1_n_0 ;
  wire \settle_cnt[4]_i_1_n_0 ;
  wire \settle_cnt[5]_i_2_n_0 ;
  wire \settle_cnt[5]_i_3_n_0 ;
  wire \settle_cnt[5]_i_4_n_0 ;
  wire \settle_cnt_reg_n_0_[0] ;
  wire \settle_cnt_reg_n_0_[1] ;
  wire \settle_cnt_reg_n_0_[2] ;
  wire \settle_cnt_reg_n_0_[3] ;
  wire \settle_cnt_reg_n_0_[4] ;
  wire \settle_cnt_reg_n_0_[5] ;
  wire settled_i_1_n_0;
  wire [3:2]NLW_error_carry__2_i_14_CO_UNCONNECTED;
  wire [3:3]NLW_error_carry__2_i_14_O_UNCONNECTED;
  wire [3:2]NLW_error_carry__2_i_15_CO_UNCONNECTED;
  wire [3:3]NLW_error_carry__2_i_15_O_UNCONNECTED;
  wire [3:0]NLW_error_carry__3_CO_UNCONNECTED;
  wire [3:1]NLW_error_carry__3_O_UNCONNECTED;
  wire [3:0]NLW_error_carry__3_i_1_CO_UNCONNECTED;
  wire [3:1]NLW_error_carry__3_i_1_O_UNCONNECTED;
  wire [3:3]\NLW_gain_acc_reg[30]_i_3_CO_UNCONNECTED ;
  wire [3:3]\NLW_i_mix_reg[15]_i_1_CO_UNCONNECTED ;
  wire [3:0]NLW_in_range_carry_O_UNCONNECTED;
  wire [3:0]NLW_in_range_carry__0_O_UNCONNECTED;
  wire [3:2]NLW_in_range_carry__0_i_9_CO_UNCONNECTED;
  wire [3:3]NLW_in_range_carry__0_i_9_O_UNCONNECTED;
  wire NLW_prod_i_CARRYCASCOUT_UNCONNECTED;
  wire NLW_prod_i_MULTSIGNOUT_UNCONNECTED;
  wire NLW_prod_i_OVERFLOW_UNCONNECTED;
  wire NLW_prod_i_PATTERNBDETECT_UNCONNECTED;
  wire NLW_prod_i_PATTERNDETECT_UNCONNECTED;
  wire NLW_prod_i_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_prod_i_ACOUT_UNCONNECTED;
  wire [17:0]NLW_prod_i_BCOUT_UNCONNECTED;
  wire [3:0]NLW_prod_i_CARRYOUT_UNCONNECTED;
  wire [47:36]NLW_prod_i_P_UNCONNECTED;
  wire [47:0]NLW_prod_i_PCOUT_UNCONNECTED;
  wire NLW_prod_q_CARRYCASCOUT_UNCONNECTED;
  wire NLW_prod_q_MULTSIGNOUT_UNCONNECTED;
  wire NLW_prod_q_OVERFLOW_UNCONNECTED;
  wire NLW_prod_q_PATTERNBDETECT_UNCONNECTED;
  wire NLW_prod_q_PATTERNDETECT_UNCONNECTED;
  wire NLW_prod_q_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_prod_q_ACOUT_UNCONNECTED;
  wire [17:0]NLW_prod_q_BCOUT_UNCONNECTED;
  wire [3:0]NLW_prod_q_CARRYOUT_UNCONNECTED;
  wire [47:36]NLW_prod_q_P_UNCONNECTED;
  wire [47:0]NLW_prod_q_PCOUT_UNCONNECTED;
  wire [3:3]\NLW_q_mix_reg[15]_i_1_CO_UNCONNECTED ;

  LUT2 #(
    .INIT(4'h8)) 
    adc_valid_d1_i_1
       (.I0(core_enable),
        .I1(adc_valid),
        .O(E));
  LUT1 #(
    .INIT(2'h1)) 
    \bits_tdata[7]_i_2 
       (.I0(aresetn),
        .O(aresetn_0));
  CARRY4 error_carry
       (.CI(1'b0),
        .CO({error_carry_n_0,error_carry_n_1,error_carry_n_2,error_carry_n_3}),
        .CYINIT(1'b1),
        .DI(\gain_acc[11]_i_8_0 [3:0]),
        .O(error_s32[3:0]),
        .S({error_carry_i_1_n_0,error_carry_i_2_n_0,error_carry_i_3_n_0,error_carry_i_4_n_0}));
  CARRY4 error_carry__0
       (.CI(error_carry_n_0),
        .CO({error_carry__0_n_0,error_carry__0_n_1,error_carry__0_n_2,error_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(\gain_acc[11]_i_8_0 [7:4]),
        .O(error_s32[7:4]),
        .S({error_carry__0_i_1_n_0,error_carry__0_i_2_n_0,error_carry__0_i_3_n_0,error_carry__0_i_4_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__0_i_1
       (.I0(\gain_acc[11]_i_8_0 [7]),
        .I1(error_carry__0_i_5_n_4),
        .O(error_carry__0_i_1_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry__0_i_10
       (.I0(error_carry__0_i_6_n_0),
        .I1(prod_q_n_86),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[7]),
        .O(error_carry__0_i_10_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry__0_i_11
       (.I0(error_carry__0_i_7_n_0),
        .I1(prod_q_n_87),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[6]),
        .O(error_carry__0_i_11_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry__0_i_12
       (.I0(error_carry__0_i_8_n_0),
        .I1(prod_q_n_88),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[5]),
        .O(error_carry__0_i_12_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry__0_i_13
       (.I0(error_carry__0_i_9_n_0),
        .I1(prod_q_n_89),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[4]),
        .O(error_carry__0_i_13_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 error_carry__0_i_14
       (.CI(error_carry_i_14_n_0),
        .CO({error_carry__0_i_14_n_0,error_carry__0_i_14_n_1,error_carry__0_i_14_n_2,error_carry__0_i_14_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(abs_i0[8:5]),
        .S({error_carry__0_i_16_n_0,error_carry__0_i_17_n_0,error_carry__0_i_18_n_0,error_carry__0_i_19_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 error_carry__0_i_15
       (.CI(error_carry_i_15_n_0),
        .CO({error_carry__0_i_15_n_0,error_carry__0_i_15_n_1,error_carry__0_i_15_n_2,error_carry__0_i_15_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(abs_q0[8:5]),
        .S({error_carry__0_i_20_n_0,error_carry__0_i_21_n_0,error_carry__0_i_22_n_0,error_carry__0_i_23_n_0}));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__0_i_16
       (.I0(prod_i_n_85),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry__0_i_16_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__0_i_17
       (.I0(prod_i_n_86),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry__0_i_17_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__0_i_18
       (.I0(prod_i_n_87),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry__0_i_18_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__0_i_19
       (.I0(prod_i_n_88),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry__0_i_19_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__0_i_2
       (.I0(\gain_acc[11]_i_8_0 [6]),
        .I1(error_carry__0_i_5_n_5),
        .O(error_carry__0_i_2_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__0_i_20
       (.I0(prod_q_n_85),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry__0_i_20_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__0_i_21
       (.I0(prod_q_n_86),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry__0_i_21_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__0_i_22
       (.I0(prod_q_n_87),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry__0_i_22_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__0_i_23
       (.I0(prod_q_n_88),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry__0_i_23_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__0_i_3
       (.I0(\gain_acc[11]_i_8_0 [5]),
        .I1(error_carry__0_i_5_n_6),
        .O(error_carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__0_i_4
       (.I0(\gain_acc[11]_i_8_0 [4]),
        .I1(error_carry__0_i_5_n_7),
        .O(error_carry__0_i_4_n_0));
  CARRY4 error_carry__0_i_5
       (.CI(error_carry_i_5_n_0),
        .CO({error_carry__0_i_5_n_0,error_carry__0_i_5_n_1,error_carry__0_i_5_n_2,error_carry__0_i_5_n_3}),
        .CYINIT(1'b0),
        .DI({error_carry__0_i_6_n_0,error_carry__0_i_7_n_0,error_carry__0_i_8_n_0,error_carry__0_i_9_n_0}),
        .O({error_carry__0_i_5_n_4,error_carry__0_i_5_n_5,error_carry__0_i_5_n_6,error_carry__0_i_5_n_7}),
        .S({error_carry__0_i_10_n_0,error_carry__0_i_11_n_0,error_carry__0_i_12_n_0,error_carry__0_i_13_n_0}));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry__0_i_6
       (.I0(abs_i0[7]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_86),
        .O(error_carry__0_i_6_n_0));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry__0_i_7
       (.I0(abs_i0[6]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_87),
        .O(error_carry__0_i_7_n_0));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry__0_i_8
       (.I0(abs_i0[5]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_88),
        .O(error_carry__0_i_8_n_0));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry__0_i_9
       (.I0(abs_i0[4]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_89),
        .O(error_carry__0_i_9_n_0));
  CARRY4 error_carry__1
       (.CI(error_carry__0_n_0),
        .CO({error_carry__1_n_0,error_carry__1_n_1,error_carry__1_n_2,error_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI(\gain_acc[11]_i_8_0 [11:8]),
        .O(error_s32[11:8]),
        .S({error_carry__1_i_1_n_0,error_carry__1_i_2_n_0,error_carry__1_i_3_n_0,error_carry__1_i_4_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__1_i_1
       (.I0(\gain_acc[11]_i_8_0 [11]),
        .I1(error_carry__1_i_5_n_4),
        .O(error_carry__1_i_1_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry__1_i_10
       (.I0(error_carry__1_i_6_n_0),
        .I1(prod_q_n_82),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[11]),
        .O(error_carry__1_i_10_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry__1_i_11
       (.I0(error_carry__1_i_7_n_0),
        .I1(prod_q_n_83),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[10]),
        .O(error_carry__1_i_11_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry__1_i_12
       (.I0(error_carry__1_i_8_n_0),
        .I1(prod_q_n_84),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[9]),
        .O(error_carry__1_i_12_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry__1_i_13
       (.I0(error_carry__1_i_9_n_0),
        .I1(prod_q_n_85),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[8]),
        .O(error_carry__1_i_13_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 error_carry__1_i_14
       (.CI(error_carry__0_i_14_n_0),
        .CO({error_carry__1_i_14_n_0,error_carry__1_i_14_n_1,error_carry__1_i_14_n_2,error_carry__1_i_14_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(abs_i0[12:9]),
        .S({error_carry__1_i_16_n_0,error_carry__1_i_17_n_0,error_carry__1_i_18_n_0,error_carry__1_i_19_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 error_carry__1_i_15
       (.CI(error_carry__0_i_15_n_0),
        .CO({error_carry__1_i_15_n_0,error_carry__1_i_15_n_1,error_carry__1_i_15_n_2,error_carry__1_i_15_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(abs_q0[12:9]),
        .S({error_carry__1_i_20_n_0,error_carry__1_i_21_n_0,error_carry__1_i_22_n_0,error_carry__1_i_23_n_0}));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__1_i_16
       (.I0(prod_i_n_81),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry__1_i_16_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__1_i_17
       (.I0(prod_i_n_82),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry__1_i_17_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__1_i_18
       (.I0(prod_i_n_83),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry__1_i_18_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__1_i_19
       (.I0(prod_i_n_84),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry__1_i_19_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__1_i_2
       (.I0(\gain_acc[11]_i_8_0 [10]),
        .I1(error_carry__1_i_5_n_5),
        .O(error_carry__1_i_2_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__1_i_20
       (.I0(prod_q_n_81),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry__1_i_20_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__1_i_21
       (.I0(prod_q_n_82),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry__1_i_21_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__1_i_22
       (.I0(prod_q_n_83),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry__1_i_22_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__1_i_23
       (.I0(prod_q_n_84),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry__1_i_23_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__1_i_3
       (.I0(\gain_acc[11]_i_8_0 [9]),
        .I1(error_carry__1_i_5_n_6),
        .O(error_carry__1_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__1_i_4
       (.I0(\gain_acc[11]_i_8_0 [8]),
        .I1(error_carry__1_i_5_n_7),
        .O(error_carry__1_i_4_n_0));
  CARRY4 error_carry__1_i_5
       (.CI(error_carry__0_i_5_n_0),
        .CO({error_carry__1_i_5_n_0,error_carry__1_i_5_n_1,error_carry__1_i_5_n_2,error_carry__1_i_5_n_3}),
        .CYINIT(1'b0),
        .DI({error_carry__1_i_6_n_0,error_carry__1_i_7_n_0,error_carry__1_i_8_n_0,error_carry__1_i_9_n_0}),
        .O({error_carry__1_i_5_n_4,error_carry__1_i_5_n_5,error_carry__1_i_5_n_6,error_carry__1_i_5_n_7}),
        .S({error_carry__1_i_10_n_0,error_carry__1_i_11_n_0,error_carry__1_i_12_n_0,error_carry__1_i_13_n_0}));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry__1_i_6
       (.I0(abs_i0[11]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_82),
        .O(error_carry__1_i_6_n_0));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry__1_i_7
       (.I0(abs_i0[10]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_83),
        .O(error_carry__1_i_7_n_0));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry__1_i_8
       (.I0(abs_i0[9]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_84),
        .O(error_carry__1_i_8_n_0));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry__1_i_9
       (.I0(abs_i0[8]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_85),
        .O(error_carry__1_i_9_n_0));
  CARRY4 error_carry__2
       (.CI(error_carry__1_n_0),
        .CO({error_carry__2_n_0,error_carry__2_n_1,error_carry__2_n_2,error_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI(\gain_acc[11]_i_8_0 [15:12]),
        .O(error_s32[15:12]),
        .S({error_carry__2_i_1_n_0,error_carry__2_i_2_n_0,error_carry__2_i_3_n_0,error_carry__2_i_4_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__2_i_1
       (.I0(\gain_acc[11]_i_8_0 [15]),
        .I1(error_carry__2_i_5_n_4),
        .O(error_carry__2_i_1_n_0));
  LUT4 #(
    .INIT(16'h7888)) 
    error_carry__2_i_10
       (.I0(abs_i0[15]),
        .I1(p_0_in[4]),
        .I2(abs_q0[15]),
        .I3(prod_q_n_74),
        .O(error_carry__2_i_10_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry__2_i_11
       (.I0(error_carry__2_i_7_n_0),
        .I1(prod_q_n_79),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[14]),
        .O(error_carry__2_i_11_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry__2_i_12
       (.I0(error_carry__2_i_8_n_0),
        .I1(prod_q_n_80),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[13]),
        .O(error_carry__2_i_12_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry__2_i_13
       (.I0(error_carry__2_i_9_n_0),
        .I1(prod_q_n_81),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[12]),
        .O(error_carry__2_i_13_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 error_carry__2_i_14
       (.CI(error_carry__1_i_14_n_0),
        .CO({NLW_error_carry__2_i_14_CO_UNCONNECTED[3:2],error_carry__2_i_14_n_2,error_carry__2_i_14_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_error_carry__2_i_14_O_UNCONNECTED[3],abs_i0[15:13]}),
        .S({1'b0,error_carry__2_i_16_n_0,error_carry__2_i_17_n_0,error_carry__2_i_18_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 error_carry__2_i_15
       (.CI(error_carry__1_i_15_n_0),
        .CO({NLW_error_carry__2_i_15_CO_UNCONNECTED[3:2],error_carry__2_i_15_n_2,error_carry__2_i_15_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_error_carry__2_i_15_O_UNCONNECTED[3],abs_q0[15:13]}),
        .S({1'b0,error_carry__2_i_19_n_0,error_carry__2_i_20_n_0,error_carry__2_i_21_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    error_carry__2_i_16
       (.I0(p_0_in[4]),
        .O(error_carry__2_i_16_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__2_i_17
       (.I0(prod_i_n_79),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry__2_i_17_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__2_i_18
       (.I0(prod_i_n_80),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry__2_i_18_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    error_carry__2_i_19
       (.I0(prod_q_n_74),
        .O(error_carry__2_i_19_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__2_i_2
       (.I0(\gain_acc[11]_i_8_0 [14]),
        .I1(error_carry__2_i_5_n_5),
        .O(error_carry__2_i_2_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__2_i_20
       (.I0(prod_q_n_79),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry__2_i_20_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry__2_i_21
       (.I0(prod_q_n_80),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry__2_i_21_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__2_i_3
       (.I0(\gain_acc[11]_i_8_0 [13]),
        .I1(error_carry__2_i_5_n_6),
        .O(error_carry__2_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry__2_i_4
       (.I0(\gain_acc[11]_i_8_0 [12]),
        .I1(error_carry__2_i_5_n_7),
        .O(error_carry__2_i_4_n_0));
  CARRY4 error_carry__2_i_5
       (.CI(error_carry__1_i_5_n_0),
        .CO({error_carry__2_i_5_n_0,error_carry__2_i_5_n_1,error_carry__2_i_5_n_2,error_carry__2_i_5_n_3}),
        .CYINIT(1'b0),
        .DI({error_carry__2_i_6_n_0,error_carry__2_i_7_n_0,error_carry__2_i_8_n_0,error_carry__2_i_9_n_0}),
        .O({error_carry__2_i_5_n_4,error_carry__2_i_5_n_5,error_carry__2_i_5_n_6,error_carry__2_i_5_n_7}),
        .S({error_carry__2_i_10_n_0,error_carry__2_i_11_n_0,error_carry__2_i_12_n_0,error_carry__2_i_13_n_0}));
  LUT2 #(
    .INIT(4'h8)) 
    error_carry__2_i_6
       (.I0(p_0_in[4]),
        .I1(abs_i0[15]),
        .O(error_carry__2_i_6_n_0));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry__2_i_7
       (.I0(abs_i0[14]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_79),
        .O(error_carry__2_i_7_n_0));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry__2_i_8
       (.I0(abs_i0[13]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_80),
        .O(error_carry__2_i_8_n_0));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry__2_i_9
       (.I0(abs_i0[12]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_81),
        .O(error_carry__2_i_9_n_0));
  CARRY4 error_carry__3
       (.CI(error_carry__2_n_0),
        .CO({NLW_error_carry__3_CO_UNCONNECTED[3:2],error_carry__3_n_2,NLW_error_carry__3_CO_UNCONNECTED[0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_error_carry__3_O_UNCONNECTED[3:1],error_s32[16]}),
        .S({1'b0,1'b0,1'b1,aD2M4dsP}));
  CARRY4 error_carry__3_i_1
       (.CI(error_carry__2_i_5_n_0),
        .CO(NLW_error_carry__3_i_1_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_error_carry__3_i_1_O_UNCONNECTED[3:1],aD2M4dsP}),
        .S({1'b0,1'b0,1'b0,1'b1}));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry_i_1
       (.I0(\gain_acc[11]_i_8_0 [3]),
        .I1(error_carry_i_5_n_4),
        .O(error_carry_i_1_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry_i_10
       (.I0(error_carry_i_6_n_0),
        .I1(prod_q_n_90),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[3]),
        .O(error_carry_i_10_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry_i_11
       (.I0(error_carry_i_7_n_0),
        .I1(prod_q_n_91),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[2]),
        .O(error_carry_i_11_n_0));
  LUT5 #(
    .INIT(32'h5556AA56)) 
    error_carry_i_12
       (.I0(error_carry_i_8_n_0),
        .I1(prod_q_n_92),
        .I2(\q_out[14]_i_2_n_0 ),
        .I3(prod_q_n_74),
        .I4(abs_q0[1]),
        .O(error_carry_i_12_n_0));
  LUT6 #(
    .INIT(64'h2E2ED12ED1D1D12E)) 
    error_carry_i_13
       (.I0(prod_i_n_93),
        .I1(\i_out[14]_i_2_n_0 ),
        .I2(p_0_in[4]),
        .I3(prod_q_n_93),
        .I4(\q_out[14]_i_2_n_0 ),
        .I5(prod_q_n_74),
        .O(error_carry_i_13_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 error_carry_i_14
       (.CI(1'b0),
        .CO({error_carry_i_14_n_0,error_carry_i_14_n_1,error_carry_i_14_n_2,error_carry_i_14_n_3}),
        .CYINIT(error_carry_i_16_n_0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(abs_i0[4:1]),
        .S({error_carry_i_17_n_0,error_carry_i_18_n_0,error_carry_i_19_n_0,error_carry_i_20_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 error_carry_i_15
       (.CI(1'b0),
        .CO({error_carry_i_15_n_0,error_carry_i_15_n_1,error_carry_i_15_n_2,error_carry_i_15_n_3}),
        .CYINIT(error_carry_i_21_n_0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(abs_q0[4:1]),
        .S({error_carry_i_22_n_0,error_carry_i_23_n_0,error_carry_i_24_n_0,error_carry_i_25_n_0}));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry_i_16
       (.I0(prod_i_n_93),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry_i_16_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry_i_17
       (.I0(prod_i_n_89),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry_i_17_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry_i_18
       (.I0(prod_i_n_90),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry_i_18_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry_i_19
       (.I0(prod_i_n_91),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry_i_19_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry_i_2
       (.I0(\gain_acc[11]_i_8_0 [2]),
        .I1(error_carry_i_5_n_5),
        .O(error_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry_i_20
       (.I0(prod_i_n_92),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(p_0_in[2]),
        .I4(p_0_in[4]),
        .I5(p_0_in[3]),
        .O(error_carry_i_20_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry_i_21
       (.I0(prod_q_n_93),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry_i_21_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry_i_22
       (.I0(prod_q_n_89),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry_i_22_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry_i_23
       (.I0(prod_q_n_90),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry_i_23_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry_i_24
       (.I0(prod_q_n_91),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry_i_24_n_0));
  LUT6 #(
    .INIT(64'h7FFF0000FFFF0001)) 
    error_carry_i_25
       (.I0(prod_q_n_92),
        .I1(prod_q_n_78),
        .I2(prod_q_n_77),
        .I3(prod_q_n_76),
        .I4(prod_q_n_74),
        .I5(prod_q_n_75),
        .O(error_carry_i_25_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry_i_3
       (.I0(\gain_acc[11]_i_8_0 [1]),
        .I1(error_carry_i_5_n_6),
        .O(error_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    error_carry_i_4
       (.I0(\gain_acc[11]_i_8_0 [0]),
        .I1(error_carry_i_5_n_7),
        .O(error_carry_i_4_n_0));
  CARRY4 error_carry_i_5
       (.CI(1'b0),
        .CO({error_carry_i_5_n_0,error_carry_i_5_n_1,error_carry_i_5_n_2,error_carry_i_5_n_3}),
        .CYINIT(1'b0),
        .DI({error_carry_i_6_n_0,error_carry_i_7_n_0,error_carry_i_8_n_0,i_scaled}),
        .O({error_carry_i_5_n_4,error_carry_i_5_n_5,error_carry_i_5_n_6,error_carry_i_5_n_7}),
        .S({error_carry_i_10_n_0,error_carry_i_11_n_0,error_carry_i_12_n_0,error_carry_i_13_n_0}));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry_i_6
       (.I0(abs_i0[3]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_90),
        .O(error_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry_i_7
       (.I0(abs_i0[2]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_91),
        .O(error_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'hBBB8)) 
    error_carry_i_8
       (.I0(abs_i0[1]),
        .I1(p_0_in[4]),
        .I2(\i_out[14]_i_2_n_0 ),
        .I3(prod_i_n_92),
        .O(error_carry_i_8_n_0));
  LUT6 #(
    .INIT(64'hB333333333333332)) 
    error_carry_i_9
       (.I0(p_0_in[3]),
        .I1(p_0_in[4]),
        .I2(p_0_in[2]),
        .I3(p_0_in[1]),
        .I4(p_0_in[0]),
        .I5(prod_i_n_93),
        .O(i_scaled));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[0]_i_1 
       (.I0(gain_acc_next1[0]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[0]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[10]_i_1 
       (.I0(gain_acc_next1[10]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[10]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[11]_i_1 
       (.I0(gain_acc_next1[11]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[11]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gain_acc[11]_i_10 
       (.I0(\gain_acc[11]_i_12_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[11]_i_13_n_0 ),
        .O(\gain_acc[11]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h5F50CFCF5F50C0C0)) 
    \gain_acc[11]_i_11 
       (.I0(error_carry__3_n_2),
        .I1(error_s32[12]),
        .I2(\gain_acc[11]_i_3_0 [2]),
        .I3(error_s32[16]),
        .I4(\gain_acc[11]_i_3_0 [3]),
        .I5(error_s32[8]),
        .O(\gain_acc[11]_i_11_n_0 ));
  LUT5 #(
    .INIT(32'h0FBB0F88)) 
    \gain_acc[11]_i_12 
       (.I0(error_s32[15]),
        .I1(\gain_acc[11]_i_3_0 [2]),
        .I2(error_carry__3_n_2),
        .I3(\gain_acc[11]_i_3_0 [3]),
        .I4(error_s32[11]),
        .O(\gain_acc[11]_i_12_n_0 ));
  LUT5 #(
    .INIT(32'h0FBB0F88)) 
    \gain_acc[11]_i_13 
       (.I0(error_s32[13]),
        .I1(\gain_acc[11]_i_3_0 [2]),
        .I2(error_carry__3_n_2),
        .I3(\gain_acc[11]_i_3_0 [3]),
        .I4(error_s32[9]),
        .O(\gain_acc[11]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'h56A6)) 
    \gain_acc[11]_i_3 
       (.I0(gain_acc[11]),
        .I1(\gain_acc[11]_i_7_n_0 ),
        .I2(\gain_acc[11]_i_3_0 [0]),
        .I3(\gain_acc[15]_i_10_n_0 ),
        .O(\gain_acc[11]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00FF47B8FF0047B8)) 
    \gain_acc[11]_i_4 
       (.I0(\gain_acc[11]_i_8_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[11]_i_9_n_0 ),
        .I3(gain_acc[10]),
        .I4(\gain_acc[11]_i_3_0 [0]),
        .I5(\gain_acc[11]_i_7_n_0 ),
        .O(\gain_acc[11]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h47B847B800FFFF00)) 
    \gain_acc[11]_i_5 
       (.I0(\gain_acc[11]_i_8_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[11]_i_9_n_0 ),
        .I3(gain_acc[9]),
        .I4(\gain_acc[11]_i_10_n_0 ),
        .I5(\gain_acc[11]_i_3_0 [0]),
        .O(\gain_acc[11]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h00FF47B8FF0047B8)) 
    \gain_acc[11]_i_6 
       (.I0(\gain_acc[11]_i_9_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[11]_i_11_n_0 ),
        .I3(gain_acc[8]),
        .I4(\gain_acc[11]_i_3_0 [0]),
        .I5(\gain_acc[11]_i_10_n_0 ),
        .O(\gain_acc[11]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h3732FFFF37320000)) 
    \gain_acc[11]_i_7 
       (.I0(\gain_acc[11]_i_3_0 [2]),
        .I1(error_carry__3_n_2),
        .I2(\gain_acc[11]_i_3_0 [3]),
        .I3(error_s32[13]),
        .I4(\gain_acc[11]_i_3_0 [1]),
        .I5(\gain_acc[11]_i_12_n_0 ),
        .O(\gain_acc[11]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h0FBB0F88)) 
    \gain_acc[11]_i_8 
       (.I0(error_s32[16]),
        .I1(\gain_acc[11]_i_3_0 [2]),
        .I2(error_carry__3_n_2),
        .I3(\gain_acc[11]_i_3_0 [3]),
        .I4(error_s32[12]),
        .O(\gain_acc[11]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'h0FBB0F88)) 
    \gain_acc[11]_i_9 
       (.I0(error_s32[14]),
        .I1(\gain_acc[11]_i_3_0 [2]),
        .I2(error_carry__3_n_2),
        .I3(\gain_acc[11]_i_3_0 [3]),
        .I4(error_s32[10]),
        .O(\gain_acc[11]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[12]_i_1 
       (.I0(gain_acc_next1[12]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[12]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[13]_i_1 
       (.I0(gain_acc_next1[13]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[13]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[14]_i_1 
       (.I0(gain_acc_next1[14]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[14]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[15]_i_1 
       (.I0(gain_acc_next1[15]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[15]));
  LUT6 #(
    .INIT(64'h3732FFFF37320000)) 
    \gain_acc[15]_i_10 
       (.I0(\gain_acc[11]_i_3_0 [2]),
        .I1(error_carry__3_n_2),
        .I2(\gain_acc[11]_i_3_0 [3]),
        .I3(error_s32[14]),
        .I4(\gain_acc[11]_i_3_0 [1]),
        .I5(\gain_acc[11]_i_8_n_0 ),
        .O(\gain_acc[15]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'h56A6)) 
    \gain_acc[15]_i_3 
       (.I0(Q[3]),
        .I1(\gain_acc[15]_i_7_n_0 ),
        .I2(\gain_acc[11]_i_3_0 [0]),
        .I3(\gain_acc[19]_i_7_n_0 ),
        .O(\gain_acc[15]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h56A6)) 
    \gain_acc[15]_i_4 
       (.I0(Q[2]),
        .I1(\gain_acc[15]_i_8_n_0 ),
        .I2(\gain_acc[11]_i_3_0 [0]),
        .I3(\gain_acc[15]_i_7_n_0 ),
        .O(\gain_acc[15]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h56A6)) 
    \gain_acc[15]_i_5 
       (.I0(Q[1]),
        .I1(\gain_acc[15]_i_9_n_0 ),
        .I2(\gain_acc[11]_i_3_0 [0]),
        .I3(\gain_acc[15]_i_8_n_0 ),
        .O(\gain_acc[15]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h56A6)) 
    \gain_acc[15]_i_6 
       (.I0(Q[0]),
        .I1(\gain_acc[15]_i_10_n_0 ),
        .I2(\gain_acc[11]_i_3_0 [0]),
        .I3(\gain_acc[15]_i_9_n_0 ),
        .O(\gain_acc[15]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h0F1F0F0E)) 
    \gain_acc[15]_i_7 
       (.I0(\gain_acc[11]_i_3_0 [1]),
        .I1(\gain_acc[11]_i_3_0 [2]),
        .I2(error_carry__3_n_2),
        .I3(\gain_acc[11]_i_3_0 [3]),
        .I4(error_s32[15]),
        .O(\gain_acc[15]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h00FF0BFB00FF08F8)) 
    \gain_acc[15]_i_8 
       (.I0(error_s32[16]),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[11]_i_3_0 [2]),
        .I3(error_carry__3_n_2),
        .I4(\gain_acc[11]_i_3_0 [3]),
        .I5(error_s32[14]),
        .O(\gain_acc[15]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h00FF0BFB00FF08F8)) 
    \gain_acc[15]_i_9 
       (.I0(error_s32[15]),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[11]_i_3_0 [2]),
        .I3(error_carry__3_n_2),
        .I4(\gain_acc[11]_i_3_0 [3]),
        .I5(error_s32[13]),
        .O(\gain_acc[15]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[16]_i_1 
       (.I0(gain_acc_next1[16]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[16]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[17]_i_1 
       (.I0(gain_acc_next1[17]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[17]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[18]_i_1 
       (.I0(gain_acc_next1[18]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[18]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[19]_i_1 
       (.I0(gain_acc_next1[19]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[19]));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[19]_i_3 
       (.I0(Q[7]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[19]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[19]_i_4 
       (.I0(Q[6]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[19]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[19]_i_5 
       (.I0(Q[5]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[19]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hA656)) 
    \gain_acc[19]_i_6 
       (.I0(Q[4]),
        .I1(\gain_acc[19]_i_7_n_0 ),
        .I2(\gain_acc[11]_i_3_0 [0]),
        .I3(error_carry__3_n_2),
        .O(\gain_acc[19]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h0F1F0F0E)) 
    \gain_acc[19]_i_7 
       (.I0(\gain_acc[11]_i_3_0 [1]),
        .I1(\gain_acc[11]_i_3_0 [2]),
        .I2(error_carry__3_n_2),
        .I3(\gain_acc[11]_i_3_0 [3]),
        .I4(error_s32[16]),
        .O(\gain_acc[19]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[1]_i_1 
       (.I0(gain_acc_next1[1]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[1]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[20]_i_1 
       (.I0(gain_acc_next1[20]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[20]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[21]_i_1 
       (.I0(gain_acc_next1[21]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[21]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[22]_i_1 
       (.I0(gain_acc_next1[22]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[22]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[23]_i_1 
       (.I0(gain_acc_next1[23]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[23]));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[23]_i_3 
       (.I0(Q[11]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[23]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[23]_i_4 
       (.I0(Q[10]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[23]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[23]_i_5 
       (.I0(Q[9]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[23]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[23]_i_6 
       (.I0(Q[8]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[23]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[24]_i_1 
       (.I0(gain_acc_next1[24]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[24]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[25]_i_1 
       (.I0(gain_acc_next1[25]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[25]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[26]_i_1 
       (.I0(gain_acc_next1[26]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[26]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[27]_i_1 
       (.I0(gain_acc_next1[27]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[27]));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[27]_i_3 
       (.I0(Q[15]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[27]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[27]_i_4 
       (.I0(Q[14]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[27]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[27]_i_5 
       (.I0(Q[13]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[27]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[27]_i_6 
       (.I0(Q[12]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[27]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[28]_i_1 
       (.I0(gain_acc_next1[28]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[28]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[29]_i_1 
       (.I0(gain_acc_next1[29]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[29]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[2]_i_1 
       (.I0(gain_acc_next1[2]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[2]));
  LUT3 #(
    .INIT(8'h08)) 
    \gain_acc[30]_i_1 
       (.I0(adc_valid),
        .I1(core_enable),
        .I2(core_bypass_agc),
        .O(gain_acc0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[30]_i_2 
       (.I0(gain_acc_next1[30]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[30]));
  LUT1 #(
    .INIT(2'h1)) 
    \gain_acc[30]_i_4 
       (.I0(error_carry__3_n_2),
        .O(error_s32[17]));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[30]_i_5 
       (.I0(gain_acc[30]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[30]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[30]_i_6 
       (.I0(gain_acc[29]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[30]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gain_acc[30]_i_7 
       (.I0(gain_acc[28]),
        .I1(error_carry__3_n_2),
        .O(\gain_acc[30]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[3]_i_1 
       (.I0(gain_acc_next1[3]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \gain_acc[3]_i_10 
       (.I0(error_s32[12]),
        .I1(error_s32[4]),
        .I2(\gain_acc[11]_i_3_0 [2]),
        .I3(error_s32[8]),
        .I4(\gain_acc[11]_i_3_0 [3]),
        .I5(error_s32[0]),
        .O(\gain_acc[3]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \gain_acc[3]_i_11 
       (.I0(error_s32[15]),
        .I1(error_s32[7]),
        .I2(\gain_acc[11]_i_3_0 [2]),
        .I3(error_s32[11]),
        .I4(\gain_acc[11]_i_3_0 [3]),
        .I5(error_s32[3]),
        .O(\gain_acc[3]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \gain_acc[3]_i_12 
       (.I0(error_s32[13]),
        .I1(error_s32[5]),
        .I2(\gain_acc[11]_i_3_0 [2]),
        .I3(error_s32[9]),
        .I4(\gain_acc[11]_i_3_0 [3]),
        .I5(error_s32[1]),
        .O(\gain_acc[3]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h47B847B800FFFF00)) 
    \gain_acc[3]_i_3 
       (.I0(\gain_acc[7]_i_8_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[7]_i_10_n_0 ),
        .I3(gain_acc[3]),
        .I4(\gain_acc[3]_i_7_n_0 ),
        .I5(\gain_acc[11]_i_3_0 [0]),
        .O(\gain_acc[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00FF47B8FF0047B8)) 
    \gain_acc[3]_i_4 
       (.I0(\gain_acc[7]_i_10_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[3]_i_8_n_0 ),
        .I3(gain_acc[2]),
        .I4(\gain_acc[11]_i_3_0 [0]),
        .I5(\gain_acc[3]_i_7_n_0 ),
        .O(\gain_acc[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h47B847B800FFFF00)) 
    \gain_acc[3]_i_5 
       (.I0(\gain_acc[7]_i_10_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[3]_i_8_n_0 ),
        .I3(gain_acc[1]),
        .I4(\gain_acc[3]_i_9_n_0 ),
        .I5(\gain_acc[11]_i_3_0 [0]),
        .O(\gain_acc[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h555556A6AAAA56A6)) 
    \gain_acc[3]_i_6 
       (.I0(gain_acc[0]),
        .I1(\gain_acc[3]_i_10_n_0 ),
        .I2(\gain_acc[11]_i_3_0 [1]),
        .I3(\gain_acc[3]_i_8_n_0 ),
        .I4(\gain_acc[11]_i_3_0 [0]),
        .I5(\gain_acc[3]_i_9_n_0 ),
        .O(\gain_acc[3]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gain_acc[3]_i_7 
       (.I0(\gain_acc[7]_i_12_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[3]_i_11_n_0 ),
        .O(\gain_acc[3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \gain_acc[3]_i_8 
       (.I0(error_s32[14]),
        .I1(error_s32[6]),
        .I2(\gain_acc[11]_i_3_0 [2]),
        .I3(error_s32[10]),
        .I4(\gain_acc[11]_i_3_0 [3]),
        .I5(error_s32[2]),
        .O(\gain_acc[3]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \gain_acc[3]_i_9 
       (.I0(\gain_acc[3]_i_11_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[3]_i_12_n_0 ),
        .O(\gain_acc[3]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[4]_i_1 
       (.I0(gain_acc_next1[4]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[4]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[5]_i_1 
       (.I0(gain_acc_next1[5]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[5]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[6]_i_1 
       (.I0(gain_acc_next1[6]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[6]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[7]_i_1 
       (.I0(gain_acc_next1[7]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[7]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \gain_acc[7]_i_10 
       (.I0(error_s32[16]),
        .I1(error_s32[8]),
        .I2(\gain_acc[11]_i_3_0 [2]),
        .I3(error_s32[12]),
        .I4(\gain_acc[11]_i_3_0 [3]),
        .I5(error_s32[4]),
        .O(\gain_acc[7]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h5F50CFCF5F50C0C0)) 
    \gain_acc[7]_i_11 
       (.I0(error_carry__3_n_2),
        .I1(error_s32[11]),
        .I2(\gain_acc[11]_i_3_0 [2]),
        .I3(error_s32[15]),
        .I4(\gain_acc[11]_i_3_0 [3]),
        .I5(error_s32[7]),
        .O(\gain_acc[7]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h5F50CFCF5F50C0C0)) 
    \gain_acc[7]_i_12 
       (.I0(error_carry__3_n_2),
        .I1(error_s32[9]),
        .I2(\gain_acc[11]_i_3_0 [2]),
        .I3(error_s32[13]),
        .I4(\gain_acc[11]_i_3_0 [3]),
        .I5(error_s32[5]),
        .O(\gain_acc[7]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h47B847B800FFFF00)) 
    \gain_acc[7]_i_3 
       (.I0(\gain_acc[11]_i_9_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[11]_i_11_n_0 ),
        .I3(gain_acc[7]),
        .I4(\gain_acc[7]_i_7_n_0 ),
        .I5(\gain_acc[11]_i_3_0 [0]),
        .O(\gain_acc[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00FF47B8FF0047B8)) 
    \gain_acc[7]_i_4 
       (.I0(\gain_acc[11]_i_11_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[7]_i_8_n_0 ),
        .I3(gain_acc[6]),
        .I4(\gain_acc[11]_i_3_0 [0]),
        .I5(\gain_acc[7]_i_7_n_0 ),
        .O(\gain_acc[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h47B847B800FFFF00)) 
    \gain_acc[7]_i_5 
       (.I0(\gain_acc[11]_i_11_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[7]_i_8_n_0 ),
        .I3(gain_acc[5]),
        .I4(\gain_acc[7]_i_9_n_0 ),
        .I5(\gain_acc[11]_i_3_0 [0]),
        .O(\gain_acc[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h00FF47B8FF0047B8)) 
    \gain_acc[7]_i_6 
       (.I0(\gain_acc[7]_i_8_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[7]_i_10_n_0 ),
        .I3(gain_acc[4]),
        .I4(\gain_acc[11]_i_3_0 [0]),
        .I5(\gain_acc[7]_i_9_n_0 ),
        .O(\gain_acc[7]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gain_acc[7]_i_7 
       (.I0(\gain_acc[11]_i_13_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[7]_i_11_n_0 ),
        .O(\gain_acc[7]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h5F50CFCF5F50C0C0)) 
    \gain_acc[7]_i_8 
       (.I0(error_carry__3_n_2),
        .I1(error_s32[10]),
        .I2(\gain_acc[11]_i_3_0 [2]),
        .I3(error_s32[14]),
        .I4(\gain_acc[11]_i_3_0 [3]),
        .I5(error_s32[6]),
        .O(\gain_acc[7]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gain_acc[7]_i_9 
       (.I0(\gain_acc[7]_i_11_n_0 ),
        .I1(\gain_acc[11]_i_3_0 [1]),
        .I2(\gain_acc[7]_i_12_n_0 ),
        .O(\gain_acc[7]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[8]_i_1 
       (.I0(gain_acc_next1[8]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[8]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gain_acc[9]_i_1 
       (.I0(gain_acc_next1[9]),
        .I1(gain_acc_next1[31]),
        .O(gain_acc_next[9]));
  FDCE \gain_acc_reg[0] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[0]),
        .Q(gain_acc[0]));
  FDCE \gain_acc_reg[10] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[10]),
        .Q(gain_acc[10]));
  FDCE \gain_acc_reg[11] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[11]),
        .Q(gain_acc[11]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gain_acc_reg[11]_i_2 
       (.CI(\gain_acc_reg[7]_i_2_n_0 ),
        .CO({\gain_acc_reg[11]_i_2_n_0 ,\gain_acc_reg[11]_i_2_n_1 ,\gain_acc_reg[11]_i_2_n_2 ,\gain_acc_reg[11]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(gain_acc[11:8]),
        .O(gain_acc_next1[11:8]),
        .S({\gain_acc[11]_i_3_n_0 ,\gain_acc[11]_i_4_n_0 ,\gain_acc[11]_i_5_n_0 ,\gain_acc[11]_i_6_n_0 }));
  FDCE \gain_acc_reg[12] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[12]),
        .Q(Q[0]));
  FDCE \gain_acc_reg[13] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[13]),
        .Q(Q[1]));
  FDCE \gain_acc_reg[14] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[14]),
        .Q(Q[2]));
  FDCE \gain_acc_reg[15] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[15]),
        .Q(Q[3]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gain_acc_reg[15]_i_2 
       (.CI(\gain_acc_reg[11]_i_2_n_0 ),
        .CO({\gain_acc_reg[15]_i_2_n_0 ,\gain_acc_reg[15]_i_2_n_1 ,\gain_acc_reg[15]_i_2_n_2 ,\gain_acc_reg[15]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(Q[3:0]),
        .O(gain_acc_next1[15:12]),
        .S({\gain_acc[15]_i_3_n_0 ,\gain_acc[15]_i_4_n_0 ,\gain_acc[15]_i_5_n_0 ,\gain_acc[15]_i_6_n_0 }));
  FDCE \gain_acc_reg[16] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[16]),
        .Q(Q[4]));
  FDCE \gain_acc_reg[17] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[17]),
        .Q(Q[5]));
  FDCE \gain_acc_reg[18] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[18]),
        .Q(Q[6]));
  FDCE \gain_acc_reg[19] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[19]),
        .Q(Q[7]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gain_acc_reg[19]_i_2 
       (.CI(\gain_acc_reg[15]_i_2_n_0 ),
        .CO({\gain_acc_reg[19]_i_2_n_0 ,\gain_acc_reg[19]_i_2_n_1 ,\gain_acc_reg[19]_i_2_n_2 ,\gain_acc_reg[19]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(Q[7:4]),
        .O(gain_acc_next1[19:16]),
        .S({\gain_acc[19]_i_3_n_0 ,\gain_acc[19]_i_4_n_0 ,\gain_acc[19]_i_5_n_0 ,\gain_acc[19]_i_6_n_0 }));
  FDCE \gain_acc_reg[1] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[1]),
        .Q(gain_acc[1]));
  FDCE \gain_acc_reg[20] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[20]),
        .Q(Q[8]));
  FDCE \gain_acc_reg[21] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[21]),
        .Q(Q[9]));
  FDCE \gain_acc_reg[22] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[22]),
        .Q(Q[10]));
  FDCE \gain_acc_reg[23] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[23]),
        .Q(Q[11]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gain_acc_reg[23]_i_2 
       (.CI(\gain_acc_reg[19]_i_2_n_0 ),
        .CO({\gain_acc_reg[23]_i_2_n_0 ,\gain_acc_reg[23]_i_2_n_1 ,\gain_acc_reg[23]_i_2_n_2 ,\gain_acc_reg[23]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(Q[11:8]),
        .O(gain_acc_next1[23:20]),
        .S({\gain_acc[23]_i_3_n_0 ,\gain_acc[23]_i_4_n_0 ,\gain_acc[23]_i_5_n_0 ,\gain_acc[23]_i_6_n_0 }));
  FDPE \gain_acc_reg[24] 
       (.C(aclk),
        .CE(gain_acc0),
        .D(gain_acc_next[24]),
        .PRE(aresetn_0),
        .Q(Q[12]));
  FDCE \gain_acc_reg[25] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[25]),
        .Q(Q[13]));
  FDCE \gain_acc_reg[26] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[26]),
        .Q(Q[14]));
  FDCE \gain_acc_reg[27] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[27]),
        .Q(Q[15]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gain_acc_reg[27]_i_2 
       (.CI(\gain_acc_reg[23]_i_2_n_0 ),
        .CO({\gain_acc_reg[27]_i_2_n_0 ,\gain_acc_reg[27]_i_2_n_1 ,\gain_acc_reg[27]_i_2_n_2 ,\gain_acc_reg[27]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(Q[15:12]),
        .O(gain_acc_next1[27:24]),
        .S({\gain_acc[27]_i_3_n_0 ,\gain_acc[27]_i_4_n_0 ,\gain_acc[27]_i_5_n_0 ,\gain_acc[27]_i_6_n_0 }));
  FDCE \gain_acc_reg[28] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[28]),
        .Q(gain_acc[28]));
  FDCE \gain_acc_reg[29] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[29]),
        .Q(gain_acc[29]));
  FDCE \gain_acc_reg[2] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[2]),
        .Q(gain_acc[2]));
  FDCE \gain_acc_reg[30] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[30]),
        .Q(gain_acc[30]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gain_acc_reg[30]_i_3 
       (.CI(\gain_acc_reg[27]_i_2_n_0 ),
        .CO({\NLW_gain_acc_reg[30]_i_3_CO_UNCONNECTED [3],\gain_acc_reg[30]_i_3_n_1 ,\gain_acc_reg[30]_i_3_n_2 ,\gain_acc_reg[30]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,gain_acc[30:28]}),
        .O(gain_acc_next1[31:28]),
        .S({error_s32[17],\gain_acc[30]_i_5_n_0 ,\gain_acc[30]_i_6_n_0 ,\gain_acc[30]_i_7_n_0 }));
  FDCE \gain_acc_reg[3] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[3]),
        .Q(gain_acc[3]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gain_acc_reg[3]_i_2 
       (.CI(1'b0),
        .CO({\gain_acc_reg[3]_i_2_n_0 ,\gain_acc_reg[3]_i_2_n_1 ,\gain_acc_reg[3]_i_2_n_2 ,\gain_acc_reg[3]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(gain_acc[3:0]),
        .O(gain_acc_next1[3:0]),
        .S({\gain_acc[3]_i_3_n_0 ,\gain_acc[3]_i_4_n_0 ,\gain_acc[3]_i_5_n_0 ,\gain_acc[3]_i_6_n_0 }));
  FDCE \gain_acc_reg[4] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[4]),
        .Q(gain_acc[4]));
  FDCE \gain_acc_reg[5] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[5]),
        .Q(gain_acc[5]));
  FDCE \gain_acc_reg[6] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[6]),
        .Q(gain_acc[6]));
  FDCE \gain_acc_reg[7] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[7]),
        .Q(gain_acc[7]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gain_acc_reg[7]_i_2 
       (.CI(\gain_acc_reg[3]_i_2_n_0 ),
        .CO({\gain_acc_reg[7]_i_2_n_0 ,\gain_acc_reg[7]_i_2_n_1 ,\gain_acc_reg[7]_i_2_n_2 ,\gain_acc_reg[7]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(gain_acc[7:4]),
        .O(gain_acc_next1[7:4]),
        .S({\gain_acc[7]_i_3_n_0 ,\gain_acc[7]_i_4_n_0 ,\gain_acc[7]_i_5_n_0 ,\gain_acc[7]_i_6_n_0 }));
  FDCE \gain_acc_reg[8] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[8]),
        .Q(gain_acc[8]));
  FDCE \gain_acc_reg[9] 
       (.C(aclk),
        .CE(gain_acc0),
        .CLR(aresetn_0),
        .D(gain_acc_next[9]),
        .Q(gain_acc[9]));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[11]_i_6 
       (.I0(\i_mix_reg[15]_0 [11]),
        .I1(\i_mix_reg[15]_1 [11]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [11]),
        .O(\i_mix[11]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[11]_i_7 
       (.I0(\i_mix_reg[15]_0 [10]),
        .I1(\i_mix_reg[15]_1 [10]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [10]),
        .O(\i_mix[11]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[11]_i_8 
       (.I0(\i_mix_reg[15]_0 [9]),
        .I1(\i_mix_reg[15]_1 [9]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [9]),
        .O(\i_mix[11]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[11]_i_9 
       (.I0(\i_mix_reg[15]_0 [8]),
        .I1(\i_mix_reg[15]_1 [8]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [8]),
        .O(\i_mix[11]_i_9_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[15]_i_5 
       (.I0(\i_mix_reg[15]_0 [15]),
        .I1(\i_mix_reg[15]_1 [15]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [15]),
        .O(\i_mix[15]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[15]_i_6 
       (.I0(\i_mix_reg[15]_0 [14]),
        .I1(\i_mix_reg[15]_1 [14]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [14]),
        .O(\i_mix[15]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[15]_i_7 
       (.I0(\i_mix_reg[15]_0 [13]),
        .I1(\i_mix_reg[15]_1 [13]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [13]),
        .O(\i_mix[15]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[15]_i_8 
       (.I0(\i_mix_reg[15]_0 [12]),
        .I1(\i_mix_reg[15]_1 [12]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [12]),
        .O(\i_mix[15]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[3]_i_6 
       (.I0(\i_mix_reg[15]_0 [3]),
        .I1(\i_mix_reg[15]_1 [3]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [3]),
        .O(\i_mix[3]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[3]_i_7 
       (.I0(\i_mix_reg[15]_0 [2]),
        .I1(\i_mix_reg[15]_1 [2]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [2]),
        .O(\i_mix[3]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[3]_i_8 
       (.I0(\i_mix_reg[15]_0 [1]),
        .I1(\i_mix_reg[15]_1 [1]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [1]),
        .O(\i_mix[3]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[3]_i_9 
       (.I0(\i_mix_reg[15]_0 [0]),
        .I1(\i_mix_reg[15]_1 [0]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [0]),
        .O(\i_mix[3]_i_9_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[7]_i_6 
       (.I0(\i_mix_reg[15]_0 [7]),
        .I1(\i_mix_reg[15]_1 [7]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [7]),
        .O(\i_mix[7]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[7]_i_7 
       (.I0(\i_mix_reg[15]_0 [6]),
        .I1(\i_mix_reg[15]_1 [6]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [6]),
        .O(\i_mix[7]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[7]_i_8 
       (.I0(\i_mix_reg[15]_0 [5]),
        .I1(\i_mix_reg[15]_1 [5]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [5]),
        .O(\i_mix[7]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \i_mix[7]_i_9 
       (.I0(\i_mix_reg[15]_0 [4]),
        .I1(\i_mix_reg[15]_1 [4]),
        .I2(core_bypass_costas),
        .I3(\i_out_reg[15]_0 [4]),
        .O(\i_mix[7]_i_9_n_0 ));
  CARRY4 \i_mix_reg[11]_i_1 
       (.CI(\i_mix_reg[7]_i_1_n_0 ),
        .CO({\i_mix_reg[11]_i_1_n_0 ,\i_mix_reg[11]_i_1_n_1 ,\i_mix_reg[11]_i_1_n_2 ,\i_mix_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\i_mix_reg[11] ),
        .O(out[11:8]),
        .S({\i_mix[11]_i_6_n_0 ,\i_mix[11]_i_7_n_0 ,\i_mix[11]_i_8_n_0 ,\i_mix[11]_i_9_n_0 }));
  CARRY4 \i_mix_reg[15]_i_1 
       (.CI(\i_mix_reg[11]_i_1_n_0 ),
        .CO({\NLW_i_mix_reg[15]_i_1_CO_UNCONNECTED [3],\i_mix_reg[15]_i_1_n_1 ,\i_mix_reg[15]_i_1_n_2 ,\i_mix_reg[15]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\i_mix_reg[15] }),
        .O(out[15:12]),
        .S({\i_mix[15]_i_5_n_0 ,\i_mix[15]_i_6_n_0 ,\i_mix[15]_i_7_n_0 ,\i_mix[15]_i_8_n_0 }));
  CARRY4 \i_mix_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\i_mix_reg[3]_i_1_n_0 ,\i_mix_reg[3]_i_1_n_1 ,\i_mix_reg[3]_i_1_n_2 ,\i_mix_reg[3]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\i_mix_reg[3] ),
        .O(out[3:0]),
        .S({\i_mix[3]_i_6_n_0 ,\i_mix[3]_i_7_n_0 ,\i_mix[3]_i_8_n_0 ,\i_mix[3]_i_9_n_0 }));
  CARRY4 \i_mix_reg[7]_i_1 
       (.CI(\i_mix_reg[3]_i_1_n_0 ),
        .CO({\i_mix_reg[7]_i_1_n_0 ,\i_mix_reg[7]_i_1_n_1 ,\i_mix_reg[7]_i_1_n_2 ,\i_mix_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\i_mix_reg[7] ),
        .O(out[7:4]),
        .S({\i_mix[7]_i_6_n_0 ,\i_mix[7]_i_7_n_0 ,\i_mix[7]_i_8_n_0 ,\i_mix[7]_i_9_n_0 }));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[0]_i_1 
       (.I0(adc_data[0]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_93),
        .O(\i_out[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[10]_i_1 
       (.I0(adc_data[10]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_83),
        .O(\i_out[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[11]_i_1 
       (.I0(adc_data[11]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_82),
        .O(\i_out[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[12]_i_1 
       (.I0(adc_data[12]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_81),
        .O(\i_out[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[13]_i_1 
       (.I0(adc_data[13]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_80),
        .O(\i_out[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[14]_i_1 
       (.I0(adc_data[14]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_79),
        .O(\i_out[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFE)) 
    \i_out[14]_i_2 
       (.I0(p_0_in[3]),
        .I1(p_0_in[4]),
        .I2(p_0_in[2]),
        .I3(p_0_in[1]),
        .I4(p_0_in[0]),
        .O(\i_out[14]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \i_out[15]_i_1 
       (.I0(adc_data[15]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .O(\i_out[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[1]_i_1 
       (.I0(adc_data[1]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_92),
        .O(\i_out[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[2]_i_1 
       (.I0(adc_data[2]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_91),
        .O(\i_out[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[3]_i_1 
       (.I0(adc_data[3]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_90),
        .O(\i_out[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[4]_i_1 
       (.I0(adc_data[4]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_89),
        .O(\i_out[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[5]_i_1 
       (.I0(adc_data[5]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_88),
        .O(\i_out[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[6]_i_1 
       (.I0(adc_data[6]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_87),
        .O(\i_out[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[7]_i_1 
       (.I0(adc_data[7]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_86),
        .O(\i_out[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[8]_i_1 
       (.I0(adc_data[8]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_85),
        .O(\i_out[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \i_out[9]_i_1 
       (.I0(adc_data[9]),
        .I1(core_bypass_agc),
        .I2(p_0_in[4]),
        .I3(\i_out[14]_i_2_n_0 ),
        .I4(prod_i_n_84),
        .O(\i_out[9]_i_1_n_0 ));
  FDCE \i_out_reg[0] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[0]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [0]));
  FDCE \i_out_reg[10] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[10]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [10]));
  FDCE \i_out_reg[11] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[11]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [11]));
  FDCE \i_out_reg[12] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[12]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [12]));
  FDCE \i_out_reg[13] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[13]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [13]));
  FDCE \i_out_reg[14] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[14]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [14]));
  FDCE \i_out_reg[15] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[15]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [15]));
  FDCE \i_out_reg[1] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[1]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [1]));
  FDCE \i_out_reg[2] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[2]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [2]));
  FDCE \i_out_reg[3] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[3]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [3]));
  FDCE \i_out_reg[4] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[4]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [4]));
  FDCE \i_out_reg[5] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[5]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [5]));
  FDCE \i_out_reg[6] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[6]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [6]));
  FDCE \i_out_reg[7] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[7]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [7]));
  FDCE \i_out_reg[8] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[8]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [8]));
  FDCE \i_out_reg[9] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\i_out[9]_i_1_n_0 ),
        .Q(\i_out_reg[15]_0 [9]));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 in_range_carry
       (.CI(1'b0),
        .CO({in_range_carry_n_0,in_range_carry_n_1,in_range_carry_n_2,in_range_carry_n_3}),
        .CYINIT(1'b0),
        .DI({in_range_carry_i_1_n_0,in_range_carry_i_2_n_0,in_range_carry_i_3_n_0,in_range_carry_i_4_n_0}),
        .O(NLW_in_range_carry_O_UNCONNECTED[3:0]),
        .S({in_range_carry_i_5_n_0,in_range_carry_i_6_n_0,in_range_carry_i_7_n_0,in_range_carry_i_8_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 in_range_carry__0
       (.CI(in_range_carry_n_0),
        .CO({in_range,in_range_carry__0_n_1,in_range_carry__0_n_2,in_range_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,in_range_carry__0_i_1_n_0,in_range_carry__0_i_2_n_0,in_range_carry__0_i_3_n_0}),
        .O(NLW_in_range_carry__0_O_UNCONNECTED[3:0]),
        .S({in_range_carry__0_i_4_n_0,in_range_carry__0_i_5_n_0,in_range_carry__0_i_6_n_0,in_range_carry__0_i_7_n_0}));
  LUT6 #(
    .INIT(64'h0000003050500030)) 
    in_range_carry__0_i_1
       (.I0(error_s32[12]),
        .I1(err_abs0[12]),
        .I2(\gain_acc[11]_i_8_0 [15]),
        .I3(err_abs0[13]),
        .I4(error_carry__3_n_2),
        .I5(error_s32[13]),
        .O(in_range_carry__0_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    in_range_carry__0_i_10
       (.I0(error_s32[11]),
        .I1(error_carry__3_n_2),
        .I2(err_abs0[11]),
        .O(in_range_carry__0_i_10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    in_range_carry__0_i_11
       (.I0(error_s32[9]),
        .I1(error_carry__3_n_2),
        .I2(err_abs0[9]),
        .O(in_range_carry__0_i_11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hA959)) 
    in_range_carry__0_i_12
       (.I0(\gain_acc[11]_i_8_0 [14]),
        .I1(err_abs0[11]),
        .I2(error_carry__3_n_2),
        .I3(error_s32[11]),
        .O(in_range_carry__0_i_12_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hA959)) 
    in_range_carry__0_i_13
       (.I0(\gain_acc[11]_i_8_0 [12]),
        .I1(err_abs0[9]),
        .I2(error_carry__3_n_2),
        .I3(error_s32[9]),
        .O(in_range_carry__0_i_13_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry__0_i_14
       (.I0(error_s32[12]),
        .O(err_abs1[12]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry__0_i_15
       (.I0(error_s32[11]),
        .O(err_abs1[11]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry__0_i_16
       (.I0(error_s32[10]),
        .O(err_abs1[10]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry__0_i_17
       (.I0(error_s32[9]),
        .O(err_abs1[9]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry__0_i_18
       (.I0(error_s32[15]),
        .O(err_abs1[15]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry__0_i_19
       (.I0(error_s32[14]),
        .O(err_abs1[14]));
  LUT6 #(
    .INIT(64'h222222B2B2B222B2)) 
    in_range_carry__0_i_2
       (.I0(\gain_acc[11]_i_8_0 [14]),
        .I1(in_range_carry__0_i_10_n_0),
        .I2(\gain_acc[11]_i_8_0 [13]),
        .I3(err_abs0[10]),
        .I4(error_carry__3_n_2),
        .I5(error_s32[10]),
        .O(in_range_carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry__0_i_20
       (.I0(error_s32[13]),
        .O(err_abs1[13]));
  LUT6 #(
    .INIT(64'h222222B2B2B222B2)) 
    in_range_carry__0_i_3
       (.I0(\gain_acc[11]_i_8_0 [12]),
        .I1(in_range_carry__0_i_11_n_0),
        .I2(\gain_acc[11]_i_8_0 [11]),
        .I3(err_abs0[8]),
        .I4(error_carry__3_n_2),
        .I5(error_s32[8]),
        .O(in_range_carry__0_i_3_n_0));
  LUT5 #(
    .INIT(32'h1010101F)) 
    in_range_carry__0_i_4
       (.I0(error_s32[14]),
        .I1(error_s32[15]),
        .I2(error_carry__3_n_2),
        .I3(err_abs0[14]),
        .I4(err_abs0[15]),
        .O(in_range_carry__0_i_4_n_0));
  LUT6 #(
    .INIT(64'h3055300003000355)) 
    in_range_carry__0_i_5
       (.I0(err_abs0[13]),
        .I1(error_s32[13]),
        .I2(error_s32[12]),
        .I3(error_carry__3_n_2),
        .I4(err_abs0[12]),
        .I5(\gain_acc[11]_i_8_0 [15]),
        .O(in_range_carry__0_i_5_n_0));
  LUT5 #(
    .INIT(32'h8A80202A)) 
    in_range_carry__0_i_6
       (.I0(in_range_carry__0_i_12_n_0),
        .I1(error_s32[10]),
        .I2(error_carry__3_n_2),
        .I3(err_abs0[10]),
        .I4(\gain_acc[11]_i_8_0 [13]),
        .O(in_range_carry__0_i_6_n_0));
  LUT5 #(
    .INIT(32'h8A80202A)) 
    in_range_carry__0_i_7
       (.I0(in_range_carry__0_i_13_n_0),
        .I1(error_s32[8]),
        .I2(error_carry__3_n_2),
        .I3(err_abs0[8]),
        .I4(\gain_acc[11]_i_8_0 [11]),
        .O(in_range_carry__0_i_7_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 in_range_carry__0_i_8
       (.CI(in_range_carry_i_10_n_0),
        .CO({in_range_carry__0_i_8_n_0,in_range_carry__0_i_8_n_1,in_range_carry__0_i_8_n_2,in_range_carry__0_i_8_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(err_abs0[12:9]),
        .S(err_abs1[12:9]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 in_range_carry__0_i_9
       (.CI(in_range_carry__0_i_8_n_0),
        .CO({NLW_in_range_carry__0_i_9_CO_UNCONNECTED[3:2],in_range_carry__0_i_9_n_2,in_range_carry__0_i_9_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_in_range_carry__0_i_9_O_UNCONNECTED[3],err_abs0[15:13]}),
        .S({1'b0,err_abs1[15:13]}));
  LUT6 #(
    .INIT(64'h222222B2B2B222B2)) 
    in_range_carry_i_1
       (.I0(\gain_acc[11]_i_8_0 [10]),
        .I1(in_range_carry_i_9_n_0),
        .I2(\gain_acc[11]_i_8_0 [9]),
        .I3(err_abs0[6]),
        .I4(error_carry__3_n_2),
        .I5(error_s32[6]),
        .O(in_range_carry_i_1_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 in_range_carry_i_10
       (.CI(in_range_carry_i_12_n_0),
        .CO({in_range_carry_i_10_n_0,in_range_carry_i_10_n_1,in_range_carry_i_10_n_2,in_range_carry_i_10_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(err_abs0[8:5]),
        .S(err_abs1[8:5]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    in_range_carry_i_11
       (.I0(error_s32[5]),
        .I1(error_carry__3_n_2),
        .I2(err_abs0[5]),
        .O(in_range_carry_i_11_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 in_range_carry_i_12
       (.CI(1'b0),
        .CO({in_range_carry_i_12_n_0,in_range_carry_i_12_n_1,in_range_carry_i_12_n_2,in_range_carry_i_12_n_3}),
        .CYINIT(err_abs1[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(err_abs0[4:1]),
        .S(err_abs1[4:1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    in_range_carry_i_13
       (.I0(error_s32[3]),
        .I1(error_carry__3_n_2),
        .I2(err_abs0[3]),
        .O(in_range_carry_i_13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hA959)) 
    in_range_carry_i_14
       (.I0(\gain_acc[11]_i_8_0 [10]),
        .I1(err_abs0[7]),
        .I2(error_carry__3_n_2),
        .I3(error_s32[7]),
        .O(in_range_carry_i_14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hA959)) 
    in_range_carry_i_15
       (.I0(\gain_acc[11]_i_8_0 [8]),
        .I1(err_abs0[5]),
        .I2(error_carry__3_n_2),
        .I3(error_s32[5]),
        .O(in_range_carry_i_15_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hA959)) 
    in_range_carry_i_16
       (.I0(\gain_acc[11]_i_8_0 [6]),
        .I1(err_abs0[3]),
        .I2(error_carry__3_n_2),
        .I3(error_s32[3]),
        .O(in_range_carry_i_16_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry_i_17
       (.I0(error_s32[8]),
        .O(err_abs1[8]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry_i_18
       (.I0(error_s32[7]),
        .O(err_abs1[7]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry_i_19
       (.I0(error_s32[6]),
        .O(err_abs1[6]));
  LUT6 #(
    .INIT(64'h222222B2B2B222B2)) 
    in_range_carry_i_2
       (.I0(\gain_acc[11]_i_8_0 [8]),
        .I1(in_range_carry_i_11_n_0),
        .I2(\gain_acc[11]_i_8_0 [7]),
        .I3(err_abs0[4]),
        .I4(error_carry__3_n_2),
        .I5(error_s32[4]),
        .O(in_range_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry_i_20
       (.I0(error_s32[5]),
        .O(err_abs1[5]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry_i_21
       (.I0(error_s32[0]),
        .O(err_abs1[0]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry_i_22
       (.I0(error_s32[4]),
        .O(err_abs1[4]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry_i_23
       (.I0(error_s32[3]),
        .O(err_abs1[3]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry_i_24
       (.I0(error_s32[2]),
        .O(err_abs1[2]));
  LUT1 #(
    .INIT(2'h1)) 
    in_range_carry_i_25
       (.I0(error_s32[1]),
        .O(err_abs1[1]));
  LUT6 #(
    .INIT(64'h222222B2B2B222B2)) 
    in_range_carry_i_3
       (.I0(\gain_acc[11]_i_8_0 [6]),
        .I1(in_range_carry_i_13_n_0),
        .I2(\gain_acc[11]_i_8_0 [5]),
        .I3(err_abs0[2]),
        .I4(error_carry__3_n_2),
        .I5(error_s32[2]),
        .O(in_range_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h02A202A2ABFB02A2)) 
    in_range_carry_i_4
       (.I0(\gain_acc[11]_i_8_0 [4]),
        .I1(err_abs0[1]),
        .I2(error_carry__3_n_2),
        .I3(error_s32[1]),
        .I4(\gain_acc[11]_i_8_0 [3]),
        .I5(error_s32[0]),
        .O(in_range_carry_i_4_n_0));
  LUT5 #(
    .INIT(32'h8A80202A)) 
    in_range_carry_i_5
       (.I0(in_range_carry_i_14_n_0),
        .I1(error_s32[6]),
        .I2(error_carry__3_n_2),
        .I3(err_abs0[6]),
        .I4(\gain_acc[11]_i_8_0 [9]),
        .O(in_range_carry_i_5_n_0));
  LUT5 #(
    .INIT(32'h8A80202A)) 
    in_range_carry_i_6
       (.I0(in_range_carry_i_15_n_0),
        .I1(error_s32[4]),
        .I2(error_carry__3_n_2),
        .I3(err_abs0[4]),
        .I4(\gain_acc[11]_i_8_0 [7]),
        .O(in_range_carry_i_6_n_0));
  LUT5 #(
    .INIT(32'h8A80202A)) 
    in_range_carry_i_7
       (.I0(in_range_carry_i_16_n_0),
        .I1(error_s32[2]),
        .I2(error_carry__3_n_2),
        .I3(err_abs0[2]),
        .I4(\gain_acc[11]_i_8_0 [5]),
        .O(in_range_carry_i_7_n_0));
  LUT6 #(
    .INIT(64'hB84700000000B847)) 
    in_range_carry_i_8
       (.I0(error_s32[1]),
        .I1(error_carry__3_n_2),
        .I2(err_abs0[1]),
        .I3(\gain_acc[11]_i_8_0 [4]),
        .I4(error_s32[0]),
        .I5(\gain_acc[11]_i_8_0 [3]),
        .O(in_range_carry_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    in_range_carry_i_9
       (.I0(error_s32[7]),
        .I1(error_carry__3_n_2),
        .I2(err_abs0[7]),
        .O(in_range_carry_i_9_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-13 {cell *THIS*}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(0),
    .BREG(0),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    prod_i
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,Q}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_prod_i_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({adc_data[15],adc_data[15],adc_data[15:0]}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_prod_i_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_prod_i_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_prod_i_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CLK(1'b0),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_prod_i_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_prod_i_OVERFLOW_UNCONNECTED),
        .P({NLW_prod_i_P_UNCONNECTED[47:36],prod_i_n_70,prod_i_n_71,prod_i_n_72,prod_i_n_73,p_0_in,prod_i_n_79,prod_i_n_80,prod_i_n_81,prod_i_n_82,prod_i_n_83,prod_i_n_84,prod_i_n_85,prod_i_n_86,prod_i_n_87,prod_i_n_88,prod_i_n_89,prod_i_n_90,prod_i_n_91,prod_i_n_92,prod_i_n_93,prod_i_n_94,prod_i_n_95,prod_i_n_96,prod_i_n_97,prod_i_n_98,prod_i_n_99,prod_i_n_100,prod_i_n_101,prod_i_n_102,prod_i_n_103,prod_i_n_104,prod_i_n_105}),
        .PATTERNBDETECT(NLW_prod_i_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_prod_i_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_prod_i_PCOUT_UNCONNECTED[47:0]),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_prod_i_UNDERFLOW_UNCONNECTED));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-13 {cell *THIS*}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(0),
    .BREG(0),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    prod_q
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,Q}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_prod_q_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({adc_data[31],adc_data[31],adc_data[31:16]}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_prod_q_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_prod_q_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_prod_q_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CLK(1'b0),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_prod_q_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_prod_q_OVERFLOW_UNCONNECTED),
        .P({NLW_prod_q_P_UNCONNECTED[47:36],prod_q_n_70,prod_q_n_71,prod_q_n_72,prod_q_n_73,prod_q_n_74,prod_q_n_75,prod_q_n_76,prod_q_n_77,prod_q_n_78,prod_q_n_79,prod_q_n_80,prod_q_n_81,prod_q_n_82,prod_q_n_83,prod_q_n_84,prod_q_n_85,prod_q_n_86,prod_q_n_87,prod_q_n_88,prod_q_n_89,prod_q_n_90,prod_q_n_91,prod_q_n_92,prod_q_n_93,prod_q_n_94,prod_q_n_95,prod_q_n_96,prod_q_n_97,prod_q_n_98,prod_q_n_99,prod_q_n_100,prod_q_n_101,prod_q_n_102,prod_q_n_103,prod_q_n_104,prod_q_n_105}),
        .PATTERNBDETECT(NLW_prod_q_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_prod_q_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_prod_q_PCOUT_UNCONNECTED[47:0]),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_prod_q_UNDERFLOW_UNCONNECTED));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[11]_i_6 
       (.I0(p_1_out[10]),
        .I1(\q_mix_reg[15]_0 [11]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [11]),
        .O(\q_mix[11]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[11]_i_7 
       (.I0(p_1_out[9]),
        .I1(\q_mix_reg[15]_0 [10]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [10]),
        .O(\q_mix[11]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[11]_i_8 
       (.I0(p_1_out[8]),
        .I1(\q_mix_reg[15]_0 [9]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [9]),
        .O(\q_mix[11]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[11]_i_9 
       (.I0(p_1_out[7]),
        .I1(\q_mix_reg[15]_0 [8]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [8]),
        .O(\q_mix[11]_i_9_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[15]_i_5 
       (.I0(p_1_out[14]),
        .I1(\q_mix_reg[15]_0 [15]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [15]),
        .O(\q_mix[15]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[15]_i_6 
       (.I0(p_1_out[13]),
        .I1(\q_mix_reg[15]_0 [14]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [14]),
        .O(\q_mix[15]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[15]_i_7 
       (.I0(p_1_out[12]),
        .I1(\q_mix_reg[15]_0 [13]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [13]),
        .O(\q_mix[15]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[15]_i_8 
       (.I0(p_1_out[11]),
        .I1(\q_mix_reg[15]_0 [12]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [12]),
        .O(\q_mix[15]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[3]_i_6 
       (.I0(p_1_out[2]),
        .I1(\q_mix_reg[15]_0 [3]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [3]),
        .O(\q_mix[3]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[3]_i_7 
       (.I0(p_1_out[1]),
        .I1(\q_mix_reg[15]_0 [2]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [2]),
        .O(\q_mix[3]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[3]_i_8 
       (.I0(p_1_out[0]),
        .I1(\q_mix_reg[15]_0 [1]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [1]),
        .O(\q_mix[3]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[3]_i_9 
       (.I0(P),
        .I1(\q_mix_reg[15]_0 [0]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [0]),
        .O(\q_mix[3]_i_9_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[7]_i_6 
       (.I0(p_1_out[6]),
        .I1(\q_mix_reg[15]_0 [7]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [7]),
        .O(\q_mix[7]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[7]_i_7 
       (.I0(p_1_out[5]),
        .I1(\q_mix_reg[15]_0 [6]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [6]),
        .O(\q_mix[7]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[7]_i_8 
       (.I0(p_1_out[4]),
        .I1(\q_mix_reg[15]_0 [5]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [5]),
        .O(\q_mix[7]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hF606)) 
    \q_mix[7]_i_9 
       (.I0(p_1_out[3]),
        .I1(\q_mix_reg[15]_0 [4]),
        .I2(core_bypass_costas),
        .I3(\q_out_reg[15]_0 [4]),
        .O(\q_mix[7]_i_9_n_0 ));
  CARRY4 \q_mix_reg[11]_i_1 
       (.CI(\q_mix_reg[7]_i_1_n_0 ),
        .CO({\q_mix_reg[11]_i_1_n_0 ,\q_mix_reg[11]_i_1_n_1 ,\q_mix_reg[11]_i_1_n_2 ,\q_mix_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\q_mix_reg[11] ),
        .O(core_bypass_costas_reg[11:8]),
        .S({\q_mix[11]_i_6_n_0 ,\q_mix[11]_i_7_n_0 ,\q_mix[11]_i_8_n_0 ,\q_mix[11]_i_9_n_0 }));
  CARRY4 \q_mix_reg[15]_i_1 
       (.CI(\q_mix_reg[11]_i_1_n_0 ),
        .CO({\NLW_q_mix_reg[15]_i_1_CO_UNCONNECTED [3],\q_mix_reg[15]_i_1_n_1 ,\q_mix_reg[15]_i_1_n_2 ,\q_mix_reg[15]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\q_mix_reg[15] }),
        .O(core_bypass_costas_reg[15:12]),
        .S({\q_mix[15]_i_5_n_0 ,\q_mix[15]_i_6_n_0 ,\q_mix[15]_i_7_n_0 ,\q_mix[15]_i_8_n_0 }));
  CARRY4 \q_mix_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\q_mix_reg[3]_i_1_n_0 ,\q_mix_reg[3]_i_1_n_1 ,\q_mix_reg[3]_i_1_n_2 ,\q_mix_reg[3]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(DI),
        .O(core_bypass_costas_reg[3:0]),
        .S({\q_mix[3]_i_6_n_0 ,\q_mix[3]_i_7_n_0 ,\q_mix[3]_i_8_n_0 ,\q_mix[3]_i_9_n_0 }));
  CARRY4 \q_mix_reg[7]_i_1 
       (.CI(\q_mix_reg[3]_i_1_n_0 ),
        .CO({\q_mix_reg[7]_i_1_n_0 ,\q_mix_reg[7]_i_1_n_1 ,\q_mix_reg[7]_i_1_n_2 ,\q_mix_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\q_mix_reg[7] ),
        .O(core_bypass_costas_reg[7:4]),
        .S({\q_mix[7]_i_6_n_0 ,\q_mix[7]_i_7_n_0 ,\q_mix[7]_i_8_n_0 ,\q_mix[7]_i_9_n_0 }));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[0]_i_1 
       (.I0(adc_data[16]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_93),
        .O(\q_out[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[10]_i_1 
       (.I0(adc_data[26]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_83),
        .O(\q_out[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[11]_i_1 
       (.I0(adc_data[27]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_82),
        .O(\q_out[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[12]_i_1 
       (.I0(adc_data[28]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_81),
        .O(\q_out[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[13]_i_1 
       (.I0(adc_data[29]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_80),
        .O(\q_out[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[14]_i_1 
       (.I0(adc_data[30]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_79),
        .O(\q_out[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFE)) 
    \q_out[14]_i_2 
       (.I0(prod_q_n_75),
        .I1(prod_q_n_74),
        .I2(prod_q_n_76),
        .I3(prod_q_n_77),
        .I4(prod_q_n_78),
        .O(\q_out[14]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \q_out[15]_i_1 
       (.I0(adc_data[31]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .O(\q_out[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[1]_i_1 
       (.I0(adc_data[17]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_92),
        .O(\q_out[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[2]_i_1 
       (.I0(adc_data[18]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_91),
        .O(\q_out[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[3]_i_1 
       (.I0(adc_data[19]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_90),
        .O(\q_out[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[4]_i_1 
       (.I0(adc_data[20]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_89),
        .O(\q_out[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[5]_i_1 
       (.I0(adc_data[21]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_88),
        .O(\q_out[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[6]_i_1 
       (.I0(adc_data[22]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_87),
        .O(\q_out[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[7]_i_1 
       (.I0(adc_data[23]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_86),
        .O(\q_out[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[8]_i_1 
       (.I0(adc_data[24]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_85),
        .O(\q_out[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8BBB8B88)) 
    \q_out[9]_i_1 
       (.I0(adc_data[25]),
        .I1(core_bypass_agc),
        .I2(prod_q_n_74),
        .I3(\q_out[14]_i_2_n_0 ),
        .I4(prod_q_n_84),
        .O(\q_out[9]_i_1_n_0 ));
  FDCE \q_out_reg[0] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[0]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [0]));
  FDCE \q_out_reg[10] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[10]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [10]));
  FDCE \q_out_reg[11] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[11]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [11]));
  FDCE \q_out_reg[12] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[12]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [12]));
  FDCE \q_out_reg[13] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[13]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [13]));
  FDCE \q_out_reg[14] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[14]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [14]));
  FDCE \q_out_reg[15] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[15]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [15]));
  FDCE \q_out_reg[1] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[1]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [1]));
  FDCE \q_out_reg[2] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[2]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [2]));
  FDCE \q_out_reg[3] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[3]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [3]));
  FDCE \q_out_reg[4] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[4]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [4]));
  FDCE \q_out_reg[5] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[5]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [5]));
  FDCE \q_out_reg[6] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[6]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [6]));
  FDCE \q_out_reg[7] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[7]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [7]));
  FDCE \q_out_reg[8] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[8]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [8]));
  FDCE \q_out_reg[9] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\q_out[9]_i_1_n_0 ),
        .Q(\q_out_reg[15]_0 [9]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \settle_cnt[0]_i_1 
       (.I0(in_range),
        .I1(\settle_cnt_reg_n_0_[0] ),
        .O(\settle_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h60)) 
    \settle_cnt[1]_i_1 
       (.I0(\settle_cnt_reg_n_0_[1] ),
        .I1(\settle_cnt_reg_n_0_[0] ),
        .I2(in_range),
        .O(\settle_cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h2A80)) 
    \settle_cnt[2]_i_1 
       (.I0(in_range),
        .I1(\settle_cnt_reg_n_0_[0] ),
        .I2(\settle_cnt_reg_n_0_[1] ),
        .I3(\settle_cnt_reg_n_0_[2] ),
        .O(\settle_cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h2AAA8000)) 
    \settle_cnt[3]_i_1 
       (.I0(in_range),
        .I1(\settle_cnt_reg_n_0_[1] ),
        .I2(\settle_cnt_reg_n_0_[0] ),
        .I3(\settle_cnt_reg_n_0_[2] ),
        .I4(\settle_cnt_reg_n_0_[3] ),
        .O(\settle_cnt[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF800000000000)) 
    \settle_cnt[4]_i_1 
       (.I0(\settle_cnt_reg_n_0_[3] ),
        .I1(\settle_cnt_reg_n_0_[2] ),
        .I2(\settle_cnt_reg_n_0_[0] ),
        .I3(\settle_cnt_reg_n_0_[1] ),
        .I4(\settle_cnt_reg_n_0_[4] ),
        .I5(in_range),
        .O(\settle_cnt[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0888)) 
    \settle_cnt[5]_i_1 
       (.I0(adc_valid),
        .I1(core_enable),
        .I2(in_range),
        .I3(\settle_cnt[5]_i_3_n_0 ),
        .O(settle_cnt));
  LUT3 #(
    .INIT(8'h82)) 
    \settle_cnt[5]_i_2 
       (.I0(in_range),
        .I1(\settle_cnt[5]_i_4_n_0 ),
        .I2(\settle_cnt_reg_n_0_[5] ),
        .O(\settle_cnt[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \settle_cnt[5]_i_3 
       (.I0(\settle_cnt_reg_n_0_[5] ),
        .I1(\settle_cnt_reg_n_0_[3] ),
        .I2(\settle_cnt_reg_n_0_[2] ),
        .I3(\settle_cnt_reg_n_0_[0] ),
        .I4(\settle_cnt_reg_n_0_[1] ),
        .I5(\settle_cnt_reg_n_0_[4] ),
        .O(\settle_cnt[5]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \settle_cnt[5]_i_4 
       (.I0(\settle_cnt_reg_n_0_[4] ),
        .I1(\settle_cnt_reg_n_0_[1] ),
        .I2(\settle_cnt_reg_n_0_[0] ),
        .I3(\settle_cnt_reg_n_0_[2] ),
        .I4(\settle_cnt_reg_n_0_[3] ),
        .O(\settle_cnt[5]_i_4_n_0 ));
  FDCE \settle_cnt_reg[0] 
       (.C(aclk),
        .CE(settle_cnt),
        .CLR(aresetn_0),
        .D(\settle_cnt[0]_i_1_n_0 ),
        .Q(\settle_cnt_reg_n_0_[0] ));
  FDCE \settle_cnt_reg[1] 
       (.C(aclk),
        .CE(settle_cnt),
        .CLR(aresetn_0),
        .D(\settle_cnt[1]_i_1_n_0 ),
        .Q(\settle_cnt_reg_n_0_[1] ));
  FDCE \settle_cnt_reg[2] 
       (.C(aclk),
        .CE(settle_cnt),
        .CLR(aresetn_0),
        .D(\settle_cnt[2]_i_1_n_0 ),
        .Q(\settle_cnt_reg_n_0_[2] ));
  FDCE \settle_cnt_reg[3] 
       (.C(aclk),
        .CE(settle_cnt),
        .CLR(aresetn_0),
        .D(\settle_cnt[3]_i_1_n_0 ),
        .Q(\settle_cnt_reg_n_0_[3] ));
  FDCE \settle_cnt_reg[4] 
       (.C(aclk),
        .CE(settle_cnt),
        .CLR(aresetn_0),
        .D(\settle_cnt[4]_i_1_n_0 ),
        .Q(\settle_cnt_reg_n_0_[4] ));
  FDCE \settle_cnt_reg[5] 
       (.C(aclk),
        .CE(settle_cnt),
        .CLR(aresetn_0),
        .D(\settle_cnt[5]_i_2_n_0 ),
        .Q(\settle_cnt_reg_n_0_[5] ));
  LUT5 #(
    .INIT(32'hFF778000)) 
    settled_i_1
       (.I0(adc_valid),
        .I1(core_enable),
        .I2(\settle_cnt[5]_i_3_n_0 ),
        .I3(in_range),
        .I4(D),
        .O(settled_i_1_n_0));
  FDCE settled_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(settled_i_1_n_0),
        .Q(D));
endmodule

(* ORIG_REF_NAME = "bpsk_demod_core" *) 
module system_bpsk_demodulator_0_0_bpsk_demod_core
   (E,
    agc_gain_out,
    aresetn_0,
    B,
    timing_err_out,
    M_AXIS_BITS_TDATA,
    M_AXIS_BITS_TVALID,
    bit_count,
    D,
    c_locked_reg_0,
    core_enable,
    core_bypass_timing,
    Q,
    \sps_eff_reg[7]_0 ,
    core_bypass_costas,
    OPMODE,
    \gain_acc[11]_i_3 ,
    adc_data,
    aclk,
    freq_int2_0,
    freq_word2_0,
    timing_int0_0,
    timing_adj2_0,
    adc_valid,
    core_bypass_agc,
    M_AXIS_BITS_TREADY,
    aresetn);
  output [0:0]E;
  output [15:0]agc_gain_out;
  output aresetn_0;
  output [15:0]B;
  output [15:0]timing_err_out;
  output [7:0]M_AXIS_BITS_TDATA;
  output M_AXIS_BITS_TVALID;
  output [39:0]bit_count;
  output [0:0]D;
  output [0:0]c_locked_reg_0;
  input core_enable;
  input core_bypass_timing;
  input [15:0]Q;
  input [7:0]\sps_eff_reg[7]_0 ;
  input core_bypass_costas;
  input [0:0]OPMODE;
  input [3:0]\gain_acc[11]_i_3 ;
  input [31:0]adc_data;
  input aclk;
  input [15:0]freq_int2_0;
  input [15:0]freq_word2_0;
  input [15:0]timing_int0_0;
  input [15:0]timing_adj2_0;
  input adc_valid;
  input core_bypass_agc;
  input M_AXIS_BITS_TREADY;
  input aresetn;

  wire [15:0]A;
  wire [15:0]B;
  wire [15:0]B_0;
  wire [0:0]D;
  wire [0:0]E;
  wire [7:0]M_AXIS_BITS_TDATA;
  wire M_AXIS_BITS_TREADY;
  wire M_AXIS_BITS_TVALID;
  wire [0:0]OPMODE;
  wire [15:0]Q;
  wire aclk;
  wire [31:0]adc_data;
  wire adc_valid;
  wire adc_valid_d1;
  wire adc_valid_d10;
  wire [15:0]agc_gain_out;
  wire aresetn;
  wire aresetn_0;
  wire [39:0]bit_count;
  wire \bit_count[0]_i_2_n_0 ;
  wire \bit_count_reg[0]_i_1_n_0 ;
  wire \bit_count_reg[0]_i_1_n_1 ;
  wire \bit_count_reg[0]_i_1_n_2 ;
  wire \bit_count_reg[0]_i_1_n_3 ;
  wire \bit_count_reg[0]_i_1_n_4 ;
  wire \bit_count_reg[0]_i_1_n_5 ;
  wire \bit_count_reg[0]_i_1_n_6 ;
  wire \bit_count_reg[0]_i_1_n_7 ;
  wire \bit_count_reg[12]_i_1_n_0 ;
  wire \bit_count_reg[12]_i_1_n_1 ;
  wire \bit_count_reg[12]_i_1_n_2 ;
  wire \bit_count_reg[12]_i_1_n_3 ;
  wire \bit_count_reg[12]_i_1_n_4 ;
  wire \bit_count_reg[12]_i_1_n_5 ;
  wire \bit_count_reg[12]_i_1_n_6 ;
  wire \bit_count_reg[12]_i_1_n_7 ;
  wire \bit_count_reg[16]_i_1_n_0 ;
  wire \bit_count_reg[16]_i_1_n_1 ;
  wire \bit_count_reg[16]_i_1_n_2 ;
  wire \bit_count_reg[16]_i_1_n_3 ;
  wire \bit_count_reg[16]_i_1_n_4 ;
  wire \bit_count_reg[16]_i_1_n_5 ;
  wire \bit_count_reg[16]_i_1_n_6 ;
  wire \bit_count_reg[16]_i_1_n_7 ;
  wire \bit_count_reg[20]_i_1_n_0 ;
  wire \bit_count_reg[20]_i_1_n_1 ;
  wire \bit_count_reg[20]_i_1_n_2 ;
  wire \bit_count_reg[20]_i_1_n_3 ;
  wire \bit_count_reg[20]_i_1_n_4 ;
  wire \bit_count_reg[20]_i_1_n_5 ;
  wire \bit_count_reg[20]_i_1_n_6 ;
  wire \bit_count_reg[20]_i_1_n_7 ;
  wire \bit_count_reg[24]_i_1_n_0 ;
  wire \bit_count_reg[24]_i_1_n_1 ;
  wire \bit_count_reg[24]_i_1_n_2 ;
  wire \bit_count_reg[24]_i_1_n_3 ;
  wire \bit_count_reg[24]_i_1_n_4 ;
  wire \bit_count_reg[24]_i_1_n_5 ;
  wire \bit_count_reg[24]_i_1_n_6 ;
  wire \bit_count_reg[24]_i_1_n_7 ;
  wire \bit_count_reg[28]_i_1_n_0 ;
  wire \bit_count_reg[28]_i_1_n_1 ;
  wire \bit_count_reg[28]_i_1_n_2 ;
  wire \bit_count_reg[28]_i_1_n_3 ;
  wire \bit_count_reg[28]_i_1_n_4 ;
  wire \bit_count_reg[28]_i_1_n_5 ;
  wire \bit_count_reg[28]_i_1_n_6 ;
  wire \bit_count_reg[28]_i_1_n_7 ;
  wire \bit_count_reg[32]_i_1_n_0 ;
  wire \bit_count_reg[32]_i_1_n_1 ;
  wire \bit_count_reg[32]_i_1_n_2 ;
  wire \bit_count_reg[32]_i_1_n_3 ;
  wire \bit_count_reg[32]_i_1_n_4 ;
  wire \bit_count_reg[32]_i_1_n_5 ;
  wire \bit_count_reg[32]_i_1_n_6 ;
  wire \bit_count_reg[32]_i_1_n_7 ;
  wire \bit_count_reg[36]_i_1_n_1 ;
  wire \bit_count_reg[36]_i_1_n_2 ;
  wire \bit_count_reg[36]_i_1_n_3 ;
  wire \bit_count_reg[36]_i_1_n_4 ;
  wire \bit_count_reg[36]_i_1_n_5 ;
  wire \bit_count_reg[36]_i_1_n_6 ;
  wire \bit_count_reg[36]_i_1_n_7 ;
  wire \bit_count_reg[4]_i_1_n_0 ;
  wire \bit_count_reg[4]_i_1_n_1 ;
  wire \bit_count_reg[4]_i_1_n_2 ;
  wire \bit_count_reg[4]_i_1_n_3 ;
  wire \bit_count_reg[4]_i_1_n_4 ;
  wire \bit_count_reg[4]_i_1_n_5 ;
  wire \bit_count_reg[4]_i_1_n_6 ;
  wire \bit_count_reg[4]_i_1_n_7 ;
  wire \bit_count_reg[8]_i_1_n_0 ;
  wire \bit_count_reg[8]_i_1_n_1 ;
  wire \bit_count_reg[8]_i_1_n_2 ;
  wire \bit_count_reg[8]_i_1_n_3 ;
  wire \bit_count_reg[8]_i_1_n_4 ;
  wire \bit_count_reg[8]_i_1_n_5 ;
  wire \bit_count_reg[8]_i_1_n_6 ;
  wire \bit_count_reg[8]_i_1_n_7 ;
  wire [2:0]bit_idx;
  wire \bit_idx[0]_i_1_n_0 ;
  wire \bit_idx[1]_i_1_n_0 ;
  wire \bit_idx[2]_i_1_n_0 ;
  wire \bits_tdata[0]_i_1_n_0 ;
  wire \bits_tdata[1]_i_1_n_0 ;
  wire \bits_tdata[2]_i_1_n_0 ;
  wire \bits_tdata[3]_i_1_n_0 ;
  wire \bits_tdata[4]_i_1_n_0 ;
  wire \bits_tdata[5]_i_1_n_0 ;
  wire \bits_tdata[6]_i_1_n_0 ;
  wire \bits_tdata[7]_i_1_n_0 ;
  wire bits_tvalid_i_1_n_0;
  wire c_locked_i_1_n_0;
  wire [0:0]c_locked_reg_0;
  wire core_bypass_agc;
  wire core_bypass_costas;
  wire core_bypass_timing;
  wire core_enable;
  wire dump_strobe0;
  wire dump_strobe0_carry__0_i_1_n_0;
  wire dump_strobe0_carry__0_i_2_n_0;
  wire dump_strobe0_carry__0_i_3_n_0;
  wire dump_strobe0_carry__0_i_4_n_0;
  wire dump_strobe0_carry__0_n_0;
  wire dump_strobe0_carry__0_n_1;
  wire dump_strobe0_carry__0_n_2;
  wire dump_strobe0_carry__0_n_3;
  wire dump_strobe0_carry__1_i_1_n_0;
  wire dump_strobe0_carry__1_i_2_n_0;
  wire dump_strobe0_carry__1_i_3_n_0;
  wire dump_strobe0_carry__1_n_2;
  wire dump_strobe0_carry__1_n_3;
  wire dump_strobe0_carry_i_1_n_0;
  wire dump_strobe0_carry_i_2_n_0;
  wire dump_strobe0_carry_i_3_n_0;
  wire dump_strobe0_carry_i_4_n_0;
  wire dump_strobe0_carry_i_5_n_0;
  wire dump_strobe0_carry_i_6_n_0;
  wire dump_strobe0_carry_i_7_n_0;
  wire dump_strobe0_carry_n_0;
  wire dump_strobe0_carry_n_1;
  wire dump_strobe0_carry_n_2;
  wire dump_strobe0_carry_n_3;
  wire err_small;
  wire [15:0]frac_timing0;
  wire [15:1]frac_timing01_in;
  wire frac_timing0_carry__0_i_1_n_0;
  wire frac_timing0_carry__0_i_2_n_0;
  wire frac_timing0_carry__0_i_3_n_0;
  wire frac_timing0_carry__0_i_4_n_0;
  wire frac_timing0_carry__0_n_0;
  wire frac_timing0_carry__0_n_1;
  wire frac_timing0_carry__0_n_2;
  wire frac_timing0_carry__0_n_3;
  wire frac_timing0_carry__1_i_1_n_0;
  wire frac_timing0_carry__1_i_2_n_0;
  wire frac_timing0_carry__1_i_3_n_0;
  wire frac_timing0_carry__1_i_4_n_0;
  wire frac_timing0_carry__1_n_0;
  wire frac_timing0_carry__1_n_1;
  wire frac_timing0_carry__1_n_2;
  wire frac_timing0_carry__1_n_3;
  wire frac_timing0_carry__2_i_1_n_0;
  wire frac_timing0_carry__2_i_2_n_0;
  wire frac_timing0_carry__2_i_3_n_0;
  wire frac_timing0_carry__2_i_4_n_0;
  wire frac_timing0_carry__2_n_1;
  wire frac_timing0_carry__2_n_2;
  wire frac_timing0_carry__2_n_3;
  wire frac_timing0_carry_i_1_n_0;
  wire frac_timing0_carry_i_2_n_0;
  wire frac_timing0_carry_i_3_n_0;
  wire frac_timing0_carry_i_4_n_0;
  wire frac_timing0_carry_n_0;
  wire frac_timing0_carry_n_1;
  wire frac_timing0_carry_n_2;
  wire frac_timing0_carry_n_3;
  wire \frac_timing0_inferred__0/i__carry__0_n_0 ;
  wire \frac_timing0_inferred__0/i__carry__0_n_1 ;
  wire \frac_timing0_inferred__0/i__carry__0_n_2 ;
  wire \frac_timing0_inferred__0/i__carry__0_n_3 ;
  wire \frac_timing0_inferred__0/i__carry__1_n_0 ;
  wire \frac_timing0_inferred__0/i__carry__1_n_1 ;
  wire \frac_timing0_inferred__0/i__carry__1_n_2 ;
  wire \frac_timing0_inferred__0/i__carry__1_n_3 ;
  wire \frac_timing0_inferred__0/i__carry__2_n_1 ;
  wire \frac_timing0_inferred__0/i__carry__2_n_2 ;
  wire \frac_timing0_inferred__0/i__carry__2_n_3 ;
  wire \frac_timing0_inferred__0/i__carry_n_0 ;
  wire \frac_timing0_inferred__0/i__carry_n_1 ;
  wire \frac_timing0_inferred__0/i__carry_n_2 ;
  wire \frac_timing0_inferred__0/i__carry_n_3 ;
  wire \frac_timing[0]_i_1_n_0 ;
  wire \frac_timing[0]_i_2_n_0 ;
  wire \frac_timing[10]_i_1_n_0 ;
  wire \frac_timing[11]_i_1_n_0 ;
  wire \frac_timing[12]_i_1_n_0 ;
  wire \frac_timing[13]_i_1_n_0 ;
  wire \frac_timing[14]_i_1_n_0 ;
  wire \frac_timing[15]_i_1_n_0 ;
  wire \frac_timing[1]_i_1_n_0 ;
  wire \frac_timing[2]_i_1_n_0 ;
  wire \frac_timing[3]_i_1_n_0 ;
  wire \frac_timing[4]_i_1_n_0 ;
  wire \frac_timing[5]_i_1_n_0 ;
  wire \frac_timing[6]_i_1_n_0 ;
  wire \frac_timing[7]_i_1_n_0 ;
  wire \frac_timing[8]_i_1_n_0 ;
  wire \frac_timing[9]_i_1_n_0 ;
  wire \frac_timing_reg_n_0_[0] ;
  wire \frac_timing_reg_n_0_[10] ;
  wire \frac_timing_reg_n_0_[11] ;
  wire \frac_timing_reg_n_0_[12] ;
  wire \frac_timing_reg_n_0_[13] ;
  wire \frac_timing_reg_n_0_[14] ;
  wire \frac_timing_reg_n_0_[15] ;
  wire \frac_timing_reg_n_0_[1] ;
  wire \frac_timing_reg_n_0_[2] ;
  wire \frac_timing_reg_n_0_[3] ;
  wire \frac_timing_reg_n_0_[4] ;
  wire \frac_timing_reg_n_0_[5] ;
  wire \frac_timing_reg_n_0_[6] ;
  wire \frac_timing_reg_n_0_[7] ;
  wire \frac_timing_reg_n_0_[8] ;
  wire \frac_timing_reg_n_0_[9] ;
  wire [15:0]freq_int2_0;
  wire freq_int2_i_16_n_2;
  wire freq_int2_i_16_n_3;
  wire freq_int2_i_17_n_0;
  wire freq_int2_i_17_n_1;
  wire freq_int2_i_17_n_2;
  wire freq_int2_i_17_n_3;
  wire freq_int2_i_18_n_0;
  wire freq_int2_i_18_n_1;
  wire freq_int2_i_18_n_2;
  wire freq_int2_i_18_n_3;
  wire freq_int2_i_19_n_0;
  wire freq_int2_i_19_n_1;
  wire freq_int2_i_19_n_2;
  wire freq_int2_i_19_n_3;
  wire freq_int2_i_20_n_0;
  wire freq_int2_i_21_n_0;
  wire freq_int2_i_22_n_0;
  wire freq_int2_i_23_n_0;
  wire freq_int2_i_24_n_0;
  wire freq_int2_i_25_n_0;
  wire freq_int2_i_26_n_0;
  wire freq_int2_i_27_n_0;
  wire freq_int2_i_28_n_0;
  wire freq_int2_i_29_n_0;
  wire freq_int2_i_30_n_0;
  wire freq_int2_i_31_n_0;
  wire freq_int2_i_32_n_0;
  wire freq_int2_i_33_n_0;
  wire freq_int2_i_34_n_0;
  wire freq_int2_i_35_n_0;
  wire freq_int2_n_100;
  wire freq_int2_n_101;
  wire freq_int2_n_102;
  wire freq_int2_n_103;
  wire freq_int2_n_104;
  wire freq_int2_n_105;
  wire freq_int2_n_73;
  wire freq_int2_n_74;
  wire freq_int2_n_75;
  wire freq_int2_n_76;
  wire freq_int2_n_77;
  wire freq_int2_n_78;
  wire freq_int2_n_79;
  wire freq_int2_n_80;
  wire freq_int2_n_81;
  wire freq_int2_n_82;
  wire freq_int2_n_83;
  wire freq_int2_n_84;
  wire freq_int2_n_85;
  wire freq_int2_n_86;
  wire freq_int2_n_87;
  wire freq_int2_n_88;
  wire freq_int2_n_89;
  wire freq_int2_n_90;
  wire freq_int2_n_91;
  wire freq_int2_n_92;
  wire freq_int2_n_93;
  wire freq_int2_n_94;
  wire freq_int2_n_95;
  wire freq_int2_n_96;
  wire freq_int2_n_97;
  wire freq_int2_n_98;
  wire freq_int2_n_99;
  wire \freq_int[12]_i_11_n_0 ;
  wire \freq_int[12]_i_12_n_0 ;
  wire \freq_int[12]_i_13_n_0 ;
  wire \freq_int[12]_i_14_n_0 ;
  wire \freq_int[12]_i_2_n_0 ;
  wire \freq_int[12]_i_3_n_0 ;
  wire \freq_int[12]_i_4_n_0 ;
  wire \freq_int[12]_i_5_n_0 ;
  wire \freq_int[12]_i_6_n_0 ;
  wire \freq_int[12]_i_7_n_0 ;
  wire \freq_int[12]_i_8_n_0 ;
  wire \freq_int[12]_i_9_n_0 ;
  wire \freq_int[16]_i_11_n_0 ;
  wire \freq_int[16]_i_12_n_0 ;
  wire \freq_int[16]_i_13_n_0 ;
  wire \freq_int[16]_i_14_n_0 ;
  wire \freq_int[16]_i_2_n_0 ;
  wire \freq_int[16]_i_3_n_0 ;
  wire \freq_int[16]_i_4_n_0 ;
  wire \freq_int[16]_i_5_n_0 ;
  wire \freq_int[16]_i_6_n_0 ;
  wire \freq_int[16]_i_7_n_0 ;
  wire \freq_int[16]_i_8_n_0 ;
  wire \freq_int[16]_i_9_n_0 ;
  wire \freq_int[20]_i_11_n_0 ;
  wire \freq_int[20]_i_12_n_0 ;
  wire \freq_int[20]_i_13_n_0 ;
  wire \freq_int[20]_i_14_n_0 ;
  wire \freq_int[20]_i_2_n_0 ;
  wire \freq_int[20]_i_3_n_0 ;
  wire \freq_int[20]_i_4_n_0 ;
  wire \freq_int[20]_i_5_n_0 ;
  wire \freq_int[20]_i_6_n_0 ;
  wire \freq_int[20]_i_7_n_0 ;
  wire \freq_int[20]_i_8_n_0 ;
  wire \freq_int[20]_i_9_n_0 ;
  wire \freq_int[24]_i_11_n_0 ;
  wire \freq_int[24]_i_12_n_0 ;
  wire \freq_int[24]_i_13_n_0 ;
  wire \freq_int[24]_i_14_n_0 ;
  wire \freq_int[24]_i_2_n_0 ;
  wire \freq_int[24]_i_3_n_0 ;
  wire \freq_int[24]_i_4_n_0 ;
  wire \freq_int[24]_i_5_n_0 ;
  wire \freq_int[24]_i_6_n_0 ;
  wire \freq_int[24]_i_7_n_0 ;
  wire \freq_int[24]_i_8_n_0 ;
  wire \freq_int[24]_i_9_n_0 ;
  wire \freq_int[28]_i_10_n_0 ;
  wire \freq_int[28]_i_2_n_0 ;
  wire \freq_int[28]_i_3_n_0 ;
  wire \freq_int[28]_i_4_n_0 ;
  wire \freq_int[28]_i_5_n_0 ;
  wire \freq_int[28]_i_6_n_0 ;
  wire \freq_int[28]_i_7_n_0 ;
  wire \freq_int[28]_i_8_n_0 ;
  wire \freq_int[4]_i_12_n_0 ;
  wire \freq_int[4]_i_13_n_0 ;
  wire \freq_int[4]_i_14_n_0 ;
  wire \freq_int[4]_i_15_n_0 ;
  wire \freq_int[4]_i_16_n_0 ;
  wire \freq_int[4]_i_17_n_0 ;
  wire \freq_int[4]_i_18_n_0 ;
  wire \freq_int[4]_i_2_n_0 ;
  wire \freq_int[4]_i_3_n_0 ;
  wire \freq_int[4]_i_4_n_0 ;
  wire \freq_int[4]_i_5_n_0 ;
  wire \freq_int[4]_i_6_n_0 ;
  wire \freq_int[4]_i_7_n_0 ;
  wire \freq_int[4]_i_8_n_0 ;
  wire \freq_int[4]_i_9_n_0 ;
  wire \freq_int[8]_i_11_n_0 ;
  wire \freq_int[8]_i_12_n_0 ;
  wire \freq_int[8]_i_13_n_0 ;
  wire \freq_int[8]_i_14_n_0 ;
  wire \freq_int[8]_i_2_n_0 ;
  wire \freq_int[8]_i_3_n_0 ;
  wire \freq_int[8]_i_4_n_0 ;
  wire \freq_int[8]_i_5_n_0 ;
  wire \freq_int[8]_i_6_n_0 ;
  wire \freq_int[8]_i_7_n_0 ;
  wire \freq_int[8]_i_8_n_0 ;
  wire \freq_int[8]_i_9_n_0 ;
  wire [31:4]freq_int_reg;
  wire \freq_int_reg[12]_i_10_n_0 ;
  wire \freq_int_reg[12]_i_10_n_1 ;
  wire \freq_int_reg[12]_i_10_n_2 ;
  wire \freq_int_reg[12]_i_10_n_3 ;
  wire \freq_int_reg[12]_i_10_n_4 ;
  wire \freq_int_reg[12]_i_10_n_5 ;
  wire \freq_int_reg[12]_i_10_n_6 ;
  wire \freq_int_reg[12]_i_10_n_7 ;
  wire \freq_int_reg[12]_i_1_n_0 ;
  wire \freq_int_reg[12]_i_1_n_1 ;
  wire \freq_int_reg[12]_i_1_n_2 ;
  wire \freq_int_reg[12]_i_1_n_3 ;
  wire \freq_int_reg[12]_i_1_n_4 ;
  wire \freq_int_reg[12]_i_1_n_5 ;
  wire \freq_int_reg[12]_i_1_n_6 ;
  wire \freq_int_reg[12]_i_1_n_7 ;
  wire \freq_int_reg[16]_i_10_n_0 ;
  wire \freq_int_reg[16]_i_10_n_1 ;
  wire \freq_int_reg[16]_i_10_n_2 ;
  wire \freq_int_reg[16]_i_10_n_3 ;
  wire \freq_int_reg[16]_i_10_n_4 ;
  wire \freq_int_reg[16]_i_10_n_5 ;
  wire \freq_int_reg[16]_i_10_n_6 ;
  wire \freq_int_reg[16]_i_10_n_7 ;
  wire \freq_int_reg[16]_i_1_n_0 ;
  wire \freq_int_reg[16]_i_1_n_1 ;
  wire \freq_int_reg[16]_i_1_n_2 ;
  wire \freq_int_reg[16]_i_1_n_3 ;
  wire \freq_int_reg[16]_i_1_n_4 ;
  wire \freq_int_reg[16]_i_1_n_5 ;
  wire \freq_int_reg[16]_i_1_n_6 ;
  wire \freq_int_reg[16]_i_1_n_7 ;
  wire \freq_int_reg[20]_i_10_n_0 ;
  wire \freq_int_reg[20]_i_10_n_1 ;
  wire \freq_int_reg[20]_i_10_n_2 ;
  wire \freq_int_reg[20]_i_10_n_3 ;
  wire \freq_int_reg[20]_i_10_n_4 ;
  wire \freq_int_reg[20]_i_10_n_5 ;
  wire \freq_int_reg[20]_i_10_n_6 ;
  wire \freq_int_reg[20]_i_10_n_7 ;
  wire \freq_int_reg[20]_i_1_n_0 ;
  wire \freq_int_reg[20]_i_1_n_1 ;
  wire \freq_int_reg[20]_i_1_n_2 ;
  wire \freq_int_reg[20]_i_1_n_3 ;
  wire \freq_int_reg[20]_i_1_n_4 ;
  wire \freq_int_reg[20]_i_1_n_5 ;
  wire \freq_int_reg[20]_i_1_n_6 ;
  wire \freq_int_reg[20]_i_1_n_7 ;
  wire \freq_int_reg[24]_i_10_n_0 ;
  wire \freq_int_reg[24]_i_10_n_1 ;
  wire \freq_int_reg[24]_i_10_n_2 ;
  wire \freq_int_reg[24]_i_10_n_3 ;
  wire \freq_int_reg[24]_i_10_n_4 ;
  wire \freq_int_reg[24]_i_10_n_5 ;
  wire \freq_int_reg[24]_i_10_n_6 ;
  wire \freq_int_reg[24]_i_10_n_7 ;
  wire \freq_int_reg[24]_i_1_n_0 ;
  wire \freq_int_reg[24]_i_1_n_1 ;
  wire \freq_int_reg[24]_i_1_n_2 ;
  wire \freq_int_reg[24]_i_1_n_3 ;
  wire \freq_int_reg[24]_i_1_n_4 ;
  wire \freq_int_reg[24]_i_1_n_5 ;
  wire \freq_int_reg[24]_i_1_n_6 ;
  wire \freq_int_reg[24]_i_1_n_7 ;
  wire \freq_int_reg[28]_i_1_n_1 ;
  wire \freq_int_reg[28]_i_1_n_2 ;
  wire \freq_int_reg[28]_i_1_n_3 ;
  wire \freq_int_reg[28]_i_1_n_4 ;
  wire \freq_int_reg[28]_i_1_n_5 ;
  wire \freq_int_reg[28]_i_1_n_6 ;
  wire \freq_int_reg[28]_i_1_n_7 ;
  wire \freq_int_reg[28]_i_9_n_7 ;
  wire \freq_int_reg[4]_i_10_n_0 ;
  wire \freq_int_reg[4]_i_10_n_1 ;
  wire \freq_int_reg[4]_i_10_n_2 ;
  wire \freq_int_reg[4]_i_10_n_3 ;
  wire \freq_int_reg[4]_i_10_n_4 ;
  wire \freq_int_reg[4]_i_10_n_5 ;
  wire \freq_int_reg[4]_i_10_n_6 ;
  wire \freq_int_reg[4]_i_10_n_7 ;
  wire \freq_int_reg[4]_i_11_n_0 ;
  wire \freq_int_reg[4]_i_11_n_1 ;
  wire \freq_int_reg[4]_i_11_n_2 ;
  wire \freq_int_reg[4]_i_11_n_3 ;
  wire \freq_int_reg[4]_i_11_n_4 ;
  wire \freq_int_reg[4]_i_11_n_5 ;
  wire \freq_int_reg[4]_i_11_n_6 ;
  wire \freq_int_reg[4]_i_1_n_0 ;
  wire \freq_int_reg[4]_i_1_n_1 ;
  wire \freq_int_reg[4]_i_1_n_2 ;
  wire \freq_int_reg[4]_i_1_n_3 ;
  wire \freq_int_reg[4]_i_1_n_4 ;
  wire \freq_int_reg[4]_i_1_n_5 ;
  wire \freq_int_reg[4]_i_1_n_6 ;
  wire \freq_int_reg[4]_i_1_n_7 ;
  wire \freq_int_reg[8]_i_10_n_0 ;
  wire \freq_int_reg[8]_i_10_n_1 ;
  wire \freq_int_reg[8]_i_10_n_2 ;
  wire \freq_int_reg[8]_i_10_n_3 ;
  wire \freq_int_reg[8]_i_10_n_4 ;
  wire \freq_int_reg[8]_i_10_n_5 ;
  wire \freq_int_reg[8]_i_10_n_6 ;
  wire \freq_int_reg[8]_i_10_n_7 ;
  wire \freq_int_reg[8]_i_1_n_0 ;
  wire \freq_int_reg[8]_i_1_n_1 ;
  wire \freq_int_reg[8]_i_1_n_2 ;
  wire \freq_int_reg[8]_i_1_n_3 ;
  wire \freq_int_reg[8]_i_1_n_4 ;
  wire \freq_int_reg[8]_i_1_n_5 ;
  wire \freq_int_reg[8]_i_1_n_6 ;
  wire \freq_int_reg[8]_i_1_n_7 ;
  wire [31:4]freq_word;
  wire [15:0]freq_word2_0;
  wire freq_word2_n_100;
  wire freq_word2_n_101;
  wire freq_word2_n_102;
  wire freq_word2_n_103;
  wire freq_word2_n_104;
  wire freq_word2_n_105;
  wire freq_word2_n_73;
  wire freq_word2_n_74;
  wire freq_word2_n_75;
  wire freq_word2_n_76;
  wire freq_word2_n_77;
  wire freq_word2_n_78;
  wire freq_word2_n_79;
  wire freq_word2_n_80;
  wire freq_word2_n_81;
  wire freq_word2_n_82;
  wire freq_word2_n_83;
  wire freq_word2_n_84;
  wire freq_word2_n_85;
  wire freq_word2_n_86;
  wire freq_word2_n_87;
  wire freq_word2_n_88;
  wire freq_word2_n_89;
  wire freq_word2_n_90;
  wire freq_word2_n_91;
  wire freq_word2_n_92;
  wire freq_word2_n_93;
  wire freq_word2_n_94;
  wire freq_word2_n_95;
  wire freq_word2_n_96;
  wire freq_word2_n_97;
  wire freq_word2_n_98;
  wire freq_word2_n_99;
  wire \freq_word[11]_i_11_n_0 ;
  wire \freq_word[11]_i_12_n_0 ;
  wire \freq_word[11]_i_13_n_0 ;
  wire \freq_word[11]_i_14_n_0 ;
  wire \freq_word[11]_i_2_n_0 ;
  wire \freq_word[11]_i_3_n_0 ;
  wire \freq_word[11]_i_4_n_0 ;
  wire \freq_word[11]_i_5_n_0 ;
  wire \freq_word[11]_i_6_n_0 ;
  wire \freq_word[11]_i_7_n_0 ;
  wire \freq_word[11]_i_8_n_0 ;
  wire \freq_word[11]_i_9_n_0 ;
  wire \freq_word[15]_i_11_n_0 ;
  wire \freq_word[15]_i_12_n_0 ;
  wire \freq_word[15]_i_13_n_0 ;
  wire \freq_word[15]_i_14_n_0 ;
  wire \freq_word[15]_i_2_n_0 ;
  wire \freq_word[15]_i_3_n_0 ;
  wire \freq_word[15]_i_4_n_0 ;
  wire \freq_word[15]_i_5_n_0 ;
  wire \freq_word[15]_i_6_n_0 ;
  wire \freq_word[15]_i_7_n_0 ;
  wire \freq_word[15]_i_8_n_0 ;
  wire \freq_word[15]_i_9_n_0 ;
  wire \freq_word[19]_i_11_n_0 ;
  wire \freq_word[19]_i_12_n_0 ;
  wire \freq_word[19]_i_13_n_0 ;
  wire \freq_word[19]_i_14_n_0 ;
  wire \freq_word[19]_i_2_n_0 ;
  wire \freq_word[19]_i_3_n_0 ;
  wire \freq_word[19]_i_4_n_0 ;
  wire \freq_word[19]_i_5_n_0 ;
  wire \freq_word[19]_i_6_n_0 ;
  wire \freq_word[19]_i_7_n_0 ;
  wire \freq_word[19]_i_8_n_0 ;
  wire \freq_word[19]_i_9_n_0 ;
  wire \freq_word[23]_i_11_n_0 ;
  wire \freq_word[23]_i_12_n_0 ;
  wire \freq_word[23]_i_13_n_0 ;
  wire \freq_word[23]_i_14_n_0 ;
  wire \freq_word[23]_i_2_n_0 ;
  wire \freq_word[23]_i_3_n_0 ;
  wire \freq_word[23]_i_4_n_0 ;
  wire \freq_word[23]_i_5_n_0 ;
  wire \freq_word[23]_i_6_n_0 ;
  wire \freq_word[23]_i_7_n_0 ;
  wire \freq_word[23]_i_8_n_0 ;
  wire \freq_word[23]_i_9_n_0 ;
  wire \freq_word[27]_i_11_n_0 ;
  wire \freq_word[27]_i_12_n_0 ;
  wire \freq_word[27]_i_13_n_0 ;
  wire \freq_word[27]_i_14_n_0 ;
  wire \freq_word[27]_i_2_n_0 ;
  wire \freq_word[27]_i_3_n_0 ;
  wire \freq_word[27]_i_4_n_0 ;
  wire \freq_word[27]_i_5_n_0 ;
  wire \freq_word[27]_i_6_n_0 ;
  wire \freq_word[27]_i_7_n_0 ;
  wire \freq_word[27]_i_8_n_0 ;
  wire \freq_word[27]_i_9_n_0 ;
  wire \freq_word[31]_i_11_n_0 ;
  wire \freq_word[31]_i_12_n_0 ;
  wire \freq_word[31]_i_13_n_0 ;
  wire \freq_word[31]_i_14_n_0 ;
  wire \freq_word[31]_i_15_n_0 ;
  wire \freq_word[31]_i_2_n_0 ;
  wire \freq_word[31]_i_3_n_0 ;
  wire \freq_word[31]_i_4_n_0 ;
  wire \freq_word[31]_i_5_n_0 ;
  wire \freq_word[31]_i_6_n_0 ;
  wire \freq_word[31]_i_7_n_0 ;
  wire \freq_word[31]_i_8_n_0 ;
  wire \freq_word[7]_i_11_n_0 ;
  wire \freq_word[7]_i_12_n_0 ;
  wire \freq_word[7]_i_13_n_0 ;
  wire \freq_word[7]_i_2_n_0 ;
  wire \freq_word[7]_i_3_n_0 ;
  wire \freq_word[7]_i_4_n_0 ;
  wire \freq_word[7]_i_5_n_0 ;
  wire \freq_word[7]_i_6_n_0 ;
  wire \freq_word[7]_i_7_n_0 ;
  wire \freq_word[7]_i_8_n_0 ;
  wire \freq_word[7]_i_9_n_0 ;
  wire \freq_word_reg[11]_i_10_n_0 ;
  wire \freq_word_reg[11]_i_10_n_1 ;
  wire \freq_word_reg[11]_i_10_n_2 ;
  wire \freq_word_reg[11]_i_10_n_3 ;
  wire \freq_word_reg[11]_i_10_n_4 ;
  wire \freq_word_reg[11]_i_10_n_5 ;
  wire \freq_word_reg[11]_i_10_n_6 ;
  wire \freq_word_reg[11]_i_10_n_7 ;
  wire \freq_word_reg[11]_i_1_n_0 ;
  wire \freq_word_reg[11]_i_1_n_1 ;
  wire \freq_word_reg[11]_i_1_n_2 ;
  wire \freq_word_reg[11]_i_1_n_3 ;
  wire \freq_word_reg[11]_i_1_n_4 ;
  wire \freq_word_reg[11]_i_1_n_5 ;
  wire \freq_word_reg[11]_i_1_n_6 ;
  wire \freq_word_reg[11]_i_1_n_7 ;
  wire \freq_word_reg[15]_i_10_n_0 ;
  wire \freq_word_reg[15]_i_10_n_1 ;
  wire \freq_word_reg[15]_i_10_n_2 ;
  wire \freq_word_reg[15]_i_10_n_3 ;
  wire \freq_word_reg[15]_i_10_n_4 ;
  wire \freq_word_reg[15]_i_10_n_5 ;
  wire \freq_word_reg[15]_i_10_n_6 ;
  wire \freq_word_reg[15]_i_10_n_7 ;
  wire \freq_word_reg[15]_i_1_n_0 ;
  wire \freq_word_reg[15]_i_1_n_1 ;
  wire \freq_word_reg[15]_i_1_n_2 ;
  wire \freq_word_reg[15]_i_1_n_3 ;
  wire \freq_word_reg[15]_i_1_n_4 ;
  wire \freq_word_reg[15]_i_1_n_5 ;
  wire \freq_word_reg[15]_i_1_n_6 ;
  wire \freq_word_reg[15]_i_1_n_7 ;
  wire \freq_word_reg[19]_i_10_n_0 ;
  wire \freq_word_reg[19]_i_10_n_1 ;
  wire \freq_word_reg[19]_i_10_n_2 ;
  wire \freq_word_reg[19]_i_10_n_3 ;
  wire \freq_word_reg[19]_i_10_n_4 ;
  wire \freq_word_reg[19]_i_10_n_5 ;
  wire \freq_word_reg[19]_i_10_n_6 ;
  wire \freq_word_reg[19]_i_10_n_7 ;
  wire \freq_word_reg[19]_i_1_n_0 ;
  wire \freq_word_reg[19]_i_1_n_1 ;
  wire \freq_word_reg[19]_i_1_n_2 ;
  wire \freq_word_reg[19]_i_1_n_3 ;
  wire \freq_word_reg[19]_i_1_n_4 ;
  wire \freq_word_reg[19]_i_1_n_5 ;
  wire \freq_word_reg[19]_i_1_n_6 ;
  wire \freq_word_reg[19]_i_1_n_7 ;
  wire \freq_word_reg[23]_i_10_n_0 ;
  wire \freq_word_reg[23]_i_10_n_1 ;
  wire \freq_word_reg[23]_i_10_n_2 ;
  wire \freq_word_reg[23]_i_10_n_3 ;
  wire \freq_word_reg[23]_i_10_n_4 ;
  wire \freq_word_reg[23]_i_10_n_5 ;
  wire \freq_word_reg[23]_i_10_n_6 ;
  wire \freq_word_reg[23]_i_10_n_7 ;
  wire \freq_word_reg[23]_i_1_n_0 ;
  wire \freq_word_reg[23]_i_1_n_1 ;
  wire \freq_word_reg[23]_i_1_n_2 ;
  wire \freq_word_reg[23]_i_1_n_3 ;
  wire \freq_word_reg[23]_i_1_n_4 ;
  wire \freq_word_reg[23]_i_1_n_5 ;
  wire \freq_word_reg[23]_i_1_n_6 ;
  wire \freq_word_reg[23]_i_1_n_7 ;
  wire \freq_word_reg[27]_i_10_n_0 ;
  wire \freq_word_reg[27]_i_10_n_1 ;
  wire \freq_word_reg[27]_i_10_n_2 ;
  wire \freq_word_reg[27]_i_10_n_3 ;
  wire \freq_word_reg[27]_i_10_n_4 ;
  wire \freq_word_reg[27]_i_10_n_5 ;
  wire \freq_word_reg[27]_i_10_n_6 ;
  wire \freq_word_reg[27]_i_10_n_7 ;
  wire \freq_word_reg[27]_i_1_n_0 ;
  wire \freq_word_reg[27]_i_1_n_1 ;
  wire \freq_word_reg[27]_i_1_n_2 ;
  wire \freq_word_reg[27]_i_1_n_3 ;
  wire \freq_word_reg[27]_i_1_n_4 ;
  wire \freq_word_reg[27]_i_1_n_5 ;
  wire \freq_word_reg[27]_i_1_n_6 ;
  wire \freq_word_reg[27]_i_1_n_7 ;
  wire \freq_word_reg[31]_i_10_n_7 ;
  wire \freq_word_reg[31]_i_1_n_1 ;
  wire \freq_word_reg[31]_i_1_n_2 ;
  wire \freq_word_reg[31]_i_1_n_3 ;
  wire \freq_word_reg[31]_i_1_n_4 ;
  wire \freq_word_reg[31]_i_1_n_5 ;
  wire \freq_word_reg[31]_i_1_n_6 ;
  wire \freq_word_reg[31]_i_1_n_7 ;
  wire \freq_word_reg[31]_i_9_n_0 ;
  wire \freq_word_reg[31]_i_9_n_1 ;
  wire \freq_word_reg[31]_i_9_n_2 ;
  wire \freq_word_reg[31]_i_9_n_3 ;
  wire \freq_word_reg[31]_i_9_n_4 ;
  wire \freq_word_reg[31]_i_9_n_5 ;
  wire \freq_word_reg[31]_i_9_n_6 ;
  wire \freq_word_reg[31]_i_9_n_7 ;
  wire \freq_word_reg[7]_i_10_n_0 ;
  wire \freq_word_reg[7]_i_10_n_1 ;
  wire \freq_word_reg[7]_i_10_n_2 ;
  wire \freq_word_reg[7]_i_10_n_3 ;
  wire \freq_word_reg[7]_i_10_n_4 ;
  wire \freq_word_reg[7]_i_10_n_5 ;
  wire \freq_word_reg[7]_i_10_n_6 ;
  wire \freq_word_reg[7]_i_1_n_0 ;
  wire \freq_word_reg[7]_i_1_n_1 ;
  wire \freq_word_reg[7]_i_1_n_2 ;
  wire \freq_word_reg[7]_i_1_n_3 ;
  wire \freq_word_reg[7]_i_1_n_4 ;
  wire \freq_word_reg[7]_i_1_n_5 ;
  wire \freq_word_reg[7]_i_1_n_6 ;
  wire \freq_word_reg[7]_i_1_n_7 ;
  wire [3:0]\gain_acc[11]_i_3 ;
  wire i__carry__0_i_1__0_n_0;
  wire i__carry__0_i_1_n_0;
  wire i__carry__0_i_2__0_n_0;
  wire i__carry__0_i_2_n_0;
  wire i__carry__0_i_3__0_n_0;
  wire i__carry__0_i_3_n_0;
  wire i__carry__0_i_4__0_n_0;
  wire i__carry__0_i_4_n_0;
  wire i__carry__0_i_5_n_0;
  wire i__carry__0_i_6_n_0;
  wire i__carry__0_i_7_n_0;
  wire i__carry__1_i_1_n_0;
  wire i__carry__1_i_2_n_0;
  wire i__carry__1_i_3_n_0;
  wire i__carry__1_i_4_n_0;
  wire i__carry__2_i_1_n_0;
  wire i__carry__2_i_2_n_0;
  wire i__carry__2_i_3_n_0;
  wire i__carry__2_i_4_n_0;
  wire i__carry_i_1__0_n_0;
  wire i__carry_i_1_n_0;
  wire i__carry_i_2__0_n_0;
  wire i__carry_i_2_n_0;
  wire i__carry_i_3__0_n_0;
  wire i__carry_i_3_n_0;
  wire i__carry_i_4__0_n_0;
  wire i__carry_i_4_n_0;
  wire i__carry_i_5_n_0;
  wire i__carry_i_6_n_0;
  wire i__carry_i_7_n_0;
  wire i__carry_i_8_n_0;
  wire [14:0]i_dump_prev;
  wire \i_dump_prev[14]_i_1_n_0 ;
  wire [15:0]i_mix;
  wire \i_mix[11]_i_2_n_0 ;
  wire \i_mix[11]_i_3_n_0 ;
  wire \i_mix[11]_i_4_n_0 ;
  wire \i_mix[11]_i_5_n_0 ;
  wire \i_mix[15]_i_2_n_0 ;
  wire \i_mix[15]_i_3_n_0 ;
  wire \i_mix[15]_i_4_n_0 ;
  wire \i_mix[3]_i_2_n_0 ;
  wire \i_mix[3]_i_3_n_0 ;
  wire \i_mix[3]_i_4_n_0 ;
  wire \i_mix[3]_i_5_n_0 ;
  wire \i_mix[7]_i_2_n_0 ;
  wire \i_mix[7]_i_3_n_0 ;
  wire \i_mix[7]_i_4_n_0 ;
  wire \i_mix[7]_i_5_n_0 ;
  wire [15:0]i_out;
  wire i_prev_sign;
  wire \integrate_acc[0]_i_3_n_0 ;
  wire \integrate_acc[0]_i_4_n_0 ;
  wire \integrate_acc[0]_i_5_n_0 ;
  wire \integrate_acc[0]_i_6_n_0 ;
  wire \integrate_acc[12]_i_2_n_0 ;
  wire \integrate_acc[12]_i_3_n_0 ;
  wire \integrate_acc[12]_i_4_n_0 ;
  wire \integrate_acc[12]_i_5_n_0 ;
  wire \integrate_acc[16]_i_2_n_0 ;
  wire \integrate_acc[16]_i_3_n_0 ;
  wire \integrate_acc[16]_i_4_n_0 ;
  wire \integrate_acc[16]_i_5_n_0 ;
  wire \integrate_acc[20]_i_2_n_0 ;
  wire \integrate_acc[20]_i_3_n_0 ;
  wire \integrate_acc[4]_i_2_n_0 ;
  wire \integrate_acc[4]_i_3_n_0 ;
  wire \integrate_acc[4]_i_4_n_0 ;
  wire \integrate_acc[4]_i_5_n_0 ;
  wire \integrate_acc[8]_i_2_n_0 ;
  wire \integrate_acc[8]_i_3_n_0 ;
  wire \integrate_acc[8]_i_4_n_0 ;
  wire \integrate_acc[8]_i_5_n_0 ;
  wire \integrate_acc_reg[0]_i_2_n_0 ;
  wire \integrate_acc_reg[0]_i_2_n_1 ;
  wire \integrate_acc_reg[0]_i_2_n_2 ;
  wire \integrate_acc_reg[0]_i_2_n_3 ;
  wire \integrate_acc_reg[0]_i_2_n_4 ;
  wire \integrate_acc_reg[0]_i_2_n_5 ;
  wire \integrate_acc_reg[0]_i_2_n_6 ;
  wire \integrate_acc_reg[0]_i_2_n_7 ;
  wire \integrate_acc_reg[12]_i_1_n_0 ;
  wire \integrate_acc_reg[12]_i_1_n_1 ;
  wire \integrate_acc_reg[12]_i_1_n_2 ;
  wire \integrate_acc_reg[12]_i_1_n_3 ;
  wire \integrate_acc_reg[12]_i_1_n_4 ;
  wire \integrate_acc_reg[12]_i_1_n_5 ;
  wire \integrate_acc_reg[12]_i_1_n_6 ;
  wire \integrate_acc_reg[12]_i_1_n_7 ;
  wire \integrate_acc_reg[16]_i_1_n_0 ;
  wire \integrate_acc_reg[16]_i_1_n_1 ;
  wire \integrate_acc_reg[16]_i_1_n_2 ;
  wire \integrate_acc_reg[16]_i_1_n_3 ;
  wire \integrate_acc_reg[16]_i_1_n_4 ;
  wire \integrate_acc_reg[16]_i_1_n_5 ;
  wire \integrate_acc_reg[16]_i_1_n_6 ;
  wire \integrate_acc_reg[16]_i_1_n_7 ;
  wire \integrate_acc_reg[20]_i_1_n_3 ;
  wire \integrate_acc_reg[20]_i_1_n_6 ;
  wire \integrate_acc_reg[20]_i_1_n_7 ;
  wire \integrate_acc_reg[4]_i_1_n_0 ;
  wire \integrate_acc_reg[4]_i_1_n_1 ;
  wire \integrate_acc_reg[4]_i_1_n_2 ;
  wire \integrate_acc_reg[4]_i_1_n_3 ;
  wire \integrate_acc_reg[4]_i_1_n_4 ;
  wire \integrate_acc_reg[4]_i_1_n_5 ;
  wire \integrate_acc_reg[4]_i_1_n_6 ;
  wire \integrate_acc_reg[4]_i_1_n_7 ;
  wire \integrate_acc_reg[8]_i_1_n_0 ;
  wire \integrate_acc_reg[8]_i_1_n_1 ;
  wire \integrate_acc_reg[8]_i_1_n_2 ;
  wire \integrate_acc_reg[8]_i_1_n_3 ;
  wire \integrate_acc_reg[8]_i_1_n_4 ;
  wire \integrate_acc_reg[8]_i_1_n_5 ;
  wire \integrate_acc_reg[8]_i_1_n_6 ;
  wire \integrate_acc_reg[8]_i_1_n_7 ;
  wire \integrate_acc_reg_n_0_[0] ;
  wire \integrate_acc_reg_n_0_[10] ;
  wire \integrate_acc_reg_n_0_[11] ;
  wire \integrate_acc_reg_n_0_[12] ;
  wire \integrate_acc_reg_n_0_[13] ;
  wire \integrate_acc_reg_n_0_[14] ;
  wire \integrate_acc_reg_n_0_[15] ;
  wire \integrate_acc_reg_n_0_[16] ;
  wire \integrate_acc_reg_n_0_[17] ;
  wire \integrate_acc_reg_n_0_[18] ;
  wire \integrate_acc_reg_n_0_[19] ;
  wire \integrate_acc_reg_n_0_[1] ;
  wire \integrate_acc_reg_n_0_[20] ;
  wire \integrate_acc_reg_n_0_[2] ;
  wire \integrate_acc_reg_n_0_[3] ;
  wire \integrate_acc_reg_n_0_[4] ;
  wire \integrate_acc_reg_n_0_[5] ;
  wire \integrate_acc_reg_n_0_[6] ;
  wire \integrate_acc_reg_n_0_[7] ;
  wire \integrate_acc_reg_n_0_[8] ;
  wire \integrate_acc_reg_n_0_[9] ;
  wire \lock_cnt[5]_i_2_n_0 ;
  wire \lock_cnt[6]_i_1_n_0 ;
  wire \lock_cnt[6]_i_3_n_0 ;
  wire \lock_cnt[6]_i_5_n_0 ;
  wire \lock_cnt[6]_i_6_n_0 ;
  wire [6:0]lock_cnt_reg;
  wire mix_ii_n_100;
  wire mix_ii_n_101;
  wire mix_ii_n_102;
  wire mix_ii_n_103;
  wire mix_ii_n_104;
  wire mix_ii_n_105;
  wire mix_ii_n_74;
  wire mix_ii_n_91;
  wire mix_ii_n_92;
  wire mix_ii_n_93;
  wire mix_ii_n_94;
  wire mix_ii_n_95;
  wire mix_ii_n_96;
  wire mix_ii_n_97;
  wire mix_ii_n_98;
  wire mix_ii_n_99;
  wire mix_iq_n_100;
  wire mix_iq_n_101;
  wire mix_iq_n_102;
  wire mix_iq_n_103;
  wire mix_iq_n_104;
  wire mix_iq_n_105;
  wire mix_iq_n_74;
  wire mix_iq_n_91;
  wire mix_iq_n_92;
  wire mix_iq_n_93;
  wire mix_iq_n_94;
  wire mix_iq_n_95;
  wire mix_iq_n_96;
  wire mix_iq_n_97;
  wire mix_iq_n_98;
  wire mix_iq_n_99;
  wire [30:15]mix_qi__0;
  wire mix_qi_n_100;
  wire mix_qi_n_101;
  wire mix_qi_n_102;
  wire mix_qi_n_103;
  wire mix_qi_n_104;
  wire mix_qi_n_105;
  wire mix_qi_n_74;
  wire mix_qi_n_91;
  wire mix_qi_n_92;
  wire mix_qi_n_93;
  wire mix_qi_n_94;
  wire mix_qi_n_95;
  wire mix_qi_n_96;
  wire mix_qi_n_97;
  wire mix_qi_n_98;
  wire mix_qi_n_99;
  wire [30:15]mix_qq__0;
  wire mix_qq_n_100;
  wire mix_qq_n_101;
  wire mix_qq_n_102;
  wire mix_qq_n_103;
  wire mix_qq_n_104;
  wire mix_qq_n_105;
  wire mix_qq_n_74;
  wire mix_qq_n_91;
  wire mix_qq_n_92;
  wire mix_qq_n_93;
  wire mix_qq_n_94;
  wire mix_qq_n_95;
  wire mix_qq_n_96;
  wire mix_qq_n_97;
  wire mix_qq_n_98;
  wire mix_qq_n_99;
  wire [15:0]out;
  wire [7:0]p_0_in;
  wire [6:0]p_0_in__0;
  wire [15:0]p_0_out;
  wire \p_0_out_inferred__0/sin_out[0]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out[0]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out[10]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[10]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[11]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[11]_i_5_n_0 ;
  wire \p_0_out_inferred__0/sin_out[11]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[11]_i_7_n_0 ;
  wire \p_0_out_inferred__0/sin_out[12]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[12]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[12]_i_7_n_0 ;
  wire \p_0_out_inferred__0/sin_out[13]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out[13]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out[13]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out[13]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[13]_i_5_n_0 ;
  wire \p_0_out_inferred__0/sin_out[13]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[14]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out[14]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out[14]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[14]_i_5_n_0 ;
  wire \p_0_out_inferred__0/sin_out[15]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out[15]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out[1]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[1]_i_5_n_0 ;
  wire \p_0_out_inferred__0/sin_out[1]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[1]_i_7_n_0 ;
  wire \p_0_out_inferred__0/sin_out[2]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[2]_i_5_n_0 ;
  wire \p_0_out_inferred__0/sin_out[2]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[2]_i_7_n_0 ;
  wire \p_0_out_inferred__0/sin_out[3]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[3]_i_5_n_0 ;
  wire \p_0_out_inferred__0/sin_out[3]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[3]_i_7_n_0 ;
  wire \p_0_out_inferred__0/sin_out[4]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[4]_i_5_n_0 ;
  wire \p_0_out_inferred__0/sin_out[4]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[4]_i_7_n_0 ;
  wire \p_0_out_inferred__0/sin_out[5]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[5]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[5]_i_7_n_0 ;
  wire \p_0_out_inferred__0/sin_out[6]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[6]_i_5_n_0 ;
  wire \p_0_out_inferred__0/sin_out[6]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[6]_i_7_n_0 ;
  wire \p_0_out_inferred__0/sin_out[7]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[7]_i_5_n_0 ;
  wire \p_0_out_inferred__0/sin_out[7]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[7]_i_7_n_0 ;
  wire \p_0_out_inferred__0/sin_out[8]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[8]_i_5_n_0 ;
  wire \p_0_out_inferred__0/sin_out[8]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[8]_i_7_n_0 ;
  wire \p_0_out_inferred__0/sin_out[9]_i_4_n_0 ;
  wire \p_0_out_inferred__0/sin_out[9]_i_6_n_0 ;
  wire \p_0_out_inferred__0/sin_out[9]_i_7_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[0]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[10]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[10]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[10]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[11]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[11]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[11]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[12]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[12]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[12]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[14]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[1]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[1]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[1]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[2]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[2]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[2]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[3]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[3]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[3]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[4]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[4]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[4]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[5]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[5]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[5]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[6]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[6]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[6]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[7]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[7]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[7]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[8]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[8]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[8]_i_3_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[9]_i_1_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[9]_i_2_n_0 ;
  wire \p_0_out_inferred__0/sin_out_reg[9]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out[0]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out[0]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out[10]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[10]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out[11]_i_4_n_0 ;
  wire \p_0_out_inferred__2/cos_out[11]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[11]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[11]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out[12]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[12]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[12]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out[13]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out[13]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out[13]_i_4_n_0 ;
  wire \p_0_out_inferred__2/cos_out[13]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[14]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out[14]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out[14]_i_4_n_0 ;
  wire \p_0_out_inferred__2/cos_out[14]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[15]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out[1]_i_4_n_0 ;
  wire \p_0_out_inferred__2/cos_out[1]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[1]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[1]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out[2]_i_4_n_0 ;
  wire \p_0_out_inferred__2/cos_out[2]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[2]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[2]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out[3]_i_4_n_0 ;
  wire \p_0_out_inferred__2/cos_out[3]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[3]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[3]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out[4]_i_4_n_0 ;
  wire \p_0_out_inferred__2/cos_out[4]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[4]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[4]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out[5]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[5]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[5]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out[6]_i_4_n_0 ;
  wire \p_0_out_inferred__2/cos_out[6]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[6]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[6]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out[7]_i_4_n_0 ;
  wire \p_0_out_inferred__2/cos_out[7]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[7]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[7]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out[8]_i_4_n_0 ;
  wire \p_0_out_inferred__2/cos_out[8]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[8]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[8]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out[9]_i_5_n_0 ;
  wire \p_0_out_inferred__2/cos_out[9]_i_6_n_0 ;
  wire \p_0_out_inferred__2/cos_out[9]_i_7_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[10]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[10]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[11]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[11]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[12]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[12]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[1]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[1]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[2]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[2]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[3]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[3]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[4]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[4]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[5]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[5]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[6]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[6]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[7]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[7]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[8]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[8]_i_3_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[9]_i_2_n_0 ;
  wire \p_0_out_inferred__2/cos_out_reg[9]_i_3_n_0 ;
  wire p_1_in0;
  wire [15:1]phase_err_p0;
  wire [15:1]q_mix;
  wire \q_mix[11]_i_11_n_0 ;
  wire \q_mix[11]_i_12_n_0 ;
  wire \q_mix[11]_i_13_n_0 ;
  wire \q_mix[11]_i_14_n_0 ;
  wire \q_mix[11]_i_2_n_0 ;
  wire \q_mix[11]_i_3_n_0 ;
  wire \q_mix[11]_i_4_n_0 ;
  wire \q_mix[11]_i_5_n_0 ;
  wire \q_mix[15]_i_11_n_0 ;
  wire \q_mix[15]_i_12_n_0 ;
  wire \q_mix[15]_i_13_n_0 ;
  wire \q_mix[15]_i_14_n_0 ;
  wire \q_mix[15]_i_15_n_0 ;
  wire \q_mix[15]_i_16_n_0 ;
  wire \q_mix[15]_i_17_n_0 ;
  wire \q_mix[15]_i_2_n_0 ;
  wire \q_mix[15]_i_3_n_0 ;
  wire \q_mix[15]_i_4_n_0 ;
  wire \q_mix[3]_i_2_n_0 ;
  wire \q_mix[3]_i_3_n_0 ;
  wire \q_mix[3]_i_4_n_0 ;
  wire \q_mix[3]_i_5_n_0 ;
  wire \q_mix[7]_i_11_n_0 ;
  wire \q_mix[7]_i_12_n_0 ;
  wire \q_mix[7]_i_13_n_0 ;
  wire \q_mix[7]_i_14_n_0 ;
  wire \q_mix[7]_i_15_n_0 ;
  wire \q_mix[7]_i_2_n_0 ;
  wire \q_mix[7]_i_3_n_0 ;
  wire \q_mix[7]_i_4_n_0 ;
  wire \q_mix[7]_i_5_n_0 ;
  wire \q_mix_reg[11]_i_10_n_0 ;
  wire \q_mix_reg[11]_i_10_n_1 ;
  wire \q_mix_reg[11]_i_10_n_2 ;
  wire \q_mix_reg[11]_i_10_n_3 ;
  wire \q_mix_reg[11]_i_10_n_4 ;
  wire \q_mix_reg[11]_i_10_n_5 ;
  wire \q_mix_reg[11]_i_10_n_6 ;
  wire \q_mix_reg[11]_i_10_n_7 ;
  wire \q_mix_reg[15]_i_10_n_0 ;
  wire \q_mix_reg[15]_i_10_n_1 ;
  wire \q_mix_reg[15]_i_10_n_2 ;
  wire \q_mix_reg[15]_i_10_n_3 ;
  wire \q_mix_reg[15]_i_10_n_4 ;
  wire \q_mix_reg[15]_i_10_n_5 ;
  wire \q_mix_reg[15]_i_10_n_6 ;
  wire \q_mix_reg[15]_i_10_n_7 ;
  wire \q_mix_reg[15]_i_9_n_2 ;
  wire \q_mix_reg[15]_i_9_n_3 ;
  wire \q_mix_reg[15]_i_9_n_5 ;
  wire \q_mix_reg[15]_i_9_n_6 ;
  wire \q_mix_reg[15]_i_9_n_7 ;
  wire \q_mix_reg[7]_i_10_n_0 ;
  wire \q_mix_reg[7]_i_10_n_1 ;
  wire \q_mix_reg[7]_i_10_n_2 ;
  wire \q_mix_reg[7]_i_10_n_3 ;
  wire \q_mix_reg[7]_i_10_n_4 ;
  wire \q_mix_reg[7]_i_10_n_5 ;
  wire \q_mix_reg[7]_i_10_n_6 ;
  wire \q_mix_reg[7]_i_10_n_7 ;
  wire [15:0]q_out;
  wire [7:0]sel;
  wire \sps_counter[2]_i_1_n_0 ;
  wire \sps_counter[3]_i_1_n_0 ;
  wire \sps_counter[4]_i_1_n_0 ;
  wire \sps_counter[5]_i_1_n_0 ;
  wire \sps_counter[5]_i_2_n_0 ;
  wire \sps_counter[6]_i_1_n_0 ;
  wire \sps_counter[7]_i_2_n_0 ;
  wire [7:0]sps_counter_reg;
  wire [7:0]sps_eff;
  wire sps_eff1;
  wire sps_eff13_in;
  wire \sps_eff1_inferred__1/i__carry__0_n_1 ;
  wire \sps_eff1_inferred__1/i__carry__0_n_2 ;
  wire \sps_eff1_inferred__1/i__carry__0_n_3 ;
  wire \sps_eff1_inferred__1/i__carry_n_0 ;
  wire \sps_eff1_inferred__1/i__carry_n_1 ;
  wire \sps_eff1_inferred__1/i__carry_n_2 ;
  wire \sps_eff1_inferred__1/i__carry_n_3 ;
  wire \sps_eff[0]_i_1_n_0 ;
  wire \sps_eff[0]_i_2_n_0 ;
  wire \sps_eff[1]_i_1_n_0 ;
  wire \sps_eff[1]_i_2_n_0 ;
  wire \sps_eff[1]_i_3_n_0 ;
  wire \sps_eff[1]_i_4_n_0 ;
  wire \sps_eff[2]_i_1_n_0 ;
  wire \sps_eff[2]_i_2_n_0 ;
  wire \sps_eff[2]_i_3_n_0 ;
  wire \sps_eff[3]_i_1_n_0 ;
  wire \sps_eff[3]_i_2_n_0 ;
  wire \sps_eff[3]_i_3_n_0 ;
  wire \sps_eff[3]_i_4_n_0 ;
  wire \sps_eff[3]_i_5_n_0 ;
  wire \sps_eff[4]_i_1_n_0 ;
  wire \sps_eff[4]_i_2_n_0 ;
  wire \sps_eff[4]_i_3_n_0 ;
  wire \sps_eff[4]_i_4_n_0 ;
  wire \sps_eff[5]_i_1_n_0 ;
  wire \sps_eff[5]_i_2_n_0 ;
  wire \sps_eff[5]_i_3_n_0 ;
  wire \sps_eff[5]_i_4_n_0 ;
  wire \sps_eff[5]_i_5_n_0 ;
  wire \sps_eff[6]_i_1_n_0 ;
  wire \sps_eff[6]_i_2_n_0 ;
  wire \sps_eff[6]_i_3_n_0 ;
  wire \sps_eff[7]_i_1_n_0 ;
  wire \sps_eff[7]_i_2_n_0 ;
  wire \sps_eff[7]_i_3_n_0 ;
  wire [7:0]\sps_eff_reg[7]_0 ;
  wire [15:0]timing_adj;
  wire timing_adj10;
  wire [15:0]timing_adj2_0;
  wire timing_adj2_n_100;
  wire timing_adj2_n_101;
  wire timing_adj2_n_102;
  wire timing_adj2_n_103;
  wire timing_adj2_n_104;
  wire timing_adj2_n_105;
  wire timing_adj2_n_73;
  wire timing_adj2_n_74;
  wire timing_adj2_n_75;
  wire timing_adj2_n_76;
  wire timing_adj2_n_77;
  wire timing_adj2_n_78;
  wire timing_adj2_n_79;
  wire timing_adj2_n_80;
  wire timing_adj2_n_81;
  wire timing_adj2_n_82;
  wire timing_adj2_n_83;
  wire timing_adj2_n_84;
  wire timing_adj2_n_85;
  wire timing_adj2_n_86;
  wire timing_adj2_n_87;
  wire timing_adj2_n_88;
  wire timing_adj2_n_90;
  wire timing_adj2_n_91;
  wire timing_adj2_n_92;
  wire timing_adj2_n_93;
  wire timing_adj2_n_94;
  wire timing_adj2_n_95;
  wire timing_adj2_n_96;
  wire timing_adj2_n_97;
  wire timing_adj2_n_98;
  wire timing_adj2_n_99;
  wire \timing_adj[11]_i_2_n_0 ;
  wire \timing_adj[11]_i_3_n_0 ;
  wire \timing_adj[11]_i_4_n_0 ;
  wire \timing_adj[11]_i_5_n_0 ;
  wire \timing_adj[11]_i_6_n_0 ;
  wire \timing_adj[11]_i_7_n_0 ;
  wire \timing_adj[11]_i_8_n_0 ;
  wire \timing_adj[11]_i_9_n_0 ;
  wire \timing_adj[15]_i_2_n_0 ;
  wire \timing_adj[15]_i_3_n_0 ;
  wire \timing_adj[15]_i_4_n_0 ;
  wire \timing_adj[15]_i_5_n_0 ;
  wire \timing_adj[15]_i_6_n_0 ;
  wire \timing_adj[15]_i_7_n_0 ;
  wire \timing_adj[15]_i_8_n_0 ;
  wire \timing_adj[3]_i_2_n_0 ;
  wire \timing_adj[3]_i_3_n_0 ;
  wire \timing_adj[3]_i_4_n_0 ;
  wire \timing_adj[3]_i_5_n_0 ;
  wire \timing_adj[7]_i_2_n_0 ;
  wire \timing_adj[7]_i_3_n_0 ;
  wire \timing_adj[7]_i_4_n_0 ;
  wire \timing_adj[7]_i_5_n_0 ;
  wire \timing_adj_reg[11]_i_1_n_0 ;
  wire \timing_adj_reg[11]_i_1_n_1 ;
  wire \timing_adj_reg[11]_i_1_n_2 ;
  wire \timing_adj_reg[11]_i_1_n_3 ;
  wire \timing_adj_reg[11]_i_1_n_4 ;
  wire \timing_adj_reg[11]_i_1_n_5 ;
  wire \timing_adj_reg[11]_i_1_n_6 ;
  wire \timing_adj_reg[11]_i_1_n_7 ;
  wire \timing_adj_reg[15]_i_1_n_1 ;
  wire \timing_adj_reg[15]_i_1_n_2 ;
  wire \timing_adj_reg[15]_i_1_n_3 ;
  wire \timing_adj_reg[15]_i_1_n_4 ;
  wire \timing_adj_reg[15]_i_1_n_5 ;
  wire \timing_adj_reg[15]_i_1_n_6 ;
  wire \timing_adj_reg[15]_i_1_n_7 ;
  wire \timing_adj_reg[3]_i_1_n_0 ;
  wire \timing_adj_reg[3]_i_1_n_1 ;
  wire \timing_adj_reg[3]_i_1_n_2 ;
  wire \timing_adj_reg[3]_i_1_n_3 ;
  wire \timing_adj_reg[3]_i_1_n_4 ;
  wire \timing_adj_reg[3]_i_1_n_5 ;
  wire \timing_adj_reg[3]_i_1_n_6 ;
  wire \timing_adj_reg[3]_i_1_n_7 ;
  wire \timing_adj_reg[7]_i_1_n_0 ;
  wire \timing_adj_reg[7]_i_1_n_1 ;
  wire \timing_adj_reg[7]_i_1_n_2 ;
  wire \timing_adj_reg[7]_i_1_n_3 ;
  wire \timing_adj_reg[7]_i_1_n_4 ;
  wire \timing_adj_reg[7]_i_1_n_5 ;
  wire \timing_adj_reg[7]_i_1_n_6 ;
  wire \timing_adj_reg[7]_i_1_n_7 ;
  wire timing_err__0_carry__0_i_1_n_0;
  wire timing_err__0_carry__0_i_2_n_0;
  wire timing_err__0_carry__0_i_3_n_0;
  wire timing_err__0_carry__0_i_4_n_0;
  wire timing_err__0_carry__0_i_5_n_0;
  wire timing_err__0_carry__0_i_6_n_0;
  wire timing_err__0_carry__0_i_7_n_0;
  wire timing_err__0_carry__0_i_8_n_0;
  wire timing_err__0_carry__0_n_0;
  wire timing_err__0_carry__0_n_1;
  wire timing_err__0_carry__0_n_2;
  wire timing_err__0_carry__0_n_3;
  wire timing_err__0_carry__1_i_1_n_0;
  wire timing_err__0_carry__1_i_2_n_0;
  wire timing_err__0_carry__1_i_3_n_0;
  wire timing_err__0_carry__1_i_4_n_0;
  wire timing_err__0_carry__1_i_5_n_0;
  wire timing_err__0_carry__1_i_6_n_0;
  wire timing_err__0_carry__1_i_7_n_0;
  wire timing_err__0_carry__1_i_8_n_0;
  wire timing_err__0_carry__1_n_0;
  wire timing_err__0_carry__1_n_1;
  wire timing_err__0_carry__1_n_2;
  wire timing_err__0_carry__1_n_3;
  wire timing_err__0_carry__2_i_1_n_0;
  wire timing_err__0_carry__2_i_2_n_0;
  wire timing_err__0_carry__2_i_3_n_0;
  wire timing_err__0_carry__2_i_4_n_0;
  wire timing_err__0_carry__2_i_5_n_0;
  wire timing_err__0_carry__2_i_6_n_0;
  wire timing_err__0_carry__2_i_7_n_0;
  wire timing_err__0_carry__2_n_1;
  wire timing_err__0_carry__2_n_2;
  wire timing_err__0_carry__2_n_3;
  wire timing_err__0_carry_i_1_n_0;
  wire timing_err__0_carry_i_2_n_0;
  wire timing_err__0_carry_i_3_n_0;
  wire timing_err__0_carry_i_4_n_0;
  wire timing_err__0_carry_i_5_n_0;
  wire timing_err__0_carry_i_6_n_0;
  wire timing_err__0_carry_i_7_n_0;
  wire timing_err__0_carry_n_0;
  wire timing_err__0_carry_n_1;
  wire timing_err__0_carry_n_2;
  wire timing_err__0_carry_n_3;
  wire [15:0]timing_err_out;
  wire [15:0]timing_int0_0;
  wire timing_int0_n_100;
  wire timing_int0_n_101;
  wire timing_int0_n_102;
  wire timing_int0_n_103;
  wire timing_int0_n_104;
  wire timing_int0_n_105;
  wire timing_int0_n_74;
  wire timing_int0_n_75;
  wire timing_int0_n_76;
  wire timing_int0_n_77;
  wire timing_int0_n_78;
  wire timing_int0_n_79;
  wire timing_int0_n_80;
  wire timing_int0_n_81;
  wire timing_int0_n_82;
  wire timing_int0_n_83;
  wire timing_int0_n_84;
  wire timing_int0_n_85;
  wire timing_int0_n_86;
  wire timing_int0_n_87;
  wire timing_int0_n_88;
  wire timing_int0_n_89;
  wire timing_int0_n_90;
  wire timing_int0_n_91;
  wire timing_int0_n_92;
  wire timing_int0_n_93;
  wire timing_int0_n_94;
  wire timing_int0_n_95;
  wire timing_int0_n_96;
  wire timing_int0_n_97;
  wire timing_int0_n_98;
  wire timing_int0_n_99;
  wire u_agc_n_18;
  wire u_agc_n_19;
  wire u_agc_n_20;
  wire u_agc_n_21;
  wire u_agc_n_22;
  wire u_agc_n_23;
  wire u_agc_n_24;
  wire u_agc_n_25;
  wire u_agc_n_26;
  wire u_agc_n_27;
  wire u_agc_n_28;
  wire u_agc_n_29;
  wire u_agc_n_30;
  wire u_agc_n_31;
  wire u_agc_n_32;
  wire u_agc_n_33;
  wire u_agc_n_67;
  wire u_agc_n_68;
  wire u_agc_n_69;
  wire u_agc_n_70;
  wire u_agc_n_71;
  wire u_agc_n_72;
  wire u_agc_n_73;
  wire u_agc_n_74;
  wire u_agc_n_75;
  wire u_agc_n_76;
  wire u_agc_n_77;
  wire u_agc_n_78;
  wire u_agc_n_79;
  wire u_agc_n_80;
  wire u_agc_n_81;
  wire u_agc_n_82;
  wire u_nco_n_0;
  wire u_nco_n_10;
  wire u_nco_n_11;
  wire u_nco_n_12;
  wire u_nco_n_13;
  wire u_nco_n_14;
  wire u_nco_n_15;
  wire u_nco_n_16;
  wire u_nco_n_17;
  wire u_nco_n_18;
  wire u_nco_n_19;
  wire u_nco_n_20;
  wire u_nco_n_21;
  wire u_nco_n_22;
  wire u_nco_n_23;
  wire u_nco_n_24;
  wire u_nco_n_25;
  wire u_nco_n_26;
  wire u_nco_n_27;
  wire u_nco_n_28;
  wire u_nco_n_29;
  wire u_nco_n_30;
  wire u_nco_n_31;
  wire u_nco_n_32;
  wire u_nco_n_33;
  wire u_nco_n_9;
  wire [3:3]\NLW_bit_count_reg[36]_i_1_CO_UNCONNECTED ;
  wire [3:0]NLW_dump_strobe0_carry_O_UNCONNECTED;
  wire [3:0]NLW_dump_strobe0_carry__0_O_UNCONNECTED;
  wire [3:3]NLW_dump_strobe0_carry__1_CO_UNCONNECTED;
  wire [3:0]NLW_dump_strobe0_carry__1_O_UNCONNECTED;
  wire [3:3]NLW_frac_timing0_carry__2_CO_UNCONNECTED;
  wire [0:0]\NLW_frac_timing0_inferred__0/i__carry_O_UNCONNECTED ;
  wire [3:3]\NLW_frac_timing0_inferred__0/i__carry__2_CO_UNCONNECTED ;
  wire NLW_freq_int2_CARRYCASCOUT_UNCONNECTED;
  wire NLW_freq_int2_MULTSIGNOUT_UNCONNECTED;
  wire NLW_freq_int2_OVERFLOW_UNCONNECTED;
  wire NLW_freq_int2_PATTERNBDETECT_UNCONNECTED;
  wire NLW_freq_int2_PATTERNDETECT_UNCONNECTED;
  wire NLW_freq_int2_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_freq_int2_ACOUT_UNCONNECTED;
  wire [17:0]NLW_freq_int2_BCOUT_UNCONNECTED;
  wire [3:0]NLW_freq_int2_CARRYOUT_UNCONNECTED;
  wire [47:33]NLW_freq_int2_P_UNCONNECTED;
  wire [47:0]NLW_freq_int2_PCOUT_UNCONNECTED;
  wire [3:2]NLW_freq_int2_i_16_CO_UNCONNECTED;
  wire [3:3]NLW_freq_int2_i_16_O_UNCONNECTED;
  wire [3:3]\NLW_freq_int_reg[28]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_freq_int_reg[28]_i_9_CO_UNCONNECTED ;
  wire [3:1]\NLW_freq_int_reg[28]_i_9_O_UNCONNECTED ;
  wire [0:0]\NLW_freq_int_reg[4]_i_11_O_UNCONNECTED ;
  wire NLW_freq_word2_CARRYCASCOUT_UNCONNECTED;
  wire NLW_freq_word2_MULTSIGNOUT_UNCONNECTED;
  wire NLW_freq_word2_OVERFLOW_UNCONNECTED;
  wire NLW_freq_word2_PATTERNBDETECT_UNCONNECTED;
  wire NLW_freq_word2_PATTERNDETECT_UNCONNECTED;
  wire NLW_freq_word2_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_freq_word2_ACOUT_UNCONNECTED;
  wire [17:0]NLW_freq_word2_BCOUT_UNCONNECTED;
  wire [3:0]NLW_freq_word2_CARRYOUT_UNCONNECTED;
  wire [47:33]NLW_freq_word2_P_UNCONNECTED;
  wire [47:0]NLW_freq_word2_PCOUT_UNCONNECTED;
  wire [3:3]\NLW_freq_word_reg[31]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_freq_word_reg[31]_i_10_CO_UNCONNECTED ;
  wire [3:1]\NLW_freq_word_reg[31]_i_10_O_UNCONNECTED ;
  wire [0:0]\NLW_freq_word_reg[7]_i_10_O_UNCONNECTED ;
  wire [3:1]\NLW_integrate_acc_reg[20]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_integrate_acc_reg[20]_i_1_O_UNCONNECTED ;
  wire NLW_mix_ii_CARRYCASCOUT_UNCONNECTED;
  wire NLW_mix_ii_MULTSIGNOUT_UNCONNECTED;
  wire NLW_mix_ii_OVERFLOW_UNCONNECTED;
  wire NLW_mix_ii_PATTERNBDETECT_UNCONNECTED;
  wire NLW_mix_ii_PATTERNDETECT_UNCONNECTED;
  wire NLW_mix_ii_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_mix_ii_ACOUT_UNCONNECTED;
  wire [17:0]NLW_mix_ii_BCOUT_UNCONNECTED;
  wire [3:0]NLW_mix_ii_CARRYOUT_UNCONNECTED;
  wire [47:32]NLW_mix_ii_P_UNCONNECTED;
  wire [47:0]NLW_mix_ii_PCOUT_UNCONNECTED;
  wire NLW_mix_iq_CARRYCASCOUT_UNCONNECTED;
  wire NLW_mix_iq_MULTSIGNOUT_UNCONNECTED;
  wire NLW_mix_iq_OVERFLOW_UNCONNECTED;
  wire NLW_mix_iq_PATTERNBDETECT_UNCONNECTED;
  wire NLW_mix_iq_PATTERNDETECT_UNCONNECTED;
  wire NLW_mix_iq_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_mix_iq_ACOUT_UNCONNECTED;
  wire [17:0]NLW_mix_iq_BCOUT_UNCONNECTED;
  wire [3:0]NLW_mix_iq_CARRYOUT_UNCONNECTED;
  wire [47:32]NLW_mix_iq_P_UNCONNECTED;
  wire [47:0]NLW_mix_iq_PCOUT_UNCONNECTED;
  wire NLW_mix_qi_CARRYCASCOUT_UNCONNECTED;
  wire NLW_mix_qi_MULTSIGNOUT_UNCONNECTED;
  wire NLW_mix_qi_OVERFLOW_UNCONNECTED;
  wire NLW_mix_qi_PATTERNBDETECT_UNCONNECTED;
  wire NLW_mix_qi_PATTERNDETECT_UNCONNECTED;
  wire NLW_mix_qi_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_mix_qi_ACOUT_UNCONNECTED;
  wire [17:0]NLW_mix_qi_BCOUT_UNCONNECTED;
  wire [3:0]NLW_mix_qi_CARRYOUT_UNCONNECTED;
  wire [47:32]NLW_mix_qi_P_UNCONNECTED;
  wire [47:0]NLW_mix_qi_PCOUT_UNCONNECTED;
  wire NLW_mix_qq_CARRYCASCOUT_UNCONNECTED;
  wire NLW_mix_qq_MULTSIGNOUT_UNCONNECTED;
  wire NLW_mix_qq_OVERFLOW_UNCONNECTED;
  wire NLW_mix_qq_PATTERNBDETECT_UNCONNECTED;
  wire NLW_mix_qq_PATTERNDETECT_UNCONNECTED;
  wire NLW_mix_qq_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_mix_qq_ACOUT_UNCONNECTED;
  wire [17:0]NLW_mix_qq_BCOUT_UNCONNECTED;
  wire [3:0]NLW_mix_qq_CARRYOUT_UNCONNECTED;
  wire [47:32]NLW_mix_qq_P_UNCONNECTED;
  wire [47:0]NLW_mix_qq_PCOUT_UNCONNECTED;
  wire [3:2]\NLW_q_mix_reg[15]_i_9_CO_UNCONNECTED ;
  wire [3:3]\NLW_q_mix_reg[15]_i_9_O_UNCONNECTED ;
  wire [3:0]\NLW_sps_eff1_inferred__1/i__carry_O_UNCONNECTED ;
  wire [3:0]\NLW_sps_eff1_inferred__1/i__carry__0_O_UNCONNECTED ;
  wire NLW_timing_adj2_CARRYCASCOUT_UNCONNECTED;
  wire NLW_timing_adj2_MULTSIGNOUT_UNCONNECTED;
  wire NLW_timing_adj2_OVERFLOW_UNCONNECTED;
  wire NLW_timing_adj2_PATTERNBDETECT_UNCONNECTED;
  wire NLW_timing_adj2_PATTERNDETECT_UNCONNECTED;
  wire NLW_timing_adj2_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_timing_adj2_ACOUT_UNCONNECTED;
  wire [17:0]NLW_timing_adj2_BCOUT_UNCONNECTED;
  wire [3:0]NLW_timing_adj2_CARRYOUT_UNCONNECTED;
  wire [47:33]NLW_timing_adj2_P_UNCONNECTED;
  wire [47:0]NLW_timing_adj2_PCOUT_UNCONNECTED;
  wire [3:3]\NLW_timing_adj_reg[15]_i_1_CO_UNCONNECTED ;
  wire [3:3]NLW_timing_err__0_carry__2_CO_UNCONNECTED;
  wire NLW_timing_int0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_timing_int0_MULTSIGNOUT_UNCONNECTED;
  wire NLW_timing_int0_OVERFLOW_UNCONNECTED;
  wire NLW_timing_int0_PATTERNBDETECT_UNCONNECTED;
  wire NLW_timing_int0_PATTERNDETECT_UNCONNECTED;
  wire NLW_timing_int0_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_timing_int0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_timing_int0_BCOUT_UNCONNECTED;
  wire [3:0]NLW_timing_int0_CARRYOUT_UNCONNECTED;
  wire [47:32]NLW_timing_int0_P_UNCONNECTED;
  wire [47:0]NLW_timing_int0_PCOUT_UNCONNECTED;

  FDRE adc_valid_d1_reg
       (.C(aclk),
        .CE(1'b1),
        .D(adc_valid_d10),
        .Q(adc_valid_d1),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \bit_count[0]_i_2 
       (.I0(bit_count[0]),
        .O(\bit_count[0]_i_2_n_0 ));
  FDCE \bit_count_reg[0] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[0]_i_1_n_7 ),
        .Q(bit_count[0]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \bit_count_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\bit_count_reg[0]_i_1_n_0 ,\bit_count_reg[0]_i_1_n_1 ,\bit_count_reg[0]_i_1_n_2 ,\bit_count_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\bit_count_reg[0]_i_1_n_4 ,\bit_count_reg[0]_i_1_n_5 ,\bit_count_reg[0]_i_1_n_6 ,\bit_count_reg[0]_i_1_n_7 }),
        .S({bit_count[3:1],\bit_count[0]_i_2_n_0 }));
  FDCE \bit_count_reg[10] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[8]_i_1_n_5 ),
        .Q(bit_count[10]));
  FDCE \bit_count_reg[11] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[8]_i_1_n_4 ),
        .Q(bit_count[11]));
  FDCE \bit_count_reg[12] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[12]_i_1_n_7 ),
        .Q(bit_count[12]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \bit_count_reg[12]_i_1 
       (.CI(\bit_count_reg[8]_i_1_n_0 ),
        .CO({\bit_count_reg[12]_i_1_n_0 ,\bit_count_reg[12]_i_1_n_1 ,\bit_count_reg[12]_i_1_n_2 ,\bit_count_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\bit_count_reg[12]_i_1_n_4 ,\bit_count_reg[12]_i_1_n_5 ,\bit_count_reg[12]_i_1_n_6 ,\bit_count_reg[12]_i_1_n_7 }),
        .S(bit_count[15:12]));
  FDCE \bit_count_reg[13] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[12]_i_1_n_6 ),
        .Q(bit_count[13]));
  FDCE \bit_count_reg[14] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[12]_i_1_n_5 ),
        .Q(bit_count[14]));
  FDCE \bit_count_reg[15] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[12]_i_1_n_4 ),
        .Q(bit_count[15]));
  FDCE \bit_count_reg[16] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[16]_i_1_n_7 ),
        .Q(bit_count[16]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \bit_count_reg[16]_i_1 
       (.CI(\bit_count_reg[12]_i_1_n_0 ),
        .CO({\bit_count_reg[16]_i_1_n_0 ,\bit_count_reg[16]_i_1_n_1 ,\bit_count_reg[16]_i_1_n_2 ,\bit_count_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\bit_count_reg[16]_i_1_n_4 ,\bit_count_reg[16]_i_1_n_5 ,\bit_count_reg[16]_i_1_n_6 ,\bit_count_reg[16]_i_1_n_7 }),
        .S(bit_count[19:16]));
  FDCE \bit_count_reg[17] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[16]_i_1_n_6 ),
        .Q(bit_count[17]));
  FDCE \bit_count_reg[18] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[16]_i_1_n_5 ),
        .Q(bit_count[18]));
  FDCE \bit_count_reg[19] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[16]_i_1_n_4 ),
        .Q(bit_count[19]));
  FDCE \bit_count_reg[1] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[0]_i_1_n_6 ),
        .Q(bit_count[1]));
  FDCE \bit_count_reg[20] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[20]_i_1_n_7 ),
        .Q(bit_count[20]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \bit_count_reg[20]_i_1 
       (.CI(\bit_count_reg[16]_i_1_n_0 ),
        .CO({\bit_count_reg[20]_i_1_n_0 ,\bit_count_reg[20]_i_1_n_1 ,\bit_count_reg[20]_i_1_n_2 ,\bit_count_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\bit_count_reg[20]_i_1_n_4 ,\bit_count_reg[20]_i_1_n_5 ,\bit_count_reg[20]_i_1_n_6 ,\bit_count_reg[20]_i_1_n_7 }),
        .S(bit_count[23:20]));
  FDCE \bit_count_reg[21] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[20]_i_1_n_6 ),
        .Q(bit_count[21]));
  FDCE \bit_count_reg[22] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[20]_i_1_n_5 ),
        .Q(bit_count[22]));
  FDCE \bit_count_reg[23] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[20]_i_1_n_4 ),
        .Q(bit_count[23]));
  FDCE \bit_count_reg[24] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[24]_i_1_n_7 ),
        .Q(bit_count[24]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \bit_count_reg[24]_i_1 
       (.CI(\bit_count_reg[20]_i_1_n_0 ),
        .CO({\bit_count_reg[24]_i_1_n_0 ,\bit_count_reg[24]_i_1_n_1 ,\bit_count_reg[24]_i_1_n_2 ,\bit_count_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\bit_count_reg[24]_i_1_n_4 ,\bit_count_reg[24]_i_1_n_5 ,\bit_count_reg[24]_i_1_n_6 ,\bit_count_reg[24]_i_1_n_7 }),
        .S(bit_count[27:24]));
  FDCE \bit_count_reg[25] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[24]_i_1_n_6 ),
        .Q(bit_count[25]));
  FDCE \bit_count_reg[26] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[24]_i_1_n_5 ),
        .Q(bit_count[26]));
  FDCE \bit_count_reg[27] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[24]_i_1_n_4 ),
        .Q(bit_count[27]));
  FDCE \bit_count_reg[28] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[28]_i_1_n_7 ),
        .Q(bit_count[28]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \bit_count_reg[28]_i_1 
       (.CI(\bit_count_reg[24]_i_1_n_0 ),
        .CO({\bit_count_reg[28]_i_1_n_0 ,\bit_count_reg[28]_i_1_n_1 ,\bit_count_reg[28]_i_1_n_2 ,\bit_count_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\bit_count_reg[28]_i_1_n_4 ,\bit_count_reg[28]_i_1_n_5 ,\bit_count_reg[28]_i_1_n_6 ,\bit_count_reg[28]_i_1_n_7 }),
        .S(bit_count[31:28]));
  FDCE \bit_count_reg[29] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[28]_i_1_n_6 ),
        .Q(bit_count[29]));
  FDCE \bit_count_reg[2] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[0]_i_1_n_5 ),
        .Q(bit_count[2]));
  FDCE \bit_count_reg[30] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[28]_i_1_n_5 ),
        .Q(bit_count[30]));
  FDCE \bit_count_reg[31] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[28]_i_1_n_4 ),
        .Q(bit_count[31]));
  FDCE \bit_count_reg[32] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[32]_i_1_n_7 ),
        .Q(bit_count[32]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \bit_count_reg[32]_i_1 
       (.CI(\bit_count_reg[28]_i_1_n_0 ),
        .CO({\bit_count_reg[32]_i_1_n_0 ,\bit_count_reg[32]_i_1_n_1 ,\bit_count_reg[32]_i_1_n_2 ,\bit_count_reg[32]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\bit_count_reg[32]_i_1_n_4 ,\bit_count_reg[32]_i_1_n_5 ,\bit_count_reg[32]_i_1_n_6 ,\bit_count_reg[32]_i_1_n_7 }),
        .S(bit_count[35:32]));
  FDCE \bit_count_reg[33] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[32]_i_1_n_6 ),
        .Q(bit_count[33]));
  FDCE \bit_count_reg[34] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[32]_i_1_n_5 ),
        .Q(bit_count[34]));
  FDCE \bit_count_reg[35] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[32]_i_1_n_4 ),
        .Q(bit_count[35]));
  FDCE \bit_count_reg[36] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[36]_i_1_n_7 ),
        .Q(bit_count[36]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \bit_count_reg[36]_i_1 
       (.CI(\bit_count_reg[32]_i_1_n_0 ),
        .CO({\NLW_bit_count_reg[36]_i_1_CO_UNCONNECTED [3],\bit_count_reg[36]_i_1_n_1 ,\bit_count_reg[36]_i_1_n_2 ,\bit_count_reg[36]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\bit_count_reg[36]_i_1_n_4 ,\bit_count_reg[36]_i_1_n_5 ,\bit_count_reg[36]_i_1_n_6 ,\bit_count_reg[36]_i_1_n_7 }),
        .S(bit_count[39:36]));
  FDCE \bit_count_reg[37] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[36]_i_1_n_6 ),
        .Q(bit_count[37]));
  FDCE \bit_count_reg[38] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[36]_i_1_n_5 ),
        .Q(bit_count[38]));
  FDCE \bit_count_reg[39] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[36]_i_1_n_4 ),
        .Q(bit_count[39]));
  FDCE \bit_count_reg[3] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[0]_i_1_n_4 ),
        .Q(bit_count[3]));
  FDCE \bit_count_reg[4] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[4]_i_1_n_7 ),
        .Q(bit_count[4]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \bit_count_reg[4]_i_1 
       (.CI(\bit_count_reg[0]_i_1_n_0 ),
        .CO({\bit_count_reg[4]_i_1_n_0 ,\bit_count_reg[4]_i_1_n_1 ,\bit_count_reg[4]_i_1_n_2 ,\bit_count_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\bit_count_reg[4]_i_1_n_4 ,\bit_count_reg[4]_i_1_n_5 ,\bit_count_reg[4]_i_1_n_6 ,\bit_count_reg[4]_i_1_n_7 }),
        .S(bit_count[7:4]));
  FDCE \bit_count_reg[5] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[4]_i_1_n_6 ),
        .Q(bit_count[5]));
  FDCE \bit_count_reg[6] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[4]_i_1_n_5 ),
        .Q(bit_count[6]));
  FDCE \bit_count_reg[7] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[4]_i_1_n_4 ),
        .Q(bit_count[7]));
  FDCE \bit_count_reg[8] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[8]_i_1_n_7 ),
        .Q(bit_count[8]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \bit_count_reg[8]_i_1 
       (.CI(\bit_count_reg[4]_i_1_n_0 ),
        .CO({\bit_count_reg[8]_i_1_n_0 ,\bit_count_reg[8]_i_1_n_1 ,\bit_count_reg[8]_i_1_n_2 ,\bit_count_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\bit_count_reg[8]_i_1_n_4 ,\bit_count_reg[8]_i_1_n_5 ,\bit_count_reg[8]_i_1_n_6 ,\bit_count_reg[8]_i_1_n_7 }),
        .S(bit_count[11:8]));
  FDCE \bit_count_reg[9] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\bit_count_reg[8]_i_1_n_6 ),
        .Q(bit_count[9]));
  LUT1 #(
    .INIT(2'h1)) 
    \bit_idx[0]_i_1 
       (.I0(bit_idx[0]),
        .O(\bit_idx[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \bit_idx[1]_i_1 
       (.I0(bit_idx[0]),
        .I1(bit_idx[1]),
        .O(\bit_idx[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \bit_idx[2]_i_1 
       (.I0(bit_idx[2]),
        .I1(bit_idx[1]),
        .I2(bit_idx[0]),
        .O(\bit_idx[2]_i_1_n_0 ));
  FDPE \bit_idx_reg[0] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .D(\bit_idx[0]_i_1_n_0 ),
        .PRE(aresetn_0),
        .Q(bit_idx[0]));
  FDPE \bit_idx_reg[1] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .D(\bit_idx[1]_i_1_n_0 ),
        .PRE(aresetn_0),
        .Q(bit_idx[1]));
  FDPE \bit_idx_reg[2] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .D(\bit_idx[2]_i_1_n_0 ),
        .PRE(aresetn_0),
        .Q(bit_idx[2]));
  LUT6 #(
    .INIT(64'hFFFFFFFB00000008)) 
    \bits_tdata[0]_i_1 
       (.I0(p_1_in0),
        .I1(\i_dump_prev[14]_i_1_n_0 ),
        .I2(bit_idx[0]),
        .I3(bit_idx[1]),
        .I4(bit_idx[2]),
        .I5(M_AXIS_BITS_TDATA[0]),
        .O(\bits_tdata[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEFFF00002000)) 
    \bits_tdata[1]_i_1 
       (.I0(p_1_in0),
        .I1(bit_idx[1]),
        .I2(bit_idx[0]),
        .I3(\i_dump_prev[14]_i_1_n_0 ),
        .I4(bit_idx[2]),
        .I5(M_AXIS_BITS_TDATA[1]),
        .O(\bits_tdata[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEFFF00002000)) 
    \bits_tdata[2]_i_1 
       (.I0(p_1_in0),
        .I1(bit_idx[0]),
        .I2(bit_idx[1]),
        .I3(\i_dump_prev[14]_i_1_n_0 ),
        .I4(bit_idx[2]),
        .I5(M_AXIS_BITS_TDATA[2]),
        .O(\bits_tdata[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \bits_tdata[3]_i_1 
       (.I0(p_1_in0),
        .I1(bit_idx[1]),
        .I2(bit_idx[0]),
        .I3(\i_dump_prev[14]_i_1_n_0 ),
        .I4(bit_idx[2]),
        .I5(M_AXIS_BITS_TDATA[3]),
        .O(\bits_tdata[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFEFFFFFF02000000)) 
    \bits_tdata[4]_i_1 
       (.I0(p_1_in0),
        .I1(bit_idx[1]),
        .I2(bit_idx[0]),
        .I3(\i_dump_prev[14]_i_1_n_0 ),
        .I4(bit_idx[2]),
        .I5(M_AXIS_BITS_TDATA[4]),
        .O(\bits_tdata[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEFFFFFFF20000000)) 
    \bits_tdata[5]_i_1 
       (.I0(p_1_in0),
        .I1(bit_idx[1]),
        .I2(bit_idx[0]),
        .I3(\i_dump_prev[14]_i_1_n_0 ),
        .I4(bit_idx[2]),
        .I5(M_AXIS_BITS_TDATA[5]),
        .O(\bits_tdata[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEFFFFFFF20000000)) 
    \bits_tdata[6]_i_1 
       (.I0(p_1_in0),
        .I1(bit_idx[0]),
        .I2(bit_idx[1]),
        .I3(\i_dump_prev[14]_i_1_n_0 ),
        .I4(bit_idx[2]),
        .I5(M_AXIS_BITS_TDATA[6]),
        .O(\bits_tdata[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBFFFFFFF80000000)) 
    \bits_tdata[7]_i_1 
       (.I0(p_1_in0),
        .I1(bit_idx[1]),
        .I2(bit_idx[0]),
        .I3(\i_dump_prev[14]_i_1_n_0 ),
        .I4(bit_idx[2]),
        .I5(M_AXIS_BITS_TDATA[7]),
        .O(\bits_tdata[7]_i_1_n_0 ));
  FDCE \bits_tdata_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(\bits_tdata[0]_i_1_n_0 ),
        .Q(M_AXIS_BITS_TDATA[0]));
  FDCE \bits_tdata_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(\bits_tdata[1]_i_1_n_0 ),
        .Q(M_AXIS_BITS_TDATA[1]));
  FDCE \bits_tdata_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(\bits_tdata[2]_i_1_n_0 ),
        .Q(M_AXIS_BITS_TDATA[2]));
  FDCE \bits_tdata_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(\bits_tdata[3]_i_1_n_0 ),
        .Q(M_AXIS_BITS_TDATA[3]));
  FDCE \bits_tdata_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(\bits_tdata[4]_i_1_n_0 ),
        .Q(M_AXIS_BITS_TDATA[4]));
  FDCE \bits_tdata_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(\bits_tdata[5]_i_1_n_0 ),
        .Q(M_AXIS_BITS_TDATA[5]));
  FDCE \bits_tdata_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(\bits_tdata[6]_i_1_n_0 ),
        .Q(M_AXIS_BITS_TDATA[6]));
  FDCE \bits_tdata_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(\bits_tdata[7]_i_1_n_0 ),
        .Q(M_AXIS_BITS_TDATA[7]));
  LUT6 #(
    .INIT(64'h4444444F44444444)) 
    bits_tvalid_i_1
       (.I0(M_AXIS_BITS_TREADY),
        .I1(M_AXIS_BITS_TVALID),
        .I2(bit_idx[2]),
        .I3(bit_idx[1]),
        .I4(bit_idx[0]),
        .I5(\i_dump_prev[14]_i_1_n_0 ),
        .O(bits_tvalid_i_1_n_0));
  FDCE bits_tvalid_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(bits_tvalid_i_1_n_0),
        .Q(M_AXIS_BITS_TVALID));
  LUT6 #(
    .INIT(64'hFBFBFBFB40000000)) 
    c_locked_i_1
       (.I0(core_bypass_costas),
        .I1(adc_valid_d1),
        .I2(err_small),
        .I3(lock_cnt_reg[6]),
        .I4(\lock_cnt[6]_i_3_n_0 ),
        .I5(c_locked_reg_0),
        .O(c_locked_i_1_n_0));
  FDCE c_locked_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(c_locked_i_1_n_0),
        .Q(c_locked_reg_0));
  CARRY4 dump_strobe0_carry
       (.CI(1'b0),
        .CO({dump_strobe0_carry_n_0,dump_strobe0_carry_n_1,dump_strobe0_carry_n_2,dump_strobe0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_dump_strobe0_carry_O_UNCONNECTED[3:0]),
        .S({dump_strobe0_carry_i_1_n_0,dump_strobe0_carry_i_2_n_0,dump_strobe0_carry_i_3_n_0,dump_strobe0_carry_i_4_n_0}));
  CARRY4 dump_strobe0_carry__0
       (.CI(dump_strobe0_carry_n_0),
        .CO({dump_strobe0_carry__0_n_0,dump_strobe0_carry__0_n_1,dump_strobe0_carry__0_n_2,dump_strobe0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_dump_strobe0_carry__0_O_UNCONNECTED[3:0]),
        .S({dump_strobe0_carry__0_i_1_n_0,dump_strobe0_carry__0_i_2_n_0,dump_strobe0_carry__0_i_3_n_0,dump_strobe0_carry__0_i_4_n_0}));
  LUT3 #(
    .INIT(8'hFE)) 
    dump_strobe0_carry__0_i_1
       (.I0(sps_eff[7]),
        .I1(dump_strobe0_carry_i_5_n_0),
        .I2(sps_eff[6]),
        .O(dump_strobe0_carry__0_i_1_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    dump_strobe0_carry__0_i_2
       (.I0(sps_eff[7]),
        .I1(dump_strobe0_carry_i_5_n_0),
        .I2(sps_eff[6]),
        .O(dump_strobe0_carry__0_i_2_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    dump_strobe0_carry__0_i_3
       (.I0(sps_eff[7]),
        .I1(dump_strobe0_carry_i_5_n_0),
        .I2(sps_eff[6]),
        .O(dump_strobe0_carry__0_i_3_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    dump_strobe0_carry__0_i_4
       (.I0(sps_eff[7]),
        .I1(dump_strobe0_carry_i_5_n_0),
        .I2(sps_eff[6]),
        .O(dump_strobe0_carry__0_i_4_n_0));
  CARRY4 dump_strobe0_carry__1
       (.CI(dump_strobe0_carry__0_n_0),
        .CO({NLW_dump_strobe0_carry__1_CO_UNCONNECTED[3],dump_strobe0,dump_strobe0_carry__1_n_2,dump_strobe0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_dump_strobe0_carry__1_O_UNCONNECTED[3:0]),
        .S({1'b0,dump_strobe0_carry__1_i_1_n_0,dump_strobe0_carry__1_i_2_n_0,dump_strobe0_carry__1_i_3_n_0}));
  LUT3 #(
    .INIT(8'hFE)) 
    dump_strobe0_carry__1_i_1
       (.I0(sps_eff[7]),
        .I1(dump_strobe0_carry_i_5_n_0),
        .I2(sps_eff[6]),
        .O(dump_strobe0_carry__1_i_1_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    dump_strobe0_carry__1_i_2
       (.I0(sps_eff[7]),
        .I1(dump_strobe0_carry_i_5_n_0),
        .I2(sps_eff[6]),
        .O(dump_strobe0_carry__1_i_2_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    dump_strobe0_carry__1_i_3
       (.I0(sps_eff[7]),
        .I1(dump_strobe0_carry_i_5_n_0),
        .I2(sps_eff[6]),
        .O(dump_strobe0_carry__1_i_3_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    dump_strobe0_carry_i_1
       (.I0(sps_eff[7]),
        .I1(dump_strobe0_carry_i_5_n_0),
        .I2(sps_eff[6]),
        .O(dump_strobe0_carry_i_1_n_0));
  LUT5 #(
    .INIT(32'h84422110)) 
    dump_strobe0_carry_i_2
       (.I0(sps_counter_reg[6]),
        .I1(sps_counter_reg[7]),
        .I2(sps_eff[6]),
        .I3(dump_strobe0_carry_i_5_n_0),
        .I4(sps_eff[7]),
        .O(dump_strobe0_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h0000000090090960)) 
    dump_strobe0_carry_i_3
       (.I0(sps_eff[5]),
        .I1(sps_counter_reg[5]),
        .I2(sps_counter_reg[4]),
        .I3(dump_strobe0_carry_i_6_n_0),
        .I4(sps_eff[4]),
        .I5(dump_strobe0_carry_i_7_n_0),
        .O(dump_strobe0_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h4120000800084120)) 
    dump_strobe0_carry_i_4
       (.I0(sps_counter_reg[0]),
        .I1(sps_counter_reg[1]),
        .I2(sps_eff[1]),
        .I3(sps_eff[0]),
        .I4(sps_counter_reg[2]),
        .I5(sps_eff[2]),
        .O(dump_strobe0_carry_i_4_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    dump_strobe0_carry_i_5
       (.I0(sps_eff[5]),
        .I1(sps_eff[3]),
        .I2(sps_eff[0]),
        .I3(sps_eff[1]),
        .I4(sps_eff[2]),
        .I5(sps_eff[4]),
        .O(dump_strobe0_carry_i_5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    dump_strobe0_carry_i_6
       (.I0(sps_eff[3]),
        .I1(sps_eff[0]),
        .I2(sps_eff[1]),
        .I3(sps_eff[2]),
        .O(dump_strobe0_carry_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT5 #(
    .INIT(32'h5556AAA9)) 
    dump_strobe0_carry_i_7
       (.I0(sps_counter_reg[3]),
        .I1(sps_eff[2]),
        .I2(sps_eff[1]),
        .I3(sps_eff[0]),
        .I4(sps_eff[3]),
        .O(dump_strobe0_carry_i_7_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 frac_timing0_carry
       (.CI(1'b0),
        .CO({frac_timing0_carry_n_0,frac_timing0_carry_n_1,frac_timing0_carry_n_2,frac_timing0_carry_n_3}),
        .CYINIT(1'b0),
        .DI({\frac_timing_reg_n_0_[3] ,\frac_timing_reg_n_0_[2] ,\frac_timing_reg_n_0_[1] ,\frac_timing_reg_n_0_[0] }),
        .O(frac_timing0[3:0]),
        .S({frac_timing0_carry_i_1_n_0,frac_timing0_carry_i_2_n_0,frac_timing0_carry_i_3_n_0,frac_timing0_carry_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 frac_timing0_carry__0
       (.CI(frac_timing0_carry_n_0),
        .CO({frac_timing0_carry__0_n_0,frac_timing0_carry__0_n_1,frac_timing0_carry__0_n_2,frac_timing0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({\frac_timing_reg_n_0_[7] ,\frac_timing_reg_n_0_[6] ,\frac_timing_reg_n_0_[5] ,\frac_timing_reg_n_0_[4] }),
        .O(frac_timing0[7:4]),
        .S({frac_timing0_carry__0_i_1_n_0,frac_timing0_carry__0_i_2_n_0,frac_timing0_carry__0_i_3_n_0,frac_timing0_carry__0_i_4_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__0_i_1
       (.I0(\frac_timing_reg_n_0_[7] ),
        .I1(timing_adj[7]),
        .O(frac_timing0_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__0_i_2
       (.I0(\frac_timing_reg_n_0_[6] ),
        .I1(timing_adj[6]),
        .O(frac_timing0_carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__0_i_3
       (.I0(\frac_timing_reg_n_0_[5] ),
        .I1(timing_adj[5]),
        .O(frac_timing0_carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__0_i_4
       (.I0(\frac_timing_reg_n_0_[4] ),
        .I1(timing_adj[4]),
        .O(frac_timing0_carry__0_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 frac_timing0_carry__1
       (.CI(frac_timing0_carry__0_n_0),
        .CO({frac_timing0_carry__1_n_0,frac_timing0_carry__1_n_1,frac_timing0_carry__1_n_2,frac_timing0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({\frac_timing_reg_n_0_[11] ,\frac_timing_reg_n_0_[10] ,\frac_timing_reg_n_0_[9] ,\frac_timing_reg_n_0_[8] }),
        .O(frac_timing0[11:8]),
        .S({frac_timing0_carry__1_i_1_n_0,frac_timing0_carry__1_i_2_n_0,frac_timing0_carry__1_i_3_n_0,frac_timing0_carry__1_i_4_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__1_i_1
       (.I0(\frac_timing_reg_n_0_[11] ),
        .I1(timing_adj[11]),
        .O(frac_timing0_carry__1_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__1_i_2
       (.I0(\frac_timing_reg_n_0_[10] ),
        .I1(timing_adj[10]),
        .O(frac_timing0_carry__1_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__1_i_3
       (.I0(\frac_timing_reg_n_0_[9] ),
        .I1(timing_adj[9]),
        .O(frac_timing0_carry__1_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__1_i_4
       (.I0(\frac_timing_reg_n_0_[8] ),
        .I1(timing_adj[8]),
        .O(frac_timing0_carry__1_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 frac_timing0_carry__2
       (.CI(frac_timing0_carry__1_n_0),
        .CO({NLW_frac_timing0_carry__2_CO_UNCONNECTED[3],frac_timing0_carry__2_n_1,frac_timing0_carry__2_n_2,frac_timing0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,\frac_timing_reg_n_0_[14] ,\frac_timing_reg_n_0_[13] ,\frac_timing_reg_n_0_[12] }),
        .O(frac_timing0[15:12]),
        .S({frac_timing0_carry__2_i_1_n_0,frac_timing0_carry__2_i_2_n_0,frac_timing0_carry__2_i_3_n_0,frac_timing0_carry__2_i_4_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__2_i_1
       (.I0(timing_adj[15]),
        .I1(\frac_timing_reg_n_0_[15] ),
        .O(frac_timing0_carry__2_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__2_i_2
       (.I0(\frac_timing_reg_n_0_[14] ),
        .I1(timing_adj[14]),
        .O(frac_timing0_carry__2_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__2_i_3
       (.I0(\frac_timing_reg_n_0_[13] ),
        .I1(timing_adj[13]),
        .O(frac_timing0_carry__2_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry__2_i_4
       (.I0(\frac_timing_reg_n_0_[12] ),
        .I1(timing_adj[12]),
        .O(frac_timing0_carry__2_i_4_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry_i_1
       (.I0(\frac_timing_reg_n_0_[3] ),
        .I1(timing_adj[3]),
        .O(frac_timing0_carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry_i_2
       (.I0(\frac_timing_reg_n_0_[2] ),
        .I1(timing_adj[2]),
        .O(frac_timing0_carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry_i_3
       (.I0(\frac_timing_reg_n_0_[1] ),
        .I1(timing_adj[1]),
        .O(frac_timing0_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    frac_timing0_carry_i_4
       (.I0(\frac_timing_reg_n_0_[0] ),
        .I1(timing_adj[0]),
        .O(frac_timing0_carry_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \frac_timing0_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\frac_timing0_inferred__0/i__carry_n_0 ,\frac_timing0_inferred__0/i__carry_n_1 ,\frac_timing0_inferred__0/i__carry_n_2 ,\frac_timing0_inferred__0/i__carry_n_3 }),
        .CYINIT(1'b0),
        .DI({\frac_timing_reg_n_0_[3] ,\frac_timing_reg_n_0_[2] ,\frac_timing_reg_n_0_[1] ,\frac_timing_reg_n_0_[0] }),
        .O({frac_timing01_in[3:1],\NLW_frac_timing0_inferred__0/i__carry_O_UNCONNECTED [0]}),
        .S({i__carry_i_1__0_n_0,i__carry_i_2__0_n_0,i__carry_i_3__0_n_0,i__carry_i_4__0_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \frac_timing0_inferred__0/i__carry__0 
       (.CI(\frac_timing0_inferred__0/i__carry_n_0 ),
        .CO({\frac_timing0_inferred__0/i__carry__0_n_0 ,\frac_timing0_inferred__0/i__carry__0_n_1 ,\frac_timing0_inferred__0/i__carry__0_n_2 ,\frac_timing0_inferred__0/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI({\frac_timing_reg_n_0_[7] ,\frac_timing_reg_n_0_[6] ,\frac_timing_reg_n_0_[5] ,\frac_timing_reg_n_0_[4] }),
        .O(frac_timing01_in[7:4]),
        .S({i__carry__0_i_1__0_n_0,i__carry__0_i_2__0_n_0,i__carry__0_i_3__0_n_0,i__carry__0_i_4__0_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \frac_timing0_inferred__0/i__carry__1 
       (.CI(\frac_timing0_inferred__0/i__carry__0_n_0 ),
        .CO({\frac_timing0_inferred__0/i__carry__1_n_0 ,\frac_timing0_inferred__0/i__carry__1_n_1 ,\frac_timing0_inferred__0/i__carry__1_n_2 ,\frac_timing0_inferred__0/i__carry__1_n_3 }),
        .CYINIT(1'b0),
        .DI({\frac_timing_reg_n_0_[11] ,\frac_timing_reg_n_0_[10] ,\frac_timing_reg_n_0_[9] ,\frac_timing_reg_n_0_[8] }),
        .O(frac_timing01_in[11:8]),
        .S({i__carry__1_i_1_n_0,i__carry__1_i_2_n_0,i__carry__1_i_3_n_0,i__carry__1_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \frac_timing0_inferred__0/i__carry__2 
       (.CI(\frac_timing0_inferred__0/i__carry__1_n_0 ),
        .CO({\NLW_frac_timing0_inferred__0/i__carry__2_CO_UNCONNECTED [3],\frac_timing0_inferred__0/i__carry__2_n_1 ,\frac_timing0_inferred__0/i__carry__2_n_2 ,\frac_timing0_inferred__0/i__carry__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\frac_timing_reg_n_0_[14] ,\frac_timing_reg_n_0_[13] ,\frac_timing_reg_n_0_[12] }),
        .O(frac_timing01_in[15:12]),
        .S({i__carry__2_i_1_n_0,i__carry__2_i_2_n_0,i__carry__2_i_3_n_0,i__carry__2_i_4_n_0}));
  LUT5 #(
    .INIT(32'h0000F606)) 
    \frac_timing[0]_i_1 
       (.I0(\frac_timing_reg_n_0_[0] ),
        .I1(timing_adj[0]),
        .I2(\frac_timing[0]_i_2_n_0 ),
        .I3(frac_timing0[0]),
        .I4(core_bypass_timing),
        .O(\frac_timing[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h0D)) 
    \frac_timing[0]_i_2 
       (.I0(\frac_timing_reg_n_0_[15] ),
        .I1(\frac_timing_reg_n_0_[14] ),
        .I2(sps_eff13_in),
        .O(\frac_timing[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[10]_i_1 
       (.I0(frac_timing01_in[10]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[10]),
        .I5(core_bypass_timing),
        .O(\frac_timing[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[11]_i_1 
       (.I0(frac_timing01_in[11]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[11]),
        .I5(core_bypass_timing),
        .O(\frac_timing[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[12]_i_1 
       (.I0(frac_timing01_in[12]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[12]),
        .I5(core_bypass_timing),
        .O(\frac_timing[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[13]_i_1 
       (.I0(frac_timing01_in[13]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[13]),
        .I5(core_bypass_timing),
        .O(\frac_timing[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[14]_i_1 
       (.I0(frac_timing01_in[14]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[14]),
        .I5(core_bypass_timing),
        .O(\frac_timing[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[15]_i_1 
       (.I0(frac_timing01_in[15]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[15]),
        .I5(core_bypass_timing),
        .O(\frac_timing[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[1]_i_1 
       (.I0(frac_timing01_in[1]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[1]),
        .I5(core_bypass_timing),
        .O(\frac_timing[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[2]_i_1 
       (.I0(frac_timing01_in[2]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[2]),
        .I5(core_bypass_timing),
        .O(\frac_timing[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[3]_i_1 
       (.I0(frac_timing01_in[3]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[3]),
        .I5(core_bypass_timing),
        .O(\frac_timing[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[4]_i_1 
       (.I0(frac_timing01_in[4]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[4]),
        .I5(core_bypass_timing),
        .O(\frac_timing[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[5]_i_1 
       (.I0(frac_timing01_in[5]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[5]),
        .I5(core_bypass_timing),
        .O(\frac_timing[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[6]_i_1 
       (.I0(frac_timing01_in[6]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[6]),
        .I5(core_bypass_timing),
        .O(\frac_timing[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[7]_i_1 
       (.I0(frac_timing01_in[7]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[7]),
        .I5(core_bypass_timing),
        .O(\frac_timing[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[8]_i_1 
       (.I0(frac_timing01_in[8]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[8]),
        .I5(core_bypass_timing),
        .O(\frac_timing[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000BABB8A88)) 
    \frac_timing[9]_i_1 
       (.I0(frac_timing01_in[9]),
        .I1(sps_eff13_in),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(frac_timing0[9]),
        .I5(core_bypass_timing),
        .O(\frac_timing[9]_i_1_n_0 ));
  FDCE \frac_timing_reg[0] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[0]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[0] ));
  FDCE \frac_timing_reg[10] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[10]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[10] ));
  FDCE \frac_timing_reg[11] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[11]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[11] ));
  FDCE \frac_timing_reg[12] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[12]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[12] ));
  FDCE \frac_timing_reg[13] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[13]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[13] ));
  FDCE \frac_timing_reg[14] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[14]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[14] ));
  FDCE \frac_timing_reg[15] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[15]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[15] ));
  FDCE \frac_timing_reg[1] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[1]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[1] ));
  FDCE \frac_timing_reg[2] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[2]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[2] ));
  FDCE \frac_timing_reg[3] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[3]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[3] ));
  FDCE \frac_timing_reg[4] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[4]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[4] ));
  FDCE \frac_timing_reg[5] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[5]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[5] ));
  FDCE \frac_timing_reg[6] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[6]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[6] ));
  FDCE \frac_timing_reg[7] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[7]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[7] ));
  FDCE \frac_timing_reg[8] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[8]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[8] ));
  FDCE \frac_timing_reg[9] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\frac_timing[9]_i_1_n_0 ),
        .Q(\frac_timing_reg_n_0_[9] ));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-13 {cell *THIS*}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(0),
    .BREG(0),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    freq_int2
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,freq_int2_0}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_freq_int2_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({B[15],B[15],B}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_freq_int2_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_freq_int2_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_freq_int2_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CLK(1'b0),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_freq_int2_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_freq_int2_OVERFLOW_UNCONNECTED),
        .P({NLW_freq_int2_P_UNCONNECTED[47:33],freq_int2_n_73,freq_int2_n_74,freq_int2_n_75,freq_int2_n_76,freq_int2_n_77,freq_int2_n_78,freq_int2_n_79,freq_int2_n_80,freq_int2_n_81,freq_int2_n_82,freq_int2_n_83,freq_int2_n_84,freq_int2_n_85,freq_int2_n_86,freq_int2_n_87,freq_int2_n_88,freq_int2_n_89,freq_int2_n_90,freq_int2_n_91,freq_int2_n_92,freq_int2_n_93,freq_int2_n_94,freq_int2_n_95,freq_int2_n_96,freq_int2_n_97,freq_int2_n_98,freq_int2_n_99,freq_int2_n_100,freq_int2_n_101,freq_int2_n_102,freq_int2_n_103,freq_int2_n_104,freq_int2_n_105}),
        .PATTERNBDETECT(NLW_freq_int2_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_freq_int2_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_freq_int2_PCOUT_UNCONNECTED[47:0]),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_freq_int2_UNDERFLOW_UNCONNECTED));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_1
       (.I0(phase_err_p0[15]),
        .I1(i_mix[15]),
        .I2(q_mix[15]),
        .O(B[15]));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_10
       (.I0(phase_err_p0[6]),
        .I1(i_mix[15]),
        .I2(q_mix[6]),
        .O(B[6]));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_11
       (.I0(phase_err_p0[5]),
        .I1(i_mix[15]),
        .I2(q_mix[5]),
        .O(B[5]));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_12
       (.I0(phase_err_p0[4]),
        .I1(i_mix[15]),
        .I2(q_mix[4]),
        .O(B[4]));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_13
       (.I0(phase_err_p0[3]),
        .I1(i_mix[15]),
        .I2(q_mix[3]),
        .O(B[3]));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_14
       (.I0(phase_err_p0[2]),
        .I1(i_mix[15]),
        .I2(q_mix[2]),
        .O(B[2]));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_15
       (.I0(phase_err_p0[1]),
        .I1(i_mix[15]),
        .I2(q_mix[1]),
        .O(B[1]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 freq_int2_i_16
       (.CI(freq_int2_i_17_n_0),
        .CO({NLW_freq_int2_i_16_CO_UNCONNECTED[3:2],freq_int2_i_16_n_2,freq_int2_i_16_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_freq_int2_i_16_O_UNCONNECTED[3],phase_err_p0[15:13]}),
        .S({1'b0,freq_int2_i_20_n_0,freq_int2_i_21_n_0,freq_int2_i_22_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 freq_int2_i_17
       (.CI(freq_int2_i_18_n_0),
        .CO({freq_int2_i_17_n_0,freq_int2_i_17_n_1,freq_int2_i_17_n_2,freq_int2_i_17_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(phase_err_p0[12:9]),
        .S({freq_int2_i_23_n_0,freq_int2_i_24_n_0,freq_int2_i_25_n_0,freq_int2_i_26_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 freq_int2_i_18
       (.CI(freq_int2_i_19_n_0),
        .CO({freq_int2_i_18_n_0,freq_int2_i_18_n_1,freq_int2_i_18_n_2,freq_int2_i_18_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(phase_err_p0[8:5]),
        .S({freq_int2_i_27_n_0,freq_int2_i_28_n_0,freq_int2_i_29_n_0,freq_int2_i_30_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 freq_int2_i_19
       (.CI(1'b0),
        .CO({freq_int2_i_19_n_0,freq_int2_i_19_n_1,freq_int2_i_19_n_2,freq_int2_i_19_n_3}),
        .CYINIT(freq_int2_i_31_n_0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(phase_err_p0[4:1]),
        .S({freq_int2_i_32_n_0,freq_int2_i_33_n_0,freq_int2_i_34_n_0,freq_int2_i_35_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_2
       (.I0(phase_err_p0[14]),
        .I1(i_mix[15]),
        .I2(q_mix[14]),
        .O(B[14]));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_20
       (.I0(q_mix[15]),
        .O(freq_int2_i_20_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_21
       (.I0(q_mix[14]),
        .O(freq_int2_i_21_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_22
       (.I0(q_mix[13]),
        .O(freq_int2_i_22_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_23
       (.I0(q_mix[12]),
        .O(freq_int2_i_23_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_24
       (.I0(q_mix[11]),
        .O(freq_int2_i_24_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_25
       (.I0(q_mix[10]),
        .O(freq_int2_i_25_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_26
       (.I0(q_mix[9]),
        .O(freq_int2_i_26_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_27
       (.I0(q_mix[8]),
        .O(freq_int2_i_27_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_28
       (.I0(q_mix[7]),
        .O(freq_int2_i_28_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_29
       (.I0(q_mix[6]),
        .O(freq_int2_i_29_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_3
       (.I0(phase_err_p0[13]),
        .I1(i_mix[15]),
        .I2(q_mix[13]),
        .O(B[13]));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_30
       (.I0(q_mix[5]),
        .O(freq_int2_i_30_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_31
       (.I0(B[0]),
        .O(freq_int2_i_31_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_32
       (.I0(q_mix[4]),
        .O(freq_int2_i_32_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_33
       (.I0(q_mix[3]),
        .O(freq_int2_i_33_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_34
       (.I0(q_mix[2]),
        .O(freq_int2_i_34_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    freq_int2_i_35
       (.I0(q_mix[1]),
        .O(freq_int2_i_35_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_4
       (.I0(phase_err_p0[12]),
        .I1(i_mix[15]),
        .I2(q_mix[12]),
        .O(B[12]));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_5
       (.I0(phase_err_p0[11]),
        .I1(i_mix[15]),
        .I2(q_mix[11]),
        .O(B[11]));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_6
       (.I0(phase_err_p0[10]),
        .I1(i_mix[15]),
        .I2(q_mix[10]),
        .O(B[10]));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_7
       (.I0(phase_err_p0[9]),
        .I1(i_mix[15]),
        .I2(q_mix[9]),
        .O(B[9]));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_8
       (.I0(phase_err_p0[8]),
        .I1(i_mix[15]),
        .I2(q_mix[8]),
        .O(B[8]));
  LUT3 #(
    .INIT(8'hB8)) 
    freq_int2_i_9
       (.I0(phase_err_p0[7]),
        .I1(i_mix[15]),
        .I2(q_mix[7]),
        .O(B[7]));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[12]_i_11 
       (.I0(freq_int2_n_91),
        .O(\freq_int[12]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[12]_i_12 
       (.I0(freq_int2_n_92),
        .O(\freq_int[12]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[12]_i_13 
       (.I0(freq_int2_n_93),
        .O(\freq_int[12]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[12]_i_14 
       (.I0(freq_int2_n_94),
        .O(\freq_int[12]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[12]_i_2 
       (.I0(\freq_int_reg[12]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_int[12]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[12]_i_3 
       (.I0(\freq_int_reg[8]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_int[12]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[12]_i_4 
       (.I0(\freq_int_reg[8]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_int[12]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[12]_i_5 
       (.I0(\freq_int_reg[8]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_int[12]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[12]_i_6 
       (.I0(\freq_int_reg[12]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[15]),
        .O(\freq_int[12]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[12]_i_7 
       (.I0(\freq_int_reg[8]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[14]),
        .O(\freq_int[12]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[12]_i_8 
       (.I0(\freq_int_reg[8]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[13]),
        .O(\freq_int[12]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[12]_i_9 
       (.I0(\freq_int_reg[8]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[12]),
        .O(\freq_int[12]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[16]_i_11 
       (.I0(freq_int2_n_87),
        .O(\freq_int[16]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[16]_i_12 
       (.I0(freq_int2_n_88),
        .O(\freq_int[16]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[16]_i_13 
       (.I0(freq_int2_n_89),
        .O(\freq_int[16]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[16]_i_14 
       (.I0(freq_int2_n_90),
        .O(\freq_int[16]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[16]_i_2 
       (.I0(\freq_int_reg[16]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_int[16]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[16]_i_3 
       (.I0(\freq_int_reg[12]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_int[16]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[16]_i_4 
       (.I0(\freq_int_reg[12]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_int[16]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[16]_i_5 
       (.I0(\freq_int_reg[12]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_int[16]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[16]_i_6 
       (.I0(\freq_int_reg[16]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[19]),
        .O(\freq_int[16]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[16]_i_7 
       (.I0(\freq_int_reg[12]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[18]),
        .O(\freq_int[16]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[16]_i_8 
       (.I0(\freq_int_reg[12]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[17]),
        .O(\freq_int[16]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[16]_i_9 
       (.I0(\freq_int_reg[12]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[16]),
        .O(\freq_int[16]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[20]_i_11 
       (.I0(freq_int2_n_83),
        .O(\freq_int[20]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[20]_i_12 
       (.I0(freq_int2_n_84),
        .O(\freq_int[20]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[20]_i_13 
       (.I0(freq_int2_n_85),
        .O(\freq_int[20]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[20]_i_14 
       (.I0(freq_int2_n_86),
        .O(\freq_int[20]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[20]_i_2 
       (.I0(\freq_int_reg[20]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_int[20]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[20]_i_3 
       (.I0(\freq_int_reg[16]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_int[20]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[20]_i_4 
       (.I0(\freq_int_reg[16]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_int[20]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[20]_i_5 
       (.I0(\freq_int_reg[16]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_int[20]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[20]_i_6 
       (.I0(\freq_int_reg[20]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[23]),
        .O(\freq_int[20]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[20]_i_7 
       (.I0(\freq_int_reg[16]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[22]),
        .O(\freq_int[20]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[20]_i_8 
       (.I0(\freq_int_reg[16]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[21]),
        .O(\freq_int[20]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[20]_i_9 
       (.I0(\freq_int_reg[16]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[20]),
        .O(\freq_int[20]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[24]_i_11 
       (.I0(freq_int2_n_79),
        .O(\freq_int[24]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[24]_i_12 
       (.I0(freq_int2_n_80),
        .O(\freq_int[24]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[24]_i_13 
       (.I0(freq_int2_n_81),
        .O(\freq_int[24]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[24]_i_14 
       (.I0(freq_int2_n_82),
        .O(\freq_int[24]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[24]_i_2 
       (.I0(\freq_int_reg[24]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_int[24]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[24]_i_3 
       (.I0(\freq_int_reg[20]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_int[24]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[24]_i_4 
       (.I0(\freq_int_reg[20]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_int[24]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[24]_i_5 
       (.I0(\freq_int_reg[20]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_int[24]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[24]_i_6 
       (.I0(\freq_int_reg[24]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[27]),
        .O(\freq_int[24]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[24]_i_7 
       (.I0(\freq_int_reg[20]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[26]),
        .O(\freq_int[24]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[24]_i_8 
       (.I0(\freq_int_reg[20]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[25]),
        .O(\freq_int[24]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[24]_i_9 
       (.I0(\freq_int_reg[20]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[24]),
        .O(\freq_int[24]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[28]_i_10 
       (.I0(freq_int2_n_78),
        .O(\freq_int[28]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[28]_i_2 
       (.I0(\freq_int_reg[24]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_int[28]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[28]_i_3 
       (.I0(\freq_int_reg[24]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_int[28]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[28]_i_4 
       (.I0(\freq_int_reg[24]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_int[28]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[28]_i_5 
       (.I0(freq_int_reg[31]),
        .I1(core_bypass_costas),
        .I2(\freq_int_reg[28]_i_9_n_7 ),
        .O(\freq_int[28]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[28]_i_6 
       (.I0(\freq_int_reg[24]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[30]),
        .O(\freq_int[28]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[28]_i_7 
       (.I0(\freq_int_reg[24]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[29]),
        .O(\freq_int[28]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[28]_i_8 
       (.I0(\freq_int_reg[24]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[28]),
        .O(\freq_int[28]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[4]_i_12 
       (.I0(freq_int2_n_99),
        .O(\freq_int[4]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[4]_i_13 
       (.I0(freq_int2_n_100),
        .O(\freq_int[4]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[4]_i_14 
       (.I0(freq_int2_n_101),
        .O(\freq_int[4]_i_14_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[4]_i_15 
       (.I0(freq_int2_n_102),
        .O(\freq_int[4]_i_15_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[4]_i_16 
       (.I0(freq_int2_n_105),
        .O(\freq_int[4]_i_16_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[4]_i_17 
       (.I0(freq_int2_n_103),
        .O(\freq_int[4]_i_17_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[4]_i_18 
       (.I0(freq_int2_n_104),
        .O(\freq_int[4]_i_18_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[4]_i_2 
       (.I0(\freq_int_reg[4]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_int[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[4]_i_3 
       (.I0(\freq_int_reg[4]_i_11_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_int[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[4]_i_4 
       (.I0(\freq_int_reg[4]_i_11_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_int[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[4]_i_5 
       (.I0(\freq_int_reg[4]_i_11_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_int[4]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[4]_i_6 
       (.I0(\freq_int_reg[4]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[7]),
        .O(\freq_int[4]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[4]_i_7 
       (.I0(\freq_int_reg[4]_i_11_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[6]),
        .O(\freq_int[4]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[4]_i_8 
       (.I0(\freq_int_reg[4]_i_11_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[5]),
        .O(\freq_int[4]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[4]_i_9 
       (.I0(\freq_int_reg[4]_i_11_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[4]),
        .O(\freq_int[4]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[8]_i_11 
       (.I0(freq_int2_n_95),
        .O(\freq_int[8]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[8]_i_12 
       (.I0(freq_int2_n_96),
        .O(\freq_int[8]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[8]_i_13 
       (.I0(freq_int2_n_97),
        .O(\freq_int[8]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_int[8]_i_14 
       (.I0(freq_int2_n_98),
        .O(\freq_int[8]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[8]_i_2 
       (.I0(\freq_int_reg[8]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_int[8]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[8]_i_3 
       (.I0(\freq_int_reg[4]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_int[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[8]_i_4 
       (.I0(\freq_int_reg[4]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_int[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_int[8]_i_5 
       (.I0(\freq_int_reg[4]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_int[8]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[8]_i_6 
       (.I0(\freq_int_reg[8]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[11]),
        .O(\freq_int[8]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[8]_i_7 
       (.I0(\freq_int_reg[4]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[10]),
        .O(\freq_int[8]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[8]_i_8 
       (.I0(\freq_int_reg[4]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[9]),
        .O(\freq_int[8]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_int[8]_i_9 
       (.I0(\freq_int_reg[4]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[8]),
        .O(\freq_int[8]_i_9_n_0 ));
  FDCE \freq_int_reg[10] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[8]_i_1_n_5 ),
        .Q(freq_int_reg[10]));
  FDCE \freq_int_reg[11] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[8]_i_1_n_4 ),
        .Q(freq_int_reg[11]));
  FDCE \freq_int_reg[12] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[12]_i_1_n_7 ),
        .Q(freq_int_reg[12]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \freq_int_reg[12]_i_1 
       (.CI(\freq_int_reg[8]_i_1_n_0 ),
        .CO({\freq_int_reg[12]_i_1_n_0 ,\freq_int_reg[12]_i_1_n_1 ,\freq_int_reg[12]_i_1_n_2 ,\freq_int_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_int[12]_i_2_n_0 ,\freq_int[12]_i_3_n_0 ,\freq_int[12]_i_4_n_0 ,\freq_int[12]_i_5_n_0 }),
        .O({\freq_int_reg[12]_i_1_n_4 ,\freq_int_reg[12]_i_1_n_5 ,\freq_int_reg[12]_i_1_n_6 ,\freq_int_reg[12]_i_1_n_7 }),
        .S({\freq_int[12]_i_6_n_0 ,\freq_int[12]_i_7_n_0 ,\freq_int[12]_i_8_n_0 ,\freq_int[12]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_int_reg[12]_i_10 
       (.CI(\freq_int_reg[8]_i_10_n_0 ),
        .CO({\freq_int_reg[12]_i_10_n_0 ,\freq_int_reg[12]_i_10_n_1 ,\freq_int_reg[12]_i_10_n_2 ,\freq_int_reg[12]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_int_reg[12]_i_10_n_4 ,\freq_int_reg[12]_i_10_n_5 ,\freq_int_reg[12]_i_10_n_6 ,\freq_int_reg[12]_i_10_n_7 }),
        .S({\freq_int[12]_i_11_n_0 ,\freq_int[12]_i_12_n_0 ,\freq_int[12]_i_13_n_0 ,\freq_int[12]_i_14_n_0 }));
  FDCE \freq_int_reg[13] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[12]_i_1_n_6 ),
        .Q(freq_int_reg[13]));
  FDCE \freq_int_reg[14] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[12]_i_1_n_5 ),
        .Q(freq_int_reg[14]));
  FDCE \freq_int_reg[15] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[12]_i_1_n_4 ),
        .Q(freq_int_reg[15]));
  FDCE \freq_int_reg[16] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[16]_i_1_n_7 ),
        .Q(freq_int_reg[16]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \freq_int_reg[16]_i_1 
       (.CI(\freq_int_reg[12]_i_1_n_0 ),
        .CO({\freq_int_reg[16]_i_1_n_0 ,\freq_int_reg[16]_i_1_n_1 ,\freq_int_reg[16]_i_1_n_2 ,\freq_int_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_int[16]_i_2_n_0 ,\freq_int[16]_i_3_n_0 ,\freq_int[16]_i_4_n_0 ,\freq_int[16]_i_5_n_0 }),
        .O({\freq_int_reg[16]_i_1_n_4 ,\freq_int_reg[16]_i_1_n_5 ,\freq_int_reg[16]_i_1_n_6 ,\freq_int_reg[16]_i_1_n_7 }),
        .S({\freq_int[16]_i_6_n_0 ,\freq_int[16]_i_7_n_0 ,\freq_int[16]_i_8_n_0 ,\freq_int[16]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_int_reg[16]_i_10 
       (.CI(\freq_int_reg[12]_i_10_n_0 ),
        .CO({\freq_int_reg[16]_i_10_n_0 ,\freq_int_reg[16]_i_10_n_1 ,\freq_int_reg[16]_i_10_n_2 ,\freq_int_reg[16]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_int_reg[16]_i_10_n_4 ,\freq_int_reg[16]_i_10_n_5 ,\freq_int_reg[16]_i_10_n_6 ,\freq_int_reg[16]_i_10_n_7 }),
        .S({\freq_int[16]_i_11_n_0 ,\freq_int[16]_i_12_n_0 ,\freq_int[16]_i_13_n_0 ,\freq_int[16]_i_14_n_0 }));
  FDCE \freq_int_reg[17] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[16]_i_1_n_6 ),
        .Q(freq_int_reg[17]));
  FDCE \freq_int_reg[18] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[16]_i_1_n_5 ),
        .Q(freq_int_reg[18]));
  FDCE \freq_int_reg[19] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[16]_i_1_n_4 ),
        .Q(freq_int_reg[19]));
  FDCE \freq_int_reg[20] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[20]_i_1_n_7 ),
        .Q(freq_int_reg[20]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \freq_int_reg[20]_i_1 
       (.CI(\freq_int_reg[16]_i_1_n_0 ),
        .CO({\freq_int_reg[20]_i_1_n_0 ,\freq_int_reg[20]_i_1_n_1 ,\freq_int_reg[20]_i_1_n_2 ,\freq_int_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_int[20]_i_2_n_0 ,\freq_int[20]_i_3_n_0 ,\freq_int[20]_i_4_n_0 ,\freq_int[20]_i_5_n_0 }),
        .O({\freq_int_reg[20]_i_1_n_4 ,\freq_int_reg[20]_i_1_n_5 ,\freq_int_reg[20]_i_1_n_6 ,\freq_int_reg[20]_i_1_n_7 }),
        .S({\freq_int[20]_i_6_n_0 ,\freq_int[20]_i_7_n_0 ,\freq_int[20]_i_8_n_0 ,\freq_int[20]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_int_reg[20]_i_10 
       (.CI(\freq_int_reg[16]_i_10_n_0 ),
        .CO({\freq_int_reg[20]_i_10_n_0 ,\freq_int_reg[20]_i_10_n_1 ,\freq_int_reg[20]_i_10_n_2 ,\freq_int_reg[20]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_int_reg[20]_i_10_n_4 ,\freq_int_reg[20]_i_10_n_5 ,\freq_int_reg[20]_i_10_n_6 ,\freq_int_reg[20]_i_10_n_7 }),
        .S({\freq_int[20]_i_11_n_0 ,\freq_int[20]_i_12_n_0 ,\freq_int[20]_i_13_n_0 ,\freq_int[20]_i_14_n_0 }));
  FDCE \freq_int_reg[21] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[20]_i_1_n_6 ),
        .Q(freq_int_reg[21]));
  FDCE \freq_int_reg[22] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[20]_i_1_n_5 ),
        .Q(freq_int_reg[22]));
  FDCE \freq_int_reg[23] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[20]_i_1_n_4 ),
        .Q(freq_int_reg[23]));
  FDCE \freq_int_reg[24] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[24]_i_1_n_7 ),
        .Q(freq_int_reg[24]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \freq_int_reg[24]_i_1 
       (.CI(\freq_int_reg[20]_i_1_n_0 ),
        .CO({\freq_int_reg[24]_i_1_n_0 ,\freq_int_reg[24]_i_1_n_1 ,\freq_int_reg[24]_i_1_n_2 ,\freq_int_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_int[24]_i_2_n_0 ,\freq_int[24]_i_3_n_0 ,\freq_int[24]_i_4_n_0 ,\freq_int[24]_i_5_n_0 }),
        .O({\freq_int_reg[24]_i_1_n_4 ,\freq_int_reg[24]_i_1_n_5 ,\freq_int_reg[24]_i_1_n_6 ,\freq_int_reg[24]_i_1_n_7 }),
        .S({\freq_int[24]_i_6_n_0 ,\freq_int[24]_i_7_n_0 ,\freq_int[24]_i_8_n_0 ,\freq_int[24]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_int_reg[24]_i_10 
       (.CI(\freq_int_reg[20]_i_10_n_0 ),
        .CO({\freq_int_reg[24]_i_10_n_0 ,\freq_int_reg[24]_i_10_n_1 ,\freq_int_reg[24]_i_10_n_2 ,\freq_int_reg[24]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_int_reg[24]_i_10_n_4 ,\freq_int_reg[24]_i_10_n_5 ,\freq_int_reg[24]_i_10_n_6 ,\freq_int_reg[24]_i_10_n_7 }),
        .S({\freq_int[24]_i_11_n_0 ,\freq_int[24]_i_12_n_0 ,\freq_int[24]_i_13_n_0 ,\freq_int[24]_i_14_n_0 }));
  FDCE \freq_int_reg[25] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[24]_i_1_n_6 ),
        .Q(freq_int_reg[25]));
  FDCE \freq_int_reg[26] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[24]_i_1_n_5 ),
        .Q(freq_int_reg[26]));
  FDCE \freq_int_reg[27] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[24]_i_1_n_4 ),
        .Q(freq_int_reg[27]));
  FDCE \freq_int_reg[28] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[28]_i_1_n_7 ),
        .Q(freq_int_reg[28]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \freq_int_reg[28]_i_1 
       (.CI(\freq_int_reg[24]_i_1_n_0 ),
        .CO({\NLW_freq_int_reg[28]_i_1_CO_UNCONNECTED [3],\freq_int_reg[28]_i_1_n_1 ,\freq_int_reg[28]_i_1_n_2 ,\freq_int_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\freq_int[28]_i_2_n_0 ,\freq_int[28]_i_3_n_0 ,\freq_int[28]_i_4_n_0 }),
        .O({\freq_int_reg[28]_i_1_n_4 ,\freq_int_reg[28]_i_1_n_5 ,\freq_int_reg[28]_i_1_n_6 ,\freq_int_reg[28]_i_1_n_7 }),
        .S({\freq_int[28]_i_5_n_0 ,\freq_int[28]_i_6_n_0 ,\freq_int[28]_i_7_n_0 ,\freq_int[28]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_int_reg[28]_i_9 
       (.CI(\freq_int_reg[24]_i_10_n_0 ),
        .CO(\NLW_freq_int_reg[28]_i_9_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_freq_int_reg[28]_i_9_O_UNCONNECTED [3:1],\freq_int_reg[28]_i_9_n_7 }),
        .S({1'b0,1'b0,1'b0,\freq_int[28]_i_10_n_0 }));
  FDCE \freq_int_reg[29] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[28]_i_1_n_6 ),
        .Q(freq_int_reg[29]));
  FDCE \freq_int_reg[30] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[28]_i_1_n_5 ),
        .Q(freq_int_reg[30]));
  FDCE \freq_int_reg[31] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[28]_i_1_n_4 ),
        .Q(freq_int_reg[31]));
  FDCE \freq_int_reg[4] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[4]_i_1_n_7 ),
        .Q(freq_int_reg[4]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \freq_int_reg[4]_i_1 
       (.CI(1'b0),
        .CO({\freq_int_reg[4]_i_1_n_0 ,\freq_int_reg[4]_i_1_n_1 ,\freq_int_reg[4]_i_1_n_2 ,\freq_int_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_int[4]_i_2_n_0 ,\freq_int[4]_i_3_n_0 ,\freq_int[4]_i_4_n_0 ,\freq_int[4]_i_5_n_0 }),
        .O({\freq_int_reg[4]_i_1_n_4 ,\freq_int_reg[4]_i_1_n_5 ,\freq_int_reg[4]_i_1_n_6 ,\freq_int_reg[4]_i_1_n_7 }),
        .S({\freq_int[4]_i_6_n_0 ,\freq_int[4]_i_7_n_0 ,\freq_int[4]_i_8_n_0 ,\freq_int[4]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_int_reg[4]_i_10 
       (.CI(\freq_int_reg[4]_i_11_n_0 ),
        .CO({\freq_int_reg[4]_i_10_n_0 ,\freq_int_reg[4]_i_10_n_1 ,\freq_int_reg[4]_i_10_n_2 ,\freq_int_reg[4]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_int_reg[4]_i_10_n_4 ,\freq_int_reg[4]_i_10_n_5 ,\freq_int_reg[4]_i_10_n_6 ,\freq_int_reg[4]_i_10_n_7 }),
        .S({\freq_int[4]_i_12_n_0 ,\freq_int[4]_i_13_n_0 ,\freq_int[4]_i_14_n_0 ,\freq_int[4]_i_15_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_int_reg[4]_i_11 
       (.CI(1'b0),
        .CO({\freq_int_reg[4]_i_11_n_0 ,\freq_int_reg[4]_i_11_n_1 ,\freq_int_reg[4]_i_11_n_2 ,\freq_int_reg[4]_i_11_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\freq_int[4]_i_16_n_0 ,1'b0}),
        .O({\freq_int_reg[4]_i_11_n_4 ,\freq_int_reg[4]_i_11_n_5 ,\freq_int_reg[4]_i_11_n_6 ,\NLW_freq_int_reg[4]_i_11_O_UNCONNECTED [0]}),
        .S({\freq_int[4]_i_17_n_0 ,\freq_int[4]_i_18_n_0 ,freq_int2_n_105,1'b0}));
  FDCE \freq_int_reg[5] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[4]_i_1_n_6 ),
        .Q(freq_int_reg[5]));
  FDCE \freq_int_reg[6] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[4]_i_1_n_5 ),
        .Q(freq_int_reg[6]));
  FDCE \freq_int_reg[7] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[4]_i_1_n_4 ),
        .Q(freq_int_reg[7]));
  FDCE \freq_int_reg[8] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[8]_i_1_n_7 ),
        .Q(freq_int_reg[8]));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \freq_int_reg[8]_i_1 
       (.CI(\freq_int_reg[4]_i_1_n_0 ),
        .CO({\freq_int_reg[8]_i_1_n_0 ,\freq_int_reg[8]_i_1_n_1 ,\freq_int_reg[8]_i_1_n_2 ,\freq_int_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_int[8]_i_2_n_0 ,\freq_int[8]_i_3_n_0 ,\freq_int[8]_i_4_n_0 ,\freq_int[8]_i_5_n_0 }),
        .O({\freq_int_reg[8]_i_1_n_4 ,\freq_int_reg[8]_i_1_n_5 ,\freq_int_reg[8]_i_1_n_6 ,\freq_int_reg[8]_i_1_n_7 }),
        .S({\freq_int[8]_i_6_n_0 ,\freq_int[8]_i_7_n_0 ,\freq_int[8]_i_8_n_0 ,\freq_int[8]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_int_reg[8]_i_10 
       (.CI(\freq_int_reg[4]_i_10_n_0 ),
        .CO({\freq_int_reg[8]_i_10_n_0 ,\freq_int_reg[8]_i_10_n_1 ,\freq_int_reg[8]_i_10_n_2 ,\freq_int_reg[8]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_int_reg[8]_i_10_n_4 ,\freq_int_reg[8]_i_10_n_5 ,\freq_int_reg[8]_i_10_n_6 ,\freq_int_reg[8]_i_10_n_7 }),
        .S({\freq_int[8]_i_11_n_0 ,\freq_int[8]_i_12_n_0 ,\freq_int[8]_i_13_n_0 ,\freq_int[8]_i_14_n_0 }));
  FDCE \freq_int_reg[9] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_int_reg[8]_i_1_n_6 ),
        .Q(freq_int_reg[9]));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-13 {cell *THIS*}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(0),
    .BREG(0),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    freq_word2
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,freq_word2_0}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_freq_word2_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({B[15],B[15],B}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_freq_word2_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_freq_word2_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_freq_word2_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CLK(1'b0),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_freq_word2_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_freq_word2_OVERFLOW_UNCONNECTED),
        .P({NLW_freq_word2_P_UNCONNECTED[47:33],freq_word2_n_73,freq_word2_n_74,freq_word2_n_75,freq_word2_n_76,freq_word2_n_77,freq_word2_n_78,freq_word2_n_79,freq_word2_n_80,freq_word2_n_81,freq_word2_n_82,freq_word2_n_83,freq_word2_n_84,freq_word2_n_85,freq_word2_n_86,freq_word2_n_87,freq_word2_n_88,freq_word2_n_89,freq_word2_n_90,freq_word2_n_91,freq_word2_n_92,freq_word2_n_93,freq_word2_n_94,freq_word2_n_95,freq_word2_n_96,freq_word2_n_97,freq_word2_n_98,freq_word2_n_99,freq_word2_n_100,freq_word2_n_101,freq_word2_n_102,freq_word2_n_103,freq_word2_n_104,freq_word2_n_105}),
        .PATTERNBDETECT(NLW_freq_word2_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_freq_word2_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_freq_word2_PCOUT_UNCONNECTED[47:0]),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_freq_word2_UNDERFLOW_UNCONNECTED));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[11]_i_11 
       (.I0(freq_word2_n_99),
        .O(\freq_word[11]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[11]_i_12 
       (.I0(freq_word2_n_100),
        .O(\freq_word[11]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[11]_i_13 
       (.I0(freq_word2_n_101),
        .O(\freq_word[11]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[11]_i_14 
       (.I0(freq_word2_n_102),
        .O(\freq_word[11]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[11]_i_2 
       (.I0(\freq_word_reg[15]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_word[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[11]_i_3 
       (.I0(\freq_word_reg[11]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_word[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[11]_i_4 
       (.I0(\freq_word_reg[11]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_word[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[11]_i_5 
       (.I0(\freq_word_reg[11]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_word[11]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[11]_i_6 
       (.I0(\freq_word_reg[15]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[11]),
        .O(\freq_word[11]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[11]_i_7 
       (.I0(\freq_word_reg[11]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[10]),
        .O(\freq_word[11]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[11]_i_8 
       (.I0(\freq_word_reg[11]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[9]),
        .O(\freq_word[11]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[11]_i_9 
       (.I0(\freq_word_reg[11]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[8]),
        .O(\freq_word[11]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[15]_i_11 
       (.I0(freq_word2_n_95),
        .O(\freq_word[15]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[15]_i_12 
       (.I0(freq_word2_n_96),
        .O(\freq_word[15]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[15]_i_13 
       (.I0(freq_word2_n_97),
        .O(\freq_word[15]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[15]_i_14 
       (.I0(freq_word2_n_98),
        .O(\freq_word[15]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[15]_i_2 
       (.I0(\freq_word_reg[19]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_word[15]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[15]_i_3 
       (.I0(\freq_word_reg[15]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_word[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[15]_i_4 
       (.I0(\freq_word_reg[15]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_word[15]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[15]_i_5 
       (.I0(\freq_word_reg[15]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_word[15]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[15]_i_6 
       (.I0(\freq_word_reg[19]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[15]),
        .O(\freq_word[15]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[15]_i_7 
       (.I0(\freq_word_reg[15]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[14]),
        .O(\freq_word[15]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[15]_i_8 
       (.I0(\freq_word_reg[15]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[13]),
        .O(\freq_word[15]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[15]_i_9 
       (.I0(\freq_word_reg[15]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[12]),
        .O(\freq_word[15]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[19]_i_11 
       (.I0(freq_word2_n_91),
        .O(\freq_word[19]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[19]_i_12 
       (.I0(freq_word2_n_92),
        .O(\freq_word[19]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[19]_i_13 
       (.I0(freq_word2_n_93),
        .O(\freq_word[19]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[19]_i_14 
       (.I0(freq_word2_n_94),
        .O(\freq_word[19]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[19]_i_2 
       (.I0(\freq_word_reg[23]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_word[19]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[19]_i_3 
       (.I0(\freq_word_reg[19]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_word[19]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[19]_i_4 
       (.I0(\freq_word_reg[19]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_word[19]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[19]_i_5 
       (.I0(\freq_word_reg[19]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_word[19]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[19]_i_6 
       (.I0(\freq_word_reg[23]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[19]),
        .O(\freq_word[19]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[19]_i_7 
       (.I0(\freq_word_reg[19]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[18]),
        .O(\freq_word[19]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[19]_i_8 
       (.I0(\freq_word_reg[19]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[17]),
        .O(\freq_word[19]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[19]_i_9 
       (.I0(\freq_word_reg[19]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[16]),
        .O(\freq_word[19]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[23]_i_11 
       (.I0(freq_word2_n_87),
        .O(\freq_word[23]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[23]_i_12 
       (.I0(freq_word2_n_88),
        .O(\freq_word[23]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[23]_i_13 
       (.I0(freq_word2_n_89),
        .O(\freq_word[23]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[23]_i_14 
       (.I0(freq_word2_n_90),
        .O(\freq_word[23]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[23]_i_2 
       (.I0(\freq_word_reg[27]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_word[23]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[23]_i_3 
       (.I0(\freq_word_reg[23]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_word[23]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[23]_i_4 
       (.I0(\freq_word_reg[23]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_word[23]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[23]_i_5 
       (.I0(\freq_word_reg[23]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_word[23]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[23]_i_6 
       (.I0(\freq_word_reg[27]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[23]),
        .O(\freq_word[23]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[23]_i_7 
       (.I0(\freq_word_reg[23]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[22]),
        .O(\freq_word[23]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[23]_i_8 
       (.I0(\freq_word_reg[23]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[21]),
        .O(\freq_word[23]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[23]_i_9 
       (.I0(\freq_word_reg[23]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[20]),
        .O(\freq_word[23]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[27]_i_11 
       (.I0(freq_word2_n_83),
        .O(\freq_word[27]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[27]_i_12 
       (.I0(freq_word2_n_84),
        .O(\freq_word[27]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[27]_i_13 
       (.I0(freq_word2_n_85),
        .O(\freq_word[27]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[27]_i_14 
       (.I0(freq_word2_n_86),
        .O(\freq_word[27]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[27]_i_2 
       (.I0(\freq_word_reg[31]_i_9_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_word[27]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[27]_i_3 
       (.I0(\freq_word_reg[27]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_word[27]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[27]_i_4 
       (.I0(\freq_word_reg[27]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_word[27]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[27]_i_5 
       (.I0(\freq_word_reg[27]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_word[27]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[27]_i_6 
       (.I0(\freq_word_reg[31]_i_9_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[27]),
        .O(\freq_word[27]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[27]_i_7 
       (.I0(\freq_word_reg[27]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[26]),
        .O(\freq_word[27]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[27]_i_8 
       (.I0(\freq_word_reg[27]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[25]),
        .O(\freq_word[27]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[27]_i_9 
       (.I0(\freq_word_reg[27]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[24]),
        .O(\freq_word[27]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[31]_i_11 
       (.I0(freq_word2_n_79),
        .O(\freq_word[31]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[31]_i_12 
       (.I0(freq_word2_n_80),
        .O(\freq_word[31]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[31]_i_13 
       (.I0(freq_word2_n_81),
        .O(\freq_word[31]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[31]_i_14 
       (.I0(freq_word2_n_82),
        .O(\freq_word[31]_i_14_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[31]_i_15 
       (.I0(freq_word2_n_78),
        .O(\freq_word[31]_i_15_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[31]_i_2 
       (.I0(\freq_word_reg[31]_i_9_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_word[31]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[31]_i_3 
       (.I0(\freq_word_reg[31]_i_9_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_word[31]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[31]_i_4 
       (.I0(\freq_word_reg[31]_i_9_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_word[31]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[31]_i_5 
       (.I0(\freq_word_reg[31]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[31]),
        .O(\freq_word[31]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[31]_i_6 
       (.I0(\freq_word_reg[31]_i_9_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[30]),
        .O(\freq_word[31]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[31]_i_7 
       (.I0(\freq_word_reg[31]_i_9_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[29]),
        .O(\freq_word[31]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[31]_i_8 
       (.I0(\freq_word_reg[31]_i_9_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[28]),
        .O(\freq_word[31]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[7]_i_11 
       (.I0(freq_word2_n_105),
        .O(\freq_word[7]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[7]_i_12 
       (.I0(freq_word2_n_103),
        .O(\freq_word[7]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \freq_word[7]_i_13 
       (.I0(freq_word2_n_104),
        .O(\freq_word[7]_i_13_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[7]_i_2 
       (.I0(\freq_word_reg[11]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\freq_word[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[7]_i_3 
       (.I0(\freq_word_reg[7]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\freq_word[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[7]_i_4 
       (.I0(\freq_word_reg[7]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\freq_word[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \freq_word[7]_i_5 
       (.I0(\freq_word_reg[7]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\freq_word[7]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[7]_i_6 
       (.I0(\freq_word_reg[11]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[7]),
        .O(\freq_word[7]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[7]_i_7 
       (.I0(\freq_word_reg[7]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[6]),
        .O(\freq_word[7]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[7]_i_8 
       (.I0(\freq_word_reg[7]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[5]),
        .O(\freq_word[7]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h12)) 
    \freq_word[7]_i_9 
       (.I0(\freq_word_reg[7]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .I2(freq_int_reg[4]),
        .O(\freq_word[7]_i_9_n_0 ));
  FDCE \freq_word_reg[10] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[11]_i_1_n_5 ),
        .Q(freq_word[10]));
  FDCE \freq_word_reg[11] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[11]_i_1_n_4 ),
        .Q(freq_word[11]));
  CARRY4 \freq_word_reg[11]_i_1 
       (.CI(\freq_word_reg[7]_i_1_n_0 ),
        .CO({\freq_word_reg[11]_i_1_n_0 ,\freq_word_reg[11]_i_1_n_1 ,\freq_word_reg[11]_i_1_n_2 ,\freq_word_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_word[11]_i_2_n_0 ,\freq_word[11]_i_3_n_0 ,\freq_word[11]_i_4_n_0 ,\freq_word[11]_i_5_n_0 }),
        .O({\freq_word_reg[11]_i_1_n_4 ,\freq_word_reg[11]_i_1_n_5 ,\freq_word_reg[11]_i_1_n_6 ,\freq_word_reg[11]_i_1_n_7 }),
        .S({\freq_word[11]_i_6_n_0 ,\freq_word[11]_i_7_n_0 ,\freq_word[11]_i_8_n_0 ,\freq_word[11]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_word_reg[11]_i_10 
       (.CI(\freq_word_reg[7]_i_10_n_0 ),
        .CO({\freq_word_reg[11]_i_10_n_0 ,\freq_word_reg[11]_i_10_n_1 ,\freq_word_reg[11]_i_10_n_2 ,\freq_word_reg[11]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_word_reg[11]_i_10_n_4 ,\freq_word_reg[11]_i_10_n_5 ,\freq_word_reg[11]_i_10_n_6 ,\freq_word_reg[11]_i_10_n_7 }),
        .S({\freq_word[11]_i_11_n_0 ,\freq_word[11]_i_12_n_0 ,\freq_word[11]_i_13_n_0 ,\freq_word[11]_i_14_n_0 }));
  FDCE \freq_word_reg[12] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[15]_i_1_n_7 ),
        .Q(freq_word[12]));
  FDCE \freq_word_reg[13] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[15]_i_1_n_6 ),
        .Q(freq_word[13]));
  FDCE \freq_word_reg[14] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[15]_i_1_n_5 ),
        .Q(freq_word[14]));
  FDCE \freq_word_reg[15] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[15]_i_1_n_4 ),
        .Q(freq_word[15]));
  CARRY4 \freq_word_reg[15]_i_1 
       (.CI(\freq_word_reg[11]_i_1_n_0 ),
        .CO({\freq_word_reg[15]_i_1_n_0 ,\freq_word_reg[15]_i_1_n_1 ,\freq_word_reg[15]_i_1_n_2 ,\freq_word_reg[15]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_word[15]_i_2_n_0 ,\freq_word[15]_i_3_n_0 ,\freq_word[15]_i_4_n_0 ,\freq_word[15]_i_5_n_0 }),
        .O({\freq_word_reg[15]_i_1_n_4 ,\freq_word_reg[15]_i_1_n_5 ,\freq_word_reg[15]_i_1_n_6 ,\freq_word_reg[15]_i_1_n_7 }),
        .S({\freq_word[15]_i_6_n_0 ,\freq_word[15]_i_7_n_0 ,\freq_word[15]_i_8_n_0 ,\freq_word[15]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_word_reg[15]_i_10 
       (.CI(\freq_word_reg[11]_i_10_n_0 ),
        .CO({\freq_word_reg[15]_i_10_n_0 ,\freq_word_reg[15]_i_10_n_1 ,\freq_word_reg[15]_i_10_n_2 ,\freq_word_reg[15]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_word_reg[15]_i_10_n_4 ,\freq_word_reg[15]_i_10_n_5 ,\freq_word_reg[15]_i_10_n_6 ,\freq_word_reg[15]_i_10_n_7 }),
        .S({\freq_word[15]_i_11_n_0 ,\freq_word[15]_i_12_n_0 ,\freq_word[15]_i_13_n_0 ,\freq_word[15]_i_14_n_0 }));
  FDCE \freq_word_reg[16] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[19]_i_1_n_7 ),
        .Q(freq_word[16]));
  FDCE \freq_word_reg[17] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[19]_i_1_n_6 ),
        .Q(freq_word[17]));
  FDCE \freq_word_reg[18] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[19]_i_1_n_5 ),
        .Q(freq_word[18]));
  FDCE \freq_word_reg[19] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[19]_i_1_n_4 ),
        .Q(freq_word[19]));
  CARRY4 \freq_word_reg[19]_i_1 
       (.CI(\freq_word_reg[15]_i_1_n_0 ),
        .CO({\freq_word_reg[19]_i_1_n_0 ,\freq_word_reg[19]_i_1_n_1 ,\freq_word_reg[19]_i_1_n_2 ,\freq_word_reg[19]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_word[19]_i_2_n_0 ,\freq_word[19]_i_3_n_0 ,\freq_word[19]_i_4_n_0 ,\freq_word[19]_i_5_n_0 }),
        .O({\freq_word_reg[19]_i_1_n_4 ,\freq_word_reg[19]_i_1_n_5 ,\freq_word_reg[19]_i_1_n_6 ,\freq_word_reg[19]_i_1_n_7 }),
        .S({\freq_word[19]_i_6_n_0 ,\freq_word[19]_i_7_n_0 ,\freq_word[19]_i_8_n_0 ,\freq_word[19]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_word_reg[19]_i_10 
       (.CI(\freq_word_reg[15]_i_10_n_0 ),
        .CO({\freq_word_reg[19]_i_10_n_0 ,\freq_word_reg[19]_i_10_n_1 ,\freq_word_reg[19]_i_10_n_2 ,\freq_word_reg[19]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_word_reg[19]_i_10_n_4 ,\freq_word_reg[19]_i_10_n_5 ,\freq_word_reg[19]_i_10_n_6 ,\freq_word_reg[19]_i_10_n_7 }),
        .S({\freq_word[19]_i_11_n_0 ,\freq_word[19]_i_12_n_0 ,\freq_word[19]_i_13_n_0 ,\freq_word[19]_i_14_n_0 }));
  FDCE \freq_word_reg[20] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[23]_i_1_n_7 ),
        .Q(freq_word[20]));
  FDCE \freq_word_reg[21] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[23]_i_1_n_6 ),
        .Q(freq_word[21]));
  FDCE \freq_word_reg[22] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[23]_i_1_n_5 ),
        .Q(freq_word[22]));
  FDCE \freq_word_reg[23] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[23]_i_1_n_4 ),
        .Q(freq_word[23]));
  CARRY4 \freq_word_reg[23]_i_1 
       (.CI(\freq_word_reg[19]_i_1_n_0 ),
        .CO({\freq_word_reg[23]_i_1_n_0 ,\freq_word_reg[23]_i_1_n_1 ,\freq_word_reg[23]_i_1_n_2 ,\freq_word_reg[23]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_word[23]_i_2_n_0 ,\freq_word[23]_i_3_n_0 ,\freq_word[23]_i_4_n_0 ,\freq_word[23]_i_5_n_0 }),
        .O({\freq_word_reg[23]_i_1_n_4 ,\freq_word_reg[23]_i_1_n_5 ,\freq_word_reg[23]_i_1_n_6 ,\freq_word_reg[23]_i_1_n_7 }),
        .S({\freq_word[23]_i_6_n_0 ,\freq_word[23]_i_7_n_0 ,\freq_word[23]_i_8_n_0 ,\freq_word[23]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_word_reg[23]_i_10 
       (.CI(\freq_word_reg[19]_i_10_n_0 ),
        .CO({\freq_word_reg[23]_i_10_n_0 ,\freq_word_reg[23]_i_10_n_1 ,\freq_word_reg[23]_i_10_n_2 ,\freq_word_reg[23]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_word_reg[23]_i_10_n_4 ,\freq_word_reg[23]_i_10_n_5 ,\freq_word_reg[23]_i_10_n_6 ,\freq_word_reg[23]_i_10_n_7 }),
        .S({\freq_word[23]_i_11_n_0 ,\freq_word[23]_i_12_n_0 ,\freq_word[23]_i_13_n_0 ,\freq_word[23]_i_14_n_0 }));
  FDCE \freq_word_reg[24] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[27]_i_1_n_7 ),
        .Q(freq_word[24]));
  FDCE \freq_word_reg[25] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[27]_i_1_n_6 ),
        .Q(freq_word[25]));
  FDCE \freq_word_reg[26] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[27]_i_1_n_5 ),
        .Q(freq_word[26]));
  FDCE \freq_word_reg[27] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[27]_i_1_n_4 ),
        .Q(freq_word[27]));
  CARRY4 \freq_word_reg[27]_i_1 
       (.CI(\freq_word_reg[23]_i_1_n_0 ),
        .CO({\freq_word_reg[27]_i_1_n_0 ,\freq_word_reg[27]_i_1_n_1 ,\freq_word_reg[27]_i_1_n_2 ,\freq_word_reg[27]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_word[27]_i_2_n_0 ,\freq_word[27]_i_3_n_0 ,\freq_word[27]_i_4_n_0 ,\freq_word[27]_i_5_n_0 }),
        .O({\freq_word_reg[27]_i_1_n_4 ,\freq_word_reg[27]_i_1_n_5 ,\freq_word_reg[27]_i_1_n_6 ,\freq_word_reg[27]_i_1_n_7 }),
        .S({\freq_word[27]_i_6_n_0 ,\freq_word[27]_i_7_n_0 ,\freq_word[27]_i_8_n_0 ,\freq_word[27]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_word_reg[27]_i_10 
       (.CI(\freq_word_reg[23]_i_10_n_0 ),
        .CO({\freq_word_reg[27]_i_10_n_0 ,\freq_word_reg[27]_i_10_n_1 ,\freq_word_reg[27]_i_10_n_2 ,\freq_word_reg[27]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_word_reg[27]_i_10_n_4 ,\freq_word_reg[27]_i_10_n_5 ,\freq_word_reg[27]_i_10_n_6 ,\freq_word_reg[27]_i_10_n_7 }),
        .S({\freq_word[27]_i_11_n_0 ,\freq_word[27]_i_12_n_0 ,\freq_word[27]_i_13_n_0 ,\freq_word[27]_i_14_n_0 }));
  FDCE \freq_word_reg[28] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[31]_i_1_n_7 ),
        .Q(freq_word[28]));
  FDCE \freq_word_reg[29] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[31]_i_1_n_6 ),
        .Q(freq_word[29]));
  FDCE \freq_word_reg[30] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[31]_i_1_n_5 ),
        .Q(freq_word[30]));
  FDCE \freq_word_reg[31] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[31]_i_1_n_4 ),
        .Q(freq_word[31]));
  CARRY4 \freq_word_reg[31]_i_1 
       (.CI(\freq_word_reg[27]_i_1_n_0 ),
        .CO({\NLW_freq_word_reg[31]_i_1_CO_UNCONNECTED [3],\freq_word_reg[31]_i_1_n_1 ,\freq_word_reg[31]_i_1_n_2 ,\freq_word_reg[31]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\freq_word[31]_i_2_n_0 ,\freq_word[31]_i_3_n_0 ,\freq_word[31]_i_4_n_0 }),
        .O({\freq_word_reg[31]_i_1_n_4 ,\freq_word_reg[31]_i_1_n_5 ,\freq_word_reg[31]_i_1_n_6 ,\freq_word_reg[31]_i_1_n_7 }),
        .S({\freq_word[31]_i_5_n_0 ,\freq_word[31]_i_6_n_0 ,\freq_word[31]_i_7_n_0 ,\freq_word[31]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_word_reg[31]_i_10 
       (.CI(\freq_word_reg[31]_i_9_n_0 ),
        .CO(\NLW_freq_word_reg[31]_i_10_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_freq_word_reg[31]_i_10_O_UNCONNECTED [3:1],\freq_word_reg[31]_i_10_n_7 }),
        .S({1'b0,1'b0,1'b0,\freq_word[31]_i_15_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_word_reg[31]_i_9 
       (.CI(\freq_word_reg[27]_i_10_n_0 ),
        .CO({\freq_word_reg[31]_i_9_n_0 ,\freq_word_reg[31]_i_9_n_1 ,\freq_word_reg[31]_i_9_n_2 ,\freq_word_reg[31]_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\freq_word_reg[31]_i_9_n_4 ,\freq_word_reg[31]_i_9_n_5 ,\freq_word_reg[31]_i_9_n_6 ,\freq_word_reg[31]_i_9_n_7 }),
        .S({\freq_word[31]_i_11_n_0 ,\freq_word[31]_i_12_n_0 ,\freq_word[31]_i_13_n_0 ,\freq_word[31]_i_14_n_0 }));
  FDCE \freq_word_reg[4] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[7]_i_1_n_7 ),
        .Q(freq_word[4]));
  FDCE \freq_word_reg[5] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[7]_i_1_n_6 ),
        .Q(freq_word[5]));
  FDCE \freq_word_reg[6] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[7]_i_1_n_5 ),
        .Q(freq_word[6]));
  FDCE \freq_word_reg[7] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[7]_i_1_n_4 ),
        .Q(freq_word[7]));
  CARRY4 \freq_word_reg[7]_i_1 
       (.CI(1'b0),
        .CO({\freq_word_reg[7]_i_1_n_0 ,\freq_word_reg[7]_i_1_n_1 ,\freq_word_reg[7]_i_1_n_2 ,\freq_word_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\freq_word[7]_i_2_n_0 ,\freq_word[7]_i_3_n_0 ,\freq_word[7]_i_4_n_0 ,\freq_word[7]_i_5_n_0 }),
        .O({\freq_word_reg[7]_i_1_n_4 ,\freq_word_reg[7]_i_1_n_5 ,\freq_word_reg[7]_i_1_n_6 ,\freq_word_reg[7]_i_1_n_7 }),
        .S({\freq_word[7]_i_6_n_0 ,\freq_word[7]_i_7_n_0 ,\freq_word[7]_i_8_n_0 ,\freq_word[7]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \freq_word_reg[7]_i_10 
       (.CI(1'b0),
        .CO({\freq_word_reg[7]_i_10_n_0 ,\freq_word_reg[7]_i_10_n_1 ,\freq_word_reg[7]_i_10_n_2 ,\freq_word_reg[7]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\freq_word[7]_i_11_n_0 ,1'b0}),
        .O({\freq_word_reg[7]_i_10_n_4 ,\freq_word_reg[7]_i_10_n_5 ,\freq_word_reg[7]_i_10_n_6 ,\NLW_freq_word_reg[7]_i_10_O_UNCONNECTED [0]}),
        .S({\freq_word[7]_i_12_n_0 ,\freq_word[7]_i_13_n_0 ,freq_word2_n_105,1'b0}));
  FDCE \freq_word_reg[8] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[11]_i_1_n_7 ),
        .Q(freq_word[8]));
  FDCE \freq_word_reg[9] 
       (.C(aclk),
        .CE(adc_valid_d1),
        .CLR(aresetn_0),
        .D(\freq_word_reg[11]_i_1_n_6 ),
        .Q(freq_word[9]));
  LUT2 #(
    .INIT(4'hE)) 
    i__carry__0_i_1
       (.I0(\frac_timing_reg_n_0_[13] ),
        .I1(\frac_timing_reg_n_0_[12] ),
        .O(i__carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_1__0
       (.I0(\frac_timing_reg_n_0_[7] ),
        .I1(timing_adj[7]),
        .O(i__carry__0_i_1__0_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    i__carry__0_i_2
       (.I0(\frac_timing_reg_n_0_[11] ),
        .I1(\frac_timing_reg_n_0_[10] ),
        .O(i__carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_2__0
       (.I0(\frac_timing_reg_n_0_[6] ),
        .I1(timing_adj[6]),
        .O(i__carry__0_i_2__0_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    i__carry__0_i_3
       (.I0(\frac_timing_reg_n_0_[9] ),
        .I1(\frac_timing_reg_n_0_[8] ),
        .O(i__carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_3__0
       (.I0(\frac_timing_reg_n_0_[5] ),
        .I1(timing_adj[5]),
        .O(i__carry__0_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__0_i_4
       (.I0(\frac_timing_reg_n_0_[14] ),
        .I1(\frac_timing_reg_n_0_[15] ),
        .O(i__carry__0_i_4_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_4__0
       (.I0(\frac_timing_reg_n_0_[4] ),
        .I1(timing_adj[4]),
        .O(i__carry__0_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    i__carry__0_i_5
       (.I0(\frac_timing_reg_n_0_[12] ),
        .I1(\frac_timing_reg_n_0_[13] ),
        .O(i__carry__0_i_5_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    i__carry__0_i_6
       (.I0(\frac_timing_reg_n_0_[10] ),
        .I1(\frac_timing_reg_n_0_[11] ),
        .O(i__carry__0_i_6_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    i__carry__0_i_7
       (.I0(\frac_timing_reg_n_0_[8] ),
        .I1(\frac_timing_reg_n_0_[9] ),
        .O(i__carry__0_i_7_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__1_i_1
       (.I0(\frac_timing_reg_n_0_[11] ),
        .I1(timing_adj[11]),
        .O(i__carry__1_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__1_i_2
       (.I0(\frac_timing_reg_n_0_[10] ),
        .I1(timing_adj[10]),
        .O(i__carry__1_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__1_i_3
       (.I0(\frac_timing_reg_n_0_[9] ),
        .I1(timing_adj[9]),
        .O(i__carry__1_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__1_i_4
       (.I0(\frac_timing_reg_n_0_[8] ),
        .I1(timing_adj[8]),
        .O(i__carry__1_i_4_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_1
       (.I0(\frac_timing_reg_n_0_[15] ),
        .I1(timing_adj[15]),
        .O(i__carry__2_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__2_i_2
       (.I0(\frac_timing_reg_n_0_[14] ),
        .I1(timing_adj[14]),
        .O(i__carry__2_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__2_i_3
       (.I0(\frac_timing_reg_n_0_[13] ),
        .I1(timing_adj[13]),
        .O(i__carry__2_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__2_i_4
       (.I0(\frac_timing_reg_n_0_[12] ),
        .I1(timing_adj[12]),
        .O(i__carry__2_i_4_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    i__carry_i_1
       (.I0(\frac_timing_reg_n_0_[7] ),
        .I1(\frac_timing_reg_n_0_[6] ),
        .O(i__carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_1__0
       (.I0(\frac_timing_reg_n_0_[3] ),
        .I1(timing_adj[3]),
        .O(i__carry_i_1__0_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    i__carry_i_2
       (.I0(\frac_timing_reg_n_0_[5] ),
        .I1(\frac_timing_reg_n_0_[4] ),
        .O(i__carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_2__0
       (.I0(\frac_timing_reg_n_0_[2] ),
        .I1(timing_adj[2]),
        .O(i__carry_i_2__0_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    i__carry_i_3
       (.I0(\frac_timing_reg_n_0_[3] ),
        .I1(\frac_timing_reg_n_0_[2] ),
        .O(i__carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_3__0
       (.I0(\frac_timing_reg_n_0_[1] ),
        .I1(timing_adj[1]),
        .O(i__carry_i_3__0_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    i__carry_i_4
       (.I0(\frac_timing_reg_n_0_[1] ),
        .I1(\frac_timing_reg_n_0_[0] ),
        .O(i__carry_i_4_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_4__0
       (.I0(\frac_timing_reg_n_0_[0] ),
        .I1(timing_adj[0]),
        .O(i__carry_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    i__carry_i_5
       (.I0(\frac_timing_reg_n_0_[6] ),
        .I1(\frac_timing_reg_n_0_[7] ),
        .O(i__carry_i_5_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    i__carry_i_6
       (.I0(\frac_timing_reg_n_0_[4] ),
        .I1(\frac_timing_reg_n_0_[5] ),
        .O(i__carry_i_6_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    i__carry_i_7
       (.I0(\frac_timing_reg_n_0_[2] ),
        .I1(\frac_timing_reg_n_0_[3] ),
        .O(i__carry_i_7_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    i__carry_i_8
       (.I0(\frac_timing_reg_n_0_[0] ),
        .I1(\frac_timing_reg_n_0_[1] ),
        .O(i__carry_i_8_n_0));
  LUT3 #(
    .INIT(8'h80)) 
    \i_dump_prev[14]_i_1 
       (.I0(adc_valid_d1),
        .I1(core_enable),
        .I2(dump_strobe0),
        .O(\i_dump_prev[14]_i_1_n_0 ));
  FDCE \i_dump_prev_reg[0] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[6] ),
        .Q(i_dump_prev[0]));
  FDCE \i_dump_prev_reg[10] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[16] ),
        .Q(i_dump_prev[10]));
  FDCE \i_dump_prev_reg[11] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[17] ),
        .Q(i_dump_prev[11]));
  FDCE \i_dump_prev_reg[12] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[18] ),
        .Q(i_dump_prev[12]));
  FDCE \i_dump_prev_reg[13] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[19] ),
        .Q(i_dump_prev[13]));
  FDCE \i_dump_prev_reg[14] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[20] ),
        .Q(i_dump_prev[14]));
  FDCE \i_dump_prev_reg[1] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[7] ),
        .Q(i_dump_prev[1]));
  FDCE \i_dump_prev_reg[2] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[8] ),
        .Q(i_dump_prev[2]));
  FDCE \i_dump_prev_reg[3] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[9] ),
        .Q(i_dump_prev[3]));
  FDCE \i_dump_prev_reg[4] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[10] ),
        .Q(i_dump_prev[4]));
  FDCE \i_dump_prev_reg[5] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[11] ),
        .Q(i_dump_prev[5]));
  FDCE \i_dump_prev_reg[6] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[12] ),
        .Q(i_dump_prev[6]));
  FDCE \i_dump_prev_reg[7] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[13] ),
        .Q(i_dump_prev[7]));
  FDCE \i_dump_prev_reg[8] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[14] ),
        .Q(i_dump_prev[8]));
  FDCE \i_dump_prev_reg[9] 
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg_n_0_[15] ),
        .Q(i_dump_prev[9]));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[11]_i_2 
       (.I0(B_0[11]),
        .I1(core_bypass_costas),
        .O(\i_mix[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[11]_i_3 
       (.I0(B_0[10]),
        .I1(core_bypass_costas),
        .O(\i_mix[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[11]_i_4 
       (.I0(B_0[9]),
        .I1(core_bypass_costas),
        .O(\i_mix[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[11]_i_5 
       (.I0(B_0[8]),
        .I1(core_bypass_costas),
        .O(\i_mix[11]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[15]_i_2 
       (.I0(B_0[14]),
        .I1(core_bypass_costas),
        .O(\i_mix[15]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[15]_i_3 
       (.I0(B_0[13]),
        .I1(core_bypass_costas),
        .O(\i_mix[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[15]_i_4 
       (.I0(B_0[12]),
        .I1(core_bypass_costas),
        .O(\i_mix[15]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[3]_i_2 
       (.I0(B_0[3]),
        .I1(core_bypass_costas),
        .O(\i_mix[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[3]_i_3 
       (.I0(B_0[2]),
        .I1(core_bypass_costas),
        .O(\i_mix[3]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[3]_i_4 
       (.I0(B_0[1]),
        .I1(core_bypass_costas),
        .O(\i_mix[3]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[3]_i_5 
       (.I0(B_0[0]),
        .I1(core_bypass_costas),
        .O(\i_mix[3]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[7]_i_2 
       (.I0(B_0[7]),
        .I1(core_bypass_costas),
        .O(\i_mix[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[7]_i_3 
       (.I0(B_0[6]),
        .I1(core_bypass_costas),
        .O(\i_mix[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[7]_i_4 
       (.I0(B_0[5]),
        .I1(core_bypass_costas),
        .O(\i_mix[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \i_mix[7]_i_5 
       (.I0(B_0[4]),
        .I1(core_bypass_costas),
        .O(\i_mix[7]_i_5_n_0 ));
  FDCE \i_mix_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_82),
        .Q(i_mix[0]));
  FDCE \i_mix_reg[10] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_72),
        .Q(i_mix[10]));
  FDCE \i_mix_reg[11] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_71),
        .Q(i_mix[11]));
  FDCE \i_mix_reg[12] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_70),
        .Q(i_mix[12]));
  FDCE \i_mix_reg[13] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_69),
        .Q(i_mix[13]));
  FDCE \i_mix_reg[14] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_68),
        .Q(i_mix[14]));
  FDCE \i_mix_reg[15] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_67),
        .Q(i_mix[15]));
  FDCE \i_mix_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_81),
        .Q(i_mix[1]));
  FDCE \i_mix_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_80),
        .Q(i_mix[2]));
  FDCE \i_mix_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_79),
        .Q(i_mix[3]));
  FDCE \i_mix_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_78),
        .Q(i_mix[4]));
  FDCE \i_mix_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_77),
        .Q(i_mix[5]));
  FDCE \i_mix_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_76),
        .Q(i_mix[6]));
  FDCE \i_mix_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_75),
        .Q(i_mix[7]));
  FDCE \i_mix_reg[8] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_74),
        .Q(i_mix[8]));
  FDCE \i_mix_reg[9] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_73),
        .Q(i_mix[9]));
  FDCE i_prev_sign_reg
       (.C(aclk),
        .CE(\i_dump_prev[14]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(p_1_in0),
        .Q(i_prev_sign));
  LUT2 #(
    .INIT(4'h8)) 
    \integrate_acc[0]_i_1 
       (.I0(core_enable),
        .I1(adc_valid_d1),
        .O(sps_eff1));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[0]_i_3 
       (.I0(i_mix[3]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[3] ),
        .O(\integrate_acc[0]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[0]_i_4 
       (.I0(i_mix[2]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[2] ),
        .O(\integrate_acc[0]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[0]_i_5 
       (.I0(i_mix[1]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[1] ),
        .O(\integrate_acc[0]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[0]_i_6 
       (.I0(i_mix[0]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[0] ),
        .O(\integrate_acc[0]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[12]_i_2 
       (.I0(i_mix[15]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[15] ),
        .O(\integrate_acc[12]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[12]_i_3 
       (.I0(i_mix[14]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[14] ),
        .O(\integrate_acc[12]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[12]_i_4 
       (.I0(i_mix[13]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[13] ),
        .O(\integrate_acc[12]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[12]_i_5 
       (.I0(i_mix[12]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[12] ),
        .O(\integrate_acc[12]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[16]_i_2 
       (.I0(i_mix[15]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[19] ),
        .O(\integrate_acc[16]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[16]_i_3 
       (.I0(i_mix[15]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[18] ),
        .O(\integrate_acc[16]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[16]_i_4 
       (.I0(i_mix[15]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[17] ),
        .O(\integrate_acc[16]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[16]_i_5 
       (.I0(i_mix[15]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[16] ),
        .O(\integrate_acc[16]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[20]_i_2 
       (.I0(i_mix[15]),
        .I1(dump_strobe0),
        .I2(p_1_in0),
        .O(\integrate_acc[20]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[20]_i_3 
       (.I0(i_mix[15]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[20] ),
        .O(\integrate_acc[20]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[4]_i_2 
       (.I0(i_mix[7]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[7] ),
        .O(\integrate_acc[4]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[4]_i_3 
       (.I0(i_mix[6]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[6] ),
        .O(\integrate_acc[4]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[4]_i_4 
       (.I0(i_mix[5]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[5] ),
        .O(\integrate_acc[4]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[4]_i_5 
       (.I0(i_mix[4]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[4] ),
        .O(\integrate_acc[4]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[8]_i_2 
       (.I0(i_mix[11]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[11] ),
        .O(\integrate_acc[8]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[8]_i_3 
       (.I0(i_mix[10]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[10] ),
        .O(\integrate_acc[8]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[8]_i_4 
       (.I0(i_mix[9]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[9] ),
        .O(\integrate_acc[8]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h9A)) 
    \integrate_acc[8]_i_5 
       (.I0(i_mix[8]),
        .I1(dump_strobe0),
        .I2(\integrate_acc_reg_n_0_[8] ),
        .O(\integrate_acc[8]_i_5_n_0 ));
  FDCE \integrate_acc_reg[0] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[0]_i_2_n_7 ),
        .Q(\integrate_acc_reg_n_0_[0] ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \integrate_acc_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\integrate_acc_reg[0]_i_2_n_0 ,\integrate_acc_reg[0]_i_2_n_1 ,\integrate_acc_reg[0]_i_2_n_2 ,\integrate_acc_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(i_mix[3:0]),
        .O({\integrate_acc_reg[0]_i_2_n_4 ,\integrate_acc_reg[0]_i_2_n_5 ,\integrate_acc_reg[0]_i_2_n_6 ,\integrate_acc_reg[0]_i_2_n_7 }),
        .S({\integrate_acc[0]_i_3_n_0 ,\integrate_acc[0]_i_4_n_0 ,\integrate_acc[0]_i_5_n_0 ,\integrate_acc[0]_i_6_n_0 }));
  FDCE \integrate_acc_reg[10] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[8]_i_1_n_5 ),
        .Q(\integrate_acc_reg_n_0_[10] ));
  FDCE \integrate_acc_reg[11] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[8]_i_1_n_4 ),
        .Q(\integrate_acc_reg_n_0_[11] ));
  FDCE \integrate_acc_reg[12] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[12]_i_1_n_7 ),
        .Q(\integrate_acc_reg_n_0_[12] ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \integrate_acc_reg[12]_i_1 
       (.CI(\integrate_acc_reg[8]_i_1_n_0 ),
        .CO({\integrate_acc_reg[12]_i_1_n_0 ,\integrate_acc_reg[12]_i_1_n_1 ,\integrate_acc_reg[12]_i_1_n_2 ,\integrate_acc_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(i_mix[15:12]),
        .O({\integrate_acc_reg[12]_i_1_n_4 ,\integrate_acc_reg[12]_i_1_n_5 ,\integrate_acc_reg[12]_i_1_n_6 ,\integrate_acc_reg[12]_i_1_n_7 }),
        .S({\integrate_acc[12]_i_2_n_0 ,\integrate_acc[12]_i_3_n_0 ,\integrate_acc[12]_i_4_n_0 ,\integrate_acc[12]_i_5_n_0 }));
  FDCE \integrate_acc_reg[13] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[12]_i_1_n_6 ),
        .Q(\integrate_acc_reg_n_0_[13] ));
  FDCE \integrate_acc_reg[14] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[12]_i_1_n_5 ),
        .Q(\integrate_acc_reg_n_0_[14] ));
  FDCE \integrate_acc_reg[15] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[12]_i_1_n_4 ),
        .Q(\integrate_acc_reg_n_0_[15] ));
  FDCE \integrate_acc_reg[16] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[16]_i_1_n_7 ),
        .Q(\integrate_acc_reg_n_0_[16] ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \integrate_acc_reg[16]_i_1 
       (.CI(\integrate_acc_reg[12]_i_1_n_0 ),
        .CO({\integrate_acc_reg[16]_i_1_n_0 ,\integrate_acc_reg[16]_i_1_n_1 ,\integrate_acc_reg[16]_i_1_n_2 ,\integrate_acc_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({i_mix[15],i_mix[15],i_mix[15],i_mix[15]}),
        .O({\integrate_acc_reg[16]_i_1_n_4 ,\integrate_acc_reg[16]_i_1_n_5 ,\integrate_acc_reg[16]_i_1_n_6 ,\integrate_acc_reg[16]_i_1_n_7 }),
        .S({\integrate_acc[16]_i_2_n_0 ,\integrate_acc[16]_i_3_n_0 ,\integrate_acc[16]_i_4_n_0 ,\integrate_acc[16]_i_5_n_0 }));
  FDCE \integrate_acc_reg[17] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[16]_i_1_n_6 ),
        .Q(\integrate_acc_reg_n_0_[17] ));
  FDCE \integrate_acc_reg[18] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[16]_i_1_n_5 ),
        .Q(\integrate_acc_reg_n_0_[18] ));
  FDCE \integrate_acc_reg[19] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[16]_i_1_n_4 ),
        .Q(\integrate_acc_reg_n_0_[19] ));
  FDCE \integrate_acc_reg[1] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[0]_i_2_n_6 ),
        .Q(\integrate_acc_reg_n_0_[1] ));
  FDCE \integrate_acc_reg[20] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[20]_i_1_n_7 ),
        .Q(\integrate_acc_reg_n_0_[20] ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \integrate_acc_reg[20]_i_1 
       (.CI(\integrate_acc_reg[16]_i_1_n_0 ),
        .CO({\NLW_integrate_acc_reg[20]_i_1_CO_UNCONNECTED [3:1],\integrate_acc_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,i_mix[15]}),
        .O({\NLW_integrate_acc_reg[20]_i_1_O_UNCONNECTED [3:2],\integrate_acc_reg[20]_i_1_n_6 ,\integrate_acc_reg[20]_i_1_n_7 }),
        .S({1'b0,1'b0,\integrate_acc[20]_i_2_n_0 ,\integrate_acc[20]_i_3_n_0 }));
  FDCE \integrate_acc_reg[21] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[20]_i_1_n_6 ),
        .Q(p_1_in0));
  FDCE \integrate_acc_reg[2] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[0]_i_2_n_5 ),
        .Q(\integrate_acc_reg_n_0_[2] ));
  FDCE \integrate_acc_reg[3] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[0]_i_2_n_4 ),
        .Q(\integrate_acc_reg_n_0_[3] ));
  FDCE \integrate_acc_reg[4] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[4]_i_1_n_7 ),
        .Q(\integrate_acc_reg_n_0_[4] ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \integrate_acc_reg[4]_i_1 
       (.CI(\integrate_acc_reg[0]_i_2_n_0 ),
        .CO({\integrate_acc_reg[4]_i_1_n_0 ,\integrate_acc_reg[4]_i_1_n_1 ,\integrate_acc_reg[4]_i_1_n_2 ,\integrate_acc_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(i_mix[7:4]),
        .O({\integrate_acc_reg[4]_i_1_n_4 ,\integrate_acc_reg[4]_i_1_n_5 ,\integrate_acc_reg[4]_i_1_n_6 ,\integrate_acc_reg[4]_i_1_n_7 }),
        .S({\integrate_acc[4]_i_2_n_0 ,\integrate_acc[4]_i_3_n_0 ,\integrate_acc[4]_i_4_n_0 ,\integrate_acc[4]_i_5_n_0 }));
  FDCE \integrate_acc_reg[5] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[4]_i_1_n_6 ),
        .Q(\integrate_acc_reg_n_0_[5] ));
  FDCE \integrate_acc_reg[6] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[4]_i_1_n_5 ),
        .Q(\integrate_acc_reg_n_0_[6] ));
  FDCE \integrate_acc_reg[7] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[4]_i_1_n_4 ),
        .Q(\integrate_acc_reg_n_0_[7] ));
  FDCE \integrate_acc_reg[8] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[8]_i_1_n_7 ),
        .Q(\integrate_acc_reg_n_0_[8] ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \integrate_acc_reg[8]_i_1 
       (.CI(\integrate_acc_reg[4]_i_1_n_0 ),
        .CO({\integrate_acc_reg[8]_i_1_n_0 ,\integrate_acc_reg[8]_i_1_n_1 ,\integrate_acc_reg[8]_i_1_n_2 ,\integrate_acc_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(i_mix[11:8]),
        .O({\integrate_acc_reg[8]_i_1_n_4 ,\integrate_acc_reg[8]_i_1_n_5 ,\integrate_acc_reg[8]_i_1_n_6 ,\integrate_acc_reg[8]_i_1_n_7 }),
        .S({\integrate_acc[8]_i_2_n_0 ,\integrate_acc[8]_i_3_n_0 ,\integrate_acc[8]_i_4_n_0 ,\integrate_acc[8]_i_5_n_0 }));
  FDCE \integrate_acc_reg[9] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\integrate_acc_reg[8]_i_1_n_6 ),
        .Q(\integrate_acc_reg_n_0_[9] ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \lock_cnt[0]_i_1 
       (.I0(err_small),
        .I1(lock_cnt_reg[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'h28)) 
    \lock_cnt[1]_i_1 
       (.I0(err_small),
        .I1(lock_cnt_reg[1]),
        .I2(lock_cnt_reg[0]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'h2A80)) 
    \lock_cnt[2]_i_1 
       (.I0(err_small),
        .I1(lock_cnt_reg[0]),
        .I2(lock_cnt_reg[1]),
        .I3(lock_cnt_reg[2]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT5 #(
    .INIT(32'h2AAA8000)) 
    \lock_cnt[3]_i_1 
       (.I0(err_small),
        .I1(lock_cnt_reg[1]),
        .I2(lock_cnt_reg[0]),
        .I3(lock_cnt_reg[2]),
        .I4(lock_cnt_reg[3]),
        .O(p_0_in__0[3]));
  LUT6 #(
    .INIT(64'h2AAAAAAA80000000)) 
    \lock_cnt[4]_i_1 
       (.I0(err_small),
        .I1(lock_cnt_reg[2]),
        .I2(lock_cnt_reg[0]),
        .I3(lock_cnt_reg[1]),
        .I4(lock_cnt_reg[3]),
        .I5(lock_cnt_reg[4]),
        .O(p_0_in__0[4]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'h82)) 
    \lock_cnt[5]_i_1 
       (.I0(err_small),
        .I1(\lock_cnt[5]_i_2_n_0 ),
        .I2(lock_cnt_reg[5]),
        .O(p_0_in__0[5]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \lock_cnt[5]_i_2 
       (.I0(lock_cnt_reg[3]),
        .I1(lock_cnt_reg[1]),
        .I2(lock_cnt_reg[0]),
        .I3(lock_cnt_reg[2]),
        .I4(lock_cnt_reg[4]),
        .O(\lock_cnt[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h04444444)) 
    \lock_cnt[6]_i_1 
       (.I0(core_bypass_costas),
        .I1(adc_valid_d1),
        .I2(lock_cnt_reg[6]),
        .I3(\lock_cnt[6]_i_3_n_0 ),
        .I4(err_small),
        .O(\lock_cnt[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'h28)) 
    \lock_cnt[6]_i_2 
       (.I0(err_small),
        .I1(\lock_cnt[6]_i_3_n_0 ),
        .I2(lock_cnt_reg[6]),
        .O(p_0_in__0[6]));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \lock_cnt[6]_i_3 
       (.I0(lock_cnt_reg[5]),
        .I1(lock_cnt_reg[4]),
        .I2(lock_cnt_reg[2]),
        .I3(lock_cnt_reg[0]),
        .I4(lock_cnt_reg[1]),
        .I5(lock_cnt_reg[3]),
        .O(\lock_cnt[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \lock_cnt[6]_i_4 
       (.I0(B[15]),
        .I1(B[10]),
        .I2(B[13]),
        .I3(B[9]),
        .I4(\lock_cnt[6]_i_5_n_0 ),
        .I5(\lock_cnt[6]_i_6_n_0 ),
        .O(err_small));
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    \lock_cnt[6]_i_5 
       (.I0(q_mix[11]),
        .I1(phase_err_p0[11]),
        .I2(q_mix[14]),
        .I3(i_mix[15]),
        .I4(phase_err_p0[14]),
        .O(\lock_cnt[6]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    \lock_cnt[6]_i_6 
       (.I0(q_mix[8]),
        .I1(phase_err_p0[8]),
        .I2(q_mix[12]),
        .I3(i_mix[15]),
        .I4(phase_err_p0[12]),
        .O(\lock_cnt[6]_i_6_n_0 ));
  FDCE \lock_cnt_reg[0] 
       (.C(aclk),
        .CE(\lock_cnt[6]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(p_0_in__0[0]),
        .Q(lock_cnt_reg[0]));
  FDCE \lock_cnt_reg[1] 
       (.C(aclk),
        .CE(\lock_cnt[6]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(p_0_in__0[1]),
        .Q(lock_cnt_reg[1]));
  FDCE \lock_cnt_reg[2] 
       (.C(aclk),
        .CE(\lock_cnt[6]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(p_0_in__0[2]),
        .Q(lock_cnt_reg[2]));
  FDCE \lock_cnt_reg[3] 
       (.C(aclk),
        .CE(\lock_cnt[6]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(p_0_in__0[3]),
        .Q(lock_cnt_reg[3]));
  FDCE \lock_cnt_reg[4] 
       (.C(aclk),
        .CE(\lock_cnt[6]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(p_0_in__0[4]),
        .Q(lock_cnt_reg[4]));
  FDCE \lock_cnt_reg[5] 
       (.C(aclk),
        .CE(\lock_cnt[6]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(p_0_in__0[5]),
        .Q(lock_cnt_reg[5]));
  FDCE \lock_cnt_reg[6] 
       (.C(aclk),
        .CE(\lock_cnt[6]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(p_0_in__0[6]),
        .Q(lock_cnt_reg[6]));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-13 {cell *THIS*}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(0),
    .BREG(0),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    mix_ii
       (.A({i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_mix_ii_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({out[15],out[15],out}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_mix_ii_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_mix_ii_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_mix_ii_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CLK(1'b0),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_mix_ii_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_mix_ii_OVERFLOW_UNCONNECTED),
        .P({NLW_mix_ii_P_UNCONNECTED[47:32],mix_ii_n_74,A,mix_ii_n_91,mix_ii_n_92,mix_ii_n_93,mix_ii_n_94,mix_ii_n_95,mix_ii_n_96,mix_ii_n_97,mix_ii_n_98,mix_ii_n_99,mix_ii_n_100,mix_ii_n_101,mix_ii_n_102,mix_ii_n_103,mix_ii_n_104,mix_ii_n_105}),
        .PATTERNBDETECT(NLW_mix_ii_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_mix_ii_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_mix_ii_PCOUT_UNCONNECTED[47:0]),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_mix_ii_UNDERFLOW_UNCONNECTED));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-13 {cell *THIS*}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(0),
    .BREG(0),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    mix_iq
       (.A({q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_mix_iq_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({u_nco_n_18,u_nco_n_18,u_nco_n_18,u_nco_n_19,u_nco_n_20,u_nco_n_21,u_nco_n_22,u_nco_n_23,u_nco_n_24,u_nco_n_25,u_nco_n_26,u_nco_n_27,u_nco_n_28,u_nco_n_29,u_nco_n_30,u_nco_n_31,u_nco_n_32,u_nco_n_33}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_mix_iq_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_mix_iq_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_mix_iq_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CLK(1'b0),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_mix_iq_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_mix_iq_OVERFLOW_UNCONNECTED),
        .P({NLW_mix_iq_P_UNCONNECTED[47:32],mix_iq_n_74,B_0,mix_iq_n_91,mix_iq_n_92,mix_iq_n_93,mix_iq_n_94,mix_iq_n_95,mix_iq_n_96,mix_iq_n_97,mix_iq_n_98,mix_iq_n_99,mix_iq_n_100,mix_iq_n_101,mix_iq_n_102,mix_iq_n_103,mix_iq_n_104,mix_iq_n_105}),
        .PATTERNBDETECT(NLW_mix_iq_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_mix_iq_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_mix_iq_PCOUT_UNCONNECTED[47:0]),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_mix_iq_UNDERFLOW_UNCONNECTED));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-13 {cell *THIS*}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(0),
    .BREG(0),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    mix_qi
       (.A({i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out[15],i_out}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_mix_qi_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({u_nco_n_18,u_nco_n_18,u_nco_n_18,u_nco_n_19,u_nco_n_20,u_nco_n_21,u_nco_n_22,u_nco_n_23,u_nco_n_24,u_nco_n_25,u_nco_n_26,u_nco_n_27,u_nco_n_28,u_nco_n_29,u_nco_n_30,u_nco_n_31,u_nco_n_32,u_nco_n_33}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_mix_qi_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_mix_qi_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_mix_qi_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CLK(1'b0),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_mix_qi_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_mix_qi_OVERFLOW_UNCONNECTED),
        .P({NLW_mix_qi_P_UNCONNECTED[47:32],mix_qi_n_74,mix_qi__0,mix_qi_n_91,mix_qi_n_92,mix_qi_n_93,mix_qi_n_94,mix_qi_n_95,mix_qi_n_96,mix_qi_n_97,mix_qi_n_98,mix_qi_n_99,mix_qi_n_100,mix_qi_n_101,mix_qi_n_102,mix_qi_n_103,mix_qi_n_104,mix_qi_n_105}),
        .PATTERNBDETECT(NLW_mix_qi_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_mix_qi_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_mix_qi_PCOUT_UNCONNECTED[47:0]),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_mix_qi_UNDERFLOW_UNCONNECTED));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-13 {cell *THIS*}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(0),
    .BREG(0),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    mix_qq
       (.A({q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out[15],q_out}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_mix_qq_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({out[15],out[15],out}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_mix_qq_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_mix_qq_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_mix_qq_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CLK(1'b0),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_mix_qq_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_mix_qq_OVERFLOW_UNCONNECTED),
        .P({NLW_mix_qq_P_UNCONNECTED[47:32],mix_qq_n_74,mix_qq__0,mix_qq_n_91,mix_qq_n_92,mix_qq_n_93,mix_qq_n_94,mix_qq_n_95,mix_qq_n_96,mix_qq_n_97,mix_qq_n_98,mix_qq_n_99,mix_qq_n_100,mix_qq_n_101,mix_qq_n_102,mix_qq_n_103,mix_qq_n_104,mix_qq_n_105}),
        .PATTERNBDETECT(NLW_mix_qq_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_mix_qq_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_mix_qq_PCOUT_UNCONNECTED[47:0]),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_mix_qq_UNDERFLOW_UNCONNECTED));
  LUT6 #(
    .INIT(64'hA93989E7C47FE61A)) 
    \p_0_out_inferred__0/sin_out[0]_i_2 
       (.I0(sel[6]),
        .I1(sel[3]),
        .I2(sel[4]),
        .I3(sel[0]),
        .I4(sel[1]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6971F9EC2935E673)) 
    \p_0_out_inferred__0/sin_out[0]_i_3 
       (.I0(sel[6]),
        .I1(sel[3]),
        .I2(sel[2]),
        .I3(sel[4]),
        .I4(sel[0]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8778708FA857D628)) 
    \p_0_out_inferred__0/sin_out[10]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[10]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h1518EAE7484FB7B0)) 
    \p_0_out_inferred__0/sin_out[10]_i_6 
       (.I0(sel[3]),
        .I1(sel[2]),
        .I2(sel[4]),
        .I3(sel[0]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[10]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h5DA225DA8A755CA2)) 
    \p_0_out_inferred__0/sin_out[11]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[11]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0FB58000F04A7FFF)) 
    \p_0_out_inferred__0/sin_out[11]_i_5 
       (.I0(sel[3]),
        .I1(sel[0]),
        .I2(sel[2]),
        .I3(sel[1]),
        .I4(sel[4]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[11]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h2333DCCC1404EBFB)) 
    \p_0_out_inferred__0/sin_out[11]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[1]),
        .I3(sel[0]),
        .I4(sel[7]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[11]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAA551BE445BAA659)) 
    \p_0_out_inferred__0/sin_out[11]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[11]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h669933CCB9469866)) 
    \p_0_out_inferred__0/sin_out[12]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[1]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[12]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h1111EEEE3222CDDD)) 
    \p_0_out_inferred__0/sin_out[12]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[1]),
        .I3(sel[0]),
        .I4(sel[7]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[12]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h9966DC23C639629D)) 
    \p_0_out_inferred__0/sin_out[12]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[1]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[12]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \p_0_out_inferred__0/sin_out[13]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out[13]_i_2_n_0 ),
        .I1(sel[5]),
        .I2(\p_0_out_inferred__0/sin_out[13]_i_3_n_0 ),
        .I3(sel[6]),
        .I4(\p_0_out_inferred__0/sin_out[13]_i_4_n_0 ),
        .O(\p_0_out_inferred__0/sin_out[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC83BCFF3C83B0C30)) 
    \p_0_out_inferred__0/sin_out[13]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[13]_i_5_n_0 ),
        .I1(sel[6]),
        .I2(sel[3]),
        .I3(sel[7]),
        .I4(sel[4]),
        .I5(\p_0_out_inferred__0/sin_out[13]_i_6_n_0 ),
        .O(\p_0_out_inferred__0/sin_out[13]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT5 #(
    .INIT(32'h80007FFF)) 
    \p_0_out_inferred__0/sin_out[13]_i_3 
       (.I0(sel[1]),
        .I1(sel[2]),
        .I2(sel[4]),
        .I3(sel[3]),
        .I4(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[13]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hDD9B99BA22646644)) 
    \p_0_out_inferred__0/sin_out[13]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[13]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'h95)) 
    \p_0_out_inferred__0/sin_out[13]_i_5 
       (.I0(sel[7]),
        .I1(sel[1]),
        .I2(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[13]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'h0F78)) 
    \p_0_out_inferred__0/sin_out[13]_i_6 
       (.I0(sel[1]),
        .I1(sel[0]),
        .I2(sel[7]),
        .I3(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[13]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h3732676737326262)) 
    \p_0_out_inferred__0/sin_out[14]_i_2 
       (.I0(sel[6]),
        .I1(sel[7]),
        .I2(sel[3]),
        .I3(\p_0_out_inferred__0/sin_out[14]_i_4_n_0 ),
        .I4(sel[4]),
        .I5(\p_0_out_inferred__0/sin_out[15]_i_2_n_0 ),
        .O(\p_0_out_inferred__0/sin_out[14]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF8000BFF)) 
    \p_0_out_inferred__0/sin_out[14]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[14]_i_5_n_0 ),
        .I1(sel[3]),
        .I2(sel[4]),
        .I3(sel[6]),
        .I4(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[14]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \p_0_out_inferred__0/sin_out[14]_i_4 
       (.I0(sel[7]),
        .I1(sel[2]),
        .I2(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[14]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT4 #(
    .INIT(16'hF087)) 
    \p_0_out_inferred__0/sin_out[14]_i_5 
       (.I0(sel[1]),
        .I1(sel[0]),
        .I2(sel[7]),
        .I3(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[14]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFF00FF01FF00FE00)) 
    \p_0_out_inferred__0/sin_out[15]_i_1 
       (.I0(sel[5]),
        .I1(sel[6]),
        .I2(sel[3]),
        .I3(sel[7]),
        .I4(sel[4]),
        .I5(\p_0_out_inferred__0/sin_out[15]_i_2_n_0 ),
        .O(\p_0_out_inferred__0/sin_out[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT4 #(
    .INIT(16'hFE00)) 
    \p_0_out_inferred__0/sin_out[15]_i_2 
       (.I0(sel[0]),
        .I1(sel[2]),
        .I2(sel[1]),
        .I3(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hD616E440C3B9FFE4)) 
    \p_0_out_inferred__0/sin_out[1]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0C6DEAC01EB29961)) 
    \p_0_out_inferred__0/sin_out[1]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[7]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hD67380B963959700)) 
    \p_0_out_inferred__0/sin_out[1]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[2]),
        .I3(sel[0]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h268279DF76B1FC34)) 
    \p_0_out_inferred__0/sin_out[1]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[7]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[1]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hD8760FC999BC6658)) 
    \p_0_out_inferred__0/sin_out[2]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hF719AF4262FD6A99)) 
    \p_0_out_inferred__0/sin_out[2]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[1]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h654E92B96FFBF842)) 
    \p_0_out_inferred__0/sin_out[2]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[2]),
        .I3(sel[0]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[2]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hD691A96FE9B73602)) 
    \p_0_out_inferred__0/sin_out[2]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h994621DE6E91926E)) 
    \p_0_out_inferred__0/sin_out[3]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCA35D52A1DF2F00B)) 
    \p_0_out_inferred__0/sin_out[3]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFA0585FABB4431CA)) 
    \p_0_out_inferred__0/sin_out[3]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h9867699647B8992E)) 
    \p_0_out_inferred__0/sin_out[3]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hB57133306A8ECCCE)) 
    \p_0_out_inferred__0/sin_out[4]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h66999A65B54AEA11)) 
    \p_0_out_inferred__0/sin_out[4]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h758AD6299A656B90)) 
    \p_0_out_inferred__0/sin_out[4]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hE01FE21DF807C57A)) 
    \p_0_out_inferred__0/sin_out[4]_i_7 
       (.I0(sel[3]),
        .I1(sel[0]),
        .I2(sel[4]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[4]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hA743C56858BC3A96)) 
    \p_0_out_inferred__0/sin_out[5]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h29D6609FEF108972)) 
    \p_0_out_inferred__0/sin_out[5]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[1]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[5]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h6C933EC12AD553AC)) 
    \p_0_out_inferred__0/sin_out[5]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[5]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h22EEDD11FBB80446)) 
    \p_0_out_inferred__0/sin_out[6]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hD32C30CF16E9C63D)) 
    \p_0_out_inferred__0/sin_out[6]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[1]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h36C9CC33807FBD46)) 
    \p_0_out_inferred__0/sin_out[6]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[6]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hD728F40B7D8243BC)) 
    \p_0_out_inferred__0/sin_out[6]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[6]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hE26E1D913B38C4C6)) 
    \p_0_out_inferred__0/sin_out[7]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[7]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h708F629D53AC4CB3)) 
    \p_0_out_inferred__0/sin_out[7]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h187D888AE7827775)) 
    \p_0_out_inferred__0/sin_out[7]_i_6 
       (.I0(sel[3]),
        .I1(sel[0]),
        .I2(sel[2]),
        .I3(sel[1]),
        .I4(sel[4]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCCD73328674298BD)) 
    \p_0_out_inferred__0/sin_out[7]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[1]),
        .I3(sel[0]),
        .I4(sel[7]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[7]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hE1AD25261E52DAD8)) 
    \p_0_out_inferred__0/sin_out[8]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hE718B24DE21DB847)) 
    \p_0_out_inferred__0/sin_out[8]_i_5 
       (.I0(sel[3]),
        .I1(sel[0]),
        .I2(sel[4]),
        .I3(sel[7]),
        .I4(sel[1]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[8]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h425D7777BDA28888)) 
    \p_0_out_inferred__0/sin_out[8]_i_6 
       (.I0(sel[3]),
        .I1(sel[1]),
        .I2(sel[2]),
        .I3(sel[0]),
        .I4(sel[4]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[8]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h4BB448B75AA57D82)) 
    \p_0_out_inferred__0/sin_out[8]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[8]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hDC5823A72FA6D058)) 
    \p_0_out_inferred__0/sin_out[9]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__0/sin_out[9]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h30B73448CF48CBB7)) 
    \p_0_out_inferred__0/sin_out[9]_i_6 
       (.I0(sel[2]),
        .I1(sel[3]),
        .I2(sel[1]),
        .I3(sel[4]),
        .I4(sel[0]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__0/sin_out[9]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h51AEAF5043BCBC43)) 
    \p_0_out_inferred__0/sin_out[9]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[7]),
        .I4(sel[1]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__0/sin_out[9]_i_7_n_0 ));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[0]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out[0]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[0]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[0]_i_1_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[10]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[10]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[10]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[10]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[10]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[10]_i_4_n_0 ),
        .I1(u_nco_n_16),
        .O(\p_0_out_inferred__0/sin_out_reg[10]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[10]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[10]_i_6_n_0 ),
        .I1(u_nco_n_15),
        .O(\p_0_out_inferred__0/sin_out_reg[10]_i_3_n_0 ),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[11]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[11]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[11]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[11]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[11]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[11]_i_4_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[11]_i_5_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[11]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[11]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[11]_i_6_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[11]_i_7_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[11]_i_3_n_0 ),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[12]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[12]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[12]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[12]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[12]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[12]_i_4_n_0 ),
        .I1(u_nco_n_17),
        .O(\p_0_out_inferred__0/sin_out_reg[12]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[12]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[12]_i_6_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[12]_i_7_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[12]_i_3_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[14]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out[14]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[14]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[14]_i_1_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[1]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[1]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[1]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[1]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[1]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[1]_i_4_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[1]_i_5_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[1]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[1]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[1]_i_6_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[1]_i_7_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[1]_i_3_n_0 ),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[2]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[2]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[2]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[2]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[2]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[2]_i_4_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[2]_i_5_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[2]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[2]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[2]_i_6_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[2]_i_7_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[2]_i_3_n_0 ),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[3]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[3]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[3]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[3]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[3]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[3]_i_4_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[3]_i_5_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[3]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[3]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[3]_i_6_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[3]_i_7_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[3]_i_3_n_0 ),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[4]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[4]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[4]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[4]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[4]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[4]_i_4_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[4]_i_5_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[4]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[4]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[4]_i_6_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[4]_i_7_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[4]_i_3_n_0 ),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[5]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[5]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[5]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[5]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[5]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[5]_i_4_n_0 ),
        .I1(u_nco_n_13),
        .O(\p_0_out_inferred__0/sin_out_reg[5]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[5]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[5]_i_6_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[5]_i_7_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[5]_i_3_n_0 ),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[6]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[6]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[6]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[6]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[6]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[6]_i_4_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[6]_i_5_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[6]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[6]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[6]_i_6_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[6]_i_7_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[6]_i_3_n_0 ),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[7]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[7]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[7]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[7]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[7]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[7]_i_4_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[7]_i_5_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[7]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[7]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[7]_i_6_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[7]_i_7_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[7]_i_3_n_0 ),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[8]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[8]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[8]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[8]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[8]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[8]_i_4_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[8]_i_5_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[8]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[8]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[8]_i_6_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[8]_i_7_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[8]_i_3_n_0 ),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__0/sin_out_reg[9]_i_1 
       (.I0(\p_0_out_inferred__0/sin_out_reg[9]_i_2_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out_reg[9]_i_3_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[9]_i_1_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[9]_i_2 
       (.I0(\p_0_out_inferred__0/sin_out[9]_i_4_n_0 ),
        .I1(u_nco_n_14),
        .O(\p_0_out_inferred__0/sin_out_reg[9]_i_2_n_0 ),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__0/sin_out_reg[9]_i_3 
       (.I0(\p_0_out_inferred__0/sin_out[9]_i_6_n_0 ),
        .I1(\p_0_out_inferred__0/sin_out[9]_i_7_n_0 ),
        .O(\p_0_out_inferred__0/sin_out_reg[9]_i_3_n_0 ),
        .S(sel[6]));
  LUT6 #(
    .INIT(64'h76BEC09D66F3D127)) 
    \p_0_out_inferred__2/cos_out[0]_i_2 
       (.I0(sel[5]),
        .I1(sel[3]),
        .I2(sel[4]),
        .I3(sel[0]),
        .I4(sel[2]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8BB903CF667D6E92)) 
    \p_0_out_inferred__2/cos_out[0]_i_3 
       (.I0(sel[5]),
        .I1(sel[3]),
        .I2(sel[4]),
        .I3(sel[0]),
        .I4(sel[1]),
        .I5(sel[2]),
        .O(\p_0_out_inferred__2/cos_out[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h788F57288770A8D6)) 
    \p_0_out_inferred__2/cos_out[10]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[10]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEAE71518B7B0484F)) 
    \p_0_out_inferred__2/cos_out[10]_i_7 
       (.I0(sel[3]),
        .I1(sel[2]),
        .I2(sel[4]),
        .I3(sel[0]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[10]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0BF58000F40A7FFF)) 
    \p_0_out_inferred__2/cos_out[11]_i_4 
       (.I0(sel[3]),
        .I1(sel[0]),
        .I2(sel[1]),
        .I3(sel[2]),
        .I4(sel[4]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[11]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAA1B55E445A6BA59)) 
    \p_0_out_inferred__2/cos_out[11]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[11]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hA2DA75A25D258A5C)) 
    \p_0_out_inferred__2/cos_out[11]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[11]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hDCCCEBFB23331404)) 
    \p_0_out_inferred__2/cos_out[11]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[1]),
        .I3(sel[0]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[11]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h99DCC6626623399D)) 
    \p_0_out_inferred__2/cos_out[12]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[12]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9946CC6666B93398)) 
    \p_0_out_inferred__2/cos_out[12]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[12]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEEEECDDD11113222)) 
    \p_0_out_inferred__2/cos_out[12]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[1]),
        .I3(sel[0]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[12]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \p_0_out_inferred__2/cos_out[13]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out[13]_i_2_n_0 ),
        .I1(sel[5]),
        .I2(\p_0_out_inferred__2/cos_out[13]_i_3_n_0 ),
        .I3(sel[6]),
        .I4(\p_0_out_inferred__2/cos_out[13]_i_4_n_0 ),
        .O(p_0_out[13]));
  LUT6 #(
    .INIT(64'hFFFFFEEE00000111)) 
    \p_0_out_inferred__2/cos_out[13]_i_2 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[1]),
        .I3(sel[0]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h22646644DD9B99BA)) 
    \p_0_out_inferred__2/cos_out[13]_i_3 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[13]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFC88C0CC30BBF333)) 
    \p_0_out_inferred__2/cos_out[13]_i_4 
       (.I0(\p_0_out_inferred__2/cos_out[13]_i_5_n_0 ),
        .I1(sel[5]),
        .I2(\p_0_out_inferred__2/cos_out[14]_i_5_n_0 ),
        .I3(sel[4]),
        .I4(sel[3]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[13]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'h07F8)) 
    \p_0_out_inferred__2/cos_out[13]_i_5 
       (.I0(sel[1]),
        .I1(sel[0]),
        .I2(sel[2]),
        .I3(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[13]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hF8000BFF)) 
    \p_0_out_inferred__2/cos_out[14]_i_2 
       (.I0(\p_0_out_inferred__2/cos_out[14]_i_4_n_0 ),
        .I1(sel[3]),
        .I2(sel[4]),
        .I3(sel[5]),
        .I4(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCDC89D9DCDC89898)) 
    \p_0_out_inferred__2/cos_out[14]_i_3 
       (.I0(sel[5]),
        .I1(sel[7]),
        .I2(sel[3]),
        .I3(\p_0_out_inferred__2/cos_out[14]_i_5_n_0 ),
        .I4(sel[4]),
        .I5(\p_0_out_inferred__2/cos_out[15]_i_2_n_0 ),
        .O(\p_0_out_inferred__2/cos_out[14]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'hF807)) 
    \p_0_out_inferred__2/cos_out[14]_i_4 
       (.I0(sel[1]),
        .I1(sel[0]),
        .I2(sel[2]),
        .I3(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[14]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'h87)) 
    \p_0_out_inferred__2/cos_out[14]_i_5 
       (.I0(sel[1]),
        .I1(sel[2]),
        .I2(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[14]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0100FFFFFFFE0000)) 
    \p_0_out_inferred__2/cos_out[15]_i_1 
       (.I0(sel[5]),
        .I1(sel[3]),
        .I2(sel[4]),
        .I3(\p_0_out_inferred__2/cos_out[15]_i_2_n_0 ),
        .I4(sel[6]),
        .I5(sel[7]),
        .O(p_0_out[15]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'h00FE)) 
    \p_0_out_inferred__2/cos_out[15]_i_2 
       (.I0(sel[0]),
        .I1(sel[2]),
        .I2(sel[1]),
        .I3(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0C6D1EB2EAC09961)) 
    \p_0_out_inferred__2/cos_out[1]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h267679FC82B1DF34)) 
    \p_0_out_inferred__2/cos_out[1]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hC3B9FFE4D616E440)) 
    \p_0_out_inferred__2/cos_out[1]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h63959700D67380B9)) 
    \p_0_out_inferred__2/cos_out[1]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[2]),
        .I3(sel[0]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[1]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hF7AF626A1942FD99)) 
    \p_0_out_inferred__2/cos_out[2]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hD691E9B7A96F3602)) 
    \p_0_out_inferred__2/cos_out[2]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0FC96658D87699BC)) 
    \p_0_out_inferred__2/cos_out[2]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[2]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h92B9654EF8426FFB)) 
    \p_0_out_inferred__2/cos_out[2]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[2]),
        .I3(sel[0]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCAD5352A1DF0F20B)) 
    \p_0_out_inferred__2/cos_out[3]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h9847699967B8962E)) 
    \p_0_out_inferred__2/cos_out[3]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h46DE916E99216E92)) 
    \p_0_out_inferred__2/cos_out[3]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0544FACAFABB8531)) 
    \p_0_out_inferred__2/cos_out[3]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h66B59AEA994A6511)) 
    \p_0_out_inferred__2/cos_out[4]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hE0E21F1DF8C5077A)) 
    \p_0_out_inferred__2/cos_out[4]_i_5 
       (.I0(sel[3]),
        .I1(sel[0]),
        .I2(sel[4]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6A8ECCCEB5713330)) 
    \p_0_out_inferred__2/cos_out[4]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8A2975D665909A6B)) 
    \p_0_out_inferred__2/cos_out[4]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[4]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h6C3E93C12A53D5AC)) 
    \p_0_out_inferred__2/cos_out[5]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h58BC3A96A743C568)) 
    \p_0_out_inferred__2/cos_out[5]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[5]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hD69F10722960EF89)) 
    \p_0_out_inferred__2/cos_out[5]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[5]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hD33016C62CCFE93D)) 
    \p_0_out_inferred__2/cos_out[6]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hD7F4280B7D4382BC)) 
    \p_0_out_inferred__2/cos_out[6]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hDD11044622EEFBB8)) 
    \p_0_out_inferred__2/cos_out[6]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[6]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hC93336CC7F4680BD)) 
    \p_0_out_inferred__2/cos_out[6]_i_7 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[6]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h7053624C8FAC9DB3)) 
    \p_0_out_inferred__2/cos_out[7]_i_4 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[1]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCCD76742332898BD)) 
    \p_0_out_inferred__2/cos_out[7]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[1]),
        .I3(sel[0]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h1DC491C6E23B6E38)) 
    \p_0_out_inferred__2/cos_out[7]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hE7827775187D888A)) 
    \p_0_out_inferred__2/cos_out[7]_i_7 
       (.I0(sel[3]),
        .I1(sel[0]),
        .I2(sel[2]),
        .I3(sel[1]),
        .I4(sel[4]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[7]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hE7B2E2B8184D1D47)) 
    \p_0_out_inferred__2/cos_out[8]_i_4 
       (.I0(sel[3]),
        .I1(sel[0]),
        .I2(sel[4]),
        .I3(sel[1]),
        .I4(sel[2]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h4B48B4B75A7DA582)) 
    \p_0_out_inferred__2/cos_out[8]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[8]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h1E52DAD8E1AD2526)) 
    \p_0_out_inferred__2/cos_out[8]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[8]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hBDA28888425D7777)) 
    \p_0_out_inferred__2/cos_out[8]_i_7 
       (.I0(sel[3]),
        .I1(sel[1]),
        .I2(sel[2]),
        .I3(sel[0]),
        .I4(sel[4]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[8]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h5143AEBCAFBC5043)) 
    \p_0_out_inferred__2/cos_out[9]_i_5 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[7]),
        .I5(sel[1]),
        .O(\p_0_out_inferred__2/cos_out[9]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h23A7D058DC582FA6)) 
    \p_0_out_inferred__2/cos_out[9]_i_6 
       (.I0(sel[3]),
        .I1(sel[4]),
        .I2(sel[0]),
        .I3(sel[2]),
        .I4(sel[1]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[9]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCF48CBB730B73448)) 
    \p_0_out_inferred__2/cos_out[9]_i_7 
       (.I0(sel[2]),
        .I1(sel[3]),
        .I2(sel[1]),
        .I3(sel[4]),
        .I4(sel[0]),
        .I5(sel[7]),
        .O(\p_0_out_inferred__2/cos_out[9]_i_7_n_0 ));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[0]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out[0]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[0]_i_3_n_0 ),
        .O(p_0_out[0]),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[10]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[10]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[10]_i_3_n_0 ),
        .O(p_0_out[10]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[10]_i_2 
       (.I0(u_nco_n_9),
        .I1(u_nco_n_10),
        .O(\p_0_out_inferred__2/cos_out_reg[10]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[10]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[10]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[10]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[10]_i_3_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[11]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[11]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[11]_i_3_n_0 ),
        .O(p_0_out[11]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[11]_i_2 
       (.I0(\p_0_out_inferred__2/cos_out[11]_i_4_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[11]_i_5_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[11]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[11]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[11]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[11]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[11]_i_3_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[12]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[12]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[12]_i_3_n_0 ),
        .O(p_0_out[12]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[12]_i_2 
       (.I0(u_nco_n_0),
        .I1(\p_0_out_inferred__2/cos_out[12]_i_5_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[12]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[12]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[12]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[12]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[12]_i_3_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[14]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out[14]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[14]_i_3_n_0 ),
        .O(p_0_out[14]),
        .S(sel[6]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[1]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[1]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[1]_i_3_n_0 ),
        .O(p_0_out[1]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[1]_i_2 
       (.I0(\p_0_out_inferred__2/cos_out[1]_i_4_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[1]_i_5_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[1]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[1]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[1]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[1]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[1]_i_3_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[2]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[2]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[2]_i_3_n_0 ),
        .O(p_0_out[2]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[2]_i_2 
       (.I0(\p_0_out_inferred__2/cos_out[2]_i_4_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[2]_i_5_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[2]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[2]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[2]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[2]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[2]_i_3_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[3]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[3]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[3]_i_3_n_0 ),
        .O(p_0_out[3]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[3]_i_2 
       (.I0(\p_0_out_inferred__2/cos_out[3]_i_4_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[3]_i_5_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[3]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[3]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[3]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[3]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[3]_i_3_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[4]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[4]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[4]_i_3_n_0 ),
        .O(p_0_out[4]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[4]_i_2 
       (.I0(\p_0_out_inferred__2/cos_out[4]_i_4_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[4]_i_5_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[4]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[4]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[4]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[4]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[4]_i_3_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[5]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[5]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[5]_i_3_n_0 ),
        .O(p_0_out[5]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[5]_i_2 
       (.I0(u_nco_n_12),
        .I1(\p_0_out_inferred__2/cos_out[5]_i_5_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[5]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[5]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[5]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[5]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[5]_i_3_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[6]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[6]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[6]_i_3_n_0 ),
        .O(p_0_out[6]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[6]_i_2 
       (.I0(\p_0_out_inferred__2/cos_out[6]_i_4_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[6]_i_5_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[6]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[6]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[6]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[6]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[6]_i_3_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[7]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[7]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[7]_i_3_n_0 ),
        .O(p_0_out[7]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[7]_i_2 
       (.I0(\p_0_out_inferred__2/cos_out[7]_i_4_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[7]_i_5_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[7]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[7]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[7]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[7]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[7]_i_3_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[8]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[8]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[8]_i_3_n_0 ),
        .O(p_0_out[8]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[8]_i_2 
       (.I0(\p_0_out_inferred__2/cos_out[8]_i_4_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[8]_i_5_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[8]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[8]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[8]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[8]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[8]_i_3_n_0 ),
        .S(sel[5]));
  MUXF8 \p_0_out_inferred__2/cos_out_reg[9]_i_1 
       (.I0(\p_0_out_inferred__2/cos_out_reg[9]_i_2_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out_reg[9]_i_3_n_0 ),
        .O(p_0_out[9]),
        .S(sel[6]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[9]_i_2 
       (.I0(u_nco_n_11),
        .I1(\p_0_out_inferred__2/cos_out[9]_i_5_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[9]_i_2_n_0 ),
        .S(sel[5]));
  MUXF7 \p_0_out_inferred__2/cos_out_reg[9]_i_3 
       (.I0(\p_0_out_inferred__2/cos_out[9]_i_6_n_0 ),
        .I1(\p_0_out_inferred__2/cos_out[9]_i_7_n_0 ),
        .O(\p_0_out_inferred__2/cos_out_reg[9]_i_3_n_0 ),
        .S(sel[5]));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[11]_i_11 
       (.I0(mix_qi__0[23]),
        .O(\q_mix[11]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[11]_i_12 
       (.I0(mix_qi__0[22]),
        .O(\q_mix[11]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[11]_i_13 
       (.I0(mix_qi__0[21]),
        .O(\q_mix[11]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[11]_i_14 
       (.I0(mix_qi__0[20]),
        .O(\q_mix[11]_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[11]_i_2 
       (.I0(\q_mix_reg[15]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\q_mix[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[11]_i_3 
       (.I0(\q_mix_reg[15]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\q_mix[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[11]_i_4 
       (.I0(\q_mix_reg[15]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\q_mix[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[11]_i_5 
       (.I0(\q_mix_reg[11]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\q_mix[11]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[15]_i_11 
       (.I0(mix_qi__0[30]),
        .O(\q_mix[15]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[15]_i_12 
       (.I0(mix_qi__0[29]),
        .O(\q_mix[15]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[15]_i_13 
       (.I0(mix_qi__0[28]),
        .O(\q_mix[15]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[15]_i_14 
       (.I0(mix_qi__0[27]),
        .O(\q_mix[15]_i_14_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[15]_i_15 
       (.I0(mix_qi__0[26]),
        .O(\q_mix[15]_i_15_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[15]_i_16 
       (.I0(mix_qi__0[25]),
        .O(\q_mix[15]_i_16_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[15]_i_17 
       (.I0(mix_qi__0[24]),
        .O(\q_mix[15]_i_17_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[15]_i_2 
       (.I0(\q_mix_reg[15]_i_9_n_6 ),
        .I1(core_bypass_costas),
        .O(\q_mix[15]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[15]_i_3 
       (.I0(\q_mix_reg[15]_i_9_n_7 ),
        .I1(core_bypass_costas),
        .O(\q_mix[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[15]_i_4 
       (.I0(\q_mix_reg[15]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\q_mix[15]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[3]_i_2 
       (.I0(\q_mix_reg[7]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\q_mix[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[3]_i_3 
       (.I0(\q_mix_reg[7]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\q_mix[3]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[3]_i_4 
       (.I0(\q_mix_reg[7]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\q_mix[3]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[3]_i_5 
       (.I0(mix_qi__0[15]),
        .I1(core_bypass_costas),
        .O(\q_mix[3]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[7]_i_11 
       (.I0(mix_qi__0[15]),
        .O(\q_mix[7]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[7]_i_12 
       (.I0(mix_qi__0[19]),
        .O(\q_mix[7]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[7]_i_13 
       (.I0(mix_qi__0[18]),
        .O(\q_mix[7]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[7]_i_14 
       (.I0(mix_qi__0[17]),
        .O(\q_mix[7]_i_14_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \q_mix[7]_i_15 
       (.I0(mix_qi__0[16]),
        .O(\q_mix[7]_i_15_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[7]_i_2 
       (.I0(\q_mix_reg[11]_i_10_n_5 ),
        .I1(core_bypass_costas),
        .O(\q_mix[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[7]_i_3 
       (.I0(\q_mix_reg[11]_i_10_n_6 ),
        .I1(core_bypass_costas),
        .O(\q_mix[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[7]_i_4 
       (.I0(\q_mix_reg[11]_i_10_n_7 ),
        .I1(core_bypass_costas),
        .O(\q_mix[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \q_mix[7]_i_5 
       (.I0(\q_mix_reg[7]_i_10_n_4 ),
        .I1(core_bypass_costas),
        .O(\q_mix[7]_i_5_n_0 ));
  FDCE \q_mix_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_33),
        .Q(B[0]));
  FDCE \q_mix_reg[10] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_23),
        .Q(q_mix[10]));
  FDCE \q_mix_reg[11] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_22),
        .Q(q_mix[11]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \q_mix_reg[11]_i_10 
       (.CI(\q_mix_reg[7]_i_10_n_0 ),
        .CO({\q_mix_reg[11]_i_10_n_0 ,\q_mix_reg[11]_i_10_n_1 ,\q_mix_reg[11]_i_10_n_2 ,\q_mix_reg[11]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\q_mix_reg[11]_i_10_n_4 ,\q_mix_reg[11]_i_10_n_5 ,\q_mix_reg[11]_i_10_n_6 ,\q_mix_reg[11]_i_10_n_7 }),
        .S({\q_mix[11]_i_11_n_0 ,\q_mix[11]_i_12_n_0 ,\q_mix[11]_i_13_n_0 ,\q_mix[11]_i_14_n_0 }));
  FDCE \q_mix_reg[12] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_21),
        .Q(q_mix[12]));
  FDCE \q_mix_reg[13] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_20),
        .Q(q_mix[13]));
  FDCE \q_mix_reg[14] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_19),
        .Q(q_mix[14]));
  FDCE \q_mix_reg[15] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_18),
        .Q(q_mix[15]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \q_mix_reg[15]_i_10 
       (.CI(\q_mix_reg[11]_i_10_n_0 ),
        .CO({\q_mix_reg[15]_i_10_n_0 ,\q_mix_reg[15]_i_10_n_1 ,\q_mix_reg[15]_i_10_n_2 ,\q_mix_reg[15]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\q_mix_reg[15]_i_10_n_4 ,\q_mix_reg[15]_i_10_n_5 ,\q_mix_reg[15]_i_10_n_6 ,\q_mix_reg[15]_i_10_n_7 }),
        .S({\q_mix[15]_i_14_n_0 ,\q_mix[15]_i_15_n_0 ,\q_mix[15]_i_16_n_0 ,\q_mix[15]_i_17_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \q_mix_reg[15]_i_9 
       (.CI(\q_mix_reg[15]_i_10_n_0 ),
        .CO({\NLW_q_mix_reg[15]_i_9_CO_UNCONNECTED [3:2],\q_mix_reg[15]_i_9_n_2 ,\q_mix_reg[15]_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_q_mix_reg[15]_i_9_O_UNCONNECTED [3],\q_mix_reg[15]_i_9_n_5 ,\q_mix_reg[15]_i_9_n_6 ,\q_mix_reg[15]_i_9_n_7 }),
        .S({1'b0,\q_mix[15]_i_11_n_0 ,\q_mix[15]_i_12_n_0 ,\q_mix[15]_i_13_n_0 }));
  FDCE \q_mix_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_32),
        .Q(q_mix[1]));
  FDCE \q_mix_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_31),
        .Q(q_mix[2]));
  FDCE \q_mix_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_30),
        .Q(q_mix[3]));
  FDCE \q_mix_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_29),
        .Q(q_mix[4]));
  FDCE \q_mix_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_28),
        .Q(q_mix[5]));
  FDCE \q_mix_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_27),
        .Q(q_mix[6]));
  FDCE \q_mix_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_26),
        .Q(q_mix[7]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \q_mix_reg[7]_i_10 
       (.CI(1'b0),
        .CO({\q_mix_reg[7]_i_10_n_0 ,\q_mix_reg[7]_i_10_n_1 ,\q_mix_reg[7]_i_10_n_2 ,\q_mix_reg[7]_i_10_n_3 }),
        .CYINIT(\q_mix[7]_i_11_n_0 ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\q_mix_reg[7]_i_10_n_4 ,\q_mix_reg[7]_i_10_n_5 ,\q_mix_reg[7]_i_10_n_6 ,\q_mix_reg[7]_i_10_n_7 }),
        .S({\q_mix[7]_i_12_n_0 ,\q_mix[7]_i_13_n_0 ,\q_mix[7]_i_14_n_0 ,\q_mix[7]_i_15_n_0 }));
  FDCE \q_mix_reg[8] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_25),
        .Q(q_mix[8]));
  FDCE \q_mix_reg[9] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
        .D(u_agc_n_24),
        .Q(q_mix[9]));
  LUT2 #(
    .INIT(4'h1)) 
    \sps_counter[0]_i_1 
       (.I0(dump_strobe0),
        .I1(sps_counter_reg[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \sps_counter[1]_i_1 
       (.I0(sps_counter_reg[1]),
        .I1(sps_counter_reg[0]),
        .I2(dump_strobe0),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'h1540)) 
    \sps_counter[2]_i_1 
       (.I0(dump_strobe0),
        .I1(sps_counter_reg[0]),
        .I2(sps_counter_reg[1]),
        .I3(sps_counter_reg[2]),
        .O(\sps_counter[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT5 #(
    .INIT(32'h15554000)) 
    \sps_counter[3]_i_1 
       (.I0(dump_strobe0),
        .I1(sps_counter_reg[1]),
        .I2(sps_counter_reg[0]),
        .I3(sps_counter_reg[2]),
        .I4(sps_counter_reg[3]),
        .O(\sps_counter[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1555555540000000)) 
    \sps_counter[4]_i_1 
       (.I0(dump_strobe0),
        .I1(sps_counter_reg[2]),
        .I2(sps_counter_reg[0]),
        .I3(sps_counter_reg[1]),
        .I4(sps_counter_reg[3]),
        .I5(sps_counter_reg[4]),
        .O(\sps_counter[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'h41)) 
    \sps_counter[5]_i_1 
       (.I0(dump_strobe0),
        .I1(\sps_counter[5]_i_2_n_0 ),
        .I2(sps_counter_reg[5]),
        .O(\sps_counter[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \sps_counter[5]_i_2 
       (.I0(sps_counter_reg[3]),
        .I1(sps_counter_reg[1]),
        .I2(sps_counter_reg[0]),
        .I3(sps_counter_reg[2]),
        .I4(sps_counter_reg[4]),
        .O(\sps_counter[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'h14)) 
    \sps_counter[6]_i_1 
       (.I0(dump_strobe0),
        .I1(\sps_counter[7]_i_2_n_0 ),
        .I2(sps_counter_reg[6]),
        .O(\sps_counter[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'h0078)) 
    \sps_counter[7]_i_1 
       (.I0(\sps_counter[7]_i_2_n_0 ),
        .I1(sps_counter_reg[6]),
        .I2(sps_counter_reg[7]),
        .I3(dump_strobe0),
        .O(p_0_in[7]));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \sps_counter[7]_i_2 
       (.I0(sps_counter_reg[5]),
        .I1(sps_counter_reg[4]),
        .I2(sps_counter_reg[2]),
        .I3(sps_counter_reg[0]),
        .I4(sps_counter_reg[1]),
        .I5(sps_counter_reg[3]),
        .O(\sps_counter[7]_i_2_n_0 ));
  FDCE \sps_counter_reg[0] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(p_0_in[0]),
        .Q(sps_counter_reg[0]));
  FDCE \sps_counter_reg[1] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(p_0_in[1]),
        .Q(sps_counter_reg[1]));
  FDCE \sps_counter_reg[2] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\sps_counter[2]_i_1_n_0 ),
        .Q(sps_counter_reg[2]));
  FDCE \sps_counter_reg[3] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\sps_counter[3]_i_1_n_0 ),
        .Q(sps_counter_reg[3]));
  FDCE \sps_counter_reg[4] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\sps_counter[4]_i_1_n_0 ),
        .Q(sps_counter_reg[4]));
  FDCE \sps_counter_reg[5] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\sps_counter[5]_i_1_n_0 ),
        .Q(sps_counter_reg[5]));
  FDCE \sps_counter_reg[6] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(\sps_counter[6]_i_1_n_0 ),
        .Q(sps_counter_reg[6]));
  FDCE \sps_counter_reg[7] 
       (.C(aclk),
        .CE(sps_eff1),
        .CLR(aresetn_0),
        .D(p_0_in[7]),
        .Q(sps_counter_reg[7]));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \sps_eff1_inferred__1/i__carry 
       (.CI(1'b0),
        .CO({\sps_eff1_inferred__1/i__carry_n_0 ,\sps_eff1_inferred__1/i__carry_n_1 ,\sps_eff1_inferred__1/i__carry_n_2 ,\sps_eff1_inferred__1/i__carry_n_3 }),
        .CYINIT(1'b0),
        .DI({i__carry_i_1_n_0,i__carry_i_2_n_0,i__carry_i_3_n_0,i__carry_i_4_n_0}),
        .O(\NLW_sps_eff1_inferred__1/i__carry_O_UNCONNECTED [3:0]),
        .S({i__carry_i_5_n_0,i__carry_i_6_n_0,i__carry_i_7_n_0,i__carry_i_8_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \sps_eff1_inferred__1/i__carry__0 
       (.CI(\sps_eff1_inferred__1/i__carry_n_0 ),
        .CO({sps_eff13_in,\sps_eff1_inferred__1/i__carry__0_n_1 ,\sps_eff1_inferred__1/i__carry__0_n_2 ,\sps_eff1_inferred__1/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,i__carry__0_i_1_n_0,i__carry__0_i_2_n_0,i__carry__0_i_3_n_0}),
        .O(\NLW_sps_eff1_inferred__1/i__carry__0_O_UNCONNECTED [3:0]),
        .S({i__carry__0_i_4_n_0,i__carry__0_i_5_n_0,i__carry__0_i_6_n_0,i__carry__0_i_7_n_0}));
  LUT4 #(
    .INIT(16'h56AA)) 
    \sps_eff[0]_i_1 
       (.I0(\sps_eff_reg[7]_0 [0]),
        .I1(sps_eff13_in),
        .I2(\sps_eff[1]_i_2_n_0 ),
        .I3(\sps_eff[0]_i_2_n_0 ),
        .O(\sps_eff[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT5 #(
    .INIT(32'h00404040)) 
    \sps_eff[0]_i_2 
       (.I0(core_bypass_timing),
        .I1(core_enable),
        .I2(adc_valid_d1),
        .I3(sps_eff13_in),
        .I4(\sps_eff[1]_i_3_n_0 ),
        .O(\sps_eff[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hF078C378F0F0F0F0)) 
    \sps_eff[1]_i_1 
       (.I0(\sps_eff[1]_i_2_n_0 ),
        .I1(\sps_eff_reg[7]_0 [0]),
        .I2(\sps_eff_reg[7]_0 [1]),
        .I3(sps_eff13_in),
        .I4(\sps_eff[1]_i_3_n_0 ),
        .I5(\sps_eff[5]_i_4_n_0 ),
        .O(\sps_eff[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT5 #(
    .INIT(32'h00000700)) 
    \sps_eff[1]_i_2 
       (.I0(\sps_eff[3]_i_5_n_0 ),
        .I1(\sps_eff_reg[7]_0 [0]),
        .I2(\frac_timing_reg_n_0_[14] ),
        .I3(\frac_timing_reg_n_0_[15] ),
        .I4(\sps_eff_reg[7]_0 [7]),
        .O(\sps_eff[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000111)) 
    \sps_eff[1]_i_3 
       (.I0(\sps_eff_reg[7]_0 [2]),
        .I1(\sps_eff_reg[7]_0 [7]),
        .I2(\sps_eff_reg[7]_0 [0]),
        .I3(\sps_eff_reg[7]_0 [1]),
        .I4(\sps_eff[1]_i_4_n_0 ),
        .O(\sps_eff[1]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \sps_eff[1]_i_4 
       (.I0(\sps_eff_reg[7]_0 [3]),
        .I1(\sps_eff_reg[7]_0 [4]),
        .I2(\sps_eff_reg[7]_0 [5]),
        .I3(\sps_eff_reg[7]_0 [6]),
        .O(\sps_eff[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFE0FFFFFF100000)) 
    \sps_eff[2]_i_1 
       (.I0(\sps_eff_reg[7]_0 [1]),
        .I1(\sps_eff_reg[7]_0 [0]),
        .I2(\sps_eff[6]_i_2_n_0 ),
        .I3(\sps_eff[2]_i_2_n_0 ),
        .I4(\sps_eff[5]_i_4_n_0 ),
        .I5(\sps_eff_reg[7]_0 [2]),
        .O(\sps_eff[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000CCCC47CC)) 
    \sps_eff[2]_i_2 
       (.I0(\sps_eff[3]_i_3_n_0 ),
        .I1(\sps_eff_reg[7]_0 [2]),
        .I2(\sps_eff_reg[7]_0 [7]),
        .I3(\sps_eff[2]_i_3_n_0 ),
        .I4(\sps_eff[4]_i_4_n_0 ),
        .I5(sps_eff13_in),
        .O(\sps_eff[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h4)) 
    \sps_eff[2]_i_3 
       (.I0(\frac_timing_reg_n_0_[14] ),
        .I1(\frac_timing_reg_n_0_[15] ),
        .O(\sps_eff[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hBB88BB88FF88BFC8)) 
    \sps_eff[3]_i_1 
       (.I0(\sps_eff[3]_i_2_n_0 ),
        .I1(\sps_eff[5]_i_4_n_0 ),
        .I2(\sps_eff[3]_i_3_n_0 ),
        .I3(\sps_eff_reg[7]_0 [3]),
        .I4(\sps_eff[3]_i_4_n_0 ),
        .I5(sps_eff13_in),
        .O(\sps_eff[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT5 #(
    .INIT(32'hAAA80002)) 
    \sps_eff[3]_i_2 
       (.I0(\sps_eff[6]_i_2_n_0 ),
        .I1(\sps_eff_reg[7]_0 [2]),
        .I2(\sps_eff_reg[7]_0 [1]),
        .I3(\sps_eff_reg[7]_0 [0]),
        .I4(\sps_eff_reg[7]_0 [3]),
        .O(\sps_eff[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h07)) 
    \sps_eff[3]_i_3 
       (.I0(\sps_eff[3]_i_5_n_0 ),
        .I1(\sps_eff_reg[7]_0 [0]),
        .I2(\sps_eff_reg[7]_0 [7]),
        .O(\sps_eff[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT5 #(
    .INIT(32'hDFFFFFFF)) 
    \sps_eff[3]_i_4 
       (.I0(\frac_timing_reg_n_0_[15] ),
        .I1(\frac_timing_reg_n_0_[14] ),
        .I2(\sps_eff_reg[7]_0 [0]),
        .I3(\sps_eff_reg[7]_0 [1]),
        .I4(\sps_eff_reg[7]_0 [2]),
        .O(\sps_eff[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \sps_eff[3]_i_5 
       (.I0(\sps_eff_reg[7]_0 [4]),
        .I1(\sps_eff_reg[7]_0 [3]),
        .I2(\sps_eff_reg[7]_0 [6]),
        .I3(\sps_eff_reg[7]_0 [5]),
        .I4(\sps_eff_reg[7]_0 [2]),
        .I5(\sps_eff_reg[7]_0 [1]),
        .O(\sps_eff[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h60AA75AA60AAEAAA)) 
    \sps_eff[4]_i_1 
       (.I0(\sps_eff_reg[7]_0 [4]),
        .I1(\sps_eff[4]_i_2_n_0 ),
        .I2(\sps_eff[6]_i_2_n_0 ),
        .I3(\sps_eff[5]_i_4_n_0 ),
        .I4(sps_eff13_in),
        .I5(\sps_eff[4]_i_3_n_0 ),
        .O(\sps_eff[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \sps_eff[4]_i_2 
       (.I0(\sps_eff_reg[7]_0 [0]),
        .I1(\sps_eff_reg[7]_0 [1]),
        .I2(\sps_eff_reg[7]_0 [2]),
        .I3(\sps_eff_reg[7]_0 [3]),
        .O(\sps_eff[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000008000000000)) 
    \sps_eff[4]_i_3 
       (.I0(\sps_eff[3]_i_3_n_0 ),
        .I1(\sps_eff_reg[7]_0 [3]),
        .I2(\frac_timing_reg_n_0_[15] ),
        .I3(\frac_timing_reg_n_0_[14] ),
        .I4(\sps_eff[4]_i_4_n_0 ),
        .I5(\sps_eff_reg[7]_0 [2]),
        .O(\sps_eff[4]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \sps_eff[4]_i_4 
       (.I0(\sps_eff_reg[7]_0 [0]),
        .I1(\sps_eff_reg[7]_0 [1]),
        .O(\sps_eff[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h888FFFFF4F440000)) 
    \sps_eff[5]_i_1 
       (.I0(\sps_eff[5]_i_2_n_0 ),
        .I1(\sps_eff[6]_i_2_n_0 ),
        .I2(sps_eff13_in),
        .I3(\sps_eff[5]_i_3_n_0 ),
        .I4(\sps_eff[5]_i_4_n_0 ),
        .I5(\sps_eff_reg[7]_0 [5]),
        .O(\sps_eff[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \sps_eff[5]_i_2 
       (.I0(\sps_eff_reg[7]_0 [4]),
        .I1(\sps_eff_reg[7]_0 [3]),
        .I2(\sps_eff_reg[7]_0 [2]),
        .I3(\sps_eff_reg[7]_0 [1]),
        .I4(\sps_eff_reg[7]_0 [0]),
        .O(\sps_eff[5]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h08)) 
    \sps_eff[5]_i_3 
       (.I0(\sps_eff[3]_i_3_n_0 ),
        .I1(\sps_eff_reg[7]_0 [4]),
        .I2(\sps_eff[5]_i_5_n_0 ),
        .O(\sps_eff[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \sps_eff[5]_i_4 
       (.I0(adc_valid_d1),
        .I1(core_enable),
        .I2(core_bypass_timing),
        .O(\sps_eff[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFF7FFFFFFFFFFFFF)) 
    \sps_eff[5]_i_5 
       (.I0(\sps_eff_reg[7]_0 [2]),
        .I1(\sps_eff_reg[7]_0 [1]),
        .I2(\sps_eff_reg[7]_0 [0]),
        .I3(\frac_timing_reg_n_0_[14] ),
        .I4(\frac_timing_reg_n_0_[15] ),
        .I5(\sps_eff_reg[7]_0 [3]),
        .O(\sps_eff[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF4FF0000F800)) 
    \sps_eff[6]_i_1 
       (.I0(\sps_eff[7]_i_3_n_0 ),
        .I1(\sps_eff[6]_i_2_n_0 ),
        .I2(\sps_eff[6]_i_3_n_0 ),
        .I3(sps_eff1),
        .I4(core_bypass_timing),
        .I5(\sps_eff_reg[7]_0 [6]),
        .O(\sps_eff[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \sps_eff[6]_i_2 
       (.I0(sps_eff13_in),
        .I1(\sps_eff[1]_i_3_n_0 ),
        .O(\sps_eff[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT4 #(
    .INIT(16'h5540)) 
    \sps_eff[6]_i_3 
       (.I0(sps_eff13_in),
        .I1(\sps_eff[5]_i_3_n_0 ),
        .I2(\sps_eff_reg[7]_0 [5]),
        .I3(\sps_eff_reg[7]_0 [6]),
        .O(\sps_eff[6]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \sps_eff[7]_i_1 
       (.I0(dump_strobe0),
        .I1(adc_valid_d1),
        .I2(core_enable),
        .O(\sps_eff[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAA2AAAAAA)) 
    \sps_eff[7]_i_2 
       (.I0(\sps_eff_reg[7]_0 [7]),
        .I1(sps_eff13_in),
        .I2(core_bypass_timing),
        .I3(sps_eff1),
        .I4(\sps_eff[7]_i_3_n_0 ),
        .I5(\sps_eff_reg[7]_0 [6]),
        .O(\sps_eff[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \sps_eff[7]_i_3 
       (.I0(\sps_eff_reg[7]_0 [5]),
        .I1(\sps_eff_reg[7]_0 [0]),
        .I2(\sps_eff_reg[7]_0 [1]),
        .I3(\sps_eff_reg[7]_0 [2]),
        .I4(\sps_eff_reg[7]_0 [3]),
        .I5(\sps_eff_reg[7]_0 [4]),
        .O(\sps_eff[7]_i_3_n_0 ));
  FDCE \sps_eff_reg[0] 
       (.C(aclk),
        .CE(\sps_eff[7]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\sps_eff[0]_i_1_n_0 ),
        .Q(sps_eff[0]));
  FDCE \sps_eff_reg[1] 
       (.C(aclk),
        .CE(\sps_eff[7]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\sps_eff[1]_i_1_n_0 ),
        .Q(sps_eff[1]));
  FDCE \sps_eff_reg[2] 
       (.C(aclk),
        .CE(\sps_eff[7]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\sps_eff[2]_i_1_n_0 ),
        .Q(sps_eff[2]));
  FDPE \sps_eff_reg[3] 
       (.C(aclk),
        .CE(\sps_eff[7]_i_1_n_0 ),
        .D(\sps_eff[3]_i_1_n_0 ),
        .PRE(aresetn_0),
        .Q(sps_eff[3]));
  FDCE \sps_eff_reg[4] 
       (.C(aclk),
        .CE(\sps_eff[7]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\sps_eff[4]_i_1_n_0 ),
        .Q(sps_eff[4]));
  FDCE \sps_eff_reg[5] 
       (.C(aclk),
        .CE(\sps_eff[7]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\sps_eff[5]_i_1_n_0 ),
        .Q(sps_eff[5]));
  FDCE \sps_eff_reg[6] 
       (.C(aclk),
        .CE(\sps_eff[7]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\sps_eff[6]_i_1_n_0 ),
        .Q(sps_eff[6]));
  FDCE \sps_eff_reg[7] 
       (.C(aclk),
        .CE(\sps_eff[7]_i_1_n_0 ),
        .CLR(aresetn_0),
        .D(\sps_eff[7]_i_2_n_0 ),
        .Q(sps_eff[7]));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-13 {cell *THIS*}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(0),
    .BREG(0),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    timing_adj2
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,timing_adj2_0}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_timing_adj2_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({timing_err_out[15],timing_err_out[15],timing_err_out}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_timing_adj2_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_timing_adj2_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_timing_adj2_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CLK(1'b0),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_timing_adj2_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_timing_adj2_OVERFLOW_UNCONNECTED),
        .P({NLW_timing_adj2_P_UNCONNECTED[47:33],timing_adj2_n_73,timing_adj2_n_74,timing_adj2_n_75,timing_adj2_n_76,timing_adj2_n_77,timing_adj2_n_78,timing_adj2_n_79,timing_adj2_n_80,timing_adj2_n_81,timing_adj2_n_82,timing_adj2_n_83,timing_adj2_n_84,timing_adj2_n_85,timing_adj2_n_86,timing_adj2_n_87,timing_adj2_n_88,timing_adj10,timing_adj2_n_90,timing_adj2_n_91,timing_adj2_n_92,timing_adj2_n_93,timing_adj2_n_94,timing_adj2_n_95,timing_adj2_n_96,timing_adj2_n_97,timing_adj2_n_98,timing_adj2_n_99,timing_adj2_n_100,timing_adj2_n_101,timing_adj2_n_102,timing_adj2_n_103,timing_adj2_n_104,timing_adj2_n_105}),
        .PATTERNBDETECT(NLW_timing_adj2_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_timing_adj2_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_timing_adj2_PCOUT_UNCONNECTED[47:0]),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_timing_adj2_UNDERFLOW_UNCONNECTED));
  LUT2 #(
    .INIT(4'h8)) 
    \timing_adj[11]_i_2 
       (.I0(timing_int0_n_79),
        .I1(OPMODE),
        .O(\timing_adj[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \timing_adj[11]_i_3 
       (.I0(timing_int0_n_80),
        .I1(OPMODE),
        .O(\timing_adj[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \timing_adj[11]_i_4 
       (.I0(timing_int0_n_81),
        .I1(OPMODE),
        .O(\timing_adj[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \timing_adj[11]_i_5 
       (.I0(OPMODE),
        .I1(timing_int0_n_81),
        .O(\timing_adj[11]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'hB7)) 
    \timing_adj[11]_i_6 
       (.I0(timing_int0_n_79),
        .I1(OPMODE),
        .I2(timing_int0_n_78),
        .O(\timing_adj[11]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'hB7)) 
    \timing_adj[11]_i_7 
       (.I0(timing_int0_n_80),
        .I1(OPMODE),
        .I2(timing_int0_n_79),
        .O(\timing_adj[11]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'hB7)) 
    \timing_adj[11]_i_8 
       (.I0(timing_int0_n_81),
        .I1(OPMODE),
        .I2(timing_int0_n_80),
        .O(\timing_adj[11]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \timing_adj[11]_i_9 
       (.I0(OPMODE),
        .I1(timing_int0_n_81),
        .I2(timing_adj10),
        .O(\timing_adj[11]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \timing_adj[15]_i_2 
       (.I0(timing_int0_n_76),
        .I1(OPMODE),
        .O(\timing_adj[15]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \timing_adj[15]_i_3 
       (.I0(timing_int0_n_77),
        .I1(OPMODE),
        .O(\timing_adj[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \timing_adj[15]_i_4 
       (.I0(timing_int0_n_78),
        .I1(OPMODE),
        .O(\timing_adj[15]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'hB7)) 
    \timing_adj[15]_i_5 
       (.I0(timing_int0_n_75),
        .I1(OPMODE),
        .I2(timing_int0_n_74),
        .O(\timing_adj[15]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'hB7)) 
    \timing_adj[15]_i_6 
       (.I0(timing_int0_n_76),
        .I1(OPMODE),
        .I2(timing_int0_n_75),
        .O(\timing_adj[15]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'hB7)) 
    \timing_adj[15]_i_7 
       (.I0(timing_int0_n_77),
        .I1(OPMODE),
        .I2(timing_int0_n_76),
        .O(\timing_adj[15]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'hB7)) 
    \timing_adj[15]_i_8 
       (.I0(timing_int0_n_78),
        .I1(OPMODE),
        .I2(timing_int0_n_77),
        .O(\timing_adj[15]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h6A)) 
    \timing_adj[3]_i_2 
       (.I0(timing_adj2_n_94),
        .I1(OPMODE),
        .I2(timing_int0_n_86),
        .O(\timing_adj[3]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h6A)) 
    \timing_adj[3]_i_3 
       (.I0(timing_adj2_n_95),
        .I1(OPMODE),
        .I2(timing_int0_n_87),
        .O(\timing_adj[3]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h6A)) 
    \timing_adj[3]_i_4 
       (.I0(timing_adj2_n_96),
        .I1(OPMODE),
        .I2(timing_int0_n_88),
        .O(\timing_adj[3]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h6A)) 
    \timing_adj[3]_i_5 
       (.I0(timing_adj2_n_97),
        .I1(OPMODE),
        .I2(timing_int0_n_89),
        .O(\timing_adj[3]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h6A)) 
    \timing_adj[7]_i_2 
       (.I0(timing_adj2_n_90),
        .I1(OPMODE),
        .I2(timing_int0_n_82),
        .O(\timing_adj[7]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h6A)) 
    \timing_adj[7]_i_3 
       (.I0(timing_adj2_n_91),
        .I1(OPMODE),
        .I2(timing_int0_n_83),
        .O(\timing_adj[7]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h6A)) 
    \timing_adj[7]_i_4 
       (.I0(timing_adj2_n_92),
        .I1(OPMODE),
        .I2(timing_int0_n_84),
        .O(\timing_adj[7]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h6A)) 
    \timing_adj[7]_i_5 
       (.I0(timing_adj2_n_93),
        .I1(OPMODE),
        .I2(timing_int0_n_85),
        .O(\timing_adj[7]_i_5_n_0 ));
  FDCE \timing_adj_reg[0] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[3]_i_1_n_7 ),
        .Q(timing_adj[0]));
  FDCE \timing_adj_reg[10] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[11]_i_1_n_5 ),
        .Q(timing_adj[10]));
  FDCE \timing_adj_reg[11] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[11]_i_1_n_4 ),
        .Q(timing_adj[11]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \timing_adj_reg[11]_i_1 
       (.CI(\timing_adj_reg[7]_i_1_n_0 ),
        .CO({\timing_adj_reg[11]_i_1_n_0 ,\timing_adj_reg[11]_i_1_n_1 ,\timing_adj_reg[11]_i_1_n_2 ,\timing_adj_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\timing_adj[11]_i_2_n_0 ,\timing_adj[11]_i_3_n_0 ,\timing_adj[11]_i_4_n_0 ,\timing_adj[11]_i_5_n_0 }),
        .O({\timing_adj_reg[11]_i_1_n_4 ,\timing_adj_reg[11]_i_1_n_5 ,\timing_adj_reg[11]_i_1_n_6 ,\timing_adj_reg[11]_i_1_n_7 }),
        .S({\timing_adj[11]_i_6_n_0 ,\timing_adj[11]_i_7_n_0 ,\timing_adj[11]_i_8_n_0 ,\timing_adj[11]_i_9_n_0 }));
  FDCE \timing_adj_reg[12] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[15]_i_1_n_7 ),
        .Q(timing_adj[12]));
  FDCE \timing_adj_reg[13] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[15]_i_1_n_6 ),
        .Q(timing_adj[13]));
  FDCE \timing_adj_reg[14] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[15]_i_1_n_5 ),
        .Q(timing_adj[14]));
  FDCE \timing_adj_reg[15] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[15]_i_1_n_4 ),
        .Q(timing_adj[15]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \timing_adj_reg[15]_i_1 
       (.CI(\timing_adj_reg[11]_i_1_n_0 ),
        .CO({\NLW_timing_adj_reg[15]_i_1_CO_UNCONNECTED [3],\timing_adj_reg[15]_i_1_n_1 ,\timing_adj_reg[15]_i_1_n_2 ,\timing_adj_reg[15]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\timing_adj[15]_i_2_n_0 ,\timing_adj[15]_i_3_n_0 ,\timing_adj[15]_i_4_n_0 }),
        .O({\timing_adj_reg[15]_i_1_n_4 ,\timing_adj_reg[15]_i_1_n_5 ,\timing_adj_reg[15]_i_1_n_6 ,\timing_adj_reg[15]_i_1_n_7 }),
        .S({\timing_adj[15]_i_5_n_0 ,\timing_adj[15]_i_6_n_0 ,\timing_adj[15]_i_7_n_0 ,\timing_adj[15]_i_8_n_0 }));
  FDCE \timing_adj_reg[1] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[3]_i_1_n_6 ),
        .Q(timing_adj[1]));
  FDCE \timing_adj_reg[2] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[3]_i_1_n_5 ),
        .Q(timing_adj[2]));
  FDCE \timing_adj_reg[3] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[3]_i_1_n_4 ),
        .Q(timing_adj[3]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \timing_adj_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\timing_adj_reg[3]_i_1_n_0 ,\timing_adj_reg[3]_i_1_n_1 ,\timing_adj_reg[3]_i_1_n_2 ,\timing_adj_reg[3]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({timing_adj2_n_94,timing_adj2_n_95,timing_adj2_n_96,timing_adj2_n_97}),
        .O({\timing_adj_reg[3]_i_1_n_4 ,\timing_adj_reg[3]_i_1_n_5 ,\timing_adj_reg[3]_i_1_n_6 ,\timing_adj_reg[3]_i_1_n_7 }),
        .S({\timing_adj[3]_i_2_n_0 ,\timing_adj[3]_i_3_n_0 ,\timing_adj[3]_i_4_n_0 ,\timing_adj[3]_i_5_n_0 }));
  FDCE \timing_adj_reg[4] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[7]_i_1_n_7 ),
        .Q(timing_adj[4]));
  FDCE \timing_adj_reg[5] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[7]_i_1_n_6 ),
        .Q(timing_adj[5]));
  FDCE \timing_adj_reg[6] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[7]_i_1_n_5 ),
        .Q(timing_adj[6]));
  FDCE \timing_adj_reg[7] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[7]_i_1_n_4 ),
        .Q(timing_adj[7]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \timing_adj_reg[7]_i_1 
       (.CI(\timing_adj_reg[3]_i_1_n_0 ),
        .CO({\timing_adj_reg[7]_i_1_n_0 ,\timing_adj_reg[7]_i_1_n_1 ,\timing_adj_reg[7]_i_1_n_2 ,\timing_adj_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({timing_adj2_n_90,timing_adj2_n_91,timing_adj2_n_92,timing_adj2_n_93}),
        .O({\timing_adj_reg[7]_i_1_n_4 ,\timing_adj_reg[7]_i_1_n_5 ,\timing_adj_reg[7]_i_1_n_6 ,\timing_adj_reg[7]_i_1_n_7 }),
        .S({\timing_adj[7]_i_2_n_0 ,\timing_adj[7]_i_3_n_0 ,\timing_adj[7]_i_4_n_0 ,\timing_adj[7]_i_5_n_0 }));
  FDCE \timing_adj_reg[8] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[11]_i_1_n_7 ),
        .Q(timing_adj[8]));
  FDCE \timing_adj_reg[9] 
       (.C(aclk),
        .CE(E),
        .CLR(aresetn_0),
        .D(\timing_adj_reg[11]_i_1_n_6 ),
        .Q(timing_adj[9]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 timing_err__0_carry
       (.CI(1'b0),
        .CO({timing_err__0_carry_n_0,timing_err__0_carry_n_1,timing_err__0_carry_n_2,timing_err__0_carry_n_3}),
        .CYINIT(1'b0),
        .DI({timing_err__0_carry_i_1_n_0,timing_err__0_carry_i_2_n_0,timing_err__0_carry_i_3_n_0,p_1_in0}),
        .O(timing_err_out[3:0]),
        .S({timing_err__0_carry_i_4_n_0,timing_err__0_carry_i_5_n_0,timing_err__0_carry_i_6_n_0,timing_err__0_carry_i_7_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 timing_err__0_carry__0
       (.CI(timing_err__0_carry_n_0),
        .CO({timing_err__0_carry__0_n_0,timing_err__0_carry__0_n_1,timing_err__0_carry__0_n_2,timing_err__0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({timing_err__0_carry__0_i_1_n_0,timing_err__0_carry__0_i_2_n_0,timing_err__0_carry__0_i_3_n_0,timing_err__0_carry__0_i_4_n_0}),
        .O(timing_err_out[7:4]),
        .S({timing_err__0_carry__0_i_5_n_0,timing_err__0_carry__0_i_6_n_0,timing_err__0_carry__0_i_7_n_0,timing_err__0_carry__0_i_8_n_0}));
  (* HLUTNM = "lutpair6" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry__0_i_1
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[12] ),
        .I2(i_dump_prev[6]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__0_i_1_n_0));
  (* HLUTNM = "lutpair5" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry__0_i_2
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[11] ),
        .I2(i_dump_prev[5]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__0_i_2_n_0));
  (* HLUTNM = "lutpair4" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry__0_i_3
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[10] ),
        .I2(i_dump_prev[4]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__0_i_3_n_0));
  (* HLUTNM = "lutpair3" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry__0_i_4
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[9] ),
        .I2(i_dump_prev[3]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__0_i_4_n_0));
  (* HLUTNM = "lutpair7" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry__0_i_5
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[13] ),
        .I2(i_dump_prev[7]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry__0_i_1_n_0),
        .O(timing_err__0_carry__0_i_5_n_0));
  (* HLUTNM = "lutpair6" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry__0_i_6
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[12] ),
        .I2(i_dump_prev[6]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry__0_i_2_n_0),
        .O(timing_err__0_carry__0_i_6_n_0));
  (* HLUTNM = "lutpair5" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry__0_i_7
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[11] ),
        .I2(i_dump_prev[5]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry__0_i_3_n_0),
        .O(timing_err__0_carry__0_i_7_n_0));
  (* HLUTNM = "lutpair4" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry__0_i_8
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[10] ),
        .I2(i_dump_prev[4]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry__0_i_4_n_0),
        .O(timing_err__0_carry__0_i_8_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 timing_err__0_carry__1
       (.CI(timing_err__0_carry__0_n_0),
        .CO({timing_err__0_carry__1_n_0,timing_err__0_carry__1_n_1,timing_err__0_carry__1_n_2,timing_err__0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({timing_err__0_carry__1_i_1_n_0,timing_err__0_carry__1_i_2_n_0,timing_err__0_carry__1_i_3_n_0,timing_err__0_carry__1_i_4_n_0}),
        .O(timing_err_out[11:8]),
        .S({timing_err__0_carry__1_i_5_n_0,timing_err__0_carry__1_i_6_n_0,timing_err__0_carry__1_i_7_n_0,timing_err__0_carry__1_i_8_n_0}));
  (* HLUTNM = "lutpair10" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry__1_i_1
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[16] ),
        .I2(i_dump_prev[10]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__1_i_1_n_0));
  (* HLUTNM = "lutpair9" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry__1_i_2
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[15] ),
        .I2(i_dump_prev[9]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__1_i_2_n_0));
  (* HLUTNM = "lutpair8" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry__1_i_3
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[14] ),
        .I2(i_dump_prev[8]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__1_i_3_n_0));
  (* HLUTNM = "lutpair7" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry__1_i_4
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[13] ),
        .I2(i_dump_prev[7]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__1_i_4_n_0));
  (* HLUTNM = "lutpair11" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry__1_i_5
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[17] ),
        .I2(i_dump_prev[11]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry__1_i_1_n_0),
        .O(timing_err__0_carry__1_i_5_n_0));
  (* HLUTNM = "lutpair10" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry__1_i_6
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[16] ),
        .I2(i_dump_prev[10]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry__1_i_2_n_0),
        .O(timing_err__0_carry__1_i_6_n_0));
  (* HLUTNM = "lutpair9" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry__1_i_7
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[15] ),
        .I2(i_dump_prev[9]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry__1_i_3_n_0),
        .O(timing_err__0_carry__1_i_7_n_0));
  (* HLUTNM = "lutpair8" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry__1_i_8
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[14] ),
        .I2(i_dump_prev[8]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry__1_i_4_n_0),
        .O(timing_err__0_carry__1_i_8_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 timing_err__0_carry__2
       (.CI(timing_err__0_carry__1_n_0),
        .CO({NLW_timing_err__0_carry__2_CO_UNCONNECTED[3],timing_err__0_carry__2_n_1,timing_err__0_carry__2_n_2,timing_err__0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,timing_err__0_carry__2_i_1_n_0,timing_err__0_carry__2_i_2_n_0,timing_err__0_carry__2_i_3_n_0}),
        .O(timing_err_out[15:12]),
        .S({timing_err__0_carry__2_i_4_n_0,timing_err__0_carry__2_i_5_n_0,timing_err__0_carry__2_i_6_n_0,timing_err__0_carry__2_i_7_n_0}));
  (* HLUTNM = "lutpair13" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry__2_i_1
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[19] ),
        .I2(i_dump_prev[13]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__2_i_1_n_0));
  (* HLUTNM = "lutpair12" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry__2_i_2
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[18] ),
        .I2(i_dump_prev[12]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__2_i_2_n_0));
  (* HLUTNM = "lutpair11" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry__2_i_3
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[17] ),
        .I2(i_dump_prev[11]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__2_i_3_n_0));
  LUT4 #(
    .INIT(16'hF66F)) 
    timing_err__0_carry__2_i_4
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[20] ),
        .I2(i_dump_prev[14]),
        .I3(p_1_in0),
        .O(timing_err__0_carry__2_i_4_n_0));
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry__2_i_5
       (.I0(timing_err__0_carry__2_i_1_n_0),
        .I1(p_1_in0),
        .I2(i_dump_prev[14]),
        .I3(\integrate_acc_reg_n_0_[20] ),
        .I4(i_prev_sign),
        .O(timing_err__0_carry__2_i_5_n_0));
  (* HLUTNM = "lutpair13" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry__2_i_6
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[19] ),
        .I2(i_dump_prev[13]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry__2_i_2_n_0),
        .O(timing_err__0_carry__2_i_6_n_0));
  (* HLUTNM = "lutpair12" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry__2_i_7
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[18] ),
        .I2(i_dump_prev[12]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry__2_i_3_n_0),
        .O(timing_err__0_carry__2_i_7_n_0));
  (* HLUTNM = "lutpair2" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry_i_1
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[8] ),
        .I2(i_dump_prev[2]),
        .I3(p_1_in0),
        .O(timing_err__0_carry_i_1_n_0));
  (* HLUTNM = "lutpair1" *) 
  LUT4 #(
    .INIT(16'h0990)) 
    timing_err__0_carry_i_2
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[7] ),
        .I2(i_dump_prev[1]),
        .I3(p_1_in0),
        .O(timing_err__0_carry_i_2_n_0));
  (* HLUTNM = "lutpair0" *) 
  LUT4 #(
    .INIT(16'h606F)) 
    timing_err__0_carry_i_3
       (.I0(p_1_in0),
        .I1(i_dump_prev[0]),
        .I2(\integrate_acc_reg_n_0_[6] ),
        .I3(i_prev_sign),
        .O(timing_err__0_carry_i_3_n_0));
  (* HLUTNM = "lutpair3" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry_i_4
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[9] ),
        .I2(i_dump_prev[3]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry_i_1_n_0),
        .O(timing_err__0_carry_i_4_n_0));
  (* HLUTNM = "lutpair2" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry_i_5
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[8] ),
        .I2(i_dump_prev[2]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry_i_2_n_0),
        .O(timing_err__0_carry_i_5_n_0));
  (* HLUTNM = "lutpair1" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    timing_err__0_carry_i_6
       (.I0(i_prev_sign),
        .I1(\integrate_acc_reg_n_0_[7] ),
        .I2(i_dump_prev[1]),
        .I3(p_1_in0),
        .I4(timing_err__0_carry_i_3_n_0),
        .O(timing_err__0_carry_i_6_n_0));
  (* HLUTNM = "lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    timing_err__0_carry_i_7
       (.I0(i_dump_prev[0]),
        .I1(\integrate_acc_reg_n_0_[6] ),
        .O(timing_err__0_carry_i_7_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-12 {cell *THIS*}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(0),
    .BREG(0),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(0),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(1),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    timing_int0
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,timing_int0_0}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_timing_int0_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({timing_err_out[15],timing_err_out[15],timing_err_out}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_timing_int0_BCOUT_UNCONNECTED[17:0]),
        .C({timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_74,timing_int0_n_75,timing_int0_n_76,timing_int0_n_77,timing_int0_n_78,timing_int0_n_79,timing_int0_n_80,timing_int0_n_81,timing_int0_n_82,timing_int0_n_83,timing_int0_n_84,timing_int0_n_85,timing_int0_n_86,timing_int0_n_87,timing_int0_n_88,timing_int0_n_89,timing_int0_n_90,timing_int0_n_91,timing_int0_n_92,timing_int0_n_93,timing_int0_n_94,timing_int0_n_95,timing_int0_n_96,timing_int0_n_97,timing_int0_n_98,timing_int0_n_99,timing_int0_n_100,timing_int0_n_101,timing_int0_n_102,timing_int0_n_103,timing_int0_n_104,timing_int0_n_105}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_timing_int0_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_timing_int0_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(E),
        .CLK(aclk),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_timing_int0_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,OPMODE,OPMODE,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_timing_int0_OVERFLOW_UNCONNECTED),
        .P({NLW_timing_int0_P_UNCONNECTED[47:32],timing_int0_n_74,timing_int0_n_75,timing_int0_n_76,timing_int0_n_77,timing_int0_n_78,timing_int0_n_79,timing_int0_n_80,timing_int0_n_81,timing_int0_n_82,timing_int0_n_83,timing_int0_n_84,timing_int0_n_85,timing_int0_n_86,timing_int0_n_87,timing_int0_n_88,timing_int0_n_89,timing_int0_n_90,timing_int0_n_91,timing_int0_n_92,timing_int0_n_93,timing_int0_n_94,timing_int0_n_95,timing_int0_n_96,timing_int0_n_97,timing_int0_n_98,timing_int0_n_99,timing_int0_n_100,timing_int0_n_101,timing_int0_n_102,timing_int0_n_103,timing_int0_n_104,timing_int0_n_105}),
        .PATTERNBDETECT(NLW_timing_int0_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_timing_int0_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_timing_int0_PCOUT_UNCONNECTED[47:0]),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_timing_int0_UNDERFLOW_UNCONNECTED));
  LUT4 #(
    .INIT(16'h4000)) 
    timing_int0_i_1
       (.I0(core_bypass_timing),
        .I1(core_enable),
        .I2(adc_valid_d1),
        .I3(dump_strobe0),
        .O(E));
  system_bpsk_demodulator_0_0_bpsk_demod_agc u_agc
       (.D(D),
        .DI({\q_mix[3]_i_2_n_0 ,\q_mix[3]_i_3_n_0 ,\q_mix[3]_i_4_n_0 ,\q_mix[3]_i_5_n_0 }),
        .E(adc_valid_d10),
        .P(mix_qi__0[15]),
        .Q(agc_gain_out),
        .aclk(aclk),
        .adc_data(adc_data),
        .adc_valid(adc_valid),
        .aresetn(aresetn),
        .aresetn_0(aresetn_0),
        .core_bypass_agc(core_bypass_agc),
        .core_bypass_costas(core_bypass_costas),
        .core_bypass_costas_reg({u_agc_n_18,u_agc_n_19,u_agc_n_20,u_agc_n_21,u_agc_n_22,u_agc_n_23,u_agc_n_24,u_agc_n_25,u_agc_n_26,u_agc_n_27,u_agc_n_28,u_agc_n_29,u_agc_n_30,u_agc_n_31,u_agc_n_32,u_agc_n_33}),
        .core_enable(core_enable),
        .\gain_acc[11]_i_3_0 (\gain_acc[11]_i_3 ),
        .\gain_acc[11]_i_8_0 (Q),
        .\i_mix_reg[11] ({\i_mix[11]_i_2_n_0 ,\i_mix[11]_i_3_n_0 ,\i_mix[11]_i_4_n_0 ,\i_mix[11]_i_5_n_0 }),
        .\i_mix_reg[15] ({\i_mix[15]_i_2_n_0 ,\i_mix[15]_i_3_n_0 ,\i_mix[15]_i_4_n_0 }),
        .\i_mix_reg[15]_0 (B_0),
        .\i_mix_reg[15]_1 (A),
        .\i_mix_reg[3] ({\i_mix[3]_i_2_n_0 ,\i_mix[3]_i_3_n_0 ,\i_mix[3]_i_4_n_0 ,\i_mix[3]_i_5_n_0 }),
        .\i_mix_reg[7] ({\i_mix[7]_i_2_n_0 ,\i_mix[7]_i_3_n_0 ,\i_mix[7]_i_4_n_0 ,\i_mix[7]_i_5_n_0 }),
        .\i_out_reg[15]_0 (i_out),
        .out({u_agc_n_67,u_agc_n_68,u_agc_n_69,u_agc_n_70,u_agc_n_71,u_agc_n_72,u_agc_n_73,u_agc_n_74,u_agc_n_75,u_agc_n_76,u_agc_n_77,u_agc_n_78,u_agc_n_79,u_agc_n_80,u_agc_n_81,u_agc_n_82}),
        .p_1_out({\q_mix_reg[15]_i_9_n_5 ,\q_mix_reg[15]_i_9_n_6 ,\q_mix_reg[15]_i_9_n_7 ,\q_mix_reg[15]_i_10_n_4 ,\q_mix_reg[15]_i_10_n_5 ,\q_mix_reg[15]_i_10_n_6 ,\q_mix_reg[15]_i_10_n_7 ,\q_mix_reg[11]_i_10_n_4 ,\q_mix_reg[11]_i_10_n_5 ,\q_mix_reg[11]_i_10_n_6 ,\q_mix_reg[11]_i_10_n_7 ,\q_mix_reg[7]_i_10_n_4 ,\q_mix_reg[7]_i_10_n_5 ,\q_mix_reg[7]_i_10_n_6 ,\q_mix_reg[7]_i_10_n_7 }),
        .\q_mix_reg[11] ({\q_mix[11]_i_2_n_0 ,\q_mix[11]_i_3_n_0 ,\q_mix[11]_i_4_n_0 ,\q_mix[11]_i_5_n_0 }),
        .\q_mix_reg[15] ({\q_mix[15]_i_2_n_0 ,\q_mix[15]_i_3_n_0 ,\q_mix[15]_i_4_n_0 }),
        .\q_mix_reg[15]_0 (mix_qq__0),
        .\q_mix_reg[7] ({\q_mix[7]_i_2_n_0 ,\q_mix[7]_i_3_n_0 ,\q_mix[7]_i_4_n_0 ,\q_mix[7]_i_5_n_0 }),
        .\q_out_reg[15]_0 (q_out));
  system_bpsk_demodulator_0_0_bpsk_demod_nco u_nco
       (.D({\p_0_out_inferred__0/sin_out[15]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[14]_i_1_n_0 ,\p_0_out_inferred__0/sin_out[13]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[12]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[11]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[10]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[9]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[8]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[7]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[6]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[5]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[4]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[3]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[2]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[1]_i_1_n_0 ,\p_0_out_inferred__0/sin_out_reg[0]_i_1_n_0 }),
        .E(adc_valid_d10),
        .Q(sel),
        .aclk(aclk),
        .\cos_out_reg[15]_0 (out),
        .\cos_out_reg[15]_1 (p_0_out),
        .\phase_acc_reg[27]_0 (u_nco_n_0),
        .\phase_acc_reg[27]_1 (u_nco_n_9),
        .\phase_acc_reg[27]_2 (u_nco_n_10),
        .\phase_acc_reg[27]_3 (u_nco_n_11),
        .\phase_acc_reg[27]_4 (u_nco_n_12),
        .\phase_acc_reg[27]_5 (u_nco_n_13),
        .\phase_acc_reg[27]_6 (u_nco_n_14),
        .\phase_acc_reg[27]_7 (u_nco_n_15),
        .\phase_acc_reg[27]_8 (u_nco_n_16),
        .\phase_acc_reg[27]_9 (u_nco_n_17),
        .\phase_acc_reg[31]_0 (aresetn_0),
        .\phase_acc_reg[31]_1 (freq_word),
        .\sin_out_reg[15]_0 ({u_nco_n_18,u_nco_n_19,u_nco_n_20,u_nco_n_21,u_nco_n_22,u_nco_n_23,u_nco_n_24,u_nco_n_25,u_nco_n_26,u_nco_n_27,u_nco_n_28,u_nco_n_29,u_nco_n_30,u_nco_n_31,u_nco_n_32,u_nco_n_33}));
endmodule

(* ORIG_REF_NAME = "bpsk_demod_nco" *) 
module system_bpsk_demodulator_0_0_bpsk_demod_nco
   (\phase_acc_reg[27]_0 ,
    Q,
    \phase_acc_reg[27]_1 ,
    \phase_acc_reg[27]_2 ,
    \phase_acc_reg[27]_3 ,
    \phase_acc_reg[27]_4 ,
    \phase_acc_reg[27]_5 ,
    \phase_acc_reg[27]_6 ,
    \phase_acc_reg[27]_7 ,
    \phase_acc_reg[27]_8 ,
    \phase_acc_reg[27]_9 ,
    \sin_out_reg[15]_0 ,
    \cos_out_reg[15]_0 ,
    D,
    aclk,
    \phase_acc_reg[31]_0 ,
    \phase_acc_reg[31]_1 ,
    E,
    \cos_out_reg[15]_1 );
  output \phase_acc_reg[27]_0 ;
  output [7:0]Q;
  output \phase_acc_reg[27]_1 ;
  output \phase_acc_reg[27]_2 ;
  output \phase_acc_reg[27]_3 ;
  output \phase_acc_reg[27]_4 ;
  output \phase_acc_reg[27]_5 ;
  output \phase_acc_reg[27]_6 ;
  output \phase_acc_reg[27]_7 ;
  output \phase_acc_reg[27]_8 ;
  output \phase_acc_reg[27]_9 ;
  output [15:0]\sin_out_reg[15]_0 ;
  output [15:0]\cos_out_reg[15]_0 ;
  input [15:0]D;
  input aclk;
  input \phase_acc_reg[31]_0 ;
  input [27:0]\phase_acc_reg[31]_1 ;
  input [0:0]E;
  input [15:0]\cos_out_reg[15]_1 ;

  wire [15:0]D;
  wire [0:0]E;
  wire [7:0]Q;
  wire aclk;
  wire [15:0]\cos_out_reg[15]_0 ;
  wire [15:0]\cos_out_reg[15]_1 ;
  wire [31:4]phase_acc0_dspDelayedAccum;
  wire \phase_acc[11]_i_2_n_0 ;
  wire \phase_acc[11]_i_3_n_0 ;
  wire \phase_acc[11]_i_4_n_0 ;
  wire \phase_acc[11]_i_5_n_0 ;
  wire \phase_acc[15]_i_2_n_0 ;
  wire \phase_acc[15]_i_3_n_0 ;
  wire \phase_acc[15]_i_4_n_0 ;
  wire \phase_acc[15]_i_5_n_0 ;
  wire \phase_acc[19]_i_2_n_0 ;
  wire \phase_acc[19]_i_3_n_0 ;
  wire \phase_acc[19]_i_4_n_0 ;
  wire \phase_acc[19]_i_5_n_0 ;
  wire \phase_acc[23]_i_2_n_0 ;
  wire \phase_acc[23]_i_3_n_0 ;
  wire \phase_acc[23]_i_4_n_0 ;
  wire \phase_acc[23]_i_5_n_0 ;
  wire \phase_acc[27]_i_2_n_0 ;
  wire \phase_acc[27]_i_3_n_0 ;
  wire \phase_acc[27]_i_4_n_0 ;
  wire \phase_acc[27]_i_5_n_0 ;
  wire \phase_acc[31]_i_2_n_0 ;
  wire \phase_acc[31]_i_3_n_0 ;
  wire \phase_acc[31]_i_4_n_0 ;
  wire \phase_acc[31]_i_5_n_0 ;
  wire \phase_acc[7]_i_2_n_0 ;
  wire \phase_acc[7]_i_3_n_0 ;
  wire \phase_acc[7]_i_4_n_0 ;
  wire \phase_acc[7]_i_5_n_0 ;
  wire \phase_acc_reg[11]_i_1_n_0 ;
  wire \phase_acc_reg[11]_i_1_n_1 ;
  wire \phase_acc_reg[11]_i_1_n_2 ;
  wire \phase_acc_reg[11]_i_1_n_3 ;
  wire \phase_acc_reg[15]_i_1_n_0 ;
  wire \phase_acc_reg[15]_i_1_n_1 ;
  wire \phase_acc_reg[15]_i_1_n_2 ;
  wire \phase_acc_reg[15]_i_1_n_3 ;
  wire \phase_acc_reg[19]_i_1_n_0 ;
  wire \phase_acc_reg[19]_i_1_n_1 ;
  wire \phase_acc_reg[19]_i_1_n_2 ;
  wire \phase_acc_reg[19]_i_1_n_3 ;
  wire \phase_acc_reg[23]_i_1_n_0 ;
  wire \phase_acc_reg[23]_i_1_n_1 ;
  wire \phase_acc_reg[23]_i_1_n_2 ;
  wire \phase_acc_reg[23]_i_1_n_3 ;
  wire \phase_acc_reg[27]_0 ;
  wire \phase_acc_reg[27]_1 ;
  wire \phase_acc_reg[27]_2 ;
  wire \phase_acc_reg[27]_3 ;
  wire \phase_acc_reg[27]_4 ;
  wire \phase_acc_reg[27]_5 ;
  wire \phase_acc_reg[27]_6 ;
  wire \phase_acc_reg[27]_7 ;
  wire \phase_acc_reg[27]_8 ;
  wire \phase_acc_reg[27]_9 ;
  wire \phase_acc_reg[27]_i_1_n_0 ;
  wire \phase_acc_reg[27]_i_1_n_1 ;
  wire \phase_acc_reg[27]_i_1_n_2 ;
  wire \phase_acc_reg[27]_i_1_n_3 ;
  wire \phase_acc_reg[31]_0 ;
  wire [27:0]\phase_acc_reg[31]_1 ;
  wire \phase_acc_reg[31]_i_1_n_1 ;
  wire \phase_acc_reg[31]_i_1_n_2 ;
  wire \phase_acc_reg[31]_i_1_n_3 ;
  wire \phase_acc_reg[7]_i_1_n_0 ;
  wire \phase_acc_reg[7]_i_1_n_1 ;
  wire \phase_acc_reg[7]_i_1_n_2 ;
  wire \phase_acc_reg[7]_i_1_n_3 ;
  wire \phase_acc_reg_n_0_[10] ;
  wire \phase_acc_reg_n_0_[11] ;
  wire \phase_acc_reg_n_0_[12] ;
  wire \phase_acc_reg_n_0_[13] ;
  wire \phase_acc_reg_n_0_[14] ;
  wire \phase_acc_reg_n_0_[15] ;
  wire \phase_acc_reg_n_0_[16] ;
  wire \phase_acc_reg_n_0_[17] ;
  wire \phase_acc_reg_n_0_[18] ;
  wire \phase_acc_reg_n_0_[19] ;
  wire \phase_acc_reg_n_0_[20] ;
  wire \phase_acc_reg_n_0_[21] ;
  wire \phase_acc_reg_n_0_[22] ;
  wire \phase_acc_reg_n_0_[23] ;
  wire \phase_acc_reg_n_0_[4] ;
  wire \phase_acc_reg_n_0_[5] ;
  wire \phase_acc_reg_n_0_[6] ;
  wire \phase_acc_reg_n_0_[7] ;
  wire \phase_acc_reg_n_0_[8] ;
  wire \phase_acc_reg_n_0_[9] ;
  wire [15:0]\sin_out_reg[15]_0 ;
  wire [3:3]\NLW_phase_acc_reg[31]_i_1_CO_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h05BA28A0FA45D75F)) 
    \cos_out[10]_i_4 
       (.I0(Q[3]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(Q[4]),
        .I5(Q[7]),
        .O(\phase_acc_reg[27]_1 ));
  LUT6 #(
    .INIT(64'hB50E4AF1E11D1EE2)) 
    \cos_out[10]_i_5 
       (.I0(Q[3]),
        .I1(Q[4]),
        .I2(Q[2]),
        .I3(Q[0]),
        .I4(Q[7]),
        .I5(Q[1]),
        .O(\phase_acc_reg[27]_2 ));
  LUT6 #(
    .INIT(64'h5EAA0000A155FFFF)) 
    \cos_out[12]_i_4 
       (.I0(Q[3]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[2]),
        .I4(Q[4]),
        .I5(Q[7]),
        .O(\phase_acc_reg[27]_0 ));
  LUT6 #(
    .INIT(64'h16F9E90674028BF9)) 
    \cos_out[5]_i_4 
       (.I0(Q[3]),
        .I1(Q[4]),
        .I2(Q[2]),
        .I3(Q[0]),
        .I4(Q[7]),
        .I5(Q[1]),
        .O(\phase_acc_reg[27]_4 ));
  LUT6 #(
    .INIT(64'hE5B0282A1A4FD7D5)) 
    \cos_out[9]_i_4 
       (.I0(Q[3]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[2]),
        .I4(Q[4]),
        .I5(Q[7]),
        .O(\phase_acc_reg[27]_3 ));
  FDCE \cos_out_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [0]),
        .Q(\cos_out_reg[15]_0 [0]));
  FDCE \cos_out_reg[10] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [10]),
        .Q(\cos_out_reg[15]_0 [10]));
  FDCE \cos_out_reg[11] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [11]),
        .Q(\cos_out_reg[15]_0 [11]));
  FDCE \cos_out_reg[12] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [12]),
        .Q(\cos_out_reg[15]_0 [12]));
  FDCE \cos_out_reg[13] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [13]),
        .Q(\cos_out_reg[15]_0 [13]));
  FDCE \cos_out_reg[14] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [14]),
        .Q(\cos_out_reg[15]_0 [14]));
  FDCE \cos_out_reg[15] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [15]),
        .Q(\cos_out_reg[15]_0 [15]));
  FDCE \cos_out_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [1]),
        .Q(\cos_out_reg[15]_0 [1]));
  FDCE \cos_out_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [2]),
        .Q(\cos_out_reg[15]_0 [2]));
  FDCE \cos_out_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [3]),
        .Q(\cos_out_reg[15]_0 [3]));
  FDCE \cos_out_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [4]),
        .Q(\cos_out_reg[15]_0 [4]));
  FDCE \cos_out_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [5]),
        .Q(\cos_out_reg[15]_0 [5]));
  FDCE \cos_out_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [6]),
        .Q(\cos_out_reg[15]_0 [6]));
  FDCE \cos_out_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [7]),
        .Q(\cos_out_reg[15]_0 [7]));
  FDCE \cos_out_reg[8] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [8]),
        .Q(\cos_out_reg[15]_0 [8]));
  FDCE \cos_out_reg[9] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(\cos_out_reg[15]_1 [9]),
        .Q(\cos_out_reg[15]_0 [9]));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[11]_i_2 
       (.I0(\phase_acc_reg[31]_1 [7]),
        .I1(\phase_acc_reg_n_0_[11] ),
        .O(\phase_acc[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[11]_i_3 
       (.I0(\phase_acc_reg[31]_1 [6]),
        .I1(\phase_acc_reg_n_0_[10] ),
        .O(\phase_acc[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[11]_i_4 
       (.I0(\phase_acc_reg[31]_1 [5]),
        .I1(\phase_acc_reg_n_0_[9] ),
        .O(\phase_acc[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[11]_i_5 
       (.I0(\phase_acc_reg[31]_1 [4]),
        .I1(\phase_acc_reg_n_0_[8] ),
        .O(\phase_acc[11]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[15]_i_2 
       (.I0(\phase_acc_reg[31]_1 [11]),
        .I1(\phase_acc_reg_n_0_[15] ),
        .O(\phase_acc[15]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[15]_i_3 
       (.I0(\phase_acc_reg[31]_1 [10]),
        .I1(\phase_acc_reg_n_0_[14] ),
        .O(\phase_acc[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[15]_i_4 
       (.I0(\phase_acc_reg[31]_1 [9]),
        .I1(\phase_acc_reg_n_0_[13] ),
        .O(\phase_acc[15]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[15]_i_5 
       (.I0(\phase_acc_reg[31]_1 [8]),
        .I1(\phase_acc_reg_n_0_[12] ),
        .O(\phase_acc[15]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[19]_i_2 
       (.I0(\phase_acc_reg[31]_1 [15]),
        .I1(\phase_acc_reg_n_0_[19] ),
        .O(\phase_acc[19]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[19]_i_3 
       (.I0(\phase_acc_reg[31]_1 [14]),
        .I1(\phase_acc_reg_n_0_[18] ),
        .O(\phase_acc[19]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[19]_i_4 
       (.I0(\phase_acc_reg[31]_1 [13]),
        .I1(\phase_acc_reg_n_0_[17] ),
        .O(\phase_acc[19]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[19]_i_5 
       (.I0(\phase_acc_reg[31]_1 [12]),
        .I1(\phase_acc_reg_n_0_[16] ),
        .O(\phase_acc[19]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[23]_i_2 
       (.I0(\phase_acc_reg[31]_1 [19]),
        .I1(\phase_acc_reg_n_0_[23] ),
        .O(\phase_acc[23]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[23]_i_3 
       (.I0(\phase_acc_reg[31]_1 [18]),
        .I1(\phase_acc_reg_n_0_[22] ),
        .O(\phase_acc[23]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[23]_i_4 
       (.I0(\phase_acc_reg[31]_1 [17]),
        .I1(\phase_acc_reg_n_0_[21] ),
        .O(\phase_acc[23]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[23]_i_5 
       (.I0(\phase_acc_reg[31]_1 [16]),
        .I1(\phase_acc_reg_n_0_[20] ),
        .O(\phase_acc[23]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[27]_i_2 
       (.I0(\phase_acc_reg[31]_1 [23]),
        .I1(Q[3]),
        .O(\phase_acc[27]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[27]_i_3 
       (.I0(\phase_acc_reg[31]_1 [22]),
        .I1(Q[2]),
        .O(\phase_acc[27]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[27]_i_4 
       (.I0(\phase_acc_reg[31]_1 [21]),
        .I1(Q[1]),
        .O(\phase_acc[27]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[27]_i_5 
       (.I0(\phase_acc_reg[31]_1 [20]),
        .I1(Q[0]),
        .O(\phase_acc[27]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[31]_i_2 
       (.I0(\phase_acc_reg[31]_1 [27]),
        .I1(Q[7]),
        .O(\phase_acc[31]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[31]_i_3 
       (.I0(\phase_acc_reg[31]_1 [26]),
        .I1(Q[6]),
        .O(\phase_acc[31]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[31]_i_4 
       (.I0(\phase_acc_reg[31]_1 [25]),
        .I1(Q[5]),
        .O(\phase_acc[31]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[31]_i_5 
       (.I0(\phase_acc_reg[31]_1 [24]),
        .I1(Q[4]),
        .O(\phase_acc[31]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[7]_i_2 
       (.I0(\phase_acc_reg[31]_1 [3]),
        .I1(\phase_acc_reg_n_0_[7] ),
        .O(\phase_acc[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[7]_i_3 
       (.I0(\phase_acc_reg[31]_1 [2]),
        .I1(\phase_acc_reg_n_0_[6] ),
        .O(\phase_acc[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[7]_i_4 
       (.I0(\phase_acc_reg[31]_1 [1]),
        .I1(\phase_acc_reg_n_0_[5] ),
        .O(\phase_acc[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \phase_acc[7]_i_5 
       (.I0(\phase_acc_reg[31]_1 [0]),
        .I1(\phase_acc_reg_n_0_[4] ),
        .O(\phase_acc[7]_i_5_n_0 ));
  FDCE \phase_acc_reg[10] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[10]),
        .Q(\phase_acc_reg_n_0_[10] ));
  FDCE \phase_acc_reg[11] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[11]),
        .Q(\phase_acc_reg_n_0_[11] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \phase_acc_reg[11]_i_1 
       (.CI(\phase_acc_reg[7]_i_1_n_0 ),
        .CO({\phase_acc_reg[11]_i_1_n_0 ,\phase_acc_reg[11]_i_1_n_1 ,\phase_acc_reg[11]_i_1_n_2 ,\phase_acc_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\phase_acc_reg[31]_1 [7:4]),
        .O(phase_acc0_dspDelayedAccum[11:8]),
        .S({\phase_acc[11]_i_2_n_0 ,\phase_acc[11]_i_3_n_0 ,\phase_acc[11]_i_4_n_0 ,\phase_acc[11]_i_5_n_0 }));
  FDCE \phase_acc_reg[12] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[12]),
        .Q(\phase_acc_reg_n_0_[12] ));
  FDCE \phase_acc_reg[13] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[13]),
        .Q(\phase_acc_reg_n_0_[13] ));
  FDCE \phase_acc_reg[14] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[14]),
        .Q(\phase_acc_reg_n_0_[14] ));
  FDCE \phase_acc_reg[15] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[15]),
        .Q(\phase_acc_reg_n_0_[15] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \phase_acc_reg[15]_i_1 
       (.CI(\phase_acc_reg[11]_i_1_n_0 ),
        .CO({\phase_acc_reg[15]_i_1_n_0 ,\phase_acc_reg[15]_i_1_n_1 ,\phase_acc_reg[15]_i_1_n_2 ,\phase_acc_reg[15]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\phase_acc_reg[31]_1 [11:8]),
        .O(phase_acc0_dspDelayedAccum[15:12]),
        .S({\phase_acc[15]_i_2_n_0 ,\phase_acc[15]_i_3_n_0 ,\phase_acc[15]_i_4_n_0 ,\phase_acc[15]_i_5_n_0 }));
  FDCE \phase_acc_reg[16] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[16]),
        .Q(\phase_acc_reg_n_0_[16] ));
  FDCE \phase_acc_reg[17] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[17]),
        .Q(\phase_acc_reg_n_0_[17] ));
  FDCE \phase_acc_reg[18] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[18]),
        .Q(\phase_acc_reg_n_0_[18] ));
  FDCE \phase_acc_reg[19] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[19]),
        .Q(\phase_acc_reg_n_0_[19] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \phase_acc_reg[19]_i_1 
       (.CI(\phase_acc_reg[15]_i_1_n_0 ),
        .CO({\phase_acc_reg[19]_i_1_n_0 ,\phase_acc_reg[19]_i_1_n_1 ,\phase_acc_reg[19]_i_1_n_2 ,\phase_acc_reg[19]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\phase_acc_reg[31]_1 [15:12]),
        .O(phase_acc0_dspDelayedAccum[19:16]),
        .S({\phase_acc[19]_i_2_n_0 ,\phase_acc[19]_i_3_n_0 ,\phase_acc[19]_i_4_n_0 ,\phase_acc[19]_i_5_n_0 }));
  FDCE \phase_acc_reg[20] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[20]),
        .Q(\phase_acc_reg_n_0_[20] ));
  FDCE \phase_acc_reg[21] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[21]),
        .Q(\phase_acc_reg_n_0_[21] ));
  FDCE \phase_acc_reg[22] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[22]),
        .Q(\phase_acc_reg_n_0_[22] ));
  FDCE \phase_acc_reg[23] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[23]),
        .Q(\phase_acc_reg_n_0_[23] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \phase_acc_reg[23]_i_1 
       (.CI(\phase_acc_reg[19]_i_1_n_0 ),
        .CO({\phase_acc_reg[23]_i_1_n_0 ,\phase_acc_reg[23]_i_1_n_1 ,\phase_acc_reg[23]_i_1_n_2 ,\phase_acc_reg[23]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\phase_acc_reg[31]_1 [19:16]),
        .O(phase_acc0_dspDelayedAccum[23:20]),
        .S({\phase_acc[23]_i_2_n_0 ,\phase_acc[23]_i_3_n_0 ,\phase_acc[23]_i_4_n_0 ,\phase_acc[23]_i_5_n_0 }));
  FDCE \phase_acc_reg[24] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[24]),
        .Q(Q[0]));
  FDCE \phase_acc_reg[25] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[25]),
        .Q(Q[1]));
  FDCE \phase_acc_reg[26] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[26]),
        .Q(Q[2]));
  FDCE \phase_acc_reg[27] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[27]),
        .Q(Q[3]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \phase_acc_reg[27]_i_1 
       (.CI(\phase_acc_reg[23]_i_1_n_0 ),
        .CO({\phase_acc_reg[27]_i_1_n_0 ,\phase_acc_reg[27]_i_1_n_1 ,\phase_acc_reg[27]_i_1_n_2 ,\phase_acc_reg[27]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\phase_acc_reg[31]_1 [23:20]),
        .O(phase_acc0_dspDelayedAccum[27:24]),
        .S({\phase_acc[27]_i_2_n_0 ,\phase_acc[27]_i_3_n_0 ,\phase_acc[27]_i_4_n_0 ,\phase_acc[27]_i_5_n_0 }));
  FDCE \phase_acc_reg[28] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[28]),
        .Q(Q[4]));
  FDCE \phase_acc_reg[29] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[29]),
        .Q(Q[5]));
  FDCE \phase_acc_reg[30] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[30]),
        .Q(Q[6]));
  FDCE \phase_acc_reg[31] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[31]),
        .Q(Q[7]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \phase_acc_reg[31]_i_1 
       (.CI(\phase_acc_reg[27]_i_1_n_0 ),
        .CO({\NLW_phase_acc_reg[31]_i_1_CO_UNCONNECTED [3],\phase_acc_reg[31]_i_1_n_1 ,\phase_acc_reg[31]_i_1_n_2 ,\phase_acc_reg[31]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\phase_acc_reg[31]_1 [26:24]}),
        .O(phase_acc0_dspDelayedAccum[31:28]),
        .S({\phase_acc[31]_i_2_n_0 ,\phase_acc[31]_i_3_n_0 ,\phase_acc[31]_i_4_n_0 ,\phase_acc[31]_i_5_n_0 }));
  FDCE \phase_acc_reg[4] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[4]),
        .Q(\phase_acc_reg_n_0_[4] ));
  FDCE \phase_acc_reg[5] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[5]),
        .Q(\phase_acc_reg_n_0_[5] ));
  FDCE \phase_acc_reg[6] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[6]),
        .Q(\phase_acc_reg_n_0_[6] ));
  FDCE \phase_acc_reg[7] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[7]),
        .Q(\phase_acc_reg_n_0_[7] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \phase_acc_reg[7]_i_1 
       (.CI(1'b0),
        .CO({\phase_acc_reg[7]_i_1_n_0 ,\phase_acc_reg[7]_i_1_n_1 ,\phase_acc_reg[7]_i_1_n_2 ,\phase_acc_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\phase_acc_reg[31]_1 [3:0]),
        .O(phase_acc0_dspDelayedAccum[7:4]),
        .S({\phase_acc[7]_i_2_n_0 ,\phase_acc[7]_i_3_n_0 ,\phase_acc[7]_i_4_n_0 ,\phase_acc[7]_i_5_n_0 }));
  FDCE \phase_acc_reg[8] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[8]),
        .Q(\phase_acc_reg_n_0_[8] ));
  FDCE \phase_acc_reg[9] 
       (.C(aclk),
        .CE(E),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(phase_acc0_dspDelayedAccum[9]),
        .Q(\phase_acc_reg_n_0_[9] ));
  LUT6 #(
    .INIT(64'h05BA28A0FA45D75F)) 
    \sin_out[10]_i_5 
       (.I0(Q[3]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(Q[4]),
        .I5(Q[7]),
        .O(\phase_acc_reg[27]_8 ));
  LUT6 #(
    .INIT(64'hB50E4AF1E11D1EE2)) 
    \sin_out[10]_i_7 
       (.I0(Q[3]),
        .I1(Q[4]),
        .I2(Q[2]),
        .I3(Q[0]),
        .I4(Q[7]),
        .I5(Q[1]),
        .O(\phase_acc_reg[27]_7 ));
  LUT6 #(
    .INIT(64'h5EAA0000A155FFFF)) 
    \sin_out[12]_i_5 
       (.I0(Q[3]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[2]),
        .I4(Q[4]),
        .I5(Q[7]),
        .O(\phase_acc_reg[27]_9 ));
  LUT6 #(
    .INIT(64'h16F9E90674028BF9)) 
    \sin_out[5]_i_5 
       (.I0(Q[3]),
        .I1(Q[4]),
        .I2(Q[2]),
        .I3(Q[0]),
        .I4(Q[7]),
        .I5(Q[1]),
        .O(\phase_acc_reg[27]_5 ));
  LUT6 #(
    .INIT(64'hE5B0282A1A4FD7D5)) 
    \sin_out[9]_i_5 
       (.I0(Q[3]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[2]),
        .I4(Q[4]),
        .I5(Q[7]),
        .O(\phase_acc_reg[27]_6 ));
  FDCE \sin_out_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[0]),
        .Q(\sin_out_reg[15]_0 [0]));
  FDCE \sin_out_reg[10] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[10]),
        .Q(\sin_out_reg[15]_0 [10]));
  FDCE \sin_out_reg[11] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[11]),
        .Q(\sin_out_reg[15]_0 [11]));
  FDCE \sin_out_reg[12] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[12]),
        .Q(\sin_out_reg[15]_0 [12]));
  FDCE \sin_out_reg[13] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[13]),
        .Q(\sin_out_reg[15]_0 [13]));
  FDCE \sin_out_reg[14] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[14]),
        .Q(\sin_out_reg[15]_0 [14]));
  FDCE \sin_out_reg[15] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[15]),
        .Q(\sin_out_reg[15]_0 [15]));
  FDCE \sin_out_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[1]),
        .Q(\sin_out_reg[15]_0 [1]));
  FDCE \sin_out_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[2]),
        .Q(\sin_out_reg[15]_0 [2]));
  FDCE \sin_out_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[3]),
        .Q(\sin_out_reg[15]_0 [3]));
  FDCE \sin_out_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[4]),
        .Q(\sin_out_reg[15]_0 [4]));
  FDCE \sin_out_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[5]),
        .Q(\sin_out_reg[15]_0 [5]));
  FDCE \sin_out_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[6]),
        .Q(\sin_out_reg[15]_0 [6]));
  FDCE \sin_out_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[7]),
        .Q(\sin_out_reg[15]_0 [7]));
  FDCE \sin_out_reg[8] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[8]),
        .Q(\sin_out_reg[15]_0 [8]));
  FDCE \sin_out_reg[9] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(\phase_acc_reg[31]_0 ),
        .D(D[9]),
        .Q(\sin_out_reg[15]_0 [9]));
endmodule

(* ORIG_REF_NAME = "bpsk_demod_v1_0" *) 
module system_bpsk_demodulator_0_0_bpsk_demod_v1_0
   (E,
    aresetn_0,
    M_AXIS_BITS_TDATA,
    M_AXIS_BITS_TVALID,
    S_AXI_AWREADY,
    S_AXI_WREADY,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RVALID,
    axi_bvalid_reg_0,
    OPMODE,
    S_AXI_ARADDR,
    adc_data,
    aclk,
    adc_valid,
    M_AXIS_BITS_TREADY,
    aresetn,
    S_AXI_ACLK,
    S_AXI_AWADDR,
    S_AXI_WSTRB,
    S_AXI_WDATA,
    S_AXI_ARESETN,
    S_AXI_ARVALID,
    S_AXI_RREADY,
    S_AXI_WVALID,
    S_AXI_AWVALID,
    S_AXI_BREADY);
  output [0:0]E;
  output aresetn_0;
  output [7:0]M_AXIS_BITS_TDATA;
  output M_AXIS_BITS_TVALID;
  output S_AXI_AWREADY;
  output S_AXI_WREADY;
  output S_AXI_ARREADY;
  output [31:0]S_AXI_RDATA;
  output S_AXI_RVALID;
  output axi_bvalid_reg_0;
  input [0:0]OPMODE;
  input [5:0]S_AXI_ARADDR;
  input [31:0]adc_data;
  input aclk;
  input adc_valid;
  input M_AXIS_BITS_TREADY;
  input aresetn;
  input S_AXI_ACLK;
  input [5:0]S_AXI_AWADDR;
  input [2:0]S_AXI_WSTRB;
  input [19:0]S_AXI_WDATA;
  input S_AXI_ARESETN;
  input S_AXI_ARVALID;
  input S_AXI_RREADY;
  input S_AXI_WVALID;
  input S_AXI_AWVALID;
  input S_AXI_BREADY;

  wire [0:0]E;
  wire [7:0]M_AXIS_BITS_TDATA;
  wire M_AXIS_BITS_TREADY;
  wire M_AXIS_BITS_TVALID;
  wire [0:0]OPMODE;
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
  wire [19:0]S_AXI_WDATA;
  wire S_AXI_WREADY;
  wire [2:0]S_AXI_WSTRB;
  wire S_AXI_WVALID;
  wire aclk;
  wire [31:0]adc_data;
  wire adc_valid;
  wire [15:0]agc_gain_ff1;
  wire aresetn;
  wire aresetn_0;
  wire \aw_addr_reg_n_0_[7] ;
  wire aw_done;
  wire aw_done_i_1_n_0;
  wire axi_arready0;
  wire axi_awready0;
  wire axi_bvalid_i_1_n_0;
  wire axi_bvalid_reg_0;
  wire \axi_rdata[0]_i_1_n_0 ;
  wire \axi_rdata[0]_i_2_n_0 ;
  wire \axi_rdata[0]_i_3_n_0 ;
  wire \axi_rdata[0]_i_4_n_0 ;
  wire \axi_rdata[0]_i_5_n_0 ;
  wire \axi_rdata[10]_i_1_n_0 ;
  wire \axi_rdata[10]_i_2_n_0 ;
  wire \axi_rdata[10]_i_3_n_0 ;
  wire \axi_rdata[10]_i_4_n_0 ;
  wire \axi_rdata[11]_i_1_n_0 ;
  wire \axi_rdata[11]_i_2_n_0 ;
  wire \axi_rdata[11]_i_3_n_0 ;
  wire \axi_rdata[11]_i_4_n_0 ;
  wire \axi_rdata[12]_i_1_n_0 ;
  wire \axi_rdata[12]_i_2_n_0 ;
  wire \axi_rdata[12]_i_3_n_0 ;
  wire \axi_rdata[12]_i_4_n_0 ;
  wire \axi_rdata[13]_i_1_n_0 ;
  wire \axi_rdata[13]_i_2_n_0 ;
  wire \axi_rdata[13]_i_3_n_0 ;
  wire \axi_rdata[13]_i_4_n_0 ;
  wire \axi_rdata[14]_i_1_n_0 ;
  wire \axi_rdata[14]_i_2_n_0 ;
  wire \axi_rdata[14]_i_3_n_0 ;
  wire \axi_rdata[14]_i_4_n_0 ;
  wire \axi_rdata[15]_i_1_n_0 ;
  wire \axi_rdata[15]_i_2_n_0 ;
  wire \axi_rdata[15]_i_3_n_0 ;
  wire \axi_rdata[15]_i_4_n_0 ;
  wire \axi_rdata[15]_i_5_n_0 ;
  wire \axi_rdata[15]_i_6_n_0 ;
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
  wire \axi_rdata[1]_i_4_n_0 ;
  wire \axi_rdata[1]_i_5_n_0 ;
  wire \axi_rdata[20]_i_1_n_0 ;
  wire \axi_rdata[21]_i_1_n_0 ;
  wire \axi_rdata[22]_i_1_n_0 ;
  wire \axi_rdata[23]_i_1_n_0 ;
  wire \axi_rdata[24]_i_1_n_0 ;
  wire \axi_rdata[25]_i_1_n_0 ;
  wire \axi_rdata[26]_i_1_n_0 ;
  wire \axi_rdata[27]_i_1_n_0 ;
  wire \axi_rdata[28]_i_1_n_0 ;
  wire \axi_rdata[29]_i_1_n_0 ;
  wire \axi_rdata[2]_i_1_n_0 ;
  wire \axi_rdata[2]_i_2_n_0 ;
  wire \axi_rdata[2]_i_3_n_0 ;
  wire \axi_rdata[2]_i_4_n_0 ;
  wire \axi_rdata[2]_i_5_n_0 ;
  wire \axi_rdata[30]_i_1_n_0 ;
  wire \axi_rdata[31]_i_1_n_0 ;
  wire \axi_rdata[31]_i_2_n_0 ;
  wire \axi_rdata[3]_i_1_n_0 ;
  wire \axi_rdata[3]_i_2_n_0 ;
  wire \axi_rdata[3]_i_3_n_0 ;
  wire \axi_rdata[3]_i_4_n_0 ;
  wire \axi_rdata[3]_i_5_n_0 ;
  wire \axi_rdata[4]_i_1_n_0 ;
  wire \axi_rdata[4]_i_2_n_0 ;
  wire \axi_rdata[4]_i_3_n_0 ;
  wire \axi_rdata[4]_i_4_n_0 ;
  wire \axi_rdata[4]_i_5_n_0 ;
  wire \axi_rdata[5]_i_1_n_0 ;
  wire \axi_rdata[5]_i_2_n_0 ;
  wire \axi_rdata[5]_i_3_n_0 ;
  wire \axi_rdata[5]_i_4_n_0 ;
  wire \axi_rdata[5]_i_5_n_0 ;
  wire \axi_rdata[6]_i_1_n_0 ;
  wire \axi_rdata[6]_i_2_n_0 ;
  wire \axi_rdata[6]_i_3_n_0 ;
  wire \axi_rdata[6]_i_4_n_0 ;
  wire \axi_rdata[6]_i_5_n_0 ;
  wire \axi_rdata[7]_i_1_n_0 ;
  wire \axi_rdata[7]_i_2_n_0 ;
  wire \axi_rdata[7]_i_3_n_0 ;
  wire \axi_rdata[7]_i_4_n_0 ;
  wire \axi_rdata[7]_i_5_n_0 ;
  wire \axi_rdata[8]_i_1_n_0 ;
  wire \axi_rdata[8]_i_2_n_0 ;
  wire \axi_rdata[8]_i_3_n_0 ;
  wire \axi_rdata[8]_i_4_n_0 ;
  wire \axi_rdata[9]_i_1_n_0 ;
  wire \axi_rdata[9]_i_2_n_0 ;
  wire \axi_rdata[9]_i_3_n_0 ;
  wire \axi_rdata[9]_i_4_n_0 ;
  wire axi_rvalid_i_1_n_0;
  wire axi_wready0;
  wire axireg_agc_ki_shift;
  wire [15:0]axireg_agc_target;
  wire \axireg_agc_target[15]_i_1_n_0 ;
  wire \axireg_agc_target[7]_i_1_n_0 ;
  wire [15:0]axireg_costas_ki;
  wire \axireg_costas_ki[15]_i_1_n_0 ;
  wire \axireg_costas_ki[7]_i_1_n_0 ;
  wire [15:0]axireg_costas_kp;
  wire \axireg_costas_kp[15]_i_1_n_0 ;
  wire \axireg_costas_kp[7]_i_1_n_0 ;
  wire axireg_enable;
  wire axireg_enable_i_2_n_0;
  wire axireg_sps;
  wire \axireg_sps[7]_i_2_n_0 ;
  wire \axireg_sps_reg_n_0_[0] ;
  wire \axireg_sps_reg_n_0_[1] ;
  wire \axireg_sps_reg_n_0_[2] ;
  wire \axireg_sps_reg_n_0_[3] ;
  wire \axireg_sps_reg_n_0_[4] ;
  wire \axireg_sps_reg_n_0_[5] ;
  wire \axireg_sps_reg_n_0_[6] ;
  wire \axireg_sps_reg_n_0_[7] ;
  wire [15:0]axireg_timing_ki;
  wire \axireg_timing_ki[15]_i_1_n_0 ;
  wire \axireg_timing_ki[15]_i_2_n_0 ;
  wire \axireg_timing_ki[7]_i_1_n_0 ;
  wire [15:0]axireg_timing_kp;
  wire \axireg_timing_kp[15]_i_1_n_0 ;
  wire \axireg_timing_kp[7]_i_1_n_0 ;
  wire [39:0]bit_cnt_ff1;
  wire \bit_cnt_ff2_reg_n_0_[0] ;
  wire \bit_cnt_ff2_reg_n_0_[10] ;
  wire \bit_cnt_ff2_reg_n_0_[11] ;
  wire \bit_cnt_ff2_reg_n_0_[12] ;
  wire \bit_cnt_ff2_reg_n_0_[13] ;
  wire \bit_cnt_ff2_reg_n_0_[14] ;
  wire \bit_cnt_ff2_reg_n_0_[15] ;
  wire \bit_cnt_ff2_reg_n_0_[16] ;
  wire \bit_cnt_ff2_reg_n_0_[17] ;
  wire \bit_cnt_ff2_reg_n_0_[18] ;
  wire \bit_cnt_ff2_reg_n_0_[19] ;
  wire \bit_cnt_ff2_reg_n_0_[1] ;
  wire \bit_cnt_ff2_reg_n_0_[20] ;
  wire \bit_cnt_ff2_reg_n_0_[21] ;
  wire \bit_cnt_ff2_reg_n_0_[22] ;
  wire \bit_cnt_ff2_reg_n_0_[23] ;
  wire \bit_cnt_ff2_reg_n_0_[24] ;
  wire \bit_cnt_ff2_reg_n_0_[25] ;
  wire \bit_cnt_ff2_reg_n_0_[26] ;
  wire \bit_cnt_ff2_reg_n_0_[27] ;
  wire \bit_cnt_ff2_reg_n_0_[28] ;
  wire \bit_cnt_ff2_reg_n_0_[29] ;
  wire \bit_cnt_ff2_reg_n_0_[2] ;
  wire \bit_cnt_ff2_reg_n_0_[30] ;
  wire \bit_cnt_ff2_reg_n_0_[31] ;
  wire \bit_cnt_ff2_reg_n_0_[3] ;
  wire \bit_cnt_ff2_reg_n_0_[4] ;
  wire \bit_cnt_ff2_reg_n_0_[5] ;
  wire \bit_cnt_ff2_reg_n_0_[6] ;
  wire \bit_cnt_ff2_reg_n_0_[7] ;
  wire \bit_cnt_ff2_reg_n_0_[8] ;
  wire \bit_cnt_ff2_reg_n_0_[9] ;
  wire [3:0]core_agc_ki_shift;
  wire [15:0]core_agc_target;
  wire core_bypass_agc;
  wire core_bypass_costas;
  wire core_bypass_timing;
  wire [15:0]core_costas_ki;
  wire [15:0]core_costas_kp;
  wire core_enable;
  wire [7:0]core_sps;
  wire [15:0]core_timing_ki;
  wire [15:0]core_timing_kp;
  wire [3:0]data0;
  wire [7:0]data12;
  wire [19:0]data4;
  wire do_write;
  wire [1:0]locked_ff;
  wire p_0_in0;
  wire [3:0]p_0_in_0;
  wire p_0_in__0_1;
  wire p_1_in;
  wire p_1_in0;
  wire [15:0]phase_err_ff1;
  wire [15:0]phase_err_ff2;
  wire [0:0]q_mix;
  wire [15:0]raw_agc_gain;
  wire raw_agc_settled;
  wire [39:0]raw_bit_count;
  wire raw_carrier_locked;
  wire [15:1]raw_phase_err;
  wire [15:0]raw_timing_err;
  wire [1:0]settled_ff;
  wire [3:0]snap_agc_ki_shift;
  wire [15:0]snap_agc_target;
  wire snap_bypass_agc;
  wire snap_bypass_costas;
  wire snap_bypass_timing;
  wire [15:0]snap_costas_ki;
  wire [15:0]snap_costas_kp;
  wire snap_enable;
  wire [7:0]snap_sps;
  wire [15:0]snap_timing_ki;
  wire [15:0]snap_timing_kp;
  wire [15:0]timing_err_ff1;
  wire [15:0]timing_err_ff2;
  wire \w_data_reg_n_0_[0] ;
  wire \w_data_reg_n_0_[10] ;
  wire \w_data_reg_n_0_[11] ;
  wire \w_data_reg_n_0_[12] ;
  wire \w_data_reg_n_0_[13] ;
  wire \w_data_reg_n_0_[14] ;
  wire \w_data_reg_n_0_[15] ;
  wire \w_data_reg_n_0_[16] ;
  wire \w_data_reg_n_0_[17] ;
  wire \w_data_reg_n_0_[18] ;
  wire \w_data_reg_n_0_[19] ;
  wire \w_data_reg_n_0_[1] ;
  wire \w_data_reg_n_0_[2] ;
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
  wire wr_pulse_axi;
  wire wr_pulse_core;
  wire \wr_pulse_sync_reg_n_0_[0] ;

  FDRE \agc_gain_ff1_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[0]),
        .Q(agc_gain_ff1[0]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[10]),
        .Q(agc_gain_ff1[10]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[11]),
        .Q(agc_gain_ff1[11]),
        .R(p_0_in__0_1));
  FDSE \agc_gain_ff1_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[12]),
        .Q(agc_gain_ff1[12]),
        .S(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[13]),
        .Q(agc_gain_ff1[13]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[14]),
        .Q(agc_gain_ff1[14]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[15]),
        .Q(agc_gain_ff1[15]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[1]),
        .Q(agc_gain_ff1[1]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[2]),
        .Q(agc_gain_ff1[2]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[3]),
        .Q(agc_gain_ff1[3]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[4]),
        .Q(agc_gain_ff1[4]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[5]),
        .Q(agc_gain_ff1[5]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[6]),
        .Q(agc_gain_ff1[6]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[7]),
        .Q(agc_gain_ff1[7]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[8]),
        .Q(agc_gain_ff1[8]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff1_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_gain[9]),
        .Q(agc_gain_ff1[9]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[0]),
        .Q(data4[0]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[10]),
        .Q(data4[10]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[11]),
        .Q(data4[11]),
        .R(p_0_in__0_1));
  FDSE \agc_gain_ff2_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[12]),
        .Q(data4[12]),
        .S(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[13]),
        .Q(data4[13]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[14]),
        .Q(data4[14]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[15]),
        .Q(data4[15]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[1]),
        .Q(data4[1]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[2]),
        .Q(data4[2]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[3]),
        .Q(data4[3]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[4]),
        .Q(data4[4]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[5]),
        .Q(data4[5]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[6]),
        .Q(data4[6]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[7]),
        .Q(data4[7]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[8]),
        .Q(data4[8]),
        .R(p_0_in__0_1));
  FDRE \agc_gain_ff2_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(agc_gain_ff1[9]),
        .Q(data4[9]),
        .R(p_0_in__0_1));
  FDRE \aw_addr_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[0]),
        .Q(p_0_in_0[0]),
        .R(p_0_in__0_1));
  FDRE \aw_addr_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[1]),
        .Q(p_0_in_0[1]),
        .R(p_0_in__0_1));
  FDRE \aw_addr_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[2]),
        .Q(p_0_in_0[2]),
        .R(p_0_in__0_1));
  FDRE \aw_addr_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[3]),
        .Q(p_0_in_0[3]),
        .R(p_0_in__0_1));
  FDRE \aw_addr_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[4]),
        .Q(p_0_in0),
        .R(p_0_in__0_1));
  FDRE \aw_addr_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(axi_awready0),
        .D(S_AXI_AWADDR[5]),
        .Q(\aw_addr_reg_n_0_[7] ),
        .R(p_0_in__0_1));
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
        .R(p_0_in__0_1));
  LUT1 #(
    .INIT(2'h1)) 
    axi_awready_i_1
       (.I0(S_AXI_ARESETN),
        .O(p_0_in__0_1));
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
        .R(p_0_in__0_1));
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
        .R(p_0_in__0_1));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFE200E2)) 
    \axi_rdata[0]_i_1 
       (.I0(\axi_rdata[0]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(\axi_rdata[0]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[3]),
        .I4(\axi_rdata[0]_i_4_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAFCFAFC0)) 
    \axi_rdata[0]_i_2 
       (.I0(axireg_agc_target[0]),
        .I1(\axireg_sps_reg_n_0_[0] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(S_AXI_ARADDR[0]),
        .I4(data0[0]),
        .O(\axi_rdata[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[0]_i_3 
       (.I0(axireg_timing_kp[0]),
        .I1(axireg_costas_ki[0]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[0]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[0]),
        .O(\axi_rdata[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT5 #(
    .INIT(32'hCACAFACA)) 
    \axi_rdata[0]_i_4 
       (.I0(\axi_rdata[0]_i_5_n_0 ),
        .I1(S_AXI_ARADDR[1]),
        .I2(S_AXI_ARADDR[2]),
        .I3(data12[0]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[0]_i_5 
       (.I0(\bit_cnt_ff2_reg_n_0_[0] ),
        .I1(timing_err_ff2[0]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[0]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[0]),
        .O(\axi_rdata[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE2EE2222)) 
    \axi_rdata[10]_i_1 
       (.I0(\axi_rdata[10]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[10]_i_3_n_0 ),
        .I3(\axi_rdata[15]_i_4_n_0 ),
        .I4(\axi_rdata[15]_i_5_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8888888)) 
    \axi_rdata[10]_i_2 
       (.I0(\axi_rdata[10]_i_4_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_agc_target[10]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[10]_i_3 
       (.I0(\bit_cnt_ff2_reg_n_0_[10] ),
        .I1(timing_err_ff2[10]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[10]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[10]),
        .O(\axi_rdata[10]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[10]_i_4 
       (.I0(axireg_timing_kp[10]),
        .I1(axireg_costas_ki[10]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[10]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[10]),
        .O(\axi_rdata[10]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE2EE2222)) 
    \axi_rdata[11]_i_1 
       (.I0(\axi_rdata[11]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[11]_i_3_n_0 ),
        .I3(\axi_rdata[15]_i_4_n_0 ),
        .I4(\axi_rdata[15]_i_5_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8888888)) 
    \axi_rdata[11]_i_2 
       (.I0(\axi_rdata[11]_i_4_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_agc_target[11]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[11]_i_3 
       (.I0(\bit_cnt_ff2_reg_n_0_[11] ),
        .I1(timing_err_ff2[11]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[11]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[11]),
        .O(\axi_rdata[11]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[11]_i_4 
       (.I0(axireg_timing_kp[11]),
        .I1(axireg_costas_ki[11]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[11]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[11]),
        .O(\axi_rdata[11]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE2EE2222)) 
    \axi_rdata[12]_i_1 
       (.I0(\axi_rdata[12]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[12]_i_3_n_0 ),
        .I3(\axi_rdata[15]_i_4_n_0 ),
        .I4(\axi_rdata[15]_i_5_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8888888)) 
    \axi_rdata[12]_i_2 
       (.I0(\axi_rdata[12]_i_4_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_agc_target[12]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[12]_i_3 
       (.I0(\bit_cnt_ff2_reg_n_0_[12] ),
        .I1(timing_err_ff2[12]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[12]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[12]),
        .O(\axi_rdata[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[12]_i_4 
       (.I0(axireg_timing_kp[12]),
        .I1(axireg_costas_ki[12]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[12]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[12]),
        .O(\axi_rdata[12]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE2EE2222)) 
    \axi_rdata[13]_i_1 
       (.I0(\axi_rdata[13]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[13]_i_3_n_0 ),
        .I3(\axi_rdata[15]_i_4_n_0 ),
        .I4(\axi_rdata[15]_i_5_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8888888)) 
    \axi_rdata[13]_i_2 
       (.I0(\axi_rdata[13]_i_4_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_agc_target[13]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[13]_i_3 
       (.I0(\bit_cnt_ff2_reg_n_0_[13] ),
        .I1(timing_err_ff2[13]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[13]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[13]),
        .O(\axi_rdata[13]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[13]_i_4 
       (.I0(axireg_timing_kp[13]),
        .I1(axireg_costas_ki[13]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[13]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[13]),
        .O(\axi_rdata[13]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00000000E2222222)) 
    \axi_rdata[14]_i_1 
       (.I0(\axi_rdata[14]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[15]_i_4_n_0 ),
        .I3(\axi_rdata[14]_i_3_n_0 ),
        .I4(\axi_rdata[15]_i_5_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8888888)) 
    \axi_rdata[14]_i_2 
       (.I0(\axi_rdata[14]_i_4_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_agc_target[14]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[14]_i_3 
       (.I0(\bit_cnt_ff2_reg_n_0_[14] ),
        .I1(timing_err_ff2[14]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[14]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[14]),
        .O(\axi_rdata[14]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[14]_i_4 
       (.I0(axireg_timing_kp[14]),
        .I1(axireg_costas_ki[14]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[14]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[14]),
        .O(\axi_rdata[14]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE2EE2222)) 
    \axi_rdata[15]_i_1 
       (.I0(\axi_rdata[15]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[15]_i_3_n_0 ),
        .I3(\axi_rdata[15]_i_4_n_0 ),
        .I4(\axi_rdata[15]_i_5_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8888888)) 
    \axi_rdata[15]_i_2 
       (.I0(\axi_rdata[15]_i_6_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_agc_target[15]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[15]_i_3 
       (.I0(\bit_cnt_ff2_reg_n_0_[15] ),
        .I1(timing_err_ff2[15]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[15]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[15]),
        .O(\axi_rdata[15]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'h5D)) 
    \axi_rdata[15]_i_4 
       (.I0(S_AXI_ARADDR[2]),
        .I1(S_AXI_ARADDR[0]),
        .I2(S_AXI_ARADDR[1]),
        .O(\axi_rdata[15]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \axi_rdata[15]_i_5 
       (.I0(S_AXI_ARADDR[1]),
        .I1(S_AXI_ARADDR[2]),
        .O(\axi_rdata[15]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[15]_i_6 
       (.I0(axireg_timing_kp[15]),
        .I1(axireg_costas_ki[15]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[15]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[15]),
        .O(\axi_rdata[15]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \axi_rdata[16]_i_1 
       (.I0(\axi_rdata[16]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[4]),
        .I2(S_AXI_ARADDR[5]),
        .O(\axi_rdata[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC8C0C8C0C030C000)) 
    \axi_rdata[16]_i_2 
       (.I0(\bit_cnt_ff2_reg_n_0_[16] ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data4[16]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[16]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \axi_rdata[17]_i_1 
       (.I0(\axi_rdata[17]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[4]),
        .I2(S_AXI_ARADDR[5]),
        .O(\axi_rdata[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0800080000300000)) 
    \axi_rdata[17]_i_2 
       (.I0(\bit_cnt_ff2_reg_n_0_[17] ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data4[17]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[17]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \axi_rdata[18]_i_1 
       (.I0(\axi_rdata[18]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[4]),
        .I2(S_AXI_ARADDR[5]),
        .O(\axi_rdata[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC800C800C030C000)) 
    \axi_rdata[18]_i_2 
       (.I0(\bit_cnt_ff2_reg_n_0_[18] ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data4[18]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[18]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \axi_rdata[19]_i_1 
       (.I0(\axi_rdata[19]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[4]),
        .I2(S_AXI_ARADDR[5]),
        .O(\axi_rdata[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC800C800C030C000)) 
    \axi_rdata[19]_i_2 
       (.I0(\bit_cnt_ff2_reg_n_0_[19] ),
        .I1(S_AXI_ARADDR[3]),
        .I2(S_AXI_ARADDR[2]),
        .I3(S_AXI_ARADDR[1]),
        .I4(data4[19]),
        .I5(S_AXI_ARADDR[0]),
        .O(\axi_rdata[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFE200E2)) 
    \axi_rdata[1]_i_1 
       (.I0(\axi_rdata[1]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(\axi_rdata[1]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[3]),
        .I4(\axi_rdata[1]_i_4_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[1]_i_2 
       (.I0(axireg_agc_target[1]),
        .I1(\axireg_sps_reg_n_0_[1] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(data0[0]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data0[1]),
        .O(\axi_rdata[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[1]_i_3 
       (.I0(axireg_timing_kp[1]),
        .I1(axireg_costas_ki[1]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[1]),
        .O(\axi_rdata[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hCACAFACA)) 
    \axi_rdata[1]_i_4 
       (.I0(\axi_rdata[1]_i_5_n_0 ),
        .I1(S_AXI_ARADDR[1]),
        .I2(S_AXI_ARADDR[2]),
        .I3(data12[1]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[1]_i_5 
       (.I0(\bit_cnt_ff2_reg_n_0_[1] ),
        .I1(timing_err_ff2[1]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[1]),
        .O(\axi_rdata[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000800000)) 
    \axi_rdata[20]_i_1 
       (.I0(S_AXI_ARADDR[1]),
        .I1(\bit_cnt_ff2_reg_n_0_[20] ),
        .I2(S_AXI_ARADDR[0]),
        .I3(S_AXI_ARADDR[2]),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0A00000)) 
    \axi_rdata[21]_i_1 
       (.I0(S_AXI_ARADDR[2]),
        .I1(S_AXI_ARADDR[0]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\bit_cnt_ff2_reg_n_0_[21] ),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000800000)) 
    \axi_rdata[22]_i_1 
       (.I0(S_AXI_ARADDR[1]),
        .I1(\bit_cnt_ff2_reg_n_0_[22] ),
        .I2(S_AXI_ARADDR[0]),
        .I3(S_AXI_ARADDR[2]),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0A00000)) 
    \axi_rdata[23]_i_1 
       (.I0(S_AXI_ARADDR[2]),
        .I1(S_AXI_ARADDR[0]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\bit_cnt_ff2_reg_n_0_[23] ),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000800000)) 
    \axi_rdata[24]_i_1 
       (.I0(S_AXI_ARADDR[1]),
        .I1(\bit_cnt_ff2_reg_n_0_[24] ),
        .I2(S_AXI_ARADDR[0]),
        .I3(S_AXI_ARADDR[2]),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0A00000)) 
    \axi_rdata[25]_i_1 
       (.I0(S_AXI_ARADDR[2]),
        .I1(S_AXI_ARADDR[0]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\bit_cnt_ff2_reg_n_0_[25] ),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0A00000)) 
    \axi_rdata[26]_i_1 
       (.I0(S_AXI_ARADDR[2]),
        .I1(S_AXI_ARADDR[0]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\bit_cnt_ff2_reg_n_0_[26] ),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0A00000)) 
    \axi_rdata[27]_i_1 
       (.I0(S_AXI_ARADDR[2]),
        .I1(S_AXI_ARADDR[0]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\bit_cnt_ff2_reg_n_0_[27] ),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0A00000)) 
    \axi_rdata[28]_i_1 
       (.I0(S_AXI_ARADDR[2]),
        .I1(S_AXI_ARADDR[0]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\bit_cnt_ff2_reg_n_0_[28] ),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000800000)) 
    \axi_rdata[29]_i_1 
       (.I0(S_AXI_ARADDR[1]),
        .I1(\bit_cnt_ff2_reg_n_0_[29] ),
        .I2(S_AXI_ARADDR[0]),
        .I3(S_AXI_ARADDR[2]),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFE200E2)) 
    \axi_rdata[2]_i_1 
       (.I0(\axi_rdata[2]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(\axi_rdata[2]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[3]),
        .I4(\axi_rdata[2]_i_4_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[2]_i_2 
       (.I0(axireg_agc_target[2]),
        .I1(\axireg_sps_reg_n_0_[2] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(locked_ff[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data0[2]),
        .O(\axi_rdata[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[2]_i_3 
       (.I0(axireg_timing_kp[2]),
        .I1(axireg_costas_ki[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[2]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[2]),
        .O(\axi_rdata[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hCACAFACA)) 
    \axi_rdata[2]_i_4 
       (.I0(\axi_rdata[2]_i_5_n_0 ),
        .I1(S_AXI_ARADDR[1]),
        .I2(S_AXI_ARADDR[2]),
        .I3(data12[2]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[2]_i_5 
       (.I0(\bit_cnt_ff2_reg_n_0_[2] ),
        .I1(timing_err_ff2[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[2]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[2]),
        .O(\axi_rdata[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0A00000)) 
    \axi_rdata[30]_i_1 
       (.I0(S_AXI_ARADDR[2]),
        .I1(S_AXI_ARADDR[0]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\bit_cnt_ff2_reg_n_0_[30] ),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0A00000)) 
    \axi_rdata[31]_i_1 
       (.I0(S_AXI_ARADDR[2]),
        .I1(S_AXI_ARADDR[0]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\bit_cnt_ff2_reg_n_0_[31] ),
        .I4(S_AXI_ARADDR[3]),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \axi_rdata[31]_i_2 
       (.I0(S_AXI_ARADDR[5]),
        .I1(S_AXI_ARADDR[4]),
        .O(\axi_rdata[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFE200E2)) 
    \axi_rdata[3]_i_1 
       (.I0(\axi_rdata[3]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(\axi_rdata[3]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[3]),
        .I4(\axi_rdata[3]_i_4_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[3]_i_2 
       (.I0(axireg_agc_target[3]),
        .I1(\axireg_sps_reg_n_0_[3] ),
        .I2(S_AXI_ARADDR[1]),
        .I3(settled_ff[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data0[3]),
        .O(\axi_rdata[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[3]_i_3 
       (.I0(axireg_timing_kp[3]),
        .I1(axireg_costas_ki[3]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[3]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[3]),
        .O(\axi_rdata[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hCACAFACA)) 
    \axi_rdata[3]_i_4 
       (.I0(\axi_rdata[3]_i_5_n_0 ),
        .I1(S_AXI_ARADDR[1]),
        .I2(S_AXI_ARADDR[2]),
        .I3(data12[3]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[3]_i_5 
       (.I0(\bit_cnt_ff2_reg_n_0_[3] ),
        .I1(timing_err_ff2[3]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[3]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[3]),
        .O(\axi_rdata[3]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h000000E2)) 
    \axi_rdata[4]_i_1 
       (.I0(\axi_rdata[4]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[4]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[4]),
        .I4(S_AXI_ARADDR[5]),
        .O(\axi_rdata[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \axi_rdata[4]_i_2 
       (.I0(\axi_rdata[4]_i_4_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\axireg_sps_reg_n_0_[4] ),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_agc_target[4]),
        .O(\axi_rdata[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h0A0A3A0A)) 
    \axi_rdata[4]_i_3 
       (.I0(\axi_rdata[4]_i_5_n_0 ),
        .I1(S_AXI_ARADDR[1]),
        .I2(S_AXI_ARADDR[2]),
        .I3(data12[4]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[4]_i_4 
       (.I0(axireg_timing_kp[4]),
        .I1(axireg_costas_ki[4]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[4]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[4]),
        .O(\axi_rdata[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[4]_i_5 
       (.I0(\bit_cnt_ff2_reg_n_0_[4] ),
        .I1(timing_err_ff2[4]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[4]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[4]),
        .O(\axi_rdata[4]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFE2)) 
    \axi_rdata[5]_i_1 
       (.I0(\axi_rdata[5]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[5]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[4]),
        .I4(S_AXI_ARADDR[5]),
        .O(\axi_rdata[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \axi_rdata[5]_i_2 
       (.I0(\axi_rdata[5]_i_4_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\axireg_sps_reg_n_0_[5] ),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_agc_target[5]),
        .O(\axi_rdata[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hCACAFACA)) 
    \axi_rdata[5]_i_3 
       (.I0(\axi_rdata[5]_i_5_n_0 ),
        .I1(S_AXI_ARADDR[1]),
        .I2(S_AXI_ARADDR[2]),
        .I3(data12[5]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[5]_i_4 
       (.I0(axireg_timing_kp[5]),
        .I1(axireg_costas_ki[5]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[5]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[5]),
        .O(\axi_rdata[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[5]_i_5 
       (.I0(\bit_cnt_ff2_reg_n_0_[5] ),
        .I1(timing_err_ff2[5]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[5]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[5]),
        .O(\axi_rdata[5]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFE2)) 
    \axi_rdata[6]_i_1 
       (.I0(\axi_rdata[6]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[6]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[4]),
        .I4(S_AXI_ARADDR[5]),
        .O(\axi_rdata[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \axi_rdata[6]_i_2 
       (.I0(\axi_rdata[6]_i_4_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\axireg_sps_reg_n_0_[6] ),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_agc_target[6]),
        .O(\axi_rdata[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hCACAFACA)) 
    \axi_rdata[6]_i_3 
       (.I0(\axi_rdata[6]_i_5_n_0 ),
        .I1(S_AXI_ARADDR[1]),
        .I2(S_AXI_ARADDR[2]),
        .I3(data12[6]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[6]_i_4 
       (.I0(axireg_timing_kp[6]),
        .I1(axireg_costas_ki[6]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[6]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[6]),
        .O(\axi_rdata[6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[6]_i_5 
       (.I0(\bit_cnt_ff2_reg_n_0_[6] ),
        .I1(timing_err_ff2[6]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[6]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[6]),
        .O(\axi_rdata[6]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT5 #(
    .INIT(32'hFFFFFFE2)) 
    \axi_rdata[7]_i_1 
       (.I0(\axi_rdata[7]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[7]_i_3_n_0 ),
        .I3(S_AXI_ARADDR[4]),
        .I4(S_AXI_ARADDR[5]),
        .O(\axi_rdata[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8888888B888)) 
    \axi_rdata[7]_i_2 
       (.I0(\axi_rdata[7]_i_4_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(\axireg_sps_reg_n_0_[7] ),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_agc_target[7]),
        .O(\axi_rdata[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT5 #(
    .INIT(32'hCACAFACA)) 
    \axi_rdata[7]_i_3 
       (.I0(\axi_rdata[7]_i_5_n_0 ),
        .I1(S_AXI_ARADDR[1]),
        .I2(S_AXI_ARADDR[2]),
        .I3(data12[7]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[7]_i_4 
       (.I0(axireg_timing_kp[7]),
        .I1(axireg_costas_ki[7]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[7]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[7]),
        .O(\axi_rdata[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[7]_i_5 
       (.I0(\bit_cnt_ff2_reg_n_0_[7] ),
        .I1(timing_err_ff2[7]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[7]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[7]),
        .O(\axi_rdata[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h00000000E2222222)) 
    \axi_rdata[8]_i_1 
       (.I0(\axi_rdata[8]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[15]_i_4_n_0 ),
        .I3(\axi_rdata[8]_i_3_n_0 ),
        .I4(\axi_rdata[15]_i_5_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8888888)) 
    \axi_rdata[8]_i_2 
       (.I0(\axi_rdata[8]_i_4_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_agc_target[8]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[8]_i_3 
       (.I0(\bit_cnt_ff2_reg_n_0_[8] ),
        .I1(timing_err_ff2[8]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[8]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[8]),
        .O(\axi_rdata[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[8]_i_4 
       (.I0(axireg_timing_kp[8]),
        .I1(axireg_costas_ki[8]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[8]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[8]),
        .O(\axi_rdata[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE2EE2222)) 
    \axi_rdata[9]_i_1 
       (.I0(\axi_rdata[9]_i_2_n_0 ),
        .I1(S_AXI_ARADDR[3]),
        .I2(\axi_rdata[9]_i_3_n_0 ),
        .I3(\axi_rdata[15]_i_4_n_0 ),
        .I4(\axi_rdata[15]_i_5_n_0 ),
        .I5(\axi_rdata[31]_i_2_n_0 ),
        .O(\axi_rdata[9]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8888888)) 
    \axi_rdata[9]_i_2 
       (.I0(\axi_rdata[9]_i_4_n_0 ),
        .I1(S_AXI_ARADDR[2]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_agc_target[9]),
        .I4(S_AXI_ARADDR[0]),
        .O(\axi_rdata[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[9]_i_3 
       (.I0(\bit_cnt_ff2_reg_n_0_[9] ),
        .I1(timing_err_ff2[9]),
        .I2(S_AXI_ARADDR[1]),
        .I3(phase_err_ff2[9]),
        .I4(S_AXI_ARADDR[0]),
        .I5(axireg_timing_ki[9]),
        .O(\axi_rdata[9]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \axi_rdata[9]_i_4 
       (.I0(axireg_timing_kp[9]),
        .I1(axireg_costas_ki[9]),
        .I2(S_AXI_ARADDR[1]),
        .I3(axireg_costas_kp[9]),
        .I4(S_AXI_ARADDR[0]),
        .I5(data4[9]),
        .O(\axi_rdata[9]_i_4_n_0 ));
  FDRE \axi_rdata_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[0]_i_1_n_0 ),
        .Q(S_AXI_RDATA[0]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[10]_i_1_n_0 ),
        .Q(S_AXI_RDATA[10]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[11]_i_1_n_0 ),
        .Q(S_AXI_RDATA[11]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[12]_i_1_n_0 ),
        .Q(S_AXI_RDATA[12]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[13]_i_1_n_0 ),
        .Q(S_AXI_RDATA[13]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[14]_i_1_n_0 ),
        .Q(S_AXI_RDATA[14]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[15]_i_1_n_0 ),
        .Q(S_AXI_RDATA[15]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[16]_i_1_n_0 ),
        .Q(S_AXI_RDATA[16]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[17]_i_1_n_0 ),
        .Q(S_AXI_RDATA[17]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[18]_i_1_n_0 ),
        .Q(S_AXI_RDATA[18]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[19]_i_1_n_0 ),
        .Q(S_AXI_RDATA[19]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[1]_i_1_n_0 ),
        .Q(S_AXI_RDATA[1]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[20]_i_1_n_0 ),
        .Q(S_AXI_RDATA[20]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[21]_i_1_n_0 ),
        .Q(S_AXI_RDATA[21]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[22]_i_1_n_0 ),
        .Q(S_AXI_RDATA[22]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[23]_i_1_n_0 ),
        .Q(S_AXI_RDATA[23]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[24]_i_1_n_0 ),
        .Q(S_AXI_RDATA[24]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[25]_i_1_n_0 ),
        .Q(S_AXI_RDATA[25]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[26]_i_1_n_0 ),
        .Q(S_AXI_RDATA[26]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[27]_i_1_n_0 ),
        .Q(S_AXI_RDATA[27]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[28]_i_1_n_0 ),
        .Q(S_AXI_RDATA[28]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[29]_i_1_n_0 ),
        .Q(S_AXI_RDATA[29]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[2]_i_1_n_0 ),
        .Q(S_AXI_RDATA[2]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[30]_i_1_n_0 ),
        .Q(S_AXI_RDATA[30]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[31]_i_1_n_0 ),
        .Q(S_AXI_RDATA[31]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[3]_i_1_n_0 ),
        .Q(S_AXI_RDATA[3]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[4]_i_1_n_0 ),
        .Q(S_AXI_RDATA[4]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[5]_i_1_n_0 ),
        .Q(S_AXI_RDATA[5]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[6]_i_1_n_0 ),
        .Q(S_AXI_RDATA[6]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[7]_i_1_n_0 ),
        .Q(S_AXI_RDATA[7]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[8]_i_1_n_0 ),
        .Q(S_AXI_RDATA[8]),
        .R(p_0_in__0_1));
  FDRE \axi_rdata_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(axi_arready0),
        .D(\axi_rdata[9]_i_1_n_0 ),
        .Q(S_AXI_RDATA[9]),
        .R(p_0_in__0_1));
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
        .R(p_0_in__0_1));
  LUT4 #(
    .INIT(16'h0800)) 
    \axireg_agc_ki_shift[3]_i_1 
       (.I0(\w_strb_reg_n_0_[2] ),
        .I1(p_0_in_0[2]),
        .I2(p_0_in_0[0]),
        .I3(axireg_enable_i_2_n_0),
        .O(axireg_agc_ki_shift));
  FDRE \axireg_agc_ki_shift_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(axireg_agc_ki_shift),
        .D(\w_data_reg_n_0_[16] ),
        .Q(data4[16]),
        .R(p_0_in__0_1));
  FDSE \axireg_agc_ki_shift_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(axireg_agc_ki_shift),
        .D(\w_data_reg_n_0_[17] ),
        .Q(data4[17]),
        .S(p_0_in__0_1));
  FDRE \axireg_agc_ki_shift_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(axireg_agc_ki_shift),
        .D(\w_data_reg_n_0_[18] ),
        .Q(data4[18]),
        .R(p_0_in__0_1));
  FDSE \axireg_agc_ki_shift_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(axireg_agc_ki_shift),
        .D(\w_data_reg_n_0_[19] ),
        .Q(data4[19]),
        .S(p_0_in__0_1));
  LUT4 #(
    .INIT(16'h0800)) 
    \axireg_agc_target[15]_i_1 
       (.I0(p_1_in0),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[2]),
        .I3(\axireg_sps[7]_i_2_n_0 ),
        .O(\axireg_agc_target[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \axireg_agc_target[7]_i_1 
       (.I0(p_1_in),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[2]),
        .I3(\axireg_sps[7]_i_2_n_0 ),
        .O(\axireg_agc_target[7]_i_1_n_0 ));
  FDRE \axireg_agc_target_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[0] ),
        .Q(axireg_agc_target[0]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[10] ),
        .Q(axireg_agc_target[10]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[11] ),
        .Q(axireg_agc_target[11]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[12] ),
        .Q(axireg_agc_target[12]),
        .R(p_0_in__0_1));
  FDSE \axireg_agc_target_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[13] ),
        .Q(axireg_agc_target[13]),
        .S(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[14] ),
        .Q(axireg_agc_target[14]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[15] ),
        .Q(axireg_agc_target[15]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[1] ),
        .Q(axireg_agc_target[1]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[2] ),
        .Q(axireg_agc_target[2]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[3] ),
        .Q(axireg_agc_target[3]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[4] ),
        .Q(axireg_agc_target[4]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[5] ),
        .Q(axireg_agc_target[5]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[6] ),
        .Q(axireg_agc_target[6]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[7] ),
        .Q(axireg_agc_target[7]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[8] ),
        .Q(axireg_agc_target[8]),
        .R(p_0_in__0_1));
  FDRE \axireg_agc_target_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_agc_target[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[9] ),
        .Q(axireg_agc_target[9]),
        .R(p_0_in__0_1));
  FDRE axireg_bypass_agc_reg
       (.C(S_AXI_ACLK),
        .CE(axireg_enable),
        .D(\w_data_reg_n_0_[1] ),
        .Q(data0[1]),
        .R(p_0_in__0_1));
  FDRE axireg_bypass_costas_reg
       (.C(S_AXI_ACLK),
        .CE(axireg_enable),
        .D(\w_data_reg_n_0_[2] ),
        .Q(data0[2]),
        .R(p_0_in__0_1));
  FDRE axireg_bypass_timing_reg
       (.C(S_AXI_ACLK),
        .CE(axireg_enable),
        .D(\w_data_reg_n_0_[3] ),
        .Q(data0[3]),
        .R(p_0_in__0_1));
  LUT4 #(
    .INIT(16'h0800)) 
    \axireg_costas_ki[15]_i_1 
       (.I0(p_1_in0),
        .I1(p_0_in_0[2]),
        .I2(p_0_in_0[0]),
        .I3(\axireg_sps[7]_i_2_n_0 ),
        .O(\axireg_costas_ki[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \axireg_costas_ki[7]_i_1 
       (.I0(p_0_in_0[2]),
        .I1(p_1_in),
        .I2(p_0_in_0[0]),
        .I3(\axireg_sps[7]_i_2_n_0 ),
        .O(\axireg_costas_ki[7]_i_1_n_0 ));
  FDRE \axireg_costas_ki_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[0] ),
        .Q(axireg_costas_ki[0]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[10] ),
        .Q(axireg_costas_ki[10]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[11] ),
        .Q(axireg_costas_ki[11]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[12] ),
        .Q(axireg_costas_ki[12]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[13] ),
        .Q(axireg_costas_ki[13]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[14] ),
        .Q(axireg_costas_ki[14]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[15] ),
        .Q(axireg_costas_ki[15]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[1] ),
        .Q(axireg_costas_ki[1]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[2] ),
        .Q(axireg_costas_ki[2]),
        .R(p_0_in__0_1));
  FDSE \axireg_costas_ki_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[3] ),
        .Q(axireg_costas_ki[3]),
        .S(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[4] ),
        .Q(axireg_costas_ki[4]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[5] ),
        .Q(axireg_costas_ki[5]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[6] ),
        .Q(axireg_costas_ki[6]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[7] ),
        .Q(axireg_costas_ki[7]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[8] ),
        .Q(axireg_costas_ki[8]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_ki_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[9] ),
        .Q(axireg_costas_ki[9]),
        .R(p_0_in__0_1));
  LUT4 #(
    .INIT(16'h8000)) 
    \axireg_costas_kp[15]_i_1 
       (.I0(p_1_in0),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[2]),
        .I3(axireg_enable_i_2_n_0),
        .O(\axireg_costas_kp[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \axireg_costas_kp[7]_i_1 
       (.I0(p_1_in),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[2]),
        .I3(axireg_enable_i_2_n_0),
        .O(\axireg_costas_kp[7]_i_1_n_0 ));
  FDRE \axireg_costas_kp_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[0] ),
        .Q(axireg_costas_kp[0]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[10] ),
        .Q(axireg_costas_kp[10]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[11] ),
        .Q(axireg_costas_kp[11]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[12] ),
        .Q(axireg_costas_kp[12]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[13] ),
        .Q(axireg_costas_kp[13]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[14] ),
        .Q(axireg_costas_kp[14]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[15] ),
        .Q(axireg_costas_kp[15]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[1] ),
        .Q(axireg_costas_kp[1]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[2] ),
        .Q(axireg_costas_kp[2]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[3] ),
        .Q(axireg_costas_kp[3]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[4] ),
        .Q(axireg_costas_kp[4]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[5] ),
        .Q(axireg_costas_kp[5]),
        .R(p_0_in__0_1));
  FDSE \axireg_costas_kp_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[6] ),
        .Q(axireg_costas_kp[6]),
        .S(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[7] ),
        .Q(axireg_costas_kp[7]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[8] ),
        .Q(axireg_costas_kp[8]),
        .R(p_0_in__0_1));
  FDRE \axireg_costas_kp_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_costas_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[9] ),
        .Q(axireg_costas_kp[9]),
        .R(p_0_in__0_1));
  LUT4 #(
    .INIT(16'h0400)) 
    axireg_enable_i_1
       (.I0(p_0_in_0[2]),
        .I1(p_1_in),
        .I2(p_0_in_0[0]),
        .I3(axireg_enable_i_2_n_0),
        .O(axireg_enable));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT5 #(
    .INIT(32'h00000100)) 
    axireg_enable_i_2
       (.I0(p_0_in_0[3]),
        .I1(\aw_addr_reg_n_0_[7] ),
        .I2(p_0_in0),
        .I3(do_write),
        .I4(p_0_in_0[1]),
        .O(axireg_enable_i_2_n_0));
  FDRE axireg_enable_reg
       (.C(S_AXI_ACLK),
        .CE(axireg_enable),
        .D(\w_data_reg_n_0_[0] ),
        .Q(data0[0]),
        .R(p_0_in__0_1));
  LUT4 #(
    .INIT(16'h0400)) 
    \axireg_sps[7]_i_1 
       (.I0(p_0_in_0[2]),
        .I1(p_1_in),
        .I2(p_0_in_0[0]),
        .I3(\axireg_sps[7]_i_2_n_0 ),
        .O(axireg_sps));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT5 #(
    .INIT(32'h01000000)) 
    \axireg_sps[7]_i_2 
       (.I0(p_0_in_0[3]),
        .I1(\aw_addr_reg_n_0_[7] ),
        .I2(p_0_in0),
        .I3(do_write),
        .I4(p_0_in_0[1]),
        .O(\axireg_sps[7]_i_2_n_0 ));
  FDRE \axireg_sps_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(axireg_sps),
        .D(\w_data_reg_n_0_[0] ),
        .Q(\axireg_sps_reg_n_0_[0] ),
        .R(p_0_in__0_1));
  FDRE \axireg_sps_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(axireg_sps),
        .D(\w_data_reg_n_0_[1] ),
        .Q(\axireg_sps_reg_n_0_[1] ),
        .R(p_0_in__0_1));
  FDRE \axireg_sps_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(axireg_sps),
        .D(\w_data_reg_n_0_[2] ),
        .Q(\axireg_sps_reg_n_0_[2] ),
        .R(p_0_in__0_1));
  FDSE \axireg_sps_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(axireg_sps),
        .D(\w_data_reg_n_0_[3] ),
        .Q(\axireg_sps_reg_n_0_[3] ),
        .S(p_0_in__0_1));
  FDRE \axireg_sps_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(axireg_sps),
        .D(\w_data_reg_n_0_[4] ),
        .Q(\axireg_sps_reg_n_0_[4] ),
        .R(p_0_in__0_1));
  FDRE \axireg_sps_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(axireg_sps),
        .D(\w_data_reg_n_0_[5] ),
        .Q(\axireg_sps_reg_n_0_[5] ),
        .R(p_0_in__0_1));
  FDRE \axireg_sps_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(axireg_sps),
        .D(\w_data_reg_n_0_[6] ),
        .Q(\axireg_sps_reg_n_0_[6] ),
        .R(p_0_in__0_1));
  FDRE \axireg_sps_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(axireg_sps),
        .D(\w_data_reg_n_0_[7] ),
        .Q(\axireg_sps_reg_n_0_[7] ),
        .R(p_0_in__0_1));
  LUT6 #(
    .INIT(64'h0002000000000000)) 
    \axireg_timing_ki[15]_i_1 
       (.I0(p_0_in_0[3]),
        .I1(p_0_in_0[2]),
        .I2(p_0_in_0[1]),
        .I3(p_0_in_0[0]),
        .I4(p_1_in0),
        .I5(\axireg_timing_ki[15]_i_2_n_0 ),
        .O(\axireg_timing_ki[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT5 #(
    .INIT(32'h00001000)) 
    \axireg_timing_ki[15]_i_2 
       (.I0(\aw_addr_reg_n_0_[7] ),
        .I1(p_0_in0),
        .I2(w_done_reg_n_0),
        .I3(aw_done),
        .I4(axi_bvalid_reg_0),
        .O(\axireg_timing_ki[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000020000000000)) 
    \axireg_timing_ki[7]_i_1 
       (.I0(p_1_in),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[2]),
        .I3(p_0_in_0[3]),
        .I4(p_0_in_0[1]),
        .I5(\axireg_timing_ki[15]_i_2_n_0 ),
        .O(\axireg_timing_ki[7]_i_1_n_0 ));
  FDRE \axireg_timing_ki_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[0] ),
        .Q(axireg_timing_ki[0]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[10] ),
        .Q(axireg_timing_ki[10]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[11] ),
        .Q(axireg_timing_ki[11]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[12] ),
        .Q(axireg_timing_ki[12]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[13] ),
        .Q(axireg_timing_ki[13]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[14] ),
        .Q(axireg_timing_ki[14]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[15] ),
        .Q(axireg_timing_ki[15]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[1] ),
        .Q(axireg_timing_ki[1]),
        .R(p_0_in__0_1));
  FDSE \axireg_timing_ki_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[2] ),
        .Q(axireg_timing_ki[2]),
        .S(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[3] ),
        .Q(axireg_timing_ki[3]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[4] ),
        .Q(axireg_timing_ki[4]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[5] ),
        .Q(axireg_timing_ki[5]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[6] ),
        .Q(axireg_timing_ki[6]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[7] ),
        .Q(axireg_timing_ki[7]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[8] ),
        .Q(axireg_timing_ki[8]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_ki_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_ki[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[9] ),
        .Q(axireg_timing_ki[9]),
        .R(p_0_in__0_1));
  LUT4 #(
    .INIT(16'h8000)) 
    \axireg_timing_kp[15]_i_1 
       (.I0(p_1_in0),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[2]),
        .I3(\axireg_sps[7]_i_2_n_0 ),
        .O(\axireg_timing_kp[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \axireg_timing_kp[7]_i_1 
       (.I0(p_1_in),
        .I1(p_0_in_0[0]),
        .I2(p_0_in_0[2]),
        .I3(\axireg_sps[7]_i_2_n_0 ),
        .O(\axireg_timing_kp[7]_i_1_n_0 ));
  FDRE \axireg_timing_kp_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[0] ),
        .Q(axireg_timing_kp[0]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[10] ),
        .Q(axireg_timing_kp[10]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[11] ),
        .Q(axireg_timing_kp[11]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[12] ),
        .Q(axireg_timing_kp[12]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[13] ),
        .Q(axireg_timing_kp[13]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[14] ),
        .Q(axireg_timing_kp[14]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[15] ),
        .Q(axireg_timing_kp[15]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[1] ),
        .Q(axireg_timing_kp[1]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[2] ),
        .Q(axireg_timing_kp[2]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[3] ),
        .Q(axireg_timing_kp[3]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[4] ),
        .Q(axireg_timing_kp[4]),
        .R(p_0_in__0_1));
  FDSE \axireg_timing_kp_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[5] ),
        .Q(axireg_timing_kp[5]),
        .S(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[6] ),
        .Q(axireg_timing_kp[6]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[7] ),
        .Q(axireg_timing_kp[7]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[8] ),
        .Q(axireg_timing_kp[8]),
        .R(p_0_in__0_1));
  FDRE \axireg_timing_kp_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(\axireg_timing_kp[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[9] ),
        .Q(axireg_timing_kp[9]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[0]),
        .Q(bit_cnt_ff1[0]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[10]),
        .Q(bit_cnt_ff1[10]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[11]),
        .Q(bit_cnt_ff1[11]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[12]),
        .Q(bit_cnt_ff1[12]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[13]),
        .Q(bit_cnt_ff1[13]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[14]),
        .Q(bit_cnt_ff1[14]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[15]),
        .Q(bit_cnt_ff1[15]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[16]),
        .Q(bit_cnt_ff1[16]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[17]),
        .Q(bit_cnt_ff1[17]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[18]),
        .Q(bit_cnt_ff1[18]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[19]),
        .Q(bit_cnt_ff1[19]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[1]),
        .Q(bit_cnt_ff1[1]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[20]),
        .Q(bit_cnt_ff1[20]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[21]),
        .Q(bit_cnt_ff1[21]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[22]),
        .Q(bit_cnt_ff1[22]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[23]),
        .Q(bit_cnt_ff1[23]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[24]),
        .Q(bit_cnt_ff1[24]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[25]),
        .Q(bit_cnt_ff1[25]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[26]),
        .Q(bit_cnt_ff1[26]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[27]),
        .Q(bit_cnt_ff1[27]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[28]),
        .Q(bit_cnt_ff1[28]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[29]),
        .Q(bit_cnt_ff1[29]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[2]),
        .Q(bit_cnt_ff1[2]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[30]),
        .Q(bit_cnt_ff1[30]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[31]),
        .Q(bit_cnt_ff1[31]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[32] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[32]),
        .Q(bit_cnt_ff1[32]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[33] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[33]),
        .Q(bit_cnt_ff1[33]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[34] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[34]),
        .Q(bit_cnt_ff1[34]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[35] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[35]),
        .Q(bit_cnt_ff1[35]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[36] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[36]),
        .Q(bit_cnt_ff1[36]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[37] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[37]),
        .Q(bit_cnt_ff1[37]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[38] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[38]),
        .Q(bit_cnt_ff1[38]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[39] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[39]),
        .Q(bit_cnt_ff1[39]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[3]),
        .Q(bit_cnt_ff1[3]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[4]),
        .Q(bit_cnt_ff1[4]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[5]),
        .Q(bit_cnt_ff1[5]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[6]),
        .Q(bit_cnt_ff1[6]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[7]),
        .Q(bit_cnt_ff1[7]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[8]),
        .Q(bit_cnt_ff1[8]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff1_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_bit_count[9]),
        .Q(bit_cnt_ff1[9]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[0]),
        .Q(\bit_cnt_ff2_reg_n_0_[0] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[10]),
        .Q(\bit_cnt_ff2_reg_n_0_[10] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[11]),
        .Q(\bit_cnt_ff2_reg_n_0_[11] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[12]),
        .Q(\bit_cnt_ff2_reg_n_0_[12] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[13]),
        .Q(\bit_cnt_ff2_reg_n_0_[13] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[14]),
        .Q(\bit_cnt_ff2_reg_n_0_[14] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[15]),
        .Q(\bit_cnt_ff2_reg_n_0_[15] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[16]),
        .Q(\bit_cnt_ff2_reg_n_0_[16] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[17]),
        .Q(\bit_cnt_ff2_reg_n_0_[17] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[18]),
        .Q(\bit_cnt_ff2_reg_n_0_[18] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[19]),
        .Q(\bit_cnt_ff2_reg_n_0_[19] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[1]),
        .Q(\bit_cnt_ff2_reg_n_0_[1] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[20]),
        .Q(\bit_cnt_ff2_reg_n_0_[20] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[21]),
        .Q(\bit_cnt_ff2_reg_n_0_[21] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[22]),
        .Q(\bit_cnt_ff2_reg_n_0_[22] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[23]),
        .Q(\bit_cnt_ff2_reg_n_0_[23] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[24]),
        .Q(\bit_cnt_ff2_reg_n_0_[24] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[25]),
        .Q(\bit_cnt_ff2_reg_n_0_[25] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[26]),
        .Q(\bit_cnt_ff2_reg_n_0_[26] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[27]),
        .Q(\bit_cnt_ff2_reg_n_0_[27] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[28]),
        .Q(\bit_cnt_ff2_reg_n_0_[28] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[29]),
        .Q(\bit_cnt_ff2_reg_n_0_[29] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[2]),
        .Q(\bit_cnt_ff2_reg_n_0_[2] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[30]),
        .Q(\bit_cnt_ff2_reg_n_0_[30] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[31]),
        .Q(\bit_cnt_ff2_reg_n_0_[31] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[32] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[32]),
        .Q(data12[0]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[33] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[33]),
        .Q(data12[1]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[34] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[34]),
        .Q(data12[2]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[35] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[35]),
        .Q(data12[3]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[36] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[36]),
        .Q(data12[4]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[37] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[37]),
        .Q(data12[5]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[38] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[38]),
        .Q(data12[6]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[39] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[39]),
        .Q(data12[7]),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[3]),
        .Q(\bit_cnt_ff2_reg_n_0_[3] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[4]),
        .Q(\bit_cnt_ff2_reg_n_0_[4] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[5]),
        .Q(\bit_cnt_ff2_reg_n_0_[5] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[6]),
        .Q(\bit_cnt_ff2_reg_n_0_[6] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[7]),
        .Q(\bit_cnt_ff2_reg_n_0_[7] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[8]),
        .Q(\bit_cnt_ff2_reg_n_0_[8] ),
        .R(p_0_in__0_1));
  FDRE \bit_cnt_ff2_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bit_cnt_ff1[9]),
        .Q(\bit_cnt_ff2_reg_n_0_[9] ),
        .R(p_0_in__0_1));
  FDCE \core_agc_ki_shift_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_ki_shift[0]),
        .Q(core_agc_ki_shift[0]));
  FDPE \core_agc_ki_shift_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_agc_ki_shift[1]),
        .PRE(aresetn_0),
        .Q(core_agc_ki_shift[1]));
  FDCE \core_agc_ki_shift_reg[2] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_ki_shift[2]),
        .Q(core_agc_ki_shift[2]));
  FDPE \core_agc_ki_shift_reg[3] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_agc_ki_shift[3]),
        .PRE(aresetn_0),
        .Q(core_agc_ki_shift[3]));
  FDCE \core_agc_target_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[0]),
        .Q(core_agc_target[0]));
  FDCE \core_agc_target_reg[10] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[10]),
        .Q(core_agc_target[10]));
  FDCE \core_agc_target_reg[11] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[11]),
        .Q(core_agc_target[11]));
  FDCE \core_agc_target_reg[12] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[12]),
        .Q(core_agc_target[12]));
  FDPE \core_agc_target_reg[13] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_agc_target[13]),
        .PRE(aresetn_0),
        .Q(core_agc_target[13]));
  FDCE \core_agc_target_reg[14] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[14]),
        .Q(core_agc_target[14]));
  FDCE \core_agc_target_reg[15] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[15]),
        .Q(core_agc_target[15]));
  FDCE \core_agc_target_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[1]),
        .Q(core_agc_target[1]));
  FDCE \core_agc_target_reg[2] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[2]),
        .Q(core_agc_target[2]));
  FDCE \core_agc_target_reg[3] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[3]),
        .Q(core_agc_target[3]));
  FDCE \core_agc_target_reg[4] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[4]),
        .Q(core_agc_target[4]));
  FDCE \core_agc_target_reg[5] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[5]),
        .Q(core_agc_target[5]));
  FDCE \core_agc_target_reg[6] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[6]),
        .Q(core_agc_target[6]));
  FDCE \core_agc_target_reg[7] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[7]),
        .Q(core_agc_target[7]));
  FDCE \core_agc_target_reg[8] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[8]),
        .Q(core_agc_target[8]));
  FDCE \core_agc_target_reg[9] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_agc_target[9]),
        .Q(core_agc_target[9]));
  FDCE core_bypass_agc_reg
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_bypass_agc),
        .Q(core_bypass_agc));
  FDCE core_bypass_costas_reg
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_bypass_costas),
        .Q(core_bypass_costas));
  FDCE core_bypass_timing_reg
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_bypass_timing),
        .Q(core_bypass_timing));
  FDCE \core_costas_ki_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[0]),
        .Q(core_costas_ki[0]));
  FDCE \core_costas_ki_reg[10] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[10]),
        .Q(core_costas_ki[10]));
  FDCE \core_costas_ki_reg[11] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[11]),
        .Q(core_costas_ki[11]));
  FDCE \core_costas_ki_reg[12] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[12]),
        .Q(core_costas_ki[12]));
  FDCE \core_costas_ki_reg[13] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[13]),
        .Q(core_costas_ki[13]));
  FDCE \core_costas_ki_reg[14] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[14]),
        .Q(core_costas_ki[14]));
  FDCE \core_costas_ki_reg[15] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[15]),
        .Q(core_costas_ki[15]));
  FDCE \core_costas_ki_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[1]),
        .Q(core_costas_ki[1]));
  FDCE \core_costas_ki_reg[2] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[2]),
        .Q(core_costas_ki[2]));
  FDPE \core_costas_ki_reg[3] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_costas_ki[3]),
        .PRE(aresetn_0),
        .Q(core_costas_ki[3]));
  FDCE \core_costas_ki_reg[4] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[4]),
        .Q(core_costas_ki[4]));
  FDCE \core_costas_ki_reg[5] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[5]),
        .Q(core_costas_ki[5]));
  FDCE \core_costas_ki_reg[6] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[6]),
        .Q(core_costas_ki[6]));
  FDCE \core_costas_ki_reg[7] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[7]),
        .Q(core_costas_ki[7]));
  FDCE \core_costas_ki_reg[8] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[8]),
        .Q(core_costas_ki[8]));
  FDCE \core_costas_ki_reg[9] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_ki[9]),
        .Q(core_costas_ki[9]));
  FDCE \core_costas_kp_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[0]),
        .Q(core_costas_kp[0]));
  FDCE \core_costas_kp_reg[10] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[10]),
        .Q(core_costas_kp[10]));
  FDCE \core_costas_kp_reg[11] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[11]),
        .Q(core_costas_kp[11]));
  FDCE \core_costas_kp_reg[12] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[12]),
        .Q(core_costas_kp[12]));
  FDCE \core_costas_kp_reg[13] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[13]),
        .Q(core_costas_kp[13]));
  FDCE \core_costas_kp_reg[14] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[14]),
        .Q(core_costas_kp[14]));
  FDCE \core_costas_kp_reg[15] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[15]),
        .Q(core_costas_kp[15]));
  FDCE \core_costas_kp_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[1]),
        .Q(core_costas_kp[1]));
  FDCE \core_costas_kp_reg[2] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[2]),
        .Q(core_costas_kp[2]));
  FDCE \core_costas_kp_reg[3] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[3]),
        .Q(core_costas_kp[3]));
  FDCE \core_costas_kp_reg[4] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[4]),
        .Q(core_costas_kp[4]));
  FDCE \core_costas_kp_reg[5] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[5]),
        .Q(core_costas_kp[5]));
  FDPE \core_costas_kp_reg[6] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_costas_kp[6]),
        .PRE(aresetn_0),
        .Q(core_costas_kp[6]));
  FDCE \core_costas_kp_reg[7] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[7]),
        .Q(core_costas_kp[7]));
  FDCE \core_costas_kp_reg[8] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[8]),
        .Q(core_costas_kp[8]));
  FDCE \core_costas_kp_reg[9] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_costas_kp[9]),
        .Q(core_costas_kp[9]));
  FDCE core_enable_reg
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_enable),
        .Q(core_enable));
  FDCE \core_sps_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_sps[0]),
        .Q(core_sps[0]));
  FDCE \core_sps_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_sps[1]),
        .Q(core_sps[1]));
  FDCE \core_sps_reg[2] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_sps[2]),
        .Q(core_sps[2]));
  FDPE \core_sps_reg[3] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_sps[3]),
        .PRE(aresetn_0),
        .Q(core_sps[3]));
  FDCE \core_sps_reg[4] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_sps[4]),
        .Q(core_sps[4]));
  FDCE \core_sps_reg[5] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_sps[5]),
        .Q(core_sps[5]));
  FDCE \core_sps_reg[6] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_sps[6]),
        .Q(core_sps[6]));
  FDCE \core_sps_reg[7] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_sps[7]),
        .Q(core_sps[7]));
  FDCE \core_timing_ki_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[0]),
        .Q(core_timing_ki[0]));
  FDCE \core_timing_ki_reg[10] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[10]),
        .Q(core_timing_ki[10]));
  FDCE \core_timing_ki_reg[11] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[11]),
        .Q(core_timing_ki[11]));
  FDCE \core_timing_ki_reg[12] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[12]),
        .Q(core_timing_ki[12]));
  FDCE \core_timing_ki_reg[13] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[13]),
        .Q(core_timing_ki[13]));
  FDCE \core_timing_ki_reg[14] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[14]),
        .Q(core_timing_ki[14]));
  FDCE \core_timing_ki_reg[15] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[15]),
        .Q(core_timing_ki[15]));
  FDCE \core_timing_ki_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[1]),
        .Q(core_timing_ki[1]));
  FDPE \core_timing_ki_reg[2] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_timing_ki[2]),
        .PRE(aresetn_0),
        .Q(core_timing_ki[2]));
  FDCE \core_timing_ki_reg[3] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[3]),
        .Q(core_timing_ki[3]));
  FDCE \core_timing_ki_reg[4] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[4]),
        .Q(core_timing_ki[4]));
  FDCE \core_timing_ki_reg[5] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[5]),
        .Q(core_timing_ki[5]));
  FDCE \core_timing_ki_reg[6] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[6]),
        .Q(core_timing_ki[6]));
  FDCE \core_timing_ki_reg[7] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[7]),
        .Q(core_timing_ki[7]));
  FDCE \core_timing_ki_reg[8] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[8]),
        .Q(core_timing_ki[8]));
  FDCE \core_timing_ki_reg[9] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_ki[9]),
        .Q(core_timing_ki[9]));
  FDCE \core_timing_kp_reg[0] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[0]),
        .Q(core_timing_kp[0]));
  FDCE \core_timing_kp_reg[10] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[10]),
        .Q(core_timing_kp[10]));
  FDCE \core_timing_kp_reg[11] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[11]),
        .Q(core_timing_kp[11]));
  FDCE \core_timing_kp_reg[12] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[12]),
        .Q(core_timing_kp[12]));
  FDCE \core_timing_kp_reg[13] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[13]),
        .Q(core_timing_kp[13]));
  FDCE \core_timing_kp_reg[14] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[14]),
        .Q(core_timing_kp[14]));
  FDCE \core_timing_kp_reg[15] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[15]),
        .Q(core_timing_kp[15]));
  FDCE \core_timing_kp_reg[1] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[1]),
        .Q(core_timing_kp[1]));
  FDCE \core_timing_kp_reg[2] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[2]),
        .Q(core_timing_kp[2]));
  FDCE \core_timing_kp_reg[3] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[3]),
        .Q(core_timing_kp[3]));
  FDCE \core_timing_kp_reg[4] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[4]),
        .Q(core_timing_kp[4]));
  FDPE \core_timing_kp_reg[5] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .D(snap_timing_kp[5]),
        .PRE(aresetn_0),
        .Q(core_timing_kp[5]));
  FDCE \core_timing_kp_reg[6] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[6]),
        .Q(core_timing_kp[6]));
  FDCE \core_timing_kp_reg[7] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[7]),
        .Q(core_timing_kp[7]));
  FDCE \core_timing_kp_reg[8] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[8]),
        .Q(core_timing_kp[8]));
  FDCE \core_timing_kp_reg[9] 
       (.C(aclk),
        .CE(wr_pulse_core),
        .CLR(aresetn_0),
        .D(snap_timing_kp[9]),
        .Q(core_timing_kp[9]));
  FDRE \locked_ff_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_carrier_locked),
        .Q(locked_ff[0]),
        .R(p_0_in__0_1));
  FDRE \locked_ff_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(locked_ff[0]),
        .Q(locked_ff[1]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(q_mix),
        .Q(phase_err_ff1[0]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[10]),
        .Q(phase_err_ff1[10]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[11]),
        .Q(phase_err_ff1[11]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[12]),
        .Q(phase_err_ff1[12]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[13]),
        .Q(phase_err_ff1[13]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[14]),
        .Q(phase_err_ff1[14]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[15]),
        .Q(phase_err_ff1[15]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[1]),
        .Q(phase_err_ff1[1]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[2]),
        .Q(phase_err_ff1[2]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[3]),
        .Q(phase_err_ff1[3]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[4]),
        .Q(phase_err_ff1[4]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[5]),
        .Q(phase_err_ff1[5]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[6]),
        .Q(phase_err_ff1[6]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[7]),
        .Q(phase_err_ff1[7]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[8]),
        .Q(phase_err_ff1[8]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff1_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_phase_err[9]),
        .Q(phase_err_ff1[9]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[0]),
        .Q(phase_err_ff2[0]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[10]),
        .Q(phase_err_ff2[10]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[11]),
        .Q(phase_err_ff2[11]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[12]),
        .Q(phase_err_ff2[12]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[13]),
        .Q(phase_err_ff2[13]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[14]),
        .Q(phase_err_ff2[14]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[15]),
        .Q(phase_err_ff2[15]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[1]),
        .Q(phase_err_ff2[1]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[2]),
        .Q(phase_err_ff2[2]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[3]),
        .Q(phase_err_ff2[3]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[4]),
        .Q(phase_err_ff2[4]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[5]),
        .Q(phase_err_ff2[5]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[6]),
        .Q(phase_err_ff2[6]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[7]),
        .Q(phase_err_ff2[7]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[8]),
        .Q(phase_err_ff2[8]),
        .R(p_0_in__0_1));
  FDRE \phase_err_ff2_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(phase_err_ff1[9]),
        .Q(phase_err_ff2[9]),
        .R(p_0_in__0_1));
  FDRE \settled_ff_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_agc_settled),
        .Q(settled_ff[0]),
        .R(p_0_in__0_1));
  FDRE \settled_ff_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(settled_ff[0]),
        .Q(settled_ff[1]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_ki_shift_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data4[16]),
        .Q(snap_agc_ki_shift[0]),
        .R(p_0_in__0_1));
  FDSE \snap_agc_ki_shift_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data4[17]),
        .Q(snap_agc_ki_shift[1]),
        .S(p_0_in__0_1));
  FDRE \snap_agc_ki_shift_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data4[18]),
        .Q(snap_agc_ki_shift[2]),
        .R(p_0_in__0_1));
  FDSE \snap_agc_ki_shift_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data4[19]),
        .Q(snap_agc_ki_shift[3]),
        .S(p_0_in__0_1));
  FDRE \snap_agc_target_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[0]),
        .Q(snap_agc_target[0]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[10]),
        .Q(snap_agc_target[10]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[11]),
        .Q(snap_agc_target[11]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[12]),
        .Q(snap_agc_target[12]),
        .R(p_0_in__0_1));
  FDSE \snap_agc_target_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[13]),
        .Q(snap_agc_target[13]),
        .S(p_0_in__0_1));
  FDRE \snap_agc_target_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[14]),
        .Q(snap_agc_target[14]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[15]),
        .Q(snap_agc_target[15]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[1]),
        .Q(snap_agc_target[1]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[2]),
        .Q(snap_agc_target[2]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[3]),
        .Q(snap_agc_target[3]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[4]),
        .Q(snap_agc_target[4]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[5]),
        .Q(snap_agc_target[5]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[6]),
        .Q(snap_agc_target[6]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[7]),
        .Q(snap_agc_target[7]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[8]),
        .Q(snap_agc_target[8]),
        .R(p_0_in__0_1));
  FDRE \snap_agc_target_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_agc_target[9]),
        .Q(snap_agc_target[9]),
        .R(p_0_in__0_1));
  FDRE snap_bypass_agc_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data0[1]),
        .Q(snap_bypass_agc),
        .R(p_0_in__0_1));
  FDRE snap_bypass_costas_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data0[2]),
        .Q(snap_bypass_costas),
        .R(p_0_in__0_1));
  FDRE snap_bypass_timing_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data0[3]),
        .Q(snap_bypass_timing),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[0]),
        .Q(snap_costas_ki[0]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[10]),
        .Q(snap_costas_ki[10]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[11]),
        .Q(snap_costas_ki[11]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[12]),
        .Q(snap_costas_ki[12]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[13]),
        .Q(snap_costas_ki[13]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[14]),
        .Q(snap_costas_ki[14]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[15]),
        .Q(snap_costas_ki[15]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[1]),
        .Q(snap_costas_ki[1]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[2]),
        .Q(snap_costas_ki[2]),
        .R(p_0_in__0_1));
  FDSE \snap_costas_ki_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[3]),
        .Q(snap_costas_ki[3]),
        .S(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[4]),
        .Q(snap_costas_ki[4]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[5]),
        .Q(snap_costas_ki[5]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[6]),
        .Q(snap_costas_ki[6]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[7]),
        .Q(snap_costas_ki[7]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[8]),
        .Q(snap_costas_ki[8]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_ki_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_ki[9]),
        .Q(snap_costas_ki[9]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[0]),
        .Q(snap_costas_kp[0]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[10]),
        .Q(snap_costas_kp[10]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[11]),
        .Q(snap_costas_kp[11]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[12]),
        .Q(snap_costas_kp[12]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[13]),
        .Q(snap_costas_kp[13]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[14]),
        .Q(snap_costas_kp[14]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[15]),
        .Q(snap_costas_kp[15]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[1]),
        .Q(snap_costas_kp[1]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[2]),
        .Q(snap_costas_kp[2]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[3]),
        .Q(snap_costas_kp[3]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[4]),
        .Q(snap_costas_kp[4]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[5]),
        .Q(snap_costas_kp[5]),
        .R(p_0_in__0_1));
  FDSE \snap_costas_kp_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[6]),
        .Q(snap_costas_kp[6]),
        .S(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[7]),
        .Q(snap_costas_kp[7]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[8]),
        .Q(snap_costas_kp[8]),
        .R(p_0_in__0_1));
  FDRE \snap_costas_kp_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_costas_kp[9]),
        .Q(snap_costas_kp[9]),
        .R(p_0_in__0_1));
  FDRE snap_enable_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(data0[0]),
        .Q(snap_enable),
        .R(p_0_in__0_1));
  FDRE \snap_sps_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\axireg_sps_reg_n_0_[0] ),
        .Q(snap_sps[0]),
        .R(p_0_in__0_1));
  FDRE \snap_sps_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\axireg_sps_reg_n_0_[1] ),
        .Q(snap_sps[1]),
        .R(p_0_in__0_1));
  FDRE \snap_sps_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\axireg_sps_reg_n_0_[2] ),
        .Q(snap_sps[2]),
        .R(p_0_in__0_1));
  FDSE \snap_sps_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\axireg_sps_reg_n_0_[3] ),
        .Q(snap_sps[3]),
        .S(p_0_in__0_1));
  FDRE \snap_sps_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\axireg_sps_reg_n_0_[4] ),
        .Q(snap_sps[4]),
        .R(p_0_in__0_1));
  FDRE \snap_sps_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\axireg_sps_reg_n_0_[5] ),
        .Q(snap_sps[5]),
        .R(p_0_in__0_1));
  FDRE \snap_sps_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\axireg_sps_reg_n_0_[6] ),
        .Q(snap_sps[6]),
        .R(p_0_in__0_1));
  FDRE \snap_sps_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\axireg_sps_reg_n_0_[7] ),
        .Q(snap_sps[7]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[0]),
        .Q(snap_timing_ki[0]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[10]),
        .Q(snap_timing_ki[10]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[11]),
        .Q(snap_timing_ki[11]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[12]),
        .Q(snap_timing_ki[12]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[13]),
        .Q(snap_timing_ki[13]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[14]),
        .Q(snap_timing_ki[14]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[15]),
        .Q(snap_timing_ki[15]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[1]),
        .Q(snap_timing_ki[1]),
        .R(p_0_in__0_1));
  FDSE \snap_timing_ki_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[2]),
        .Q(snap_timing_ki[2]),
        .S(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[3]),
        .Q(snap_timing_ki[3]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[4]),
        .Q(snap_timing_ki[4]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[5]),
        .Q(snap_timing_ki[5]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[6]),
        .Q(snap_timing_ki[6]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[7]),
        .Q(snap_timing_ki[7]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[8]),
        .Q(snap_timing_ki[8]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_ki_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_ki[9]),
        .Q(snap_timing_ki[9]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[0]),
        .Q(snap_timing_kp[0]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[10]),
        .Q(snap_timing_kp[10]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[11]),
        .Q(snap_timing_kp[11]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[12]),
        .Q(snap_timing_kp[12]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[13]),
        .Q(snap_timing_kp[13]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[14]),
        .Q(snap_timing_kp[14]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[15]),
        .Q(snap_timing_kp[15]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[1]),
        .Q(snap_timing_kp[1]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[2]),
        .Q(snap_timing_kp[2]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[3]),
        .Q(snap_timing_kp[3]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[4]),
        .Q(snap_timing_kp[4]),
        .R(p_0_in__0_1));
  FDSE \snap_timing_kp_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[5]),
        .Q(snap_timing_kp[5]),
        .S(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[6]),
        .Q(snap_timing_kp[6]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[7]),
        .Q(snap_timing_kp[7]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[8]),
        .Q(snap_timing_kp[8]),
        .R(p_0_in__0_1));
  FDRE \snap_timing_kp_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(axireg_timing_kp[9]),
        .Q(snap_timing_kp[9]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[0]),
        .Q(timing_err_ff1[0]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[10]),
        .Q(timing_err_ff1[10]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[11]),
        .Q(timing_err_ff1[11]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[12]),
        .Q(timing_err_ff1[12]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[13]),
        .Q(timing_err_ff1[13]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[14]),
        .Q(timing_err_ff1[14]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[15]),
        .Q(timing_err_ff1[15]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[1]),
        .Q(timing_err_ff1[1]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[2]),
        .Q(timing_err_ff1[2]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[3]),
        .Q(timing_err_ff1[3]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[4]),
        .Q(timing_err_ff1[4]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[5]),
        .Q(timing_err_ff1[5]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[6]),
        .Q(timing_err_ff1[6]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[7]),
        .Q(timing_err_ff1[7]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[8]),
        .Q(timing_err_ff1[8]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff1_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(raw_timing_err[9]),
        .Q(timing_err_ff1[9]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[0]),
        .Q(timing_err_ff2[0]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[10]),
        .Q(timing_err_ff2[10]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[11]),
        .Q(timing_err_ff2[11]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[12]),
        .Q(timing_err_ff2[12]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[13]),
        .Q(timing_err_ff2[13]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[14]),
        .Q(timing_err_ff2[14]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[15]),
        .Q(timing_err_ff2[15]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[1]),
        .Q(timing_err_ff2[1]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[2]),
        .Q(timing_err_ff2[2]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[3]),
        .Q(timing_err_ff2[3]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[4]),
        .Q(timing_err_ff2[4]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[5]),
        .Q(timing_err_ff2[5]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[6]),
        .Q(timing_err_ff2[6]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[7]),
        .Q(timing_err_ff2[7]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[8]),
        .Q(timing_err_ff2[8]),
        .R(p_0_in__0_1));
  FDRE \timing_err_ff2_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(timing_err_ff1[9]),
        .Q(timing_err_ff2[9]),
        .R(p_0_in__0_1));
  system_bpsk_demodulator_0_0_bpsk_demod_core u_demod_core
       (.B({raw_phase_err,q_mix}),
        .D(raw_agc_settled),
        .E(E),
        .M_AXIS_BITS_TDATA(M_AXIS_BITS_TDATA),
        .M_AXIS_BITS_TREADY(M_AXIS_BITS_TREADY),
        .M_AXIS_BITS_TVALID(M_AXIS_BITS_TVALID),
        .OPMODE(OPMODE),
        .Q(core_agc_target),
        .aclk(aclk),
        .adc_data(adc_data),
        .adc_valid(adc_valid),
        .agc_gain_out(raw_agc_gain),
        .aresetn(aresetn),
        .aresetn_0(aresetn_0),
        .bit_count(raw_bit_count),
        .c_locked_reg_0(raw_carrier_locked),
        .core_bypass_agc(core_bypass_agc),
        .core_bypass_costas(core_bypass_costas),
        .core_bypass_timing(core_bypass_timing),
        .core_enable(core_enable),
        .freq_int2_0(core_costas_ki),
        .freq_word2_0(core_costas_kp),
        .\gain_acc[11]_i_3 (core_agc_ki_shift),
        .\sps_eff_reg[7]_0 (core_sps),
        .timing_adj2_0(core_timing_kp),
        .timing_err_out(raw_timing_err),
        .timing_int0_0(core_timing_ki));
  FDRE \w_data_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[0]),
        .Q(\w_data_reg_n_0_[0] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[10]),
        .Q(\w_data_reg_n_0_[10] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[11]),
        .Q(\w_data_reg_n_0_[11] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[12]),
        .Q(\w_data_reg_n_0_[12] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[13]),
        .Q(\w_data_reg_n_0_[13] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[14]),
        .Q(\w_data_reg_n_0_[14] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[15]),
        .Q(\w_data_reg_n_0_[15] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[16]),
        .Q(\w_data_reg_n_0_[16] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[17]),
        .Q(\w_data_reg_n_0_[17] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[18]),
        .Q(\w_data_reg_n_0_[18] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[19]),
        .Q(\w_data_reg_n_0_[19] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[1]),
        .Q(\w_data_reg_n_0_[1] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[2]),
        .Q(\w_data_reg_n_0_[2] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[3]),
        .Q(\w_data_reg_n_0_[3] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[4]),
        .Q(\w_data_reg_n_0_[4] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[5]),
        .Q(\w_data_reg_n_0_[5] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[6]),
        .Q(\w_data_reg_n_0_[6] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[7]),
        .Q(\w_data_reg_n_0_[7] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[8]),
        .Q(\w_data_reg_n_0_[8] ),
        .R(p_0_in__0_1));
  FDRE \w_data_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WDATA[9]),
        .Q(\w_data_reg_n_0_[9] ),
        .R(p_0_in__0_1));
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
        .Q(p_1_in),
        .R(p_0_in__0_1));
  FDRE \w_strb_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WSTRB[1]),
        .Q(p_1_in0),
        .R(p_0_in__0_1));
  FDRE \w_strb_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(axi_wready0),
        .D(S_AXI_WSTRB[2]),
        .Q(\w_strb_reg_n_0_[2] ),
        .R(p_0_in__0_1));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
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
        .CLR(aresetn_0),
        .D(wr_pulse_axi),
        .Q(\wr_pulse_sync_reg_n_0_[0] ));
  FDCE \wr_pulse_sync_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn_0),
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
