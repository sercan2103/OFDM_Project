-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Tue Mar 31 15:18:34 2026
-- Host        : kemal-EXCALIBUR-G770 running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/kemal/Desktop/FMCOMM2andos/zed/fmcomms2_zed.gen/sources_1/bd/system/ip/system_bpsk_modulator_0_0/system_bpsk_modulator_0_0_sim_netlist.vhdl
-- Design      : system_bpsk_modulator_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_bpsk_modulator_0_0_bpsk_core is
  port (
    SS : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 39 downto 0 );
    S_AXIS_BITS_TREADY : out STD_LOGIC;
    M_AXIS_DAC_TDATA : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXIS_DAC_TVALID : out STD_LOGIC;
    aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    core_enable : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    axis_bit_reg_0 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXIS_DAC_TREADY : in STD_LOGIC;
    \i_hold_reg[15]_0\ : in STD_LOGIC_VECTOR ( 15 downto 0 );
    \i_hold_reg[15]_1\ : in STD_LOGIC_VECTOR ( 15 downto 0 );
    core_ch_sel : in STD_LOGIC;
    \i_hold_reg[15]_i_4_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXIS_DMA_TDATA : in STD_LOGIC_VECTOR ( 63 downto 0 );
    S_AXIS_BITS_TDATA : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXIS_BITS_TVALID : in STD_LOGIC;
    S_AXIS_DMA_TVALID : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of system_bpsk_modulator_0_0_bpsk_core : entity is "bpsk_core";
end system_bpsk_modulator_0_0_bpsk_core;

architecture STRUCTURE of system_bpsk_modulator_0_0_bpsk_core is
  signal \^d\ : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal \^ss\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal S_AXIS_BITS_TREADY_INST_0_i_2_n_0 : STD_LOGIC;
  signal S_AXIS_BITS_TREADY_INST_0_i_3_n_0 : STD_LOGIC;
  signal S_AXIS_BITS_TREADY_INST_0_i_4_n_0 : STD_LOGIC;
  signal S_AXIS_BITS_TREADY_INST_0_i_5_n_0 : STD_LOGIC;
  signal alt_bit : STD_LOGIC;
  signal alt_bit_i_1_n_0 : STD_LOGIC;
  signal axis_bit : STD_LOGIC;
  signal axis_bit_i_1_n_0 : STD_LOGIC;
  signal data1 : STD_LOGIC_VECTOR ( 15 downto 1 );
  signal div_cnt : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \div_cnt0_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__0_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__0_n_1\ : STD_LOGIC;
  signal \div_cnt0_carry__0_n_2\ : STD_LOGIC;
  signal \div_cnt0_carry__0_n_3\ : STD_LOGIC;
  signal \div_cnt0_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__1_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__1_n_1\ : STD_LOGIC;
  signal \div_cnt0_carry__1_n_2\ : STD_LOGIC;
  signal \div_cnt0_carry__1_n_3\ : STD_LOGIC;
  signal \div_cnt0_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \div_cnt0_carry__2_n_2\ : STD_LOGIC;
  signal \div_cnt0_carry__2_n_3\ : STD_LOGIC;
  signal div_cnt0_carry_i_1_n_0 : STD_LOGIC;
  signal div_cnt0_carry_i_2_n_0 : STD_LOGIC;
  signal div_cnt0_carry_i_3_n_0 : STD_LOGIC;
  signal div_cnt0_carry_i_4_n_0 : STD_LOGIC;
  signal div_cnt0_carry_n_0 : STD_LOGIC;
  signal div_cnt0_carry_n_1 : STD_LOGIC;
  signal div_cnt0_carry_n_2 : STD_LOGIC;
  signal div_cnt0_carry_n_3 : STD_LOGIC;
  signal div_cnt1 : STD_LOGIC_VECTOR ( 15 downto 1 );
  signal \div_cnt1_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__0_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__0_n_1\ : STD_LOGIC;
  signal \div_cnt1_carry__0_n_2\ : STD_LOGIC;
  signal \div_cnt1_carry__0_n_3\ : STD_LOGIC;
  signal \div_cnt1_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__1_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__1_n_1\ : STD_LOGIC;
  signal \div_cnt1_carry__1_n_2\ : STD_LOGIC;
  signal \div_cnt1_carry__1_n_3\ : STD_LOGIC;
  signal \div_cnt1_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \div_cnt1_carry__2_n_2\ : STD_LOGIC;
  signal \div_cnt1_carry__2_n_3\ : STD_LOGIC;
  signal div_cnt1_carry_i_1_n_0 : STD_LOGIC;
  signal div_cnt1_carry_i_2_n_0 : STD_LOGIC;
  signal div_cnt1_carry_i_3_n_0 : STD_LOGIC;
  signal div_cnt1_carry_i_4_n_0 : STD_LOGIC;
  signal div_cnt1_carry_n_0 : STD_LOGIC;
  signal div_cnt1_carry_n_1 : STD_LOGIC;
  signal div_cnt1_carry_n_2 : STD_LOGIC;
  signal div_cnt1_carry_n_3 : STD_LOGIC;
  signal \div_cnt[15]_i_1_n_0\ : STD_LOGIC;
  signal \div_cnt[15]_i_3_n_0\ : STD_LOGIC;
  signal \div_cnt[15]_i_4_n_0\ : STD_LOGIC;
  signal \div_cnt[15]_i_5_n_0\ : STD_LOGIC;
  signal \div_cnt[15]_i_6_n_0\ : STD_LOGIC;
  signal \div_cnt[15]_i_7_n_0\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[10]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[11]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[12]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[13]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[14]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[15]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[2]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[3]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[4]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[5]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[6]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[7]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[8]\ : STD_LOGIC;
  signal \div_cnt_reg_n_0_[9]\ : STD_LOGIC;
  signal i_hold : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \i_hold[0]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[10]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[11]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[12]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[13]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[14]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[15]_i_10_n_0\ : STD_LOGIC;
  signal \i_hold[15]_i_11_n_0\ : STD_LOGIC;
  signal \i_hold[15]_i_12_n_0\ : STD_LOGIC;
  signal \i_hold[15]_i_13_n_0\ : STD_LOGIC;
  signal \i_hold[15]_i_14_n_0\ : STD_LOGIC;
  signal \i_hold[15]_i_15_n_0\ : STD_LOGIC;
  signal \i_hold[15]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[15]_i_2_n_0\ : STD_LOGIC;
  signal \i_hold[15]_i_3_n_0\ : STD_LOGIC;
  signal \i_hold[15]_i_8_n_0\ : STD_LOGIC;
  signal \i_hold[15]_i_9_n_0\ : STD_LOGIC;
  signal \i_hold[1]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[2]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[3]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[4]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[5]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[6]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[7]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[8]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold[9]_i_1_n_0\ : STD_LOGIC;
  signal \i_hold_reg[15]_i_4_n_0\ : STD_LOGIC;
  signal \i_hold_reg[15]_i_5_n_0\ : STD_LOGIC;
  signal \i_hold_reg[15]_i_6_n_0\ : STD_LOGIC;
  signal \i_hold_reg[15]_i_7_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[0]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[10]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[11]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[12]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[13]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[14]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[15]_i_2_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[1]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[2]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[32]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[33]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[34]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[35]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[36]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[37]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[38]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[39]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[3]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[40]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[41]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[42]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[43]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[44]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[45]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[46]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[47]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[47]_i_2_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[4]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[5]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[63]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[6]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[7]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[8]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_dac_tdata[9]_i_1_n_0\ : STD_LOGIC;
  signal m_axis_dac_tvalid_i_1_n_0 : STD_LOGIC;
  signal p_3_in : STD_LOGIC;
  signal pat_idx : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal pat_idx0 : STD_LOGIC;
  signal \pat_idx[0]_i_1_n_0\ : STD_LOGIC;
  signal \pat_idx[1]_i_1_n_0\ : STD_LOGIC;
  signal \pat_idx[2]_i_1_n_0\ : STD_LOGIC;
  signal \pat_idx[3]_i_1_n_0\ : STD_LOGIC;
  signal \pat_idx[4]_i_2_n_0\ : STD_LOGIC;
  signal \sym_count[0]_i_2_n_0\ : STD_LOGIC;
  signal \sym_count_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \sym_count_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \sym_count_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \sym_count_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \sym_count_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \sym_count_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \sym_count_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \sym_count_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \sym_count_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \sym_count_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \sym_count_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \sym_count_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \sym_count_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \sym_count_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \sym_count_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \sym_count_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \sym_count_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \sym_count_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \sym_count_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \sym_count_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \sym_count_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \sym_count_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \sym_count_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \sym_count_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \sym_count_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \sym_count_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \sym_count_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \sym_count_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \sym_count_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \sym_count_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \sym_count_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \sym_count_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \sym_count_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \sym_count_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \sym_count_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \sym_count_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \sym_count_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \sym_count_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \sym_count_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \sym_count_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \sym_count_reg[28]_i_1_n_0\ : STD_LOGIC;
  signal \sym_count_reg[28]_i_1_n_1\ : STD_LOGIC;
  signal \sym_count_reg[28]_i_1_n_2\ : STD_LOGIC;
  signal \sym_count_reg[28]_i_1_n_3\ : STD_LOGIC;
  signal \sym_count_reg[28]_i_1_n_4\ : STD_LOGIC;
  signal \sym_count_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \sym_count_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \sym_count_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \sym_count_reg[32]_i_1_n_0\ : STD_LOGIC;
  signal \sym_count_reg[32]_i_1_n_1\ : STD_LOGIC;
  signal \sym_count_reg[32]_i_1_n_2\ : STD_LOGIC;
  signal \sym_count_reg[32]_i_1_n_3\ : STD_LOGIC;
  signal \sym_count_reg[32]_i_1_n_4\ : STD_LOGIC;
  signal \sym_count_reg[32]_i_1_n_5\ : STD_LOGIC;
  signal \sym_count_reg[32]_i_1_n_6\ : STD_LOGIC;
  signal \sym_count_reg[32]_i_1_n_7\ : STD_LOGIC;
  signal \sym_count_reg[36]_i_1_n_1\ : STD_LOGIC;
  signal \sym_count_reg[36]_i_1_n_2\ : STD_LOGIC;
  signal \sym_count_reg[36]_i_1_n_3\ : STD_LOGIC;
  signal \sym_count_reg[36]_i_1_n_4\ : STD_LOGIC;
  signal \sym_count_reg[36]_i_1_n_5\ : STD_LOGIC;
  signal \sym_count_reg[36]_i_1_n_6\ : STD_LOGIC;
  signal \sym_count_reg[36]_i_1_n_7\ : STD_LOGIC;
  signal \sym_count_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \sym_count_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \sym_count_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \sym_count_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \sym_count_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \sym_count_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \sym_count_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \sym_count_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \sym_count_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \sym_count_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \sym_count_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \sym_count_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \sym_count_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \sym_count_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \sym_count_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \sym_count_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \NLW_div_cnt0_carry__2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_div_cnt0_carry__2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_div_cnt1_carry__2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_div_cnt1_carry__2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_sym_count_reg[36]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of S_AXIS_BITS_TREADY_INST_0 : label is "soft_lutpair1";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of div_cnt0_carry : label is 35;
  attribute ADDER_THRESHOLD of \div_cnt0_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \div_cnt0_carry__1\ : label is 35;
  attribute ADDER_THRESHOLD of \div_cnt0_carry__2\ : label is 35;
  attribute ADDER_THRESHOLD of div_cnt1_carry : label is 35;
  attribute ADDER_THRESHOLD of \div_cnt1_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \div_cnt1_carry__1\ : label is 35;
  attribute ADDER_THRESHOLD of \div_cnt1_carry__2\ : label is 35;
  attribute SOFT_HLUTNM of \i_hold[15]_i_3\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[0]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[10]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[11]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[12]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[13]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[14]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[15]_i_2\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[1]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[2]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[32]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[33]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[34]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[35]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[36]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[37]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[38]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[39]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[3]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[40]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[41]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[42]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[43]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[44]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[45]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[46]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[47]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[4]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[5]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[6]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[7]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[8]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \m_axis_dac_tdata[9]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \pat_idx[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \pat_idx[2]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \pat_idx[3]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \pat_idx[4]_i_2\ : label is "soft_lutpair0";
  attribute ADDER_THRESHOLD of \sym_count_reg[0]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \sym_count_reg[12]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \sym_count_reg[16]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \sym_count_reg[20]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \sym_count_reg[24]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \sym_count_reg[28]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \sym_count_reg[32]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \sym_count_reg[36]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \sym_count_reg[4]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \sym_count_reg[8]_i_1\ : label is 11;
begin
  D(39 downto 0) <= \^d\(39 downto 0);
  SS(0) <= \^ss\(0);
S_AXIS_BITS_TREADY_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => p_3_in,
      I1 => axis_bit_reg_0(0),
      I2 => axis_bit_reg_0(1),
      O => S_AXIS_BITS_TREADY
    );
S_AXIS_BITS_TREADY_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0001000000000000"
    )
        port map (
      I0 => S_AXIS_BITS_TREADY_INST_0_i_2_n_0,
      I1 => S_AXIS_BITS_TREADY_INST_0_i_3_n_0,
      I2 => S_AXIS_BITS_TREADY_INST_0_i_4_n_0,
      I3 => S_AXIS_BITS_TREADY_INST_0_i_5_n_0,
      I4 => M_AXIS_DAC_TREADY,
      I5 => core_enable,
      O => p_3_in
    );
S_AXIS_BITS_TREADY_INST_0_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[1]\,
      I1 => \div_cnt_reg_n_0_[0]\,
      I2 => \div_cnt_reg_n_0_[3]\,
      I3 => \div_cnt_reg_n_0_[2]\,
      O => S_AXIS_BITS_TREADY_INST_0_i_2_n_0
    );
S_AXIS_BITS_TREADY_INST_0_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[5]\,
      I1 => \div_cnt_reg_n_0_[4]\,
      I2 => \div_cnt_reg_n_0_[7]\,
      I3 => \div_cnt_reg_n_0_[6]\,
      O => S_AXIS_BITS_TREADY_INST_0_i_3_n_0
    );
S_AXIS_BITS_TREADY_INST_0_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[10]\,
      I1 => \div_cnt_reg_n_0_[9]\,
      I2 => \div_cnt_reg_n_0_[11]\,
      I3 => \div_cnt_reg_n_0_[8]\,
      O => S_AXIS_BITS_TREADY_INST_0_i_4_n_0
    );
S_AXIS_BITS_TREADY_INST_0_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[15]\,
      I1 => \div_cnt_reg_n_0_[14]\,
      I2 => \div_cnt_reg_n_0_[13]\,
      I3 => \div_cnt_reg_n_0_[12]\,
      O => S_AXIS_BITS_TREADY_INST_0_i_5_n_0
    );
alt_bit_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => alt_bit,
      O => alt_bit_i_1_n_0
    );
alt_bit_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => alt_bit_i_1_n_0,
      Q => alt_bit,
      R => \^ss\(0)
    );
axis_bit_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFBFFFFF00800000"
    )
        port map (
      I0 => S_AXIS_BITS_TDATA(0),
      I1 => S_AXIS_BITS_TVALID,
      I2 => p_3_in,
      I3 => axis_bit_reg_0(0),
      I4 => axis_bit_reg_0(1),
      I5 => axis_bit,
      O => axis_bit_i_1_n_0
    );
axis_bit_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => axis_bit_i_1_n_0,
      Q => axis_bit,
      R => \^ss\(0)
    );
div_cnt0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => div_cnt0_carry_n_0,
      CO(2) => div_cnt0_carry_n_1,
      CO(1) => div_cnt0_carry_n_2,
      CO(0) => div_cnt0_carry_n_3,
      CYINIT => \div_cnt_reg_n_0_[0]\,
      DI(3) => \div_cnt_reg_n_0_[4]\,
      DI(2) => \div_cnt_reg_n_0_[3]\,
      DI(1) => \div_cnt_reg_n_0_[2]\,
      DI(0) => \div_cnt_reg_n_0_[1]\,
      O(3 downto 0) => data1(4 downto 1),
      S(3) => div_cnt0_carry_i_1_n_0,
      S(2) => div_cnt0_carry_i_2_n_0,
      S(1) => div_cnt0_carry_i_3_n_0,
      S(0) => div_cnt0_carry_i_4_n_0
    );
