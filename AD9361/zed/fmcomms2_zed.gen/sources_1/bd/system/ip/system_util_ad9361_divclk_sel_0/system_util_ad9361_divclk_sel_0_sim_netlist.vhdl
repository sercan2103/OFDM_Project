-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Wed Mar 25 18:27:46 2026
-- Host        : kemal-EXCALIBUR-G770 running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/kemal/Desktop/FMCOMM2andos/hdl/projects/fmcomms2/zed/fmcomms2_zed.gen/sources_1/bd/system/ip/system_util_ad9361_divclk_sel_0/system_util_ad9361_divclk_sel_0_sim_netlist.vhdl
-- Design      : system_util_ad9361_divclk_sel_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_util_ad9361_divclk_sel_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    Res : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of system_util_ad9361_divclk_sel_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of system_util_ad9361_divclk_sel_0 : entity is "system_util_ad9361_divclk_sel_0,util_reduced_logic_v2_0_4_util_reduced_logic,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of system_util_ad9361_divclk_sel_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of system_util_ad9361_divclk_sel_0 : entity is "util_reduced_logic_v2_0_4_util_reduced_logic,Vivado 2022.2";
end system_util_ad9361_divclk_sel_0;

architecture STRUCTURE of system_util_ad9361_divclk_sel_0 is
begin
Res_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Op1(0),
      I1 => Op1(1),
      O => Res
    );
end STRUCTURE;
