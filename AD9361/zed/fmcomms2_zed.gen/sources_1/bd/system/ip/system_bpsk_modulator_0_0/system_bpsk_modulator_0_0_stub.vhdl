-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Tue Mar 31 15:18:34 2026
-- Host        : kemal-EXCALIBUR-G770 running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/kemal/Desktop/FMCOMM2andos/zed/fmcomms2_zed.gen/sources_1/bd/system/ip/system_bpsk_modulator_0_0/system_bpsk_modulator_0_0_stub.vhdl
-- Design      : system_bpsk_modulator_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_bpsk_modulator_0_0 is
  Port ( 
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    S_AXI_ACLK : in STD_LOGIC;
    S_AXI_ARESETN : in STD_LOGIC;
    S_AXI_AWADDR : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_AWPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_AWVALID : in STD_LOGIC;
    S_AXI_AWREADY : out STD_LOGIC;
    S_AXI_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_WVALID : in STD_LOGIC;
    S_AXI_WREADY : out STD_LOGIC;
    S_AXI_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_BVALID : out STD_LOGIC;
    S_AXI_BREADY : in STD_LOGIC;
    S_AXI_ARADDR : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_ARPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_ARVALID : in STD_LOGIC;
    S_AXI_ARREADY : out STD_LOGIC;
    S_AXI_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_RVALID : out STD_LOGIC;
    S_AXI_RREADY : in STD_LOGIC;
    S_AXIS_BITS_TDATA : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXIS_BITS_TVALID : in STD_LOGIC;
    S_AXIS_BITS_TREADY : out STD_LOGIC;
    S_AXIS_DMA_TDATA : in STD_LOGIC_VECTOR ( 63 downto 0 );
    S_AXIS_DMA_TVALID : in STD_LOGIC;
    S_AXIS_DMA_TREADY : out STD_LOGIC;
    S_AXIS_DMA_TLAST : in STD_LOGIC;
    S_AXIS_DMA_TKEEP : in STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXIS_DAC_TDATA : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXIS_DAC_TVALID : out STD_LOGIC;
    M_AXIS_DAC_TREADY : in STD_LOGIC;
    M_AXIS_DAC_TLAST : out STD_LOGIC;
    M_AXIS_DAC_TKEEP : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end system_bpsk_modulator_0_0;

architecture stub of system_bpsk_modulator_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,aresetn,S_AXI_ACLK,S_AXI_ARESETN,S_AXI_AWADDR[7:0],S_AXI_AWPROT[2:0],S_AXI_AWVALID,S_AXI_AWREADY,S_AXI_WDATA[31:0],S_AXI_WSTRB[3:0],S_AXI_WVALID,S_AXI_WREADY,S_AXI_BRESP[1:0],S_AXI_BVALID,S_AXI_BREADY,S_AXI_ARADDR[7:0],S_AXI_ARPROT[2:0],S_AXI_ARVALID,S_AXI_ARREADY,S_AXI_RDATA[31:0],S_AXI_RRESP[1:0],S_AXI_RVALID,S_AXI_RREADY,S_AXIS_BITS_TDATA[7:0],S_AXIS_BITS_TVALID,S_AXIS_BITS_TREADY,S_AXIS_DMA_TDATA[63:0],S_AXIS_DMA_TVALID,S_AXIS_DMA_TREADY,S_AXIS_DMA_TLAST,S_AXIS_DMA_TKEEP[7:0],M_AXIS_DAC_TDATA[63:0],M_AXIS_DAC_TVALID,M_AXIS_DAC_TREADY,M_AXIS_DAC_TLAST,M_AXIS_DAC_TKEEP[7:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "bpsk_modulator_v1_0,Vivado 2022.2";
begin
end;