\div_cnt0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => div_cnt0_carry_n_0,
      CO(3) => \div_cnt0_carry__0_n_0\,
      CO(2) => \div_cnt0_carry__0_n_1\,
      CO(1) => \div_cnt0_carry__0_n_2\,
      CO(0) => \div_cnt0_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => \div_cnt_reg_n_0_[8]\,
      DI(2) => \div_cnt_reg_n_0_[7]\,
      DI(1) => \div_cnt_reg_n_0_[6]\,
      DI(0) => \div_cnt_reg_n_0_[5]\,
      O(3 downto 0) => data1(8 downto 5),
      S(3) => \div_cnt0_carry__0_i_1_n_0\,
      S(2) => \div_cnt0_carry__0_i_2_n_0\,
      S(1) => \div_cnt0_carry__0_i_3_n_0\,
      S(0) => \div_cnt0_carry__0_i_4_n_0\
    );
\div_cnt0_carry__0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[8]\,
      O => \div_cnt0_carry__0_i_1_n_0\
    );
\div_cnt0_carry__0_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[7]\,
      O => \div_cnt0_carry__0_i_2_n_0\
    );
\div_cnt0_carry__0_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[6]\,
      O => \div_cnt0_carry__0_i_3_n_0\
    );
\div_cnt0_carry__0_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[5]\,
      O => \div_cnt0_carry__0_i_4_n_0\
    );
\div_cnt0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \div_cnt0_carry__0_n_0\,
      CO(3) => \div_cnt0_carry__1_n_0\,
      CO(2) => \div_cnt0_carry__1_n_1\,
      CO(1) => \div_cnt0_carry__1_n_2\,
      CO(0) => \div_cnt0_carry__1_n_3\,
      CYINIT => '0',
      DI(3) => \div_cnt_reg_n_0_[12]\,
      DI(2) => \div_cnt_reg_n_0_[11]\,
      DI(1) => \div_cnt_reg_n_0_[10]\,
      DI(0) => \div_cnt_reg_n_0_[9]\,
      O(3 downto 0) => data1(12 downto 9),
      S(3) => \div_cnt0_carry__1_i_1_n_0\,
      S(2) => \div_cnt0_carry__1_i_2_n_0\,
      S(1) => \div_cnt0_carry__1_i_3_n_0\,
      S(0) => \div_cnt0_carry__1_i_4_n_0\
    );
\div_cnt0_carry__1_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[12]\,
      O => \div_cnt0_carry__1_i_1_n_0\
    );
\div_cnt0_carry__1_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[11]\,
      O => \div_cnt0_carry__1_i_2_n_0\
    );
\div_cnt0_carry__1_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[10]\,
      O => \div_cnt0_carry__1_i_3_n_0\
    );
\div_cnt0_carry__1_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[9]\,
      O => \div_cnt0_carry__1_i_4_n_0\
    );
\div_cnt0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \div_cnt0_carry__1_n_0\,
      CO(3 downto 2) => \NLW_div_cnt0_carry__2_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \div_cnt0_carry__2_n_2\,
      CO(0) => \div_cnt0_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => \div_cnt_reg_n_0_[14]\,
      DI(0) => \div_cnt_reg_n_0_[13]\,
      O(3) => \NLW_div_cnt0_carry__2_O_UNCONNECTED\(3),
      O(2 downto 0) => data1(15 downto 13),
      S(3) => '0',
      S(2) => \div_cnt0_carry__2_i_1_n_0\,
      S(1) => \div_cnt0_carry__2_i_2_n_0\,
      S(0) => \div_cnt0_carry__2_i_3_n_0\
    );
\div_cnt0_carry__2_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[15]\,
      O => \div_cnt0_carry__2_i_1_n_0\
    );
\div_cnt0_carry__2_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[14]\,
      O => \div_cnt0_carry__2_i_2_n_0\
    );
\div_cnt0_carry__2_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[13]\,
      O => \div_cnt0_carry__2_i_3_n_0\
    );
div_cnt0_carry_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[4]\,
      O => div_cnt0_carry_i_1_n_0
    );
div_cnt0_carry_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[3]\,
      O => div_cnt0_carry_i_2_n_0
    );
div_cnt0_carry_i_3: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[2]\,
      O => div_cnt0_carry_i_3_n_0
    );
div_cnt0_carry_i_4: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \div_cnt_reg_n_0_[1]\,
      O => div_cnt0_carry_i_4_n_0
    );
div_cnt1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => div_cnt1_carry_n_0,
      CO(2) => div_cnt1_carry_n_1,
      CO(1) => div_cnt1_carry_n_2,
      CO(0) => div_cnt1_carry_n_3,
      CYINIT => Q(0),
      DI(3 downto 0) => Q(4 downto 1),
      O(3 downto 0) => div_cnt1(4 downto 1),
      S(3) => div_cnt1_carry_i_1_n_0,
      S(2) => div_cnt1_carry_i_2_n_0,
      S(1) => div_cnt1_carry_i_3_n_0,
      S(0) => div_cnt1_carry_i_4_n_0
    );
\div_cnt1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => div_cnt1_carry_n_0,
      CO(3) => \div_cnt1_carry__0_n_0\,
      CO(2) => \div_cnt1_carry__0_n_1\,
      CO(1) => \div_cnt1_carry__0_n_2\,
      CO(0) => \div_cnt1_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => Q(8 downto 5),
      O(3 downto 0) => div_cnt1(8 downto 5),
      S(3) => \div_cnt1_carry__0_i_1_n_0\,
      S(2) => \div_cnt1_carry__0_i_2_n_0\,
      S(1) => \div_cnt1_carry__0_i_3_n_0\,
      S(0) => \div_cnt1_carry__0_i_4_n_0\
    );
\div_cnt1_carry__0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(8),
      O => \div_cnt1_carry__0_i_1_n_0\
    );
\div_cnt1_carry__0_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(7),
      O => \div_cnt1_carry__0_i_2_n_0\
    );
\div_cnt1_carry__0_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(6),
      O => \div_cnt1_carry__0_i_3_n_0\
    );
\div_cnt1_carry__0_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(5),
      O => \div_cnt1_carry__0_i_4_n_0\
    );
\div_cnt1_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \div_cnt1_carry__0_n_0\,
      CO(3) => \div_cnt1_carry__1_n_0\,
      CO(2) => \div_cnt1_carry__1_n_1\,
      CO(1) => \div_cnt1_carry__1_n_2\,
      CO(0) => \div_cnt1_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => Q(12 downto 9),
      O(3 downto 0) => div_cnt1(12 downto 9),
      S(3) => \div_cnt1_carry__1_i_1_n_0\,
      S(2) => \div_cnt1_carry__1_i_2_n_0\,
      S(1) => \div_cnt1_carry__1_i_3_n_0\,
      S(0) => \div_cnt1_carry__1_i_4_n_0\
    );
\div_cnt1_carry__1_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(12),
      O => \div_cnt1_carry__1_i_1_n_0\
    );
\div_cnt1_carry__1_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(11),
      O => \div_cnt1_carry__1_i_2_n_0\
    );
\div_cnt1_carry__1_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(10),
      O => \div_cnt1_carry__1_i_3_n_0\
    );
\div_cnt1_carry__1_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(9),
      O => \div_cnt1_carry__1_i_4_n_0\
    );
\div_cnt1_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \div_cnt1_carry__1_n_0\,
      CO(3 downto 2) => \NLW_div_cnt1_carry__2_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \div_cnt1_carry__2_n_2\,
      CO(0) => \div_cnt1_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1 downto 0) => Q(14 downto 13),
      O(3) => \NLW_div_cnt1_carry__2_O_UNCONNECTED\(3),
      O(2 downto 0) => div_cnt1(15 downto 13),
      S(3) => '0',
      S(2) => \div_cnt1_carry__2_i_1_n_0\,
      S(1) => \div_cnt1_carry__2_i_2_n_0\,
      S(0) => \div_cnt1_carry__2_i_3_n_0\
    );
\div_cnt1_carry__2_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(15),
      O => \div_cnt1_carry__2_i_1_n_0\
    );
\div_cnt1_carry__2_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(14),
      O => \div_cnt1_carry__2_i_2_n_0\
    );
\div_cnt1_carry__2_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(13),
      O => \div_cnt1_carry__2_i_3_n_0\
    );
div_cnt1_carry_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(4),
      O => div_cnt1_carry_i_1_n_0
    );
div_cnt1_carry_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(3),
      O => div_cnt1_carry_i_2_n_0
    );
div_cnt1_carry_i_3: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(2),
      O => div_cnt1_carry_i_3_n_0
    );
div_cnt1_carry_i_4: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(1),
      O => div_cnt1_carry_i_4_n_0
    );
\div_cnt[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0F11"
    )
        port map (
      I0 => Q(0),
      I1 => \div_cnt[15]_i_4_n_0\,
      I2 => \div_cnt_reg_n_0_[0]\,
      I3 => \div_cnt[15]_i_3_n_0\,
      O => div_cnt(0)
    );
\div_cnt[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(10),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(10),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(10)
    );
\div_cnt[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(11),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(11),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(11)
    );
\div_cnt[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(12),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(12),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(12)
    );
\div_cnt[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(13),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(13),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(13)
    );
\div_cnt[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(14),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(14),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(14)
    );
\div_cnt[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => core_enable,
      I1 => aresetn,
      O => \div_cnt[15]_i_1_n_0\
    );
\div_cnt[15]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(15),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(15),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(15)
    );
\div_cnt[15]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => S_AXIS_BITS_TREADY_INST_0_i_5_n_0,
      I1 => S_AXIS_BITS_TREADY_INST_0_i_4_n_0,
      I2 => S_AXIS_BITS_TREADY_INST_0_i_3_n_0,
      I3 => S_AXIS_BITS_TREADY_INST_0_i_2_n_0,
      O => \div_cnt[15]_i_3_n_0\
    );
\div_cnt[15]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
        port map (
      I0 => \div_cnt[15]_i_5_n_0\,
      I1 => \div_cnt[15]_i_6_n_0\,
      I2 => \div_cnt[15]_i_7_n_0\,
      I3 => Q(8),
      I4 => Q(15),
      I5 => Q(11),
      O => \div_cnt[15]_i_4_n_0\
    );
\div_cnt[15]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => Q(6),
      I1 => Q(1),
      I2 => Q(7),
      I3 => Q(2),
      O => \div_cnt[15]_i_5_n_0\
    );
\div_cnt[15]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => Q(5),
      I1 => Q(3),
      I2 => Q(10),
      I3 => Q(9),
      O => \div_cnt[15]_i_6_n_0\
    );
\div_cnt[15]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => Q(12),
      I1 => Q(4),
      I2 => Q(14),
      I3 => Q(13),
      O => \div_cnt[15]_i_7_n_0\
    );
\div_cnt[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(1),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(1),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(1)
    );
\div_cnt[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(2),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(2),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(2)
    );
\div_cnt[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(3),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(3),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(3)
    );
\div_cnt[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(4),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(4),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(4)
    );
\div_cnt[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(5),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(5),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(5)
    );
\div_cnt[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(6),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(6),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(6)
    );
\div_cnt[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(7),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(7),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(7)
    );
\div_cnt[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(8),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(8),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(8)
    );
\div_cnt[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => data1(9),
      I1 => \div_cnt[15]_i_3_n_0\,
      I2 => div_cnt1(9),
      I3 => \div_cnt[15]_i_4_n_0\,
      O => div_cnt(9)
    );
\div_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(0),
      Q => \div_cnt_reg_n_0_[0]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(10),
      Q => \div_cnt_reg_n_0_[10]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(11),
      Q => \div_cnt_reg_n_0_[11]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(12),
      Q => \div_cnt_reg_n_0_[12]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(13),
      Q => \div_cnt_reg_n_0_[13]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(14),
      Q => \div_cnt_reg_n_0_[14]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(15),
      Q => \div_cnt_reg_n_0_[15]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(1),
      Q => \div_cnt_reg_n_0_[1]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(2),
      Q => \div_cnt_reg_n_0_[2]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(3),
      Q => \div_cnt_reg_n_0_[3]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(4),
      Q => \div_cnt_reg_n_0_[4]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(5),
      Q => \div_cnt_reg_n_0_[5]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(6),
      Q => \div_cnt_reg_n_0_[6]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(7),
      Q => \div_cnt_reg_n_0_[7]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(8),
      Q => \div_cnt_reg_n_0_[8]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\div_cnt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => M_AXIS_DAC_TREADY,
      D => div_cnt(9),
      Q => \div_cnt_reg_n_0_[9]\,
      R => \div_cnt[15]_i_1_n_0\
    );
\i_hold[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(0),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(0),
      O => \i_hold[0]_i_1_n_0\
    );
\i_hold[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(10),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(10),
      O => \i_hold[10]_i_1_n_0\
    );
\i_hold[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(11),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(11),
      O => \i_hold[11]_i_1_n_0\
    );
\i_hold[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(12),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(12),
      O => \i_hold[12]_i_1_n_0\
    );
\i_hold[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(13),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(13),
      O => \i_hold[13]_i_1_n_0\
    );
\i_hold[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(14),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(14),
      O => \i_hold[14]_i_1_n_0\
    );
\i_hold[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(15),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(15),
      O => \i_hold[15]_i_1_n_0\
    );
\i_hold[15]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \i_hold_reg[15]_i_4_0\(19),
      I1 => \i_hold_reg[15]_i_4_0\(18),
      I2 => pat_idx(1),
      I3 => \i_hold_reg[15]_i_4_0\(17),
      I4 => pat_idx(0),
      I5 => \i_hold_reg[15]_i_4_0\(16),
      O => \i_hold[15]_i_10_n_0\
    );
\i_hold[15]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \i_hold_reg[15]_i_4_0\(23),
      I1 => \i_hold_reg[15]_i_4_0\(22),
      I2 => pat_idx(1),
      I3 => \i_hold_reg[15]_i_4_0\(21),
      I4 => pat_idx(0),
      I5 => \i_hold_reg[15]_i_4_0\(20),
      O => \i_hold[15]_i_11_n_0\
    );
\i_hold[15]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \i_hold_reg[15]_i_4_0\(11),
      I1 => \i_hold_reg[15]_i_4_0\(10),
      I2 => pat_idx(1),
      I3 => \i_hold_reg[15]_i_4_0\(9),
      I4 => pat_idx(0),
      I5 => \i_hold_reg[15]_i_4_0\(8),
      O => \i_hold[15]_i_12_n_0\
    );
\i_hold[15]_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \i_hold_reg[15]_i_4_0\(15),
      I1 => \i_hold_reg[15]_i_4_0\(14),
      I2 => pat_idx(1),
      I3 => \i_hold_reg[15]_i_4_0\(13),
      I4 => pat_idx(0),
      I5 => \i_hold_reg[15]_i_4_0\(12),
      O => \i_hold[15]_i_13_n_0\
    );
\i_hold[15]_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \i_hold_reg[15]_i_4_0\(3),
      I1 => \i_hold_reg[15]_i_4_0\(2),
      I2 => pat_idx(1),
      I3 => \i_hold_reg[15]_i_4_0\(1),
      I4 => pat_idx(0),
      I5 => \i_hold_reg[15]_i_4_0\(0),
      O => \i_hold[15]_i_14_n_0\
    );
\i_hold[15]_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \i_hold_reg[15]_i_4_0\(7),
      I1 => \i_hold_reg[15]_i_4_0\(6),
      I2 => pat_idx(1),
      I3 => \i_hold_reg[15]_i_4_0\(5),
      I4 => pat_idx(0),
      I5 => \i_hold_reg[15]_i_4_0\(4),
      O => \i_hold[15]_i_15_n_0\
    );
\i_hold[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \i_hold_reg[15]_i_4_n_0\,
      I1 => \i_hold_reg[15]_i_5_n_0\,
      I2 => pat_idx(4),
      I3 => \i_hold_reg[15]_i_6_n_0\,
      I4 => pat_idx(3),
      I5 => \i_hold_reg[15]_i_7_n_0\,
      O => \i_hold[15]_i_2_n_0\
    );
\i_hold[15]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B282"
    )
        port map (
      I0 => alt_bit,
      I1 => axis_bit_reg_0(0),
      I2 => axis_bit_reg_0(1),
      I3 => axis_bit,
      O => \i_hold[15]_i_3_n_0\
    );
