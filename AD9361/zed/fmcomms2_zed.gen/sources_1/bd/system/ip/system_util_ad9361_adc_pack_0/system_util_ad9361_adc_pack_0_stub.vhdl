-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Wed Mar 25 18:28:37 2026
-- Host        : kemal-EXCALIBUR-G770 running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/kemal/Desktop/FMCOMM2andos/hdl/projects/fmcomms2/zed/fmcomms2_zed.gen/sources_1/bd/system/ip/system_util_ad9361_adc_pack_0/system_util_ad9361_adc_pack_0_stub.vhdl
-- Design      : system_util_ad9361_adc_pack_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_util_ad9361_adc_pack_0 is
  Port ( 
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    enable_0 : in STD_LOGIC;
    enable_1 : in STD_LOGIC;
    enable_2 : in STD_LOGIC;
    enable_3 : in STD_LOGIC;
    fifo_wr_en : in STD_LOGIC;
    fifo_wr_overflow : out STD_LOGIC;
    fifo_wr_data_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    fifo_wr_data_1 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    fifo_wr_data_2 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    fifo_wr_data_3 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    packed_fifo_wr_en : out STD_LOGIC;
    packed_fifo_wr_overflow : in STD_LOGIC;
    packed_fifo_wr_sync : out STD_LOGIC;
    packed_fifo_wr_data : out STD_LOGIC_VECTOR ( 63 downto 0 )
  );

end system_util_ad9361_adc_pack_0;

architecture stub of system_util_ad9361_adc_pack_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,reset,enable_0,enable_1,enable_2,enable_3,fifo_wr_en,fifo_wr_overflow,fifo_wr_data_0[15:0],fifo_wr_data_1[15:0],fifo_wr_data_2[15:0],fifo_wr_data_3[15:0],packed_fifo_wr_en,packed_fifo_wr_overflow,packed_fifo_wr_sync,packed_fifo_wr_data[63:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "util_cpack2,Vivado 2022.2";
begin
end;