\i_hold[15]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \i_hold_reg[15]_i_4_0\(27),
      I1 => \i_hold_reg[15]_i_4_0\(26),
      I2 => pat_idx(1),
      I3 => \i_hold_reg[15]_i_4_0\(25),
      I4 => pat_idx(0),
      I5 => \i_hold_reg[15]_i_4_0\(24),
      O => \i_hold[15]_i_8_n_0\
    );
\i_hold[15]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \i_hold_reg[15]_i_4_0\(31),
      I1 => \i_hold_reg[15]_i_4_0\(30),
      I2 => pat_idx(1),
      I3 => \i_hold_reg[15]_i_4_0\(29),
      I4 => pat_idx(0),
      I5 => \i_hold_reg[15]_i_4_0\(28),
      O => \i_hold[15]_i_9_n_0\
    );
\i_hold[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(1),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(1),
      O => \i_hold[1]_i_1_n_0\
    );
\i_hold[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(2),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(2),
      O => \i_hold[2]_i_1_n_0\
    );
\i_hold[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(3),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(3),
      O => \i_hold[3]_i_1_n_0\
    );
\i_hold[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(4),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(4),
      O => \i_hold[4]_i_1_n_0\
    );
\i_hold[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(5),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(5),
      O => \i_hold[5]_i_1_n_0\
    );
\i_hold[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(6),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(6),
      O => \i_hold[6]_i_1_n_0\
    );
\i_hold[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(7),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(7),
      O => \i_hold[7]_i_1_n_0\
    );
\i_hold[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(8),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(8),
      O => \i_hold[8]_i_1_n_0\
    );
\i_hold[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEA0000AA2A"
    )
        port map (
      I0 => \i_hold_reg[15]_0\(9),
      I1 => \i_hold[15]_i_2_n_0\,
      I2 => axis_bit_reg_0(0),
      I3 => axis_bit_reg_0(1),
      I4 => \i_hold[15]_i_3_n_0\,
      I5 => \i_hold_reg[15]_1\(9),
      O => \i_hold[9]_i_1_n_0\
    );
\i_hold_reg[0]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[0]_i_1_n_0\,
      Q => i_hold(0),
      S => \^ss\(0)
    );
\i_hold_reg[10]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[10]_i_1_n_0\,
      Q => i_hold(10),
      S => \^ss\(0)
    );
\i_hold_reg[11]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[11]_i_1_n_0\,
      Q => i_hold(11),
      S => \^ss\(0)
    );
\i_hold_reg[12]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[12]_i_1_n_0\,
      Q => i_hold(12),
      S => \^ss\(0)
    );
\i_hold_reg[13]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[13]_i_1_n_0\,
      Q => i_hold(13),
      S => \^ss\(0)
    );
\i_hold_reg[14]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[14]_i_1_n_0\,
      Q => i_hold(14),
      S => \^ss\(0)
    );
\i_hold_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[15]_i_1_n_0\,
      Q => i_hold(15),
      R => \^ss\(0)
    );
\i_hold_reg[15]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \i_hold[15]_i_8_n_0\,
      I1 => \i_hold[15]_i_9_n_0\,
      O => \i_hold_reg[15]_i_4_n_0\,
      S => pat_idx(2)
    );
\i_hold_reg[15]_i_5\: unisim.vcomponents.MUXF7
     port map (
      I0 => \i_hold[15]_i_10_n_0\,
      I1 => \i_hold[15]_i_11_n_0\,
      O => \i_hold_reg[15]_i_5_n_0\,
      S => pat_idx(2)
    );
\i_hold_reg[15]_i_6\: unisim.vcomponents.MUXF7
     port map (
      I0 => \i_hold[15]_i_12_n_0\,
      I1 => \i_hold[15]_i_13_n_0\,
      O => \i_hold_reg[15]_i_6_n_0\,
      S => pat_idx(2)
    );
\i_hold_reg[15]_i_7\: unisim.vcomponents.MUXF7
     port map (
      I0 => \i_hold[15]_i_14_n_0\,
      I1 => \i_hold[15]_i_15_n_0\,
      O => \i_hold_reg[15]_i_7_n_0\,
      S => pat_idx(2)
    );
\i_hold_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[1]_i_1_n_0\,
      Q => i_hold(1),
      S => \^ss\(0)
    );
\i_hold_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[2]_i_1_n_0\,
      Q => i_hold(2),
      S => \^ss\(0)
    );
\i_hold_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[3]_i_1_n_0\,
      Q => i_hold(3),
      S => \^ss\(0)
    );
\i_hold_reg[4]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[4]_i_1_n_0\,
      Q => i_hold(4),
      S => \^ss\(0)
    );
\i_hold_reg[5]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[5]_i_1_n_0\,
      Q => i_hold(5),
      S => \^ss\(0)
    );
\i_hold_reg[6]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[6]_i_1_n_0\,
      Q => i_hold(6),
      S => \^ss\(0)
    );
\i_hold_reg[7]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[7]_i_1_n_0\,
      Q => i_hold(7),
      S => \^ss\(0)
    );
\i_hold_reg[8]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[8]_i_1_n_0\,
      Q => i_hold(8),
      S => \^ss\(0)
    );
\i_hold_reg[9]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \i_hold[9]_i_1_n_0\,
      Q => i_hold(9),
      S => \^ss\(0)
    );
\m_axis_dac_tdata[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(0),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(0),
      O => \m_axis_dac_tdata[0]_i_1_n_0\
    );
\m_axis_dac_tdata[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(10),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(10),
      O => \m_axis_dac_tdata[10]_i_1_n_0\
    );
\m_axis_dac_tdata[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(11),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(11),
      O => \m_axis_dac_tdata[11]_i_1_n_0\
    );
\m_axis_dac_tdata[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(12),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(12),
      O => \m_axis_dac_tdata[12]_i_1_n_0\
    );
\m_axis_dac_tdata[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(13),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(13),
      O => \m_axis_dac_tdata[13]_i_1_n_0\
    );
\m_axis_dac_tdata[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(14),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(14),
      O => \m_axis_dac_tdata[14]_i_1_n_0\
    );
\m_axis_dac_tdata[15]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => aresetn,
      O => \^ss\(0)
    );
\m_axis_dac_tdata[15]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(15),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(15),
      O => \m_axis_dac_tdata[15]_i_2_n_0\
    );
\m_axis_dac_tdata[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(1),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(1),
      O => \m_axis_dac_tdata[1]_i_1_n_0\
    );
\m_axis_dac_tdata[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(2),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(2),
      O => \m_axis_dac_tdata[2]_i_1_n_0\
    );
\m_axis_dac_tdata[32]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(0),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(32),
      O => \m_axis_dac_tdata[32]_i_1_n_0\
    );
\m_axis_dac_tdata[33]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(1),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(33),
      O => \m_axis_dac_tdata[33]_i_1_n_0\
    );
\m_axis_dac_tdata[34]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(2),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(34),
      O => \m_axis_dac_tdata[34]_i_1_n_0\
    );
\m_axis_dac_tdata[35]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(3),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(35),
      O => \m_axis_dac_tdata[35]_i_1_n_0\
    );
\m_axis_dac_tdata[36]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(4),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(36),
      O => \m_axis_dac_tdata[36]_i_1_n_0\
    );
\m_axis_dac_tdata[37]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(5),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(37),
      O => \m_axis_dac_tdata[37]_i_1_n_0\
    );
\m_axis_dac_tdata[38]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(6),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(38),
      O => \m_axis_dac_tdata[38]_i_1_n_0\
    );
\m_axis_dac_tdata[39]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(7),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(39),
      O => \m_axis_dac_tdata[39]_i_1_n_0\
    );
\m_axis_dac_tdata[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(3),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(3),
      O => \m_axis_dac_tdata[3]_i_1_n_0\
    );
\m_axis_dac_tdata[40]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(8),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(40),
      O => \m_axis_dac_tdata[40]_i_1_n_0\
    );
\m_axis_dac_tdata[41]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(9),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(41),
      O => \m_axis_dac_tdata[41]_i_1_n_0\
    );
\m_axis_dac_tdata[42]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(10),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(42),
      O => \m_axis_dac_tdata[42]_i_1_n_0\
    );
\m_axis_dac_tdata[43]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(11),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(43),
      O => \m_axis_dac_tdata[43]_i_1_n_0\
    );
\m_axis_dac_tdata[44]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(12),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(44),
      O => \m_axis_dac_tdata[44]_i_1_n_0\
    );
\m_axis_dac_tdata[45]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(13),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(45),
      O => \m_axis_dac_tdata[45]_i_1_n_0\
    );
\m_axis_dac_tdata[46]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(14),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(46),
      O => \m_axis_dac_tdata[46]_i_1_n_0\
    );
\m_axis_dac_tdata[47]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"2F"
    )
        port map (
      I0 => core_enable,
      I1 => core_ch_sel,
      I2 => aresetn,
      O => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata[47]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(15),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(47),
      O => \m_axis_dac_tdata[47]_i_2_n_0\
    );
\m_axis_dac_tdata[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(4),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(4),
      O => \m_axis_dac_tdata[4]_i_1_n_0\
    );
\m_axis_dac_tdata[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(5),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(5),
      O => \m_axis_dac_tdata[5]_i_1_n_0\
    );
\m_axis_dac_tdata[63]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => core_enable,
      I1 => aresetn,
      O => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(6),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(6),
      O => \m_axis_dac_tdata[6]_i_1_n_0\
    );
\m_axis_dac_tdata[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(7),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(7),
      O => \m_axis_dac_tdata[7]_i_1_n_0\
    );
\m_axis_dac_tdata[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(8),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(8),
      O => \m_axis_dac_tdata[8]_i_1_n_0\
    );
\m_axis_dac_tdata[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => i_hold(9),
      I1 => core_enable,
      I2 => S_AXIS_DMA_TDATA(9),
      O => \m_axis_dac_tdata[9]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[0]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(0),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[10]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(10),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[11]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(11),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[12]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(12),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[13]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(13),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[14]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(14),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[15]_i_2_n_0\,
      Q => M_AXIS_DAC_TDATA(15),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(16),
      Q => M_AXIS_DAC_TDATA(16),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(17),
      Q => M_AXIS_DAC_TDATA(17),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(18),
      Q => M_AXIS_DAC_TDATA(18),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(19),
      Q => M_AXIS_DAC_TDATA(19),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[1]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(1),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(20),
      Q => M_AXIS_DAC_TDATA(20),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(21),
      Q => M_AXIS_DAC_TDATA(21),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(22),
      Q => M_AXIS_DAC_TDATA(22),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(23),
      Q => M_AXIS_DAC_TDATA(23),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(24),
      Q => M_AXIS_DAC_TDATA(24),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(25),
      Q => M_AXIS_DAC_TDATA(25),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(26),
      Q => M_AXIS_DAC_TDATA(26),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(27),
      Q => M_AXIS_DAC_TDATA(27),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(28),
      Q => M_AXIS_DAC_TDATA(28),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(29),
      Q => M_AXIS_DAC_TDATA(29),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[2]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(2),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(30),
      Q => M_AXIS_DAC_TDATA(30),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(31),
      Q => M_AXIS_DAC_TDATA(31),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[32]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(32),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[33]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(33),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[34]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(34),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[35]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(35),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[36]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(36),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[37]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(37),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[38]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(38),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[39]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(39),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[3]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(3),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[40]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(40),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[41]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(41),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[42]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(42),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[43]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(43),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[44]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(44),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[45]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(45),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[46]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(46),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[47]_i_2_n_0\,
      Q => M_AXIS_DAC_TDATA(47),
      R => \m_axis_dac_tdata[47]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(48),
      Q => M_AXIS_DAC_TDATA(48),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(49),
      Q => M_AXIS_DAC_TDATA(49),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[4]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(4),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(50),
      Q => M_AXIS_DAC_TDATA(50),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(51),
      Q => M_AXIS_DAC_TDATA(51),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(52),
      Q => M_AXIS_DAC_TDATA(52),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(53),
      Q => M_AXIS_DAC_TDATA(53),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(54),
      Q => M_AXIS_DAC_TDATA(54),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(55),
      Q => M_AXIS_DAC_TDATA(55),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(56),
      Q => M_AXIS_DAC_TDATA(56),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(57),
      Q => M_AXIS_DAC_TDATA(57),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(58),
      Q => M_AXIS_DAC_TDATA(58),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(59),
      Q => M_AXIS_DAC_TDATA(59),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[5]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(5),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(60),
      Q => M_AXIS_DAC_TDATA(60),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(61),
      Q => M_AXIS_DAC_TDATA(61),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(62),
      Q => M_AXIS_DAC_TDATA(62),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => S_AXIS_DMA_TDATA(63),
      Q => M_AXIS_DAC_TDATA(63),
      R => \m_axis_dac_tdata[63]_i_1_n_0\
    );
\m_axis_dac_tdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[6]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(6),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[7]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(7),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[8]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(8),
      R => \^ss\(0)
    );
\m_axis_dac_tdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \m_axis_dac_tdata[9]_i_1_n_0\,
      Q => M_AXIS_DAC_TDATA(9),
      R => \^ss\(0)
    );
m_axis_dac_tvalid_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => S_AXIS_DMA_TVALID,
      I1 => core_enable,
      O => m_axis_dac_tvalid_i_1_n_0
    );
m_axis_dac_tvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => m_axis_dac_tvalid_i_1_n_0,
      Q => M_AXIS_DAC_TVALID,
      R => \^ss\(0)
    );
\pat_idx[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => pat_idx(0),
      O => \pat_idx[0]_i_1_n_0\
    );
\pat_idx[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => pat_idx(0),
      I1 => pat_idx(1),
      O => \pat_idx[1]_i_1_n_0\
    );
\pat_idx[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A9"
    )
        port map (
      I0 => pat_idx(2),
      I1 => pat_idx(1),
      I2 => pat_idx(0),
      O => \pat_idx[2]_i_1_n_0\
    );
\pat_idx[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA9"
    )
        port map (
      I0 => pat_idx(3),
      I1 => pat_idx(2),
      I2 => pat_idx(0),
      I3 => pat_idx(1),
      O => \pat_idx[3]_i_1_n_0\
    );
\pat_idx[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => p_3_in,
      I1 => axis_bit_reg_0(1),
      I2 => axis_bit_reg_0(0),
      O => pat_idx0
    );
\pat_idx[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAAA9"
    )
        port map (
      I0 => pat_idx(4),
      I1 => pat_idx(3),
      I2 => pat_idx(1),
      I3 => pat_idx(0),
      I4 => pat_idx(2),
      O => \pat_idx[4]_i_2_n_0\
    );
\pat_idx_reg[0]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => pat_idx0,
      D => \pat_idx[0]_i_1_n_0\,
      Q => pat_idx(0),
      S => \^ss\(0)
    );
\pat_idx_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => pat_idx0,
      D => \pat_idx[1]_i_1_n_0\,
      Q => pat_idx(1),
      S => \^ss\(0)
    );
\pat_idx_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => pat_idx0,
      D => \pat_idx[2]_i_1_n_0\,
      Q => pat_idx(2),
      S => \^ss\(0)
    );
\pat_idx_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => pat_idx0,
      D => \pat_idx[3]_i_1_n_0\,
      Q => pat_idx(3),
      S => \^ss\(0)
    );
\pat_idx_reg[4]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => pat_idx0,
      D => \pat_idx[4]_i_2_n_0\,
      Q => pat_idx(4),
      S => \^ss\(0)
    );
\sym_count[0]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^d\(0),
      O => \sym_count[0]_i_2_n_0\
    );
\sym_count_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[0]_i_1_n_7\,
      Q => \^d\(0),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \sym_count_reg[0]_i_1_n_0\,
      CO(2) => \sym_count_reg[0]_i_1_n_1\,
      CO(1) => \sym_count_reg[0]_i_1_n_2\,
      CO(0) => \sym_count_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \sym_count_reg[0]_i_1_n_4\,
      O(2) => \sym_count_reg[0]_i_1_n_5\,
      O(1) => \sym_count_reg[0]_i_1_n_6\,
      O(0) => \sym_count_reg[0]_i_1_n_7\,
      S(3 downto 1) => \^d\(3 downto 1),
      S(0) => \sym_count[0]_i_2_n_0\
    );
\sym_count_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[8]_i_1_n_5\,
      Q => \^d\(10),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[8]_i_1_n_4\,
      Q => \^d\(11),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[12]_i_1_n_7\,
      Q => \^d\(12),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sym_count_reg[8]_i_1_n_0\,
      CO(3) => \sym_count_reg[12]_i_1_n_0\,
      CO(2) => \sym_count_reg[12]_i_1_n_1\,
      CO(1) => \sym_count_reg[12]_i_1_n_2\,
      CO(0) => \sym_count_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sym_count_reg[12]_i_1_n_4\,
      O(2) => \sym_count_reg[12]_i_1_n_5\,
      O(1) => \sym_count_reg[12]_i_1_n_6\,
      O(0) => \sym_count_reg[12]_i_1_n_7\,
      S(3 downto 0) => \^d\(15 downto 12)
    );
\sym_count_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[12]_i_1_n_6\,
      Q => \^d\(13),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[12]_i_1_n_5\,
      Q => \^d\(14),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[12]_i_1_n_4\,
      Q => \^d\(15),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[16]_i_1_n_7\,
      Q => \^d\(16),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sym_count_reg[12]_i_1_n_0\,
      CO(3) => \sym_count_reg[16]_i_1_n_0\,
      CO(2) => \sym_count_reg[16]_i_1_n_1\,
      CO(1) => \sym_count_reg[16]_i_1_n_2\,
      CO(0) => \sym_count_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sym_count_reg[16]_i_1_n_4\,
      O(2) => \sym_count_reg[16]_i_1_n_5\,
      O(1) => \sym_count_reg[16]_i_1_n_6\,
      O(0) => \sym_count_reg[16]_i_1_n_7\,
      S(3 downto 0) => \^d\(19 downto 16)
    );
\sym_count_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[16]_i_1_n_6\,
      Q => \^d\(17),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[16]_i_1_n_5\,
      Q => \^d\(18),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[16]_i_1_n_4\,
      Q => \^d\(19),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[0]_i_1_n_6\,
      Q => \^d\(1),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[20]_i_1_n_7\,
      Q => \^d\(20),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sym_count_reg[16]_i_1_n_0\,
      CO(3) => \sym_count_reg[20]_i_1_n_0\,
      CO(2) => \sym_count_reg[20]_i_1_n_1\,
      CO(1) => \sym_count_reg[20]_i_1_n_2\,
      CO(0) => \sym_count_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sym_count_reg[20]_i_1_n_4\,
      O(2) => \sym_count_reg[20]_i_1_n_5\,
      O(1) => \sym_count_reg[20]_i_1_n_6\,
      O(0) => \sym_count_reg[20]_i_1_n_7\,
      S(3 downto 0) => \^d\(23 downto 20)
    );
\sym_count_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[20]_i_1_n_6\,
      Q => \^d\(21),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[20]_i_1_n_5\,
      Q => \^d\(22),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[20]_i_1_n_4\,
      Q => \^d\(23),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[24]_i_1_n_7\,
      Q => \^d\(24),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sym_count_reg[20]_i_1_n_0\,
      CO(3) => \sym_count_reg[24]_i_1_n_0\,
      CO(2) => \sym_count_reg[24]_i_1_n_1\,
      CO(1) => \sym_count_reg[24]_i_1_n_2\,
      CO(0) => \sym_count_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sym_count_reg[24]_i_1_n_4\,
      O(2) => \sym_count_reg[24]_i_1_n_5\,
      O(1) => \sym_count_reg[24]_i_1_n_6\,
      O(0) => \sym_count_reg[24]_i_1_n_7\,
      S(3 downto 0) => \^d\(27 downto 24)
    );
\sym_count_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[24]_i_1_n_6\,
      Q => \^d\(25),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[24]_i_1_n_5\,
      Q => \^d\(26),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[24]_i_1_n_4\,
      Q => \^d\(27),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[28]_i_1_n_7\,
      Q => \^d\(28),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sym_count_reg[24]_i_1_n_0\,
      CO(3) => \sym_count_reg[28]_i_1_n_0\,
      CO(2) => \sym_count_reg[28]_i_1_n_1\,
      CO(1) => \sym_count_reg[28]_i_1_n_2\,
      CO(0) => \sym_count_reg[28]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sym_count_reg[28]_i_1_n_4\,
      O(2) => \sym_count_reg[28]_i_1_n_5\,
      O(1) => \sym_count_reg[28]_i_1_n_6\,
      O(0) => \sym_count_reg[28]_i_1_n_7\,
      S(3 downto 0) => \^d\(31 downto 28)
    );
\sym_count_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[28]_i_1_n_6\,
      Q => \^d\(29),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[0]_i_1_n_5\,
      Q => \^d\(2),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[28]_i_1_n_5\,
      Q => \^d\(30),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[28]_i_1_n_4\,
      Q => \^d\(31),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[32]_i_1_n_7\,
      Q => \^d\(32),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[32]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sym_count_reg[28]_i_1_n_0\,
      CO(3) => \sym_count_reg[32]_i_1_n_0\,
      CO(2) => \sym_count_reg[32]_i_1_n_1\,
      CO(1) => \sym_count_reg[32]_i_1_n_2\,
      CO(0) => \sym_count_reg[32]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sym_count_reg[32]_i_1_n_4\,
      O(2) => \sym_count_reg[32]_i_1_n_5\,
      O(1) => \sym_count_reg[32]_i_1_n_6\,
      O(0) => \sym_count_reg[32]_i_1_n_7\,
      S(3 downto 0) => \^d\(35 downto 32)
    );
\sym_count_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[32]_i_1_n_6\,
      Q => \^d\(33),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[32]_i_1_n_5\,
      Q => \^d\(34),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[32]_i_1_n_4\,
      Q => \^d\(35),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[36]_i_1_n_7\,
      Q => \^d\(36),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[36]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sym_count_reg[32]_i_1_n_0\,
      CO(3) => \NLW_sym_count_reg[36]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \sym_count_reg[36]_i_1_n_1\,
      CO(1) => \sym_count_reg[36]_i_1_n_2\,
      CO(0) => \sym_count_reg[36]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sym_count_reg[36]_i_1_n_4\,
      O(2) => \sym_count_reg[36]_i_1_n_5\,
      O(1) => \sym_count_reg[36]_i_1_n_6\,
      O(0) => \sym_count_reg[36]_i_1_n_7\,
      S(3 downto 0) => \^d\(39 downto 36)
    );
\sym_count_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[36]_i_1_n_6\,
      Q => \^d\(37),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[36]_i_1_n_5\,
      Q => \^d\(38),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[36]_i_1_n_4\,
      Q => \^d\(39),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[0]_i_1_n_4\,
      Q => \^d\(3),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[4]_i_1_n_7\,
      Q => \^d\(4),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sym_count_reg[0]_i_1_n_0\,
      CO(3) => \sym_count_reg[4]_i_1_n_0\,
      CO(2) => \sym_count_reg[4]_i_1_n_1\,
      CO(1) => \sym_count_reg[4]_i_1_n_2\,
      CO(0) => \sym_count_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sym_count_reg[4]_i_1_n_4\,
      O(2) => \sym_count_reg[4]_i_1_n_5\,
      O(1) => \sym_count_reg[4]_i_1_n_6\,
      O(0) => \sym_count_reg[4]_i_1_n_7\,
      S(3 downto 0) => \^d\(7 downto 4)
    );
\sym_count_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[4]_i_1_n_6\,
      Q => \^d\(5),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[4]_i_1_n_5\,
      Q => \^d\(6),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[4]_i_1_n_4\,
      Q => \^d\(7),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[8]_i_1_n_7\,
      Q => \^d\(8),
      R => \div_cnt[15]_i_1_n_0\
    );
\sym_count_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sym_count_reg[4]_i_1_n_0\,
      CO(3) => \sym_count_reg[8]_i_1_n_0\,
      CO(2) => \sym_count_reg[8]_i_1_n_1\,
      CO(1) => \sym_count_reg[8]_i_1_n_2\,
      CO(0) => \sym_count_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sym_count_reg[8]_i_1_n_4\,
      O(2) => \sym_count_reg[8]_i_1_n_5\,
      O(1) => \sym_count_reg[8]_i_1_n_6\,
      O(0) => \sym_count_reg[8]_i_1_n_7\,
      S(3 downto 0) => \^d\(11 downto 8)
    );
\sym_count_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_3_in,
      D => \sym_count_reg[8]_i_1_n_6\,
      Q => \^d\(9),
      R => \div_cnt[15]_i_1_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_bpsk_modulator_0_0_bpsk_modulator_v1_0 is
  port (
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
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of system_bpsk_modulator_0_0_bpsk_modulator_v1_0 : entity is 8;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of system_bpsk_modulator_0_0_bpsk_modulator_v1_0 : entity is 32;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of system_bpsk_modulator_0_0_bpsk_modulator_v1_0 : entity is "bpsk_modulator_v1_0";
end system_bpsk_modulator_0_0_bpsk_modulator_v1_0;

architecture STRUCTURE of system_bpsk_modulator_0_0_bpsk_modulator_v1_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^s_axi_arready\ : STD_LOGIC;
  signal \^s_axi_bvalid\ : STD_LOGIC;
  signal \^s_axi_rvalid\ : STD_LOGIC;
  signal active_ff : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \aw_addr_reg_n_0_[5]\ : STD_LOGIC;
  signal \aw_addr_reg_n_0_[6]\ : STD_LOGIC;
  signal \aw_addr_reg_n_0_[7]\ : STD_LOGIC;
  signal aw_done : STD_LOGIC;
  signal aw_done_i_1_n_0 : STD_LOGIC;
  signal axi_arready0 : STD_LOGIC;
  signal axi_awready0 : STD_LOGIC;
  signal axi_awready_i_1_n_0 : STD_LOGIC;
  signal axi_bvalid_i_1_n_0 : STD_LOGIC;
  signal \axi_rdata[0]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[0]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[0]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[10]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[10]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[10]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[11]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[11]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[11]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[12]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[12]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[12]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[13]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[13]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[13]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[14]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[14]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[14]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[15]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[15]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[15]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[16]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[16]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[17]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[17]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[18]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[18]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[19]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[19]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[1]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[1]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[1]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[20]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[20]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[21]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[21]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[22]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[22]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[23]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[23]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[24]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[24]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[25]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[25]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[26]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[26]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[27]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[27]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[28]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[28]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[29]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[29]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[2]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[2]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[2]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[30]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[30]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[31]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[31]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[31]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[3]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[3]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[3]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[3]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[4]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[4]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[4]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[5]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[5]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[5]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[6]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[6]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[6]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[7]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[7]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[7]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[8]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[8]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[8]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[9]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[9]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[9]_i_3_n_0\ : STD_LOGIC;
  signal axi_rvalid_i_1_n_0 : STD_LOGIC;
  signal axi_wready0 : STD_LOGIC;
  signal axireg_ch_sel : STD_LOGIC;
  signal axireg_enable : STD_LOGIC;
  signal axireg_enable_reg_n_0 : STD_LOGIC;
  signal \axireg_i_neg[15]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_i_neg[7]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_i_pos[15]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_i_pos[15]_i_2_n_0\ : STD_LOGIC;
  signal \axireg_i_pos[7]_i_1_n_0\ : STD_LOGIC;
  signal axireg_pat_data : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \axireg_pat_data[15]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_pat_data[23]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_pat_data[31]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_pat_data[7]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_src_sel[1]_i_2_n_0\ : STD_LOGIC;
  signal \axireg_src_sel_reg_n_0_[0]\ : STD_LOGIC;
  signal \axireg_src_sel_reg_n_0_[1]\ : STD_LOGIC;
  signal axireg_sym_div : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \axireg_sym_div[15]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_sym_div[7]_i_1_n_0\ : STD_LOGIC;
  signal core_ch_sel : STD_LOGIC;
  signal core_enable : STD_LOGIC;
  signal core_i_neg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal core_i_pos : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal core_pat_data : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal core_src_sel : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal core_sym_div : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal data3 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal data6 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal do_write : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal p_1_in : STD_LOGIC;
  signal p_1_in0 : STD_LOGIC;
  signal \p_1_in__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal p_2_in : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal snap_ch_sel : STD_LOGIC;
  signal snap_enable : STD_LOGIC;
  signal snap_i_neg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal snap_i_pos : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal snap_pat_data : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal snap_src_sel : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal snap_sym_div : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal sym_cnt_ff1 : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal \sym_cnt_ff2_reg_n_0_[0]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[10]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[11]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[12]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[13]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[14]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[15]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[16]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[17]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[18]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[19]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[1]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[20]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[21]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[22]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[23]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[24]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[25]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[26]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[27]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[28]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[29]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[2]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[30]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[31]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[3]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[4]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[5]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[6]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[7]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[8]\ : STD_LOGIC;
  signal \sym_cnt_ff2_reg_n_0_[9]\ : STD_LOGIC;
  signal sym_count_reg : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal u_bpsk_core_n_0 : STD_LOGIC;
  signal \w_data_reg_n_0_[0]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[10]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[11]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[12]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[13]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[14]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[15]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[3]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[4]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[5]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[6]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[7]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[8]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[9]\ : STD_LOGIC;
  signal w_done_i_1_n_0 : STD_LOGIC;
  signal w_done_reg_n_0 : STD_LOGIC;
  signal \w_strb_reg_n_0_[2]\ : STD_LOGIC;
  signal \w_strb_reg_n_0_[3]\ : STD_LOGIC;
  signal wr_pulse_axi : STD_LOGIC;
  signal wr_pulse_core : STD_LOGIC;
  signal \wr_pulse_sync_reg_n_0_[0]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \M_AXIS_DAC_TKEEP[0]_INST_0\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \M_AXIS_DAC_TKEEP[1]_INST_0\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \M_AXIS_DAC_TKEEP[2]_INST_0\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \M_AXIS_DAC_TKEEP[3]_INST_0\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \M_AXIS_DAC_TKEEP[4]_INST_0\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \M_AXIS_DAC_TKEEP[5]_INST_0\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \M_AXIS_DAC_TKEEP[6]_INST_0\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \M_AXIS_DAC_TKEEP[7]_INST_0\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of M_AXIS_DAC_TLAST_INST_0 : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of S_AXIS_DMA_TREADY_INST_0 : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of axi_bvalid_i_1 : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \axi_rdata[16]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \axi_rdata[17]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \axi_rdata[20]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \axi_rdata[22]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \axi_rdata[24]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \axi_rdata[29]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \axi_rdata[3]_i_4\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \axi_rdata[4]_i_3\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of wr_pulse_axi_i_1 : label is "soft_lutpair23";
begin
  S_AXI_ARREADY <= \^s_axi_arready\;
  S_AXI_BRESP(1) <= \<const0>\;
  S_AXI_BRESP(0) <= \<const0>\;
  S_AXI_BVALID <= \^s_axi_bvalid\;
  S_AXI_RRESP(1) <= \<const0>\;
  S_AXI_RRESP(0) <= \<const0>\;
  S_AXI_RVALID <= \^s_axi_rvalid\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\M_AXIS_DAC_TKEEP[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => core_enable,
      I1 => S_AXIS_DMA_TKEEP(0),
      O => M_AXIS_DAC_TKEEP(0)
    );
\M_AXIS_DAC_TKEEP[1]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => core_enable,
      I1 => S_AXIS_DMA_TKEEP(1),
      O => M_AXIS_DAC_TKEEP(1)
    );
\M_AXIS_DAC_TKEEP[2]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => core_enable,
      I1 => S_AXIS_DMA_TKEEP(2),
      O => M_AXIS_DAC_TKEEP(2)
    );
\M_AXIS_DAC_TKEEP[3]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => core_enable,
      I1 => S_AXIS_DMA_TKEEP(3),
      O => M_AXIS_DAC_TKEEP(3)
    );
\M_AXIS_DAC_TKEEP[4]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => core_enable,
      I1 => S_AXIS_DMA_TKEEP(4),
      O => M_AXIS_DAC_TKEEP(4)
    );
\M_AXIS_DAC_TKEEP[5]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => core_enable,
      I1 => S_AXIS_DMA_TKEEP(5),
      O => M_AXIS_DAC_TKEEP(5)
    );
\M_AXIS_DAC_TKEEP[6]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => core_enable,
      I1 => S_AXIS_DMA_TKEEP(6),
      O => M_AXIS_DAC_TKEEP(6)
    );
\M_AXIS_DAC_TKEEP[7]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => core_enable,
      I1 => S_AXIS_DMA_TKEEP(7),
      O => M_AXIS_DAC_TKEEP(7)
    );
M_AXIS_DAC_TLAST_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => S_AXIS_DMA_TLAST,
      I1 => core_enable,
      O => M_AXIS_DAC_TLAST
    );
S_AXIS_DMA_TREADY_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => core_enable,
      I1 => M_AXIS_DAC_TREADY,
      O => S_AXIS_DMA_TREADY
    );
\active_ff_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => core_enable,
      Q => active_ff(0),
      R => axi_awready_i_1_n_0
    );
\active_ff_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => active_ff(0),
      Q => active_ff(1),
      R => axi_awready_i_1_n_0
    );
\aw_addr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(2),
      Q => p_0_in(0),
      R => axi_awready_i_1_n_0
    );
\aw_addr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(3),
      Q => p_0_in(1),
      R => axi_awready_i_1_n_0
    );
\aw_addr_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(4),
      Q => p_0_in(2),
      R => axi_awready_i_1_n_0
    );
\aw_addr_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(5),
      Q => \aw_addr_reg_n_0_[5]\,
      R => axi_awready_i_1_n_0
    );
\aw_addr_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(6),
      Q => \aw_addr_reg_n_0_[6]\,
      R => axi_awready_i_1_n_0
    );
\aw_addr_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(7),
      Q => \aw_addr_reg_n_0_[7]\,
      R => axi_awready_i_1_n_0
    );
aw_done_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00E0E0E0"
    )
        port map (
      I0 => aw_done,
      I1 => S_AXI_AWVALID,
      I2 => S_AXI_ARESETN,
      I3 => \^s_axi_bvalid\,
      I4 => S_AXI_BREADY,
      O => aw_done_i_1_n_0
    );
aw_done_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => aw_done_i_1_n_0,
      Q => aw_done,
      R => '0'
    );
axi_arready_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => S_AXI_ARVALID,
      I1 => \^s_axi_arready\,
      O => axi_arready0
    );
axi_arready_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axi_arready0,
      Q => \^s_axi_arready\,
      R => axi_awready_i_1_n_0
    );
axi_awready_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => S_AXI_ARESETN,
      O => axi_awready_i_1_n_0
    );
axi_awready_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => S_AXI_AWVALID,
      I1 => aw_done,
      O => axi_awready0
    );
axi_awready_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axi_awready0,
      Q => S_AXI_AWREADY,
      R => axi_awready_i_1_n_0
    );
axi_bvalid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08F8"
    )
        port map (
      I0 => w_done_reg_n_0,
      I1 => aw_done,
      I2 => \^s_axi_bvalid\,
      I3 => S_AXI_BREADY,
      O => axi_bvalid_i_1_n_0
    );
axi_bvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axi_bvalid_i_1_n_0,
      Q => \^s_axi_bvalid\,
      R => axi_awready_i_1_n_0
    );
\axi_rdata[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFE200E2"
    )
        port map (
      I0 => \axi_rdata[0]_i_2_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => \axi_rdata[0]_i_3_n_0\,
      I3 => S_AXI_ARADDR(5),
      I4 => \axi_rdata[3]_i_4_n_0\,
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[0]_i_1_n_0\
    );
\axi_rdata[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFCFAFC0"
    )
        port map (
      I0 => data3(0),
      I1 => axireg_sym_div(0),
      I2 => S_AXI_ARADDR(3),
      I3 => S_AXI_ARADDR(2),
      I4 => axireg_enable_reg_n_0,
      O => \axi_rdata[0]_i_2_n_0\
    );
\axi_rdata[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A0CFC0"
    )
        port map (
      I0 => data6(0),
      I1 => \sym_cnt_ff2_reg_n_0_[0]\,
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_pat_data(0),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[0]_i_3_n_0\
    );
\axi_rdata[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[10]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[10]_i_1_n_0\
    );
\axi_rdata[10]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00B8FFFF00B80000"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[10]\,
      I1 => S_AXI_ARADDR(3),
      I2 => axireg_pat_data(10),
      I3 => S_AXI_ARADDR(2),
      I4 => S_AXI_ARADDR(4),
      I5 => \axi_rdata[10]_i_3_n_0\,
      O => \axi_rdata[10]_i_2_n_0\
    );
\axi_rdata[10]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => axireg_sym_div(10),
      I2 => S_AXI_ARADDR(2),
      I3 => data3(10),
      O => \axi_rdata[10]_i_3_n_0\
    );
\axi_rdata[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[11]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[11]_i_1_n_0\
    );
\axi_rdata[11]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00B8FFFF00B80000"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[11]\,
      I1 => S_AXI_ARADDR(3),
      I2 => axireg_pat_data(11),
      I3 => S_AXI_ARADDR(2),
      I4 => S_AXI_ARADDR(4),
      I5 => \axi_rdata[11]_i_3_n_0\,
      O => \axi_rdata[11]_i_2_n_0\
    );
\axi_rdata[11]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => axireg_sym_div(11),
      I2 => S_AXI_ARADDR(2),
      I3 => data3(11),
      O => \axi_rdata[11]_i_3_n_0\
    );
\axi_rdata[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[12]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[12]_i_1_n_0\
    );
\axi_rdata[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00B8FFFF00B80000"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[12]\,
      I1 => S_AXI_ARADDR(3),
      I2 => axireg_pat_data(12),
      I3 => S_AXI_ARADDR(2),
      I4 => S_AXI_ARADDR(4),
      I5 => \axi_rdata[12]_i_3_n_0\,
      O => \axi_rdata[12]_i_2_n_0\
    );
\axi_rdata[12]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => axireg_sym_div(12),
      I2 => S_AXI_ARADDR(2),
      I3 => data3(12),
      O => \axi_rdata[12]_i_3_n_0\
    );
\axi_rdata[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[13]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[13]_i_1_n_0\
    );
\axi_rdata[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00B8FFFF00B80000"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[13]\,
      I1 => S_AXI_ARADDR(3),
      I2 => axireg_pat_data(13),
      I3 => S_AXI_ARADDR(2),
      I4 => S_AXI_ARADDR(4),
      I5 => \axi_rdata[13]_i_3_n_0\,
      O => \axi_rdata[13]_i_2_n_0\
    );
\axi_rdata[13]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => axireg_sym_div(13),
      I2 => S_AXI_ARADDR(2),
      I3 => data3(13),
      O => \axi_rdata[13]_i_3_n_0\
    );
\axi_rdata[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000004540"
    )
        port map (
      I0 => S_AXI_ARADDR(5),
      I1 => \axi_rdata[14]_i_2_n_0\,
      I2 => S_AXI_ARADDR(4),
      I3 => \axi_rdata[14]_i_3_n_0\,
      I4 => S_AXI_ARADDR(6),
      I5 => S_AXI_ARADDR(7),
      O => \axi_rdata[14]_i_1_n_0\
    );
\axi_rdata[14]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00B8"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[14]\,
      I1 => S_AXI_ARADDR(3),
      I2 => axireg_pat_data(14),
      I3 => S_AXI_ARADDR(2),
      O => \axi_rdata[14]_i_2_n_0\
    );
\axi_rdata[14]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => axireg_sym_div(14),
      I2 => S_AXI_ARADDR(2),
      I3 => data3(14),
      O => \axi_rdata[14]_i_3_n_0\
    );
\axi_rdata[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[15]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[15]_i_1_n_0\
    );
\axi_rdata[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00B8FFFF00B80000"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[15]\,
      I1 => S_AXI_ARADDR(3),
      I2 => axireg_pat_data(15),
      I3 => S_AXI_ARADDR(2),
      I4 => S_AXI_ARADDR(4),
      I5 => \axi_rdata[15]_i_3_n_0\,
      O => \axi_rdata[15]_i_2_n_0\
    );
\axi_rdata[15]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => axireg_sym_div(15),
      I2 => S_AXI_ARADDR(2),
      I3 => data3(15),
      O => \axi_rdata[15]_i_3_n_0\
    );
\axi_rdata[16]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \axi_rdata[16]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(6),
      I3 => S_AXI_ARADDR(7),
      O => \axi_rdata[16]_i_1_n_0\
    );
\axi_rdata[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[16]\,
      I1 => axireg_pat_data(16),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(16),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[16]_i_2_n_0\
    );
\axi_rdata[17]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => S_AXI_ARADDR(5),
      I1 => \axi_rdata[17]_i_2_n_0\,
      I2 => S_AXI_ARADDR(6),
      I3 => S_AXI_ARADDR(7),
      O => \axi_rdata[17]_i_1_n_0\
    );
\axi_rdata[17]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[17]\,
      I1 => axireg_pat_data(17),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(17),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[17]_i_2_n_0\
    );
\axi_rdata[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[18]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[18]_i_1_n_0\
    );
\axi_rdata[18]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[18]\,
      I1 => axireg_pat_data(18),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(18),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[18]_i_2_n_0\
    );
\axi_rdata[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[19]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[19]_i_1_n_0\
    );
\axi_rdata[19]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[19]\,
      I1 => axireg_pat_data(19),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(19),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[19]_i_2_n_0\
    );
\axi_rdata[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFE200E2"
    )
        port map (
      I0 => \axi_rdata[1]_i_2_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => \axi_rdata[1]_i_3_n_0\,
      I3 => S_AXI_ARADDR(5),
      I4 => \axi_rdata[3]_i_4_n_0\,
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[1]_i_1_n_0\
    );
\axi_rdata[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data3(1),
      I1 => axireg_sym_div(1),
      I2 => S_AXI_ARADDR(3),
      I3 => active_ff(1),
      I4 => S_AXI_ARADDR(2),
      I5 => \axireg_src_sel_reg_n_0_[0]\,
      O => \axi_rdata[1]_i_2_n_0\
    );
\axi_rdata[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A0CFC0"
    )
        port map (
      I0 => data6(1),
      I1 => \sym_cnt_ff2_reg_n_0_[1]\,
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_pat_data(1),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[1]_i_3_n_0\
    );
\axi_rdata[20]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => S_AXI_ARADDR(5),
      I1 => \axi_rdata[20]_i_2_n_0\,
      I2 => S_AXI_ARADDR(6),
      I3 => S_AXI_ARADDR(7),
      O => \axi_rdata[20]_i_1_n_0\
    );
\axi_rdata[20]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[20]\,
      I1 => axireg_pat_data(20),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(20),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[20]_i_2_n_0\
    );
\axi_rdata[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[21]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[21]_i_1_n_0\
    );
\axi_rdata[21]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[21]\,
      I1 => axireg_pat_data(21),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(21),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[21]_i_2_n_0\
    );
\axi_rdata[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => S_AXI_ARADDR(5),
      I1 => \axi_rdata[22]_i_2_n_0\,
      I2 => S_AXI_ARADDR(6),
      I3 => S_AXI_ARADDR(7),
      O => \axi_rdata[22]_i_1_n_0\
    );
\axi_rdata[22]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[22]\,
      I1 => axireg_pat_data(22),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(22),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[22]_i_2_n_0\
    );
\axi_rdata[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[23]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[23]_i_1_n_0\
    );
\axi_rdata[23]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[23]\,
      I1 => axireg_pat_data(23),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(23),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[23]_i_2_n_0\
    );
\axi_rdata[24]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => S_AXI_ARADDR(5),
      I1 => \axi_rdata[24]_i_2_n_0\,
      I2 => S_AXI_ARADDR(6),
      I3 => S_AXI_ARADDR(7),
      O => \axi_rdata[24]_i_1_n_0\
    );
\axi_rdata[24]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[24]\,
      I1 => axireg_pat_data(24),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(24),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[24]_i_2_n_0\
    );
\axi_rdata[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[25]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[25]_i_1_n_0\
    );
\axi_rdata[25]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[25]\,
      I1 => axireg_pat_data(25),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(25),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[25]_i_2_n_0\
    );
\axi_rdata[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[26]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[26]_i_1_n_0\
    );
\axi_rdata[26]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[26]\,
      I1 => axireg_pat_data(26),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(26),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[26]_i_2_n_0\
    );
\axi_rdata[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[27]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[27]_i_1_n_0\
    );
\axi_rdata[27]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[27]\,
      I1 => axireg_pat_data(27),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(27),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[27]_i_2_n_0\
    );
\axi_rdata[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[28]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[28]_i_1_n_0\
    );
\axi_rdata[28]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[28]\,
      I1 => axireg_pat_data(28),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(28),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[28]_i_2_n_0\
    );
\axi_rdata[29]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => S_AXI_ARADDR(5),
      I1 => \axi_rdata[29]_i_2_n_0\,
      I2 => S_AXI_ARADDR(6),
      I3 => S_AXI_ARADDR(7),
      O => \axi_rdata[29]_i_1_n_0\
    );
\axi_rdata[29]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[29]\,
      I1 => axireg_pat_data(29),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(29),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[29]_i_2_n_0\
    );
\axi_rdata[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFE200E2"
    )
        port map (
      I0 => \axi_rdata[2]_i_2_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => \axi_rdata[2]_i_3_n_0\,
      I3 => S_AXI_ARADDR(5),
      I4 => \axi_rdata[3]_i_4_n_0\,
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[2]_i_1_n_0\
    );
\axi_rdata[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A0CFC0"
    )
        port map (
      I0 => data3(2),
      I1 => axireg_sym_div(2),
      I2 => S_AXI_ARADDR(3),
      I3 => \axireg_src_sel_reg_n_0_[1]\,
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[2]_i_2_n_0\
    );
\axi_rdata[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A0CFC0"
    )
        port map (
      I0 => data6(2),
      I1 => \sym_cnt_ff2_reg_n_0_[2]\,
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_pat_data(2),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[2]_i_3_n_0\
    );
\axi_rdata[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[30]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[30]_i_1_n_0\
    );
\axi_rdata[30]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[30]\,
      I1 => axireg_pat_data(30),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(30),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[30]_i_2_n_0\
    );
\axi_rdata[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[31]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000000A0C0A0C0"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[31]\,
      I1 => axireg_pat_data(31),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data3(31),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[31]_i_2_n_0\
    );
\axi_rdata[31]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => S_AXI_ARADDR(7),
      I1 => S_AXI_ARADDR(6),
      O => \axi_rdata[31]_i_3_n_0\
    );
\axi_rdata[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFE200E2"
    )
        port map (
      I0 => \axi_rdata[3]_i_2_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => \axi_rdata[3]_i_3_n_0\,
      I3 => S_AXI_ARADDR(5),
      I4 => \axi_rdata[3]_i_4_n_0\,
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[3]_i_1_n_0\
    );
\axi_rdata[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A0CFC0"
    )
        port map (
      I0 => data3(3),
      I1 => axireg_sym_div(3),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_ch_sel,
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[3]_i_2_n_0\
    );
\axi_rdata[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A0CFC0"
    )
        port map (
      I0 => data6(3),
      I1 => \sym_cnt_ff2_reg_n_0_[3]\,
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_pat_data(3),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[3]_i_3_n_0\
    );
\axi_rdata[3]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => S_AXI_ARADDR(2),
      I1 => S_AXI_ARADDR(3),
      I2 => S_AXI_ARADDR(4),
      O => \axi_rdata[3]_i_4_n_0\
    );
\axi_rdata[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000004540"
    )
        port map (
      I0 => S_AXI_ARADDR(5),
      I1 => \axi_rdata[4]_i_2_n_0\,
      I2 => S_AXI_ARADDR(4),
      I3 => \axi_rdata[4]_i_3_n_0\,
      I4 => S_AXI_ARADDR(6),
      I5 => S_AXI_ARADDR(7),
      O => \axi_rdata[4]_i_1_n_0\
    );
\axi_rdata[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A0CFC0"
    )
        port map (
      I0 => data6(4),
      I1 => \sym_cnt_ff2_reg_n_0_[4]\,
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_pat_data(4),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[4]_i_2_n_0\
    );
\axi_rdata[4]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => axireg_sym_div(4),
      I2 => S_AXI_ARADDR(2),
      I3 => data3(4),
      O => \axi_rdata[4]_i_3_n_0\
    );
\axi_rdata[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[5]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[5]_i_1_n_0\
    );
\axi_rdata[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
        port map (
      I0 => \axi_rdata[5]_i_3_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_sym_div(5),
      I4 => S_AXI_ARADDR(2),
      I5 => data3(5),
      O => \axi_rdata[5]_i_2_n_0\
    );
\axi_rdata[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A0CFC0"
    )
        port map (
      I0 => data6(5),
      I1 => \sym_cnt_ff2_reg_n_0_[5]\,
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_pat_data(5),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[5]_i_3_n_0\
    );
\axi_rdata[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[6]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[6]_i_1_n_0\
    );
\axi_rdata[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
        port map (
      I0 => \axi_rdata[6]_i_3_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_sym_div(6),
      I4 => S_AXI_ARADDR(2),
      I5 => data3(6),
      O => \axi_rdata[6]_i_2_n_0\
    );
\axi_rdata[6]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A0CFC0"
    )
        port map (
      I0 => data6(6),
      I1 => \sym_cnt_ff2_reg_n_0_[6]\,
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_pat_data(6),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[6]_i_3_n_0\
    );
\axi_rdata[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[7]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[7]_i_1_n_0\
    );
\axi_rdata[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
        port map (
      I0 => \axi_rdata[7]_i_3_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_sym_div(7),
      I4 => S_AXI_ARADDR(2),
      I5 => data3(7),
      O => \axi_rdata[7]_i_2_n_0\
    );
\axi_rdata[7]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A0CFC0"
    )
        port map (
      I0 => data6(7),
      I1 => \sym_cnt_ff2_reg_n_0_[7]\,
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_pat_data(7),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[7]_i_3_n_0\
    );
\axi_rdata[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000004540"
    )
        port map (
      I0 => S_AXI_ARADDR(5),
      I1 => \axi_rdata[8]_i_2_n_0\,
      I2 => S_AXI_ARADDR(4),
      I3 => \axi_rdata[8]_i_3_n_0\,
      I4 => S_AXI_ARADDR(6),
      I5 => S_AXI_ARADDR(7),
      O => \axi_rdata[8]_i_1_n_0\
    );
\axi_rdata[8]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00B8"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[8]\,
      I1 => S_AXI_ARADDR(3),
      I2 => axireg_pat_data(8),
      I3 => S_AXI_ARADDR(2),
      O => \axi_rdata[8]_i_2_n_0\
    );
\axi_rdata[8]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => axireg_sym_div(8),
      I2 => S_AXI_ARADDR(2),
      I3 => data3(8),
      O => \axi_rdata[8]_i_3_n_0\
    );
\axi_rdata[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEE2"
    )
        port map (
      I0 => \axi_rdata[9]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => S_AXI_ARADDR(2),
      I5 => \axi_rdata[31]_i_3_n_0\,
      O => \axi_rdata[9]_i_1_n_0\
    );
\axi_rdata[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00B8FFFF00B80000"
    )
        port map (
      I0 => \sym_cnt_ff2_reg_n_0_[9]\,
      I1 => S_AXI_ARADDR(3),
      I2 => axireg_pat_data(9),
      I3 => S_AXI_ARADDR(2),
      I4 => S_AXI_ARADDR(4),
      I5 => \axi_rdata[9]_i_3_n_0\,
      O => \axi_rdata[9]_i_2_n_0\
    );
\axi_rdata[9]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => axireg_sym_div(9),
      I2 => S_AXI_ARADDR(2),
      I3 => data3(9),
      O => \axi_rdata[9]_i_3_n_0\
    );
\axi_rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[0]_i_1_n_0\,
      Q => S_AXI_RDATA(0),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[10]_i_1_n_0\,
      Q => S_AXI_RDATA(10),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[11]_i_1_n_0\,
      Q => S_AXI_RDATA(11),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[12]_i_1_n_0\,
      Q => S_AXI_RDATA(12),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[13]_i_1_n_0\,
      Q => S_AXI_RDATA(13),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[14]_i_1_n_0\,
      Q => S_AXI_RDATA(14),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[15]_i_1_n_0\,
      Q => S_AXI_RDATA(15),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[16]_i_1_n_0\,
      Q => S_AXI_RDATA(16),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[17]_i_1_n_0\,
      Q => S_AXI_RDATA(17),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[18]_i_1_n_0\,
      Q => S_AXI_RDATA(18),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[19]_i_1_n_0\,
      Q => S_AXI_RDATA(19),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[1]_i_1_n_0\,
      Q => S_AXI_RDATA(1),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[20]_i_1_n_0\,
      Q => S_AXI_RDATA(20),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[21]_i_1_n_0\,
      Q => S_AXI_RDATA(21),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[22]_i_1_n_0\,
      Q => S_AXI_RDATA(22),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[23]_i_1_n_0\,
      Q => S_AXI_RDATA(23),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[24]_i_1_n_0\,
      Q => S_AXI_RDATA(24),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[25]_i_1_n_0\,
      Q => S_AXI_RDATA(25),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[26]_i_1_n_0\,
      Q => S_AXI_RDATA(26),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[27]_i_1_n_0\,
      Q => S_AXI_RDATA(27),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[28]_i_1_n_0\,
      Q => S_AXI_RDATA(28),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[29]_i_1_n_0\,
      Q => S_AXI_RDATA(29),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[2]_i_1_n_0\,
      Q => S_AXI_RDATA(2),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[30]_i_1_n_0\,
      Q => S_AXI_RDATA(30),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[31]_i_1_n_0\,
      Q => S_AXI_RDATA(31),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[3]_i_1_n_0\,
      Q => S_AXI_RDATA(3),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[4]_i_1_n_0\,
      Q => S_AXI_RDATA(4),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[5]_i_1_n_0\,
      Q => S_AXI_RDATA(5),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[6]_i_1_n_0\,
      Q => S_AXI_RDATA(6),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[7]_i_1_n_0\,
      Q => S_AXI_RDATA(7),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[8]_i_1_n_0\,
      Q => S_AXI_RDATA(8),
      R => axi_awready_i_1_n_0
    );
\axi_rdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[9]_i_1_n_0\,
      Q => S_AXI_RDATA(9),
      R => axi_awready_i_1_n_0
    );
axi_rvalid_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AA2020"
    )
        port map (
      I0 => S_AXI_ARESETN,
      I1 => \^s_axi_arready\,
      I2 => S_AXI_ARVALID,
      I3 => S_AXI_RREADY,
      I4 => \^s_axi_rvalid\,
      O => axi_rvalid_i_1_n_0
    );
axi_rvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axi_rvalid_i_1_n_0,
      Q => \^s_axi_rvalid\,
      R => '0'
    );
axi_wready_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => S_AXI_WVALID,
      I1 => w_done_reg_n_0,
      O => axi_wready0
    );
axi_wready_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axi_wready0,
      Q => S_AXI_WREADY,
      R => axi_awready_i_1_n_0
    );
axireg_ch_sel_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_enable,
      D => \w_data_reg_n_0_[3]\,
      Q => axireg_ch_sel,
      R => axi_awready_i_1_n_0
    );
axireg_enable_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_enable,
      D => \w_data_reg_n_0_[0]\,
      Q => axireg_enable_reg_n_0,
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08000000"
    )
        port map (
      I0 => p_0_in(0),
      I1 => p_0_in(1),
      I2 => p_0_in(2),
      I3 => \axireg_i_pos[15]_i_2_n_0\,
      I4 => p_1_in0,
      O => \axireg_i_neg[15]_i_1_n_0\
    );
\axireg_i_neg[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08000000"
    )
        port map (
      I0 => p_0_in(0),
      I1 => p_0_in(1),
      I2 => p_0_in(2),
      I3 => \axireg_i_pos[15]_i_2_n_0\,
      I4 => p_1_in,
      O => \axireg_i_neg[7]_i_1_n_0\
    );
\axireg_i_neg_reg[0]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[0]\,
      Q => data3(0),
      S => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[10]\,
      Q => data3(10),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[11]\,
      Q => data3(11),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[12]\,
      Q => data3(12),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[13]\,
      Q => data3(13),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[14]\,
      Q => data3(14),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[15]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[15]\,
      Q => data3(15),
      S => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[7]_i_1_n_0\,
      D => \p_1_in__0\(0),
      Q => data3(1),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[7]_i_1_n_0\,
      D => \p_1_in__0\(1),
      Q => data3(2),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[3]\,
      Q => data3(3),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[4]\,
      Q => data3(4),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[5]\,
      Q => data3(5),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[6]\,
      Q => data3(6),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[7]\,
      Q => data3(7),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[8]\,
      Q => data3(8),
      R => axi_awready_i_1_n_0
    );
\axireg_i_neg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_neg[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[9]\,
      Q => data3(9),
      R => axi_awready_i_1_n_0
    );
\axireg_i_pos[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08000000"
    )
        port map (
      I0 => p_0_in(0),
      I1 => p_0_in(1),
      I2 => p_0_in(2),
      I3 => \axireg_i_pos[15]_i_2_n_0\,
      I4 => \w_strb_reg_n_0_[3]\,
      O => \axireg_i_pos[15]_i_1_n_0\
    );
\axireg_i_pos[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000001000"
    )
        port map (
      I0 => \aw_addr_reg_n_0_[7]\,
      I1 => \^s_axi_bvalid\,
      I2 => aw_done,
      I3 => w_done_reg_n_0,
      I4 => \aw_addr_reg_n_0_[6]\,
      I5 => \aw_addr_reg_n_0_[5]\,
      O => \axireg_i_pos[15]_i_2_n_0\
    );
\axireg_i_pos[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08000000"
    )
        port map (
      I0 => p_0_in(0),
      I1 => p_0_in(1),
      I2 => p_0_in(2),
      I3 => \axireg_i_pos[15]_i_2_n_0\,
      I4 => \w_strb_reg_n_0_[2]\,
      O => \axireg_i_pos[7]_i_1_n_0\
    );
\axireg_i_pos_reg[0]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[7]_i_1_n_0\,
      D => p_2_in(0),
      Q => data3(16),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[10]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[15]_i_1_n_0\,
      D => p_2_in(10),
      Q => data3(26),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[11]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[15]_i_1_n_0\,
      D => p_2_in(11),
      Q => data3(27),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[12]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[15]_i_1_n_0\,
      D => p_2_in(12),
      Q => data3(28),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[13]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[15]_i_1_n_0\,
      D => p_2_in(13),
      Q => data3(29),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[14]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[15]_i_1_n_0\,
      D => p_2_in(14),
      Q => data3(30),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[15]_i_1_n_0\,
      D => p_2_in(15),
      Q => data3(31),
      R => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[7]_i_1_n_0\,
      D => p_2_in(1),
      Q => data3(17),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[7]_i_1_n_0\,
      D => p_2_in(2),
      Q => data3(18),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[7]_i_1_n_0\,
      D => p_2_in(3),
      Q => data3(19),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[4]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[7]_i_1_n_0\,
      D => p_2_in(4),
      Q => data3(20),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[5]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[7]_i_1_n_0\,
      D => p_2_in(5),
      Q => data3(21),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[6]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[7]_i_1_n_0\,
      D => p_2_in(6),
      Q => data3(22),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[7]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[7]_i_1_n_0\,
      D => p_2_in(7),
      Q => data3(23),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[8]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[15]_i_1_n_0\,
      D => p_2_in(8),
      Q => data3(24),
      S => axi_awready_i_1_n_0
    );
\axireg_i_pos_reg[9]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_i_pos[15]_i_1_n_0\,
      D => p_2_in(9),
      Q => data3(25),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => p_0_in(2),
      I1 => \axireg_src_sel[1]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => p_1_in0,
      O => \axireg_pat_data[15]_i_1_n_0\
    );
\axireg_pat_data[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => p_0_in(2),
      I1 => \axireg_src_sel[1]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => \w_strb_reg_n_0_[2]\,
      O => \axireg_pat_data[23]_i_1_n_0\
    );
\axireg_pat_data[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => p_0_in(2),
      I1 => \axireg_src_sel[1]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => \w_strb_reg_n_0_[3]\,
      O => \axireg_pat_data[31]_i_1_n_0\
    );
\axireg_pat_data[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => p_0_in(2),
      I1 => \axireg_src_sel[1]_i_2_n_0\,
      I2 => p_0_in(1),
      I3 => p_1_in,
      O => \axireg_pat_data[7]_i_1_n_0\
    );
\axireg_pat_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[0]\,
      Q => axireg_pat_data(0),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[10]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[10]\,
      Q => axireg_pat_data(10),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[11]\,
      Q => axireg_pat_data(11),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[12]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[12]\,
      Q => axireg_pat_data(12),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[13]\,
      Q => axireg_pat_data(13),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[14]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[14]\,
      Q => axireg_pat_data(14),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[15]\,
      Q => axireg_pat_data(15),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[23]_i_1_n_0\,
      D => p_2_in(0),
      Q => axireg_pat_data(16),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[17]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[23]_i_1_n_0\,
      D => p_2_in(1),
      Q => axireg_pat_data(17),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[23]_i_1_n_0\,
      D => p_2_in(2),
      Q => axireg_pat_data(18),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[19]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[23]_i_1_n_0\,
      D => p_2_in(3),
      Q => axireg_pat_data(19),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[7]_i_1_n_0\,
      D => \p_1_in__0\(0),
      Q => axireg_pat_data(1),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[23]_i_1_n_0\,
      D => p_2_in(4),
      Q => axireg_pat_data(20),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[21]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[23]_i_1_n_0\,
      D => p_2_in(5),
      Q => axireg_pat_data(21),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[23]_i_1_n_0\,
      D => p_2_in(6),
      Q => axireg_pat_data(22),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[23]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[23]_i_1_n_0\,
      D => p_2_in(7),
      Q => axireg_pat_data(23),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[24]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[31]_i_1_n_0\,
      D => p_2_in(8),
      Q => axireg_pat_data(24),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[31]_i_1_n_0\,
      D => p_2_in(9),
      Q => axireg_pat_data(25),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[26]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[31]_i_1_n_0\,
      D => p_2_in(10),
      Q => axireg_pat_data(26),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[31]_i_1_n_0\,
      D => p_2_in(11),
      Q => axireg_pat_data(27),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[28]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[31]_i_1_n_0\,
      D => p_2_in(12),
      Q => axireg_pat_data(28),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[31]_i_1_n_0\,
      D => p_2_in(13),
      Q => axireg_pat_data(29),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[7]_i_1_n_0\,
      D => \p_1_in__0\(1),
      Q => axireg_pat_data(2),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[30]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[31]_i_1_n_0\,
      D => p_2_in(14),
      Q => axireg_pat_data(30),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[31]_i_1_n_0\,
      D => p_2_in(15),
      Q => axireg_pat_data(31),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[3]\,
      Q => axireg_pat_data(3),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[4]\,
      Q => axireg_pat_data(4),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[5]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[5]\,
      Q => axireg_pat_data(5),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[6]\,
      Q => axireg_pat_data(6),
      R => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[7]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[7]\,
      Q => axireg_pat_data(7),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[8]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[8]\,
      Q => axireg_pat_data(8),
      S => axi_awready_i_1_n_0
    );
\axireg_pat_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_pat_data[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[9]\,
      Q => axireg_pat_data(9),
      R => axi_awready_i_1_n_0
    );
\axireg_src_sel[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => p_0_in(2),
      I1 => p_1_in,
      I2 => p_0_in(1),
      I3 => \axireg_src_sel[1]_i_2_n_0\,
      O => axireg_enable
    );
\axireg_src_sel[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000010"
    )
        port map (
      I0 => \aw_addr_reg_n_0_[5]\,
      I1 => \aw_addr_reg_n_0_[6]\,
      I2 => do_write,
      I3 => \aw_addr_reg_n_0_[7]\,
      I4 => p_0_in(0),
      O => \axireg_src_sel[1]_i_2_n_0\
    );
\axireg_src_sel_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_enable,
      D => \p_1_in__0\(0),
      Q => \axireg_src_sel_reg_n_0_[0]\,
      R => axi_awready_i_1_n_0
    );
\axireg_src_sel_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_enable,
      D => \p_1_in__0\(1),
      Q => \axireg_src_sel_reg_n_0_[1]\,
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => p_1_in0,
      I1 => p_0_in(1),
      I2 => p_0_in(2),
      I3 => \axireg_src_sel[1]_i_2_n_0\,
      O => \axireg_sym_div[15]_i_1_n_0\
    );
\axireg_sym_div[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => p_1_in,
      I1 => p_0_in(1),
      I2 => p_0_in(2),
      I3 => \axireg_src_sel[1]_i_2_n_0\,
      O => \axireg_sym_div[7]_i_1_n_0\
    );
\axireg_sym_div_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[0]\,
      Q => axireg_sym_div(0),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[10]\,
      Q => axireg_sym_div(10),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[11]\,
      Q => axireg_sym_div(11),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[12]\,
      Q => axireg_sym_div(12),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[13]\,
      Q => axireg_sym_div(13),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[14]\,
      Q => axireg_sym_div(14),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[15]\,
      Q => axireg_sym_div(15),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[7]_i_1_n_0\,
      D => \p_1_in__0\(0),
      Q => axireg_sym_div(1),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[7]_i_1_n_0\,
      D => \p_1_in__0\(1),
      Q => axireg_sym_div(2),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[3]\,
      Q => axireg_sym_div(3),
      S => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[4]\,
      Q => axireg_sym_div(4),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[5]\,
      Q => axireg_sym_div(5),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[6]\,
      Q => axireg_sym_div(6),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[7]\,
      Q => axireg_sym_div(7),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[8]\,
      Q => axireg_sym_div(8),
      R => axi_awready_i_1_n_0
    );
\axireg_sym_div_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_sym_div[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[9]\,
      Q => axireg_sym_div(9),
      R => axi_awready_i_1_n_0
    );
core_ch_sel_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_ch_sel,
      Q => core_ch_sel
    );
core_enable_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_enable,
      Q => core_enable
    );
\core_i_neg_reg[0]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_neg(0),
      PRE => u_bpsk_core_n_0,
      Q => core_i_neg(0)
    );
\core_i_neg_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(10),
      Q => core_i_neg(10)
    );
\core_i_neg_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(11),
      Q => core_i_neg(11)
    );
\core_i_neg_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(12),
      Q => core_i_neg(12)
    );
\core_i_neg_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(13),
      Q => core_i_neg(13)
    );
\core_i_neg_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(14),
      Q => core_i_neg(14)
    );
\core_i_neg_reg[15]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_neg(15),
      PRE => u_bpsk_core_n_0,
      Q => core_i_neg(15)
    );
\core_i_neg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(1),
      Q => core_i_neg(1)
    );
\core_i_neg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(2),
      Q => core_i_neg(2)
    );
\core_i_neg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(3),
      Q => core_i_neg(3)
    );
\core_i_neg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(4),
      Q => core_i_neg(4)
    );
\core_i_neg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(5),
      Q => core_i_neg(5)
    );
\core_i_neg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(6),
      Q => core_i_neg(6)
    );
\core_i_neg_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(7),
      Q => core_i_neg(7)
    );
\core_i_neg_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(8),
      Q => core_i_neg(8)
    );
\core_i_neg_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_neg(9),
      Q => core_i_neg(9)
    );
\core_i_pos_reg[0]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(0),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(0)
    );
\core_i_pos_reg[10]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(10),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(10)
    );
\core_i_pos_reg[11]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(11),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(11)
    );
\core_i_pos_reg[12]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(12),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(12)
    );
\core_i_pos_reg[13]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(13),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(13)
    );
\core_i_pos_reg[14]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(14),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(14)
    );
\core_i_pos_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_i_pos(15),
      Q => core_i_pos(15)
    );
\core_i_pos_reg[1]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(1),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(1)
    );
\core_i_pos_reg[2]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(2),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(2)
    );
\core_i_pos_reg[3]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(3),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(3)
    );
\core_i_pos_reg[4]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(4),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(4)
    );
\core_i_pos_reg[5]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(5),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(5)
    );
\core_i_pos_reg[6]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(6),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(6)
    );
\core_i_pos_reg[7]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(7),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(7)
    );
\core_i_pos_reg[8]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(8),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(8)
    );
\core_i_pos_reg[9]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_i_pos(9),
      PRE => u_bpsk_core_n_0,
      Q => core_i_pos(9)
    );
\core_pat_data_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(0),
      Q => core_pat_data(0)
    );
\core_pat_data_reg[10]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(10),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(10)
    );
\core_pat_data_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(11),
      Q => core_pat_data(11)
    );
\core_pat_data_reg[12]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(12),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(12)
    );
\core_pat_data_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(13),
      Q => core_pat_data(13)
    );
\core_pat_data_reg[14]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(14),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(14)
    );
\core_pat_data_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(15),
      Q => core_pat_data(15)
    );
\core_pat_data_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(16),
      Q => core_pat_data(16)
    );
\core_pat_data_reg[17]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(17),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(17)
    );
\core_pat_data_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(18),
      Q => core_pat_data(18)
    );
\core_pat_data_reg[19]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(19),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(19)
    );
\core_pat_data_reg[1]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(1),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(1)
    );
\core_pat_data_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(20),
      Q => core_pat_data(20)
    );
\core_pat_data_reg[21]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(21),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(21)
    );
\core_pat_data_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(22),
      Q => core_pat_data(22)
    );
\core_pat_data_reg[23]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(23),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(23)
    );
\core_pat_data_reg[24]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(24),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(24)
    );
\core_pat_data_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(25),
      Q => core_pat_data(25)
    );
\core_pat_data_reg[26]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(26),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(26)
    );
\core_pat_data_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(27),
      Q => core_pat_data(27)
    );
\core_pat_data_reg[28]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(28),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(28)
    );
\core_pat_data_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(29),
      Q => core_pat_data(29)
    );
\core_pat_data_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(2),
      Q => core_pat_data(2)
    );
\core_pat_data_reg[30]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(30),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(30)
    );
\core_pat_data_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(31),
      Q => core_pat_data(31)
    );
\core_pat_data_reg[3]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(3),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(3)
    );
\core_pat_data_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(4),
      Q => core_pat_data(4)
    );
\core_pat_data_reg[5]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(5),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(5)
    );
\core_pat_data_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(6),
      Q => core_pat_data(6)
    );
\core_pat_data_reg[7]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(7),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(7)
    );
\core_pat_data_reg[8]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_pat_data(8),
      PRE => u_bpsk_core_n_0,
      Q => core_pat_data(8)
    );
\core_pat_data_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_pat_data(9),
      Q => core_pat_data(9)
    );
\core_src_sel_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_src_sel(0),
      Q => core_src_sel(0)
    );
\core_src_sel_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_src_sel(1),
      Q => core_src_sel(1)
    );
\core_sym_div_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(0),
      Q => core_sym_div(0)
    );
\core_sym_div_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(10),
      Q => core_sym_div(10)
    );
\core_sym_div_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(11),
      Q => core_sym_div(11)
    );
\core_sym_div_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(12),
      Q => core_sym_div(12)
    );
\core_sym_div_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(13),
      Q => core_sym_div(13)
    );
\core_sym_div_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(14),
      Q => core_sym_div(14)
    );
\core_sym_div_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(15),
      Q => core_sym_div(15)
    );
\core_sym_div_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(1),
      Q => core_sym_div(1)
    );
\core_sym_div_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(2),
      Q => core_sym_div(2)
    );
\core_sym_div_reg[3]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_sym_div(3),
      PRE => u_bpsk_core_n_0,
      Q => core_sym_div(3)
    );
\core_sym_div_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(4),
      Q => core_sym_div(4)
    );
\core_sym_div_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(5),
      Q => core_sym_div(5)
    );
\core_sym_div_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(6),
      Q => core_sym_div(6)
    );
\core_sym_div_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(7),
      Q => core_sym_div(7)
    );
\core_sym_div_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(8),
      Q => core_sym_div(8)
    );
\core_sym_div_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_bpsk_core_n_0,
      D => snap_sym_div(9),
      Q => core_sym_div(9)
    );
snap_ch_sel_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_ch_sel,
      Q => snap_ch_sel,
      R => axi_awready_i_1_n_0
    );
snap_enable_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_enable_reg_n_0,
      Q => snap_enable,
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[0]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(0),
      Q => snap_i_neg(0),
      S => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(10),
      Q => snap_i_neg(10),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(11),
      Q => snap_i_neg(11),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(12),
      Q => snap_i_neg(12),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(13),
      Q => snap_i_neg(13),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(14),
      Q => snap_i_neg(14),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[15]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(15),
      Q => snap_i_neg(15),
      S => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(1),
      Q => snap_i_neg(1),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(2),
      Q => snap_i_neg(2),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(3),
      Q => snap_i_neg(3),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(4),
      Q => snap_i_neg(4),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(5),
      Q => snap_i_neg(5),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(6),
      Q => snap_i_neg(6),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(7),
      Q => snap_i_neg(7),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(8),
      Q => snap_i_neg(8),
      R => axi_awready_i_1_n_0
    );
\snap_i_neg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(9),
      Q => snap_i_neg(9),
      R => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[0]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(16),
      Q => snap_i_pos(0),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[10]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(26),
      Q => snap_i_pos(10),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[11]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(27),
      Q => snap_i_pos(11),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[12]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(28),
      Q => snap_i_pos(12),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[13]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(29),
      Q => snap_i_pos(13),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[14]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(30),
      Q => snap_i_pos(14),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(31),
      Q => snap_i_pos(15),
      R => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(17),
      Q => snap_i_pos(1),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(18),
      Q => snap_i_pos(2),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(19),
      Q => snap_i_pos(3),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[4]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(20),
      Q => snap_i_pos(4),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[5]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(21),
      Q => snap_i_pos(5),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[6]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(22),
      Q => snap_i_pos(6),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[7]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(23),
      Q => snap_i_pos(7),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[8]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(24),
      Q => snap_i_pos(8),
      S => axi_awready_i_1_n_0
    );
\snap_i_pos_reg[9]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data3(25),
      Q => snap_i_pos(9),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(0),
      Q => snap_pat_data(0),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[10]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(10),
      Q => snap_pat_data(10),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(11),
      Q => snap_pat_data(11),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[12]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(12),
      Q => snap_pat_data(12),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(13),
      Q => snap_pat_data(13),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[14]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(14),
      Q => snap_pat_data(14),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(15),
      Q => snap_pat_data(15),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(16),
      Q => snap_pat_data(16),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[17]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(17),
      Q => snap_pat_data(17),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(18),
      Q => snap_pat_data(18),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[19]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(19),
      Q => snap_pat_data(19),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(1),
      Q => snap_pat_data(1),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(20),
      Q => snap_pat_data(20),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[21]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(21),
      Q => snap_pat_data(21),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(22),
      Q => snap_pat_data(22),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[23]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(23),
      Q => snap_pat_data(23),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[24]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(24),
      Q => snap_pat_data(24),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(25),
      Q => snap_pat_data(25),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[26]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(26),
      Q => snap_pat_data(26),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(27),
      Q => snap_pat_data(27),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[28]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(28),
      Q => snap_pat_data(28),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(29),
      Q => snap_pat_data(29),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(2),
      Q => snap_pat_data(2),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[30]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(30),
      Q => snap_pat_data(30),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(31),
      Q => snap_pat_data(31),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(3),
      Q => snap_pat_data(3),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(4),
      Q => snap_pat_data(4),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[5]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(5),
      Q => snap_pat_data(5),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(6),
      Q => snap_pat_data(6),
      R => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[7]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(7),
      Q => snap_pat_data(7),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[8]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(8),
      Q => snap_pat_data(8),
      S => axi_awready_i_1_n_0
    );
\snap_pat_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_pat_data(9),
      Q => snap_pat_data(9),
      R => axi_awready_i_1_n_0
    );
\snap_src_sel_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \axireg_src_sel_reg_n_0_[0]\,
      Q => snap_src_sel(0),
      R => axi_awready_i_1_n_0
    );
\snap_src_sel_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \axireg_src_sel_reg_n_0_[1]\,
      Q => snap_src_sel(1),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(0),
      Q => snap_sym_div(0),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(10),
      Q => snap_sym_div(10),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(11),
      Q => snap_sym_div(11),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(12),
      Q => snap_sym_div(12),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(13),
      Q => snap_sym_div(13),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(14),
      Q => snap_sym_div(14),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(15),
      Q => snap_sym_div(15),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(1),
      Q => snap_sym_div(1),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(2),
      Q => snap_sym_div(2),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(3),
      Q => snap_sym_div(3),
      S => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(4),
      Q => snap_sym_div(4),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(5),
      Q => snap_sym_div(5),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(6),
      Q => snap_sym_div(6),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(7),
      Q => snap_sym_div(7),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(8),
      Q => snap_sym_div(8),
      R => axi_awready_i_1_n_0
    );
\snap_sym_div_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_sym_div(9),
      Q => snap_sym_div(9),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(0),
      Q => sym_cnt_ff1(0),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(10),
      Q => sym_cnt_ff1(10),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(11),
      Q => sym_cnt_ff1(11),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(12),
      Q => sym_cnt_ff1(12),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(13),
      Q => sym_cnt_ff1(13),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(14),
      Q => sym_cnt_ff1(14),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(15),
      Q => sym_cnt_ff1(15),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(16),
      Q => sym_cnt_ff1(16),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(17),
      Q => sym_cnt_ff1(17),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(18),
      Q => sym_cnt_ff1(18),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(19),
      Q => sym_cnt_ff1(19),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(1),
      Q => sym_cnt_ff1(1),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(20),
      Q => sym_cnt_ff1(20),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(21),
      Q => sym_cnt_ff1(21),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(22),
      Q => sym_cnt_ff1(22),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(23),
      Q => sym_cnt_ff1(23),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(24),
      Q => sym_cnt_ff1(24),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(25),
      Q => sym_cnt_ff1(25),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(26),
      Q => sym_cnt_ff1(26),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(27),
      Q => sym_cnt_ff1(27),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(28),
      Q => sym_cnt_ff1(28),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(29),
      Q => sym_cnt_ff1(29),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(2),
      Q => sym_cnt_ff1(2),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(30),
      Q => sym_cnt_ff1(30),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(31),
      Q => sym_cnt_ff1(31),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(32),
      Q => sym_cnt_ff1(32),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(33),
      Q => sym_cnt_ff1(33),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(34),
      Q => sym_cnt_ff1(34),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(35),
      Q => sym_cnt_ff1(35),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(36),
      Q => sym_cnt_ff1(36),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(37),
      Q => sym_cnt_ff1(37),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(38),
      Q => sym_cnt_ff1(38),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(39),
      Q => sym_cnt_ff1(39),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(3),
      Q => sym_cnt_ff1(3),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(4),
      Q => sym_cnt_ff1(4),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(5),
      Q => sym_cnt_ff1(5),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(6),
      Q => sym_cnt_ff1(6),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(7),
      Q => sym_cnt_ff1(7),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(8),
      Q => sym_cnt_ff1(8),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_count_reg(9),
      Q => sym_cnt_ff1(9),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(0),
      Q => \sym_cnt_ff2_reg_n_0_[0]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(10),
      Q => \sym_cnt_ff2_reg_n_0_[10]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(11),
      Q => \sym_cnt_ff2_reg_n_0_[11]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(12),
      Q => \sym_cnt_ff2_reg_n_0_[12]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(13),
      Q => \sym_cnt_ff2_reg_n_0_[13]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(14),
      Q => \sym_cnt_ff2_reg_n_0_[14]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(15),
      Q => \sym_cnt_ff2_reg_n_0_[15]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(16),
      Q => \sym_cnt_ff2_reg_n_0_[16]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(17),
      Q => \sym_cnt_ff2_reg_n_0_[17]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(18),
      Q => \sym_cnt_ff2_reg_n_0_[18]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(19),
      Q => \sym_cnt_ff2_reg_n_0_[19]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(1),
      Q => \sym_cnt_ff2_reg_n_0_[1]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(20),
      Q => \sym_cnt_ff2_reg_n_0_[20]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(21),
      Q => \sym_cnt_ff2_reg_n_0_[21]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(22),
      Q => \sym_cnt_ff2_reg_n_0_[22]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(23),
      Q => \sym_cnt_ff2_reg_n_0_[23]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(24),
      Q => \sym_cnt_ff2_reg_n_0_[24]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(25),
      Q => \sym_cnt_ff2_reg_n_0_[25]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(26),
      Q => \sym_cnt_ff2_reg_n_0_[26]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(27),
      Q => \sym_cnt_ff2_reg_n_0_[27]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(28),
      Q => \sym_cnt_ff2_reg_n_0_[28]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(29),
      Q => \sym_cnt_ff2_reg_n_0_[29]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(2),
      Q => \sym_cnt_ff2_reg_n_0_[2]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(30),
      Q => \sym_cnt_ff2_reg_n_0_[30]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(31),
      Q => \sym_cnt_ff2_reg_n_0_[31]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(32),
      Q => data6(0),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(33),
      Q => data6(1),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(34),
      Q => data6(2),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(35),
      Q => data6(3),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(36),
      Q => data6(4),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(37),
      Q => data6(5),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(38),
      Q => data6(6),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(39),
      Q => data6(7),
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(3),
      Q => \sym_cnt_ff2_reg_n_0_[3]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(4),
      Q => \sym_cnt_ff2_reg_n_0_[4]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(5),
      Q => \sym_cnt_ff2_reg_n_0_[5]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(6),
      Q => \sym_cnt_ff2_reg_n_0_[6]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(7),
      Q => \sym_cnt_ff2_reg_n_0_[7]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(8),
      Q => \sym_cnt_ff2_reg_n_0_[8]\,
      R => axi_awready_i_1_n_0
    );
\sym_cnt_ff2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => sym_cnt_ff1(9),
      Q => \sym_cnt_ff2_reg_n_0_[9]\,
      R => axi_awready_i_1_n_0
    );
u_bpsk_core: entity work.system_bpsk_modulator_0_0_bpsk_core
     port map (
      D(39 downto 0) => sym_count_reg(39 downto 0),
      M_AXIS_DAC_TDATA(63 downto 0) => M_AXIS_DAC_TDATA(63 downto 0),
      M_AXIS_DAC_TREADY => M_AXIS_DAC_TREADY,
      M_AXIS_DAC_TVALID => M_AXIS_DAC_TVALID,
      Q(15 downto 0) => core_sym_div(15 downto 0),
      SS(0) => u_bpsk_core_n_0,
      S_AXIS_BITS_TDATA(0) => S_AXIS_BITS_TDATA(0),
      S_AXIS_BITS_TREADY => S_AXIS_BITS_TREADY,
      S_AXIS_BITS_TVALID => S_AXIS_BITS_TVALID,
      S_AXIS_DMA_TDATA(63 downto 0) => S_AXIS_DMA_TDATA(63 downto 0),
      S_AXIS_DMA_TVALID => S_AXIS_DMA_TVALID,
      aclk => aclk,
      aresetn => aresetn,
      axis_bit_reg_0(1 downto 0) => core_src_sel(1 downto 0),
      core_ch_sel => core_ch_sel,
      core_enable => core_enable,
      \i_hold_reg[15]_0\(15 downto 0) => core_i_pos(15 downto 0),
      \i_hold_reg[15]_1\(15 downto 0) => core_i_neg(15 downto 0),
      \i_hold_reg[15]_i_4_0\(31 downto 0) => core_pat_data(31 downto 0)
    );
\w_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(0),
      Q => \w_data_reg_n_0_[0]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(10),
      Q => \w_data_reg_n_0_[10]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(11),
      Q => \w_data_reg_n_0_[11]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(12),
      Q => \w_data_reg_n_0_[12]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(13),
      Q => \w_data_reg_n_0_[13]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(14),
      Q => \w_data_reg_n_0_[14]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(15),
      Q => \w_data_reg_n_0_[15]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(16),
      Q => p_2_in(0),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(17),
      Q => p_2_in(1),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(18),
      Q => p_2_in(2),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(19),
      Q => p_2_in(3),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(1),
      Q => \p_1_in__0\(0),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(20),
      Q => p_2_in(4),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(21),
      Q => p_2_in(5),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(22),
      Q => p_2_in(6),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(23),
      Q => p_2_in(7),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(24),
      Q => p_2_in(8),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(25),
      Q => p_2_in(9),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(26),
      Q => p_2_in(10),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(27),
      Q => p_2_in(11),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(28),
      Q => p_2_in(12),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(29),
      Q => p_2_in(13),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(2),
      Q => \p_1_in__0\(1),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(30),
      Q => p_2_in(14),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(31),
      Q => p_2_in(15),
      R => axi_awready_i_1_n_0
    );
\w_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(3),
      Q => \w_data_reg_n_0_[3]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(4),
      Q => \w_data_reg_n_0_[4]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(5),
      Q => \w_data_reg_n_0_[5]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(6),
      Q => \w_data_reg_n_0_[6]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(7),
      Q => \w_data_reg_n_0_[7]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(8),
      Q => \w_data_reg_n_0_[8]\,
      R => axi_awready_i_1_n_0
    );
\w_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(9),
      Q => \w_data_reg_n_0_[9]\,
      R => axi_awready_i_1_n_0
    );
w_done_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00E0E0E0"
    )
        port map (
      I0 => w_done_reg_n_0,
      I1 => S_AXI_WVALID,
      I2 => S_AXI_ARESETN,
      I3 => \^s_axi_bvalid\,
      I4 => S_AXI_BREADY,
      O => w_done_i_1_n_0
    );
w_done_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => w_done_i_1_n_0,
      Q => w_done_reg_n_0,
      R => '0'
    );
\w_strb_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WSTRB(0),
      Q => p_1_in,
      R => axi_awready_i_1_n_0
    );
\w_strb_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WSTRB(1),
      Q => p_1_in0,
      R => axi_awready_i_1_n_0
    );
\w_strb_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WSTRB(2),
      Q => \w_strb_reg_n_0_[2]\,
      R => axi_awready_i_1_n_0
    );
\w_strb_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WSTRB(3),
      Q => \w_strb_reg_n_0_[3]\,
      R => axi_awready_i_1_n_0
    );
wr_pulse_axi_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => \^s_axi_bvalid\,
      I1 => aw_done,
      I2 => w_done_reg_n_0,
      O => do_write
    );
wr_pulse_axi_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => do_write,
      Q => wr_pulse_axi,
      R => '0'
    );
\wr_pulse_sync_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => u_bpsk_core_n_0,
      D => wr_pulse_axi,
      Q => \wr_pulse_sync_reg_n_0_[0]\
    );
\wr_pulse_sync_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => u_bpsk_core_n_0,
      D => \wr_pulse_sync_reg_n_0_[0]\,
      Q => wr_pulse_core
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_bpsk_modulator_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of system_bpsk_modulator_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of system_bpsk_modulator_0_0 : entity is "system_bpsk_modulator_0_0,bpsk_modulator_v1_0,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of system_bpsk_modulator_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of system_bpsk_modulator_0_0 : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of system_bpsk_modulator_0_0 : entity is "bpsk_modulator_v1_0,Vivado 2022.2";
end system_bpsk_modulator_0_0;

architecture STRUCTURE of system_bpsk_modulator_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal NLW_inst_S_AXI_BRESP_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_S_AXI_RRESP_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of inst : label is 8;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of inst : label is 32;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of M_AXIS_DAC_TLAST : signal is "xilinx.com:interface:axis:1.0 M_AXIS_DAC TLAST";
  attribute X_INTERFACE_INFO of M_AXIS_DAC_TREADY : signal is "xilinx.com:interface:axis:1.0 M_AXIS_DAC TREADY";
  attribute X_INTERFACE_INFO of M_AXIS_DAC_TVALID : signal is "xilinx.com:interface:axis:1.0 M_AXIS_DAC TVALID";
  attribute X_INTERFACE_INFO of S_AXIS_BITS_TREADY : signal is "xilinx.com:interface:axis:1.0 S_AXIS_BITS TREADY";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of S_AXIS_BITS_TREADY : signal is "XIL_INTERFACENAME S_AXIS_BITS, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of S_AXIS_BITS_TVALID : signal is "xilinx.com:interface:axis:1.0 S_AXIS_BITS TVALID";
  attribute X_INTERFACE_INFO of S_AXIS_DMA_TLAST : signal is "xilinx.com:interface:axis:1.0 S_AXIS_DMA TLAST";
  attribute X_INTERFACE_INFO of S_AXIS_DMA_TREADY : signal is "xilinx.com:interface:axis:1.0 S_AXIS_DMA TREADY";
  attribute X_INTERFACE_INFO of S_AXIS_DMA_TVALID : signal is "xilinx.com:interface:axis:1.0 S_AXIS_DMA TVALID";
  attribute X_INTERFACE_INFO of S_AXI_ACLK : signal is "xilinx.com:signal:clock:1.0 S_AXI_ACLK CLK";
  attribute X_INTERFACE_PARAMETER of S_AXI_ACLK : signal is "XIL_INTERFACENAME S_AXI_ACLK, ASSOCIATED_BUSIF S_AXI, ASSOCIATED_RESET S_AXI_ARESETN, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_sys_ps7_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of S_AXI_ARESETN : signal is "xilinx.com:signal:reset:1.0 S_AXI_ARESETN RST";
  attribute X_INTERFACE_PARAMETER of S_AXI_ARESETN : signal is "XIL_INTERFACENAME S_AXI_ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of S_AXI_ARREADY : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARREADY";
  attribute X_INTERFACE_INFO of S_AXI_ARVALID : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARVALID";
  attribute X_INTERFACE_INFO of S_AXI_AWREADY : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWREADY";
  attribute X_INTERFACE_INFO of S_AXI_AWVALID : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWVALID";
  attribute X_INTERFACE_INFO of S_AXI_BREADY : signal is "xilinx.com:interface:aximm:1.0 S_AXI BREADY";
  attribute X_INTERFACE_INFO of S_AXI_BVALID : signal is "xilinx.com:interface:aximm:1.0 S_AXI BVALID";
  attribute X_INTERFACE_INFO of S_AXI_RREADY : signal is "xilinx.com:interface:aximm:1.0 S_AXI RREADY";
  attribute X_INTERFACE_PARAMETER of S_AXI_RREADY : signal is "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 8, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN system_sys_ps7_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of S_AXI_RVALID : signal is "xilinx.com:interface:aximm:1.0 S_AXI RVALID";
  attribute X_INTERFACE_INFO of S_AXI_WREADY : signal is "xilinx.com:interface:aximm:1.0 S_AXI WREADY";
  attribute X_INTERFACE_INFO of S_AXI_WVALID : signal is "xilinx.com:interface:aximm:1.0 S_AXI WVALID";
  attribute X_INTERFACE_INFO of aclk : signal is "xilinx.com:signal:clock:1.0 aclk CLK";
  attribute X_INTERFACE_PARAMETER of aclk : signal is "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF S_AXIS_BITS:S_AXIS_DMA:M_AXIS_DAC, ASSOCIATED_RESET aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of aresetn : signal is "xilinx.com:signal:reset:1.0 aresetn RST";
  attribute X_INTERFACE_PARAMETER of aresetn : signal is "XIL_INTERFACENAME aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of M_AXIS_DAC_TDATA : signal is "xilinx.com:interface:axis:1.0 M_AXIS_DAC TDATA";
  attribute X_INTERFACE_INFO of M_AXIS_DAC_TKEEP : signal is "xilinx.com:interface:axis:1.0 M_AXIS_DAC TKEEP";
  attribute X_INTERFACE_PARAMETER of M_AXIS_DAC_TKEEP : signal is "XIL_INTERFACENAME M_AXIS_DAC, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of S_AXIS_BITS_TDATA : signal is "xilinx.com:interface:axis:1.0 S_AXIS_BITS TDATA";
  attribute X_INTERFACE_INFO of S_AXIS_DMA_TDATA : signal is "xilinx.com:interface:axis:1.0 S_AXIS_DMA TDATA";
  attribute X_INTERFACE_INFO of S_AXIS_DMA_TKEEP : signal is "xilinx.com:interface:axis:1.0 S_AXIS_DMA TKEEP";
  attribute X_INTERFACE_PARAMETER of S_AXIS_DMA_TKEEP : signal is "XIL_INTERFACENAME S_AXIS_DMA, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of S_AXI_ARADDR : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARADDR";
  attribute X_INTERFACE_INFO of S_AXI_ARPROT : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARPROT";
  attribute X_INTERFACE_INFO of S_AXI_AWADDR : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWADDR";
  attribute X_INTERFACE_INFO of S_AXI_AWPROT : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWPROT";
  attribute X_INTERFACE_INFO of S_AXI_BRESP : signal is "xilinx.com:interface:aximm:1.0 S_AXI BRESP";
  attribute X_INTERFACE_INFO of S_AXI_RDATA : signal is "xilinx.com:interface:aximm:1.0 S_AXI RDATA";
  attribute X_INTERFACE_INFO of S_AXI_RRESP : signal is "xilinx.com:interface:aximm:1.0 S_AXI RRESP";
  attribute X_INTERFACE_INFO of S_AXI_WDATA : signal is "xilinx.com:interface:aximm:1.0 S_AXI WDATA";
  attribute X_INTERFACE_INFO of S_AXI_WSTRB : signal is "xilinx.com:interface:aximm:1.0 S_AXI WSTRB";
begin
  S_AXI_BRESP(1) <= \<const0>\;
  S_AXI_BRESP(0) <= \<const0>\;
  S_AXI_RRESP(1) <= \<const0>\;
  S_AXI_RRESP(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.system_bpsk_modulator_0_0_bpsk_modulator_v1_0
     port map (
      M_AXIS_DAC_TDATA(63 downto 0) => M_AXIS_DAC_TDATA(63 downto 0),
      M_AXIS_DAC_TKEEP(7 downto 0) => M_AXIS_DAC_TKEEP(7 downto 0),
      M_AXIS_DAC_TLAST => M_AXIS_DAC_TLAST,
      M_AXIS_DAC_TREADY => M_AXIS_DAC_TREADY,
      M_AXIS_DAC_TVALID => M_AXIS_DAC_TVALID,
      S_AXIS_BITS_TDATA(7 downto 1) => B"0000000",
      S_AXIS_BITS_TDATA(0) => S_AXIS_BITS_TDATA(0),
      S_AXIS_BITS_TREADY => S_AXIS_BITS_TREADY,
      S_AXIS_BITS_TVALID => S_AXIS_BITS_TVALID,
      S_AXIS_DMA_TDATA(63 downto 0) => S_AXIS_DMA_TDATA(63 downto 0),
      S_AXIS_DMA_TKEEP(7 downto 0) => S_AXIS_DMA_TKEEP(7 downto 0),
      S_AXIS_DMA_TLAST => S_AXIS_DMA_TLAST,
      S_AXIS_DMA_TREADY => S_AXIS_DMA_TREADY,
      S_AXIS_DMA_TVALID => S_AXIS_DMA_TVALID,
      S_AXI_ACLK => S_AXI_ACLK,
      S_AXI_ARADDR(7 downto 2) => S_AXI_ARADDR(7 downto 2),
      S_AXI_ARADDR(1 downto 0) => B"00",
      S_AXI_ARESETN => S_AXI_ARESETN,
      S_AXI_ARPROT(2 downto 0) => B"000",
      S_AXI_ARREADY => S_AXI_ARREADY,
      S_AXI_ARVALID => S_AXI_ARVALID,
      S_AXI_AWADDR(7 downto 2) => S_AXI_AWADDR(7 downto 2),
      S_AXI_AWADDR(1 downto 0) => B"00",
      S_AXI_AWPROT(2 downto 0) => B"000",
      S_AXI_AWREADY => S_AXI_AWREADY,
      S_AXI_AWVALID => S_AXI_AWVALID,
      S_AXI_BREADY => S_AXI_BREADY,
      S_AXI_BRESP(1 downto 0) => NLW_inst_S_AXI_BRESP_UNCONNECTED(1 downto 0),
      S_AXI_BVALID => S_AXI_BVALID,
      S_AXI_RDATA(31 downto 0) => S_AXI_RDATA(31 downto 0),
      S_AXI_RREADY => S_AXI_RREADY,
      S_AXI_RRESP(1 downto 0) => NLW_inst_S_AXI_RRESP_UNCONNECTED(1 downto 0),
      S_AXI_RVALID => S_AXI_RVALID,
      S_AXI_WDATA(31 downto 0) => S_AXI_WDATA(31 downto 0),
      S_AXI_WREADY => S_AXI_WREADY,
      S_AXI_WSTRB(3 downto 0) => S_AXI_WSTRB(3 downto 0),
      S_AXI_WVALID => S_AXI_WVALID,
      aclk => aclk,
      aresetn => aresetn
    );
end STRUCTURE;
