-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Tue Mar 31 15:18:45 2026
-- Host        : kemal-EXCALIBUR-G770 running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_bpsk_demodulator_0_0_sim_netlist.vhdl
-- Design      : system_bpsk_demodulator_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_agc is
  port (
    A : out STD_LOGIC_VECTOR ( 15 downto 0 );
    aresetn_0 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 15 downto 0 );
    \q_out_reg[15]_0\ : out STD_LOGIC_VECTOR ( 15 downto 0 );
    settled_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    \i_out_reg[15]_0\ : out STD_LOGIC_VECTOR ( 15 downto 0 );
    \out\ : out STD_LOGIC_VECTOR ( 15 downto 0 );
    adc_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    DI : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \q_mix_reg[7]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \q_mix_reg[11]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \q_mix_reg[15]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    P : in STD_LOGIC_VECTOR ( 0 to 0 );
    \q_mix_reg[15]_0\ : in STD_LOGIC_VECTOR ( 15 downto 0 );
    core_bypass_costas : in STD_LOGIC;
    p_1_out : in STD_LOGIC_VECTOR ( 14 downto 0 );
    adc_valid : in STD_LOGIC;
    core_enable : in STD_LOGIC;
    core_bypass_agc : in STD_LOGIC;
    \gain_acc_reg[19]_0\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    aresetn : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    \i_mix_reg[3]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \i_mix_reg[7]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \i_mix_reg[11]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \i_mix_reg[15]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \i_mix_reg[15]_0\ : in STD_LOGIC_VECTOR ( 15 downto 0 );
    \i_mix_reg[15]_1\ : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_agc;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_agc is
  signal \^a\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal aD2M4dsP : STD_LOGIC_VECTOR ( 16 to 16 );
  signal abs_i0 : STD_LOGIC_VECTOR ( 15 downto 1 );
  signal abs_q0 : STD_LOGIC_VECTOR ( 15 downto 1 );
  signal \^aresetn_0\ : STD_LOGIC;
  signal err_abs0 : STD_LOGIC_VECTOR ( 15 downto 1 );
  signal err_abs1 : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal error : STD_LOGIC_VECTOR ( 16 downto 0 );
  signal \error_carry__0_i_10_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_11_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_12_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_13_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_14_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_14_n_1\ : STD_LOGIC;
  signal \error_carry__0_i_14_n_2\ : STD_LOGIC;
  signal \error_carry__0_i_14_n_3\ : STD_LOGIC;
  signal \error_carry__0_i_15_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_15_n_1\ : STD_LOGIC;
  signal \error_carry__0_i_15_n_2\ : STD_LOGIC;
  signal \error_carry__0_i_15_n_3\ : STD_LOGIC;
  signal \error_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_20_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_21_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_22_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_23_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_5_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_5_n_1\ : STD_LOGIC;
  signal \error_carry__0_i_5_n_2\ : STD_LOGIC;
  signal \error_carry__0_i_5_n_3\ : STD_LOGIC;
  signal \error_carry__0_i_5_n_4\ : STD_LOGIC;
  signal \error_carry__0_i_5_n_5\ : STD_LOGIC;
  signal \error_carry__0_i_5_n_6\ : STD_LOGIC;
  signal \error_carry__0_i_5_n_7\ : STD_LOGIC;
  signal \error_carry__0_i_6_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_7_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_8_n_0\ : STD_LOGIC;
  signal \error_carry__0_i_9_n_0\ : STD_LOGIC;
  signal \error_carry__0_n_0\ : STD_LOGIC;
  signal \error_carry__0_n_1\ : STD_LOGIC;
  signal \error_carry__0_n_2\ : STD_LOGIC;
  signal \error_carry__0_n_3\ : STD_LOGIC;
  signal \error_carry__1_i_10_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_11_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_12_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_13_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_14_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_14_n_1\ : STD_LOGIC;
  signal \error_carry__1_i_14_n_2\ : STD_LOGIC;
  signal \error_carry__1_i_14_n_3\ : STD_LOGIC;
  signal \error_carry__1_i_15_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_15_n_1\ : STD_LOGIC;
  signal \error_carry__1_i_15_n_2\ : STD_LOGIC;
  signal \error_carry__1_i_15_n_3\ : STD_LOGIC;
  signal \error_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_20_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_21_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_22_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_23_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_5_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_5_n_1\ : STD_LOGIC;
  signal \error_carry__1_i_5_n_2\ : STD_LOGIC;
  signal \error_carry__1_i_5_n_3\ : STD_LOGIC;
  signal \error_carry__1_i_5_n_4\ : STD_LOGIC;
  signal \error_carry__1_i_5_n_5\ : STD_LOGIC;
  signal \error_carry__1_i_5_n_6\ : STD_LOGIC;
  signal \error_carry__1_i_5_n_7\ : STD_LOGIC;
  signal \error_carry__1_i_6_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_7_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_8_n_0\ : STD_LOGIC;
  signal \error_carry__1_i_9_n_0\ : STD_LOGIC;
  signal \error_carry__1_n_0\ : STD_LOGIC;
  signal \error_carry__1_n_1\ : STD_LOGIC;
  signal \error_carry__1_n_2\ : STD_LOGIC;
  signal \error_carry__1_n_3\ : STD_LOGIC;
  signal \error_carry__2_i_10_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_11_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_12_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_13_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_14_n_2\ : STD_LOGIC;
  signal \error_carry__2_i_14_n_3\ : STD_LOGIC;
  signal \error_carry__2_i_15_n_2\ : STD_LOGIC;
  signal \error_carry__2_i_15_n_3\ : STD_LOGIC;
  signal \error_carry__2_i_19_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_20_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_21_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_5_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_5_n_1\ : STD_LOGIC;
  signal \error_carry__2_i_5_n_2\ : STD_LOGIC;
  signal \error_carry__2_i_5_n_3\ : STD_LOGIC;
  signal \error_carry__2_i_5_n_4\ : STD_LOGIC;
  signal \error_carry__2_i_5_n_5\ : STD_LOGIC;
  signal \error_carry__2_i_5_n_6\ : STD_LOGIC;
  signal \error_carry__2_i_5_n_7\ : STD_LOGIC;
  signal \error_carry__2_i_6_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_7_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_8_n_0\ : STD_LOGIC;
  signal \error_carry__2_i_9_n_0\ : STD_LOGIC;
  signal \error_carry__2_n_0\ : STD_LOGIC;
  signal \error_carry__2_n_1\ : STD_LOGIC;
  signal \error_carry__2_n_2\ : STD_LOGIC;
  signal \error_carry__2_n_3\ : STD_LOGIC;
  signal \error_carry__3_n_2\ : STD_LOGIC;
  signal error_carry_i_10_n_0 : STD_LOGIC;
  signal error_carry_i_11_n_0 : STD_LOGIC;
  signal error_carry_i_12_n_0 : STD_LOGIC;
  signal error_carry_i_13_n_0 : STD_LOGIC;
  signal error_carry_i_13_n_1 : STD_LOGIC;
  signal error_carry_i_13_n_2 : STD_LOGIC;
  signal error_carry_i_13_n_3 : STD_LOGIC;
  signal error_carry_i_14_n_0 : STD_LOGIC;
  signal error_carry_i_14_n_1 : STD_LOGIC;
  signal error_carry_i_14_n_2 : STD_LOGIC;
  signal error_carry_i_14_n_3 : STD_LOGIC;
  signal error_carry_i_1_n_0 : STD_LOGIC;
  signal error_carry_i_20_n_0 : STD_LOGIC;
  signal error_carry_i_21_n_0 : STD_LOGIC;
  signal error_carry_i_22_n_0 : STD_LOGIC;
  signal error_carry_i_23_n_0 : STD_LOGIC;
  signal error_carry_i_24_n_0 : STD_LOGIC;
  signal error_carry_i_2_n_0 : STD_LOGIC;
  signal error_carry_i_3_n_0 : STD_LOGIC;
  signal error_carry_i_4_n_0 : STD_LOGIC;
  signal error_carry_i_5_n_0 : STD_LOGIC;
  signal error_carry_i_5_n_1 : STD_LOGIC;
  signal error_carry_i_5_n_2 : STD_LOGIC;
  signal error_carry_i_5_n_3 : STD_LOGIC;
  signal error_carry_i_5_n_4 : STD_LOGIC;
  signal error_carry_i_5_n_5 : STD_LOGIC;
  signal error_carry_i_5_n_6 : STD_LOGIC;
  signal error_carry_i_5_n_7 : STD_LOGIC;
  signal error_carry_i_6_n_0 : STD_LOGIC;
  signal error_carry_i_7_n_0 : STD_LOGIC;
  signal error_carry_i_8_n_0 : STD_LOGIC;
  signal error_carry_i_9_n_0 : STD_LOGIC;
  signal error_carry_n_0 : STD_LOGIC;
  signal error_carry_n_1 : STD_LOGIC;
  signal error_carry_n_2 : STD_LOGIC;
  signal error_carry_n_3 : STD_LOGIC;
  signal gain_acc0 : STD_LOGIC;
  signal \gain_acc[0]_i_10_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_11_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_12_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_13_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_14_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_15_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_16_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_17_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_18_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_19_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_20_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_21_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_22_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_3_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_4_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_5_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_6_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_7_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_8_n_0\ : STD_LOGIC;
  signal \gain_acc[0]_i_9_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_10_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_11_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_12_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_13_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_2_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_3_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_4_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_5_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_6_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_7_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_8_n_0\ : STD_LOGIC;
  signal \gain_acc[12]_i_9_n_0\ : STD_LOGIC;
  signal \gain_acc[16]_i_2_n_0\ : STD_LOGIC;
  signal \gain_acc[16]_i_3_n_0\ : STD_LOGIC;
  signal \gain_acc[16]_i_4_n_0\ : STD_LOGIC;
  signal \gain_acc[16]_i_5_n_0\ : STD_LOGIC;
  signal \gain_acc[16]_i_6_n_0\ : STD_LOGIC;
  signal \gain_acc[16]_i_7_n_0\ : STD_LOGIC;
  signal \gain_acc[16]_i_8_n_0\ : STD_LOGIC;
  signal \gain_acc[20]_i_2_n_0\ : STD_LOGIC;
  signal \gain_acc[20]_i_3_n_0\ : STD_LOGIC;
  signal \gain_acc[20]_i_4_n_0\ : STD_LOGIC;
  signal \gain_acc[20]_i_5_n_0\ : STD_LOGIC;
  signal \gain_acc[24]_i_2_n_0\ : STD_LOGIC;
  signal \gain_acc[24]_i_3_n_0\ : STD_LOGIC;
  signal \gain_acc[24]_i_4_n_0\ : STD_LOGIC;
  signal \gain_acc[24]_i_5_n_0\ : STD_LOGIC;
  signal \gain_acc[28]_i_2_n_0\ : STD_LOGIC;
  signal \gain_acc[28]_i_3_n_0\ : STD_LOGIC;
  signal \gain_acc[28]_i_4_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_10_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_11_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_12_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_13_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_14_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_15_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_16_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_2_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_3_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_4_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_5_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_6_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_7_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_8_n_0\ : STD_LOGIC;
  signal \gain_acc[4]_i_9_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_10_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_11_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_12_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_13_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_14_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_15_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_16_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_2_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_3_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_4_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_5_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_6_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_7_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_8_n_0\ : STD_LOGIC;
  signal \gain_acc[8]_i_9_n_0\ : STD_LOGIC;
  signal \gain_acc_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \gain_acc_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \gain_acc_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \gain_acc_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \gain_acc_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \gain_acc_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \gain_acc_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \gain_acc_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \gain_acc_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \gain_acc_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \gain_acc_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \gain_acc_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \gain_acc_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \gain_acc_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \gain_acc_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \gain_acc_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \gain_acc_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \gain_acc_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \gain_acc_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \gain_acc_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \gain_acc_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \gain_acc_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \gain_acc_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \gain_acc_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \gain_acc_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \gain_acc_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \gain_acc_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \gain_acc_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \gain_acc_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \gain_acc_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \gain_acc_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \gain_acc_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \gain_acc_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \gain_acc_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \gain_acc_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \gain_acc_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \gain_acc_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \gain_acc_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \gain_acc_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \gain_acc_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \gain_acc_reg[28]_i_1_n_0\ : STD_LOGIC;
  signal \gain_acc_reg[28]_i_1_n_2\ : STD_LOGIC;
  signal \gain_acc_reg[28]_i_1_n_3\ : STD_LOGIC;
  signal \gain_acc_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \gain_acc_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \gain_acc_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \gain_acc_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \gain_acc_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \gain_acc_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \gain_acc_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \gain_acc_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \gain_acc_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \gain_acc_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \gain_acc_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \gain_acc_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \gain_acc_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \gain_acc_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \gain_acc_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \gain_acc_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \gain_acc_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \gain_acc_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \gain_acc_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[0]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[10]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[11]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[1]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[28]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[29]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[2]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[30]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[31]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[3]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[4]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[5]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[6]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[7]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[8]\ : STD_LOGIC;
  signal \gain_acc_reg_n_0_[9]\ : STD_LOGIC;
  signal \i_mix[11]_i_6_n_0\ : STD_LOGIC;
  signal \i_mix[11]_i_7_n_0\ : STD_LOGIC;
  signal \i_mix[11]_i_8_n_0\ : STD_LOGIC;
  signal \i_mix[11]_i_9_n_0\ : STD_LOGIC;
  signal \i_mix[15]_i_5_n_0\ : STD_LOGIC;
  signal \i_mix[15]_i_6_n_0\ : STD_LOGIC;
  signal \i_mix[15]_i_7_n_0\ : STD_LOGIC;
  signal \i_mix[15]_i_8_n_0\ : STD_LOGIC;
  signal \i_mix[3]_i_6_n_0\ : STD_LOGIC;
  signal \i_mix[3]_i_7_n_0\ : STD_LOGIC;
  signal \i_mix[3]_i_8_n_0\ : STD_LOGIC;
  signal \i_mix[3]_i_9_n_0\ : STD_LOGIC;
  signal \i_mix[7]_i_6_n_0\ : STD_LOGIC;
  signal \i_mix[7]_i_7_n_0\ : STD_LOGIC;
  signal \i_mix[7]_i_8_n_0\ : STD_LOGIC;
  signal \i_mix[7]_i_9_n_0\ : STD_LOGIC;
  signal \i_mix_reg[11]_i_1_n_0\ : STD_LOGIC;
  signal \i_mix_reg[11]_i_1_n_1\ : STD_LOGIC;
  signal \i_mix_reg[11]_i_1_n_2\ : STD_LOGIC;
  signal \i_mix_reg[11]_i_1_n_3\ : STD_LOGIC;
  signal \i_mix_reg[15]_i_1_n_1\ : STD_LOGIC;
  signal \i_mix_reg[15]_i_1_n_2\ : STD_LOGIC;
  signal \i_mix_reg[15]_i_1_n_3\ : STD_LOGIC;
  signal \i_mix_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \i_mix_reg[3]_i_1_n_1\ : STD_LOGIC;
  signal \i_mix_reg[3]_i_1_n_2\ : STD_LOGIC;
  signal \i_mix_reg[3]_i_1_n_3\ : STD_LOGIC;
  signal \i_mix_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \i_mix_reg[7]_i_1_n_1\ : STD_LOGIC;
  signal \i_mix_reg[7]_i_1_n_2\ : STD_LOGIC;
  signal \i_mix_reg[7]_i_1_n_3\ : STD_LOGIC;
  signal \i_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[10]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[11]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[12]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[13]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[14]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[14]_i_2_n_0\ : STD_LOGIC;
  signal \i_out[15]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[3]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[4]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[5]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[6]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[7]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[8]_i_1_n_0\ : STD_LOGIC;
  signal \i_out[9]_i_1_n_0\ : STD_LOGIC;
  signal \^i_out_reg[15]_0\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal in_range : STD_LOGIC;
  signal \in_range_carry__0_i_10_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_11_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_12_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_13_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_14_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_15_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_16_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_18_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_19_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_20_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_5_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_6_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_7_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_8_n_0\ : STD_LOGIC;
  signal \in_range_carry__0_i_8_n_1\ : STD_LOGIC;
  signal \in_range_carry__0_i_8_n_2\ : STD_LOGIC;
  signal \in_range_carry__0_i_8_n_3\ : STD_LOGIC;
  signal \in_range_carry__0_i_9_n_2\ : STD_LOGIC;
  signal \in_range_carry__0_i_9_n_3\ : STD_LOGIC;
  signal \in_range_carry__0_n_1\ : STD_LOGIC;
  signal \in_range_carry__0_n_2\ : STD_LOGIC;
  signal \in_range_carry__0_n_3\ : STD_LOGIC;
  signal in_range_carry_i_10_n_0 : STD_LOGIC;
  signal in_range_carry_i_10_n_1 : STD_LOGIC;
  signal in_range_carry_i_10_n_2 : STD_LOGIC;
  signal in_range_carry_i_10_n_3 : STD_LOGIC;
  signal in_range_carry_i_11_n_0 : STD_LOGIC;
  signal in_range_carry_i_12_n_0 : STD_LOGIC;
  signal in_range_carry_i_12_n_1 : STD_LOGIC;
  signal in_range_carry_i_12_n_2 : STD_LOGIC;
  signal in_range_carry_i_12_n_3 : STD_LOGIC;
  signal in_range_carry_i_13_n_0 : STD_LOGIC;
  signal in_range_carry_i_14_n_0 : STD_LOGIC;
  signal in_range_carry_i_15_n_0 : STD_LOGIC;
  signal in_range_carry_i_16_n_0 : STD_LOGIC;
  signal in_range_carry_i_1_n_0 : STD_LOGIC;
  signal in_range_carry_i_2_n_0 : STD_LOGIC;
  signal in_range_carry_i_3_n_0 : STD_LOGIC;
  signal in_range_carry_i_4_n_0 : STD_LOGIC;
  signal in_range_carry_i_5_n_0 : STD_LOGIC;
  signal in_range_carry_i_6_n_0 : STD_LOGIC;
  signal in_range_carry_i_7_n_0 : STD_LOGIC;
  signal in_range_carry_i_8_n_0 : STD_LOGIC;
  signal in_range_carry_i_9_n_0 : STD_LOGIC;
  signal in_range_carry_n_0 : STD_LOGIC;
  signal in_range_carry_n_1 : STD_LOGIC;
  signal in_range_carry_n_2 : STD_LOGIC;
  signal in_range_carry_n_3 : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal p_0_in_1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal prod_i_n_100 : STD_LOGIC;
  signal prod_i_n_101 : STD_LOGIC;
  signal prod_i_n_102 : STD_LOGIC;
  signal prod_i_n_103 : STD_LOGIC;
  signal prod_i_n_104 : STD_LOGIC;
  signal prod_i_n_105 : STD_LOGIC;
  signal prod_i_n_70 : STD_LOGIC;
  signal prod_i_n_71 : STD_LOGIC;
  signal prod_i_n_72 : STD_LOGIC;
  signal prod_i_n_73 : STD_LOGIC;
  signal prod_i_n_79 : STD_LOGIC;
  signal prod_i_n_80 : STD_LOGIC;
  signal prod_i_n_81 : STD_LOGIC;
  signal prod_i_n_82 : STD_LOGIC;
  signal prod_i_n_83 : STD_LOGIC;
  signal prod_i_n_84 : STD_LOGIC;
  signal prod_i_n_85 : STD_LOGIC;
  signal prod_i_n_86 : STD_LOGIC;
  signal prod_i_n_87 : STD_LOGIC;
  signal prod_i_n_88 : STD_LOGIC;
  signal prod_i_n_89 : STD_LOGIC;
  signal prod_i_n_90 : STD_LOGIC;
  signal prod_i_n_91 : STD_LOGIC;
  signal prod_i_n_92 : STD_LOGIC;
  signal prod_i_n_93 : STD_LOGIC;
  signal prod_i_n_94 : STD_LOGIC;
  signal prod_i_n_95 : STD_LOGIC;
  signal prod_i_n_96 : STD_LOGIC;
  signal prod_i_n_97 : STD_LOGIC;
  signal prod_i_n_98 : STD_LOGIC;
  signal prod_i_n_99 : STD_LOGIC;
  signal prod_q_n_100 : STD_LOGIC;
  signal prod_q_n_101 : STD_LOGIC;
  signal prod_q_n_102 : STD_LOGIC;
  signal prod_q_n_103 : STD_LOGIC;
  signal prod_q_n_104 : STD_LOGIC;
  signal prod_q_n_105 : STD_LOGIC;
  signal prod_q_n_70 : STD_LOGIC;
  signal prod_q_n_71 : STD_LOGIC;
  signal prod_q_n_72 : STD_LOGIC;
  signal prod_q_n_73 : STD_LOGIC;
  signal prod_q_n_74 : STD_LOGIC;
  signal prod_q_n_75 : STD_LOGIC;
  signal prod_q_n_76 : STD_LOGIC;
  signal prod_q_n_77 : STD_LOGIC;
  signal prod_q_n_78 : STD_LOGIC;
  signal prod_q_n_79 : STD_LOGIC;
  signal prod_q_n_80 : STD_LOGIC;
  signal prod_q_n_81 : STD_LOGIC;
  signal prod_q_n_82 : STD_LOGIC;
  signal prod_q_n_83 : STD_LOGIC;
  signal prod_q_n_84 : STD_LOGIC;
  signal prod_q_n_85 : STD_LOGIC;
  signal prod_q_n_86 : STD_LOGIC;
  signal prod_q_n_87 : STD_LOGIC;
  signal prod_q_n_88 : STD_LOGIC;
  signal prod_q_n_89 : STD_LOGIC;
  signal prod_q_n_90 : STD_LOGIC;
  signal prod_q_n_91 : STD_LOGIC;
  signal prod_q_n_92 : STD_LOGIC;
  signal prod_q_n_93 : STD_LOGIC;
  signal prod_q_n_94 : STD_LOGIC;
  signal prod_q_n_95 : STD_LOGIC;
  signal prod_q_n_96 : STD_LOGIC;
  signal prod_q_n_97 : STD_LOGIC;
  signal prod_q_n_98 : STD_LOGIC;
  signal prod_q_n_99 : STD_LOGIC;
  signal \q_mix[11]_i_6_n_0\ : STD_LOGIC;
  signal \q_mix[11]_i_7_n_0\ : STD_LOGIC;
  signal \q_mix[11]_i_8_n_0\ : STD_LOGIC;
  signal \q_mix[11]_i_9_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_5_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_6_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_7_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_8_n_0\ : STD_LOGIC;
  signal \q_mix[3]_i_6_n_0\ : STD_LOGIC;
  signal \q_mix[3]_i_7_n_0\ : STD_LOGIC;
  signal \q_mix[3]_i_8_n_0\ : STD_LOGIC;
  signal \q_mix[3]_i_9_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_6_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_7_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_8_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_9_n_0\ : STD_LOGIC;
  signal \q_mix_reg[11]_i_1_n_0\ : STD_LOGIC;
  signal \q_mix_reg[11]_i_1_n_1\ : STD_LOGIC;
  signal \q_mix_reg[11]_i_1_n_2\ : STD_LOGIC;
  signal \q_mix_reg[11]_i_1_n_3\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_1_n_1\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_1_n_2\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_1_n_3\ : STD_LOGIC;
  signal \q_mix_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \q_mix_reg[3]_i_1_n_1\ : STD_LOGIC;
  signal \q_mix_reg[3]_i_1_n_2\ : STD_LOGIC;
  signal \q_mix_reg[3]_i_1_n_3\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_1_n_1\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_1_n_2\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_1_n_3\ : STD_LOGIC;
  signal \q_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[10]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[11]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[12]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[13]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[14]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[14]_i_2_n_0\ : STD_LOGIC;
  signal \q_out[15]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[3]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[4]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[5]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[6]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[7]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[8]_i_1_n_0\ : STD_LOGIC;
  signal \q_out[9]_i_1_n_0\ : STD_LOGIC;
  signal \^q_out_reg[15]_0\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal settle_cnt : STD_LOGIC;
  signal \settle_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \settle_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \settle_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \settle_cnt[3]_i_1_n_0\ : STD_LOGIC;
  signal \settle_cnt[4]_i_1_n_0\ : STD_LOGIC;
  signal \settle_cnt[5]_i_2_n_0\ : STD_LOGIC;
  signal \settle_cnt[5]_i_3_n_0\ : STD_LOGIC;
  signal \settle_cnt[5]_i_4_n_0\ : STD_LOGIC;
  signal \settle_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \settle_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \settle_cnt_reg_n_0_[2]\ : STD_LOGIC;
  signal \settle_cnt_reg_n_0_[3]\ : STD_LOGIC;
  signal \settle_cnt_reg_n_0_[4]\ : STD_LOGIC;
  signal \settle_cnt_reg_n_0_[5]\ : STD_LOGIC;
  signal settled_i_1_n_0 : STD_LOGIC;
  signal \^settled_reg_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_error_carry__2_i_14_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_error_carry__2_i_14_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_error_carry__2_i_15_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_error_carry__2_i_15_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_error_carry__3_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_error_carry__3_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_error_carry__3_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_error_carry__3_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_gain_acc_reg[28]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 to 2 );
  signal \NLW_gain_acc_reg[28]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_i_mix_reg[15]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_in_range_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_in_range_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_in_range_carry__0_i_9_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_in_range_carry__0_i_9_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_prod_i_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_i_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_i_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_i_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_i_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_i_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_i_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_prod_i_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_prod_i_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_prod_i_P_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 36 );
  signal NLW_prod_i_PCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal NLW_prod_q_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_q_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_q_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_q_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_q_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_q_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_prod_q_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_prod_q_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_prod_q_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_prod_q_P_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 36 );
  signal NLW_prod_q_PCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal \NLW_q_mix_reg[15]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \error_carry__0_i_14\ : label is 35;
  attribute ADDER_THRESHOLD of \error_carry__0_i_15\ : label is 35;
  attribute ADDER_THRESHOLD of \error_carry__1_i_14\ : label is 35;
  attribute ADDER_THRESHOLD of \error_carry__1_i_15\ : label is 35;
  attribute ADDER_THRESHOLD of \error_carry__2_i_14\ : label is 35;
  attribute ADDER_THRESHOLD of \error_carry__2_i_15\ : label is 35;
  attribute ADDER_THRESHOLD of error_carry_i_13 : label is 35;
  attribute ADDER_THRESHOLD of error_carry_i_14 : label is 35;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gain_acc[0]_i_11\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gain_acc[0]_i_12\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gain_acc[0]_i_13\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gain_acc[0]_i_14\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gain_acc[0]_i_20\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \gain_acc[12]_i_10\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gain_acc[12]_i_11\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gain_acc[12]_i_12\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gain_acc[16]_i_8\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gain_acc[4]_i_12\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gain_acc[4]_i_13\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gain_acc[4]_i_14\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \gain_acc[4]_i_15\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gain_acc[8]_i_10\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \gain_acc[8]_i_11\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gain_acc[8]_i_16\ : label is "soft_lutpair2";
  attribute COMPARATOR_THRESHOLD : integer;
  attribute COMPARATOR_THRESHOLD of in_range_carry : label is 11;
  attribute COMPARATOR_THRESHOLD of \in_range_carry__0\ : label is 11;
  attribute SOFT_HLUTNM of \in_range_carry__0_i_10\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \in_range_carry__0_i_11\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \in_range_carry__0_i_12\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \in_range_carry__0_i_13\ : label is "soft_lutpair7";
  attribute ADDER_THRESHOLD of \in_range_carry__0_i_8\ : label is 35;
  attribute ADDER_THRESHOLD of \in_range_carry__0_i_9\ : label is 35;
  attribute ADDER_THRESHOLD of in_range_carry_i_10 : label is 35;
  attribute SOFT_HLUTNM of in_range_carry_i_11 : label is "soft_lutpair9";
  attribute ADDER_THRESHOLD of in_range_carry_i_12 : label is 35;
  attribute SOFT_HLUTNM of in_range_carry_i_13 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of in_range_carry_i_14 : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of in_range_carry_i_15 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of in_range_carry_i_16 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of in_range_carry_i_9 : label is "soft_lutpair8";
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of prod_i : label is "{SYNTH-13 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of prod_q : label is "{SYNTH-13 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \settle_cnt[0]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \settle_cnt[1]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \settle_cnt[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \settle_cnt[3]_i_1\ : label is "soft_lutpair0";
begin
  A(15 downto 0) <= \^a\(15 downto 0);
  aresetn_0 <= \^aresetn_0\;
  \i_out_reg[15]_0\(15 downto 0) <= \^i_out_reg[15]_0\(15 downto 0);
  \q_out_reg[15]_0\(15 downto 0) <= \^q_out_reg[15]_0\(15 downto 0);
  settled_reg_0(0) <= \^settled_reg_0\(0);
\bits_tdata[7]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => aresetn,
      O => \^aresetn_0\
    );
error_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => error_carry_n_0,
      CO(2) => error_carry_n_1,
      CO(1) => error_carry_n_2,
      CO(0) => error_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => Q(3 downto 0),
      O(3 downto 0) => error(3 downto 0),
      S(3) => error_carry_i_1_n_0,
      S(2) => error_carry_i_2_n_0,
      S(1) => error_carry_i_3_n_0,
      S(0) => error_carry_i_4_n_0
    );
\error_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => error_carry_n_0,
      CO(3) => \error_carry__0_n_0\,
      CO(2) => \error_carry__0_n_1\,
      CO(1) => \error_carry__0_n_2\,
      CO(0) => \error_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => Q(7 downto 4),
      O(3 downto 0) => error(7 downto 4),
      S(3) => \error_carry__0_i_1_n_0\,
      S(2) => \error_carry__0_i_2_n_0\,
      S(1) => \error_carry__0_i_3_n_0\,
      S(0) => \error_carry__0_i_4_n_0\
    );
\error_carry__0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(7),
      I1 => \error_carry__0_i_5_n_4\,
      O => \error_carry__0_i_1_n_0\
    );
\error_carry__0_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(7),
      I1 => adc_data(15),
      I2 => abs_i0(7),
      I3 => adc_data(23),
      I4 => adc_data(31),
      I5 => abs_q0(7),
      O => \error_carry__0_i_10_n_0\
    );
\error_carry__0_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(6),
      I1 => adc_data(15),
      I2 => abs_i0(6),
      I3 => adc_data(22),
      I4 => adc_data(31),
      I5 => abs_q0(6),
      O => \error_carry__0_i_11_n_0\
    );
\error_carry__0_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(5),
      I1 => adc_data(15),
      I2 => abs_i0(5),
      I3 => adc_data(21),
      I4 => adc_data(31),
      I5 => abs_q0(5),
      O => \error_carry__0_i_12_n_0\
    );
\error_carry__0_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(4),
      I1 => adc_data(15),
      I2 => abs_i0(4),
      I3 => adc_data(20),
      I4 => adc_data(31),
      I5 => abs_q0(4),
      O => \error_carry__0_i_13_n_0\
    );
\error_carry__0_i_14\: unisim.vcomponents.CARRY4
     port map (
      CI => error_carry_i_13_n_0,
      CO(3) => \error_carry__0_i_14_n_0\,
      CO(2) => \error_carry__0_i_14_n_1\,
      CO(1) => \error_carry__0_i_14_n_2\,
      CO(0) => \error_carry__0_i_14_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => abs_i0(8 downto 5),
      S(3 downto 0) => p_0_in_1(8 downto 5)
    );
\error_carry__0_i_15\: unisim.vcomponents.CARRY4
     port map (
      CI => error_carry_i_14_n_0,
      CO(3) => \error_carry__0_i_15_n_0\,
      CO(2) => \error_carry__0_i_15_n_1\,
      CO(1) => \error_carry__0_i_15_n_2\,
      CO(0) => \error_carry__0_i_15_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => abs_q0(8 downto 5),
      S(3) => \error_carry__0_i_20_n_0\,
      S(2) => \error_carry__0_i_21_n_0\,
      S(1) => \error_carry__0_i_22_n_0\,
      S(0) => \error_carry__0_i_23_n_0\
    );
\error_carry__0_i_16\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(8),
      O => p_0_in_1(8)
    );
\error_carry__0_i_17\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(7),
      O => p_0_in_1(7)
    );
\error_carry__0_i_18\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(6),
      O => p_0_in_1(6)
    );
\error_carry__0_i_19\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(5),
      O => p_0_in_1(5)
    );
\error_carry__0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(6),
      I1 => \error_carry__0_i_5_n_5\,
      O => \error_carry__0_i_2_n_0\
    );
\error_carry__0_i_20\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(24),
      O => \error_carry__0_i_20_n_0\
    );
\error_carry__0_i_21\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(23),
      O => \error_carry__0_i_21_n_0\
    );
\error_carry__0_i_22\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(22),
      O => \error_carry__0_i_22_n_0\
    );
\error_carry__0_i_23\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(21),
      O => \error_carry__0_i_23_n_0\
    );
\error_carry__0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(5),
      I1 => \error_carry__0_i_5_n_6\,
      O => \error_carry__0_i_3_n_0\
    );
\error_carry__0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(4),
      I1 => \error_carry__0_i_5_n_7\,
      O => \error_carry__0_i_4_n_0\
    );
\error_carry__0_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => error_carry_i_5_n_0,
      CO(3) => \error_carry__0_i_5_n_0\,
      CO(2) => \error_carry__0_i_5_n_1\,
      CO(1) => \error_carry__0_i_5_n_2\,
      CO(0) => \error_carry__0_i_5_n_3\,
      CYINIT => '0',
      DI(3) => \error_carry__0_i_6_n_0\,
      DI(2) => \error_carry__0_i_7_n_0\,
      DI(1) => \error_carry__0_i_8_n_0\,
      DI(0) => \error_carry__0_i_9_n_0\,
      O(3) => \error_carry__0_i_5_n_4\,
      O(2) => \error_carry__0_i_5_n_5\,
      O(1) => \error_carry__0_i_5_n_6\,
      O(0) => \error_carry__0_i_5_n_7\,
      S(3) => \error_carry__0_i_10_n_0\,
      S(2) => \error_carry__0_i_11_n_0\,
      S(1) => \error_carry__0_i_12_n_0\,
      S(0) => \error_carry__0_i_13_n_0\
    );
\error_carry__0_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(7),
      I1 => adc_data(15),
      I2 => adc_data(7),
      O => \error_carry__0_i_6_n_0\
    );
\error_carry__0_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(6),
      I1 => adc_data(15),
      I2 => adc_data(6),
      O => \error_carry__0_i_7_n_0\
    );
\error_carry__0_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(5),
      I1 => adc_data(15),
      I2 => adc_data(5),
      O => \error_carry__0_i_8_n_0\
    );
\error_carry__0_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(4),
      I1 => adc_data(15),
      I2 => adc_data(4),
      O => \error_carry__0_i_9_n_0\
    );
\error_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \error_carry__0_n_0\,
      CO(3) => \error_carry__1_n_0\,
      CO(2) => \error_carry__1_n_1\,
      CO(1) => \error_carry__1_n_2\,
      CO(0) => \error_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => Q(11 downto 8),
      O(3 downto 0) => error(11 downto 8),
      S(3) => \error_carry__1_i_1_n_0\,
      S(2) => \error_carry__1_i_2_n_0\,
      S(1) => \error_carry__1_i_3_n_0\,
      S(0) => \error_carry__1_i_4_n_0\
    );
\error_carry__1_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(11),
      I1 => \error_carry__1_i_5_n_4\,
      O => \error_carry__1_i_1_n_0\
    );
\error_carry__1_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(11),
      I1 => adc_data(15),
      I2 => abs_i0(11),
      I3 => adc_data(27),
      I4 => adc_data(31),
      I5 => abs_q0(11),
      O => \error_carry__1_i_10_n_0\
    );
\error_carry__1_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(10),
      I1 => adc_data(15),
      I2 => abs_i0(10),
      I3 => adc_data(26),
      I4 => adc_data(31),
      I5 => abs_q0(10),
      O => \error_carry__1_i_11_n_0\
    );
\error_carry__1_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(9),
      I1 => adc_data(15),
      I2 => abs_i0(9),
      I3 => adc_data(25),
      I4 => adc_data(31),
      I5 => abs_q0(9),
      O => \error_carry__1_i_12_n_0\
    );
\error_carry__1_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(8),
      I1 => adc_data(15),
      I2 => abs_i0(8),
      I3 => adc_data(24),
      I4 => adc_data(31),
      I5 => abs_q0(8),
      O => \error_carry__1_i_13_n_0\
    );
\error_carry__1_i_14\: unisim.vcomponents.CARRY4
     port map (
      CI => \error_carry__0_i_14_n_0\,
      CO(3) => \error_carry__1_i_14_n_0\,
      CO(2) => \error_carry__1_i_14_n_1\,
      CO(1) => \error_carry__1_i_14_n_2\,
      CO(0) => \error_carry__1_i_14_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => abs_i0(12 downto 9),
      S(3 downto 0) => p_0_in_1(12 downto 9)
    );
\error_carry__1_i_15\: unisim.vcomponents.CARRY4
     port map (
      CI => \error_carry__0_i_15_n_0\,
      CO(3) => \error_carry__1_i_15_n_0\,
      CO(2) => \error_carry__1_i_15_n_1\,
      CO(1) => \error_carry__1_i_15_n_2\,
      CO(0) => \error_carry__1_i_15_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => abs_q0(12 downto 9),
      S(3) => \error_carry__1_i_20_n_0\,
      S(2) => \error_carry__1_i_21_n_0\,
      S(1) => \error_carry__1_i_22_n_0\,
      S(0) => \error_carry__1_i_23_n_0\
    );
\error_carry__1_i_16\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(12),
      O => p_0_in_1(12)
    );
\error_carry__1_i_17\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(11),
      O => p_0_in_1(11)
    );
\error_carry__1_i_18\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(10),
      O => p_0_in_1(10)
    );
\error_carry__1_i_19\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(9),
      O => p_0_in_1(9)
    );
\error_carry__1_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(10),
      I1 => \error_carry__1_i_5_n_5\,
      O => \error_carry__1_i_2_n_0\
    );
\error_carry__1_i_20\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(28),
      O => \error_carry__1_i_20_n_0\
    );
\error_carry__1_i_21\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(27),
      O => \error_carry__1_i_21_n_0\
    );
\error_carry__1_i_22\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(26),
      O => \error_carry__1_i_22_n_0\
    );
\error_carry__1_i_23\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(25),
      O => \error_carry__1_i_23_n_0\
    );
\error_carry__1_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(9),
      I1 => \error_carry__1_i_5_n_6\,
      O => \error_carry__1_i_3_n_0\
    );
\error_carry__1_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(8),
      I1 => \error_carry__1_i_5_n_7\,
      O => \error_carry__1_i_4_n_0\
    );
\error_carry__1_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \error_carry__0_i_5_n_0\,
      CO(3) => \error_carry__1_i_5_n_0\,
      CO(2) => \error_carry__1_i_5_n_1\,
      CO(1) => \error_carry__1_i_5_n_2\,
      CO(0) => \error_carry__1_i_5_n_3\,
      CYINIT => '0',
      DI(3) => \error_carry__1_i_6_n_0\,
      DI(2) => \error_carry__1_i_7_n_0\,
      DI(1) => \error_carry__1_i_8_n_0\,
      DI(0) => \error_carry__1_i_9_n_0\,
      O(3) => \error_carry__1_i_5_n_4\,
      O(2) => \error_carry__1_i_5_n_5\,
      O(1) => \error_carry__1_i_5_n_6\,
      O(0) => \error_carry__1_i_5_n_7\,
      S(3) => \error_carry__1_i_10_n_0\,
      S(2) => \error_carry__1_i_11_n_0\,
      S(1) => \error_carry__1_i_12_n_0\,
      S(0) => \error_carry__1_i_13_n_0\
    );
\error_carry__1_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(11),
      I1 => adc_data(15),
      I2 => adc_data(11),
      O => \error_carry__1_i_6_n_0\
    );
\error_carry__1_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(10),
      I1 => adc_data(15),
      I2 => adc_data(10),
      O => \error_carry__1_i_7_n_0\
    );
\error_carry__1_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(9),
      I1 => adc_data(15),
      I2 => adc_data(9),
      O => \error_carry__1_i_8_n_0\
    );
\error_carry__1_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(8),
      I1 => adc_data(15),
      I2 => adc_data(8),
      O => \error_carry__1_i_9_n_0\
    );
\error_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \error_carry__1_n_0\,
      CO(3) => \error_carry__2_n_0\,
      CO(2) => \error_carry__2_n_1\,
      CO(1) => \error_carry__2_n_2\,
      CO(0) => \error_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => Q(15 downto 12),
      O(3 downto 0) => error(15 downto 12),
      S(3) => \error_carry__2_i_1_n_0\,
      S(2) => \error_carry__2_i_2_n_0\,
      S(1) => \error_carry__2_i_3_n_0\,
      S(0) => \error_carry__2_i_4_n_0\
    );
\error_carry__2_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(15),
      I1 => \error_carry__2_i_5_n_4\,
      O => \error_carry__2_i_1_n_0\
    );
\error_carry__2_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7888"
    )
        port map (
      I0 => abs_i0(15),
      I1 => adc_data(15),
      I2 => abs_q0(15),
      I3 => adc_data(31),
      O => \error_carry__2_i_10_n_0\
    );
\error_carry__2_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(14),
      I1 => adc_data(15),
      I2 => abs_i0(14),
      I3 => adc_data(30),
      I4 => adc_data(31),
      I5 => abs_q0(14),
      O => \error_carry__2_i_11_n_0\
    );
\error_carry__2_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(13),
      I1 => adc_data(15),
      I2 => abs_i0(13),
      I3 => adc_data(29),
      I4 => adc_data(31),
      I5 => abs_q0(13),
      O => \error_carry__2_i_12_n_0\
    );
\error_carry__2_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(12),
      I1 => adc_data(15),
      I2 => abs_i0(12),
      I3 => adc_data(28),
      I4 => adc_data(31),
      I5 => abs_q0(12),
      O => \error_carry__2_i_13_n_0\
    );
\error_carry__2_i_14\: unisim.vcomponents.CARRY4
     port map (
      CI => \error_carry__1_i_14_n_0\,
      CO(3 downto 2) => \NLW_error_carry__2_i_14_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \error_carry__2_i_14_n_2\,
      CO(0) => \error_carry__2_i_14_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_error_carry__2_i_14_O_UNCONNECTED\(3),
      O(2 downto 0) => abs_i0(15 downto 13),
      S(3) => '0',
      S(2 downto 0) => p_0_in_1(15 downto 13)
    );
\error_carry__2_i_15\: unisim.vcomponents.CARRY4
     port map (
      CI => \error_carry__1_i_15_n_0\,
      CO(3 downto 2) => \NLW_error_carry__2_i_15_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \error_carry__2_i_15_n_2\,
      CO(0) => \error_carry__2_i_15_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_error_carry__2_i_15_O_UNCONNECTED\(3),
      O(2 downto 0) => abs_q0(15 downto 13),
      S(3) => '0',
      S(2) => \error_carry__2_i_19_n_0\,
      S(1) => \error_carry__2_i_20_n_0\,
      S(0) => \error_carry__2_i_21_n_0\
    );
\error_carry__2_i_16\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(15),
      O => p_0_in_1(15)
    );
\error_carry__2_i_17\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(14),
      O => p_0_in_1(14)
    );
\error_carry__2_i_18\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(13),
      O => p_0_in_1(13)
    );
\error_carry__2_i_19\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(31),
      O => \error_carry__2_i_19_n_0\
    );
\error_carry__2_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(14),
      I1 => \error_carry__2_i_5_n_5\,
      O => \error_carry__2_i_2_n_0\
    );
\error_carry__2_i_20\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(30),
      O => \error_carry__2_i_20_n_0\
    );
\error_carry__2_i_21\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(29),
      O => \error_carry__2_i_21_n_0\
    );
\error_carry__2_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(13),
      I1 => \error_carry__2_i_5_n_6\,
      O => \error_carry__2_i_3_n_0\
    );
\error_carry__2_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(12),
      I1 => \error_carry__2_i_5_n_7\,
      O => \error_carry__2_i_4_n_0\
    );
\error_carry__2_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \error_carry__1_i_5_n_0\,
      CO(3) => \error_carry__2_i_5_n_0\,
      CO(2) => \error_carry__2_i_5_n_1\,
      CO(1) => \error_carry__2_i_5_n_2\,
      CO(0) => \error_carry__2_i_5_n_3\,
      CYINIT => '0',
      DI(3) => \error_carry__2_i_6_n_0\,
      DI(2) => \error_carry__2_i_7_n_0\,
      DI(1) => \error_carry__2_i_8_n_0\,
      DI(0) => \error_carry__2_i_9_n_0\,
      O(3) => \error_carry__2_i_5_n_4\,
      O(2) => \error_carry__2_i_5_n_5\,
      O(1) => \error_carry__2_i_5_n_6\,
      O(0) => \error_carry__2_i_5_n_7\,
      S(3) => \error_carry__2_i_10_n_0\,
      S(2) => \error_carry__2_i_11_n_0\,
      S(1) => \error_carry__2_i_12_n_0\,
      S(0) => \error_carry__2_i_13_n_0\
    );
\error_carry__2_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => adc_data(15),
      I1 => abs_i0(15),
      O => \error_carry__2_i_6_n_0\
    );
\error_carry__2_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(14),
      I1 => adc_data(15),
      I2 => adc_data(14),
      O => \error_carry__2_i_7_n_0\
    );
\error_carry__2_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(13),
      I1 => adc_data(15),
      I2 => adc_data(13),
      O => \error_carry__2_i_8_n_0\
    );
\error_carry__2_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(12),
      I1 => adc_data(15),
      I2 => adc_data(12),
      O => \error_carry__2_i_9_n_0\
    );
\error_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \error_carry__2_n_0\,
      CO(3 downto 2) => \NLW_error_carry__3_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \error_carry__3_n_2\,
      CO(0) => \NLW_error_carry__3_CO_UNCONNECTED\(0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_error_carry__3_O_UNCONNECTED\(3 downto 1),
      O(0) => error(16),
      S(3 downto 1) => B"001",
      S(0) => aD2M4dsP(16)
    );
\error_carry__3_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \error_carry__2_i_5_n_0\,
      CO(3 downto 0) => \NLW_error_carry__3_i_1_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_error_carry__3_i_1_O_UNCONNECTED\(3 downto 1),
      O(0) => aD2M4dsP(16),
      S(3 downto 0) => B"0001"
    );
error_carry_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(3),
      I1 => error_carry_i_5_n_4,
      O => error_carry_i_1_n_0
    );
error_carry_i_10: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(2),
      I1 => adc_data(15),
      I2 => abs_i0(2),
      I3 => adc_data(18),
      I4 => adc_data(31),
      I5 => abs_q0(2),
      O => error_carry_i_10_n_0
    );
error_carry_i_11: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(1),
      I1 => adc_data(15),
      I2 => abs_i0(1),
      I3 => adc_data(17),
      I4 => adc_data(31),
      I5 => abs_q0(1),
      O => error_carry_i_11_n_0
    );
error_carry_i_12: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => adc_data(0),
      I1 => adc_data(16),
      O => error_carry_i_12_n_0
    );
error_carry_i_13: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => error_carry_i_13_n_0,
      CO(2) => error_carry_i_13_n_1,
      CO(1) => error_carry_i_13_n_2,
      CO(0) => error_carry_i_13_n_3,
      CYINIT => p_0_in_1(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => abs_i0(4 downto 1),
      S(3 downto 0) => p_0_in_1(4 downto 1)
    );
error_carry_i_14: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => error_carry_i_14_n_0,
      CO(2) => error_carry_i_14_n_1,
      CO(1) => error_carry_i_14_n_2,
      CO(0) => error_carry_i_14_n_3,
      CYINIT => error_carry_i_20_n_0,
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => abs_q0(4 downto 1),
      S(3) => error_carry_i_21_n_0,
      S(2) => error_carry_i_22_n_0,
      S(1) => error_carry_i_23_n_0,
      S(0) => error_carry_i_24_n_0
    );
error_carry_i_15: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(0),
      O => p_0_in_1(0)
    );
error_carry_i_16: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(4),
      O => p_0_in_1(4)
    );
error_carry_i_17: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(3),
      O => p_0_in_1(3)
    );
error_carry_i_18: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(2),
      O => p_0_in_1(2)
    );
error_carry_i_19: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(1),
      O => p_0_in_1(1)
    );
error_carry_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(2),
      I1 => error_carry_i_5_n_5,
      O => error_carry_i_2_n_0
    );
error_carry_i_20: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(16),
      O => error_carry_i_20_n_0
    );
error_carry_i_21: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(20),
      O => error_carry_i_21_n_0
    );
error_carry_i_22: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(19),
      O => error_carry_i_22_n_0
    );
error_carry_i_23: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(18),
      O => error_carry_i_23_n_0
    );
error_carry_i_24: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => adc_data(17),
      O => error_carry_i_24_n_0
    );
error_carry_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(1),
      I1 => error_carry_i_5_n_6,
      O => error_carry_i_3_n_0
    );
error_carry_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => Q(0),
      I1 => error_carry_i_5_n_7,
      O => error_carry_i_4_n_0
    );
error_carry_i_5: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => error_carry_i_5_n_0,
      CO(2) => error_carry_i_5_n_1,
      CO(1) => error_carry_i_5_n_2,
      CO(0) => error_carry_i_5_n_3,
      CYINIT => '0',
      DI(3) => error_carry_i_6_n_0,
      DI(2) => error_carry_i_7_n_0,
      DI(1) => error_carry_i_8_n_0,
      DI(0) => adc_data(0),
      O(3) => error_carry_i_5_n_4,
      O(2) => error_carry_i_5_n_5,
      O(1) => error_carry_i_5_n_6,
      O(0) => error_carry_i_5_n_7,
      S(3) => error_carry_i_9_n_0,
      S(2) => error_carry_i_10_n_0,
      S(1) => error_carry_i_11_n_0,
      S(0) => error_carry_i_12_n_0
    );
error_carry_i_6: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(3),
      I1 => adc_data(15),
      I2 => adc_data(3),
      O => error_carry_i_6_n_0
    );
error_carry_i_7: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(2),
      I1 => adc_data(15),
      I2 => adc_data(2),
      O => error_carry_i_7_n_0
    );
error_carry_i_8: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => abs_i0(1),
      I1 => adc_data(15),
      I2 => adc_data(1),
      O => error_carry_i_8_n_0
    );
error_carry_i_9: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1D1D1DE2E2E21DE2"
    )
        port map (
      I0 => adc_data(3),
      I1 => adc_data(15),
      I2 => abs_i0(3),
      I3 => adc_data(19),
      I4 => adc_data(31),
      I5 => abs_q0(3),
      O => error_carry_i_9_n_0
    );
\gain_acc[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => adc_valid,
      I1 => core_enable,
      I2 => core_bypass_agc,
      O => gain_acc0
    );
\gain_acc[0]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AA15AAEA"
    )
        port map (
      I0 => \gain_acc[0]_i_17_n_0\,
      I1 => \gain_acc[0]_i_14_n_0\,
      I2 => \gain_acc_reg[19]_0\(0),
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \gain_acc_reg_n_0_[0]\,
      O => \gain_acc[0]_i_10_n_0\
    );
\gain_acc[0]_i_11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \gain_acc[0]_i_18_n_0\,
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => \gain_acc[0]_i_19_n_0\,
      O => \gain_acc[0]_i_11_n_0\
    );
\gain_acc[0]_i_12\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \gain_acc[0]_i_20_n_0\,
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => \gain_acc[0]_i_21_n_0\,
      O => \gain_acc[0]_i_12_n_0\
    );
\gain_acc[0]_i_13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \gain_acc[0]_i_21_n_0\,
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => \gain_acc[0]_i_15_n_0\,
      O => \gain_acc[0]_i_13_n_0\
    );
\gain_acc[0]_i_14\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \gain_acc[0]_i_19_n_0\,
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => \gain_acc[0]_i_22_n_0\,
      O => \gain_acc[0]_i_14_n_0\
    );
\gain_acc[0]_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => error(14),
      I1 => error(6),
      I2 => \gain_acc_reg[19]_0\(2),
      I3 => error(10),
      I4 => \gain_acc_reg[19]_0\(3),
      I5 => error(2),
      O => \gain_acc[0]_i_15_n_0\
    );
\gain_acc[0]_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => error(12),
      I1 => error(4),
      I2 => \gain_acc_reg[19]_0\(2),
      I3 => error(8),
      I4 => \gain_acc_reg[19]_0\(3),
      I5 => error(0),
      O => \gain_acc[0]_i_16_n_0\
    );
\gain_acc[0]_i_17\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"11100100"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(0),
      I1 => \gain_acc_reg_n_0_[31]\,
      I2 => \gain_acc_reg[19]_0\(1),
      I3 => \gain_acc[0]_i_16_n_0\,
      I4 => \gain_acc[0]_i_15_n_0\,
      O => \gain_acc[0]_i_17_n_0\
    );
\gain_acc[0]_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3F30AFAF3F30A0A0"
    )
        port map (
      I0 => error(9),
      I1 => \error_carry__3_n_2\,
      I2 => \gain_acc_reg[19]_0\(2),
      I3 => error(13),
      I4 => \gain_acc_reg[19]_0\(3),
      I5 => error(5),
      O => \gain_acc[0]_i_18_n_0\
    );
\gain_acc[0]_i_19\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => error(15),
      I1 => error(7),
      I2 => \gain_acc_reg[19]_0\(2),
      I3 => error(11),
      I4 => \gain_acc_reg[19]_0\(3),
      I5 => error(3),
      O => \gain_acc[0]_i_19_n_0\
    );
\gain_acc[0]_i_20\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => error(10),
      I1 => \gain_acc_reg[19]_0\(2),
      I2 => error(14),
      I3 => \gain_acc_reg[19]_0\(3),
      I4 => error(6),
      O => \gain_acc[0]_i_20_n_0\
    );
\gain_acc[0]_i_21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => error(16),
      I1 => error(8),
      I2 => \gain_acc_reg[19]_0\(2),
      I3 => error(12),
      I4 => \gain_acc_reg[19]_0\(3),
      I5 => error(4),
      O => \gain_acc[0]_i_21_n_0\
    );
\gain_acc[0]_i_22\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => error(13),
      I1 => error(5),
      I2 => \gain_acc_reg[19]_0\(2),
      I3 => error(9),
      I4 => \gain_acc_reg[19]_0\(3),
      I5 => error(1),
      O => \gain_acc[0]_i_22_n_0\
    );
\gain_acc[0]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0E02"
    )
        port map (
      I0 => \gain_acc[0]_i_11_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc_reg_n_0_[31]\,
      I3 => \gain_acc[0]_i_12_n_0\,
      O => \gain_acc[0]_i_3_n_0\
    );
\gain_acc[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0E02"
    )
        port map (
      I0 => \gain_acc[0]_i_13_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc_reg_n_0_[31]\,
      I3 => \gain_acc[0]_i_11_n_0\,
      O => \gain_acc[0]_i_4_n_0\
    );
\gain_acc[0]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0E02"
    )
        port map (
      I0 => \gain_acc[0]_i_14_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc_reg_n_0_[31]\,
      I3 => \gain_acc[0]_i_13_n_0\,
      O => \gain_acc[0]_i_5_n_0\
    );
\gain_acc[0]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AAAA0000CCF0"
    )
        port map (
      I0 => \gain_acc[0]_i_14_n_0\,
      I1 => \gain_acc[0]_i_15_n_0\,
      I2 => \gain_acc[0]_i_16_n_0\,
      I3 => \gain_acc_reg[19]_0\(1),
      I4 => \gain_acc_reg_n_0_[31]\,
      I5 => \gain_acc_reg[19]_0\(0),
      O => \gain_acc[0]_i_6_n_0\
    );
\gain_acc[0]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"004700B8"
    )
        port map (
      I0 => \gain_acc[0]_i_12_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc[0]_i_11_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \gain_acc_reg_n_0_[3]\,
      O => \gain_acc[0]_i_7_n_0\
    );
\gain_acc[0]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"004700B8"
    )
        port map (
      I0 => \gain_acc[0]_i_11_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc[0]_i_13_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \gain_acc_reg_n_0_[2]\,
      O => \gain_acc[0]_i_8_n_0\
    );
\gain_acc[0]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"004700B8"
    )
        port map (
      I0 => \gain_acc[0]_i_13_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc[0]_i_14_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \gain_acc_reg_n_0_[1]\,
      O => \gain_acc[0]_i_9_n_0\
    );
\gain_acc[12]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFF8FB"
    )
        port map (
      I0 => \error_carry__3_n_2\,
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => \gain_acc_reg[19]_0\(2),
      I3 => error(15),
      I4 => \gain_acc_reg[19]_0\(3),
      O => \gain_acc[12]_i_10_n_0\
    );
\gain_acc[12]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(1),
      I1 => \gain_acc_reg[19]_0\(3),
      I2 => error(16),
      I3 => \gain_acc_reg[19]_0\(2),
      O => \gain_acc[12]_i_11_n_0\
    );
\gain_acc[12]_i_12\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFF4F7"
    )
        port map (
      I0 => error(16),
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => \gain_acc_reg[19]_0\(2),
      I3 => error(14),
      I4 => \gain_acc_reg[19]_0\(3),
      O => \gain_acc[12]_i_12_n_0\
    );
\gain_acc[12]_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFC44FFFFFC77"
    )
        port map (
      I0 => error(15),
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => \error_carry__3_n_2\,
      I3 => \gain_acc_reg[19]_0\(2),
      I4 => \gain_acc_reg[19]_0\(3),
      I5 => error(13),
      O => \gain_acc[12]_i_13_n_0\
    );
\gain_acc[12]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0035"
    )
        port map (
      I0 => \gain_acc[12]_i_10_n_0\,
      I1 => \gain_acc[12]_i_11_n_0\,
      I2 => \gain_acc_reg[19]_0\(0),
      I3 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[12]_i_2_n_0\
    );
\gain_acc[12]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0035"
    )
        port map (
      I0 => \gain_acc[12]_i_12_n_0\,
      I1 => \gain_acc[12]_i_10_n_0\,
      I2 => \gain_acc_reg[19]_0\(0),
      I3 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[12]_i_3_n_0\
    );
\gain_acc[12]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0035"
    )
        port map (
      I0 => \gain_acc[12]_i_13_n_0\,
      I1 => \gain_acc[12]_i_12_n_0\,
      I2 => \gain_acc_reg[19]_0\(0),
      I3 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[12]_i_4_n_0\
    );
\gain_acc[12]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0035"
    )
        port map (
      I0 => \gain_acc[8]_i_12_n_0\,
      I1 => \gain_acc[12]_i_13_n_0\,
      I2 => \gain_acc_reg[19]_0\(0),
      I3 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[12]_i_5_n_0\
    );
\gain_acc[12]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00D80027"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(0),
      I1 => \gain_acc[12]_i_11_n_0\,
      I2 => \gain_acc[12]_i_10_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \^a\(3),
      O => \gain_acc[12]_i_6_n_0\
    );
\gain_acc[12]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00D80027"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(0),
      I1 => \gain_acc[12]_i_10_n_0\,
      I2 => \gain_acc[12]_i_12_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \^a\(2),
      O => \gain_acc[12]_i_7_n_0\
    );
\gain_acc[12]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00D80027"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(0),
      I1 => \gain_acc[12]_i_12_n_0\,
      I2 => \gain_acc[12]_i_13_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \^a\(1),
      O => \gain_acc[12]_i_8_n_0\
    );
\gain_acc[12]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00D80027"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(0),
      I1 => \gain_acc[12]_i_13_n_0\,
      I2 => \gain_acc[8]_i_12_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \^a\(0),
      O => \gain_acc[12]_i_9_n_0\
    );
\gain_acc[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(0),
      I1 => \gain_acc_reg_n_0_[31]\,
      I2 => \gain_acc_reg[19]_0\(2),
      I3 => \gain_acc_reg[19]_0\(3),
      I4 => \error_carry__3_n_2\,
      I5 => \gain_acc_reg[19]_0\(1),
      O => \gain_acc[16]_i_2_n_0\
    );
\gain_acc[16]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0035"
    )
        port map (
      I0 => \gain_acc[12]_i_11_n_0\,
      I1 => \gain_acc[16]_i_8_n_0\,
      I2 => \gain_acc_reg[19]_0\(0),
      I3 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[16]_i_3_n_0\
    );
\gain_acc[16]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^a\(7),
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[16]_i_4_n_0\
    );
\gain_acc[16]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^a\(6),
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[16]_i_5_n_0\
    );
\gain_acc[16]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9A"
    )
        port map (
      I0 => \gain_acc[16]_i_2_n_0\,
      I1 => \gain_acc_reg_n_0_[31]\,
      I2 => \^a\(5),
      O => \gain_acc[16]_i_6_n_0\
    );
\gain_acc[16]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00D80027"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(0),
      I1 => \gain_acc[16]_i_8_n_0\,
      I2 => \gain_acc[12]_i_11_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \^a\(4),
      O => \gain_acc[16]_i_7_n_0\
    );
\gain_acc[16]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(1),
      I1 => \error_carry__3_n_2\,
      I2 => \gain_acc_reg[19]_0\(3),
      I3 => \gain_acc_reg[19]_0\(2),
      O => \gain_acc[16]_i_8_n_0\
    );
\gain_acc[20]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^a\(11),
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[20]_i_2_n_0\
    );
\gain_acc[20]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^a\(10),
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[20]_i_3_n_0\
    );
\gain_acc[20]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^a\(9),
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[20]_i_4_n_0\
    );
\gain_acc[20]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^a\(8),
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[20]_i_5_n_0\
    );
\gain_acc[24]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^a\(15),
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[24]_i_2_n_0\
    );
\gain_acc[24]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^a\(14),
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[24]_i_3_n_0\
    );
\gain_acc[24]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^a\(13),
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[24]_i_4_n_0\
    );
\gain_acc[24]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^a\(12),
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[24]_i_5_n_0\
    );
\gain_acc[28]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \gain_acc_reg_n_0_[30]\,
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[28]_i_2_n_0\
    );
\gain_acc[28]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \gain_acc_reg_n_0_[29]\,
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[28]_i_3_n_0\
    );
\gain_acc[28]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \gain_acc_reg_n_0_[28]\,
      I1 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[28]_i_4_n_0\
    );
\gain_acc[4]_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"74"
    )
        port map (
      I0 => \gain_acc[4]_i_14_n_0\,
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => \gain_acc[4]_i_15_n_0\,
      O => \gain_acc[4]_i_10_n_0\
    );
\gain_acc[4]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00B8FFFF00B80000"
    )
        port map (
      I0 => error(14),
      I1 => \gain_acc_reg[19]_0\(2),
      I2 => error(10),
      I3 => \gain_acc_reg[19]_0\(3),
      I4 => \gain_acc_reg[19]_0\(1),
      I5 => \gain_acc[4]_i_16_n_0\,
      O => \gain_acc[4]_i_11_n_0\
    );
\gain_acc[4]_i_12\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \gain_acc[4]_i_16_n_0\,
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => \gain_acc[0]_i_20_n_0\,
      O => \gain_acc[4]_i_12_n_0\
    );
\gain_acc[4]_i_13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \gain_acc[4]_i_15_n_0\,
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => \gain_acc[0]_i_18_n_0\,
      O => \gain_acc[4]_i_13_n_0\
    );
\gain_acc[4]_i_14\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFCC4747"
    )
        port map (
      I0 => error(13),
      I1 => \gain_acc_reg[19]_0\(2),
      I2 => error(9),
      I3 => \error_carry__3_n_2\,
      I4 => \gain_acc_reg[19]_0\(3),
      O => \gain_acc[4]_i_14_n_0\
    );
\gain_acc[4]_i_15\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => error(11),
      I1 => \gain_acc_reg[19]_0\(2),
      I2 => error(15),
      I3 => \gain_acc_reg[19]_0\(3),
      I4 => error(7),
      O => \gain_acc[4]_i_15_n_0\
    );
\gain_acc[4]_i_16\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => error(12),
      I1 => \gain_acc_reg[19]_0\(2),
      I2 => error(16),
      I3 => \gain_acc_reg[19]_0\(3),
      I4 => error(8),
      O => \gain_acc[4]_i_16_n_0\
    );
\gain_acc[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0E02"
    )
        port map (
      I0 => \gain_acc[4]_i_10_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc_reg_n_0_[31]\,
      I3 => \gain_acc[4]_i_11_n_0\,
      O => \gain_acc[4]_i_2_n_0\
    );
\gain_acc[4]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0E02"
    )
        port map (
      I0 => \gain_acc[4]_i_12_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc_reg_n_0_[31]\,
      I3 => \gain_acc[4]_i_10_n_0\,
      O => \gain_acc[4]_i_3_n_0\
    );
\gain_acc[4]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0E02"
    )
        port map (
      I0 => \gain_acc[4]_i_13_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc_reg_n_0_[31]\,
      I3 => \gain_acc[4]_i_12_n_0\,
      O => \gain_acc[4]_i_4_n_0\
    );
\gain_acc[4]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0E02"
    )
        port map (
      I0 => \gain_acc[0]_i_12_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc_reg_n_0_[31]\,
      I3 => \gain_acc[4]_i_13_n_0\,
      O => \gain_acc[4]_i_5_n_0\
    );
\gain_acc[4]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"004700B8"
    )
        port map (
      I0 => \gain_acc[4]_i_11_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc[4]_i_10_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \gain_acc_reg_n_0_[7]\,
      O => \gain_acc[4]_i_6_n_0\
    );
\gain_acc[4]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"004700B8"
    )
        port map (
      I0 => \gain_acc[4]_i_10_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc[4]_i_12_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \gain_acc_reg_n_0_[6]\,
      O => \gain_acc[4]_i_7_n_0\
    );
\gain_acc[4]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"004700B8"
    )
        port map (
      I0 => \gain_acc[4]_i_12_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc[4]_i_13_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \gain_acc_reg_n_0_[5]\,
      O => \gain_acc[4]_i_8_n_0\
    );
\gain_acc[4]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"004700B8"
    )
        port map (
      I0 => \gain_acc[4]_i_13_n_0\,
      I1 => \gain_acc_reg[19]_0\(0),
      I2 => \gain_acc[0]_i_12_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \gain_acc_reg_n_0_[4]\,
      O => \gain_acc[4]_i_9_n_0\
    );
\gain_acc[8]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F8FB"
    )
        port map (
      I0 => \error_carry__3_n_2\,
      I1 => \gain_acc_reg[19]_0\(2),
      I2 => \gain_acc_reg[19]_0\(3),
      I3 => error(13),
      O => \gain_acc[8]_i_10_n_0\
    );
\gain_acc[8]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF47"
    )
        port map (
      I0 => error(15),
      I1 => \gain_acc_reg[19]_0\(2),
      I2 => error(11),
      I3 => \gain_acc_reg[19]_0\(3),
      O => \gain_acc[8]_i_11_n_0\
    );
\gain_acc[8]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFCF44CF77"
    )
        port map (
      I0 => error(14),
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => error(16),
      I3 => \gain_acc_reg[19]_0\(2),
      I4 => error(12),
      I5 => \gain_acc_reg[19]_0\(3),
      O => \gain_acc[8]_i_12_n_0\
    );
\gain_acc[8]_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF47FFFFFF470000"
    )
        port map (
      I0 => error(16),
      I1 => \gain_acc_reg[19]_0\(2),
      I2 => error(12),
      I3 => \gain_acc_reg[19]_0\(3),
      I4 => \gain_acc_reg[19]_0\(1),
      I5 => \gain_acc[8]_i_16_n_0\,
      O => \gain_acc[8]_i_13_n_0\
    );
\gain_acc[8]_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F8FBFFFFF8FB0000"
    )
        port map (
      I0 => \error_carry__3_n_2\,
      I1 => \gain_acc_reg[19]_0\(2),
      I2 => \gain_acc_reg[19]_0\(3),
      I3 => error(13),
      I4 => \gain_acc_reg[19]_0\(1),
      I5 => \gain_acc[8]_i_11_n_0\,
      O => \gain_acc[8]_i_14_n_0\
    );
\gain_acc[8]_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF47FFFFFF470000"
    )
        port map (
      I0 => error(15),
      I1 => \gain_acc_reg[19]_0\(2),
      I2 => error(11),
      I3 => \gain_acc_reg[19]_0\(3),
      I4 => \gain_acc_reg[19]_0\(1),
      I5 => \gain_acc[4]_i_14_n_0\,
      O => \gain_acc[8]_i_15_n_0\
    );
\gain_acc[8]_i_16\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF47"
    )
        port map (
      I0 => error(14),
      I1 => \gain_acc_reg[19]_0\(2),
      I2 => error(10),
      I3 => \gain_acc_reg[19]_0\(3),
      O => \gain_acc[8]_i_16_n_0\
    );
\gain_acc[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000FF4747"
    )
        port map (
      I0 => \gain_acc[8]_i_10_n_0\,
      I1 => \gain_acc_reg[19]_0\(1),
      I2 => \gain_acc[8]_i_11_n_0\,
      I3 => \gain_acc[8]_i_12_n_0\,
      I4 => \gain_acc_reg[19]_0\(0),
      I5 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[8]_i_2_n_0\
    );
\gain_acc[8]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0035"
    )
        port map (
      I0 => \gain_acc[8]_i_13_n_0\,
      I1 => \gain_acc[8]_i_14_n_0\,
      I2 => \gain_acc_reg[19]_0\(0),
      I3 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[8]_i_3_n_0\
    );
\gain_acc[8]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0035"
    )
        port map (
      I0 => \gain_acc[8]_i_15_n_0\,
      I1 => \gain_acc[8]_i_13_n_0\,
      I2 => \gain_acc_reg[19]_0\(0),
      I3 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[8]_i_4_n_0\
    );
\gain_acc[8]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"003A"
    )
        port map (
      I0 => \gain_acc[4]_i_11_n_0\,
      I1 => \gain_acc[8]_i_15_n_0\,
      I2 => \gain_acc_reg[19]_0\(0),
      I3 => \gain_acc_reg_n_0_[31]\,
      O => \gain_acc[8]_i_5_n_0\
    );
\gain_acc[8]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9A"
    )
        port map (
      I0 => \gain_acc[8]_i_2_n_0\,
      I1 => \gain_acc_reg_n_0_[31]\,
      I2 => \gain_acc_reg_n_0_[11]\,
      O => \gain_acc[8]_i_6_n_0\
    );
\gain_acc[8]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00D80027"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(0),
      I1 => \gain_acc[8]_i_14_n_0\,
      I2 => \gain_acc[8]_i_13_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \gain_acc_reg_n_0_[10]\,
      O => \gain_acc[8]_i_7_n_0\
    );
\gain_acc[8]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00D80027"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(0),
      I1 => \gain_acc[8]_i_13_n_0\,
      I2 => \gain_acc[8]_i_15_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \gain_acc_reg_n_0_[9]\,
      O => \gain_acc[8]_i_8_n_0\
    );
\gain_acc[8]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"008D0072"
    )
        port map (
      I0 => \gain_acc_reg[19]_0\(0),
      I1 => \gain_acc[8]_i_15_n_0\,
      I2 => \gain_acc[4]_i_11_n_0\,
      I3 => \gain_acc_reg_n_0_[31]\,
      I4 => \gain_acc_reg_n_0_[8]\,
      O => \gain_acc[8]_i_9_n_0\
    );
\gain_acc_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[0]_i_2_n_7\,
      Q => \gain_acc_reg_n_0_[0]\
    );
\gain_acc_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \gain_acc_reg[0]_i_2_n_0\,
      CO(2) => \gain_acc_reg[0]_i_2_n_1\,
      CO(1) => \gain_acc_reg[0]_i_2_n_2\,
      CO(0) => \gain_acc_reg[0]_i_2_n_3\,
      CYINIT => '0',
      DI(3) => \gain_acc[0]_i_3_n_0\,
      DI(2) => \gain_acc[0]_i_4_n_0\,
      DI(1) => \gain_acc[0]_i_5_n_0\,
      DI(0) => \gain_acc[0]_i_6_n_0\,
      O(3) => \gain_acc_reg[0]_i_2_n_4\,
      O(2) => \gain_acc_reg[0]_i_2_n_5\,
      O(1) => \gain_acc_reg[0]_i_2_n_6\,
      O(0) => \gain_acc_reg[0]_i_2_n_7\,
      S(3) => \gain_acc[0]_i_7_n_0\,
      S(2) => \gain_acc[0]_i_8_n_0\,
      S(1) => \gain_acc[0]_i_9_n_0\,
      S(0) => \gain_acc[0]_i_10_n_0\
    );
\gain_acc_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[8]_i_1_n_5\,
      Q => \gain_acc_reg_n_0_[10]\
    );
\gain_acc_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[8]_i_1_n_4\,
      Q => \gain_acc_reg_n_0_[11]\
    );
\gain_acc_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[12]_i_1_n_7\,
      Q => \^a\(0)
    );
\gain_acc_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gain_acc_reg[8]_i_1_n_0\,
      CO(3) => \gain_acc_reg[12]_i_1_n_0\,
      CO(2) => \gain_acc_reg[12]_i_1_n_1\,
      CO(1) => \gain_acc_reg[12]_i_1_n_2\,
      CO(0) => \gain_acc_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \gain_acc[12]_i_2_n_0\,
      DI(2) => \gain_acc[12]_i_3_n_0\,
      DI(1) => \gain_acc[12]_i_4_n_0\,
      DI(0) => \gain_acc[12]_i_5_n_0\,
      O(3) => \gain_acc_reg[12]_i_1_n_4\,
      O(2) => \gain_acc_reg[12]_i_1_n_5\,
      O(1) => \gain_acc_reg[12]_i_1_n_6\,
      O(0) => \gain_acc_reg[12]_i_1_n_7\,
      S(3) => \gain_acc[12]_i_6_n_0\,
      S(2) => \gain_acc[12]_i_7_n_0\,
      S(1) => \gain_acc[12]_i_8_n_0\,
      S(0) => \gain_acc[12]_i_9_n_0\
    );
\gain_acc_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[12]_i_1_n_6\,
      Q => \^a\(1)
    );
\gain_acc_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[12]_i_1_n_5\,
      Q => \^a\(2)
    );
\gain_acc_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[12]_i_1_n_4\,
      Q => \^a\(3)
    );
\gain_acc_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[16]_i_1_n_7\,
      Q => \^a\(4)
    );
\gain_acc_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gain_acc_reg[12]_i_1_n_0\,
      CO(3) => \gain_acc_reg[16]_i_1_n_0\,
      CO(2) => \gain_acc_reg[16]_i_1_n_1\,
      CO(1) => \gain_acc_reg[16]_i_1_n_2\,
      CO(0) => \gain_acc_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => \gain_acc[16]_i_2_n_0\,
      DI(0) => \gain_acc[16]_i_3_n_0\,
      O(3) => \gain_acc_reg[16]_i_1_n_4\,
      O(2) => \gain_acc_reg[16]_i_1_n_5\,
      O(1) => \gain_acc_reg[16]_i_1_n_6\,
      O(0) => \gain_acc_reg[16]_i_1_n_7\,
      S(3) => \gain_acc[16]_i_4_n_0\,
      S(2) => \gain_acc[16]_i_5_n_0\,
      S(1) => \gain_acc[16]_i_6_n_0\,
      S(0) => \gain_acc[16]_i_7_n_0\
    );
\gain_acc_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[16]_i_1_n_6\,
      Q => \^a\(5)
    );
\gain_acc_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[16]_i_1_n_5\,
      Q => \^a\(6)
    );
\gain_acc_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[16]_i_1_n_4\,
      Q => \^a\(7)
    );
\gain_acc_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[0]_i_2_n_6\,
      Q => \gain_acc_reg_n_0_[1]\
    );
\gain_acc_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[20]_i_1_n_7\,
      Q => \^a\(8)
    );
\gain_acc_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gain_acc_reg[16]_i_1_n_0\,
      CO(3) => \gain_acc_reg[20]_i_1_n_0\,
      CO(2) => \gain_acc_reg[20]_i_1_n_1\,
      CO(1) => \gain_acc_reg[20]_i_1_n_2\,
      CO(0) => \gain_acc_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \gain_acc_reg[20]_i_1_n_4\,
      O(2) => \gain_acc_reg[20]_i_1_n_5\,
      O(1) => \gain_acc_reg[20]_i_1_n_6\,
      O(0) => \gain_acc_reg[20]_i_1_n_7\,
      S(3) => \gain_acc[20]_i_2_n_0\,
      S(2) => \gain_acc[20]_i_3_n_0\,
      S(1) => \gain_acc[20]_i_4_n_0\,
      S(0) => \gain_acc[20]_i_5_n_0\
    );
\gain_acc_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[20]_i_1_n_6\,
      Q => \^a\(9)
    );
\gain_acc_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[20]_i_1_n_5\,
      Q => \^a\(10)
    );
\gain_acc_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[20]_i_1_n_4\,
      Q => \^a\(11)
    );
\gain_acc_reg[24]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => gain_acc0,
      D => \gain_acc_reg[24]_i_1_n_7\,
      PRE => \^aresetn_0\,
      Q => \^a\(12)
    );
\gain_acc_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gain_acc_reg[20]_i_1_n_0\,
      CO(3) => \gain_acc_reg[24]_i_1_n_0\,
      CO(2) => \gain_acc_reg[24]_i_1_n_1\,
      CO(1) => \gain_acc_reg[24]_i_1_n_2\,
      CO(0) => \gain_acc_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \gain_acc_reg[24]_i_1_n_4\,
      O(2) => \gain_acc_reg[24]_i_1_n_5\,
      O(1) => \gain_acc_reg[24]_i_1_n_6\,
      O(0) => \gain_acc_reg[24]_i_1_n_7\,
      S(3) => \gain_acc[24]_i_2_n_0\,
      S(2) => \gain_acc[24]_i_3_n_0\,
      S(1) => \gain_acc[24]_i_4_n_0\,
      S(0) => \gain_acc[24]_i_5_n_0\
    );
\gain_acc_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[24]_i_1_n_6\,
      Q => \^a\(13)
    );
\gain_acc_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[24]_i_1_n_5\,
      Q => \^a\(14)
    );
\gain_acc_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[24]_i_1_n_4\,
      Q => \^a\(15)
    );
\gain_acc_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[28]_i_1_n_7\,
      Q => \gain_acc_reg_n_0_[28]\
    );
\gain_acc_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gain_acc_reg[24]_i_1_n_0\,
      CO(3) => \gain_acc_reg[28]_i_1_n_0\,
      CO(2) => \NLW_gain_acc_reg[28]_i_1_CO_UNCONNECTED\(2),
      CO(1) => \gain_acc_reg[28]_i_1_n_2\,
      CO(0) => \gain_acc_reg[28]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_gain_acc_reg[28]_i_1_O_UNCONNECTED\(3),
      O(2) => \gain_acc_reg[28]_i_1_n_5\,
      O(1) => \gain_acc_reg[28]_i_1_n_6\,
      O(0) => \gain_acc_reg[28]_i_1_n_7\,
      S(3) => '1',
      S(2) => \gain_acc[28]_i_2_n_0\,
      S(1) => \gain_acc[28]_i_3_n_0\,
      S(0) => \gain_acc[28]_i_4_n_0\
    );
\gain_acc_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[28]_i_1_n_6\,
      Q => \gain_acc_reg_n_0_[29]\
    );
\gain_acc_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[0]_i_2_n_5\,
      Q => \gain_acc_reg_n_0_[2]\
    );
\gain_acc_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[28]_i_1_n_5\,
      Q => \gain_acc_reg_n_0_[30]\
    );
\gain_acc_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[28]_i_1_n_0\,
      Q => \gain_acc_reg_n_0_[31]\
    );
\gain_acc_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[0]_i_2_n_4\,
      Q => \gain_acc_reg_n_0_[3]\
    );
\gain_acc_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[4]_i_1_n_7\,
      Q => \gain_acc_reg_n_0_[4]\
    );
\gain_acc_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gain_acc_reg[0]_i_2_n_0\,
      CO(3) => \gain_acc_reg[4]_i_1_n_0\,
      CO(2) => \gain_acc_reg[4]_i_1_n_1\,
      CO(1) => \gain_acc_reg[4]_i_1_n_2\,
      CO(0) => \gain_acc_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \gain_acc[4]_i_2_n_0\,
      DI(2) => \gain_acc[4]_i_3_n_0\,
      DI(1) => \gain_acc[4]_i_4_n_0\,
      DI(0) => \gain_acc[4]_i_5_n_0\,
      O(3) => \gain_acc_reg[4]_i_1_n_4\,
      O(2) => \gain_acc_reg[4]_i_1_n_5\,
      O(1) => \gain_acc_reg[4]_i_1_n_6\,
      O(0) => \gain_acc_reg[4]_i_1_n_7\,
      S(3) => \gain_acc[4]_i_6_n_0\,
      S(2) => \gain_acc[4]_i_7_n_0\,
      S(1) => \gain_acc[4]_i_8_n_0\,
      S(0) => \gain_acc[4]_i_9_n_0\
    );
\gain_acc_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[4]_i_1_n_6\,
      Q => \gain_acc_reg_n_0_[5]\
    );
\gain_acc_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[4]_i_1_n_5\,
      Q => \gain_acc_reg_n_0_[6]\
    );
\gain_acc_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[4]_i_1_n_4\,
      Q => \gain_acc_reg_n_0_[7]\
    );
\gain_acc_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[8]_i_1_n_7\,
      Q => \gain_acc_reg_n_0_[8]\
    );
\gain_acc_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gain_acc_reg[4]_i_1_n_0\,
      CO(3) => \gain_acc_reg[8]_i_1_n_0\,
      CO(2) => \gain_acc_reg[8]_i_1_n_1\,
      CO(1) => \gain_acc_reg[8]_i_1_n_2\,
      CO(0) => \gain_acc_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \gain_acc[8]_i_2_n_0\,
      DI(2) => \gain_acc[8]_i_3_n_0\,
      DI(1) => \gain_acc[8]_i_4_n_0\,
      DI(0) => \gain_acc[8]_i_5_n_0\,
      O(3) => \gain_acc_reg[8]_i_1_n_4\,
      O(2) => \gain_acc_reg[8]_i_1_n_5\,
      O(1) => \gain_acc_reg[8]_i_1_n_6\,
      O(0) => \gain_acc_reg[8]_i_1_n_7\,
      S(3) => \gain_acc[8]_i_6_n_0\,
      S(2) => \gain_acc[8]_i_7_n_0\,
      S(1) => \gain_acc[8]_i_8_n_0\,
      S(0) => \gain_acc[8]_i_9_n_0\
    );
\gain_acc_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => gain_acc0,
      CLR => \^aresetn_0\,
      D => \gain_acc_reg[8]_i_1_n_6\,
      Q => \gain_acc_reg_n_0_[9]\
    );
\i_mix[11]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(11),
      I1 => \i_mix_reg[15]_1\(11),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(11),
      O => \i_mix[11]_i_6_n_0\
    );
\i_mix[11]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(10),
      I1 => \i_mix_reg[15]_1\(10),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(10),
      O => \i_mix[11]_i_7_n_0\
    );
\i_mix[11]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(9),
      I1 => \i_mix_reg[15]_1\(9),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(9),
      O => \i_mix[11]_i_8_n_0\
    );
\i_mix[11]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(8),
      I1 => \i_mix_reg[15]_1\(8),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(8),
      O => \i_mix[11]_i_9_n_0\
    );
\i_mix[15]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(15),
      I1 => \i_mix_reg[15]_1\(15),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(15),
      O => \i_mix[15]_i_5_n_0\
    );
\i_mix[15]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(14),
      I1 => \i_mix_reg[15]_1\(14),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(14),
      O => \i_mix[15]_i_6_n_0\
    );
\i_mix[15]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(13),
      I1 => \i_mix_reg[15]_1\(13),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(13),
      O => \i_mix[15]_i_7_n_0\
    );
\i_mix[15]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(12),
      I1 => \i_mix_reg[15]_1\(12),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(12),
      O => \i_mix[15]_i_8_n_0\
    );
\i_mix[3]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(3),
      I1 => \i_mix_reg[15]_1\(3),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(3),
      O => \i_mix[3]_i_6_n_0\
    );
\i_mix[3]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(2),
      I1 => \i_mix_reg[15]_1\(2),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(2),
      O => \i_mix[3]_i_7_n_0\
    );
\i_mix[3]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(1),
      I1 => \i_mix_reg[15]_1\(1),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(1),
      O => \i_mix[3]_i_8_n_0\
    );
\i_mix[3]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(0),
      I1 => \i_mix_reg[15]_1\(0),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(0),
      O => \i_mix[3]_i_9_n_0\
    );
\i_mix[7]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(7),
      I1 => \i_mix_reg[15]_1\(7),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(7),
      O => \i_mix[7]_i_6_n_0\
    );
\i_mix[7]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(6),
      I1 => \i_mix_reg[15]_1\(6),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(6),
      O => \i_mix[7]_i_7_n_0\
    );
\i_mix[7]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(5),
      I1 => \i_mix_reg[15]_1\(5),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(5),
      O => \i_mix[7]_i_8_n_0\
    );
\i_mix[7]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => \i_mix_reg[15]_0\(4),
      I1 => \i_mix_reg[15]_1\(4),
      I2 => core_bypass_costas,
      I3 => \^i_out_reg[15]_0\(4),
      O => \i_mix[7]_i_9_n_0\
    );
\i_mix_reg[11]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \i_mix_reg[7]_i_1_n_0\,
      CO(3) => \i_mix_reg[11]_i_1_n_0\,
      CO(2) => \i_mix_reg[11]_i_1_n_1\,
      CO(1) => \i_mix_reg[11]_i_1_n_2\,
      CO(0) => \i_mix_reg[11]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \i_mix_reg[11]\(3 downto 0),
      O(3 downto 0) => \out\(11 downto 8),
      S(3) => \i_mix[11]_i_6_n_0\,
      S(2) => \i_mix[11]_i_7_n_0\,
      S(1) => \i_mix[11]_i_8_n_0\,
      S(0) => \i_mix[11]_i_9_n_0\
    );
\i_mix_reg[15]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \i_mix_reg[11]_i_1_n_0\,
      CO(3) => \NLW_i_mix_reg[15]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \i_mix_reg[15]_i_1_n_1\,
      CO(1) => \i_mix_reg[15]_i_1_n_2\,
      CO(0) => \i_mix_reg[15]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => \i_mix_reg[15]\(2 downto 0),
      O(3 downto 0) => \out\(15 downto 12),
      S(3) => \i_mix[15]_i_5_n_0\,
      S(2) => \i_mix[15]_i_6_n_0\,
      S(1) => \i_mix[15]_i_7_n_0\,
      S(0) => \i_mix[15]_i_8_n_0\
    );
\i_mix_reg[3]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \i_mix_reg[3]_i_1_n_0\,
      CO(2) => \i_mix_reg[3]_i_1_n_1\,
      CO(1) => \i_mix_reg[3]_i_1_n_2\,
      CO(0) => \i_mix_reg[3]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \i_mix_reg[3]\(3 downto 0),
      O(3 downto 0) => \out\(3 downto 0),
      S(3) => \i_mix[3]_i_6_n_0\,
      S(2) => \i_mix[3]_i_7_n_0\,
      S(1) => \i_mix[3]_i_8_n_0\,
      S(0) => \i_mix[3]_i_9_n_0\
    );
\i_mix_reg[7]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \i_mix_reg[3]_i_1_n_0\,
      CO(3) => \i_mix_reg[7]_i_1_n_0\,
      CO(2) => \i_mix_reg[7]_i_1_n_1\,
      CO(1) => \i_mix_reg[7]_i_1_n_2\,
      CO(0) => \i_mix_reg[7]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \i_mix_reg[7]\(3 downto 0),
      O(3 downto 0) => \out\(7 downto 4),
      S(3) => \i_mix[7]_i_6_n_0\,
      S(2) => \i_mix[7]_i_7_n_0\,
      S(1) => \i_mix[7]_i_8_n_0\,
      S(0) => \i_mix[7]_i_9_n_0\
    );
\i_out[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(0),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_93,
      O => \i_out[0]_i_1_n_0\
    );
\i_out[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(10),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_83,
      O => \i_out[10]_i_1_n_0\
    );
\i_out[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(11),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_82,
      O => \i_out[11]_i_1_n_0\
    );
\i_out[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(12),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_81,
      O => \i_out[12]_i_1_n_0\
    );
\i_out[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(13),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_80,
      O => \i_out[13]_i_1_n_0\
    );
\i_out[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(14),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_79,
      O => \i_out[14]_i_1_n_0\
    );
\i_out[14]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFE"
    )
        port map (
      I0 => p_0_in(1),
      I1 => p_0_in(0),
      I2 => p_0_in(4),
      I3 => p_0_in(2),
      I4 => p_0_in(3),
      O => \i_out[14]_i_2_n_0\
    );
\i_out[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => adc_data(15),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      O => \i_out[15]_i_1_n_0\
    );
\i_out[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(1),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_92,
      O => \i_out[1]_i_1_n_0\
    );
\i_out[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(2),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_91,
      O => \i_out[2]_i_1_n_0\
    );
\i_out[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(3),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_90,
      O => \i_out[3]_i_1_n_0\
    );
\i_out[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(4),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_89,
      O => \i_out[4]_i_1_n_0\
    );
\i_out[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(5),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_88,
      O => \i_out[5]_i_1_n_0\
    );
\i_out[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(6),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_87,
      O => \i_out[6]_i_1_n_0\
    );
\i_out[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(7),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_86,
      O => \i_out[7]_i_1_n_0\
    );
\i_out[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(8),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_85,
      O => \i_out[8]_i_1_n_0\
    );
\i_out[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(9),
      I1 => core_bypass_agc,
      I2 => p_0_in(4),
      I3 => \i_out[14]_i_2_n_0\,
      I4 => prod_i_n_84,
      O => \i_out[9]_i_1_n_0\
    );
\i_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[0]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(0)
    );
\i_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[10]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(10)
    );
\i_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[11]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(11)
    );
\i_out_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[12]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(12)
    );
\i_out_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[13]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(13)
    );
\i_out_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[14]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(14)
    );
\i_out_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[15]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(15)
    );
\i_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[1]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(1)
    );
\i_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[2]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(2)
    );
\i_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[3]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(3)
    );
\i_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[4]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(4)
    );
\i_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[5]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(5)
    );
\i_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[6]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(6)
    );
\i_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[7]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(7)
    );
\i_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[8]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(8)
    );
\i_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \i_out[9]_i_1_n_0\,
      Q => \^i_out_reg[15]_0\(9)
    );
in_range_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => in_range_carry_n_0,
      CO(2) => in_range_carry_n_1,
      CO(1) => in_range_carry_n_2,
      CO(0) => in_range_carry_n_3,
      CYINIT => '0',
      DI(3) => in_range_carry_i_1_n_0,
      DI(2) => in_range_carry_i_2_n_0,
      DI(1) => in_range_carry_i_3_n_0,
      DI(0) => in_range_carry_i_4_n_0,
      O(3 downto 0) => NLW_in_range_carry_O_UNCONNECTED(3 downto 0),
      S(3) => in_range_carry_i_5_n_0,
      S(2) => in_range_carry_i_6_n_0,
      S(1) => in_range_carry_i_7_n_0,
      S(0) => in_range_carry_i_8_n_0
    );
\in_range_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => in_range_carry_n_0,
      CO(3) => in_range,
      CO(2) => \in_range_carry__0_n_1\,
      CO(1) => \in_range_carry__0_n_2\,
      CO(0) => \in_range_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => \in_range_carry__0_i_1_n_0\,
      DI(1) => \in_range_carry__0_i_2_n_0\,
      DI(0) => \in_range_carry__0_i_3_n_0\,
      O(3 downto 0) => \NLW_in_range_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \in_range_carry__0_i_4_n_0\,
      S(2) => \in_range_carry__0_i_5_n_0\,
      S(1) => \in_range_carry__0_i_6_n_0\,
      S(0) => \in_range_carry__0_i_7_n_0\
    );
\in_range_carry__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000003050500030"
    )
        port map (
      I0 => error(12),
      I1 => err_abs0(12),
      I2 => Q(15),
      I3 => err_abs0(13),
      I4 => \error_carry__3_n_2\,
      I5 => error(13),
      O => \in_range_carry__0_i_1_n_0\
    );
\in_range_carry__0_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => error(11),
      I1 => \error_carry__3_n_2\,
      I2 => err_abs0(11),
      O => \in_range_carry__0_i_10_n_0\
    );
\in_range_carry__0_i_11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => error(9),
      I1 => \error_carry__3_n_2\,
      I2 => err_abs0(9),
      O => \in_range_carry__0_i_11_n_0\
    );
\in_range_carry__0_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A959"
    )
        port map (
      I0 => Q(14),
      I1 => err_abs0(11),
      I2 => \error_carry__3_n_2\,
      I3 => error(11),
      O => \in_range_carry__0_i_12_n_0\
    );
\in_range_carry__0_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A959"
    )
        port map (
      I0 => Q(12),
      I1 => err_abs0(9),
      I2 => \error_carry__3_n_2\,
      I3 => error(9),
      O => \in_range_carry__0_i_13_n_0\
    );
\in_range_carry__0_i_14\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(12),
      O => \in_range_carry__0_i_14_n_0\
    );
\in_range_carry__0_i_15\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(11),
      O => \in_range_carry__0_i_15_n_0\
    );
\in_range_carry__0_i_16\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(10),
      O => \in_range_carry__0_i_16_n_0\
    );
\in_range_carry__0_i_17\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(9),
      O => err_abs1(9)
    );
\in_range_carry__0_i_18\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(15),
      O => \in_range_carry__0_i_18_n_0\
    );
\in_range_carry__0_i_19\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(14),
      O => \in_range_carry__0_i_19_n_0\
    );
\in_range_carry__0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"222222B2B2B222B2"
    )
        port map (
      I0 => Q(14),
      I1 => \in_range_carry__0_i_10_n_0\,
      I2 => Q(13),
      I3 => err_abs0(10),
      I4 => \error_carry__3_n_2\,
      I5 => error(10),
      O => \in_range_carry__0_i_2_n_0\
    );
\in_range_carry__0_i_20\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(13),
      O => \in_range_carry__0_i_20_n_0\
    );
\in_range_carry__0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"222222B2B2B222B2"
    )
        port map (
      I0 => Q(12),
      I1 => \in_range_carry__0_i_11_n_0\,
      I2 => Q(11),
      I3 => err_abs0(8),
      I4 => \error_carry__3_n_2\,
      I5 => error(8),
      O => \in_range_carry__0_i_3_n_0\
    );
\in_range_carry__0_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"1010101F"
    )
        port map (
      I0 => error(15),
      I1 => error(14),
      I2 => \error_carry__3_n_2\,
      I3 => err_abs0(14),
      I4 => err_abs0(15),
      O => \in_range_carry__0_i_4_n_0\
    );
\in_range_carry__0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3055300003000355"
    )
        port map (
      I0 => err_abs0(13),
      I1 => error(13),
      I2 => error(12),
      I3 => \error_carry__3_n_2\,
      I4 => err_abs0(12),
      I5 => Q(15),
      O => \in_range_carry__0_i_5_n_0\
    );
\in_range_carry__0_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8A80202A"
    )
        port map (
      I0 => \in_range_carry__0_i_12_n_0\,
      I1 => error(10),
      I2 => \error_carry__3_n_2\,
      I3 => err_abs0(10),
      I4 => Q(13),
      O => \in_range_carry__0_i_6_n_0\
    );
\in_range_carry__0_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8A80202A"
    )
        port map (
      I0 => \in_range_carry__0_i_13_n_0\,
      I1 => error(8),
      I2 => \error_carry__3_n_2\,
      I3 => err_abs0(8),
      I4 => Q(11),
      O => \in_range_carry__0_i_7_n_0\
    );
\in_range_carry__0_i_8\: unisim.vcomponents.CARRY4
     port map (
      CI => in_range_carry_i_10_n_0,
      CO(3) => \in_range_carry__0_i_8_n_0\,
      CO(2) => \in_range_carry__0_i_8_n_1\,
      CO(1) => \in_range_carry__0_i_8_n_2\,
      CO(0) => \in_range_carry__0_i_8_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => err_abs0(12 downto 9),
      S(3) => \in_range_carry__0_i_14_n_0\,
      S(2) => \in_range_carry__0_i_15_n_0\,
      S(1) => \in_range_carry__0_i_16_n_0\,
      S(0) => err_abs1(9)
    );
\in_range_carry__0_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \in_range_carry__0_i_8_n_0\,
      CO(3 downto 2) => \NLW_in_range_carry__0_i_9_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \in_range_carry__0_i_9_n_2\,
      CO(0) => \in_range_carry__0_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_in_range_carry__0_i_9_O_UNCONNECTED\(3),
      O(2 downto 0) => err_abs0(15 downto 13),
      S(3) => '0',
      S(2) => \in_range_carry__0_i_18_n_0\,
      S(1) => \in_range_carry__0_i_19_n_0\,
      S(0) => \in_range_carry__0_i_20_n_0\
    );
in_range_carry_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"222222B2B2B222B2"
    )
        port map (
      I0 => Q(10),
      I1 => in_range_carry_i_9_n_0,
      I2 => Q(9),
      I3 => err_abs0(6),
      I4 => \error_carry__3_n_2\,
      I5 => error(6),
      O => in_range_carry_i_1_n_0
    );
in_range_carry_i_10: unisim.vcomponents.CARRY4
     port map (
      CI => in_range_carry_i_12_n_0,
      CO(3) => in_range_carry_i_10_n_0,
      CO(2) => in_range_carry_i_10_n_1,
      CO(1) => in_range_carry_i_10_n_2,
      CO(0) => in_range_carry_i_10_n_3,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => err_abs0(8 downto 5),
      S(3 downto 0) => err_abs1(8 downto 5)
    );
in_range_carry_i_11: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => error(5),
      I1 => \error_carry__3_n_2\,
      I2 => err_abs0(5),
      O => in_range_carry_i_11_n_0
    );
in_range_carry_i_12: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => in_range_carry_i_12_n_0,
      CO(2) => in_range_carry_i_12_n_1,
      CO(1) => in_range_carry_i_12_n_2,
      CO(0) => in_range_carry_i_12_n_3,
      CYINIT => err_abs1(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => err_abs0(4 downto 1),
      S(3 downto 0) => err_abs1(4 downto 1)
    );
in_range_carry_i_13: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => error(3),
      I1 => \error_carry__3_n_2\,
      I2 => err_abs0(3),
      O => in_range_carry_i_13_n_0
    );
in_range_carry_i_14: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A959"
    )
        port map (
      I0 => Q(10),
      I1 => err_abs0(7),
      I2 => \error_carry__3_n_2\,
      I3 => error(7),
      O => in_range_carry_i_14_n_0
    );
in_range_carry_i_15: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A959"
    )
        port map (
      I0 => Q(8),
      I1 => err_abs0(5),
      I2 => \error_carry__3_n_2\,
      I3 => error(5),
      O => in_range_carry_i_15_n_0
    );
in_range_carry_i_16: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A959"
    )
        port map (
      I0 => Q(6),
      I1 => err_abs0(3),
      I2 => \error_carry__3_n_2\,
      I3 => error(3),
      O => in_range_carry_i_16_n_0
    );
in_range_carry_i_17: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(8),
      O => err_abs1(8)
    );
in_range_carry_i_18: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(7),
      O => err_abs1(7)
    );
in_range_carry_i_19: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(6),
      O => err_abs1(6)
    );
in_range_carry_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"222222B2B2B222B2"
    )
        port map (
      I0 => Q(8),
      I1 => in_range_carry_i_11_n_0,
      I2 => Q(7),
      I3 => err_abs0(4),
      I4 => \error_carry__3_n_2\,
      I5 => error(4),
      O => in_range_carry_i_2_n_0
    );
in_range_carry_i_20: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(5),
      O => err_abs1(5)
    );
in_range_carry_i_21: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(0),
      O => err_abs1(0)
    );
in_range_carry_i_22: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(4),
      O => err_abs1(4)
    );
in_range_carry_i_23: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(3),
      O => err_abs1(3)
    );
in_range_carry_i_24: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(2),
      O => err_abs1(2)
    );
in_range_carry_i_25: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => error(1),
      O => err_abs1(1)
    );
in_range_carry_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"222222B2B2B222B2"
    )
        port map (
      I0 => Q(6),
      I1 => in_range_carry_i_13_n_0,
      I2 => Q(5),
      I3 => err_abs0(2),
      I4 => \error_carry__3_n_2\,
      I5 => error(2),
      O => in_range_carry_i_3_n_0
    );
in_range_carry_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02A202A2ABFB02A2"
    )
        port map (
      I0 => Q(4),
      I1 => err_abs0(1),
      I2 => \error_carry__3_n_2\,
      I3 => error(1),
      I4 => Q(3),
      I5 => error(0),
      O => in_range_carry_i_4_n_0
    );
in_range_carry_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8A80202A"
    )
        port map (
      I0 => in_range_carry_i_14_n_0,
      I1 => error(6),
      I2 => \error_carry__3_n_2\,
      I3 => err_abs0(6),
      I4 => Q(9),
      O => in_range_carry_i_5_n_0
    );
in_range_carry_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8A80202A"
    )
        port map (
      I0 => in_range_carry_i_15_n_0,
      I1 => error(4),
      I2 => \error_carry__3_n_2\,
      I3 => err_abs0(4),
      I4 => Q(7),
      O => in_range_carry_i_6_n_0
    );
in_range_carry_i_7: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8A80202A"
    )
        port map (
      I0 => in_range_carry_i_16_n_0,
      I1 => error(2),
      I2 => \error_carry__3_n_2\,
      I3 => err_abs0(2),
      I4 => Q(5),
      O => in_range_carry_i_7_n_0
    );
in_range_carry_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B84700000000B847"
    )
        port map (
      I0 => error(1),
      I1 => \error_carry__3_n_2\,
      I2 => err_abs0(1),
      I3 => Q(4),
      I4 => error(0),
      I5 => Q(3),
      O => in_range_carry_i_8_n_0
    );
in_range_carry_i_9: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => error(7),
      I1 => \error_carry__3_n_2\,
      I2 => err_abs0(7),
      O => in_range_carry_i_9_n_0
    );
prod_i: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 16) => B"00000000000000",
      A(15 downto 0) => \^a\(15 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_prod_i_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => adc_data(15),
      B(16) => adc_data(15),
      B(15 downto 0) => adc_data(15 downto 0),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_prod_i_BCOUT_UNCONNECTED(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_prod_i_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_prod_i_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_prod_i_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => NLW_prod_i_OVERFLOW_UNCONNECTED,
      P(47 downto 36) => NLW_prod_i_P_UNCONNECTED(47 downto 36),
      P(35) => prod_i_n_70,
      P(34) => prod_i_n_71,
      P(33) => prod_i_n_72,
      P(32) => prod_i_n_73,
      P(31 downto 27) => p_0_in(4 downto 0),
      P(26) => prod_i_n_79,
      P(25) => prod_i_n_80,
      P(24) => prod_i_n_81,
      P(23) => prod_i_n_82,
      P(22) => prod_i_n_83,
      P(21) => prod_i_n_84,
      P(20) => prod_i_n_85,
      P(19) => prod_i_n_86,
      P(18) => prod_i_n_87,
      P(17) => prod_i_n_88,
      P(16) => prod_i_n_89,
      P(15) => prod_i_n_90,
      P(14) => prod_i_n_91,
      P(13) => prod_i_n_92,
      P(12) => prod_i_n_93,
      P(11) => prod_i_n_94,
      P(10) => prod_i_n_95,
      P(9) => prod_i_n_96,
      P(8) => prod_i_n_97,
      P(7) => prod_i_n_98,
      P(6) => prod_i_n_99,
      P(5) => prod_i_n_100,
      P(4) => prod_i_n_101,
      P(3) => prod_i_n_102,
      P(2) => prod_i_n_103,
      P(1) => prod_i_n_104,
      P(0) => prod_i_n_105,
      PATTERNBDETECT => NLW_prod_i_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_prod_i_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47 downto 0) => NLW_prod_i_PCOUT_UNCONNECTED(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_prod_i_UNDERFLOW_UNCONNECTED
    );
prod_q: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 16) => B"00000000000000",
      A(15 downto 0) => \^a\(15 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_prod_q_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => adc_data(31),
      B(16) => adc_data(31),
      B(15 downto 0) => adc_data(31 downto 16),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_prod_q_BCOUT_UNCONNECTED(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_prod_q_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_prod_q_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_prod_q_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => NLW_prod_q_OVERFLOW_UNCONNECTED,
      P(47 downto 36) => NLW_prod_q_P_UNCONNECTED(47 downto 36),
      P(35) => prod_q_n_70,
      P(34) => prod_q_n_71,
      P(33) => prod_q_n_72,
      P(32) => prod_q_n_73,
      P(31) => prod_q_n_74,
      P(30) => prod_q_n_75,
      P(29) => prod_q_n_76,
      P(28) => prod_q_n_77,
      P(27) => prod_q_n_78,
      P(26) => prod_q_n_79,
      P(25) => prod_q_n_80,
      P(24) => prod_q_n_81,
      P(23) => prod_q_n_82,
      P(22) => prod_q_n_83,
      P(21) => prod_q_n_84,
      P(20) => prod_q_n_85,
      P(19) => prod_q_n_86,
      P(18) => prod_q_n_87,
      P(17) => prod_q_n_88,
      P(16) => prod_q_n_89,
      P(15) => prod_q_n_90,
      P(14) => prod_q_n_91,
      P(13) => prod_q_n_92,
      P(12) => prod_q_n_93,
      P(11) => prod_q_n_94,
      P(10) => prod_q_n_95,
      P(9) => prod_q_n_96,
      P(8) => prod_q_n_97,
      P(7) => prod_q_n_98,
      P(6) => prod_q_n_99,
      P(5) => prod_q_n_100,
      P(4) => prod_q_n_101,
      P(3) => prod_q_n_102,
      P(2) => prod_q_n_103,
      P(1) => prod_q_n_104,
      P(0) => prod_q_n_105,
      PATTERNBDETECT => NLW_prod_q_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_prod_q_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47 downto 0) => NLW_prod_q_PCOUT_UNCONNECTED(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_prod_q_UNDERFLOW_UNCONNECTED
    );
\q_mix[11]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(10),
      I1 => \q_mix_reg[15]_0\(11),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(11),
      O => \q_mix[11]_i_6_n_0\
    );
\q_mix[11]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(9),
      I1 => \q_mix_reg[15]_0\(10),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(10),
      O => \q_mix[11]_i_7_n_0\
    );
\q_mix[11]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(8),
      I1 => \q_mix_reg[15]_0\(9),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(9),
      O => \q_mix[11]_i_8_n_0\
    );
\q_mix[11]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(7),
      I1 => \q_mix_reg[15]_0\(8),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(8),
      O => \q_mix[11]_i_9_n_0\
    );
\q_mix[15]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(14),
      I1 => \q_mix_reg[15]_0\(15),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(15),
      O => \q_mix[15]_i_5_n_0\
    );
\q_mix[15]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(13),
      I1 => \q_mix_reg[15]_0\(14),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(14),
      O => \q_mix[15]_i_6_n_0\
    );
\q_mix[15]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(12),
      I1 => \q_mix_reg[15]_0\(13),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(13),
      O => \q_mix[15]_i_7_n_0\
    );
\q_mix[15]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(11),
      I1 => \q_mix_reg[15]_0\(12),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(12),
      O => \q_mix[15]_i_8_n_0\
    );
\q_mix[3]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(2),
      I1 => \q_mix_reg[15]_0\(3),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(3),
      O => \q_mix[3]_i_6_n_0\
    );
\q_mix[3]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(1),
      I1 => \q_mix_reg[15]_0\(2),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(2),
      O => \q_mix[3]_i_7_n_0\
    );
\q_mix[3]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(0),
      I1 => \q_mix_reg[15]_0\(1),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(1),
      O => \q_mix[3]_i_8_n_0\
    );
\q_mix[3]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => P(0),
      I1 => \q_mix_reg[15]_0\(0),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(0),
      O => \q_mix[3]_i_9_n_0\
    );
\q_mix[7]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(6),
      I1 => \q_mix_reg[15]_0\(7),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(7),
      O => \q_mix[7]_i_6_n_0\
    );
\q_mix[7]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(5),
      I1 => \q_mix_reg[15]_0\(6),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(6),
      O => \q_mix[7]_i_7_n_0\
    );
\q_mix[7]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(4),
      I1 => \q_mix_reg[15]_0\(5),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(5),
      O => \q_mix[7]_i_8_n_0\
    );
\q_mix[7]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F606"
    )
        port map (
      I0 => p_1_out(3),
      I1 => \q_mix_reg[15]_0\(4),
      I2 => core_bypass_costas,
      I3 => \^q_out_reg[15]_0\(4),
      O => \q_mix[7]_i_9_n_0\
    );
\q_mix_reg[11]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \q_mix_reg[7]_i_1_n_0\,
      CO(3) => \q_mix_reg[11]_i_1_n_0\,
      CO(2) => \q_mix_reg[11]_i_1_n_1\,
      CO(1) => \q_mix_reg[11]_i_1_n_2\,
      CO(0) => \q_mix_reg[11]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \q_mix_reg[11]\(3 downto 0),
      O(3 downto 0) => D(11 downto 8),
      S(3) => \q_mix[11]_i_6_n_0\,
      S(2) => \q_mix[11]_i_7_n_0\,
      S(1) => \q_mix[11]_i_8_n_0\,
      S(0) => \q_mix[11]_i_9_n_0\
    );
\q_mix_reg[15]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \q_mix_reg[11]_i_1_n_0\,
      CO(3) => \NLW_q_mix_reg[15]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \q_mix_reg[15]_i_1_n_1\,
      CO(1) => \q_mix_reg[15]_i_1_n_2\,
      CO(0) => \q_mix_reg[15]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => \q_mix_reg[15]\(2 downto 0),
      O(3 downto 0) => D(15 downto 12),
      S(3) => \q_mix[15]_i_5_n_0\,
      S(2) => \q_mix[15]_i_6_n_0\,
      S(1) => \q_mix[15]_i_7_n_0\,
      S(0) => \q_mix[15]_i_8_n_0\
    );
\q_mix_reg[3]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \q_mix_reg[3]_i_1_n_0\,
      CO(2) => \q_mix_reg[3]_i_1_n_1\,
      CO(1) => \q_mix_reg[3]_i_1_n_2\,
      CO(0) => \q_mix_reg[3]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => DI(3 downto 0),
      O(3 downto 0) => D(3 downto 0),
      S(3) => \q_mix[3]_i_6_n_0\,
      S(2) => \q_mix[3]_i_7_n_0\,
      S(1) => \q_mix[3]_i_8_n_0\,
      S(0) => \q_mix[3]_i_9_n_0\
    );
\q_mix_reg[7]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \q_mix_reg[3]_i_1_n_0\,
      CO(3) => \q_mix_reg[7]_i_1_n_0\,
      CO(2) => \q_mix_reg[7]_i_1_n_1\,
      CO(1) => \q_mix_reg[7]_i_1_n_2\,
      CO(0) => \q_mix_reg[7]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \q_mix_reg[7]\(3 downto 0),
      O(3 downto 0) => D(7 downto 4),
      S(3) => \q_mix[7]_i_6_n_0\,
      S(2) => \q_mix[7]_i_7_n_0\,
      S(1) => \q_mix[7]_i_8_n_0\,
      S(0) => \q_mix[7]_i_9_n_0\
    );
\q_out[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(16),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_93,
      O => \q_out[0]_i_1_n_0\
    );
\q_out[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(26),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_83,
      O => \q_out[10]_i_1_n_0\
    );
\q_out[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(27),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_82,
      O => \q_out[11]_i_1_n_0\
    );
\q_out[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(28),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_81,
      O => \q_out[12]_i_1_n_0\
    );
\q_out[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(29),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_80,
      O => \q_out[13]_i_1_n_0\
    );
\q_out[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(30),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_79,
      O => \q_out[14]_i_1_n_0\
    );
\q_out[14]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFE"
    )
        port map (
      I0 => prod_q_n_77,
      I1 => prod_q_n_78,
      I2 => prod_q_n_74,
      I3 => prod_q_n_76,
      I4 => prod_q_n_75,
      O => \q_out[14]_i_2_n_0\
    );
\q_out[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => adc_data(31),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      O => \q_out[15]_i_1_n_0\
    );
\q_out[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(17),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_92,
      O => \q_out[1]_i_1_n_0\
    );
\q_out[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(18),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_91,
      O => \q_out[2]_i_1_n_0\
    );
\q_out[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(19),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_90,
      O => \q_out[3]_i_1_n_0\
    );
\q_out[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(20),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_89,
      O => \q_out[4]_i_1_n_0\
    );
\q_out[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(21),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_88,
      O => \q_out[5]_i_1_n_0\
    );
\q_out[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(22),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_87,
      O => \q_out[6]_i_1_n_0\
    );
\q_out[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(23),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_86,
      O => \q_out[7]_i_1_n_0\
    );
\q_out[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(24),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_85,
      O => \q_out[8]_i_1_n_0\
    );
\q_out[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8B88"
    )
        port map (
      I0 => adc_data(25),
      I1 => core_bypass_agc,
      I2 => prod_q_n_74,
      I3 => \q_out[14]_i_2_n_0\,
      I4 => prod_q_n_84,
      O => \q_out[9]_i_1_n_0\
    );
\q_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[0]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(0)
    );
\q_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[10]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(10)
    );
\q_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[11]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(11)
    );
\q_out_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[12]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(12)
    );
\q_out_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[13]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(13)
    );
\q_out_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[14]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(14)
    );
\q_out_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[15]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(15)
    );
\q_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[1]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(1)
    );
\q_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[2]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(2)
    );
\q_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[3]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(3)
    );
\q_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[4]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(4)
    );
\q_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[5]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(5)
    );
\q_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[6]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(6)
    );
\q_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[7]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(7)
    );
\q_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[8]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(8)
    );
\q_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => E(0),
      CLR => \^aresetn_0\,
      D => \q_out[9]_i_1_n_0\,
      Q => \^q_out_reg[15]_0\(9)
    );
\settle_cnt[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => in_range,
      I1 => \settle_cnt_reg_n_0_[0]\,
      O => \settle_cnt[0]_i_1_n_0\
    );
\settle_cnt[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"60"
    )
        port map (
      I0 => \settle_cnt_reg_n_0_[1]\,
      I1 => \settle_cnt_reg_n_0_[0]\,
      I2 => in_range,
      O => \settle_cnt[1]_i_1_n_0\
    );
\settle_cnt[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2A80"
    )
        port map (
      I0 => in_range,
      I1 => \settle_cnt_reg_n_0_[0]\,
      I2 => \settle_cnt_reg_n_0_[1]\,
      I3 => \settle_cnt_reg_n_0_[2]\,
      O => \settle_cnt[2]_i_1_n_0\
    );
\settle_cnt[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2AAA8000"
    )
        port map (
      I0 => in_range,
      I1 => \settle_cnt_reg_n_0_[1]\,
      I2 => \settle_cnt_reg_n_0_[0]\,
      I3 => \settle_cnt_reg_n_0_[2]\,
      I4 => \settle_cnt_reg_n_0_[3]\,
      O => \settle_cnt[3]_i_1_n_0\
    );
\settle_cnt[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2AAAAAAA80000000"
    )
        port map (
      I0 => in_range,
      I1 => \settle_cnt_reg_n_0_[3]\,
      I2 => \settle_cnt_reg_n_0_[2]\,
      I3 => \settle_cnt_reg_n_0_[0]\,
      I4 => \settle_cnt_reg_n_0_[1]\,
      I5 => \settle_cnt_reg_n_0_[4]\,
      O => \settle_cnt[4]_i_1_n_0\
    );
\settle_cnt[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0888"
    )
        port map (
      I0 => adc_valid,
      I1 => core_enable,
      I2 => in_range,
      I3 => \settle_cnt[5]_i_3_n_0\,
      O => settle_cnt
    );
\settle_cnt[5]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => in_range,
      I1 => \settle_cnt[5]_i_4_n_0\,
      I2 => \settle_cnt_reg_n_0_[5]\,
      O => \settle_cnt[5]_i_2_n_0\
    );
\settle_cnt[5]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \settle_cnt_reg_n_0_[4]\,
      I1 => \settle_cnt_reg_n_0_[3]\,
      I2 => \settle_cnt_reg_n_0_[2]\,
      I3 => \settle_cnt_reg_n_0_[0]\,
      I4 => \settle_cnt_reg_n_0_[1]\,
      I5 => \settle_cnt_reg_n_0_[5]\,
      O => \settle_cnt[5]_i_3_n_0\
    );
\settle_cnt[5]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \settle_cnt_reg_n_0_[1]\,
      I1 => \settle_cnt_reg_n_0_[0]\,
      I2 => \settle_cnt_reg_n_0_[2]\,
      I3 => \settle_cnt_reg_n_0_[3]\,
      I4 => \settle_cnt_reg_n_0_[4]\,
      O => \settle_cnt[5]_i_4_n_0\
    );
\settle_cnt_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => settle_cnt,
      CLR => \^aresetn_0\,
      D => \settle_cnt[0]_i_1_n_0\,
      Q => \settle_cnt_reg_n_0_[0]\
    );
\settle_cnt_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => settle_cnt,
      CLR => \^aresetn_0\,
      D => \settle_cnt[1]_i_1_n_0\,
      Q => \settle_cnt_reg_n_0_[1]\
    );
\settle_cnt_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => settle_cnt,
      CLR => \^aresetn_0\,
      D => \settle_cnt[2]_i_1_n_0\,
      Q => \settle_cnt_reg_n_0_[2]\
    );
\settle_cnt_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => settle_cnt,
      CLR => \^aresetn_0\,
      D => \settle_cnt[3]_i_1_n_0\,
      Q => \settle_cnt_reg_n_0_[3]\
    );
\settle_cnt_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => settle_cnt,
      CLR => \^aresetn_0\,
      D => \settle_cnt[4]_i_1_n_0\,
      Q => \settle_cnt_reg_n_0_[4]\
    );
\settle_cnt_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => settle_cnt,
      CLR => \^aresetn_0\,
      D => \settle_cnt[5]_i_2_n_0\,
      Q => \settle_cnt_reg_n_0_[5]\
    );
settled_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF778000"
    )
        port map (
      I0 => adc_valid,
      I1 => core_enable,
      I2 => \settle_cnt[5]_i_3_n_0\,
      I3 => in_range,
      I4 => \^settled_reg_0\(0),
      O => settled_i_1_n_0
    );
settled_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => settled_i_1_n_0,
      Q => \^settled_reg_0\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_nco is
  port (
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    B : out STD_LOGIC_VECTOR ( 14 downto 0 );
    \phase_acc_reg[31]_0\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    \phase_acc_reg[27]_0\ : out STD_LOGIC;
    \phase_acc_reg[27]_1\ : out STD_LOGIC;
    \phase_acc_reg[27]_2\ : out STD_LOGIC;
    \phase_acc_reg[27]_3\ : out STD_LOGIC;
    \phase_acc_reg[27]_4\ : out STD_LOGIC;
    \phase_acc_reg[27]_5\ : out STD_LOGIC;
    \phase_acc_reg[27]_6\ : out STD_LOGIC;
    \phase_acc_reg[27]_7\ : out STD_LOGIC;
    \phase_acc_reg[27]_8\ : out STD_LOGIC;
    \phase_acc_reg[27]_9\ : out STD_LOGIC;
    \sin_out_reg[15]_0\ : out STD_LOGIC_VECTOR ( 15 downto 0 );
    \cos_out_reg[15]_0\ : out STD_LOGIC_VECTOR ( 15 downto 0 );
    core_enable : in STD_LOGIC;
    adc_valid : in STD_LOGIC;
    core_bypass_costas : in STD_LOGIC;
    phase_err_p0 : in STD_LOGIC_VECTOR ( 14 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    freq_word2 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    \phase_acc_reg[27]_10\ : in STD_LOGIC_VECTOR ( 25 downto 0 );
    D : in STD_LOGIC_VECTOR ( 15 downto 0 );
    aclk : in STD_LOGIC;
    \cos_out_reg[0]_0\ : in STD_LOGIC;
    \cos_out_reg[15]_1\ : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_nco;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_nco is
  signal \^b\ : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \^e\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \phase_acc0__0_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_i_5_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_i_6_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_i_7_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_i_8_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_n_1\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_n_2\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_n_3\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_n_4\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_n_5\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_n_6\ : STD_LOGIC;
  signal \phase_acc0__0_carry__0_n_7\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_i_5_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_i_6_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_i_7_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_i_8_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_n_1\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_n_2\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_n_3\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_n_4\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_n_5\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_n_6\ : STD_LOGIC;
  signal \phase_acc0__0_carry__1_n_7\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_i_5_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_i_6_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_i_7_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_i_8_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_n_1\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_n_2\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_n_3\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_n_4\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_n_5\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_n_6\ : STD_LOGIC;
  signal \phase_acc0__0_carry__2_n_7\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_i_1_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_i_2_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_i_3_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_i_4_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_i_5_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_i_6_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_i_7_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_i_8_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_n_1\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_n_2\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_n_3\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_n_4\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_n_5\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_n_6\ : STD_LOGIC;
  signal \phase_acc0__0_carry__3_n_7\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_i_1_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_i_2_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_i_3_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_i_4_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_i_5_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_i_6_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_i_7_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_i_8_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_n_1\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_n_2\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_n_3\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_n_4\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_n_5\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_n_6\ : STD_LOGIC;
  signal \phase_acc0__0_carry__4_n_7\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_i_1_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_i_2_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_i_3_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_i_4_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_i_5_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_i_6_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_i_7_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_i_8_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_n_1\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_n_2\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_n_3\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_n_4\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_n_5\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_n_6\ : STD_LOGIC;
  signal \phase_acc0__0_carry__5_n_7\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_i_1_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_i_2_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_i_3_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_i_4_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_i_5_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_i_6_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_i_7_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_n_1\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_n_2\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_n_3\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_n_4\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_n_5\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_n_6\ : STD_LOGIC;
  signal \phase_acc0__0_carry__6_n_7\ : STD_LOGIC;
  signal \phase_acc0__0_carry_i_1_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry_i_2_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry_i_3_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry_i_4_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry_i_5_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry_i_6_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry_i_7_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry_n_0\ : STD_LOGIC;
  signal \phase_acc0__0_carry_n_1\ : STD_LOGIC;
  signal \phase_acc0__0_carry_n_2\ : STD_LOGIC;
  signal \phase_acc0__0_carry_n_3\ : STD_LOGIC;
  signal \phase_acc0__0_carry_n_4\ : STD_LOGIC;
  signal \phase_acc0__0_carry_n_5\ : STD_LOGIC;
  signal \phase_acc0__0_carry_n_6\ : STD_LOGIC;
  signal \phase_acc0__0_carry_n_7\ : STD_LOGIC;
  signal \^phase_acc_reg[31]_0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \phase_acc_reg_n_0_[0]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[10]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[11]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[12]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[13]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[14]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[15]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[16]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[17]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[18]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[19]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[1]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[20]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[21]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[22]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[23]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[2]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[3]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[4]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[5]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[6]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[7]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[8]\ : STD_LOGIC;
  signal \phase_acc_reg_n_0_[9]\ : STD_LOGIC;
  signal \NLW_phase_acc0__0_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \phase_acc0__0_carry\ : label is 35;
  attribute ADDER_THRESHOLD of \phase_acc0__0_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \phase_acc0__0_carry__1\ : label is 35;
  attribute ADDER_THRESHOLD of \phase_acc0__0_carry__2\ : label is 35;
  attribute ADDER_THRESHOLD of \phase_acc0__0_carry__3\ : label is 35;
  attribute ADDER_THRESHOLD of \phase_acc0__0_carry__4\ : label is 35;
  attribute ADDER_THRESHOLD of \phase_acc0__0_carry__5\ : label is 35;
  attribute ADDER_THRESHOLD of \phase_acc0__0_carry__6\ : label is 35;
  attribute HLUTNM : string;
  attribute HLUTNM of \phase_acc0__0_carry_i_3\ : label is "lutpair0";
  attribute HLUTNM of \phase_acc0__0_carry_i_7\ : label is "lutpair0";
begin
  B(14 downto 0) <= \^b\(14 downto 0);
  E(0) <= \^e\(0);
  \phase_acc_reg[31]_0\(7 downto 0) <= \^phase_acc_reg[31]_0\(7 downto 0);
adc_valid_d1_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => core_enable,
      I1 => adc_valid,
      O => \^e\(0)
    );
\cos_out[10]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"05BA28A0FA45D75F"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \^phase_acc_reg[31]_0\(0),
      I2 => \^phase_acc_reg[31]_0\(2),
      I3 => \^phase_acc_reg[31]_0\(1),
      I4 => \^phase_acc_reg[31]_0\(4),
      I5 => \^phase_acc_reg[31]_0\(7),
      O => \phase_acc_reg[27]_1\
    );
\cos_out[10]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B50E4AF1E11D1EE2"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \^phase_acc_reg[31]_0\(4),
      I2 => \^phase_acc_reg[31]_0\(2),
      I3 => \^phase_acc_reg[31]_0\(0),
      I4 => \^phase_acc_reg[31]_0\(7),
      I5 => \^phase_acc_reg[31]_0\(1),
      O => \phase_acc_reg[27]_2\
    );
\cos_out[12]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5EAA0000A155FFFF"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \^phase_acc_reg[31]_0\(0),
      I2 => \^phase_acc_reg[31]_0\(1),
      I3 => \^phase_acc_reg[31]_0\(2),
      I4 => \^phase_acc_reg[31]_0\(4),
      I5 => \^phase_acc_reg[31]_0\(7),
      O => \phase_acc_reg[27]_0\
    );
\cos_out[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"16F9E90674028BF9"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \^phase_acc_reg[31]_0\(4),
      I2 => \^phase_acc_reg[31]_0\(2),
      I3 => \^phase_acc_reg[31]_0\(0),
      I4 => \^phase_acc_reg[31]_0\(7),
      I5 => \^phase_acc_reg[31]_0\(1),
      O => \phase_acc_reg[27]_4\
    );
\cos_out[9]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E5B0282A1A4FD7D5"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \^phase_acc_reg[31]_0\(1),
      I2 => \^phase_acc_reg[31]_0\(0),
      I3 => \^phase_acc_reg[31]_0\(2),
      I4 => \^phase_acc_reg[31]_0\(4),
      I5 => \^phase_acc_reg[31]_0\(7),
      O => \phase_acc_reg[27]_3\
    );
\cos_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(0),
      Q => \cos_out_reg[15]_0\(0)
    );
\cos_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(10),
      Q => \cos_out_reg[15]_0\(10)
    );
\cos_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(11),
      Q => \cos_out_reg[15]_0\(11)
    );
\cos_out_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(12),
      Q => \cos_out_reg[15]_0\(12)
    );
\cos_out_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(13),
      Q => \cos_out_reg[15]_0\(13)
    );
\cos_out_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(14),
      Q => \cos_out_reg[15]_0\(14)
    );
\cos_out_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(15),
      Q => \cos_out_reg[15]_0\(15)
    );
\cos_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(1),
      Q => \cos_out_reg[15]_0\(1)
    );
\cos_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(2),
      Q => \cos_out_reg[15]_0\(2)
    );
\cos_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(3),
      Q => \cos_out_reg[15]_0\(3)
    );
\cos_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(4),
      Q => \cos_out_reg[15]_0\(4)
    );
\cos_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(5),
      Q => \cos_out_reg[15]_0\(5)
    );
\cos_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(6),
      Q => \cos_out_reg[15]_0\(6)
    );
\cos_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(7),
      Q => \cos_out_reg[15]_0\(7)
    );
\cos_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(8),
      Q => \cos_out_reg[15]_0\(8)
    );
\cos_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => \cos_out_reg[15]_1\(9),
      Q => \cos_out_reg[15]_0\(9)
    );
freq_word2_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(14),
      I1 => Q(0),
      I2 => freq_word2(15),
      O => \^b\(14)
    );
freq_word2_i_10: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(5),
      I1 => Q(0),
      I2 => freq_word2(6),
      O => \^b\(5)
    );
freq_word2_i_11: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(4),
      I1 => Q(0),
      I2 => freq_word2(5),
      O => \^b\(4)
    );
freq_word2_i_12: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(3),
      I1 => Q(0),
      I2 => freq_word2(4),
      O => \^b\(3)
    );
freq_word2_i_13: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(2),
      I1 => Q(0),
      I2 => freq_word2(3),
      O => \^b\(2)
    );
freq_word2_i_14: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(1),
      I1 => Q(0),
      I2 => freq_word2(2),
      O => \^b\(1)
    );
freq_word2_i_15: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(0),
      I1 => Q(0),
      I2 => freq_word2(1),
      O => \^b\(0)
    );
freq_word2_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(13),
      I1 => Q(0),
      I2 => freq_word2(14),
      O => \^b\(13)
    );
freq_word2_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(12),
      I1 => Q(0),
      I2 => freq_word2(13),
      O => \^b\(12)
    );
freq_word2_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(11),
      I1 => Q(0),
      I2 => freq_word2(12),
      O => \^b\(11)
    );
freq_word2_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(10),
      I1 => Q(0),
      I2 => freq_word2(11),
      O => \^b\(10)
    );
freq_word2_i_6: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(9),
      I1 => Q(0),
      I2 => freq_word2(10),
      O => \^b\(9)
    );
freq_word2_i_7: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(8),
      I1 => Q(0),
      I2 => freq_word2(9),
      O => \^b\(8)
    );
freq_word2_i_8: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(7),
      I1 => Q(0),
      I2 => freq_word2(8),
      O => \^b\(7)
    );
freq_word2_i_9: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => phase_err_p0(6),
      I1 => Q(0),
      I2 => freq_word2(7),
      O => \^b\(6)
    );
\phase_acc0__0_carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \phase_acc0__0_carry_n_0\,
      CO(2) => \phase_acc0__0_carry_n_1\,
      CO(1) => \phase_acc0__0_carry_n_2\,
      CO(0) => \phase_acc0__0_carry_n_3\,
      CYINIT => '0',
      DI(3) => \phase_acc0__0_carry_i_1_n_0\,
      DI(2) => \phase_acc0__0_carry_i_2_n_0\,
      DI(1) => \phase_acc0__0_carry_i_3_n_0\,
      DI(0) => '0',
      O(3) => \phase_acc0__0_carry_n_4\,
      O(2) => \phase_acc0__0_carry_n_5\,
      O(1) => \phase_acc0__0_carry_n_6\,
      O(0) => \phase_acc0__0_carry_n_7\,
      S(3) => \phase_acc0__0_carry_i_4_n_0\,
      S(2) => \phase_acc0__0_carry_i_5_n_0\,
      S(1) => \phase_acc0__0_carry_i_6_n_0\,
      S(0) => \phase_acc0__0_carry_i_7_n_0\
    );
\phase_acc0__0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \phase_acc0__0_carry_n_0\,
      CO(3) => \phase_acc0__0_carry__0_n_0\,
      CO(2) => \phase_acc0__0_carry__0_n_1\,
      CO(1) => \phase_acc0__0_carry__0_n_2\,
      CO(0) => \phase_acc0__0_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => \phase_acc0__0_carry__0_i_1_n_0\,
      DI(2) => \phase_acc0__0_carry__0_i_2_n_0\,
      DI(1) => \phase_acc0__0_carry__0_i_3_n_0\,
      DI(0) => \phase_acc0__0_carry__0_i_4_n_0\,
      O(3) => \phase_acc0__0_carry__0_n_4\,
      O(2) => \phase_acc0__0_carry__0_n_5\,
      O(1) => \phase_acc0__0_carry__0_n_6\,
      O(0) => \phase_acc0__0_carry__0_n_7\,
      S(3) => \phase_acc0__0_carry__0_i_5_n_0\,
      S(2) => \phase_acc0__0_carry__0_i_6_n_0\,
      S(1) => \phase_acc0__0_carry__0_i_7_n_0\,
      S(0) => \phase_acc0__0_carry__0_i_8_n_0\
    );
\phase_acc0__0_carry__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[6]\,
      I1 => \phase_acc_reg[27]_10\(6),
      I2 => freq_word2(6),
      I3 => Q(0),
      I4 => phase_err_p0(5),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry__0_i_1_n_0\
    );
\phase_acc0__0_carry__0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[5]\,
      I1 => \phase_acc_reg[27]_10\(5),
      I2 => freq_word2(5),
      I3 => Q(0),
      I4 => phase_err_p0(4),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry__0_i_2_n_0\
    );
\phase_acc0__0_carry__0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[4]\,
      I1 => \phase_acc_reg[27]_10\(4),
      I2 => freq_word2(4),
      I3 => Q(0),
      I4 => phase_err_p0(3),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry__0_i_3_n_0\
    );
\phase_acc0__0_carry__0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[3]\,
      I1 => \phase_acc_reg[27]_10\(3),
      I2 => freq_word2(3),
      I3 => Q(0),
      I4 => phase_err_p0(2),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry__0_i_4_n_0\
    );
\phase_acc0__0_carry__0_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry__0_i_1_n_0\,
      I1 => \phase_acc_reg_n_0_[7]\,
      I2 => \phase_acc_reg[27]_10\(7),
      I3 => \^b\(6),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry__0_i_5_n_0\
    );
\phase_acc0__0_carry__0_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry__0_i_2_n_0\,
      I1 => \phase_acc_reg_n_0_[6]\,
      I2 => \phase_acc_reg[27]_10\(6),
      I3 => \^b\(5),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry__0_i_6_n_0\
    );
\phase_acc0__0_carry__0_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry__0_i_3_n_0\,
      I1 => \phase_acc_reg_n_0_[5]\,
      I2 => \phase_acc_reg[27]_10\(5),
      I3 => \^b\(4),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry__0_i_7_n_0\
    );
\phase_acc0__0_carry__0_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry__0_i_4_n_0\,
      I1 => \phase_acc_reg_n_0_[4]\,
      I2 => \phase_acc_reg[27]_10\(4),
      I3 => \^b\(3),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry__0_i_8_n_0\
    );
\phase_acc0__0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \phase_acc0__0_carry__0_n_0\,
      CO(3) => \phase_acc0__0_carry__1_n_0\,
      CO(2) => \phase_acc0__0_carry__1_n_1\,
      CO(1) => \phase_acc0__0_carry__1_n_2\,
      CO(0) => \phase_acc0__0_carry__1_n_3\,
      CYINIT => '0',
      DI(3) => \phase_acc0__0_carry__1_i_1_n_0\,
      DI(2) => \phase_acc0__0_carry__1_i_2_n_0\,
      DI(1) => \phase_acc0__0_carry__1_i_3_n_0\,
      DI(0) => \phase_acc0__0_carry__1_i_4_n_0\,
      O(3) => \phase_acc0__0_carry__1_n_4\,
      O(2) => \phase_acc0__0_carry__1_n_5\,
      O(1) => \phase_acc0__0_carry__1_n_6\,
      O(0) => \phase_acc0__0_carry__1_n_7\,
      S(3) => \phase_acc0__0_carry__1_i_5_n_0\,
      S(2) => \phase_acc0__0_carry__1_i_6_n_0\,
      S(1) => \phase_acc0__0_carry__1_i_7_n_0\,
      S(0) => \phase_acc0__0_carry__1_i_8_n_0\
    );
\phase_acc0__0_carry__1_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[10]\,
      I1 => \phase_acc_reg[27]_10\(10),
      I2 => freq_word2(10),
      I3 => Q(0),
      I4 => phase_err_p0(9),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry__1_i_1_n_0\
    );
\phase_acc0__0_carry__1_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[9]\,
      I1 => \phase_acc_reg[27]_10\(9),
      I2 => freq_word2(9),
      I3 => Q(0),
      I4 => phase_err_p0(8),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry__1_i_2_n_0\
    );
\phase_acc0__0_carry__1_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[8]\,
      I1 => \phase_acc_reg[27]_10\(8),
      I2 => freq_word2(8),
      I3 => Q(0),
      I4 => phase_err_p0(7),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry__1_i_3_n_0\
    );
\phase_acc0__0_carry__1_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[7]\,
      I1 => \phase_acc_reg[27]_10\(7),
      I2 => freq_word2(7),
      I3 => Q(0),
      I4 => phase_err_p0(6),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry__1_i_4_n_0\
    );
\phase_acc0__0_carry__1_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry__1_i_1_n_0\,
      I1 => \phase_acc_reg_n_0_[11]\,
      I2 => \phase_acc_reg[27]_10\(11),
      I3 => \^b\(10),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry__1_i_5_n_0\
    );
\phase_acc0__0_carry__1_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry__1_i_2_n_0\,
      I1 => \phase_acc_reg_n_0_[10]\,
      I2 => \phase_acc_reg[27]_10\(10),
      I3 => \^b\(9),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry__1_i_6_n_0\
    );
\phase_acc0__0_carry__1_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry__1_i_3_n_0\,
      I1 => \phase_acc_reg_n_0_[9]\,
      I2 => \phase_acc_reg[27]_10\(9),
      I3 => \^b\(8),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry__1_i_7_n_0\
    );
\phase_acc0__0_carry__1_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry__1_i_4_n_0\,
      I1 => \phase_acc_reg_n_0_[8]\,
      I2 => \phase_acc_reg[27]_10\(8),
      I3 => \^b\(7),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry__1_i_8_n_0\
    );
\phase_acc0__0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \phase_acc0__0_carry__1_n_0\,
      CO(3) => \phase_acc0__0_carry__2_n_0\,
      CO(2) => \phase_acc0__0_carry__2_n_1\,
      CO(1) => \phase_acc0__0_carry__2_n_2\,
      CO(0) => \phase_acc0__0_carry__2_n_3\,
      CYINIT => '0',
      DI(3) => \phase_acc0__0_carry__2_i_1_n_0\,
      DI(2) => \phase_acc0__0_carry__2_i_2_n_0\,
      DI(1) => \phase_acc0__0_carry__2_i_3_n_0\,
      DI(0) => \phase_acc0__0_carry__2_i_4_n_0\,
      O(3) => \phase_acc0__0_carry__2_n_4\,
      O(2) => \phase_acc0__0_carry__2_n_5\,
      O(1) => \phase_acc0__0_carry__2_n_6\,
      O(0) => \phase_acc0__0_carry__2_n_7\,
      S(3) => \phase_acc0__0_carry__2_i_5_n_0\,
      S(2) => \phase_acc0__0_carry__2_i_6_n_0\,
      S(1) => \phase_acc0__0_carry__2_i_7_n_0\,
      S(0) => \phase_acc0__0_carry__2_i_8_n_0\
    );
\phase_acc0__0_carry__2_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4540BABFBABF4540"
    )
        port map (
      I0 => core_bypass_costas,
      I1 => phase_err_p0(14),
      I2 => Q(0),
      I3 => freq_word2(15),
      I4 => \phase_acc_reg[27]_10\(15),
      I5 => \phase_acc_reg_n_0_[15]\,
      O => \phase_acc0__0_carry__2_i_1_n_0\
    );
\phase_acc0__0_carry__2_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[13]\,
      I1 => \phase_acc_reg[27]_10\(13),
      I2 => freq_word2(13),
      I3 => Q(0),
      I4 => phase_err_p0(12),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry__2_i_2_n_0\
    );
\phase_acc0__0_carry__2_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[12]\,
      I1 => \phase_acc_reg[27]_10\(12),
      I2 => freq_word2(12),
      I3 => Q(0),
      I4 => phase_err_p0(11),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry__2_i_3_n_0\
    );
\phase_acc0__0_carry__2_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[11]\,
      I1 => \phase_acc_reg[27]_10\(11),
      I2 => freq_word2(11),
      I3 => Q(0),
      I4 => phase_err_p0(10),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry__2_i_4_n_0\
    );
\phase_acc0__0_carry__2_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"559A9AAA"
    )
        port map (
      I0 => \phase_acc0__0_carry__2_i_1_n_0\,
      I1 => core_bypass_costas,
      I2 => \^b\(13),
      I3 => \phase_acc_reg[27]_10\(14),
      I4 => \phase_acc_reg_n_0_[14]\,
      O => \phase_acc0__0_carry__2_i_5_n_0\
    );
\phase_acc0__0_carry__2_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry__2_i_2_n_0\,
      I1 => \phase_acc_reg_n_0_[14]\,
      I2 => \phase_acc_reg[27]_10\(14),
      I3 => \^b\(13),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry__2_i_6_n_0\
    );
\phase_acc0__0_carry__2_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry__2_i_3_n_0\,
      I1 => \phase_acc_reg_n_0_[13]\,
      I2 => \phase_acc_reg[27]_10\(13),
      I3 => \^b\(12),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry__2_i_7_n_0\
    );
\phase_acc0__0_carry__2_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry__2_i_4_n_0\,
      I1 => \phase_acc_reg_n_0_[12]\,
      I2 => \phase_acc_reg[27]_10\(12),
      I3 => \^b\(11),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry__2_i_8_n_0\
    );
\phase_acc0__0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \phase_acc0__0_carry__2_n_0\,
      CO(3) => \phase_acc0__0_carry__3_n_0\,
      CO(2) => \phase_acc0__0_carry__3_n_1\,
      CO(1) => \phase_acc0__0_carry__3_n_2\,
      CO(0) => \phase_acc0__0_carry__3_n_3\,
      CYINIT => '0',
      DI(3) => \phase_acc0__0_carry__3_i_1_n_0\,
      DI(2) => \phase_acc0__0_carry__3_i_2_n_0\,
      DI(1) => \phase_acc0__0_carry__3_i_3_n_0\,
      DI(0) => \phase_acc0__0_carry__3_i_4_n_0\,
      O(3) => \phase_acc0__0_carry__3_n_4\,
      O(2) => \phase_acc0__0_carry__3_n_5\,
      O(1) => \phase_acc0__0_carry__3_n_6\,
      O(0) => \phase_acc0__0_carry__3_n_7\,
      S(3) => \phase_acc0__0_carry__3_i_5_n_0\,
      S(2) => \phase_acc0__0_carry__3_i_6_n_0\,
      S(1) => \phase_acc0__0_carry__3_i_7_n_0\,
      S(0) => \phase_acc0__0_carry__3_i_8_n_0\
    );
\phase_acc0__0_carry__3_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E00E"
    )
        port map (
      I0 => \phase_acc_reg[27]_10\(17),
      I1 => \phase_acc_reg_n_0_[17]\,
      I2 => \phase_acc_reg[27]_10\(18),
      I3 => \phase_acc_reg_n_0_[18]\,
      O => \phase_acc0__0_carry__3_i_1_n_0\
    );
\phase_acc0__0_carry__3_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E00E"
    )
        port map (
      I0 => \phase_acc_reg[27]_10\(16),
      I1 => \phase_acc_reg_n_0_[16]\,
      I2 => \phase_acc_reg[27]_10\(17),
      I3 => \phase_acc_reg_n_0_[17]\,
      O => \phase_acc0__0_carry__3_i_2_n_0\
    );
\phase_acc0__0_carry__3_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E00E"
    )
        port map (
      I0 => \phase_acc_reg[27]_10\(15),
      I1 => \phase_acc_reg_n_0_[15]\,
      I2 => \phase_acc_reg[27]_10\(16),
      I3 => \phase_acc_reg_n_0_[16]\,
      O => \phase_acc0__0_carry__3_i_3_n_0\
    );
\phase_acc0__0_carry__3_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BABF00000000BABF"
    )
        port map (
      I0 => core_bypass_costas,
      I1 => phase_err_p0(14),
      I2 => Q(0),
      I3 => freq_word2(15),
      I4 => \phase_acc_reg[27]_10\(15),
      I5 => \phase_acc_reg_n_0_[15]\,
      O => \phase_acc0__0_carry__3_i_4_n_0\
    );
\phase_acc0__0_carry__3_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E11E0FF00FF01EE1"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[17]\,
      I1 => \phase_acc_reg[27]_10\(17),
      I2 => \phase_acc_reg_n_0_[19]\,
      I3 => \phase_acc_reg[27]_10\(19),
      I4 => \phase_acc_reg_n_0_[18]\,
      I5 => \phase_acc_reg[27]_10\(18),
      O => \phase_acc0__0_carry__3_i_5_n_0\
    );
\phase_acc0__0_carry__3_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E11E0FF00FF01EE1"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[16]\,
      I1 => \phase_acc_reg[27]_10\(16),
      I2 => \phase_acc_reg_n_0_[18]\,
      I3 => \phase_acc_reg[27]_10\(18),
      I4 => \phase_acc_reg_n_0_[17]\,
      I5 => \phase_acc_reg[27]_10\(17),
      O => \phase_acc0__0_carry__3_i_6_n_0\
    );
\phase_acc0__0_carry__3_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E11E0FF00FF01EE1"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[15]\,
      I1 => \phase_acc_reg[27]_10\(15),
      I2 => \phase_acc_reg_n_0_[17]\,
      I3 => \phase_acc_reg[27]_10\(17),
      I4 => \phase_acc_reg_n_0_[16]\,
      I5 => \phase_acc_reg[27]_10\(16),
      O => \phase_acc0__0_carry__3_i_7_n_0\
    );
\phase_acc0__0_carry__3_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D22D0FF00FF02DD2"
    )
        port map (
      I0 => \^b\(14),
      I1 => core_bypass_costas,
      I2 => \phase_acc_reg_n_0_[16]\,
      I3 => \phase_acc_reg[27]_10\(16),
      I4 => \phase_acc_reg_n_0_[15]\,
      I5 => \phase_acc_reg[27]_10\(15),
      O => \phase_acc0__0_carry__3_i_8_n_0\
    );
\phase_acc0__0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \phase_acc0__0_carry__3_n_0\,
      CO(3) => \phase_acc0__0_carry__4_n_0\,
      CO(2) => \phase_acc0__0_carry__4_n_1\,
      CO(1) => \phase_acc0__0_carry__4_n_2\,
      CO(0) => \phase_acc0__0_carry__4_n_3\,
      CYINIT => '0',
      DI(3) => \phase_acc0__0_carry__4_i_1_n_0\,
      DI(2) => \phase_acc0__0_carry__4_i_2_n_0\,
      DI(1) => \phase_acc0__0_carry__4_i_3_n_0\,
      DI(0) => \phase_acc0__0_carry__4_i_4_n_0\,
      O(3) => \phase_acc0__0_carry__4_n_4\,
      O(2) => \phase_acc0__0_carry__4_n_5\,
      O(1) => \phase_acc0__0_carry__4_n_6\,
      O(0) => \phase_acc0__0_carry__4_n_7\,
      S(3) => \phase_acc0__0_carry__4_i_5_n_0\,
      S(2) => \phase_acc0__0_carry__4_i_6_n_0\,
      S(1) => \phase_acc0__0_carry__4_i_7_n_0\,
      S(0) => \phase_acc0__0_carry__4_i_8_n_0\
    );
\phase_acc0__0_carry__4_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E00E"
    )
        port map (
      I0 => \phase_acc_reg[27]_10\(21),
      I1 => \phase_acc_reg_n_0_[21]\,
      I2 => \phase_acc_reg[27]_10\(22),
      I3 => \phase_acc_reg_n_0_[22]\,
      O => \phase_acc0__0_carry__4_i_1_n_0\
    );
\phase_acc0__0_carry__4_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E00E"
    )
        port map (
      I0 => \phase_acc_reg[27]_10\(20),
      I1 => \phase_acc_reg_n_0_[20]\,
      I2 => \phase_acc_reg[27]_10\(21),
      I3 => \phase_acc_reg_n_0_[21]\,
      O => \phase_acc0__0_carry__4_i_2_n_0\
    );
\phase_acc0__0_carry__4_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E00E"
    )
        port map (
      I0 => \phase_acc_reg[27]_10\(19),
      I1 => \phase_acc_reg_n_0_[19]\,
      I2 => \phase_acc_reg[27]_10\(20),
      I3 => \phase_acc_reg_n_0_[20]\,
      O => \phase_acc0__0_carry__4_i_3_n_0\
    );
\phase_acc0__0_carry__4_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E00E"
    )
        port map (
      I0 => \phase_acc_reg[27]_10\(18),
      I1 => \phase_acc_reg_n_0_[18]\,
      I2 => \phase_acc_reg[27]_10\(19),
      I3 => \phase_acc_reg_n_0_[19]\,
      O => \phase_acc0__0_carry__4_i_4_n_0\
    );
\phase_acc0__0_carry__4_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E11E0FF00FF01EE1"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[21]\,
      I1 => \phase_acc_reg[27]_10\(21),
      I2 => \phase_acc_reg_n_0_[23]\,
      I3 => \phase_acc_reg[27]_10\(23),
      I4 => \phase_acc_reg_n_0_[22]\,
      I5 => \phase_acc_reg[27]_10\(22),
      O => \phase_acc0__0_carry__4_i_5_n_0\
    );
\phase_acc0__0_carry__4_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E11E0FF00FF01EE1"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[20]\,
      I1 => \phase_acc_reg[27]_10\(20),
      I2 => \phase_acc_reg_n_0_[22]\,
      I3 => \phase_acc_reg[27]_10\(22),
      I4 => \phase_acc_reg_n_0_[21]\,
      I5 => \phase_acc_reg[27]_10\(21),
      O => \phase_acc0__0_carry__4_i_6_n_0\
    );
\phase_acc0__0_carry__4_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E11E0FF00FF01EE1"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[19]\,
      I1 => \phase_acc_reg[27]_10\(19),
      I2 => \phase_acc_reg_n_0_[21]\,
      I3 => \phase_acc_reg[27]_10\(21),
      I4 => \phase_acc_reg_n_0_[20]\,
      I5 => \phase_acc_reg[27]_10\(20),
      O => \phase_acc0__0_carry__4_i_7_n_0\
    );
\phase_acc0__0_carry__4_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E11E0FF00FF01EE1"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[18]\,
      I1 => \phase_acc_reg[27]_10\(18),
      I2 => \phase_acc_reg_n_0_[20]\,
      I3 => \phase_acc_reg[27]_10\(20),
      I4 => \phase_acc_reg_n_0_[19]\,
      I5 => \phase_acc_reg[27]_10\(19),
      O => \phase_acc0__0_carry__4_i_8_n_0\
    );
\phase_acc0__0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \phase_acc0__0_carry__4_n_0\,
      CO(3) => \phase_acc0__0_carry__5_n_0\,
      CO(2) => \phase_acc0__0_carry__5_n_1\,
      CO(1) => \phase_acc0__0_carry__5_n_2\,
      CO(0) => \phase_acc0__0_carry__5_n_3\,
      CYINIT => '0',
      DI(3) => \phase_acc0__0_carry__5_i_1_n_0\,
      DI(2) => \phase_acc0__0_carry__5_i_2_n_0\,
      DI(1) => \phase_acc0__0_carry__5_i_3_n_0\,
      DI(0) => \phase_acc0__0_carry__5_i_4_n_0\,
      O(3) => \phase_acc0__0_carry__5_n_4\,
      O(2) => \phase_acc0__0_carry__5_n_5\,
      O(1) => \phase_acc0__0_carry__5_n_6\,
      O(0) => \phase_acc0__0_carry__5_n_7\,
      S(3) => \phase_acc0__0_carry__5_i_5_n_0\,
      S(2) => \phase_acc0__0_carry__5_i_6_n_0\,
      S(1) => \phase_acc0__0_carry__5_i_7_n_0\,
      S(0) => \phase_acc0__0_carry__5_i_8_n_0\
    );
\phase_acc0__0_carry__5_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C2"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(1),
      I1 => \^phase_acc_reg[31]_0\(2),
      I2 => \phase_acc_reg[27]_10\(25),
      O => \phase_acc0__0_carry__5_i_1_n_0\
    );
\phase_acc0__0_carry__5_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E00E"
    )
        port map (
      I0 => \phase_acc_reg[27]_10\(24),
      I1 => \^phase_acc_reg[31]_0\(0),
      I2 => \phase_acc_reg[27]_10\(25),
      I3 => \^phase_acc_reg[31]_0\(1),
      O => \phase_acc0__0_carry__5_i_2_n_0\
    );
\phase_acc0__0_carry__5_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E00E"
    )
        port map (
      I0 => \phase_acc_reg[27]_10\(23),
      I1 => \phase_acc_reg_n_0_[23]\,
      I2 => \phase_acc_reg[27]_10\(24),
      I3 => \^phase_acc_reg[31]_0\(0),
      O => \phase_acc0__0_carry__5_i_3_n_0\
    );
\phase_acc0__0_carry__5_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E00E"
    )
        port map (
      I0 => \phase_acc_reg[27]_10\(22),
      I1 => \phase_acc_reg_n_0_[22]\,
      I2 => \phase_acc_reg[27]_10\(23),
      I3 => \phase_acc_reg_n_0_[23]\,
      O => \phase_acc0__0_carry__5_i_4_n_0\
    );
\phase_acc0__0_carry__5_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F02D"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(1),
      I1 => \phase_acc_reg[27]_10\(25),
      I2 => \^phase_acc_reg[31]_0\(3),
      I3 => \^phase_acc_reg[31]_0\(2),
      O => \phase_acc0__0_carry__5_i_5_n_0\
    );
\phase_acc0__0_carry__5_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EF100EF1"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(0),
      I1 => \phase_acc_reg[27]_10\(24),
      I2 => \phase_acc_reg[27]_10\(25),
      I3 => \^phase_acc_reg[31]_0\(2),
      I4 => \^phase_acc_reg[31]_0\(1),
      O => \phase_acc0__0_carry__5_i_6_n_0\
    );
\phase_acc0__0_carry__5_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E11E0FF00FF01EE1"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[23]\,
      I1 => \phase_acc_reg[27]_10\(23),
      I2 => \^phase_acc_reg[31]_0\(1),
      I3 => \phase_acc_reg[27]_10\(25),
      I4 => \^phase_acc_reg[31]_0\(0),
      I5 => \phase_acc_reg[27]_10\(24),
      O => \phase_acc0__0_carry__5_i_7_n_0\
    );
\phase_acc0__0_carry__5_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E11E0FF00FF01EE1"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[22]\,
      I1 => \phase_acc_reg[27]_10\(22),
      I2 => \^phase_acc_reg[31]_0\(0),
      I3 => \phase_acc_reg[27]_10\(24),
      I4 => \phase_acc_reg_n_0_[23]\,
      I5 => \phase_acc_reg[27]_10\(23),
      O => \phase_acc0__0_carry__5_i_8_n_0\
    );
\phase_acc0__0_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \phase_acc0__0_carry__5_n_0\,
      CO(3) => \NLW_phase_acc0__0_carry__6_CO_UNCONNECTED\(3),
      CO(2) => \phase_acc0__0_carry__6_n_1\,
      CO(1) => \phase_acc0__0_carry__6_n_2\,
      CO(0) => \phase_acc0__0_carry__6_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => \phase_acc0__0_carry__6_i_1_n_0\,
      DI(1) => \phase_acc0__0_carry__6_i_2_n_0\,
      DI(0) => \phase_acc0__0_carry__6_i_3_n_0\,
      O(3) => \phase_acc0__0_carry__6_n_4\,
      O(2) => \phase_acc0__0_carry__6_n_5\,
      O(1) => \phase_acc0__0_carry__6_n_6\,
      O(0) => \phase_acc0__0_carry__6_n_7\,
      S(3) => \phase_acc0__0_carry__6_i_4_n_0\,
      S(2) => \phase_acc0__0_carry__6_i_5_n_0\,
      S(1) => \phase_acc0__0_carry__6_i_6_n_0\,
      S(0) => \phase_acc0__0_carry__6_i_7_n_0\
    );
\phase_acc0__0_carry__6_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C2"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(4),
      I1 => \^phase_acc_reg[31]_0\(5),
      I2 => \phase_acc_reg[27]_10\(25),
      O => \phase_acc0__0_carry__6_i_1_n_0\
    );
\phase_acc0__0_carry__6_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C2"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \^phase_acc_reg[31]_0\(4),
      I2 => \phase_acc_reg[27]_10\(25),
      O => \phase_acc0__0_carry__6_i_2_n_0\
    );
\phase_acc0__0_carry__6_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C2"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(2),
      I1 => \^phase_acc_reg[31]_0\(3),
      I2 => \phase_acc_reg[27]_10\(25),
      O => \phase_acc0__0_carry__6_i_3_n_0\
    );
\phase_acc0__0_carry__6_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F20D"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(5),
      I1 => \phase_acc_reg[27]_10\(25),
      I2 => \^phase_acc_reg[31]_0\(6),
      I3 => \^phase_acc_reg[31]_0\(7),
      O => \phase_acc0__0_carry__6_i_4_n_0\
    );
\phase_acc0__0_carry__6_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F02D"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(4),
      I1 => \phase_acc_reg[27]_10\(25),
      I2 => \^phase_acc_reg[31]_0\(6),
      I3 => \^phase_acc_reg[31]_0\(5),
      O => \phase_acc0__0_carry__6_i_5_n_0\
    );
\phase_acc0__0_carry__6_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F02D"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \phase_acc_reg[27]_10\(25),
      I2 => \^phase_acc_reg[31]_0\(5),
      I3 => \^phase_acc_reg[31]_0\(4),
      O => \phase_acc0__0_carry__6_i_6_n_0\
    );
\phase_acc0__0_carry__6_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F02D"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(2),
      I1 => \phase_acc_reg[27]_10\(25),
      I2 => \^phase_acc_reg[31]_0\(4),
      I3 => \^phase_acc_reg[31]_0\(3),
      O => \phase_acc0__0_carry__6_i_7_n_0\
    );
\phase_acc0__0_carry_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[2]\,
      I1 => \phase_acc_reg[27]_10\(2),
      I2 => freq_word2(2),
      I3 => Q(0),
      I4 => phase_err_p0(1),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry_i_1_n_0\
    );
\phase_acc0__0_carry_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888EEE888E8"
    )
        port map (
      I0 => \phase_acc_reg_n_0_[1]\,
      I1 => \phase_acc_reg[27]_10\(1),
      I2 => freq_word2(1),
      I3 => Q(0),
      I4 => phase_err_p0(0),
      I5 => core_bypass_costas,
      O => \phase_acc0__0_carry_i_2_n_0\
    );
\phase_acc0__0_carry_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F220"
    )
        port map (
      I0 => freq_word2(0),
      I1 => core_bypass_costas,
      I2 => \phase_acc_reg_n_0_[0]\,
      I3 => \phase_acc_reg[27]_10\(0),
      O => \phase_acc0__0_carry_i_3_n_0\
    );
\phase_acc0__0_carry_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry_i_1_n_0\,
      I1 => \phase_acc_reg_n_0_[3]\,
      I2 => \phase_acc_reg[27]_10\(3),
      I3 => \^b\(2),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry_i_4_n_0\
    );
\phase_acc0__0_carry_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry_i_2_n_0\,
      I1 => \phase_acc_reg_n_0_[2]\,
      I2 => \phase_acc_reg[27]_10\(2),
      I3 => \^b\(1),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry_i_5_n_0\
    );
\phase_acc0__0_carry_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96966996"
    )
        port map (
      I0 => \phase_acc0__0_carry_i_3_n_0\,
      I1 => \phase_acc_reg_n_0_[1]\,
      I2 => \phase_acc_reg[27]_10\(1),
      I3 => \^b\(0),
      I4 => core_bypass_costas,
      O => \phase_acc0__0_carry_i_6_n_0\
    );
\phase_acc0__0_carry_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2DD2"
    )
        port map (
      I0 => freq_word2(0),
      I1 => core_bypass_costas,
      I2 => \phase_acc_reg_n_0_[0]\,
      I3 => \phase_acc_reg[27]_10\(0),
      O => \phase_acc0__0_carry_i_7_n_0\
    );
\phase_acc_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry_n_7\,
      Q => \phase_acc_reg_n_0_[0]\
    );
\phase_acc_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__1_n_5\,
      Q => \phase_acc_reg_n_0_[10]\
    );
\phase_acc_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__1_n_4\,
      Q => \phase_acc_reg_n_0_[11]\
    );
\phase_acc_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__2_n_7\,
      Q => \phase_acc_reg_n_0_[12]\
    );
\phase_acc_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__2_n_6\,
      Q => \phase_acc_reg_n_0_[13]\
    );
\phase_acc_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__2_n_5\,
      Q => \phase_acc_reg_n_0_[14]\
    );
\phase_acc_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__2_n_4\,
      Q => \phase_acc_reg_n_0_[15]\
    );
\phase_acc_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__3_n_7\,
      Q => \phase_acc_reg_n_0_[16]\
    );
\phase_acc_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__3_n_6\,
      Q => \phase_acc_reg_n_0_[17]\
    );
\phase_acc_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__3_n_5\,
      Q => \phase_acc_reg_n_0_[18]\
    );
\phase_acc_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__3_n_4\,
      Q => \phase_acc_reg_n_0_[19]\
    );
\phase_acc_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry_n_6\,
      Q => \phase_acc_reg_n_0_[1]\
    );
\phase_acc_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__4_n_7\,
      Q => \phase_acc_reg_n_0_[20]\
    );
\phase_acc_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__4_n_6\,
      Q => \phase_acc_reg_n_0_[21]\
    );
\phase_acc_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__4_n_5\,
      Q => \phase_acc_reg_n_0_[22]\
    );
\phase_acc_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__4_n_4\,
      Q => \phase_acc_reg_n_0_[23]\
    );
\phase_acc_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__5_n_7\,
      Q => \^phase_acc_reg[31]_0\(0)
    );
\phase_acc_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__5_n_6\,
      Q => \^phase_acc_reg[31]_0\(1)
    );
\phase_acc_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__5_n_5\,
      Q => \^phase_acc_reg[31]_0\(2)
    );
\phase_acc_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__5_n_4\,
      Q => \^phase_acc_reg[31]_0\(3)
    );
\phase_acc_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__6_n_7\,
      Q => \^phase_acc_reg[31]_0\(4)
    );
\phase_acc_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__6_n_6\,
      Q => \^phase_acc_reg[31]_0\(5)
    );
\phase_acc_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry_n_5\,
      Q => \phase_acc_reg_n_0_[2]\
    );
\phase_acc_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__6_n_5\,
      Q => \^phase_acc_reg[31]_0\(6)
    );
\phase_acc_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__6_n_4\,
      Q => \^phase_acc_reg[31]_0\(7)
    );
\phase_acc_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry_n_4\,
      Q => \phase_acc_reg_n_0_[3]\
    );
\phase_acc_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__0_n_7\,
      Q => \phase_acc_reg_n_0_[4]\
    );
\phase_acc_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__0_n_6\,
      Q => \phase_acc_reg_n_0_[5]\
    );
\phase_acc_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__0_n_5\,
      Q => \phase_acc_reg_n_0_[6]\
    );
\phase_acc_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__0_n_4\,
      Q => \phase_acc_reg_n_0_[7]\
    );
\phase_acc_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__1_n_7\,
      Q => \phase_acc_reg_n_0_[8]\
    );
\phase_acc_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \cos_out_reg[0]_0\,
      D => \phase_acc0__0_carry__1_n_6\,
      Q => \phase_acc_reg_n_0_[9]\
    );
\sin_out[10]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"05BA28A0FA45D75F"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \^phase_acc_reg[31]_0\(0),
      I2 => \^phase_acc_reg[31]_0\(2),
      I3 => \^phase_acc_reg[31]_0\(1),
      I4 => \^phase_acc_reg[31]_0\(4),
      I5 => \^phase_acc_reg[31]_0\(7),
      O => \phase_acc_reg[27]_8\
    );
\sin_out[10]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B50E4AF1E11D1EE2"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \^phase_acc_reg[31]_0\(4),
      I2 => \^phase_acc_reg[31]_0\(2),
      I3 => \^phase_acc_reg[31]_0\(0),
      I4 => \^phase_acc_reg[31]_0\(7),
      I5 => \^phase_acc_reg[31]_0\(1),
      O => \phase_acc_reg[27]_7\
    );
\sin_out[12]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5EAA0000A155FFFF"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \^phase_acc_reg[31]_0\(0),
      I2 => \^phase_acc_reg[31]_0\(1),
      I3 => \^phase_acc_reg[31]_0\(2),
      I4 => \^phase_acc_reg[31]_0\(4),
      I5 => \^phase_acc_reg[31]_0\(7),
      O => \phase_acc_reg[27]_9\
    );
\sin_out[5]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"16F9E90674028BF9"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \^phase_acc_reg[31]_0\(4),
      I2 => \^phase_acc_reg[31]_0\(2),
      I3 => \^phase_acc_reg[31]_0\(0),
      I4 => \^phase_acc_reg[31]_0\(7),
      I5 => \^phase_acc_reg[31]_0\(1),
      O => \phase_acc_reg[27]_5\
    );
\sin_out[9]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E5B0282A1A4FD7D5"
    )
        port map (
      I0 => \^phase_acc_reg[31]_0\(3),
      I1 => \^phase_acc_reg[31]_0\(1),
      I2 => \^phase_acc_reg[31]_0\(0),
      I3 => \^phase_acc_reg[31]_0\(2),
      I4 => \^phase_acc_reg[31]_0\(4),
      I5 => \^phase_acc_reg[31]_0\(7),
      O => \phase_acc_reg[27]_6\
    );
\sin_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(0),
      Q => \sin_out_reg[15]_0\(0)
    );
\sin_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(10),
      Q => \sin_out_reg[15]_0\(10)
    );
\sin_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(11),
      Q => \sin_out_reg[15]_0\(11)
    );
\sin_out_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(12),
      Q => \sin_out_reg[15]_0\(12)
    );
\sin_out_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(13),
      Q => \sin_out_reg[15]_0\(13)
    );
\sin_out_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(14),
      Q => \sin_out_reg[15]_0\(14)
    );
\sin_out_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(15),
      Q => \sin_out_reg[15]_0\(15)
    );
\sin_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(1),
      Q => \sin_out_reg[15]_0\(1)
    );
\sin_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(2),
      Q => \sin_out_reg[15]_0\(2)
    );
\sin_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(3),
      Q => \sin_out_reg[15]_0\(3)
    );
\sin_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(4),
      Q => \sin_out_reg[15]_0\(4)
    );
\sin_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(5),
      Q => \sin_out_reg[15]_0\(5)
    );
\sin_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(6),
      Q => \sin_out_reg[15]_0\(6)
    );
\sin_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(7),
      Q => \sin_out_reg[15]_0\(7)
    );
\sin_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(8),
      Q => \sin_out_reg[15]_0\(8)
    );
\sin_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \cos_out_reg[0]_0\,
      D => D(9),
      Q => \sin_out_reg[15]_0\(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_core is
  port (
    timing_int1_i_2 : out STD_LOGIC;
    agc_gain_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    aresetn_0 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 0 to 0 );
    \q_mix_reg[0]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    B : out STD_LOGIC_VECTOR ( 14 downto 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    timing_err_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    M_AXIS_BITS_TDATA : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXIS_BITS_TVALID : out STD_LOGIC;
    c_locked_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    bit_count : out STD_LOGIC_VECTOR ( 39 downto 0 );
    OPMODE : in STD_LOGIC_VECTOR ( 0 to 0 );
    core_bypass_timing : in STD_LOGIC;
    core_enable : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    \sps_eff_reg[7]_0\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    core_bypass_costas : in STD_LOGIC;
    freq_int1_0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    adc_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    aclk : in STD_LOGIC;
    adc_valid : in STD_LOGIC;
    freq_word2_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    freq_int1_1 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    timing_int1_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    timing_adj2_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    core_bypass_agc : in STD_LOGIC;
    M_AXIS_BITS_TREADY : in STD_LOGIC;
    \gain_acc_reg[19]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    aresetn : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_core;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_core is
  signal A : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^b\ : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal B_0 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^e\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^m_axis_bits_tdata\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^m_axis_bits_tvalid\ : STD_LOGIC;
  signal adc_valid_d1 : STD_LOGIC;
  signal adc_valid_d10 : STD_LOGIC;
  signal \^aresetn_0\ : STD_LOGIC;
  signal \^bit_count\ : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal \bit_count[0]_i_2_n_0\ : STD_LOGIC;
  signal \bit_count_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \bit_count_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \bit_count_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \bit_count_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \bit_count_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \bit_count_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \bit_count_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \bit_count_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \bit_count_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \bit_count_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \bit_count_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \bit_count_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \bit_count_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \bit_count_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \bit_count_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \bit_count_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \bit_count_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \bit_count_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \bit_count_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \bit_count_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \bit_count_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \bit_count_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \bit_count_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \bit_count_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \bit_count_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \bit_count_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \bit_count_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \bit_count_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \bit_count_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \bit_count_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \bit_count_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \bit_count_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \bit_count_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \bit_count_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \bit_count_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \bit_count_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \bit_count_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \bit_count_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \bit_count_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \bit_count_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \bit_count_reg[28]_i_1_n_0\ : STD_LOGIC;
  signal \bit_count_reg[28]_i_1_n_1\ : STD_LOGIC;
  signal \bit_count_reg[28]_i_1_n_2\ : STD_LOGIC;
  signal \bit_count_reg[28]_i_1_n_3\ : STD_LOGIC;
  signal \bit_count_reg[28]_i_1_n_4\ : STD_LOGIC;
  signal \bit_count_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \bit_count_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \bit_count_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \bit_count_reg[32]_i_1_n_0\ : STD_LOGIC;
  signal \bit_count_reg[32]_i_1_n_1\ : STD_LOGIC;
  signal \bit_count_reg[32]_i_1_n_2\ : STD_LOGIC;
  signal \bit_count_reg[32]_i_1_n_3\ : STD_LOGIC;
  signal \bit_count_reg[32]_i_1_n_4\ : STD_LOGIC;
  signal \bit_count_reg[32]_i_1_n_5\ : STD_LOGIC;
  signal \bit_count_reg[32]_i_1_n_6\ : STD_LOGIC;
  signal \bit_count_reg[32]_i_1_n_7\ : STD_LOGIC;
  signal \bit_count_reg[36]_i_1_n_1\ : STD_LOGIC;
  signal \bit_count_reg[36]_i_1_n_2\ : STD_LOGIC;
  signal \bit_count_reg[36]_i_1_n_3\ : STD_LOGIC;
  signal \bit_count_reg[36]_i_1_n_4\ : STD_LOGIC;
  signal \bit_count_reg[36]_i_1_n_5\ : STD_LOGIC;
  signal \bit_count_reg[36]_i_1_n_6\ : STD_LOGIC;
  signal \bit_count_reg[36]_i_1_n_7\ : STD_LOGIC;
  signal \bit_count_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \bit_count_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \bit_count_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \bit_count_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \bit_count_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \bit_count_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \bit_count_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \bit_count_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \bit_count_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \bit_count_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \bit_count_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \bit_count_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \bit_count_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \bit_count_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \bit_count_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \bit_count_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal bit_idx : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \bit_idx[0]_i_1_n_0\ : STD_LOGIC;
  signal \bit_idx[1]_i_1_n_0\ : STD_LOGIC;
  signal \bit_idx[2]_i_1_n_0\ : STD_LOGIC;
  signal \bits_tdata[0]_i_1_n_0\ : STD_LOGIC;
  signal \bits_tdata[1]_i_1_n_0\ : STD_LOGIC;
  signal \bits_tdata[2]_i_1_n_0\ : STD_LOGIC;
  signal \bits_tdata[3]_i_1_n_0\ : STD_LOGIC;
  signal \bits_tdata[4]_i_1_n_0\ : STD_LOGIC;
  signal \bits_tdata[5]_i_1_n_0\ : STD_LOGIC;
  signal \bits_tdata[6]_i_1_n_0\ : STD_LOGIC;
  signal \bits_tdata[7]_i_1_n_0\ : STD_LOGIC;
  signal bits_tvalid_i_1_n_0 : STD_LOGIC;
  signal c_locked_i_1_n_0 : STD_LOGIC;
  signal c_locked_i_3_n_0 : STD_LOGIC;
  signal c_locked_i_4_n_0 : STD_LOGIC;
  signal c_locked_i_5_n_0 : STD_LOGIC;
  signal \^c_locked_reg_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal err_small : STD_LOGIC;
  signal freq_int1_n_100 : STD_LOGIC;
  signal freq_int1_n_101 : STD_LOGIC;
  signal freq_int1_n_102 : STD_LOGIC;
  signal freq_int1_n_103 : STD_LOGIC;
  signal freq_int1_n_104 : STD_LOGIC;
  signal freq_int1_n_105 : STD_LOGIC;
  signal freq_int1_n_74 : STD_LOGIC;
  signal freq_int1_n_75 : STD_LOGIC;
  signal freq_int1_n_76 : STD_LOGIC;
  signal freq_int1_n_77 : STD_LOGIC;
  signal freq_int1_n_78 : STD_LOGIC;
  signal freq_int1_n_79 : STD_LOGIC;
  signal freq_int1_n_80 : STD_LOGIC;
  signal freq_int1_n_81 : STD_LOGIC;
  signal freq_int1_n_82 : STD_LOGIC;
  signal freq_int1_n_83 : STD_LOGIC;
  signal freq_int1_n_84 : STD_LOGIC;
  signal freq_int1_n_85 : STD_LOGIC;
  signal freq_int1_n_86 : STD_LOGIC;
  signal freq_int1_n_87 : STD_LOGIC;
  signal freq_int1_n_88 : STD_LOGIC;
  signal freq_int1_n_89 : STD_LOGIC;
  signal freq_int1_n_90 : STD_LOGIC;
  signal freq_int1_n_91 : STD_LOGIC;
  signal freq_int1_n_92 : STD_LOGIC;
  signal freq_int1_n_93 : STD_LOGIC;
  signal freq_int1_n_94 : STD_LOGIC;
  signal freq_int1_n_95 : STD_LOGIC;
  signal freq_int1_n_96 : STD_LOGIC;
  signal freq_int1_n_97 : STD_LOGIC;
  signal freq_int1_n_98 : STD_LOGIC;
  signal freq_int1_n_99 : STD_LOGIC;
  signal freq_word : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal freq_word10 : STD_LOGIC;
  signal freq_word2_i_16_n_2 : STD_LOGIC;
  signal freq_word2_i_16_n_3 : STD_LOGIC;
  signal freq_word2_i_17_n_0 : STD_LOGIC;
  signal freq_word2_i_17_n_1 : STD_LOGIC;
  signal freq_word2_i_17_n_2 : STD_LOGIC;
  signal freq_word2_i_17_n_3 : STD_LOGIC;
  signal freq_word2_i_18_n_0 : STD_LOGIC;
  signal freq_word2_i_18_n_1 : STD_LOGIC;
  signal freq_word2_i_18_n_2 : STD_LOGIC;
  signal freq_word2_i_18_n_3 : STD_LOGIC;
  signal freq_word2_i_19_n_0 : STD_LOGIC;
  signal freq_word2_i_19_n_1 : STD_LOGIC;
  signal freq_word2_i_19_n_2 : STD_LOGIC;
  signal freq_word2_i_19_n_3 : STD_LOGIC;
  signal freq_word2_i_20_n_0 : STD_LOGIC;
  signal freq_word2_i_21_n_0 : STD_LOGIC;
  signal freq_word2_i_22_n_0 : STD_LOGIC;
  signal freq_word2_i_23_n_0 : STD_LOGIC;
  signal freq_word2_i_24_n_0 : STD_LOGIC;
  signal freq_word2_i_25_n_0 : STD_LOGIC;
  signal freq_word2_i_26_n_0 : STD_LOGIC;
  signal freq_word2_i_27_n_0 : STD_LOGIC;
  signal freq_word2_i_28_n_0 : STD_LOGIC;
  signal freq_word2_i_29_n_0 : STD_LOGIC;
  signal freq_word2_i_30_n_0 : STD_LOGIC;
  signal freq_word2_i_31_n_0 : STD_LOGIC;
  signal freq_word2_i_32_n_0 : STD_LOGIC;
  signal freq_word2_i_33_n_0 : STD_LOGIC;
  signal freq_word2_i_34_n_0 : STD_LOGIC;
  signal freq_word2_i_35_n_0 : STD_LOGIC;
  signal freq_word2_n_100 : STD_LOGIC;
  signal freq_word2_n_101 : STD_LOGIC;
  signal freq_word2_n_102 : STD_LOGIC;
  signal freq_word2_n_103 : STD_LOGIC;
  signal freq_word2_n_104 : STD_LOGIC;
  signal freq_word2_n_105 : STD_LOGIC;
  signal freq_word2_n_73 : STD_LOGIC;
  signal freq_word2_n_75 : STD_LOGIC;
  signal freq_word2_n_76 : STD_LOGIC;
  signal freq_word2_n_77 : STD_LOGIC;
  signal freq_word2_n_78 : STD_LOGIC;
  signal freq_word2_n_79 : STD_LOGIC;
  signal freq_word2_n_80 : STD_LOGIC;
  signal freq_word2_n_81 : STD_LOGIC;
  signal freq_word2_n_82 : STD_LOGIC;
  signal freq_word2_n_83 : STD_LOGIC;
  signal freq_word2_n_84 : STD_LOGIC;
  signal freq_word2_n_85 : STD_LOGIC;
  signal freq_word2_n_86 : STD_LOGIC;
  signal freq_word2_n_87 : STD_LOGIC;
  signal freq_word2_n_88 : STD_LOGIC;
  signal freq_word2_n_89 : STD_LOGIC;
  signal freq_word2_n_90 : STD_LOGIC;
  signal freq_word2_n_91 : STD_LOGIC;
  signal freq_word2_n_92 : STD_LOGIC;
  signal freq_word2_n_93 : STD_LOGIC;
  signal freq_word2_n_94 : STD_LOGIC;
  signal freq_word2_n_95 : STD_LOGIC;
  signal freq_word2_n_96 : STD_LOGIC;
  signal freq_word2_n_97 : STD_LOGIC;
  signal freq_word2_n_98 : STD_LOGIC;
  signal freq_word2_n_99 : STD_LOGIC;
  signal \freq_word[11]_i_2_n_0\ : STD_LOGIC;
  signal \freq_word[11]_i_3_n_0\ : STD_LOGIC;
  signal \freq_word[11]_i_4_n_0\ : STD_LOGIC;
  signal \freq_word[11]_i_5_n_0\ : STD_LOGIC;
  signal \freq_word[11]_i_6_n_0\ : STD_LOGIC;
  signal \freq_word[11]_i_7_n_0\ : STD_LOGIC;
  signal \freq_word[11]_i_8_n_0\ : STD_LOGIC;
  signal \freq_word[11]_i_9_n_0\ : STD_LOGIC;
  signal \freq_word[15]_i_2_n_0\ : STD_LOGIC;
  signal \freq_word[15]_i_3_n_0\ : STD_LOGIC;
  signal \freq_word[15]_i_4_n_0\ : STD_LOGIC;
  signal \freq_word[15]_i_5_n_0\ : STD_LOGIC;
  signal \freq_word[15]_i_6_n_0\ : STD_LOGIC;
  signal \freq_word[15]_i_7_n_0\ : STD_LOGIC;
  signal \freq_word[15]_i_8_n_0\ : STD_LOGIC;
  signal \freq_word[15]_i_9_n_0\ : STD_LOGIC;
  signal \freq_word[19]_i_2_n_0\ : STD_LOGIC;
  signal \freq_word[19]_i_3_n_0\ : STD_LOGIC;
  signal \freq_word[19]_i_4_n_0\ : STD_LOGIC;
  signal \freq_word[19]_i_5_n_0\ : STD_LOGIC;
  signal \freq_word[19]_i_6_n_0\ : STD_LOGIC;
  signal \freq_word[19]_i_7_n_0\ : STD_LOGIC;
  signal \freq_word[19]_i_8_n_0\ : STD_LOGIC;
  signal \freq_word[19]_i_9_n_0\ : STD_LOGIC;
  signal \freq_word[23]_i_2_n_0\ : STD_LOGIC;
  signal \freq_word[23]_i_3_n_0\ : STD_LOGIC;
  signal \freq_word[23]_i_4_n_0\ : STD_LOGIC;
  signal \freq_word[23]_i_5_n_0\ : STD_LOGIC;
  signal \freq_word[23]_i_6_n_0\ : STD_LOGIC;
  signal \freq_word[23]_i_7_n_0\ : STD_LOGIC;
  signal \freq_word[23]_i_8_n_0\ : STD_LOGIC;
  signal \freq_word[29]_i_2_n_0\ : STD_LOGIC;
  signal \freq_word[29]_i_3_n_0\ : STD_LOGIC;
  signal \freq_word[3]_i_2_n_0\ : STD_LOGIC;
  signal \freq_word[3]_i_3_n_0\ : STD_LOGIC;
  signal \freq_word[3]_i_4_n_0\ : STD_LOGIC;
  signal \freq_word[3]_i_5_n_0\ : STD_LOGIC;
  signal \freq_word[3]_i_6_n_0\ : STD_LOGIC;
  signal \freq_word[3]_i_7_n_0\ : STD_LOGIC;
  signal \freq_word[3]_i_8_n_0\ : STD_LOGIC;
  signal \freq_word[3]_i_9_n_0\ : STD_LOGIC;
  signal \freq_word[7]_i_2_n_0\ : STD_LOGIC;
  signal \freq_word[7]_i_3_n_0\ : STD_LOGIC;
  signal \freq_word[7]_i_4_n_0\ : STD_LOGIC;
  signal \freq_word[7]_i_5_n_0\ : STD_LOGIC;
  signal \freq_word[7]_i_6_n_0\ : STD_LOGIC;
  signal \freq_word[7]_i_7_n_0\ : STD_LOGIC;
  signal \freq_word[7]_i_8_n_0\ : STD_LOGIC;
  signal \freq_word[7]_i_9_n_0\ : STD_LOGIC;
  signal \freq_word_reg[11]_i_1_n_0\ : STD_LOGIC;
  signal \freq_word_reg[11]_i_1_n_1\ : STD_LOGIC;
  signal \freq_word_reg[11]_i_1_n_2\ : STD_LOGIC;
  signal \freq_word_reg[11]_i_1_n_3\ : STD_LOGIC;
  signal \freq_word_reg[11]_i_1_n_4\ : STD_LOGIC;
  signal \freq_word_reg[11]_i_1_n_5\ : STD_LOGIC;
  signal \freq_word_reg[11]_i_1_n_6\ : STD_LOGIC;
  signal \freq_word_reg[11]_i_1_n_7\ : STD_LOGIC;
  signal \freq_word_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal \freq_word_reg[15]_i_1_n_1\ : STD_LOGIC;
  signal \freq_word_reg[15]_i_1_n_2\ : STD_LOGIC;
  signal \freq_word_reg[15]_i_1_n_3\ : STD_LOGIC;
  signal \freq_word_reg[15]_i_1_n_4\ : STD_LOGIC;
  signal \freq_word_reg[15]_i_1_n_5\ : STD_LOGIC;
  signal \freq_word_reg[15]_i_1_n_6\ : STD_LOGIC;
  signal \freq_word_reg[15]_i_1_n_7\ : STD_LOGIC;
  signal \freq_word_reg[19]_i_1_n_0\ : STD_LOGIC;
  signal \freq_word_reg[19]_i_1_n_1\ : STD_LOGIC;
  signal \freq_word_reg[19]_i_1_n_2\ : STD_LOGIC;
  signal \freq_word_reg[19]_i_1_n_3\ : STD_LOGIC;
  signal \freq_word_reg[19]_i_1_n_4\ : STD_LOGIC;
  signal \freq_word_reg[19]_i_1_n_5\ : STD_LOGIC;
  signal \freq_word_reg[19]_i_1_n_6\ : STD_LOGIC;
  signal \freq_word_reg[19]_i_1_n_7\ : STD_LOGIC;
  signal \freq_word_reg[23]_i_1_n_0\ : STD_LOGIC;
  signal \freq_word_reg[23]_i_1_n_1\ : STD_LOGIC;
  signal \freq_word_reg[23]_i_1_n_2\ : STD_LOGIC;
  signal \freq_word_reg[23]_i_1_n_3\ : STD_LOGIC;
  signal \freq_word_reg[23]_i_1_n_4\ : STD_LOGIC;
  signal \freq_word_reg[23]_i_1_n_5\ : STD_LOGIC;
  signal \freq_word_reg[23]_i_1_n_6\ : STD_LOGIC;
  signal \freq_word_reg[23]_i_1_n_7\ : STD_LOGIC;
  signal \freq_word_reg[29]_i_1_n_3\ : STD_LOGIC;
  signal \freq_word_reg[29]_i_1_n_6\ : STD_LOGIC;
  signal \freq_word_reg[29]_i_1_n_7\ : STD_LOGIC;
  signal \freq_word_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \freq_word_reg[3]_i_1_n_1\ : STD_LOGIC;
  signal \freq_word_reg[3]_i_1_n_2\ : STD_LOGIC;
  signal \freq_word_reg[3]_i_1_n_3\ : STD_LOGIC;
  signal \freq_word_reg[3]_i_1_n_4\ : STD_LOGIC;
  signal \freq_word_reg[3]_i_1_n_5\ : STD_LOGIC;
  signal \freq_word_reg[3]_i_1_n_6\ : STD_LOGIC;
  signal \freq_word_reg[3]_i_1_n_7\ : STD_LOGIC;
  signal \freq_word_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \freq_word_reg[7]_i_1_n_1\ : STD_LOGIC;
  signal \freq_word_reg[7]_i_1_n_2\ : STD_LOGIC;
  signal \freq_word_reg[7]_i_1_n_3\ : STD_LOGIC;
  signal \freq_word_reg[7]_i_1_n_4\ : STD_LOGIC;
  signal \freq_word_reg[7]_i_1_n_5\ : STD_LOGIC;
  signal \freq_word_reg[7]_i_1_n_6\ : STD_LOGIC;
  signal \freq_word_reg[7]_i_1_n_7\ : STD_LOGIC;
  signal i_dump : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal i_dump_prev : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \i_dump_prev[14]_i_1_n_0\ : STD_LOGIC;
  signal i_mix : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \i_mix[11]_i_2_n_0\ : STD_LOGIC;
  signal \i_mix[11]_i_3_n_0\ : STD_LOGIC;
  signal \i_mix[11]_i_4_n_0\ : STD_LOGIC;
  signal \i_mix[11]_i_5_n_0\ : STD_LOGIC;
  signal \i_mix[15]_i_2_n_0\ : STD_LOGIC;
  signal \i_mix[15]_i_3_n_0\ : STD_LOGIC;
  signal \i_mix[15]_i_4_n_0\ : STD_LOGIC;
  signal \i_mix[3]_i_2_n_0\ : STD_LOGIC;
  signal \i_mix[3]_i_3_n_0\ : STD_LOGIC;
  signal \i_mix[3]_i_4_n_0\ : STD_LOGIC;
  signal \i_mix[3]_i_5_n_0\ : STD_LOGIC;
  signal \i_mix[7]_i_2_n_0\ : STD_LOGIC;
  signal \i_mix[7]_i_3_n_0\ : STD_LOGIC;
  signal \i_mix[7]_i_4_n_0\ : STD_LOGIC;
  signal \i_mix[7]_i_5_n_0\ : STD_LOGIC;
  signal i_out : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal i_prev_sign : STD_LOGIC;
  signal \integrate_acc[0]_i_2_n_0\ : STD_LOGIC;
  signal \integrate_acc[0]_i_3_n_0\ : STD_LOGIC;
  signal \integrate_acc[0]_i_4_n_0\ : STD_LOGIC;
  signal \integrate_acc[0]_i_5_n_0\ : STD_LOGIC;
  signal \integrate_acc[0]_i_6_n_0\ : STD_LOGIC;
  signal \integrate_acc[0]_i_7_n_0\ : STD_LOGIC;
  signal \integrate_acc[0]_i_8_n_0\ : STD_LOGIC;
  signal \integrate_acc[0]_i_9_n_0\ : STD_LOGIC;
  signal \integrate_acc[12]_i_2_n_0\ : STD_LOGIC;
  signal \integrate_acc[12]_i_3_n_0\ : STD_LOGIC;
  signal \integrate_acc[12]_i_4_n_0\ : STD_LOGIC;
  signal \integrate_acc[12]_i_5_n_0\ : STD_LOGIC;
  signal \integrate_acc[12]_i_6_n_0\ : STD_LOGIC;
  signal \integrate_acc[12]_i_7_n_0\ : STD_LOGIC;
  signal \integrate_acc[12]_i_8_n_0\ : STD_LOGIC;
  signal \integrate_acc[12]_i_9_n_0\ : STD_LOGIC;
  signal \integrate_acc[16]_i_2_n_0\ : STD_LOGIC;
  signal \integrate_acc[16]_i_3_n_0\ : STD_LOGIC;
  signal \integrate_acc[16]_i_4_n_0\ : STD_LOGIC;
  signal \integrate_acc[16]_i_5_n_0\ : STD_LOGIC;
  signal \integrate_acc[16]_i_6_n_0\ : STD_LOGIC;
  signal \integrate_acc[16]_i_7_n_0\ : STD_LOGIC;
  signal \integrate_acc[16]_i_8_n_0\ : STD_LOGIC;
  signal \integrate_acc[16]_i_9_n_0\ : STD_LOGIC;
  signal \integrate_acc[20]_i_2_n_0\ : STD_LOGIC;
  signal \integrate_acc[20]_i_3_n_0\ : STD_LOGIC;
  signal \integrate_acc[20]_i_4_n_0\ : STD_LOGIC;
  signal \integrate_acc[4]_i_2_n_0\ : STD_LOGIC;
  signal \integrate_acc[4]_i_3_n_0\ : STD_LOGIC;
  signal \integrate_acc[4]_i_4_n_0\ : STD_LOGIC;
  signal \integrate_acc[4]_i_5_n_0\ : STD_LOGIC;
  signal \integrate_acc[4]_i_6_n_0\ : STD_LOGIC;
  signal \integrate_acc[4]_i_7_n_0\ : STD_LOGIC;
  signal \integrate_acc[4]_i_8_n_0\ : STD_LOGIC;
  signal \integrate_acc[4]_i_9_n_0\ : STD_LOGIC;
  signal \integrate_acc[8]_i_2_n_0\ : STD_LOGIC;
  signal \integrate_acc[8]_i_3_n_0\ : STD_LOGIC;
  signal \integrate_acc[8]_i_4_n_0\ : STD_LOGIC;
  signal \integrate_acc[8]_i_5_n_0\ : STD_LOGIC;
  signal \integrate_acc[8]_i_6_n_0\ : STD_LOGIC;
  signal \integrate_acc[8]_i_7_n_0\ : STD_LOGIC;
  signal \integrate_acc[8]_i_8_n_0\ : STD_LOGIC;
  signal \integrate_acc[8]_i_9_n_0\ : STD_LOGIC;
  signal \integrate_acc_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \integrate_acc_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \integrate_acc_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \integrate_acc_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \integrate_acc_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \integrate_acc_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \integrate_acc_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \integrate_acc_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \integrate_acc_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \integrate_acc_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \integrate_acc_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \integrate_acc_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \integrate_acc_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \integrate_acc_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \integrate_acc_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \integrate_acc_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \integrate_acc_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \integrate_acc_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \integrate_acc_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \integrate_acc_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \integrate_acc_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \integrate_acc_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \integrate_acc_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \integrate_acc_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \integrate_acc_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \integrate_acc_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \integrate_acc_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \integrate_acc_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \integrate_acc_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \integrate_acc_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \integrate_acc_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \integrate_acc_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \integrate_acc_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \integrate_acc_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \integrate_acc_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \integrate_acc_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \integrate_acc_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \integrate_acc_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \integrate_acc_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \integrate_acc_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \integrate_acc_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \integrate_acc_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \integrate_acc_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \integrate_acc_reg_n_0_[0]\ : STD_LOGIC;
  signal \integrate_acc_reg_n_0_[1]\ : STD_LOGIC;
  signal \integrate_acc_reg_n_0_[2]\ : STD_LOGIC;
  signal \integrate_acc_reg_n_0_[3]\ : STD_LOGIC;
  signal \integrate_acc_reg_n_0_[4]\ : STD_LOGIC;
  signal \integrate_acc_reg_n_0_[5]\ : STD_LOGIC;
  signal \lock_cnt[5]_i_2_n_0\ : STD_LOGIC;
  signal \lock_cnt[6]_i_1_n_0\ : STD_LOGIC;
  signal lock_cnt_reg : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal mix_ii_n_100 : STD_LOGIC;
  signal mix_ii_n_101 : STD_LOGIC;
  signal mix_ii_n_102 : STD_LOGIC;
  signal mix_ii_n_103 : STD_LOGIC;
  signal mix_ii_n_104 : STD_LOGIC;
  signal mix_ii_n_105 : STD_LOGIC;
  signal mix_ii_n_74 : STD_LOGIC;
  signal mix_ii_n_91 : STD_LOGIC;
  signal mix_ii_n_92 : STD_LOGIC;
  signal mix_ii_n_93 : STD_LOGIC;
  signal mix_ii_n_94 : STD_LOGIC;
  signal mix_ii_n_95 : STD_LOGIC;
  signal mix_ii_n_96 : STD_LOGIC;
  signal mix_ii_n_97 : STD_LOGIC;
  signal mix_ii_n_98 : STD_LOGIC;
  signal mix_ii_n_99 : STD_LOGIC;
  signal mix_iq_n_100 : STD_LOGIC;
  signal mix_iq_n_101 : STD_LOGIC;
  signal mix_iq_n_102 : STD_LOGIC;
  signal mix_iq_n_103 : STD_LOGIC;
  signal mix_iq_n_104 : STD_LOGIC;
  signal mix_iq_n_105 : STD_LOGIC;
  signal mix_iq_n_74 : STD_LOGIC;
  signal mix_iq_n_91 : STD_LOGIC;
  signal mix_iq_n_92 : STD_LOGIC;
  signal mix_iq_n_93 : STD_LOGIC;
  signal mix_iq_n_94 : STD_LOGIC;
  signal mix_iq_n_95 : STD_LOGIC;
  signal mix_iq_n_96 : STD_LOGIC;
  signal mix_iq_n_97 : STD_LOGIC;
  signal mix_iq_n_98 : STD_LOGIC;
  signal mix_iq_n_99 : STD_LOGIC;
  signal \mix_qi__0\ : STD_LOGIC_VECTOR ( 30 downto 15 );
  signal mix_qi_n_100 : STD_LOGIC;
  signal mix_qi_n_101 : STD_LOGIC;
  signal mix_qi_n_102 : STD_LOGIC;
  signal mix_qi_n_103 : STD_LOGIC;
  signal mix_qi_n_104 : STD_LOGIC;
  signal mix_qi_n_105 : STD_LOGIC;
  signal mix_qi_n_74 : STD_LOGIC;
  signal mix_qi_n_91 : STD_LOGIC;
  signal mix_qi_n_92 : STD_LOGIC;
  signal mix_qi_n_93 : STD_LOGIC;
  signal mix_qi_n_94 : STD_LOGIC;
  signal mix_qi_n_95 : STD_LOGIC;
  signal mix_qi_n_96 : STD_LOGIC;
  signal mix_qi_n_97 : STD_LOGIC;
  signal mix_qi_n_98 : STD_LOGIC;
  signal mix_qi_n_99 : STD_LOGIC;
  signal \mix_qq__0\ : STD_LOGIC_VECTOR ( 30 downto 15 );
  signal mix_qq_n_100 : STD_LOGIC;
  signal mix_qq_n_101 : STD_LOGIC;
  signal mix_qq_n_102 : STD_LOGIC;
  signal mix_qq_n_103 : STD_LOGIC;
  signal mix_qq_n_104 : STD_LOGIC;
  signal mix_qq_n_105 : STD_LOGIC;
  signal mix_qq_n_74 : STD_LOGIC;
  signal mix_qq_n_91 : STD_LOGIC;
  signal mix_qq_n_92 : STD_LOGIC;
  signal mix_qq_n_93 : STD_LOGIC;
  signal mix_qq_n_94 : STD_LOGIC;
  signal mix_qq_n_95 : STD_LOGIC;
  signal mix_qq_n_96 : STD_LOGIC;
  signal mix_qq_n_97 : STD_LOGIC;
  signal mix_qq_n_98 : STD_LOGIC;
  signal mix_qq_n_99 : STD_LOGIC;
  signal \out\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal p_0_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal p_0_in0 : STD_LOGIC;
  signal \p_0_in__0\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal p_0_out : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \p_0_out_inferred__1/cos_out[0]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[0]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[10]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[10]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[11]_i_4_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[11]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[11]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[11]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[12]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[12]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[12]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[13]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[13]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[13]_i_4_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[13]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[14]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[14]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[14]_i_4_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[14]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[15]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[1]_i_4_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[1]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[1]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[1]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[2]_i_4_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[2]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[2]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[2]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[3]_i_4_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[3]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[3]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[3]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[4]_i_4_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[4]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[4]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[4]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[5]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[5]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[5]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[6]_i_4_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[6]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[6]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[6]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[7]_i_4_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[7]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[7]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[7]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[8]_i_4_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[8]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[8]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[8]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[9]_i_5_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[9]_i_6_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out[9]_i_7_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[10]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[10]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[11]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[11]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[12]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[1]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[1]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[2]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[2]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[3]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[3]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[4]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[5]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[5]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[6]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[6]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[7]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[7]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[8]_i_3_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[9]_i_2_n_0\ : STD_LOGIC;
  signal \p_0_out_inferred__1/cos_out_reg[9]_i_3_n_0\ : STD_LOGIC;
  signal phase_err_p0 : STD_LOGIC_VECTOR ( 15 downto 1 );
  signal q_mix : STD_LOGIC_VECTOR ( 15 downto 1 );
  signal \q_mix[11]_i_11_n_0\ : STD_LOGIC;
  signal \q_mix[11]_i_12_n_0\ : STD_LOGIC;
  signal \q_mix[11]_i_13_n_0\ : STD_LOGIC;
  signal \q_mix[11]_i_14_n_0\ : STD_LOGIC;
  signal \q_mix[11]_i_2_n_0\ : STD_LOGIC;
  signal \q_mix[11]_i_3_n_0\ : STD_LOGIC;
  signal \q_mix[11]_i_4_n_0\ : STD_LOGIC;
  signal \q_mix[11]_i_5_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_11_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_12_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_13_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_14_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_15_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_16_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_17_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_2_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_3_n_0\ : STD_LOGIC;
  signal \q_mix[15]_i_4_n_0\ : STD_LOGIC;
  signal \q_mix[3]_i_2_n_0\ : STD_LOGIC;
  signal \q_mix[3]_i_3_n_0\ : STD_LOGIC;
  signal \q_mix[3]_i_4_n_0\ : STD_LOGIC;
  signal \q_mix[3]_i_5_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_11_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_12_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_13_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_14_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_15_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_2_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_3_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_4_n_0\ : STD_LOGIC;
  signal \q_mix[7]_i_5_n_0\ : STD_LOGIC;
  signal \^q_mix_reg[0]_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \q_mix_reg[11]_i_10_n_0\ : STD_LOGIC;
  signal \q_mix_reg[11]_i_10_n_1\ : STD_LOGIC;
  signal \q_mix_reg[11]_i_10_n_2\ : STD_LOGIC;
  signal \q_mix_reg[11]_i_10_n_3\ : STD_LOGIC;
  signal \q_mix_reg[11]_i_10_n_4\ : STD_LOGIC;
  signal \q_mix_reg[11]_i_10_n_5\ : STD_LOGIC;
  signal \q_mix_reg[11]_i_10_n_6\ : STD_LOGIC;
  signal \q_mix_reg[11]_i_10_n_7\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_10_n_0\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_10_n_1\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_10_n_2\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_10_n_3\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_10_n_4\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_10_n_5\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_10_n_6\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_10_n_7\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_9_n_2\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_9_n_3\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_9_n_5\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_9_n_6\ : STD_LOGIC;
  signal \q_mix_reg[15]_i_9_n_7\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_10_n_0\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_10_n_1\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_10_n_2\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_10_n_3\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_10_n_4\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_10_n_5\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_10_n_6\ : STD_LOGIC;
  signal \q_mix_reg[7]_i_10_n_7\ : STD_LOGIC;
  signal q_out : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal sel : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \sin_out[0]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out[0]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out[10]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[10]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[11]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[11]_i_5_n_0\ : STD_LOGIC;
  signal \sin_out[11]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[11]_i_7_n_0\ : STD_LOGIC;
  signal \sin_out[12]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[12]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[12]_i_7_n_0\ : STD_LOGIC;
  signal \sin_out[13]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out[13]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out[13]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out[13]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[13]_i_5_n_0\ : STD_LOGIC;
  signal \sin_out[13]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[14]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out[14]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out[14]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[14]_i_5_n_0\ : STD_LOGIC;
  signal \sin_out[15]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out[15]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out[1]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[1]_i_5_n_0\ : STD_LOGIC;
  signal \sin_out[1]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[1]_i_7_n_0\ : STD_LOGIC;
  signal \sin_out[2]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[2]_i_5_n_0\ : STD_LOGIC;
  signal \sin_out[2]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[2]_i_7_n_0\ : STD_LOGIC;
  signal \sin_out[3]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[3]_i_5_n_0\ : STD_LOGIC;
  signal \sin_out[3]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[3]_i_7_n_0\ : STD_LOGIC;
  signal \sin_out[4]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[4]_i_5_n_0\ : STD_LOGIC;
  signal \sin_out[4]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[4]_i_7_n_0\ : STD_LOGIC;
  signal \sin_out[5]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[5]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[5]_i_7_n_0\ : STD_LOGIC;
  signal \sin_out[6]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[6]_i_5_n_0\ : STD_LOGIC;
  signal \sin_out[6]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[6]_i_7_n_0\ : STD_LOGIC;
  signal \sin_out[7]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[7]_i_5_n_0\ : STD_LOGIC;
  signal \sin_out[7]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[7]_i_7_n_0\ : STD_LOGIC;
  signal \sin_out[8]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[8]_i_5_n_0\ : STD_LOGIC;
  signal \sin_out[8]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[8]_i_7_n_0\ : STD_LOGIC;
  signal \sin_out[9]_i_4_n_0\ : STD_LOGIC;
  signal \sin_out[9]_i_6_n_0\ : STD_LOGIC;
  signal \sin_out[9]_i_7_n_0\ : STD_LOGIC;
  signal \sin_out_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[10]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[10]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[10]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out_reg[11]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[11]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[11]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[12]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out_reg[14]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[1]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[1]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[1]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out_reg[2]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[2]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[2]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[3]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[3]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[4]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out_reg[5]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[5]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[5]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out_reg[6]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[6]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[6]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[7]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[7]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[8]_i_3_n_0\ : STD_LOGIC;
  signal \sin_out_reg[9]_i_1_n_0\ : STD_LOGIC;
  signal \sin_out_reg[9]_i_2_n_0\ : STD_LOGIC;
  signal \sin_out_reg[9]_i_3_n_0\ : STD_LOGIC;
  signal sps_counter0 : STD_LOGIC;
  signal sps_counter1 : STD_LOGIC;
  signal \sps_counter1_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \sps_counter1_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \sps_counter1_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \sps_counter1_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \sps_counter1_carry__0_n_0\ : STD_LOGIC;
  signal \sps_counter1_carry__0_n_1\ : STD_LOGIC;
  signal \sps_counter1_carry__0_n_2\ : STD_LOGIC;
  signal \sps_counter1_carry__0_n_3\ : STD_LOGIC;
  signal \sps_counter1_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \sps_counter1_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \sps_counter1_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \sps_counter1_carry__1_n_2\ : STD_LOGIC;
  signal \sps_counter1_carry__1_n_3\ : STD_LOGIC;
  signal sps_counter1_carry_i_1_n_0 : STD_LOGIC;
  signal sps_counter1_carry_i_2_n_0 : STD_LOGIC;
  signal sps_counter1_carry_i_3_n_0 : STD_LOGIC;
  signal sps_counter1_carry_i_4_n_0 : STD_LOGIC;
  signal sps_counter1_carry_i_5_n_0 : STD_LOGIC;
  signal sps_counter1_carry_i_6_n_0 : STD_LOGIC;
  signal sps_counter1_carry_i_7_n_0 : STD_LOGIC;
  signal sps_counter1_carry_n_0 : STD_LOGIC;
  signal sps_counter1_carry_n_1 : STD_LOGIC;
  signal sps_counter1_carry_n_2 : STD_LOGIC;
  signal sps_counter1_carry_n_3 : STD_LOGIC;
  signal \sps_counter[2]_i_1_n_0\ : STD_LOGIC;
  signal \sps_counter[3]_i_1_n_0\ : STD_LOGIC;
  signal \sps_counter[4]_i_1_n_0\ : STD_LOGIC;
  signal \sps_counter[5]_i_1_n_0\ : STD_LOGIC;
  signal \sps_counter[5]_i_2_n_0\ : STD_LOGIC;
  signal \sps_counter[6]_i_1_n_0\ : STD_LOGIC;
  signal \sps_counter[7]_i_3_n_0\ : STD_LOGIC;
  signal sps_counter_reg : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal sps_eff : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \sps_eff[0]_i_1_n_0\ : STD_LOGIC;
  signal \sps_eff[1]_i_1_n_0\ : STD_LOGIC;
  signal \sps_eff[1]_i_2_n_0\ : STD_LOGIC;
  signal \sps_eff[1]_i_3_n_0\ : STD_LOGIC;
  signal \sps_eff[2]_i_1_n_0\ : STD_LOGIC;
  signal \sps_eff[2]_i_2_n_0\ : STD_LOGIC;
  signal \sps_eff[3]_i_1_n_0\ : STD_LOGIC;
  signal \sps_eff[3]_i_2_n_0\ : STD_LOGIC;
  signal \sps_eff[3]_i_3_n_0\ : STD_LOGIC;
  signal \sps_eff[4]_i_1_n_0\ : STD_LOGIC;
  signal \sps_eff[4]_i_2_n_0\ : STD_LOGIC;
  signal \sps_eff[5]_i_1_n_0\ : STD_LOGIC;
  signal \sps_eff[5]_i_2_n_0\ : STD_LOGIC;
  signal \sps_eff[5]_i_3_n_0\ : STD_LOGIC;
  signal \sps_eff[5]_i_4_n_0\ : STD_LOGIC;
  signal \sps_eff[5]_i_5_n_0\ : STD_LOGIC;
  signal \sps_eff[5]_i_6_n_0\ : STD_LOGIC;
  signal \sps_eff[6]_i_1_n_0\ : STD_LOGIC;
  signal \sps_eff[6]_i_2_n_0\ : STD_LOGIC;
  signal \sps_eff[6]_i_3_n_0\ : STD_LOGIC;
  signal \sps_eff[6]_i_4_n_0\ : STD_LOGIC;
  signal \sps_eff[7]_i_1_n_0\ : STD_LOGIC;
  signal \sps_eff[7]_i_2_n_0\ : STD_LOGIC;
  signal timing_adj1 : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal timing_adj2_n_100 : STD_LOGIC;
  signal timing_adj2_n_101 : STD_LOGIC;
  signal timing_adj2_n_102 : STD_LOGIC;
  signal timing_adj2_n_103 : STD_LOGIC;
  signal timing_adj2_n_104 : STD_LOGIC;
  signal timing_adj2_n_105 : STD_LOGIC;
  signal timing_adj2_n_74 : STD_LOGIC;
  signal timing_adj2_n_75 : STD_LOGIC;
  signal timing_adj2_n_76 : STD_LOGIC;
  signal timing_adj2_n_77 : STD_LOGIC;
  signal timing_adj2_n_78 : STD_LOGIC;
  signal timing_adj2_n_79 : STD_LOGIC;
  signal timing_adj2_n_80 : STD_LOGIC;
  signal timing_adj2_n_81 : STD_LOGIC;
  signal timing_adj2_n_82 : STD_LOGIC;
  signal timing_adj2_n_83 : STD_LOGIC;
  signal timing_adj2_n_84 : STD_LOGIC;
  signal timing_adj2_n_85 : STD_LOGIC;
  signal timing_adj2_n_86 : STD_LOGIC;
  signal timing_adj2_n_87 : STD_LOGIC;
  signal timing_adj2_n_88 : STD_LOGIC;
  signal timing_adj2_n_98 : STD_LOGIC;
  signal timing_adj2_n_99 : STD_LOGIC;
  signal \timing_adj[0]_i_2_n_0\ : STD_LOGIC;
  signal \timing_adj[0]_i_3_n_0\ : STD_LOGIC;
  signal \timing_adj[0]_i_4_n_0\ : STD_LOGIC;
  signal \timing_adj[0]_i_5_n_0\ : STD_LOGIC;
  signal \timing_adj[8]_i_3_n_0\ : STD_LOGIC;
  signal \timing_adj[8]_i_4_n_0\ : STD_LOGIC;
  signal \timing_adj[8]_i_5_n_0\ : STD_LOGIC;
  signal \timing_adj[8]_i_6_n_0\ : STD_LOGIC;
  signal \timing_adj[8]_i_7_n_0\ : STD_LOGIC;
  signal \timing_adj_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \timing_adj_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \timing_adj_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \timing_adj_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \timing_adj_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \timing_adj_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \timing_adj_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \timing_adj_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \timing_adj_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \timing_adj_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal \timing_adj_reg_n_0_[0]\ : STD_LOGIC;
  signal \timing_adj_reg_n_0_[8]\ : STD_LOGIC;
  signal \timing_err__0_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__0_i_5_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__0_i_6_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__0_i_7_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__0_i_8_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__0_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__0_n_1\ : STD_LOGIC;
  signal \timing_err__0_carry__0_n_2\ : STD_LOGIC;
  signal \timing_err__0_carry__0_n_3\ : STD_LOGIC;
  signal \timing_err__0_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__1_i_5_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__1_i_6_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__1_i_7_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__1_i_8_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__1_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__1_n_1\ : STD_LOGIC;
  signal \timing_err__0_carry__1_n_2\ : STD_LOGIC;
  signal \timing_err__0_carry__1_n_3\ : STD_LOGIC;
  signal \timing_err__0_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__2_i_5_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__2_i_6_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__2_i_7_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry__2_n_1\ : STD_LOGIC;
  signal \timing_err__0_carry__2_n_2\ : STD_LOGIC;
  signal \timing_err__0_carry__2_n_3\ : STD_LOGIC;
  signal \timing_err__0_carry_i_1_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry_i_2_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry_i_3_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry_i_4_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry_i_5_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry_i_6_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry_i_7_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry_n_0\ : STD_LOGIC;
  signal \timing_err__0_carry_n_1\ : STD_LOGIC;
  signal \timing_err__0_carry_n_2\ : STD_LOGIC;
  signal \timing_err__0_carry_n_3\ : STD_LOGIC;
  signal \^timing_err_out\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal timing_int : STD_LOGIC;
  signal timing_int1_n_100 : STD_LOGIC;
  signal timing_int1_n_101 : STD_LOGIC;
  signal timing_int1_n_102 : STD_LOGIC;
  signal timing_int1_n_103 : STD_LOGIC;
  signal timing_int1_n_104 : STD_LOGIC;
  signal timing_int1_n_105 : STD_LOGIC;
  signal timing_int1_n_75 : STD_LOGIC;
  signal timing_int1_n_76 : STD_LOGIC;
  signal timing_int1_n_77 : STD_LOGIC;
  signal timing_int1_n_78 : STD_LOGIC;
  signal timing_int1_n_79 : STD_LOGIC;
  signal timing_int1_n_80 : STD_LOGIC;
  signal timing_int1_n_81 : STD_LOGIC;
  signal timing_int1_n_82 : STD_LOGIC;
  signal timing_int1_n_83 : STD_LOGIC;
  signal timing_int1_n_84 : STD_LOGIC;
  signal timing_int1_n_85 : STD_LOGIC;
  signal timing_int1_n_86 : STD_LOGIC;
  signal timing_int1_n_87 : STD_LOGIC;
  signal timing_int1_n_88 : STD_LOGIC;
  signal timing_int1_n_89 : STD_LOGIC;
  signal timing_int1_n_90 : STD_LOGIC;
  signal timing_int1_n_91 : STD_LOGIC;
  signal timing_int1_n_92 : STD_LOGIC;
  signal timing_int1_n_93 : STD_LOGIC;
  signal timing_int1_n_94 : STD_LOGIC;
  signal timing_int1_n_95 : STD_LOGIC;
  signal timing_int1_n_96 : STD_LOGIC;
  signal timing_int1_n_97 : STD_LOGIC;
  signal timing_int1_n_98 : STD_LOGIC;
  signal timing_int1_n_99 : STD_LOGIC;
  signal u_agc_n_17 : STD_LOGIC;
  signal u_agc_n_18 : STD_LOGIC;
  signal u_agc_n_19 : STD_LOGIC;
  signal u_agc_n_20 : STD_LOGIC;
  signal u_agc_n_21 : STD_LOGIC;
  signal u_agc_n_22 : STD_LOGIC;
  signal u_agc_n_23 : STD_LOGIC;
  signal u_agc_n_24 : STD_LOGIC;
  signal u_agc_n_25 : STD_LOGIC;
  signal u_agc_n_26 : STD_LOGIC;
  signal u_agc_n_27 : STD_LOGIC;
  signal u_agc_n_28 : STD_LOGIC;
  signal u_agc_n_29 : STD_LOGIC;
  signal u_agc_n_30 : STD_LOGIC;
  signal u_agc_n_31 : STD_LOGIC;
  signal u_agc_n_32 : STD_LOGIC;
  signal u_agc_n_66 : STD_LOGIC;
  signal u_agc_n_67 : STD_LOGIC;
  signal u_agc_n_68 : STD_LOGIC;
  signal u_agc_n_69 : STD_LOGIC;
  signal u_agc_n_70 : STD_LOGIC;
  signal u_agc_n_71 : STD_LOGIC;
  signal u_agc_n_72 : STD_LOGIC;
  signal u_agc_n_73 : STD_LOGIC;
  signal u_agc_n_74 : STD_LOGIC;
  signal u_agc_n_75 : STD_LOGIC;
  signal u_agc_n_76 : STD_LOGIC;
  signal u_agc_n_77 : STD_LOGIC;
  signal u_agc_n_78 : STD_LOGIC;
  signal u_agc_n_79 : STD_LOGIC;
  signal u_agc_n_80 : STD_LOGIC;
  signal u_agc_n_81 : STD_LOGIC;
  signal u_nco_n_24 : STD_LOGIC;
  signal u_nco_n_25 : STD_LOGIC;
  signal u_nco_n_26 : STD_LOGIC;
  signal u_nco_n_27 : STD_LOGIC;
  signal u_nco_n_28 : STD_LOGIC;
  signal u_nco_n_29 : STD_LOGIC;
  signal u_nco_n_30 : STD_LOGIC;
  signal u_nco_n_31 : STD_LOGIC;
  signal u_nco_n_32 : STD_LOGIC;
  signal u_nco_n_33 : STD_LOGIC;
  signal u_nco_n_34 : STD_LOGIC;
  signal u_nco_n_35 : STD_LOGIC;
  signal u_nco_n_36 : STD_LOGIC;
  signal u_nco_n_37 : STD_LOGIC;
  signal u_nco_n_38 : STD_LOGIC;
  signal u_nco_n_39 : STD_LOGIC;
  signal u_nco_n_40 : STD_LOGIC;
  signal u_nco_n_41 : STD_LOGIC;
  signal u_nco_n_42 : STD_LOGIC;
  signal u_nco_n_43 : STD_LOGIC;
  signal u_nco_n_44 : STD_LOGIC;
  signal u_nco_n_45 : STD_LOGIC;
  signal u_nco_n_46 : STD_LOGIC;
  signal u_nco_n_47 : STD_LOGIC;
  signal u_nco_n_48 : STD_LOGIC;
  signal u_nco_n_49 : STD_LOGIC;
  signal \NLW_bit_count_reg[36]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_freq_int1_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_int1_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_int1_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_int1_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_int1_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_int1_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_int1_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_freq_int1_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_freq_int1_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_freq_int1_P_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 32 );
  signal NLW_freq_int1_PCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal NLW_freq_word2_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_word2_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_word2_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_word2_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_word2_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_word2_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_freq_word2_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_freq_word2_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_freq_word2_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_freq_word2_P_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 33 );
  signal NLW_freq_word2_PCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal NLW_freq_word2_i_16_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_freq_word2_i_16_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_freq_word_reg[29]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_freq_word_reg[29]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_integrate_acc_reg[20]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_integrate_acc_reg[20]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_mix_ii_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_ii_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_ii_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_ii_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_ii_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_ii_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_ii_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_mix_ii_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_mix_ii_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_mix_ii_P_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 32 );
  signal NLW_mix_ii_PCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal NLW_mix_iq_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_iq_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_iq_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_iq_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_iq_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_iq_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_iq_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_mix_iq_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_mix_iq_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_mix_iq_P_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 32 );
  signal NLW_mix_iq_PCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal NLW_mix_qi_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qi_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qi_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qi_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qi_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qi_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qi_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_mix_qi_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_mix_qi_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_mix_qi_P_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 32 );
  signal NLW_mix_qi_PCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal NLW_mix_qq_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qq_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qq_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qq_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qq_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qq_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_mix_qq_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_mix_qq_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_mix_qq_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_mix_qq_P_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 32 );
  signal NLW_mix_qq_PCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal \NLW_q_mix_reg[15]_i_9_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_q_mix_reg[15]_i_9_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_sps_counter1_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_sps_counter1_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_sps_counter1_carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_sps_counter1_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_timing_adj2_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_adj2_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_adj2_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_adj2_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_adj2_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_adj2_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_adj2_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_timing_adj2_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_timing_adj2_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_timing_adj2_P_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 32 );
  signal NLW_timing_adj2_PCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal \NLW_timing_adj_reg[0]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_timing_adj_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_timing_adj_reg[8]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_timing_adj_reg[8]_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_timing_err__0_carry__2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_timing_int1_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_int1_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_int1_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_int1_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_int1_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_int1_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_timing_int1_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_timing_int1_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_timing_int1_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_timing_int1_P_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 32 );
  signal NLW_timing_int1_PCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \bit_count_reg[0]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \bit_count_reg[12]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \bit_count_reg[16]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \bit_count_reg[20]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \bit_count_reg[24]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \bit_count_reg[28]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \bit_count_reg[32]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \bit_count_reg[36]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \bit_count_reg[4]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \bit_count_reg[8]_i_1\ : label is 11;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \bit_idx[1]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \bit_idx[2]_i_1\ : label is "soft_lutpair30";
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of freq_int1 : label is "{SYNTH-12 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of freq_word2 : label is "{SYNTH-13 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of freq_word2_i_16 : label is 35;
  attribute ADDER_THRESHOLD of freq_word2_i_17 : label is 35;
  attribute ADDER_THRESHOLD of freq_word2_i_18 : label is 35;
  attribute ADDER_THRESHOLD of freq_word2_i_19 : label is 35;
  attribute ADDER_THRESHOLD of \integrate_acc_reg[0]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \integrate_acc_reg[12]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \integrate_acc_reg[16]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \integrate_acc_reg[20]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \integrate_acc_reg[4]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \integrate_acc_reg[8]_i_1\ : label is 11;
  attribute SOFT_HLUTNM of \lock_cnt[2]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \lock_cnt[3]_i_1\ : label is "soft_lutpair16";
  attribute METHODOLOGY_DRC_VIOS of mix_ii : label is "{SYNTH-13 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of mix_iq : label is "{SYNTH-13 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of mix_qi : label is "{SYNTH-13 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of mix_qq : label is "{SYNTH-13 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \p_0_out_inferred__1/cos_out[13]_i_5\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \p_0_out_inferred__1/cos_out[14]_i_4\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \p_0_out_inferred__1/cos_out[14]_i_5\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \p_0_out_inferred__1/cos_out[15]_i_2\ : label is "soft_lutpair26";
  attribute ADDER_THRESHOLD of \q_mix_reg[11]_i_10\ : label is 35;
  attribute ADDER_THRESHOLD of \q_mix_reg[15]_i_10\ : label is 35;
  attribute ADDER_THRESHOLD of \q_mix_reg[15]_i_9\ : label is 35;
  attribute ADDER_THRESHOLD of \q_mix_reg[7]_i_10\ : label is 35;
  attribute SOFT_HLUTNM of \sin_out[13]_i_3\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \sin_out[13]_i_5\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \sin_out[13]_i_6\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \sin_out[14]_i_4\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \sin_out[14]_i_5\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \sin_out[15]_i_2\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of sps_counter1_carry_i_6 : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of sps_counter1_carry_i_7 : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \sps_counter[1]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \sps_counter[2]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \sps_counter[3]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \sps_counter[5]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \sps_counter[6]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \sps_counter[7]_i_2\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \sps_eff[0]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \sps_eff[1]_i_2\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \sps_eff[3]_i_2\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \sps_eff[4]_i_2\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \sps_eff[5]_i_2\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \sps_eff[5]_i_3\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \sps_eff[5]_i_6\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \sps_eff[6]_i_2\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \sps_eff[6]_i_3\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \sps_eff[6]_i_4\ : label is "soft_lutpair24";
  attribute METHODOLOGY_DRC_VIOS of timing_adj2 : label is "{SYNTH-13 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \timing_adj_reg[0]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \timing_adj_reg[8]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \timing_adj_reg[8]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \timing_err__0_carry\ : label is 35;
  attribute ADDER_THRESHOLD of \timing_err__0_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \timing_err__0_carry__1\ : label is 35;
  attribute ADDER_THRESHOLD of \timing_err__0_carry__2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of timing_int1 : label is "{SYNTH-12 {cell *THIS*}}";
begin
  B(14 downto 0) <= \^b\(14 downto 0);
  E(0) <= \^e\(0);
  M_AXIS_BITS_TDATA(7 downto 0) <= \^m_axis_bits_tdata\(7 downto 0);
  M_AXIS_BITS_TVALID <= \^m_axis_bits_tvalid\;
  aresetn_0 <= \^aresetn_0\;
  bit_count(39 downto 0) <= \^bit_count\(39 downto 0);
  c_locked_reg_0(0) <= \^c_locked_reg_0\(0);
  \q_mix_reg[0]_0\(0) <= \^q_mix_reg[0]_0\(0);
  timing_err_out(15 downto 0) <= \^timing_err_out\(15 downto 0);
adc_valid_d1_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => adc_valid_d10,
      Q => adc_valid_d1,
      R => '0'
    );
\bit_count[0]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^bit_count\(0),
      O => \bit_count[0]_i_2_n_0\
    );
\bit_count_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[0]_i_1_n_7\,
      Q => \^bit_count\(0)
    );
\bit_count_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \bit_count_reg[0]_i_1_n_0\,
      CO(2) => \bit_count_reg[0]_i_1_n_1\,
      CO(1) => \bit_count_reg[0]_i_1_n_2\,
      CO(0) => \bit_count_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \bit_count_reg[0]_i_1_n_4\,
      O(2) => \bit_count_reg[0]_i_1_n_5\,
      O(1) => \bit_count_reg[0]_i_1_n_6\,
      O(0) => \bit_count_reg[0]_i_1_n_7\,
      S(3 downto 1) => \^bit_count\(3 downto 1),
      S(0) => \bit_count[0]_i_2_n_0\
    );
\bit_count_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[8]_i_1_n_5\,
      Q => \^bit_count\(10)
    );
\bit_count_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[8]_i_1_n_4\,
      Q => \^bit_count\(11)
    );
\bit_count_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[12]_i_1_n_7\,
      Q => \^bit_count\(12)
    );
\bit_count_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \bit_count_reg[8]_i_1_n_0\,
      CO(3) => \bit_count_reg[12]_i_1_n_0\,
      CO(2) => \bit_count_reg[12]_i_1_n_1\,
      CO(1) => \bit_count_reg[12]_i_1_n_2\,
      CO(0) => \bit_count_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \bit_count_reg[12]_i_1_n_4\,
      O(2) => \bit_count_reg[12]_i_1_n_5\,
      O(1) => \bit_count_reg[12]_i_1_n_6\,
      O(0) => \bit_count_reg[12]_i_1_n_7\,
      S(3 downto 0) => \^bit_count\(15 downto 12)
    );
\bit_count_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[12]_i_1_n_6\,
      Q => \^bit_count\(13)
    );
\bit_count_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[12]_i_1_n_5\,
      Q => \^bit_count\(14)
    );
\bit_count_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[12]_i_1_n_4\,
      Q => \^bit_count\(15)
    );
\bit_count_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[16]_i_1_n_7\,
      Q => \^bit_count\(16)
    );
\bit_count_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \bit_count_reg[12]_i_1_n_0\,
      CO(3) => \bit_count_reg[16]_i_1_n_0\,
      CO(2) => \bit_count_reg[16]_i_1_n_1\,
      CO(1) => \bit_count_reg[16]_i_1_n_2\,
      CO(0) => \bit_count_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \bit_count_reg[16]_i_1_n_4\,
      O(2) => \bit_count_reg[16]_i_1_n_5\,
      O(1) => \bit_count_reg[16]_i_1_n_6\,
      O(0) => \bit_count_reg[16]_i_1_n_7\,
      S(3 downto 0) => \^bit_count\(19 downto 16)
    );
\bit_count_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[16]_i_1_n_6\,
      Q => \^bit_count\(17)
    );
\bit_count_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[16]_i_1_n_5\,
      Q => \^bit_count\(18)
    );
\bit_count_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[16]_i_1_n_4\,
      Q => \^bit_count\(19)
    );
\bit_count_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[0]_i_1_n_6\,
      Q => \^bit_count\(1)
    );
\bit_count_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[20]_i_1_n_7\,
      Q => \^bit_count\(20)
    );
\bit_count_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \bit_count_reg[16]_i_1_n_0\,
      CO(3) => \bit_count_reg[20]_i_1_n_0\,
      CO(2) => \bit_count_reg[20]_i_1_n_1\,
      CO(1) => \bit_count_reg[20]_i_1_n_2\,
      CO(0) => \bit_count_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \bit_count_reg[20]_i_1_n_4\,
      O(2) => \bit_count_reg[20]_i_1_n_5\,
      O(1) => \bit_count_reg[20]_i_1_n_6\,
      O(0) => \bit_count_reg[20]_i_1_n_7\,
      S(3 downto 0) => \^bit_count\(23 downto 20)
    );
\bit_count_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[20]_i_1_n_6\,
      Q => \^bit_count\(21)
    );
\bit_count_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[20]_i_1_n_5\,
      Q => \^bit_count\(22)
    );
\bit_count_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[20]_i_1_n_4\,
      Q => \^bit_count\(23)
    );
\bit_count_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[24]_i_1_n_7\,
      Q => \^bit_count\(24)
    );
\bit_count_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \bit_count_reg[20]_i_1_n_0\,
      CO(3) => \bit_count_reg[24]_i_1_n_0\,
      CO(2) => \bit_count_reg[24]_i_1_n_1\,
      CO(1) => \bit_count_reg[24]_i_1_n_2\,
      CO(0) => \bit_count_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \bit_count_reg[24]_i_1_n_4\,
      O(2) => \bit_count_reg[24]_i_1_n_5\,
      O(1) => \bit_count_reg[24]_i_1_n_6\,
      O(0) => \bit_count_reg[24]_i_1_n_7\,
      S(3 downto 0) => \^bit_count\(27 downto 24)
    );
\bit_count_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[24]_i_1_n_6\,
      Q => \^bit_count\(25)
    );
\bit_count_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[24]_i_1_n_5\,
      Q => \^bit_count\(26)
    );
\bit_count_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[24]_i_1_n_4\,
      Q => \^bit_count\(27)
    );
\bit_count_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[28]_i_1_n_7\,
      Q => \^bit_count\(28)
    );
\bit_count_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \bit_count_reg[24]_i_1_n_0\,
      CO(3) => \bit_count_reg[28]_i_1_n_0\,
      CO(2) => \bit_count_reg[28]_i_1_n_1\,
      CO(1) => \bit_count_reg[28]_i_1_n_2\,
      CO(0) => \bit_count_reg[28]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \bit_count_reg[28]_i_1_n_4\,
      O(2) => \bit_count_reg[28]_i_1_n_5\,
      O(1) => \bit_count_reg[28]_i_1_n_6\,
      O(0) => \bit_count_reg[28]_i_1_n_7\,
      S(3 downto 0) => \^bit_count\(31 downto 28)
    );
\bit_count_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[28]_i_1_n_6\,
      Q => \^bit_count\(29)
    );
\bit_count_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[0]_i_1_n_5\,
      Q => \^bit_count\(2)
    );
\bit_count_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[28]_i_1_n_5\,
      Q => \^bit_count\(30)
    );
\bit_count_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[28]_i_1_n_4\,
      Q => \^bit_count\(31)
    );
\bit_count_reg[32]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[32]_i_1_n_7\,
      Q => \^bit_count\(32)
    );
\bit_count_reg[32]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \bit_count_reg[28]_i_1_n_0\,
      CO(3) => \bit_count_reg[32]_i_1_n_0\,
      CO(2) => \bit_count_reg[32]_i_1_n_1\,
      CO(1) => \bit_count_reg[32]_i_1_n_2\,
      CO(0) => \bit_count_reg[32]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \bit_count_reg[32]_i_1_n_4\,
      O(2) => \bit_count_reg[32]_i_1_n_5\,
      O(1) => \bit_count_reg[32]_i_1_n_6\,
      O(0) => \bit_count_reg[32]_i_1_n_7\,
      S(3 downto 0) => \^bit_count\(35 downto 32)
    );
\bit_count_reg[33]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[32]_i_1_n_6\,
      Q => \^bit_count\(33)
    );
\bit_count_reg[34]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[32]_i_1_n_5\,
      Q => \^bit_count\(34)
    );
\bit_count_reg[35]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[32]_i_1_n_4\,
      Q => \^bit_count\(35)
    );
\bit_count_reg[36]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[36]_i_1_n_7\,
      Q => \^bit_count\(36)
    );
\bit_count_reg[36]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \bit_count_reg[32]_i_1_n_0\,
      CO(3) => \NLW_bit_count_reg[36]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \bit_count_reg[36]_i_1_n_1\,
      CO(1) => \bit_count_reg[36]_i_1_n_2\,
      CO(0) => \bit_count_reg[36]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \bit_count_reg[36]_i_1_n_4\,
      O(2) => \bit_count_reg[36]_i_1_n_5\,
      O(1) => \bit_count_reg[36]_i_1_n_6\,
      O(0) => \bit_count_reg[36]_i_1_n_7\,
      S(3 downto 0) => \^bit_count\(39 downto 36)
    );
\bit_count_reg[37]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[36]_i_1_n_6\,
      Q => \^bit_count\(37)
    );
\bit_count_reg[38]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[36]_i_1_n_5\,
      Q => \^bit_count\(38)
    );
\bit_count_reg[39]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[36]_i_1_n_4\,
      Q => \^bit_count\(39)
    );
\bit_count_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[0]_i_1_n_4\,
      Q => \^bit_count\(3)
    );
\bit_count_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[4]_i_1_n_7\,
      Q => \^bit_count\(4)
    );
\bit_count_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \bit_count_reg[0]_i_1_n_0\,
      CO(3) => \bit_count_reg[4]_i_1_n_0\,
      CO(2) => \bit_count_reg[4]_i_1_n_1\,
      CO(1) => \bit_count_reg[4]_i_1_n_2\,
      CO(0) => \bit_count_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \bit_count_reg[4]_i_1_n_4\,
      O(2) => \bit_count_reg[4]_i_1_n_5\,
      O(1) => \bit_count_reg[4]_i_1_n_6\,
      O(0) => \bit_count_reg[4]_i_1_n_7\,
      S(3 downto 0) => \^bit_count\(7 downto 4)
    );
\bit_count_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[4]_i_1_n_6\,
      Q => \^bit_count\(5)
    );
\bit_count_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[4]_i_1_n_5\,
      Q => \^bit_count\(6)
    );
\bit_count_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[4]_i_1_n_4\,
      Q => \^bit_count\(7)
    );
\bit_count_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[8]_i_1_n_7\,
      Q => \^bit_count\(8)
    );
\bit_count_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \bit_count_reg[4]_i_1_n_0\,
      CO(3) => \bit_count_reg[8]_i_1_n_0\,
      CO(2) => \bit_count_reg[8]_i_1_n_1\,
      CO(1) => \bit_count_reg[8]_i_1_n_2\,
      CO(0) => \bit_count_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \bit_count_reg[8]_i_1_n_4\,
      O(2) => \bit_count_reg[8]_i_1_n_5\,
      O(1) => \bit_count_reg[8]_i_1_n_6\,
      O(0) => \bit_count_reg[8]_i_1_n_7\,
      S(3 downto 0) => \^bit_count\(11 downto 8)
    );
\bit_count_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \bit_count_reg[8]_i_1_n_6\,
      Q => \^bit_count\(9)
    );
\bit_idx[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => bit_idx(0),
      O => \bit_idx[0]_i_1_n_0\
    );
\bit_idx[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => bit_idx(0),
      I1 => bit_idx(1),
      O => \bit_idx[1]_i_1_n_0\
    );
\bit_idx[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A9"
    )
        port map (
      I0 => bit_idx(2),
      I1 => bit_idx(1),
      I2 => bit_idx(0),
      O => \bit_idx[2]_i_1_n_0\
    );
\bit_idx_reg[0]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      D => \bit_idx[0]_i_1_n_0\,
      PRE => \^aresetn_0\,
      Q => bit_idx(0)
    );
\bit_idx_reg[1]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      D => \bit_idx[1]_i_1_n_0\,
      PRE => \^aresetn_0\,
      Q => bit_idx(1)
    );
\bit_idx_reg[2]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      D => \bit_idx[2]_i_1_n_0\,
      PRE => \^aresetn_0\,
      Q => bit_idx(2)
    );
\bits_tdata[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFB00000008"
    )
        port map (
      I0 => i_dump(15),
      I1 => \i_dump_prev[14]_i_1_n_0\,
      I2 => bit_idx(0),
      I3 => bit_idx(1),
      I4 => bit_idx(2),
      I5 => \^m_axis_bits_tdata\(0),
      O => \bits_tdata[0]_i_1_n_0\
    );
\bits_tdata[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFFF00002000"
    )
        port map (
      I0 => i_dump(15),
      I1 => bit_idx(1),
      I2 => bit_idx(0),
      I3 => \i_dump_prev[14]_i_1_n_0\,
      I4 => bit_idx(2),
      I5 => \^m_axis_bits_tdata\(1),
      O => \bits_tdata[1]_i_1_n_0\
    );
\bits_tdata[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFFF00002000"
    )
        port map (
      I0 => i_dump(15),
      I1 => bit_idx(0),
      I2 => bit_idx(1),
      I3 => \i_dump_prev[14]_i_1_n_0\,
      I4 => bit_idx(2),
      I5 => \^m_axis_bits_tdata\(2),
      O => \bits_tdata[2]_i_1_n_0\
    );
\bits_tdata[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00008000"
    )
        port map (
      I0 => i_dump(15),
      I1 => bit_idx(1),
      I2 => bit_idx(0),
      I3 => \i_dump_prev[14]_i_1_n_0\,
      I4 => bit_idx(2),
      I5 => \^m_axis_bits_tdata\(3),
      O => \bits_tdata[3]_i_1_n_0\
    );
\bits_tdata[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFFFF02000000"
    )
        port map (
      I0 => i_dump(15),
      I1 => bit_idx(1),
      I2 => bit_idx(0),
      I3 => \i_dump_prev[14]_i_1_n_0\,
      I4 => bit_idx(2),
      I5 => \^m_axis_bits_tdata\(4),
      O => \bits_tdata[4]_i_1_n_0\
    );
\bits_tdata[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFFFFFF20000000"
    )
        port map (
      I0 => i_dump(15),
      I1 => bit_idx(1),
      I2 => bit_idx(0),
      I3 => \i_dump_prev[14]_i_1_n_0\,
      I4 => bit_idx(2),
      I5 => \^m_axis_bits_tdata\(5),
      O => \bits_tdata[5]_i_1_n_0\
    );
\bits_tdata[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFFFFFF20000000"
    )
        port map (
      I0 => i_dump(15),
      I1 => bit_idx(0),
      I2 => bit_idx(1),
      I3 => \i_dump_prev[14]_i_1_n_0\,
      I4 => bit_idx(2),
      I5 => \^m_axis_bits_tdata\(6),
      O => \bits_tdata[6]_i_1_n_0\
    );
\bits_tdata[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFFFFF80000000"
    )
        port map (
      I0 => i_dump(15),
      I1 => bit_idx(1),
      I2 => bit_idx(0),
      I3 => \i_dump_prev[14]_i_1_n_0\,
      I4 => bit_idx(2),
      I5 => \^m_axis_bits_tdata\(7),
      O => \bits_tdata[7]_i_1_n_0\
    );
\bits_tdata_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \bits_tdata[0]_i_1_n_0\,
      Q => \^m_axis_bits_tdata\(0)
    );
\bits_tdata_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \bits_tdata[1]_i_1_n_0\,
      Q => \^m_axis_bits_tdata\(1)
    );
\bits_tdata_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \bits_tdata[2]_i_1_n_0\,
      Q => \^m_axis_bits_tdata\(2)
    );
\bits_tdata_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \bits_tdata[3]_i_1_n_0\,
      Q => \^m_axis_bits_tdata\(3)
    );
\bits_tdata_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \bits_tdata[4]_i_1_n_0\,
      Q => \^m_axis_bits_tdata\(4)
    );
\bits_tdata_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \bits_tdata[5]_i_1_n_0\,
      Q => \^m_axis_bits_tdata\(5)
    );
\bits_tdata_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \bits_tdata[6]_i_1_n_0\,
      Q => \^m_axis_bits_tdata\(6)
    );
\bits_tdata_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \bits_tdata[7]_i_1_n_0\,
      Q => \^m_axis_bits_tdata\(7)
    );
bits_tvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444444F44444444"
    )
        port map (
      I0 => M_AXIS_BITS_TREADY,
      I1 => \^m_axis_bits_tvalid\,
      I2 => bit_idx(2),
      I3 => bit_idx(1),
      I4 => bit_idx(0),
      I5 => \i_dump_prev[14]_i_1_n_0\,
      O => bits_tvalid_i_1_n_0
    );
bits_tvalid_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => bits_tvalid_i_1_n_0,
      Q => \^m_axis_bits_tvalid\
    );
c_locked_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFBFBFB40000000"
    )
        port map (
      I0 => core_bypass_costas,
      I1 => adc_valid_d1,
      I2 => err_small,
      I3 => lock_cnt_reg(6),
      I4 => c_locked_i_3_n_0,
      I5 => \^c_locked_reg_0\(0),
      O => c_locked_i_1_n_0
    );
c_locked_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => c_locked_i_4_n_0,
      I1 => \^b\(8),
      I2 => \^b\(7),
      I3 => \^b\(11),
      I4 => \^b\(14),
      I5 => c_locked_i_5_n_0,
      O => err_small
    );
c_locked_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => lock_cnt_reg(5),
      I1 => lock_cnt_reg(4),
      I2 => lock_cnt_reg(2),
      I3 => lock_cnt_reg(0),
      I4 => lock_cnt_reg(1),
      I5 => lock_cnt_reg(3),
      O => c_locked_i_3_n_0
    );
c_locked_i_4: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => q_mix(14),
      I1 => phase_err_p0(14),
      I2 => q_mix(10),
      I3 => i_mix(15),
      I4 => phase_err_p0(10),
      O => c_locked_i_4_n_0
    );
c_locked_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => q_mix(11),
      I1 => phase_err_p0(11),
      I2 => q_mix(13),
      I3 => i_mix(15),
      I4 => phase_err_p0(13),
      O => c_locked_i_5_n_0
    );
c_locked_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => c_locked_i_1_n_0,
      Q => \^c_locked_reg_0\(0)
    );
freq_int1: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 0,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 1,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 16) => B"00000000000000",
      A(15 downto 0) => freq_int1_1(15 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_freq_int1_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => \^b\(14),
      B(16) => \^b\(14),
      B(15 downto 1) => \^b\(14 downto 0),
      B(0) => \^q_mix_reg[0]_0\(0),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_freq_int1_BCOUT_UNCONNECTED(17 downto 0),
      C(47) => freq_int1_n_74,
      C(46) => freq_int1_n_74,
      C(45) => freq_int1_n_74,
      C(44) => freq_int1_n_74,
      C(43) => freq_int1_n_74,
      C(42) => freq_int1_n_74,
      C(41) => freq_int1_n_74,
      C(40) => freq_int1_n_74,
      C(39) => freq_int1_n_74,
      C(38) => freq_int1_n_74,
      C(37) => freq_int1_n_74,
      C(36) => freq_int1_n_74,
      C(35) => freq_int1_n_74,
      C(34) => freq_int1_n_74,
      C(33) => freq_int1_n_74,
      C(32) => freq_int1_n_74,
      C(31) => freq_int1_n_74,
      C(30) => freq_int1_n_74,
      C(29) => freq_int1_n_74,
      C(28) => freq_int1_n_74,
      C(27) => freq_int1_n_74,
      C(26) => freq_int1_n_74,
      C(25) => freq_int1_n_74,
      C(24) => freq_int1_n_74,
      C(23) => freq_int1_n_74,
      C(22) => freq_int1_n_75,
      C(21) => freq_int1_n_76,
      C(20) => freq_int1_n_77,
      C(19) => freq_int1_n_78,
      C(18) => freq_int1_n_79,
      C(17) => freq_int1_n_80,
      C(16) => freq_int1_n_81,
      C(15) => freq_int1_n_82,
      C(14) => freq_int1_n_83,
      C(13) => freq_int1_n_84,
      C(12) => freq_int1_n_85,
      C(11) => freq_int1_n_86,
      C(10) => freq_int1_n_87,
      C(9) => freq_int1_n_88,
      C(8) => freq_int1_n_89,
      C(7) => freq_int1_n_90,
      C(6) => freq_int1_n_91,
      C(5) => freq_int1_n_92,
      C(4) => freq_int1_n_93,
      C(3) => freq_int1_n_94,
      C(2) => freq_int1_n_95,
      C(1) => freq_int1_n_96,
      C(0) => freq_int1_n_97,
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_freq_int1_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_freq_int1_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => \^e\(0),
      CLK => aclk,
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_freq_int1_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6) => '0',
      OPMODE(5) => freq_int1_0(0),
      OPMODE(4) => freq_int1_0(0),
      OPMODE(3 downto 0) => B"0101",
      OVERFLOW => NLW_freq_int1_OVERFLOW_UNCONNECTED,
      P(47 downto 32) => NLW_freq_int1_P_UNCONNECTED(47 downto 32),
      P(31) => freq_int1_n_74,
      P(30) => freq_int1_n_75,
      P(29) => freq_int1_n_76,
      P(28) => freq_int1_n_77,
      P(27) => freq_int1_n_78,
      P(26) => freq_int1_n_79,
      P(25) => freq_int1_n_80,
      P(24) => freq_int1_n_81,
      P(23) => freq_int1_n_82,
      P(22) => freq_int1_n_83,
      P(21) => freq_int1_n_84,
      P(20) => freq_int1_n_85,
      P(19) => freq_int1_n_86,
      P(18) => freq_int1_n_87,
      P(17) => freq_int1_n_88,
      P(16) => freq_int1_n_89,
      P(15) => freq_int1_n_90,
      P(14) => freq_int1_n_91,
      P(13) => freq_int1_n_92,
      P(12) => freq_int1_n_93,
      P(11) => freq_int1_n_94,
      P(10) => freq_int1_n_95,
      P(9) => freq_int1_n_96,
      P(8) => freq_int1_n_97,
      P(7) => freq_int1_n_98,
      P(6) => freq_int1_n_99,
      P(5) => freq_int1_n_100,
      P(4) => freq_int1_n_101,
      P(3) => freq_int1_n_102,
      P(2) => freq_int1_n_103,
      P(1) => freq_int1_n_104,
      P(0) => freq_int1_n_105,
      PATTERNBDETECT => NLW_freq_int1_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_freq_int1_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47 downto 0) => NLW_freq_int1_PCOUT_UNCONNECTED(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_freq_int1_UNDERFLOW_UNCONNECTED
    );
freq_int1_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => sps_counter1,
      I1 => core_enable,
      I2 => adc_valid_d1,
      I3 => core_bypass_costas,
      O => \^e\(0)
    );
freq_word2: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 16) => B"00000000000000",
      A(15 downto 0) => freq_word2_0(15 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_freq_word2_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => \^b\(14),
      B(16) => \^b\(14),
      B(15 downto 1) => \^b\(14 downto 0),
      B(0) => \^q_mix_reg[0]_0\(0),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_freq_word2_BCOUT_UNCONNECTED(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_freq_word2_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_freq_word2_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_freq_word2_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => NLW_freq_word2_OVERFLOW_UNCONNECTED,
      P(47 downto 33) => NLW_freq_word2_P_UNCONNECTED(47 downto 33),
      P(32) => freq_word2_n_73,
      P(31) => freq_word10,
      P(30) => freq_word2_n_75,
      P(29) => freq_word2_n_76,
      P(28) => freq_word2_n_77,
      P(27) => freq_word2_n_78,
      P(26) => freq_word2_n_79,
      P(25) => freq_word2_n_80,
      P(24) => freq_word2_n_81,
      P(23) => freq_word2_n_82,
      P(22) => freq_word2_n_83,
      P(21) => freq_word2_n_84,
      P(20) => freq_word2_n_85,
      P(19) => freq_word2_n_86,
      P(18) => freq_word2_n_87,
      P(17) => freq_word2_n_88,
      P(16) => freq_word2_n_89,
      P(15) => freq_word2_n_90,
      P(14) => freq_word2_n_91,
      P(13) => freq_word2_n_92,
      P(12) => freq_word2_n_93,
      P(11) => freq_word2_n_94,
      P(10) => freq_word2_n_95,
      P(9) => freq_word2_n_96,
      P(8) => freq_word2_n_97,
      P(7) => freq_word2_n_98,
      P(6) => freq_word2_n_99,
      P(5) => freq_word2_n_100,
      P(4) => freq_word2_n_101,
      P(3) => freq_word2_n_102,
      P(2) => freq_word2_n_103,
      P(1) => freq_word2_n_104,
      P(0) => freq_word2_n_105,
      PATTERNBDETECT => NLW_freq_word2_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_freq_word2_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47 downto 0) => NLW_freq_word2_PCOUT_UNCONNECTED(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_freq_word2_UNDERFLOW_UNCONNECTED
    );
freq_word2_i_16: unisim.vcomponents.CARRY4
     port map (
      CI => freq_word2_i_17_n_0,
      CO(3 downto 2) => NLW_freq_word2_i_16_CO_UNCONNECTED(3 downto 2),
      CO(1) => freq_word2_i_16_n_2,
      CO(0) => freq_word2_i_16_n_3,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => NLW_freq_word2_i_16_O_UNCONNECTED(3),
      O(2 downto 0) => phase_err_p0(15 downto 13),
      S(3) => '0',
      S(2) => freq_word2_i_20_n_0,
      S(1) => freq_word2_i_21_n_0,
      S(0) => freq_word2_i_22_n_0
    );
freq_word2_i_17: unisim.vcomponents.CARRY4
     port map (
      CI => freq_word2_i_18_n_0,
      CO(3) => freq_word2_i_17_n_0,
      CO(2) => freq_word2_i_17_n_1,
      CO(1) => freq_word2_i_17_n_2,
      CO(0) => freq_word2_i_17_n_3,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => phase_err_p0(12 downto 9),
      S(3) => freq_word2_i_23_n_0,
      S(2) => freq_word2_i_24_n_0,
      S(1) => freq_word2_i_25_n_0,
      S(0) => freq_word2_i_26_n_0
    );
freq_word2_i_18: unisim.vcomponents.CARRY4
     port map (
      CI => freq_word2_i_19_n_0,
      CO(3) => freq_word2_i_18_n_0,
      CO(2) => freq_word2_i_18_n_1,
      CO(1) => freq_word2_i_18_n_2,
      CO(0) => freq_word2_i_18_n_3,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => phase_err_p0(8 downto 5),
      S(3) => freq_word2_i_27_n_0,
      S(2) => freq_word2_i_28_n_0,
      S(1) => freq_word2_i_29_n_0,
      S(0) => freq_word2_i_30_n_0
    );
freq_word2_i_19: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => freq_word2_i_19_n_0,
      CO(2) => freq_word2_i_19_n_1,
      CO(1) => freq_word2_i_19_n_2,
      CO(0) => freq_word2_i_19_n_3,
      CYINIT => freq_word2_i_31_n_0,
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => phase_err_p0(4 downto 1),
      S(3) => freq_word2_i_32_n_0,
      S(2) => freq_word2_i_33_n_0,
      S(1) => freq_word2_i_34_n_0,
      S(0) => freq_word2_i_35_n_0
    );
freq_word2_i_20: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(15),
      O => freq_word2_i_20_n_0
    );
freq_word2_i_21: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(14),
      O => freq_word2_i_21_n_0
    );
freq_word2_i_22: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(13),
      O => freq_word2_i_22_n_0
    );
freq_word2_i_23: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(12),
      O => freq_word2_i_23_n_0
    );
freq_word2_i_24: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(11),
      O => freq_word2_i_24_n_0
    );
freq_word2_i_25: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(10),
      O => freq_word2_i_25_n_0
    );
freq_word2_i_26: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(9),
      O => freq_word2_i_26_n_0
    );
freq_word2_i_27: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(8),
      O => freq_word2_i_27_n_0
    );
freq_word2_i_28: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(7),
      O => freq_word2_i_28_n_0
    );
freq_word2_i_29: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(6),
      O => freq_word2_i_29_n_0
    );
freq_word2_i_30: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(5),
      O => freq_word2_i_30_n_0
    );
freq_word2_i_31: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q_mix_reg[0]_0\(0),
      O => freq_word2_i_31_n_0
    );
freq_word2_i_32: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(4),
      O => freq_word2_i_32_n_0
    );
freq_word2_i_33: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(3),
      O => freq_word2_i_33_n_0
    );
freq_word2_i_34: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(2),
      O => freq_word2_i_34_n_0
    );
freq_word2_i_35: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => q_mix(1),
      O => freq_word2_i_35_n_0
    );
\freq_word[11]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_86,
      I1 => freq_int1_0(0),
      O => \freq_word[11]_i_2_n_0\
    );
\freq_word[11]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_87,
      I1 => freq_int1_0(0),
      O => \freq_word[11]_i_3_n_0\
    );
\freq_word[11]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_88,
      I1 => freq_int1_0(0),
      O => \freq_word[11]_i_4_n_0\
    );
\freq_word[11]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_89,
      I1 => freq_int1_0(0),
      O => \freq_word[11]_i_5_n_0\
    );
\freq_word[11]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_86,
      I2 => freq_word2_n_86,
      O => \freq_word[11]_i_6_n_0\
    );
\freq_word[11]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_87,
      I2 => freq_word2_n_87,
      O => \freq_word[11]_i_7_n_0\
    );
\freq_word[11]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_88,
      I2 => freq_word2_n_88,
      O => \freq_word[11]_i_8_n_0\
    );
\freq_word[11]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_89,
      I2 => freq_word2_n_89,
      O => \freq_word[11]_i_9_n_0\
    );
\freq_word[15]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_82,
      I1 => freq_int1_0(0),
      O => \freq_word[15]_i_2_n_0\
    );
\freq_word[15]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_83,
      I1 => freq_int1_0(0),
      O => \freq_word[15]_i_3_n_0\
    );
\freq_word[15]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_84,
      I1 => freq_int1_0(0),
      O => \freq_word[15]_i_4_n_0\
    );
\freq_word[15]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_85,
      I1 => freq_int1_0(0),
      O => \freq_word[15]_i_5_n_0\
    );
\freq_word[15]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_82,
      I2 => freq_word2_n_82,
      O => \freq_word[15]_i_6_n_0\
    );
\freq_word[15]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_83,
      I2 => freq_word2_n_83,
      O => \freq_word[15]_i_7_n_0\
    );
\freq_word[15]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_84,
      I2 => freq_word2_n_84,
      O => \freq_word[15]_i_8_n_0\
    );
\freq_word[15]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_85,
      I2 => freq_word2_n_85,
      O => \freq_word[15]_i_9_n_0\
    );
\freq_word[19]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_78,
      I1 => freq_int1_0(0),
      O => \freq_word[19]_i_2_n_0\
    );
\freq_word[19]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_79,
      I1 => freq_int1_0(0),
      O => \freq_word[19]_i_3_n_0\
    );
\freq_word[19]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_80,
      I1 => freq_int1_0(0),
      O => \freq_word[19]_i_4_n_0\
    );
\freq_word[19]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_81,
      I1 => freq_int1_0(0),
      O => \freq_word[19]_i_5_n_0\
    );
\freq_word[19]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_78,
      I2 => freq_word2_n_78,
      O => \freq_word[19]_i_6_n_0\
    );
\freq_word[19]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_79,
      I2 => freq_word2_n_79,
      O => \freq_word[19]_i_7_n_0\
    );
\freq_word[19]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_80,
      I2 => freq_word2_n_80,
      O => \freq_word[19]_i_8_n_0\
    );
\freq_word[19]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_81,
      I2 => freq_word2_n_81,
      O => \freq_word[19]_i_9_n_0\
    );
\freq_word[23]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_75,
      I1 => freq_int1_0(0),
      O => \freq_word[23]_i_2_n_0\
    );
\freq_word[23]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_76,
      I1 => freq_int1_0(0),
      O => \freq_word[23]_i_3_n_0\
    );
\freq_word[23]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_77,
      I1 => freq_int1_0(0),
      O => \freq_word[23]_i_4_n_0\
    );
\freq_word[23]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => freq_word10,
      I1 => freq_int1_0(0),
      I2 => freq_int1_n_74,
      O => \freq_word[23]_i_5_n_0\
    );
\freq_word[23]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_75,
      I2 => freq_word2_n_75,
      O => \freq_word[23]_i_6_n_0\
    );
\freq_word[23]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_76,
      I2 => freq_word2_n_76,
      O => \freq_word[23]_i_7_n_0\
    );
\freq_word[23]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_77,
      I2 => freq_word2_n_77,
      O => \freq_word[23]_i_8_n_0\
    );
\freq_word[29]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => freq_word10,
      O => \freq_word[29]_i_2_n_0\
    );
\freq_word[29]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => freq_word10,
      I1 => freq_int1_0(0),
      I2 => freq_int1_n_74,
      O => \freq_word[29]_i_3_n_0\
    );
\freq_word[3]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_94,
      I1 => freq_int1_0(0),
      O => \freq_word[3]_i_2_n_0\
    );
\freq_word[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_95,
      I1 => freq_int1_0(0),
      O => \freq_word[3]_i_3_n_0\
    );
\freq_word[3]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_96,
      I1 => freq_int1_0(0),
      O => \freq_word[3]_i_4_n_0\
    );
\freq_word[3]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_97,
      I1 => freq_int1_0(0),
      O => \freq_word[3]_i_5_n_0\
    );
\freq_word[3]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_94,
      I2 => freq_word2_n_94,
      O => \freq_word[3]_i_6_n_0\
    );
\freq_word[3]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_95,
      I2 => freq_word2_n_95,
      O => \freq_word[3]_i_7_n_0\
    );
\freq_word[3]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_96,
      I2 => freq_word2_n_96,
      O => \freq_word[3]_i_8_n_0\
    );
\freq_word[3]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_97,
      I2 => freq_word2_n_97,
      O => \freq_word[3]_i_9_n_0\
    );
\freq_word[7]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_90,
      I1 => freq_int1_0(0),
      O => \freq_word[7]_i_2_n_0\
    );
\freq_word[7]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_91,
      I1 => freq_int1_0(0),
      O => \freq_word[7]_i_3_n_0\
    );
\freq_word[7]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_92,
      I1 => freq_int1_0(0),
      O => \freq_word[7]_i_4_n_0\
    );
\freq_word[7]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => freq_int1_n_93,
      I1 => freq_int1_0(0),
      O => \freq_word[7]_i_5_n_0\
    );
\freq_word[7]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_90,
      I2 => freq_word2_n_90,
      O => \freq_word[7]_i_6_n_0\
    );
\freq_word[7]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_91,
      I2 => freq_word2_n_91,
      O => \freq_word[7]_i_7_n_0\
    );
\freq_word[7]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_92,
      I2 => freq_word2_n_92,
      O => \freq_word[7]_i_8_n_0\
    );
\freq_word[7]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => freq_int1_0(0),
      I1 => freq_int1_n_93,
      I2 => freq_word2_n_93,
      O => \freq_word[7]_i_9_n_0\
    );
\freq_word_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[3]_i_1_n_7\,
      Q => freq_word(0)
    );
\freq_word_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[11]_i_1_n_5\,
      Q => freq_word(10)
    );
\freq_word_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[11]_i_1_n_4\,
      Q => freq_word(11)
    );
\freq_word_reg[11]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \freq_word_reg[7]_i_1_n_0\,
      CO(3) => \freq_word_reg[11]_i_1_n_0\,
      CO(2) => \freq_word_reg[11]_i_1_n_1\,
      CO(1) => \freq_word_reg[11]_i_1_n_2\,
      CO(0) => \freq_word_reg[11]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \freq_word[11]_i_2_n_0\,
      DI(2) => \freq_word[11]_i_3_n_0\,
      DI(1) => \freq_word[11]_i_4_n_0\,
      DI(0) => \freq_word[11]_i_5_n_0\,
      O(3) => \freq_word_reg[11]_i_1_n_4\,
      O(2) => \freq_word_reg[11]_i_1_n_5\,
      O(1) => \freq_word_reg[11]_i_1_n_6\,
      O(0) => \freq_word_reg[11]_i_1_n_7\,
      S(3) => \freq_word[11]_i_6_n_0\,
      S(2) => \freq_word[11]_i_7_n_0\,
      S(1) => \freq_word[11]_i_8_n_0\,
      S(0) => \freq_word[11]_i_9_n_0\
    );
\freq_word_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[15]_i_1_n_7\,
      Q => freq_word(12)
    );
\freq_word_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[15]_i_1_n_6\,
      Q => freq_word(13)
    );
\freq_word_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[15]_i_1_n_5\,
      Q => freq_word(14)
    );
\freq_word_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[15]_i_1_n_4\,
      Q => freq_word(15)
    );
\freq_word_reg[15]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \freq_word_reg[11]_i_1_n_0\,
      CO(3) => \freq_word_reg[15]_i_1_n_0\,
      CO(2) => \freq_word_reg[15]_i_1_n_1\,
      CO(1) => \freq_word_reg[15]_i_1_n_2\,
      CO(0) => \freq_word_reg[15]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \freq_word[15]_i_2_n_0\,
      DI(2) => \freq_word[15]_i_3_n_0\,
      DI(1) => \freq_word[15]_i_4_n_0\,
      DI(0) => \freq_word[15]_i_5_n_0\,
      O(3) => \freq_word_reg[15]_i_1_n_4\,
      O(2) => \freq_word_reg[15]_i_1_n_5\,
      O(1) => \freq_word_reg[15]_i_1_n_6\,
      O(0) => \freq_word_reg[15]_i_1_n_7\,
      S(3) => \freq_word[15]_i_6_n_0\,
      S(2) => \freq_word[15]_i_7_n_0\,
      S(1) => \freq_word[15]_i_8_n_0\,
      S(0) => \freq_word[15]_i_9_n_0\
    );
\freq_word_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[19]_i_1_n_7\,
      Q => freq_word(16)
    );
\freq_word_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[19]_i_1_n_6\,
      Q => freq_word(17)
    );
\freq_word_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[19]_i_1_n_5\,
      Q => freq_word(18)
    );
\freq_word_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[19]_i_1_n_4\,
      Q => freq_word(19)
    );
\freq_word_reg[19]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \freq_word_reg[15]_i_1_n_0\,
      CO(3) => \freq_word_reg[19]_i_1_n_0\,
      CO(2) => \freq_word_reg[19]_i_1_n_1\,
      CO(1) => \freq_word_reg[19]_i_1_n_2\,
      CO(0) => \freq_word_reg[19]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \freq_word[19]_i_2_n_0\,
      DI(2) => \freq_word[19]_i_3_n_0\,
      DI(1) => \freq_word[19]_i_4_n_0\,
      DI(0) => \freq_word[19]_i_5_n_0\,
      O(3) => \freq_word_reg[19]_i_1_n_4\,
      O(2) => \freq_word_reg[19]_i_1_n_5\,
      O(1) => \freq_word_reg[19]_i_1_n_6\,
      O(0) => \freq_word_reg[19]_i_1_n_7\,
      S(3) => \freq_word[19]_i_6_n_0\,
      S(2) => \freq_word[19]_i_7_n_0\,
      S(1) => \freq_word[19]_i_8_n_0\,
      S(0) => \freq_word[19]_i_9_n_0\
    );
\freq_word_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[3]_i_1_n_6\,
      Q => freq_word(1)
    );
\freq_word_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[23]_i_1_n_7\,
      Q => freq_word(20)
    );
\freq_word_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[23]_i_1_n_6\,
      Q => freq_word(21)
    );
\freq_word_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[23]_i_1_n_5\,
      Q => freq_word(22)
    );
\freq_word_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[23]_i_1_n_4\,
      Q => freq_word(23)
    );
\freq_word_reg[23]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \freq_word_reg[19]_i_1_n_0\,
      CO(3) => \freq_word_reg[23]_i_1_n_0\,
      CO(2) => \freq_word_reg[23]_i_1_n_1\,
      CO(1) => \freq_word_reg[23]_i_1_n_2\,
      CO(0) => \freq_word_reg[23]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => freq_word10,
      DI(2) => \freq_word[23]_i_2_n_0\,
      DI(1) => \freq_word[23]_i_3_n_0\,
      DI(0) => \freq_word[23]_i_4_n_0\,
      O(3) => \freq_word_reg[23]_i_1_n_4\,
      O(2) => \freq_word_reg[23]_i_1_n_5\,
      O(1) => \freq_word_reg[23]_i_1_n_6\,
      O(0) => \freq_word_reg[23]_i_1_n_7\,
      S(3) => \freq_word[23]_i_5_n_0\,
      S(2) => \freq_word[23]_i_6_n_0\,
      S(1) => \freq_word[23]_i_7_n_0\,
      S(0) => \freq_word[23]_i_8_n_0\
    );
\freq_word_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[29]_i_1_n_7\,
      Q => freq_word(24)
    );
\freq_word_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[29]_i_1_n_6\,
      Q => freq_word(29)
    );
\freq_word_reg[29]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \freq_word_reg[23]_i_1_n_0\,
      CO(3 downto 1) => \NLW_freq_word_reg[29]_i_1_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \freq_word_reg[29]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => \freq_word[29]_i_2_n_0\,
      O(3 downto 2) => \NLW_freq_word_reg[29]_i_1_O_UNCONNECTED\(3 downto 2),
      O(1) => \freq_word_reg[29]_i_1_n_6\,
      O(0) => \freq_word_reg[29]_i_1_n_7\,
      S(3 downto 1) => B"001",
      S(0) => \freq_word[29]_i_3_n_0\
    );
\freq_word_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[3]_i_1_n_5\,
      Q => freq_word(2)
    );
\freq_word_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[3]_i_1_n_4\,
      Q => freq_word(3)
    );
\freq_word_reg[3]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \freq_word_reg[3]_i_1_n_0\,
      CO(2) => \freq_word_reg[3]_i_1_n_1\,
      CO(1) => \freq_word_reg[3]_i_1_n_2\,
      CO(0) => \freq_word_reg[3]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \freq_word[3]_i_2_n_0\,
      DI(2) => \freq_word[3]_i_3_n_0\,
      DI(1) => \freq_word[3]_i_4_n_0\,
      DI(0) => \freq_word[3]_i_5_n_0\,
      O(3) => \freq_word_reg[3]_i_1_n_4\,
      O(2) => \freq_word_reg[3]_i_1_n_5\,
      O(1) => \freq_word_reg[3]_i_1_n_6\,
      O(0) => \freq_word_reg[3]_i_1_n_7\,
      S(3) => \freq_word[3]_i_6_n_0\,
      S(2) => \freq_word[3]_i_7_n_0\,
      S(1) => \freq_word[3]_i_8_n_0\,
      S(0) => \freq_word[3]_i_9_n_0\
    );
\freq_word_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[7]_i_1_n_7\,
      Q => freq_word(4)
    );
\freq_word_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[7]_i_1_n_6\,
      Q => freq_word(5)
    );
\freq_word_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[7]_i_1_n_5\,
      Q => freq_word(6)
    );
\freq_word_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[7]_i_1_n_4\,
      Q => freq_word(7)
    );
\freq_word_reg[7]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \freq_word_reg[3]_i_1_n_0\,
      CO(3) => \freq_word_reg[7]_i_1_n_0\,
      CO(2) => \freq_word_reg[7]_i_1_n_1\,
      CO(1) => \freq_word_reg[7]_i_1_n_2\,
      CO(0) => \freq_word_reg[7]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \freq_word[7]_i_2_n_0\,
      DI(2) => \freq_word[7]_i_3_n_0\,
      DI(1) => \freq_word[7]_i_4_n_0\,
      DI(0) => \freq_word[7]_i_5_n_0\,
      O(3) => \freq_word_reg[7]_i_1_n_4\,
      O(2) => \freq_word_reg[7]_i_1_n_5\,
      O(1) => \freq_word_reg[7]_i_1_n_6\,
      O(0) => \freq_word_reg[7]_i_1_n_7\,
      S(3) => \freq_word[7]_i_6_n_0\,
      S(2) => \freq_word[7]_i_7_n_0\,
      S(1) => \freq_word[7]_i_8_n_0\,
      S(0) => \freq_word[7]_i_9_n_0\
    );
\freq_word_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[11]_i_1_n_7\,
      Q => freq_word(8)
    );
\freq_word_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \^e\(0),
      CLR => \^aresetn_0\,
      D => \freq_word_reg[11]_i_1_n_6\,
      Q => freq_word(9)
    );
\i_dump_prev[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => adc_valid_d1,
      I1 => core_enable,
      I2 => sps_counter1,
      O => \i_dump_prev[14]_i_1_n_0\
    );
\i_dump_prev_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(0),
      Q => i_dump_prev(0)
    );
\i_dump_prev_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(10),
      Q => i_dump_prev(10)
    );
\i_dump_prev_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(11),
      Q => i_dump_prev(11)
    );
\i_dump_prev_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(12),
      Q => i_dump_prev(12)
    );
\i_dump_prev_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(13),
      Q => i_dump_prev(13)
    );
\i_dump_prev_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(14),
      Q => i_dump_prev(14)
    );
\i_dump_prev_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(1),
      Q => i_dump_prev(1)
    );
\i_dump_prev_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(2),
      Q => i_dump_prev(2)
    );
\i_dump_prev_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(3),
      Q => i_dump_prev(3)
    );
\i_dump_prev_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(4),
      Q => i_dump_prev(4)
    );
\i_dump_prev_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(5),
      Q => i_dump_prev(5)
    );
\i_dump_prev_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(6),
      Q => i_dump_prev(6)
    );
\i_dump_prev_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(7),
      Q => i_dump_prev(7)
    );
\i_dump_prev_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(8),
      Q => i_dump_prev(8)
    );
\i_dump_prev_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(9),
      Q => i_dump_prev(9)
    );
\i_mix[11]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(11),
      I1 => core_bypass_costas,
      O => \i_mix[11]_i_2_n_0\
    );
\i_mix[11]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(10),
      I1 => core_bypass_costas,
      O => \i_mix[11]_i_3_n_0\
    );
\i_mix[11]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(9),
      I1 => core_bypass_costas,
      O => \i_mix[11]_i_4_n_0\
    );
\i_mix[11]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(8),
      I1 => core_bypass_costas,
      O => \i_mix[11]_i_5_n_0\
    );
\i_mix[15]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(14),
      I1 => core_bypass_costas,
      O => \i_mix[15]_i_2_n_0\
    );
\i_mix[15]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(13),
      I1 => core_bypass_costas,
      O => \i_mix[15]_i_3_n_0\
    );
\i_mix[15]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(12),
      I1 => core_bypass_costas,
      O => \i_mix[15]_i_4_n_0\
    );
\i_mix[3]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(3),
      I1 => core_bypass_costas,
      O => \i_mix[3]_i_2_n_0\
    );
\i_mix[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(2),
      I1 => core_bypass_costas,
      O => \i_mix[3]_i_3_n_0\
    );
\i_mix[3]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(1),
      I1 => core_bypass_costas,
      O => \i_mix[3]_i_4_n_0\
    );
\i_mix[3]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(0),
      I1 => core_bypass_costas,
      O => \i_mix[3]_i_5_n_0\
    );
\i_mix[7]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(7),
      I1 => core_bypass_costas,
      O => \i_mix[7]_i_2_n_0\
    );
\i_mix[7]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(6),
      I1 => core_bypass_costas,
      O => \i_mix[7]_i_3_n_0\
    );
\i_mix[7]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(5),
      I1 => core_bypass_costas,
      O => \i_mix[7]_i_4_n_0\
    );
\i_mix[7]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B_0(4),
      I1 => core_bypass_costas,
      O => \i_mix[7]_i_5_n_0\
    );
\i_mix_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_81,
      Q => i_mix(0)
    );
\i_mix_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_71,
      Q => i_mix(10)
    );
\i_mix_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_70,
      Q => i_mix(11)
    );
\i_mix_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_69,
      Q => i_mix(12)
    );
\i_mix_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_68,
      Q => i_mix(13)
    );
\i_mix_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_67,
      Q => i_mix(14)
    );
\i_mix_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_66,
      Q => i_mix(15)
    );
\i_mix_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_80,
      Q => i_mix(1)
    );
\i_mix_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_79,
      Q => i_mix(2)
    );
\i_mix_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_78,
      Q => i_mix(3)
    );
\i_mix_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_77,
      Q => i_mix(4)
    );
\i_mix_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_76,
      Q => i_mix(5)
    );
\i_mix_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_75,
      Q => i_mix(6)
    );
\i_mix_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_74,
      Q => i_mix(7)
    );
\i_mix_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_73,
      Q => i_mix(8)
    );
\i_mix_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_72,
      Q => i_mix(9)
    );
i_prev_sign_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \i_dump_prev[14]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => i_dump(15),
      Q => i_prev_sign
    );
\integrate_acc[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(3),
      I1 => sps_counter1,
      O => \integrate_acc[0]_i_2_n_0\
    );
\integrate_acc[0]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(2),
      I1 => sps_counter1,
      O => \integrate_acc[0]_i_3_n_0\
    );
\integrate_acc[0]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(1),
      I1 => sps_counter1,
      O => \integrate_acc[0]_i_4_n_0\
    );
\integrate_acc[0]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(0),
      I1 => sps_counter1,
      O => \integrate_acc[0]_i_5_n_0\
    );
\integrate_acc[0]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(3),
      I1 => sps_counter1,
      I2 => \integrate_acc_reg_n_0_[3]\,
      O => \integrate_acc[0]_i_6_n_0\
    );
\integrate_acc[0]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(2),
      I1 => sps_counter1,
      I2 => \integrate_acc_reg_n_0_[2]\,
      O => \integrate_acc[0]_i_7_n_0\
    );
\integrate_acc[0]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(1),
      I1 => sps_counter1,
      I2 => \integrate_acc_reg_n_0_[1]\,
      O => \integrate_acc[0]_i_8_n_0\
    );
\integrate_acc[0]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(0),
      I1 => sps_counter1,
      I2 => \integrate_acc_reg_n_0_[0]\,
      O => \integrate_acc[0]_i_9_n_0\
    );
\integrate_acc[12]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      O => \integrate_acc[12]_i_2_n_0\
    );
\integrate_acc[12]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(14),
      I1 => sps_counter1,
      O => \integrate_acc[12]_i_3_n_0\
    );
\integrate_acc[12]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(13),
      I1 => sps_counter1,
      O => \integrate_acc[12]_i_4_n_0\
    );
\integrate_acc[12]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(12),
      I1 => sps_counter1,
      O => \integrate_acc[12]_i_5_n_0\
    );
\integrate_acc[12]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      I2 => i_dump(9),
      O => \integrate_acc[12]_i_6_n_0\
    );
\integrate_acc[12]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(14),
      I1 => sps_counter1,
      I2 => i_dump(8),
      O => \integrate_acc[12]_i_7_n_0\
    );
\integrate_acc[12]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(13),
      I1 => sps_counter1,
      I2 => i_dump(7),
      O => \integrate_acc[12]_i_8_n_0\
    );
\integrate_acc[12]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(12),
      I1 => sps_counter1,
      I2 => i_dump(6),
      O => \integrate_acc[12]_i_9_n_0\
    );
\integrate_acc[16]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      O => \integrate_acc[16]_i_2_n_0\
    );
\integrate_acc[16]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      O => \integrate_acc[16]_i_3_n_0\
    );
\integrate_acc[16]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      O => \integrate_acc[16]_i_4_n_0\
    );
\integrate_acc[16]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      O => \integrate_acc[16]_i_5_n_0\
    );
\integrate_acc[16]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      I2 => i_dump(13),
      O => \integrate_acc[16]_i_6_n_0\
    );
\integrate_acc[16]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      I2 => i_dump(12),
      O => \integrate_acc[16]_i_7_n_0\
    );
\integrate_acc[16]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      I2 => i_dump(11),
      O => \integrate_acc[16]_i_8_n_0\
    );
\integrate_acc[16]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      I2 => i_dump(10),
      O => \integrate_acc[16]_i_9_n_0\
    );
\integrate_acc[20]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      O => \integrate_acc[20]_i_2_n_0\
    );
\integrate_acc[20]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      I2 => i_dump(15),
      O => \integrate_acc[20]_i_3_n_0\
    );
\integrate_acc[20]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(15),
      I1 => sps_counter1,
      I2 => i_dump(14),
      O => \integrate_acc[20]_i_4_n_0\
    );
\integrate_acc[4]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(7),
      I1 => sps_counter1,
      O => \integrate_acc[4]_i_2_n_0\
    );
\integrate_acc[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(6),
      I1 => sps_counter1,
      O => \integrate_acc[4]_i_3_n_0\
    );
\integrate_acc[4]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(5),
      I1 => sps_counter1,
      O => \integrate_acc[4]_i_4_n_0\
    );
\integrate_acc[4]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(4),
      I1 => sps_counter1,
      O => \integrate_acc[4]_i_5_n_0\
    );
\integrate_acc[4]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(7),
      I1 => sps_counter1,
      I2 => i_dump(1),
      O => \integrate_acc[4]_i_6_n_0\
    );
\integrate_acc[4]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(6),
      I1 => sps_counter1,
      I2 => i_dump(0),
      O => \integrate_acc[4]_i_7_n_0\
    );
\integrate_acc[4]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(5),
      I1 => sps_counter1,
      I2 => \integrate_acc_reg_n_0_[5]\,
      O => \integrate_acc[4]_i_8_n_0\
    );
\integrate_acc[4]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(4),
      I1 => sps_counter1,
      I2 => \integrate_acc_reg_n_0_[4]\,
      O => \integrate_acc[4]_i_9_n_0\
    );
\integrate_acc[8]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(11),
      I1 => sps_counter1,
      O => \integrate_acc[8]_i_2_n_0\
    );
\integrate_acc[8]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(10),
      I1 => sps_counter1,
      O => \integrate_acc[8]_i_3_n_0\
    );
\integrate_acc[8]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(9),
      I1 => sps_counter1,
      O => \integrate_acc[8]_i_4_n_0\
    );
\integrate_acc[8]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => i_mix(8),
      I1 => sps_counter1,
      O => \integrate_acc[8]_i_5_n_0\
    );
\integrate_acc[8]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(11),
      I1 => sps_counter1,
      I2 => i_dump(5),
      O => \integrate_acc[8]_i_6_n_0\
    );
\integrate_acc[8]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(10),
      I1 => sps_counter1,
      I2 => i_dump(4),
      O => \integrate_acc[8]_i_7_n_0\
    );
\integrate_acc[8]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(9),
      I1 => sps_counter1,
      I2 => i_dump(3),
      O => \integrate_acc[8]_i_8_n_0\
    );
\integrate_acc[8]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => i_mix(8),
      I1 => sps_counter1,
      I2 => i_dump(2),
      O => \integrate_acc[8]_i_9_n_0\
    );
\integrate_acc_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[0]_i_1_n_7\,
      Q => \integrate_acc_reg_n_0_[0]\
    );
\integrate_acc_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \integrate_acc_reg[0]_i_1_n_0\,
      CO(2) => \integrate_acc_reg[0]_i_1_n_1\,
      CO(1) => \integrate_acc_reg[0]_i_1_n_2\,
      CO(0) => \integrate_acc_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \integrate_acc[0]_i_2_n_0\,
      DI(2) => \integrate_acc[0]_i_3_n_0\,
      DI(1) => \integrate_acc[0]_i_4_n_0\,
      DI(0) => \integrate_acc[0]_i_5_n_0\,
      O(3) => \integrate_acc_reg[0]_i_1_n_4\,
      O(2) => \integrate_acc_reg[0]_i_1_n_5\,
      O(1) => \integrate_acc_reg[0]_i_1_n_6\,
      O(0) => \integrate_acc_reg[0]_i_1_n_7\,
      S(3) => \integrate_acc[0]_i_6_n_0\,
      S(2) => \integrate_acc[0]_i_7_n_0\,
      S(1) => \integrate_acc[0]_i_8_n_0\,
      S(0) => \integrate_acc[0]_i_9_n_0\
    );
\integrate_acc_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[8]_i_1_n_5\,
      Q => i_dump(4)
    );
\integrate_acc_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[8]_i_1_n_4\,
      Q => i_dump(5)
    );
\integrate_acc_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[12]_i_1_n_7\,
      Q => i_dump(6)
    );
\integrate_acc_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \integrate_acc_reg[8]_i_1_n_0\,
      CO(3) => \integrate_acc_reg[12]_i_1_n_0\,
      CO(2) => \integrate_acc_reg[12]_i_1_n_1\,
      CO(1) => \integrate_acc_reg[12]_i_1_n_2\,
      CO(0) => \integrate_acc_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \integrate_acc[12]_i_2_n_0\,
      DI(2) => \integrate_acc[12]_i_3_n_0\,
      DI(1) => \integrate_acc[12]_i_4_n_0\,
      DI(0) => \integrate_acc[12]_i_5_n_0\,
      O(3) => \integrate_acc_reg[12]_i_1_n_4\,
      O(2) => \integrate_acc_reg[12]_i_1_n_5\,
      O(1) => \integrate_acc_reg[12]_i_1_n_6\,
      O(0) => \integrate_acc_reg[12]_i_1_n_7\,
      S(3) => \integrate_acc[12]_i_6_n_0\,
      S(2) => \integrate_acc[12]_i_7_n_0\,
      S(1) => \integrate_acc[12]_i_8_n_0\,
      S(0) => \integrate_acc[12]_i_9_n_0\
    );
\integrate_acc_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[12]_i_1_n_6\,
      Q => i_dump(7)
    );
\integrate_acc_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[12]_i_1_n_5\,
      Q => i_dump(8)
    );
\integrate_acc_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[12]_i_1_n_4\,
      Q => i_dump(9)
    );
\integrate_acc_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[16]_i_1_n_7\,
      Q => i_dump(10)
    );
\integrate_acc_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \integrate_acc_reg[12]_i_1_n_0\,
      CO(3) => \integrate_acc_reg[16]_i_1_n_0\,
      CO(2) => \integrate_acc_reg[16]_i_1_n_1\,
      CO(1) => \integrate_acc_reg[16]_i_1_n_2\,
      CO(0) => \integrate_acc_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \integrate_acc[16]_i_2_n_0\,
      DI(2) => \integrate_acc[16]_i_3_n_0\,
      DI(1) => \integrate_acc[16]_i_4_n_0\,
      DI(0) => \integrate_acc[16]_i_5_n_0\,
      O(3) => \integrate_acc_reg[16]_i_1_n_4\,
      O(2) => \integrate_acc_reg[16]_i_1_n_5\,
      O(1) => \integrate_acc_reg[16]_i_1_n_6\,
      O(0) => \integrate_acc_reg[16]_i_1_n_7\,
      S(3) => \integrate_acc[16]_i_6_n_0\,
      S(2) => \integrate_acc[16]_i_7_n_0\,
      S(1) => \integrate_acc[16]_i_8_n_0\,
      S(0) => \integrate_acc[16]_i_9_n_0\
    );
\integrate_acc_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[16]_i_1_n_6\,
      Q => i_dump(11)
    );
\integrate_acc_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[16]_i_1_n_5\,
      Q => i_dump(12)
    );
\integrate_acc_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[16]_i_1_n_4\,
      Q => i_dump(13)
    );
\integrate_acc_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[0]_i_1_n_6\,
      Q => \integrate_acc_reg_n_0_[1]\
    );
\integrate_acc_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[20]_i_1_n_7\,
      Q => i_dump(14)
    );
\integrate_acc_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \integrate_acc_reg[16]_i_1_n_0\,
      CO(3 downto 1) => \NLW_integrate_acc_reg[20]_i_1_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \integrate_acc_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => \integrate_acc[20]_i_2_n_0\,
      O(3 downto 2) => \NLW_integrate_acc_reg[20]_i_1_O_UNCONNECTED\(3 downto 2),
      O(1) => \integrate_acc_reg[20]_i_1_n_6\,
      O(0) => \integrate_acc_reg[20]_i_1_n_7\,
      S(3 downto 2) => B"00",
      S(1) => \integrate_acc[20]_i_3_n_0\,
      S(0) => \integrate_acc[20]_i_4_n_0\
    );
\integrate_acc_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[20]_i_1_n_6\,
      Q => i_dump(15)
    );
\integrate_acc_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[0]_i_1_n_5\,
      Q => \integrate_acc_reg_n_0_[2]\
    );
\integrate_acc_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[0]_i_1_n_4\,
      Q => \integrate_acc_reg_n_0_[3]\
    );
\integrate_acc_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[4]_i_1_n_7\,
      Q => \integrate_acc_reg_n_0_[4]\
    );
\integrate_acc_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \integrate_acc_reg[0]_i_1_n_0\,
      CO(3) => \integrate_acc_reg[4]_i_1_n_0\,
      CO(2) => \integrate_acc_reg[4]_i_1_n_1\,
      CO(1) => \integrate_acc_reg[4]_i_1_n_2\,
      CO(0) => \integrate_acc_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \integrate_acc[4]_i_2_n_0\,
      DI(2) => \integrate_acc[4]_i_3_n_0\,
      DI(1) => \integrate_acc[4]_i_4_n_0\,
      DI(0) => \integrate_acc[4]_i_5_n_0\,
      O(3) => \integrate_acc_reg[4]_i_1_n_4\,
      O(2) => \integrate_acc_reg[4]_i_1_n_5\,
      O(1) => \integrate_acc_reg[4]_i_1_n_6\,
      O(0) => \integrate_acc_reg[4]_i_1_n_7\,
      S(3) => \integrate_acc[4]_i_6_n_0\,
      S(2) => \integrate_acc[4]_i_7_n_0\,
      S(1) => \integrate_acc[4]_i_8_n_0\,
      S(0) => \integrate_acc[4]_i_9_n_0\
    );
\integrate_acc_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[4]_i_1_n_6\,
      Q => \integrate_acc_reg_n_0_[5]\
    );
\integrate_acc_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[4]_i_1_n_5\,
      Q => i_dump(0)
    );
\integrate_acc_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[4]_i_1_n_4\,
      Q => i_dump(1)
    );
\integrate_acc_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[8]_i_1_n_7\,
      Q => i_dump(2)
    );
\integrate_acc_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \integrate_acc_reg[4]_i_1_n_0\,
      CO(3) => \integrate_acc_reg[8]_i_1_n_0\,
      CO(2) => \integrate_acc_reg[8]_i_1_n_1\,
      CO(1) => \integrate_acc_reg[8]_i_1_n_2\,
      CO(0) => \integrate_acc_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \integrate_acc[8]_i_2_n_0\,
      DI(2) => \integrate_acc[8]_i_3_n_0\,
      DI(1) => \integrate_acc[8]_i_4_n_0\,
      DI(0) => \integrate_acc[8]_i_5_n_0\,
      O(3) => \integrate_acc_reg[8]_i_1_n_4\,
      O(2) => \integrate_acc_reg[8]_i_1_n_5\,
      O(1) => \integrate_acc_reg[8]_i_1_n_6\,
      O(0) => \integrate_acc_reg[8]_i_1_n_7\,
      S(3) => \integrate_acc[8]_i_6_n_0\,
      S(2) => \integrate_acc[8]_i_7_n_0\,
      S(1) => \integrate_acc[8]_i_8_n_0\,
      S(0) => \integrate_acc[8]_i_9_n_0\
    );
\integrate_acc_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \integrate_acc_reg[8]_i_1_n_6\,
      Q => i_dump(3)
    );
\lock_cnt[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => err_small,
      I1 => lock_cnt_reg(0),
      O => \p_0_in__0\(0)
    );
\lock_cnt[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => err_small,
      I1 => lock_cnt_reg(1),
      I2 => lock_cnt_reg(0),
      O => \p_0_in__0\(1)
    );
\lock_cnt[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2A80"
    )
        port map (
      I0 => err_small,
      I1 => lock_cnt_reg(0),
      I2 => lock_cnt_reg(1),
      I3 => lock_cnt_reg(2),
      O => \p_0_in__0\(2)
    );
\lock_cnt[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2AAA8000"
    )
        port map (
      I0 => err_small,
      I1 => lock_cnt_reg(1),
      I2 => lock_cnt_reg(0),
      I3 => lock_cnt_reg(2),
      I4 => lock_cnt_reg(3),
      O => \p_0_in__0\(3)
    );
\lock_cnt[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2AAAAAAA80000000"
    )
        port map (
      I0 => err_small,
      I1 => lock_cnt_reg(2),
      I2 => lock_cnt_reg(0),
      I3 => lock_cnt_reg(1),
      I4 => lock_cnt_reg(3),
      I5 => lock_cnt_reg(4),
      O => \p_0_in__0\(4)
    );
\lock_cnt[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"82"
    )
        port map (
      I0 => err_small,
      I1 => \lock_cnt[5]_i_2_n_0\,
      I2 => lock_cnt_reg(5),
      O => \p_0_in__0\(5)
    );
\lock_cnt[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
        port map (
      I0 => lock_cnt_reg(3),
      I1 => lock_cnt_reg(1),
      I2 => lock_cnt_reg(0),
      I3 => lock_cnt_reg(2),
      I4 => lock_cnt_reg(4),
      O => \lock_cnt[5]_i_2_n_0\
    );
\lock_cnt[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04444444"
    )
        port map (
      I0 => core_bypass_costas,
      I1 => adc_valid_d1,
      I2 => lock_cnt_reg(6),
      I3 => c_locked_i_3_n_0,
      I4 => err_small,
      O => \lock_cnt[6]_i_1_n_0\
    );
\lock_cnt[6]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => err_small,
      I1 => c_locked_i_3_n_0,
      I2 => lock_cnt_reg(6),
      O => \p_0_in__0\(6)
    );
\lock_cnt_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \lock_cnt[6]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \p_0_in__0\(0),
      Q => lock_cnt_reg(0)
    );
\lock_cnt_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \lock_cnt[6]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \p_0_in__0\(1),
      Q => lock_cnt_reg(1)
    );
\lock_cnt_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \lock_cnt[6]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \p_0_in__0\(2),
      Q => lock_cnt_reg(2)
    );
\lock_cnt_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \lock_cnt[6]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \p_0_in__0\(3),
      Q => lock_cnt_reg(3)
    );
\lock_cnt_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \lock_cnt[6]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \p_0_in__0\(4),
      Q => lock_cnt_reg(4)
    );
\lock_cnt_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \lock_cnt[6]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \p_0_in__0\(5),
      Q => lock_cnt_reg(5)
    );
\lock_cnt_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => \lock_cnt[6]_i_1_n_0\,
      CLR => \^aresetn_0\,
      D => \p_0_in__0\(6),
      Q => lock_cnt_reg(6)
    );
mix_ii: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29) => i_out(15),
      A(28) => i_out(15),
      A(27) => i_out(15),
      A(26) => i_out(15),
      A(25) => i_out(15),
      A(24) => i_out(15),
      A(23) => i_out(15),
      A(22) => i_out(15),
      A(21) => i_out(15),
      A(20) => i_out(15),
      A(19) => i_out(15),
      A(18) => i_out(15),
      A(17) => i_out(15),
      A(16) => i_out(15),
      A(15 downto 0) => i_out(15 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_mix_ii_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => \out\(15),
      B(16) => \out\(15),
      B(15 downto 0) => \out\(15 downto 0),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_mix_ii_BCOUT_UNCONNECTED(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_mix_ii_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_mix_ii_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_mix_ii_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => NLW_mix_ii_OVERFLOW_UNCONNECTED,
      P(47 downto 32) => NLW_mix_ii_P_UNCONNECTED(47 downto 32),
      P(31) => mix_ii_n_74,
      P(30 downto 15) => A(15 downto 0),
      P(14) => mix_ii_n_91,
      P(13) => mix_ii_n_92,
      P(12) => mix_ii_n_93,
      P(11) => mix_ii_n_94,
      P(10) => mix_ii_n_95,
      P(9) => mix_ii_n_96,
      P(8) => mix_ii_n_97,
      P(7) => mix_ii_n_98,
      P(6) => mix_ii_n_99,
      P(5) => mix_ii_n_100,
      P(4) => mix_ii_n_101,
      P(3) => mix_ii_n_102,
      P(2) => mix_ii_n_103,
      P(1) => mix_ii_n_104,
      P(0) => mix_ii_n_105,
      PATTERNBDETECT => NLW_mix_ii_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_mix_ii_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47 downto 0) => NLW_mix_ii_PCOUT_UNCONNECTED(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_mix_ii_UNDERFLOW_UNCONNECTED
    );
mix_iq: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29) => q_out(15),
      A(28) => q_out(15),
      A(27) => q_out(15),
      A(26) => q_out(15),
      A(25) => q_out(15),
      A(24) => q_out(15),
      A(23) => q_out(15),
      A(22) => q_out(15),
      A(21) => q_out(15),
      A(20) => q_out(15),
      A(19) => q_out(15),
      A(18) => q_out(15),
      A(17) => q_out(15),
      A(16) => q_out(15),
      A(15 downto 0) => q_out(15 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_mix_iq_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => u_nco_n_34,
      B(16) => u_nco_n_34,
      B(15) => u_nco_n_34,
      B(14) => u_nco_n_35,
      B(13) => u_nco_n_36,
      B(12) => u_nco_n_37,
      B(11) => u_nco_n_38,
      B(10) => u_nco_n_39,
      B(9) => u_nco_n_40,
      B(8) => u_nco_n_41,
      B(7) => u_nco_n_42,
      B(6) => u_nco_n_43,
      B(5) => u_nco_n_44,
      B(4) => u_nco_n_45,
      B(3) => u_nco_n_46,
      B(2) => u_nco_n_47,
      B(1) => u_nco_n_48,
      B(0) => u_nco_n_49,
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_mix_iq_BCOUT_UNCONNECTED(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_mix_iq_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_mix_iq_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_mix_iq_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => NLW_mix_iq_OVERFLOW_UNCONNECTED,
      P(47 downto 32) => NLW_mix_iq_P_UNCONNECTED(47 downto 32),
      P(31) => mix_iq_n_74,
      P(30 downto 15) => B_0(15 downto 0),
      P(14) => mix_iq_n_91,
      P(13) => mix_iq_n_92,
      P(12) => mix_iq_n_93,
      P(11) => mix_iq_n_94,
      P(10) => mix_iq_n_95,
      P(9) => mix_iq_n_96,
      P(8) => mix_iq_n_97,
      P(7) => mix_iq_n_98,
      P(6) => mix_iq_n_99,
      P(5) => mix_iq_n_100,
      P(4) => mix_iq_n_101,
      P(3) => mix_iq_n_102,
      P(2) => mix_iq_n_103,
      P(1) => mix_iq_n_104,
      P(0) => mix_iq_n_105,
      PATTERNBDETECT => NLW_mix_iq_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_mix_iq_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47 downto 0) => NLW_mix_iq_PCOUT_UNCONNECTED(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_mix_iq_UNDERFLOW_UNCONNECTED
    );
mix_qi: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29) => i_out(15),
      A(28) => i_out(15),
      A(27) => i_out(15),
      A(26) => i_out(15),
      A(25) => i_out(15),
      A(24) => i_out(15),
      A(23) => i_out(15),
      A(22) => i_out(15),
      A(21) => i_out(15),
      A(20) => i_out(15),
      A(19) => i_out(15),
      A(18) => i_out(15),
      A(17) => i_out(15),
      A(16) => i_out(15),
      A(15 downto 0) => i_out(15 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_mix_qi_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => u_nco_n_34,
      B(16) => u_nco_n_34,
      B(15) => u_nco_n_34,
      B(14) => u_nco_n_35,
      B(13) => u_nco_n_36,
      B(12) => u_nco_n_37,
      B(11) => u_nco_n_38,
      B(10) => u_nco_n_39,
      B(9) => u_nco_n_40,
      B(8) => u_nco_n_41,
      B(7) => u_nco_n_42,
      B(6) => u_nco_n_43,
      B(5) => u_nco_n_44,
      B(4) => u_nco_n_45,
      B(3) => u_nco_n_46,
      B(2) => u_nco_n_47,
      B(1) => u_nco_n_48,
      B(0) => u_nco_n_49,
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_mix_qi_BCOUT_UNCONNECTED(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_mix_qi_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_mix_qi_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_mix_qi_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => NLW_mix_qi_OVERFLOW_UNCONNECTED,
      P(47 downto 32) => NLW_mix_qi_P_UNCONNECTED(47 downto 32),
      P(31) => mix_qi_n_74,
      P(30 downto 15) => \mix_qi__0\(30 downto 15),
      P(14) => mix_qi_n_91,
      P(13) => mix_qi_n_92,
      P(12) => mix_qi_n_93,
      P(11) => mix_qi_n_94,
      P(10) => mix_qi_n_95,
      P(9) => mix_qi_n_96,
      P(8) => mix_qi_n_97,
      P(7) => mix_qi_n_98,
      P(6) => mix_qi_n_99,
      P(5) => mix_qi_n_100,
      P(4) => mix_qi_n_101,
      P(3) => mix_qi_n_102,
      P(2) => mix_qi_n_103,
      P(1) => mix_qi_n_104,
      P(0) => mix_qi_n_105,
      PATTERNBDETECT => NLW_mix_qi_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_mix_qi_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47 downto 0) => NLW_mix_qi_PCOUT_UNCONNECTED(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_mix_qi_UNDERFLOW_UNCONNECTED
    );
mix_qq: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29) => q_out(15),
      A(28) => q_out(15),
      A(27) => q_out(15),
      A(26) => q_out(15),
      A(25) => q_out(15),
      A(24) => q_out(15),
      A(23) => q_out(15),
      A(22) => q_out(15),
      A(21) => q_out(15),
      A(20) => q_out(15),
      A(19) => q_out(15),
      A(18) => q_out(15),
      A(17) => q_out(15),
      A(16) => q_out(15),
      A(15 downto 0) => q_out(15 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_mix_qq_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => \out\(15),
      B(16) => \out\(15),
      B(15 downto 0) => \out\(15 downto 0),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_mix_qq_BCOUT_UNCONNECTED(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_mix_qq_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_mix_qq_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_mix_qq_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => NLW_mix_qq_OVERFLOW_UNCONNECTED,
      P(47 downto 32) => NLW_mix_qq_P_UNCONNECTED(47 downto 32),
      P(31) => mix_qq_n_74,
      P(30 downto 15) => \mix_qq__0\(30 downto 15),
      P(14) => mix_qq_n_91,
      P(13) => mix_qq_n_92,
      P(12) => mix_qq_n_93,
      P(11) => mix_qq_n_94,
      P(10) => mix_qq_n_95,
      P(9) => mix_qq_n_96,
      P(8) => mix_qq_n_97,
      P(7) => mix_qq_n_98,
      P(6) => mix_qq_n_99,
      P(5) => mix_qq_n_100,
      P(4) => mix_qq_n_101,
      P(3) => mix_qq_n_102,
      P(2) => mix_qq_n_103,
      P(1) => mix_qq_n_104,
      P(0) => mix_qq_n_105,
      PATTERNBDETECT => NLW_mix_qq_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_mix_qq_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47 downto 0) => NLW_mix_qq_PCOUT_UNCONNECTED(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_mix_qq_UNDERFLOW_UNCONNECTED
    );
\p_0_out_inferred__1/cos_out[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"76BEC09D66F3D127"
    )
        port map (
      I0 => sel(5),
      I1 => sel(3),
      I2 => sel(4),
      I3 => sel(0),
      I4 => sel(2),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[0]_i_2_n_0\
    );
\p_0_out_inferred__1/cos_out[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8BB903CF667D6E92"
    )
        port map (
      I0 => sel(5),
      I1 => sel(3),
      I2 => sel(4),
      I3 => sel(0),
      I4 => sel(1),
      I5 => sel(2),
      O => \p_0_out_inferred__1/cos_out[0]_i_3_n_0\
    );
\p_0_out_inferred__1/cos_out[10]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"788F57288770A8D6"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[10]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[10]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EAE71518B7B0484F"
    )
        port map (
      I0 => sel(3),
      I1 => sel(2),
      I2 => sel(4),
      I3 => sel(0),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[10]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out[11]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0BF58000F40A7FFF"
    )
        port map (
      I0 => sel(3),
      I1 => sel(0),
      I2 => sel(1),
      I3 => sel(2),
      I4 => sel(4),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[11]_i_4_n_0\
    );
\p_0_out_inferred__1/cos_out[11]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA1B55E445A6BA59"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[11]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[11]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A2DA75A25D258A5C"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[11]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[11]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DCCCEBFB23331404"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(1),
      I3 => sel(0),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[11]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out[12]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"99DCC6626623399D"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[12]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[12]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9946CC6666B93398"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[12]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[12]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEECDDD11113222"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(1),
      I3 => sel(0),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[12]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => \p_0_out_inferred__1/cos_out[13]_i_2_n_0\,
      I1 => sel(5),
      I2 => \p_0_out_inferred__1/cos_out[13]_i_3_n_0\,
      I3 => sel(6),
      I4 => \p_0_out_inferred__1/cos_out[13]_i_4_n_0\,
      O => p_0_out(13)
    );
\p_0_out_inferred__1/cos_out[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEEE00000111"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(1),
      I3 => sel(0),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[13]_i_2_n_0\
    );
\p_0_out_inferred__1/cos_out[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"22646644DD9B99BA"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[13]_i_3_n_0\
    );
\p_0_out_inferred__1/cos_out[13]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FC88C0CC30BBF333"
    )
        port map (
      I0 => \p_0_out_inferred__1/cos_out[13]_i_5_n_0\,
      I1 => sel(5),
      I2 => \p_0_out_inferred__1/cos_out[14]_i_5_n_0\,
      I3 => sel(4),
      I4 => sel(3),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[13]_i_4_n_0\
    );
\p_0_out_inferred__1/cos_out[13]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"07F8"
    )
        port map (
      I0 => sel(1),
      I1 => sel(0),
      I2 => sel(2),
      I3 => sel(7),
      O => \p_0_out_inferred__1/cos_out[13]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[14]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F8000BFF"
    )
        port map (
      I0 => \p_0_out_inferred__1/cos_out[14]_i_4_n_0\,
      I1 => sel(3),
      I2 => sel(4),
      I3 => sel(5),
      I4 => sel(7),
      O => \p_0_out_inferred__1/cos_out[14]_i_2_n_0\
    );
\p_0_out_inferred__1/cos_out[14]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CDC89D9DCDC89898"
    )
        port map (
      I0 => sel(5),
      I1 => sel(7),
      I2 => sel(3),
      I3 => \p_0_out_inferred__1/cos_out[14]_i_5_n_0\,
      I4 => sel(4),
      I5 => \p_0_out_inferred__1/cos_out[15]_i_2_n_0\,
      O => \p_0_out_inferred__1/cos_out[14]_i_3_n_0\
    );
\p_0_out_inferred__1/cos_out[14]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F807"
    )
        port map (
      I0 => sel(1),
      I1 => sel(0),
      I2 => sel(2),
      I3 => sel(7),
      O => \p_0_out_inferred__1/cos_out[14]_i_4_n_0\
    );
\p_0_out_inferred__1/cos_out[14]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"87"
    )
        port map (
      I0 => sel(1),
      I1 => sel(2),
      I2 => sel(7),
      O => \p_0_out_inferred__1/cos_out[14]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0100FFFFFFFE0000"
    )
        port map (
      I0 => sel(5),
      I1 => sel(3),
      I2 => sel(4),
      I3 => \p_0_out_inferred__1/cos_out[15]_i_2_n_0\,
      I4 => sel(6),
      I5 => sel(7),
      O => p_0_out(15)
    );
\p_0_out_inferred__1/cos_out[15]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00FE"
    )
        port map (
      I0 => sel(0),
      I1 => sel(2),
      I2 => sel(1),
      I3 => sel(7),
      O => \p_0_out_inferred__1/cos_out[15]_i_2_n_0\
    );
\p_0_out_inferred__1/cos_out[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0C6D1EB2EAC09961"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[1]_i_4_n_0\
    );
\p_0_out_inferred__1/cos_out[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"267679FC82B1DF34"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[1]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[1]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C3B9FFE4D616E440"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[1]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[1]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"63959700D67380B9"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(2),
      I3 => sel(0),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[1]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F7AF626A1942FD99"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[2]_i_4_n_0\
    );
\p_0_out_inferred__1/cos_out[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D691E9B7A96F3602"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[2]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[2]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0FC96658D87699BC"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[2]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[2]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"92B9654EF8426FFB"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(2),
      I3 => sel(0),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[2]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAD5352A1DF0F20B"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[3]_i_4_n_0\
    );
\p_0_out_inferred__1/cos_out[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9847699967B8962E"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[3]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"46DE916E99216E92"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[3]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[3]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0544FACAFABB8531"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[3]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"66B59AEA994A6511"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[4]_i_4_n_0\
    );
\p_0_out_inferred__1/cos_out[4]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E0E21F1DF8C5077A"
    )
        port map (
      I0 => sel(3),
      I1 => sel(0),
      I2 => sel(4),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[4]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[4]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6A8ECCCEB5713330"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[4]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[4]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8A2975D665909A6B"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[4]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out[5]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6C3E93C12A53D5AC"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[5]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[5]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"58BC3A96A743C568"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[5]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[5]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D69F10722960EF89"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[5]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D33016C62CCFE93D"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[6]_i_4_n_0\
    );
\p_0_out_inferred__1/cos_out[6]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D7F4280B7D4382BC"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[6]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[6]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DD11044622EEFBB8"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[6]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[6]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C93336CC7F4680BD"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[6]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7053624C8FAC9DB3"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[7]_i_4_n_0\
    );
\p_0_out_inferred__1/cos_out[7]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCD76742332898BD"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(1),
      I3 => sel(0),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[7]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[7]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1DC491C6E23B6E38"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[7]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[7]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E7827775187D888A"
    )
        port map (
      I0 => sel(3),
      I1 => sel(0),
      I2 => sel(2),
      I3 => sel(1),
      I4 => sel(4),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[7]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out[8]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E7B2E2B8184D1D47"
    )
        port map (
      I0 => sel(3),
      I1 => sel(0),
      I2 => sel(4),
      I3 => sel(1),
      I4 => sel(2),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[8]_i_4_n_0\
    );
\p_0_out_inferred__1/cos_out[8]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4B48B4B75A7DA582"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[8]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[8]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1E52DAD8E1AD2526"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[8]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[8]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BDA28888425D7777"
    )
        port map (
      I0 => sel(3),
      I1 => sel(1),
      I2 => sel(2),
      I3 => sel(0),
      I4 => sel(4),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[8]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out[9]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5143AEBCAFBC5043"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \p_0_out_inferred__1/cos_out[9]_i_5_n_0\
    );
\p_0_out_inferred__1/cos_out[9]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"23A7D058DC582FA6"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[9]_i_6_n_0\
    );
\p_0_out_inferred__1/cos_out[9]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CF48CBB730B73448"
    )
        port map (
      I0 => sel(2),
      I1 => sel(3),
      I2 => sel(1),
      I3 => sel(4),
      I4 => sel(0),
      I5 => sel(7),
      O => \p_0_out_inferred__1/cos_out[9]_i_7_n_0\
    );
\p_0_out_inferred__1/cos_out_reg[0]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[0]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[0]_i_3_n_0\,
      O => p_0_out(0),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[10]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[10]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[10]_i_3_n_0\,
      O => p_0_out(10),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[10]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => u_nco_n_25,
      I1 => u_nco_n_26,
      O => \p_0_out_inferred__1/cos_out_reg[10]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[10]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[10]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[10]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[10]_i_3_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[11]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[11]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[11]_i_3_n_0\,
      O => p_0_out(11),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[11]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[11]_i_4_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[11]_i_5_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[11]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[11]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[11]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[11]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[11]_i_3_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[12]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[12]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[12]_i_3_n_0\,
      O => p_0_out(12),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[12]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => u_nco_n_24,
      I1 => \p_0_out_inferred__1/cos_out[12]_i_5_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[12]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[12]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[12]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[12]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[12]_i_3_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[14]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[14]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[14]_i_3_n_0\,
      O => p_0_out(14),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[1]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[1]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[1]_i_3_n_0\,
      O => p_0_out(1),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[1]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[1]_i_4_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[1]_i_5_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[1]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[1]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[1]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[1]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[1]_i_3_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[2]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[2]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[2]_i_3_n_0\,
      O => p_0_out(2),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[2]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[2]_i_4_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[2]_i_5_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[2]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[2]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[2]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[2]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[2]_i_3_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[3]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[3]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[3]_i_3_n_0\,
      O => p_0_out(3),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[3]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[3]_i_4_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[3]_i_5_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[3]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[3]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[3]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[3]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[3]_i_3_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[4]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[4]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[4]_i_3_n_0\,
      O => p_0_out(4),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[4]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[4]_i_4_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[4]_i_5_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[4]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[4]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[4]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[4]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[4]_i_3_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[5]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[5]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[5]_i_3_n_0\,
      O => p_0_out(5),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[5]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => u_nco_n_28,
      I1 => \p_0_out_inferred__1/cos_out[5]_i_5_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[5]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[5]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[5]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[5]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[5]_i_3_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[6]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[6]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[6]_i_3_n_0\,
      O => p_0_out(6),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[6]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[6]_i_4_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[6]_i_5_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[6]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[6]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[6]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[6]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[6]_i_3_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[7]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[7]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[7]_i_3_n_0\,
      O => p_0_out(7),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[7]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[7]_i_4_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[7]_i_5_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[7]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[7]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[7]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[7]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[7]_i_3_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[8]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[8]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[8]_i_3_n_0\,
      O => p_0_out(8),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[8]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[8]_i_4_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[8]_i_5_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[8]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[8]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[8]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[8]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[8]_i_3_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[9]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \p_0_out_inferred__1/cos_out_reg[9]_i_2_n_0\,
      I1 => \p_0_out_inferred__1/cos_out_reg[9]_i_3_n_0\,
      O => p_0_out(9),
      S => sel(6)
    );
\p_0_out_inferred__1/cos_out_reg[9]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => u_nco_n_27,
      I1 => \p_0_out_inferred__1/cos_out[9]_i_5_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[9]_i_2_n_0\,
      S => sel(5)
    );
\p_0_out_inferred__1/cos_out_reg[9]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \p_0_out_inferred__1/cos_out[9]_i_6_n_0\,
      I1 => \p_0_out_inferred__1/cos_out[9]_i_7_n_0\,
      O => \p_0_out_inferred__1/cos_out_reg[9]_i_3_n_0\,
      S => sel(5)
    );
\q_mix[11]_i_11\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(23),
      O => \q_mix[11]_i_11_n_0\
    );
\q_mix[11]_i_12\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(22),
      O => \q_mix[11]_i_12_n_0\
    );
\q_mix[11]_i_13\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(21),
      O => \q_mix[11]_i_13_n_0\
    );
\q_mix[11]_i_14\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(20),
      O => \q_mix[11]_i_14_n_0\
    );
\q_mix[11]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[15]_i_10_n_5\,
      I1 => core_bypass_costas,
      O => \q_mix[11]_i_2_n_0\
    );
\q_mix[11]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[15]_i_10_n_6\,
      I1 => core_bypass_costas,
      O => \q_mix[11]_i_3_n_0\
    );
\q_mix[11]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[15]_i_10_n_7\,
      I1 => core_bypass_costas,
      O => \q_mix[11]_i_4_n_0\
    );
\q_mix[11]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[11]_i_10_n_4\,
      I1 => core_bypass_costas,
      O => \q_mix[11]_i_5_n_0\
    );
\q_mix[15]_i_11\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(30),
      O => \q_mix[15]_i_11_n_0\
    );
\q_mix[15]_i_12\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(29),
      O => \q_mix[15]_i_12_n_0\
    );
\q_mix[15]_i_13\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(28),
      O => \q_mix[15]_i_13_n_0\
    );
\q_mix[15]_i_14\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(27),
      O => \q_mix[15]_i_14_n_0\
    );
\q_mix[15]_i_15\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(26),
      O => \q_mix[15]_i_15_n_0\
    );
\q_mix[15]_i_16\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(25),
      O => \q_mix[15]_i_16_n_0\
    );
\q_mix[15]_i_17\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(24),
      O => \q_mix[15]_i_17_n_0\
    );
\q_mix[15]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[15]_i_9_n_6\,
      I1 => core_bypass_costas,
      O => \q_mix[15]_i_2_n_0\
    );
\q_mix[15]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[15]_i_9_n_7\,
      I1 => core_bypass_costas,
      O => \q_mix[15]_i_3_n_0\
    );
\q_mix[15]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[15]_i_10_n_4\,
      I1 => core_bypass_costas,
      O => \q_mix[15]_i_4_n_0\
    );
\q_mix[3]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[7]_i_10_n_5\,
      I1 => core_bypass_costas,
      O => \q_mix[3]_i_2_n_0\
    );
\q_mix[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[7]_i_10_n_6\,
      I1 => core_bypass_costas,
      O => \q_mix[3]_i_3_n_0\
    );
\q_mix[3]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[7]_i_10_n_7\,
      I1 => core_bypass_costas,
      O => \q_mix[3]_i_4_n_0\
    );
\q_mix[3]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \mix_qi__0\(15),
      I1 => core_bypass_costas,
      O => \q_mix[3]_i_5_n_0\
    );
\q_mix[7]_i_11\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(15),
      O => \q_mix[7]_i_11_n_0\
    );
\q_mix[7]_i_12\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(19),
      O => \q_mix[7]_i_12_n_0\
    );
\q_mix[7]_i_13\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(18),
      O => \q_mix[7]_i_13_n_0\
    );
\q_mix[7]_i_14\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(17),
      O => \q_mix[7]_i_14_n_0\
    );
\q_mix[7]_i_15\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mix_qi__0\(16),
      O => \q_mix[7]_i_15_n_0\
    );
\q_mix[7]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[11]_i_10_n_5\,
      I1 => core_bypass_costas,
      O => \q_mix[7]_i_2_n_0\
    );
\q_mix[7]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[11]_i_10_n_6\,
      I1 => core_bypass_costas,
      O => \q_mix[7]_i_3_n_0\
    );
\q_mix[7]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[11]_i_10_n_7\,
      I1 => core_bypass_costas,
      O => \q_mix[7]_i_4_n_0\
    );
\q_mix[7]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \q_mix_reg[7]_i_10_n_4\,
      I1 => core_bypass_costas,
      O => \q_mix[7]_i_5_n_0\
    );
\q_mix_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_32,
      Q => \^q_mix_reg[0]_0\(0)
    );
\q_mix_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_22,
      Q => q_mix(10)
    );
\q_mix_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_21,
      Q => q_mix(11)
    );
\q_mix_reg[11]_i_10\: unisim.vcomponents.CARRY4
     port map (
      CI => \q_mix_reg[7]_i_10_n_0\,
      CO(3) => \q_mix_reg[11]_i_10_n_0\,
      CO(2) => \q_mix_reg[11]_i_10_n_1\,
      CO(1) => \q_mix_reg[11]_i_10_n_2\,
      CO(0) => \q_mix_reg[11]_i_10_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \q_mix_reg[11]_i_10_n_4\,
      O(2) => \q_mix_reg[11]_i_10_n_5\,
      O(1) => \q_mix_reg[11]_i_10_n_6\,
      O(0) => \q_mix_reg[11]_i_10_n_7\,
      S(3) => \q_mix[11]_i_11_n_0\,
      S(2) => \q_mix[11]_i_12_n_0\,
      S(1) => \q_mix[11]_i_13_n_0\,
      S(0) => \q_mix[11]_i_14_n_0\
    );
\q_mix_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_20,
      Q => q_mix(12)
    );
\q_mix_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_19,
      Q => q_mix(13)
    );
\q_mix_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_18,
      Q => q_mix(14)
    );
\q_mix_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_17,
      Q => q_mix(15)
    );
\q_mix_reg[15]_i_10\: unisim.vcomponents.CARRY4
     port map (
      CI => \q_mix_reg[11]_i_10_n_0\,
      CO(3) => \q_mix_reg[15]_i_10_n_0\,
      CO(2) => \q_mix_reg[15]_i_10_n_1\,
      CO(1) => \q_mix_reg[15]_i_10_n_2\,
      CO(0) => \q_mix_reg[15]_i_10_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \q_mix_reg[15]_i_10_n_4\,
      O(2) => \q_mix_reg[15]_i_10_n_5\,
      O(1) => \q_mix_reg[15]_i_10_n_6\,
      O(0) => \q_mix_reg[15]_i_10_n_7\,
      S(3) => \q_mix[15]_i_14_n_0\,
      S(2) => \q_mix[15]_i_15_n_0\,
      S(1) => \q_mix[15]_i_16_n_0\,
      S(0) => \q_mix[15]_i_17_n_0\
    );
\q_mix_reg[15]_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \q_mix_reg[15]_i_10_n_0\,
      CO(3 downto 2) => \NLW_q_mix_reg[15]_i_9_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \q_mix_reg[15]_i_9_n_2\,
      CO(0) => \q_mix_reg[15]_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_q_mix_reg[15]_i_9_O_UNCONNECTED\(3),
      O(2) => \q_mix_reg[15]_i_9_n_5\,
      O(1) => \q_mix_reg[15]_i_9_n_6\,
      O(0) => \q_mix_reg[15]_i_9_n_7\,
      S(3) => '0',
      S(2) => \q_mix[15]_i_11_n_0\,
      S(1) => \q_mix[15]_i_12_n_0\,
      S(0) => \q_mix[15]_i_13_n_0\
    );
\q_mix_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_31,
      Q => q_mix(1)
    );
\q_mix_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_30,
      Q => q_mix(2)
    );
\q_mix_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_29,
      Q => q_mix(3)
    );
\q_mix_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_28,
      Q => q_mix(4)
    );
\q_mix_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_27,
      Q => q_mix(5)
    );
\q_mix_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_26,
      Q => q_mix(6)
    );
\q_mix_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_25,
      Q => q_mix(7)
    );
\q_mix_reg[7]_i_10\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \q_mix_reg[7]_i_10_n_0\,
      CO(2) => \q_mix_reg[7]_i_10_n_1\,
      CO(1) => \q_mix_reg[7]_i_10_n_2\,
      CO(0) => \q_mix_reg[7]_i_10_n_3\,
      CYINIT => \q_mix[7]_i_11_n_0\,
      DI(3 downto 0) => B"0000",
      O(3) => \q_mix_reg[7]_i_10_n_4\,
      O(2) => \q_mix_reg[7]_i_10_n_5\,
      O(1) => \q_mix_reg[7]_i_10_n_6\,
      O(0) => \q_mix_reg[7]_i_10_n_7\,
      S(3) => \q_mix[7]_i_12_n_0\,
      S(2) => \q_mix[7]_i_13_n_0\,
      S(1) => \q_mix[7]_i_14_n_0\,
      S(0) => \q_mix[7]_i_15_n_0\
    );
\q_mix_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_24,
      Q => q_mix(8)
    );
\q_mix_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => u_agc_n_23,
      Q => q_mix(9)
    );
\sin_out[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A93989E7C47FE61A"
    )
        port map (
      I0 => sel(6),
      I1 => sel(3),
      I2 => sel(4),
      I3 => sel(0),
      I4 => sel(1),
      I5 => sel(2),
      O => \sin_out[0]_i_2_n_0\
    );
\sin_out[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6971F9EC2935E673"
    )
        port map (
      I0 => sel(6),
      I1 => sel(3),
      I2 => sel(2),
      I3 => sel(4),
      I4 => sel(0),
      I5 => sel(1),
      O => \sin_out[0]_i_3_n_0\
    );
\sin_out[10]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8778708FA857D628"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[10]_i_4_n_0\
    );
\sin_out[10]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1518EAE7484FB7B0"
    )
        port map (
      I0 => sel(3),
      I1 => sel(2),
      I2 => sel(4),
      I3 => sel(0),
      I4 => sel(7),
      I5 => sel(1),
      O => \sin_out[10]_i_6_n_0\
    );
\sin_out[11]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5DA225DA8A755CA2"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[11]_i_4_n_0\
    );
\sin_out[11]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0FB58000F04A7FFF"
    )
        port map (
      I0 => sel(3),
      I1 => sel(0),
      I2 => sel(2),
      I3 => sel(1),
      I4 => sel(4),
      I5 => sel(7),
      O => \sin_out[11]_i_5_n_0\
    );
\sin_out[11]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2333DCCC1404EBFB"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(1),
      I3 => sel(0),
      I4 => sel(7),
      I5 => sel(2),
      O => \sin_out[11]_i_6_n_0\
    );
\sin_out[11]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA551BE445BAA659"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[11]_i_7_n_0\
    );
\sin_out[12]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"669933CCB9469866"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(1),
      I5 => sel(2),
      O => \sin_out[12]_i_4_n_0\
    );
\sin_out[12]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1111EEEE3222CDDD"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(1),
      I3 => sel(0),
      I4 => sel(7),
      I5 => sel(2),
      O => \sin_out[12]_i_6_n_0\
    );
\sin_out[12]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9966DC23C639629D"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(1),
      I5 => sel(2),
      O => \sin_out[12]_i_7_n_0\
    );
\sin_out[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \sin_out[13]_i_2_n_0\,
      I1 => sel(5),
      I2 => \sin_out[13]_i_3_n_0\,
      I3 => sel(6),
      I4 => \sin_out[13]_i_4_n_0\,
      O => \sin_out[13]_i_1_n_0\
    );
\sin_out[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C83BCFF3C83B0C30"
    )
        port map (
      I0 => \sin_out[13]_i_5_n_0\,
      I1 => sel(6),
      I2 => sel(3),
      I3 => sel(7),
      I4 => sel(4),
      I5 => \sin_out[13]_i_6_n_0\,
      O => \sin_out[13]_i_2_n_0\
    );
\sin_out[13]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80007FFF"
    )
        port map (
      I0 => sel(1),
      I1 => sel(2),
      I2 => sel(4),
      I3 => sel(3),
      I4 => sel(7),
      O => \sin_out[13]_i_3_n_0\
    );
\sin_out[13]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DD9B99BA22646644"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \sin_out[13]_i_4_n_0\
    );
\sin_out[13]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"95"
    )
        port map (
      I0 => sel(7),
      I1 => sel(1),
      I2 => sel(2),
      O => \sin_out[13]_i_5_n_0\
    );
\sin_out[13]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0F78"
    )
        port map (
      I0 => sel(1),
      I1 => sel(0),
      I2 => sel(7),
      I3 => sel(2),
      O => \sin_out[13]_i_6_n_0\
    );
\sin_out[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3732676737326262"
    )
        port map (
      I0 => sel(6),
      I1 => sel(7),
      I2 => sel(3),
      I3 => \sin_out[14]_i_4_n_0\,
      I4 => sel(4),
      I5 => \sin_out[15]_i_2_n_0\,
      O => \sin_out[14]_i_2_n_0\
    );
\sin_out[14]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F8000BFF"
    )
        port map (
      I0 => \sin_out[14]_i_5_n_0\,
      I1 => sel(3),
      I2 => sel(4),
      I3 => sel(6),
      I4 => sel(7),
      O => \sin_out[14]_i_3_n_0\
    );
\sin_out[14]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => sel(7),
      I1 => sel(2),
      I2 => sel(1),
      O => \sin_out[14]_i_4_n_0\
    );
\sin_out[14]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F087"
    )
        port map (
      I0 => sel(1),
      I1 => sel(0),
      I2 => sel(7),
      I3 => sel(2),
      O => \sin_out[14]_i_5_n_0\
    );
\sin_out[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00FF01FF00FE00"
    )
        port map (
      I0 => sel(5),
      I1 => sel(6),
      I2 => sel(3),
      I3 => sel(7),
      I4 => sel(4),
      I5 => \sin_out[15]_i_2_n_0\,
      O => \sin_out[15]_i_1_n_0\
    );
\sin_out[15]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE00"
    )
        port map (
      I0 => sel(0),
      I1 => sel(2),
      I2 => sel(1),
      I3 => sel(7),
      O => \sin_out[15]_i_2_n_0\
    );
\sin_out[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D616E440C3B9FFE4"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \sin_out[1]_i_4_n_0\
    );
\sin_out[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0C6DEAC01EB29961"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(7),
      I5 => sel(2),
      O => \sin_out[1]_i_5_n_0\
    );
\sin_out[1]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D67380B963959700"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(2),
      I3 => sel(0),
      I4 => sel(1),
      I5 => sel(7),
      O => \sin_out[1]_i_6_n_0\
    );
\sin_out[1]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"268279DF76B1FC34"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(7),
      I5 => sel(2),
      O => \sin_out[1]_i_7_n_0\
    );
\sin_out[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D8760FC999BC6658"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \sin_out[2]_i_4_n_0\
    );
\sin_out[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F719AF4262FD6A99"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(1),
      I5 => sel(2),
      O => \sin_out[2]_i_5_n_0\
    );
\sin_out[2]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"654E92B96FFBF842"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(2),
      I3 => sel(0),
      I4 => sel(7),
      I5 => sel(1),
      O => \sin_out[2]_i_6_n_0\
    );
\sin_out[2]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D691A96FE9B73602"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \sin_out[2]_i_7_n_0\
    );
\sin_out[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"994621DE6E91926E"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[3]_i_4_n_0\
    );
\sin_out[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CA35D52A1DF2F00B"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[3]_i_5_n_0\
    );
\sin_out[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FA0585FABB4431CA"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[3]_i_6_n_0\
    );
\sin_out[3]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9867699647B8992E"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[3]_i_7_n_0\
    );
\sin_out[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B57133306A8ECCCE"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \sin_out[4]_i_4_n_0\
    );
\sin_out[4]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"66999A65B54AEA11"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[4]_i_5_n_0\
    );
\sin_out[4]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"758AD6299A656B90"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[4]_i_6_n_0\
    );
\sin_out[4]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E01FE21DF807C57A"
    )
        port map (
      I0 => sel(3),
      I1 => sel(0),
      I2 => sel(4),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[4]_i_7_n_0\
    );
\sin_out[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A743C56858BC3A96"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \sin_out[5]_i_4_n_0\
    );
\sin_out[5]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"29D6609FEF108972"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(1),
      I5 => sel(2),
      O => \sin_out[5]_i_6_n_0\
    );
\sin_out[5]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6C933EC12AD553AC"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[5]_i_7_n_0\
    );
\sin_out[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"22EEDD11FBB80446"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \sin_out[6]_i_4_n_0\
    );
\sin_out[6]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D32C30CF16E9C63D"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(1),
      I5 => sel(2),
      O => \sin_out[6]_i_5_n_0\
    );
\sin_out[6]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"36C9CC33807FBD46"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[6]_i_6_n_0\
    );
\sin_out[6]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D728F40B7D8243BC"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[6]_i_7_n_0\
    );
\sin_out[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E26E1D913B38C4C6"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(1),
      I4 => sel(7),
      I5 => sel(2),
      O => \sin_out[7]_i_4_n_0\
    );
\sin_out[7]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"708F629D53AC4CB3"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[7]_i_5_n_0\
    );
\sin_out[7]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"187D888AE7827775"
    )
        port map (
      I0 => sel(3),
      I1 => sel(0),
      I2 => sel(2),
      I3 => sel(1),
      I4 => sel(4),
      I5 => sel(7),
      O => \sin_out[7]_i_6_n_0\
    );
\sin_out[7]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCD73328674298BD"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(1),
      I3 => sel(0),
      I4 => sel(7),
      I5 => sel(2),
      O => \sin_out[7]_i_7_n_0\
    );
\sin_out[8]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E1AD25261E52DAD8"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(1),
      I5 => sel(7),
      O => \sin_out[8]_i_4_n_0\
    );
\sin_out[8]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E718B24DE21DB847"
    )
        port map (
      I0 => sel(3),
      I1 => sel(0),
      I2 => sel(4),
      I3 => sel(7),
      I4 => sel(1),
      I5 => sel(2),
      O => \sin_out[8]_i_5_n_0\
    );
\sin_out[8]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"425D7777BDA28888"
    )
        port map (
      I0 => sel(3),
      I1 => sel(1),
      I2 => sel(2),
      I3 => sel(0),
      I4 => sel(4),
      I5 => sel(7),
      O => \sin_out[8]_i_6_n_0\
    );
\sin_out[8]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4BB448B75AA57D82"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(2),
      I5 => sel(1),
      O => \sin_out[8]_i_7_n_0\
    );
\sin_out[9]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DC5823A72FA6D058"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(2),
      I4 => sel(7),
      I5 => sel(1),
      O => \sin_out[9]_i_4_n_0\
    );
\sin_out[9]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"30B73448CF48CBB7"
    )
        port map (
      I0 => sel(2),
      I1 => sel(3),
      I2 => sel(1),
      I3 => sel(4),
      I4 => sel(0),
      I5 => sel(7),
      O => \sin_out[9]_i_6_n_0\
    );
\sin_out[9]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"51AEAF5043BCBC43"
    )
        port map (
      I0 => sel(3),
      I1 => sel(4),
      I2 => sel(0),
      I3 => sel(7),
      I4 => sel(1),
      I5 => sel(2),
      O => \sin_out[9]_i_7_n_0\
    );
\sin_out_reg[0]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[0]_i_2_n_0\,
      I1 => \sin_out[0]_i_3_n_0\,
      O => \sin_out_reg[0]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[10]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[10]_i_2_n_0\,
      I1 => \sin_out_reg[10]_i_3_n_0\,
      O => \sin_out_reg[10]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[10]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[10]_i_4_n_0\,
      I1 => u_nco_n_32,
      O => \sin_out_reg[10]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[10]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[10]_i_6_n_0\,
      I1 => u_nco_n_31,
      O => \sin_out_reg[10]_i_3_n_0\,
      S => sel(6)
    );
\sin_out_reg[11]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[11]_i_2_n_0\,
      I1 => \sin_out_reg[11]_i_3_n_0\,
      O => \sin_out_reg[11]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[11]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[11]_i_4_n_0\,
      I1 => \sin_out[11]_i_5_n_0\,
      O => \sin_out_reg[11]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[11]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[11]_i_6_n_0\,
      I1 => \sin_out[11]_i_7_n_0\,
      O => \sin_out_reg[11]_i_3_n_0\,
      S => sel(6)
    );
\sin_out_reg[12]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[12]_i_2_n_0\,
      I1 => \sin_out_reg[12]_i_3_n_0\,
      O => \sin_out_reg[12]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[12]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[12]_i_4_n_0\,
      I1 => u_nco_n_33,
      O => \sin_out_reg[12]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[12]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[12]_i_6_n_0\,
      I1 => \sin_out[12]_i_7_n_0\,
      O => \sin_out_reg[12]_i_3_n_0\,
      S => sel(6)
    );
\sin_out_reg[14]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[14]_i_2_n_0\,
      I1 => \sin_out[14]_i_3_n_0\,
      O => \sin_out_reg[14]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[1]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[1]_i_2_n_0\,
      I1 => \sin_out_reg[1]_i_3_n_0\,
      O => \sin_out_reg[1]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[1]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[1]_i_4_n_0\,
      I1 => \sin_out[1]_i_5_n_0\,
      O => \sin_out_reg[1]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[1]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[1]_i_6_n_0\,
      I1 => \sin_out[1]_i_7_n_0\,
      O => \sin_out_reg[1]_i_3_n_0\,
      S => sel(6)
    );
\sin_out_reg[2]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[2]_i_2_n_0\,
      I1 => \sin_out_reg[2]_i_3_n_0\,
      O => \sin_out_reg[2]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[2]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[2]_i_4_n_0\,
      I1 => \sin_out[2]_i_5_n_0\,
      O => \sin_out_reg[2]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[2]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[2]_i_6_n_0\,
      I1 => \sin_out[2]_i_7_n_0\,
      O => \sin_out_reg[2]_i_3_n_0\,
      S => sel(6)
    );
\sin_out_reg[3]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[3]_i_2_n_0\,
      I1 => \sin_out_reg[3]_i_3_n_0\,
      O => \sin_out_reg[3]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[3]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[3]_i_4_n_0\,
      I1 => \sin_out[3]_i_5_n_0\,
      O => \sin_out_reg[3]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[3]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[3]_i_6_n_0\,
      I1 => \sin_out[3]_i_7_n_0\,
      O => \sin_out_reg[3]_i_3_n_0\,
      S => sel(6)
    );
\sin_out_reg[4]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[4]_i_2_n_0\,
      I1 => \sin_out_reg[4]_i_3_n_0\,
      O => \sin_out_reg[4]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[4]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[4]_i_4_n_0\,
      I1 => \sin_out[4]_i_5_n_0\,
      O => \sin_out_reg[4]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[4]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[4]_i_6_n_0\,
      I1 => \sin_out[4]_i_7_n_0\,
      O => \sin_out_reg[4]_i_3_n_0\,
      S => sel(6)
    );
\sin_out_reg[5]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[5]_i_2_n_0\,
      I1 => \sin_out_reg[5]_i_3_n_0\,
      O => \sin_out_reg[5]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[5]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[5]_i_4_n_0\,
      I1 => u_nco_n_29,
      O => \sin_out_reg[5]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[5]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[5]_i_6_n_0\,
      I1 => \sin_out[5]_i_7_n_0\,
      O => \sin_out_reg[5]_i_3_n_0\,
      S => sel(6)
    );
\sin_out_reg[6]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[6]_i_2_n_0\,
      I1 => \sin_out_reg[6]_i_3_n_0\,
      O => \sin_out_reg[6]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[6]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[6]_i_4_n_0\,
      I1 => \sin_out[6]_i_5_n_0\,
      O => \sin_out_reg[6]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[6]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[6]_i_6_n_0\,
      I1 => \sin_out[6]_i_7_n_0\,
      O => \sin_out_reg[6]_i_3_n_0\,
      S => sel(6)
    );
\sin_out_reg[7]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[7]_i_2_n_0\,
      I1 => \sin_out_reg[7]_i_3_n_0\,
      O => \sin_out_reg[7]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[7]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[7]_i_4_n_0\,
      I1 => \sin_out[7]_i_5_n_0\,
      O => \sin_out_reg[7]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[7]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[7]_i_6_n_0\,
      I1 => \sin_out[7]_i_7_n_0\,
      O => \sin_out_reg[7]_i_3_n_0\,
      S => sel(6)
    );
\sin_out_reg[8]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[8]_i_2_n_0\,
      I1 => \sin_out_reg[8]_i_3_n_0\,
      O => \sin_out_reg[8]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[8]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[8]_i_4_n_0\,
      I1 => \sin_out[8]_i_5_n_0\,
      O => \sin_out_reg[8]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[8]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[8]_i_6_n_0\,
      I1 => \sin_out[8]_i_7_n_0\,
      O => \sin_out_reg[8]_i_3_n_0\,
      S => sel(6)
    );
\sin_out_reg[9]_i_1\: unisim.vcomponents.MUXF8
     port map (
      I0 => \sin_out_reg[9]_i_2_n_0\,
      I1 => \sin_out_reg[9]_i_3_n_0\,
      O => \sin_out_reg[9]_i_1_n_0\,
      S => sel(5)
    );
\sin_out_reg[9]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[9]_i_4_n_0\,
      I1 => u_nco_n_30,
      O => \sin_out_reg[9]_i_2_n_0\,
      S => sel(6)
    );
\sin_out_reg[9]_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \sin_out[9]_i_6_n_0\,
      I1 => \sin_out[9]_i_7_n_0\,
      O => \sin_out_reg[9]_i_3_n_0\,
      S => sel(6)
    );
sps_counter1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => sps_counter1_carry_n_0,
      CO(2) => sps_counter1_carry_n_1,
      CO(1) => sps_counter1_carry_n_2,
      CO(0) => sps_counter1_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_sps_counter1_carry_O_UNCONNECTED(3 downto 0),
      S(3) => sps_counter1_carry_i_1_n_0,
      S(2) => sps_counter1_carry_i_2_n_0,
      S(1) => sps_counter1_carry_i_3_n_0,
      S(0) => sps_counter1_carry_i_4_n_0
    );
\sps_counter1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => sps_counter1_carry_n_0,
      CO(3) => \sps_counter1_carry__0_n_0\,
      CO(2) => \sps_counter1_carry__0_n_1\,
      CO(1) => \sps_counter1_carry__0_n_2\,
      CO(0) => \sps_counter1_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_sps_counter1_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \sps_counter1_carry__0_i_1_n_0\,
      S(2) => \sps_counter1_carry__0_i_2_n_0\,
      S(1) => \sps_counter1_carry__0_i_3_n_0\,
      S(0) => \sps_counter1_carry__0_i_4_n_0\
    );
\sps_counter1_carry__0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => sps_eff(7),
      I1 => sps_counter1_carry_i_5_n_0,
      I2 => sps_eff(6),
      O => \sps_counter1_carry__0_i_1_n_0\
    );
\sps_counter1_carry__0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => sps_eff(7),
      I1 => sps_counter1_carry_i_5_n_0,
      I2 => sps_eff(6),
      O => \sps_counter1_carry__0_i_2_n_0\
    );
\sps_counter1_carry__0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => sps_eff(7),
      I1 => sps_counter1_carry_i_5_n_0,
      I2 => sps_eff(6),
      O => \sps_counter1_carry__0_i_3_n_0\
    );
\sps_counter1_carry__0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => sps_eff(7),
      I1 => sps_counter1_carry_i_5_n_0,
      I2 => sps_eff(6),
      O => \sps_counter1_carry__0_i_4_n_0\
    );
\sps_counter1_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sps_counter1_carry__0_n_0\,
      CO(3) => \NLW_sps_counter1_carry__1_CO_UNCONNECTED\(3),
      CO(2) => sps_counter1,
      CO(1) => \sps_counter1_carry__1_n_2\,
      CO(0) => \sps_counter1_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_sps_counter1_carry__1_O_UNCONNECTED\(3 downto 0),
      S(3) => '0',
      S(2) => \sps_counter1_carry__1_i_1_n_0\,
      S(1) => \sps_counter1_carry__1_i_2_n_0\,
      S(0) => \sps_counter1_carry__1_i_3_n_0\
    );
\sps_counter1_carry__1_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => sps_eff(7),
      I1 => sps_counter1_carry_i_5_n_0,
      I2 => sps_eff(6),
      O => \sps_counter1_carry__1_i_1_n_0\
    );
\sps_counter1_carry__1_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => sps_eff(7),
      I1 => sps_counter1_carry_i_5_n_0,
      I2 => sps_eff(6),
      O => \sps_counter1_carry__1_i_2_n_0\
    );
\sps_counter1_carry__1_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => sps_eff(7),
      I1 => sps_counter1_carry_i_5_n_0,
      I2 => sps_eff(6),
      O => \sps_counter1_carry__1_i_3_n_0\
    );
sps_counter1_carry_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => sps_eff(7),
      I1 => sps_counter1_carry_i_5_n_0,
      I2 => sps_eff(6),
      O => sps_counter1_carry_i_1_n_0
    );
sps_counter1_carry_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"84422110"
    )
        port map (
      I0 => sps_counter_reg(6),
      I1 => sps_counter_reg(7),
      I2 => sps_eff(6),
      I3 => sps_counter1_carry_i_5_n_0,
      I4 => sps_eff(7),
      O => sps_counter1_carry_i_2_n_0
    );
sps_counter1_carry_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000090090960"
    )
        port map (
      I0 => sps_eff(5),
      I1 => sps_counter_reg(5),
      I2 => sps_counter_reg(4),
      I3 => sps_counter1_carry_i_6_n_0,
      I4 => sps_eff(4),
      I5 => sps_counter1_carry_i_7_n_0,
      O => sps_counter1_carry_i_3_n_0
    );
sps_counter1_carry_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4120000800084120"
    )
        port map (
      I0 => sps_counter_reg(0),
      I1 => sps_counter_reg(1),
      I2 => sps_eff(1),
      I3 => sps_eff(0),
      I4 => sps_counter_reg(2),
      I5 => sps_eff(2),
      O => sps_counter1_carry_i_4_n_0
    );
sps_counter1_carry_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => sps_eff(5),
      I1 => sps_eff(3),
      I2 => sps_eff(0),
      I3 => sps_eff(1),
      I4 => sps_eff(2),
      I5 => sps_eff(4),
      O => sps_counter1_carry_i_5_n_0
    );
sps_counter1_carry_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => sps_eff(3),
      I1 => sps_eff(0),
      I2 => sps_eff(1),
      I3 => sps_eff(2),
      O => sps_counter1_carry_i_6_n_0
    );
sps_counter1_carry_i_7: unisim.vcomponents.LUT5
    generic map(
      INIT => X"5556AAA9"
    )
        port map (
      I0 => sps_counter_reg(3),
      I1 => sps_eff(2),
      I2 => sps_eff(1),
      I3 => sps_eff(0),
      I4 => sps_eff(3),
      O => sps_counter1_carry_i_7_n_0
    );
\sps_counter[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => sps_counter1,
      I1 => sps_counter_reg(0),
      O => p_0_in(0)
    );
\sps_counter[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => sps_counter_reg(1),
      I1 => sps_counter_reg(0),
      I2 => sps_counter1,
      O => p_0_in(1)
    );
\sps_counter[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1540"
    )
        port map (
      I0 => sps_counter1,
      I1 => sps_counter_reg(0),
      I2 => sps_counter_reg(1),
      I3 => sps_counter_reg(2),
      O => \sps_counter[2]_i_1_n_0\
    );
\sps_counter[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"15554000"
    )
        port map (
      I0 => sps_counter1,
      I1 => sps_counter_reg(1),
      I2 => sps_counter_reg(0),
      I3 => sps_counter_reg(2),
      I4 => sps_counter_reg(3),
      O => \sps_counter[3]_i_1_n_0\
    );
\sps_counter[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1555555540000000"
    )
        port map (
      I0 => sps_counter1,
      I1 => sps_counter_reg(2),
      I2 => sps_counter_reg(0),
      I3 => sps_counter_reg(1),
      I4 => sps_counter_reg(3),
      I5 => sps_counter_reg(4),
      O => \sps_counter[4]_i_1_n_0\
    );
\sps_counter[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"41"
    )
        port map (
      I0 => sps_counter1,
      I1 => \sps_counter[5]_i_2_n_0\,
      I2 => sps_counter_reg(5),
      O => \sps_counter[5]_i_1_n_0\
    );
\sps_counter[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
        port map (
      I0 => sps_counter_reg(3),
      I1 => sps_counter_reg(1),
      I2 => sps_counter_reg(0),
      I3 => sps_counter_reg(2),
      I4 => sps_counter_reg(4),
      O => \sps_counter[5]_i_2_n_0\
    );
\sps_counter[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"14"
    )
        port map (
      I0 => sps_counter1,
      I1 => \sps_counter[7]_i_3_n_0\,
      I2 => sps_counter_reg(6),
      O => \sps_counter[6]_i_1_n_0\
    );
\sps_counter[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => core_enable,
      I1 => adc_valid_d1,
      O => sps_counter0
    );
\sps_counter[7]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0078"
    )
        port map (
      I0 => \sps_counter[7]_i_3_n_0\,
      I1 => sps_counter_reg(6),
      I2 => sps_counter_reg(7),
      I3 => sps_counter1,
      O => p_0_in(7)
    );
\sps_counter[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => sps_counter_reg(5),
      I1 => sps_counter_reg(4),
      I2 => sps_counter_reg(2),
      I3 => sps_counter_reg(0),
      I4 => sps_counter_reg(1),
      I5 => sps_counter_reg(3),
      O => \sps_counter[7]_i_3_n_0\
    );
\sps_counter_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => p_0_in(0),
      Q => sps_counter_reg(0)
    );
\sps_counter_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => p_0_in(1),
      Q => sps_counter_reg(1)
    );
\sps_counter_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \sps_counter[2]_i_1_n_0\,
      Q => sps_counter_reg(2)
    );
\sps_counter_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \sps_counter[3]_i_1_n_0\,
      Q => sps_counter_reg(3)
    );
\sps_counter_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \sps_counter[4]_i_1_n_0\,
      Q => sps_counter_reg(4)
    );
\sps_counter_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \sps_counter[5]_i_1_n_0\,
      Q => sps_counter_reg(5)
    );
\sps_counter_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => \sps_counter[6]_i_1_n_0\,
      Q => sps_counter_reg(6)
    );
\sps_counter_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => sps_counter0,
      CLR => \^aresetn_0\,
      D => p_0_in(7),
      Q => sps_counter_reg(7)
    );
\sps_eff[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"9A999599"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(0),
      I1 => \sps_eff[1]_i_2_n_0\,
      I2 => core_bypass_timing,
      I3 => \timing_adj_reg_n_0_[8]\,
      I4 => \sps_eff[6]_i_2_n_0\,
      O => \sps_eff[0]_i_1_n_0\
    );
\sps_eff[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF0CFBFB00F30404"
    )
        port map (
      I0 => \sps_eff[6]_i_2_n_0\,
      I1 => \timing_adj_reg_n_0_[8]\,
      I2 => core_bypass_timing,
      I3 => \sps_eff[1]_i_2_n_0\,
      I4 => \sps_eff_reg[7]_0\(0),
      I5 => \sps_eff_reg[7]_0\(1),
      O => \sps_eff[1]_i_1_n_0\
    );
\sps_eff[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FBFBFFFB"
    )
        port map (
      I0 => core_bypass_timing,
      I1 => \timing_adj_reg_n_0_[0]\,
      I2 => \sps_eff_reg[7]_0\(7),
      I3 => \sps_eff_reg[7]_0\(0),
      I4 => \sps_eff[1]_i_3_n_0\,
      O => \sps_eff[1]_i_2_n_0\
    );
\sps_eff[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(4),
      I1 => \sps_eff_reg[7]_0\(3),
      I2 => \sps_eff_reg[7]_0\(6),
      I3 => \sps_eff_reg[7]_0\(5),
      I4 => \sps_eff_reg[7]_0\(2),
      I5 => \sps_eff_reg[7]_0\(1),
      O => \sps_eff[1]_i_3_n_0\
    );
\sps_eff[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5401FFFF54010000"
    )
        port map (
      I0 => \sps_eff[6]_i_2_n_0\,
      I1 => \sps_eff_reg[7]_0\(0),
      I2 => \sps_eff_reg[7]_0\(1),
      I3 => \sps_eff_reg[7]_0\(2),
      I4 => \sps_eff[5]_i_3_n_0\,
      I5 => \sps_eff[2]_i_2_n_0\,
      O => \sps_eff[2]_i_1_n_0\
    );
\sps_eff[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FDFFFDFF00000300"
    )
        port map (
      I0 => \sps_eff[5]_i_6_n_0\,
      I1 => \sps_eff[5]_i_5_n_0\,
      I2 => core_bypass_timing,
      I3 => \timing_adj_reg_n_0_[0]\,
      I4 => \sps_eff_reg[7]_0\(7),
      I5 => \sps_eff_reg[7]_0\(2),
      O => \sps_eff[2]_i_2_n_0\
    );
\sps_eff[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF2F00100020FF1F"
    )
        port map (
      I0 => \sps_eff[3]_i_2_n_0\,
      I1 => \sps_eff[6]_i_2_n_0\,
      I2 => \timing_adj_reg_n_0_[8]\,
      I3 => core_bypass_timing,
      I4 => \sps_eff_reg[7]_0\(3),
      I5 => \sps_eff[3]_i_3_n_0\,
      O => \sps_eff[3]_i_1_n_0\
    );
\sps_eff[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(2),
      I1 => \sps_eff_reg[7]_0\(1),
      I2 => \sps_eff_reg[7]_0\(0),
      O => \sps_eff[3]_i_2_n_0\
    );
\sps_eff[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFFFFFFFFFFFFF"
    )
        port map (
      I0 => core_bypass_timing,
      I1 => \timing_adj_reg_n_0_[0]\,
      I2 => \sps_eff_reg[7]_0\(1),
      I3 => \sps_eff_reg[7]_0\(0),
      I4 => \sps_eff_reg[7]_0\(2),
      I5 => \sps_eff[5]_i_6_n_0\,
      O => \sps_eff[3]_i_3_n_0\
    );
\sps_eff[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF1F00400010FF4F"
    )
        port map (
      I0 => \sps_eff[6]_i_2_n_0\,
      I1 => \sps_eff[4]_i_2_n_0\,
      I2 => \timing_adj_reg_n_0_[8]\,
      I3 => core_bypass_timing,
      I4 => \sps_eff_reg[7]_0\(4),
      I5 => \sps_eff[5]_i_4_n_0\,
      O => \sps_eff[4]_i_1_n_0\
    );
\sps_eff[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(3),
      I1 => \sps_eff_reg[7]_0\(0),
      I2 => \sps_eff_reg[7]_0\(1),
      I3 => \sps_eff_reg[7]_0\(2),
      O => \sps_eff[4]_i_2_n_0\
    );
\sps_eff[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F10401F4F104F10"
    )
        port map (
      I0 => \sps_eff[6]_i_2_n_0\,
      I1 => \sps_eff[5]_i_2_n_0\,
      I2 => \sps_eff[5]_i_3_n_0\,
      I3 => \sps_eff_reg[7]_0\(5),
      I4 => \sps_eff[5]_i_4_n_0\,
      I5 => \sps_eff_reg[7]_0\(4),
      O => \sps_eff[5]_i_1_n_0\
    );
\sps_eff[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(4),
      I1 => \sps_eff_reg[7]_0\(2),
      I2 => \sps_eff_reg[7]_0\(1),
      I3 => \sps_eff_reg[7]_0\(0),
      I4 => \sps_eff_reg[7]_0\(3),
      O => \sps_eff[5]_i_2_n_0\
    );
\sps_eff[5]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \timing_adj_reg_n_0_[8]\,
      I1 => core_bypass_timing,
      O => \sps_eff[5]_i_3_n_0\
    );
\sps_eff[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF7FFFFFFFFFF"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(3),
      I1 => \sps_eff_reg[7]_0\(2),
      I2 => \sps_eff[5]_i_5_n_0\,
      I3 => \timing_adj_reg_n_0_[0]\,
      I4 => core_bypass_timing,
      I5 => \sps_eff[5]_i_6_n_0\,
      O => \sps_eff[5]_i_4_n_0\
    );
\sps_eff[5]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(0),
      I1 => \sps_eff_reg[7]_0\(1),
      O => \sps_eff[5]_i_5_n_0\
    );
\sps_eff[5]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0D"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(0),
      I1 => \sps_eff[1]_i_3_n_0\,
      I2 => \sps_eff_reg[7]_0\(7),
      O => \sps_eff[5]_i_6_n_0\
    );
\sps_eff[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF14FF00001400"
    )
        port map (
      I0 => \sps_eff[6]_i_2_n_0\,
      I1 => \sps_eff[7]_i_2_n_0\,
      I2 => \sps_eff_reg[7]_0\(6),
      I3 => \timing_adj_reg_n_0_[8]\,
      I4 => core_bypass_timing,
      I5 => \sps_eff[6]_i_3_n_0\,
      O => \sps_eff[6]_i_1_n_0\
    );
\sps_eff[6]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000111"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(2),
      I1 => \sps_eff_reg[7]_0\(7),
      I2 => \sps_eff_reg[7]_0\(0),
      I3 => \sps_eff_reg[7]_0\(1),
      I4 => \sps_eff[6]_i_4_n_0\,
      O => \sps_eff[6]_i_2_n_0\
    );
\sps_eff[6]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BAAA"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(6),
      I1 => \sps_eff[5]_i_4_n_0\,
      I2 => \sps_eff_reg[7]_0\(5),
      I3 => \sps_eff_reg[7]_0\(4),
      O => \sps_eff[6]_i_3_n_0\
    );
\sps_eff[6]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(3),
      I1 => \sps_eff_reg[7]_0\(4),
      I2 => \sps_eff_reg[7]_0\(5),
      I3 => \sps_eff_reg[7]_0\(6),
      O => \sps_eff[6]_i_4_n_0\
    );
\sps_eff[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAA8AAA"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(7),
      I1 => \sps_eff_reg[7]_0\(6),
      I2 => \sps_eff[7]_i_2_n_0\,
      I3 => \timing_adj_reg_n_0_[8]\,
      I4 => core_bypass_timing,
      O => \sps_eff[7]_i_1_n_0\
    );
\sps_eff[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \sps_eff_reg[7]_0\(5),
      I1 => \sps_eff_reg[7]_0\(3),
      I2 => \sps_eff_reg[7]_0\(0),
      I3 => \sps_eff_reg[7]_0\(1),
      I4 => \sps_eff_reg[7]_0\(2),
      I5 => \sps_eff_reg[7]_0\(4),
      O => \sps_eff[7]_i_2_n_0\
    );
\sps_eff_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \sps_eff[0]_i_1_n_0\,
      Q => sps_eff(0)
    );
\sps_eff_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \sps_eff[1]_i_1_n_0\,
      Q => sps_eff(1)
    );
\sps_eff_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \sps_eff[2]_i_1_n_0\,
      Q => sps_eff(2)
    );
\sps_eff_reg[3]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => '1',
      D => \sps_eff[3]_i_1_n_0\,
      PRE => \^aresetn_0\,
      Q => sps_eff(3)
    );
\sps_eff_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \sps_eff[4]_i_1_n_0\,
      Q => sps_eff(4)
    );
\sps_eff_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \sps_eff[5]_i_1_n_0\,
      Q => sps_eff(5)
    );
\sps_eff_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \sps_eff[6]_i_1_n_0\,
      Q => sps_eff(6)
    );
\sps_eff_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => \^aresetn_0\,
      D => \sps_eff[7]_i_1_n_0\,
      Q => sps_eff(7)
    );
timing_adj2: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 16) => B"00000000000000",
      A(15 downto 0) => timing_adj2_0(15 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_timing_adj2_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17 downto 16) => B"00",
      B(15 downto 0) => \^timing_err_out\(15 downto 0),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_timing_adj2_BCOUT_UNCONNECTED(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_timing_adj2_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_timing_adj2_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_timing_adj2_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => NLW_timing_adj2_OVERFLOW_UNCONNECTED,
      P(47 downto 32) => NLW_timing_adj2_P_UNCONNECTED(47 downto 32),
      P(31) => timing_adj2_n_74,
      P(30) => timing_adj2_n_75,
      P(29) => timing_adj2_n_76,
      P(28) => timing_adj2_n_77,
      P(27) => timing_adj2_n_78,
      P(26) => timing_adj2_n_79,
      P(25) => timing_adj2_n_80,
      P(24) => timing_adj2_n_81,
      P(23) => timing_adj2_n_82,
      P(22) => timing_adj2_n_83,
      P(21) => timing_adj2_n_84,
      P(20) => timing_adj2_n_85,
      P(19) => timing_adj2_n_86,
      P(18) => timing_adj2_n_87,
      P(17) => timing_adj2_n_88,
      P(16 downto 8) => timing_adj1(8 downto 0),
      P(7) => timing_adj2_n_98,
      P(6) => timing_adj2_n_99,
      P(5) => timing_adj2_n_100,
      P(4) => timing_adj2_n_101,
      P(3) => timing_adj2_n_102,
      P(2) => timing_adj2_n_103,
      P(1) => timing_adj2_n_104,
      P(0) => timing_adj2_n_105,
      PATTERNBDETECT => NLW_timing_adj2_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_timing_adj2_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47 downto 0) => NLW_timing_adj2_PCOUT_UNCONNECTED(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_timing_adj2_UNDERFLOW_UNCONNECTED
    );
\timing_adj[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => timing_adj1(3),
      I1 => OPMODE(0),
      I2 => timing_int1_n_94,
      O => \timing_adj[0]_i_2_n_0\
    );
\timing_adj[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => timing_adj1(2),
      I1 => OPMODE(0),
      I2 => timing_int1_n_95,
      O => \timing_adj[0]_i_3_n_0\
    );
\timing_adj[0]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => timing_adj1(1),
      I1 => OPMODE(0),
      I2 => timing_int1_n_96,
      O => \timing_adj[0]_i_4_n_0\
    );
\timing_adj[0]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => timing_adj1(0),
      I1 => OPMODE(0),
      I2 => timing_int1_n_97,
      O => \timing_adj[0]_i_5_n_0\
    );
\timing_adj[8]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => timing_adj1(8),
      I1 => OPMODE(0),
      I2 => timing_int1_n_89,
      O => \timing_adj[8]_i_3_n_0\
    );
\timing_adj[8]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => timing_adj1(7),
      I1 => OPMODE(0),
      I2 => timing_int1_n_90,
      O => \timing_adj[8]_i_4_n_0\
    );
\timing_adj[8]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => timing_adj1(6),
      I1 => OPMODE(0),
      I2 => timing_int1_n_91,
      O => \timing_adj[8]_i_5_n_0\
    );
\timing_adj[8]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => timing_adj1(5),
      I1 => OPMODE(0),
      I2 => timing_int1_n_92,
      O => \timing_adj[8]_i_6_n_0\
    );
\timing_adj[8]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => timing_adj1(4),
      I1 => OPMODE(0),
      I2 => timing_int1_n_93,
      O => \timing_adj[8]_i_7_n_0\
    );
\timing_adj_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => timing_int,
      CLR => \^aresetn_0\,
      D => \timing_adj_reg[0]_i_1_n_7\,
      Q => \timing_adj_reg_n_0_[0]\
    );
\timing_adj_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \timing_adj_reg[0]_i_1_n_0\,
      CO(2) => \timing_adj_reg[0]_i_1_n_1\,
      CO(1) => \timing_adj_reg[0]_i_1_n_2\,
      CO(0) => \timing_adj_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => timing_adj1(3 downto 0),
      O(3 downto 1) => \NLW_timing_adj_reg[0]_i_1_O_UNCONNECTED\(3 downto 1),
      O(0) => \timing_adj_reg[0]_i_1_n_7\,
      S(3) => \timing_adj[0]_i_2_n_0\,
      S(2) => \timing_adj[0]_i_3_n_0\,
      S(1) => \timing_adj[0]_i_4_n_0\,
      S(0) => \timing_adj[0]_i_5_n_0\
    );
\timing_adj_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => timing_int,
      CLR => \^aresetn_0\,
      D => \timing_adj_reg[8]_i_1_n_7\,
      Q => \timing_adj_reg_n_0_[8]\
    );
\timing_adj_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timing_adj_reg[8]_i_2_n_0\,
      CO(3 downto 0) => \NLW_timing_adj_reg[8]_i_1_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_timing_adj_reg[8]_i_1_O_UNCONNECTED\(3 downto 1),
      O(0) => \timing_adj_reg[8]_i_1_n_7\,
      S(3 downto 1) => B"000",
      S(0) => \timing_adj[8]_i_3_n_0\
    );
\timing_adj_reg[8]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \timing_adj_reg[0]_i_1_n_0\,
      CO(3) => \timing_adj_reg[8]_i_2_n_0\,
      CO(2) => \timing_adj_reg[8]_i_2_n_1\,
      CO(1) => \timing_adj_reg[8]_i_2_n_2\,
      CO(0) => \timing_adj_reg[8]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => timing_adj1(7 downto 4),
      O(3 downto 0) => \NLW_timing_adj_reg[8]_i_2_O_UNCONNECTED\(3 downto 0),
      S(3) => \timing_adj[8]_i_4_n_0\,
      S(2) => \timing_adj[8]_i_5_n_0\,
      S(1) => \timing_adj[8]_i_6_n_0\,
      S(0) => \timing_adj[8]_i_7_n_0\
    );
\timing_err__0_carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \timing_err__0_carry_n_0\,
      CO(2) => \timing_err__0_carry_n_1\,
      CO(1) => \timing_err__0_carry_n_2\,
      CO(0) => \timing_err__0_carry_n_3\,
      CYINIT => '0',
      DI(3) => \timing_err__0_carry_i_1_n_0\,
      DI(2) => \timing_err__0_carry_i_2_n_0\,
      DI(1) => \timing_err__0_carry_i_3_n_0\,
      DI(0) => i_prev_sign,
      O(3 downto 0) => \^timing_err_out\(3 downto 0),
      S(3) => \timing_err__0_carry_i_4_n_0\,
      S(2) => \timing_err__0_carry_i_5_n_0\,
      S(1) => \timing_err__0_carry_i_6_n_0\,
      S(0) => \timing_err__0_carry_i_7_n_0\
    );
\timing_err__0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \timing_err__0_carry_n_0\,
      CO(3) => \timing_err__0_carry__0_n_0\,
      CO(2) => \timing_err__0_carry__0_n_1\,
      CO(1) => \timing_err__0_carry__0_n_2\,
      CO(0) => \timing_err__0_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => \timing_err__0_carry__0_i_1_n_0\,
      DI(2) => \timing_err__0_carry__0_i_2_n_0\,
      DI(1) => \timing_err__0_carry__0_i_3_n_0\,
      DI(0) => \timing_err__0_carry__0_i_4_n_0\,
      O(3 downto 0) => \^timing_err_out\(7 downto 4),
      S(3) => \timing_err__0_carry__0_i_5_n_0\,
      S(2) => \timing_err__0_carry__0_i_6_n_0\,
      S(1) => \timing_err__0_carry__0_i_7_n_0\,
      S(0) => \timing_err__0_carry__0_i_8_n_0\
    );
\timing_err__0_carry__0_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(6),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(6),
      O => \timing_err__0_carry__0_i_1_n_0\
    );
\timing_err__0_carry__0_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(5),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(5),
      O => \timing_err__0_carry__0_i_2_n_0\
    );
\timing_err__0_carry__0_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(4),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(4),
      O => \timing_err__0_carry__0_i_3_n_0\
    );
\timing_err__0_carry__0_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(3),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(3),
      O => \timing_err__0_carry__0_i_4_n_0\
    );
\timing_err__0_carry__0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(6),
      I1 => i_dump_prev(6),
      I2 => i_dump(7),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(7),
      O => \timing_err__0_carry__0_i_5_n_0\
    );
\timing_err__0_carry__0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(5),
      I1 => i_dump_prev(5),
      I2 => i_dump(6),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(6),
      O => \timing_err__0_carry__0_i_6_n_0\
    );
\timing_err__0_carry__0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(4),
      I1 => i_dump_prev(4),
      I2 => i_dump(5),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(5),
      O => \timing_err__0_carry__0_i_7_n_0\
    );
\timing_err__0_carry__0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(3),
      I1 => i_dump_prev(3),
      I2 => i_dump(4),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(4),
      O => \timing_err__0_carry__0_i_8_n_0\
    );
\timing_err__0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timing_err__0_carry__0_n_0\,
      CO(3) => \timing_err__0_carry__1_n_0\,
      CO(2) => \timing_err__0_carry__1_n_1\,
      CO(1) => \timing_err__0_carry__1_n_2\,
      CO(0) => \timing_err__0_carry__1_n_3\,
      CYINIT => '0',
      DI(3) => \timing_err__0_carry__1_i_1_n_0\,
      DI(2) => \timing_err__0_carry__1_i_2_n_0\,
      DI(1) => \timing_err__0_carry__1_i_3_n_0\,
      DI(0) => \timing_err__0_carry__1_i_4_n_0\,
      O(3 downto 0) => \^timing_err_out\(11 downto 8),
      S(3) => \timing_err__0_carry__1_i_5_n_0\,
      S(2) => \timing_err__0_carry__1_i_6_n_0\,
      S(1) => \timing_err__0_carry__1_i_7_n_0\,
      S(0) => \timing_err__0_carry__1_i_8_n_0\
    );
\timing_err__0_carry__1_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(10),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(10),
      O => \timing_err__0_carry__1_i_1_n_0\
    );
\timing_err__0_carry__1_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(9),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(9),
      O => \timing_err__0_carry__1_i_2_n_0\
    );
\timing_err__0_carry__1_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(8),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(8),
      O => \timing_err__0_carry__1_i_3_n_0\
    );
\timing_err__0_carry__1_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(7),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(7),
      O => \timing_err__0_carry__1_i_4_n_0\
    );
\timing_err__0_carry__1_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(10),
      I1 => i_dump_prev(10),
      I2 => i_dump(11),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(11),
      O => \timing_err__0_carry__1_i_5_n_0\
    );
\timing_err__0_carry__1_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(9),
      I1 => i_dump_prev(9),
      I2 => i_dump(10),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(10),
      O => \timing_err__0_carry__1_i_6_n_0\
    );
\timing_err__0_carry__1_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(8),
      I1 => i_dump_prev(8),
      I2 => i_dump(9),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(9),
      O => \timing_err__0_carry__1_i_7_n_0\
    );
\timing_err__0_carry__1_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(7),
      I1 => i_dump_prev(7),
      I2 => i_dump(8),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(8),
      O => \timing_err__0_carry__1_i_8_n_0\
    );
\timing_err__0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \timing_err__0_carry__1_n_0\,
      CO(3) => \NLW_timing_err__0_carry__2_CO_UNCONNECTED\(3),
      CO(2) => \timing_err__0_carry__2_n_1\,
      CO(1) => \timing_err__0_carry__2_n_2\,
      CO(0) => \timing_err__0_carry__2_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => \timing_err__0_carry__2_i_1_n_0\,
      DI(1) => \timing_err__0_carry__2_i_2_n_0\,
      DI(0) => \timing_err__0_carry__2_i_3_n_0\,
      O(3 downto 0) => \^timing_err_out\(15 downto 12),
      S(3) => \timing_err__0_carry__2_i_4_n_0\,
      S(2) => \timing_err__0_carry__2_i_5_n_0\,
      S(1) => \timing_err__0_carry__2_i_6_n_0\,
      S(0) => \timing_err__0_carry__2_i_7_n_0\
    );
\timing_err__0_carry__2_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(13),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(13),
      O => \timing_err__0_carry__2_i_1_n_0\
    );
\timing_err__0_carry__2_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(12),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(12),
      O => \timing_err__0_carry__2_i_2_n_0\
    );
\timing_err__0_carry__2_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(11),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(11),
      O => \timing_err__0_carry__2_i_3_n_0\
    );
\timing_err__0_carry__2_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F66F"
    )
        port map (
      I0 => i_dump_prev(14),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(14),
      O => \timing_err__0_carry__2_i_4_n_0\
    );
\timing_err__0_carry__2_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(13),
      I1 => i_dump_prev(13),
      I2 => i_dump(14),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(14),
      O => \timing_err__0_carry__2_i_5_n_0\
    );
\timing_err__0_carry__2_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(12),
      I1 => i_dump_prev(12),
      I2 => i_dump(13),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(13),
      O => \timing_err__0_carry__2_i_6_n_0\
    );
\timing_err__0_carry__2_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(11),
      I1 => i_dump_prev(11),
      I2 => i_dump(12),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(12),
      O => \timing_err__0_carry__2_i_7_n_0\
    );
\timing_err__0_carry_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(2),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(2),
      O => \timing_err__0_carry_i_1_n_0\
    );
\timing_err__0_carry_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0990"
    )
        port map (
      I0 => i_dump_prev(1),
      I1 => i_dump(15),
      I2 => i_prev_sign,
      I3 => i_dump(1),
      O => \timing_err__0_carry_i_2_n_0\
    );
\timing_err__0_carry_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"606F"
    )
        port map (
      I0 => i_dump(0),
      I1 => i_prev_sign,
      I2 => i_dump_prev(0),
      I3 => i_dump(15),
      O => \timing_err__0_carry_i_3_n_0\
    );
\timing_err__0_carry_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(2),
      I1 => i_dump_prev(2),
      I2 => i_dump(3),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(3),
      O => \timing_err__0_carry_i_4_n_0\
    );
\timing_err__0_carry_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B4871ED24B78E12D"
    )
        port map (
      I0 => i_dump(1),
      I1 => i_dump_prev(1),
      I2 => i_dump(2),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(2),
      O => \timing_err__0_carry_i_5_n_0\
    );
\timing_err__0_carry_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D287782D2D7887D2"
    )
        port map (
      I0 => i_dump_prev(0),
      I1 => i_dump(0),
      I2 => i_dump(1),
      I3 => i_prev_sign,
      I4 => i_dump(15),
      I5 => i_dump_prev(1),
      O => \timing_err__0_carry_i_6_n_0\
    );
\timing_err__0_carry_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => i_dump_prev(0),
      I1 => i_dump(0),
      O => \timing_err__0_carry_i_7_n_0\
    );
timing_int1: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 0,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 1,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 16) => B"00000000000000",
      A(15 downto 0) => timing_int1_0(15 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_timing_int1_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => \^timing_err_out\(15),
      B(16) => \^timing_err_out\(15),
      B(15 downto 0) => \^timing_err_out\(15 downto 0),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_timing_int1_BCOUT_UNCONNECTED(17 downto 0),
      C(47) => p_0_in0,
      C(46) => p_0_in0,
      C(45) => p_0_in0,
      C(44) => p_0_in0,
      C(43) => p_0_in0,
      C(42) => p_0_in0,
      C(41) => p_0_in0,
      C(40) => p_0_in0,
      C(39) => p_0_in0,
      C(38) => p_0_in0,
      C(37) => p_0_in0,
      C(36) => p_0_in0,
      C(35) => p_0_in0,
      C(34) => p_0_in0,
      C(33) => p_0_in0,
      C(32) => p_0_in0,
      C(31) => p_0_in0,
      C(30) => p_0_in0,
      C(29) => p_0_in0,
      C(28) => p_0_in0,
      C(27) => p_0_in0,
      C(26) => p_0_in0,
      C(25) => p_0_in0,
      C(24) => p_0_in0,
      C(23) => p_0_in0,
      C(22) => timing_int1_n_75,
      C(21) => timing_int1_n_76,
      C(20) => timing_int1_n_77,
      C(19) => timing_int1_n_78,
      C(18) => timing_int1_n_79,
      C(17) => timing_int1_n_80,
      C(16) => timing_int1_n_81,
      C(15) => timing_int1_n_82,
      C(14) => timing_int1_n_83,
      C(13) => timing_int1_n_84,
      C(12) => timing_int1_n_85,
      C(11) => timing_int1_n_86,
      C(10) => timing_int1_n_87,
      C(9) => timing_int1_n_88,
      C(8) => timing_int1_n_89,
      C(7) => timing_int1_n_90,
      C(6) => timing_int1_n_91,
      C(5) => timing_int1_n_92,
      C(4) => timing_int1_n_93,
      C(3) => timing_int1_n_94,
      C(2) => timing_int1_n_95,
      C(1) => timing_int1_n_96,
      C(0) => timing_int1_n_97,
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_timing_int1_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_timing_int1_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => timing_int,
      CLK => aclk,
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_timing_int1_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6) => '0',
      OPMODE(5) => OPMODE(0),
      OPMODE(4) => OPMODE(0),
      OPMODE(3 downto 0) => B"0101",
      OVERFLOW => NLW_timing_int1_OVERFLOW_UNCONNECTED,
      P(47 downto 32) => NLW_timing_int1_P_UNCONNECTED(47 downto 32),
      P(31) => p_0_in0,
      P(30) => timing_int1_n_75,
      P(29) => timing_int1_n_76,
      P(28) => timing_int1_n_77,
      P(27) => timing_int1_n_78,
      P(26) => timing_int1_n_79,
      P(25) => timing_int1_n_80,
      P(24) => timing_int1_n_81,
      P(23) => timing_int1_n_82,
      P(22) => timing_int1_n_83,
      P(21) => timing_int1_n_84,
      P(20) => timing_int1_n_85,
      P(19) => timing_int1_n_86,
      P(18) => timing_int1_n_87,
      P(17) => timing_int1_n_88,
      P(16) => timing_int1_n_89,
      P(15) => timing_int1_n_90,
      P(14) => timing_int1_n_91,
      P(13) => timing_int1_n_92,
      P(12) => timing_int1_n_93,
      P(11) => timing_int1_n_94,
      P(10) => timing_int1_n_95,
      P(9) => timing_int1_n_96,
      P(8) => timing_int1_n_97,
      P(7) => timing_int1_n_98,
      P(6) => timing_int1_n_99,
      P(5) => timing_int1_n_100,
      P(4) => timing_int1_n_101,
      P(3) => timing_int1_n_102,
      P(2) => timing_int1_n_103,
      P(1) => timing_int1_n_104,
      P(0) => timing_int1_n_105,
      PATTERNBDETECT => NLW_timing_int1_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_timing_int1_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47 downto 0) => NLW_timing_int1_PCOUT_UNCONNECTED(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_timing_int1_UNDERFLOW_UNCONNECTED
    );
timing_int1_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => sps_counter1,
      I1 => core_enable,
      I2 => adc_valid_d1,
      I3 => core_bypass_timing,
      O => timing_int
    );
timing_int1_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BAAAAAAA"
    )
        port map (
      I0 => OPMODE(0),
      I1 => core_bypass_timing,
      I2 => adc_valid_d1,
      I3 => core_enable,
      I4 => sps_counter1,
      O => timing_int1_i_2
    );
u_agc: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_agc
     port map (
      A(15 downto 0) => agc_gain_out(15 downto 0),
      D(15) => u_agc_n_17,
      D(14) => u_agc_n_18,
      D(13) => u_agc_n_19,
      D(12) => u_agc_n_20,
      D(11) => u_agc_n_21,
      D(10) => u_agc_n_22,
      D(9) => u_agc_n_23,
      D(8) => u_agc_n_24,
      D(7) => u_agc_n_25,
      D(6) => u_agc_n_26,
      D(5) => u_agc_n_27,
      D(4) => u_agc_n_28,
      D(3) => u_agc_n_29,
      D(2) => u_agc_n_30,
      D(1) => u_agc_n_31,
      D(0) => u_agc_n_32,
      DI(3) => \q_mix[3]_i_2_n_0\,
      DI(2) => \q_mix[3]_i_3_n_0\,
      DI(1) => \q_mix[3]_i_4_n_0\,
      DI(0) => \q_mix[3]_i_5_n_0\,
      E(0) => adc_valid_d10,
      P(0) => \mix_qi__0\(15),
      Q(15 downto 0) => Q(15 downto 0),
      aclk => aclk,
      adc_data(31 downto 0) => adc_data(31 downto 0),
      adc_valid => adc_valid,
      aresetn => aresetn,
      aresetn_0 => \^aresetn_0\,
      core_bypass_agc => core_bypass_agc,
      core_bypass_costas => core_bypass_costas,
      core_enable => core_enable,
      \gain_acc_reg[19]_0\(3 downto 0) => \gain_acc_reg[19]\(3 downto 0),
      \i_mix_reg[11]\(3) => \i_mix[11]_i_2_n_0\,
      \i_mix_reg[11]\(2) => \i_mix[11]_i_3_n_0\,
      \i_mix_reg[11]\(1) => \i_mix[11]_i_4_n_0\,
      \i_mix_reg[11]\(0) => \i_mix[11]_i_5_n_0\,
      \i_mix_reg[15]\(2) => \i_mix[15]_i_2_n_0\,
      \i_mix_reg[15]\(1) => \i_mix[15]_i_3_n_0\,
      \i_mix_reg[15]\(0) => \i_mix[15]_i_4_n_0\,
      \i_mix_reg[15]_0\(15 downto 0) => B_0(15 downto 0),
      \i_mix_reg[15]_1\(15 downto 0) => A(15 downto 0),
      \i_mix_reg[3]\(3) => \i_mix[3]_i_2_n_0\,
      \i_mix_reg[3]\(2) => \i_mix[3]_i_3_n_0\,
      \i_mix_reg[3]\(1) => \i_mix[3]_i_4_n_0\,
      \i_mix_reg[3]\(0) => \i_mix[3]_i_5_n_0\,
      \i_mix_reg[7]\(3) => \i_mix[7]_i_2_n_0\,
      \i_mix_reg[7]\(2) => \i_mix[7]_i_3_n_0\,
      \i_mix_reg[7]\(1) => \i_mix[7]_i_4_n_0\,
      \i_mix_reg[7]\(0) => \i_mix[7]_i_5_n_0\,
      \i_out_reg[15]_0\(15 downto 0) => i_out(15 downto 0),
      \out\(15) => u_agc_n_66,
      \out\(14) => u_agc_n_67,
      \out\(13) => u_agc_n_68,
      \out\(12) => u_agc_n_69,
      \out\(11) => u_agc_n_70,
      \out\(10) => u_agc_n_71,
      \out\(9) => u_agc_n_72,
      \out\(8) => u_agc_n_73,
      \out\(7) => u_agc_n_74,
      \out\(6) => u_agc_n_75,
      \out\(5) => u_agc_n_76,
      \out\(4) => u_agc_n_77,
      \out\(3) => u_agc_n_78,
      \out\(2) => u_agc_n_79,
      \out\(1) => u_agc_n_80,
      \out\(0) => u_agc_n_81,
      p_1_out(14) => \q_mix_reg[15]_i_9_n_5\,
      p_1_out(13) => \q_mix_reg[15]_i_9_n_6\,
      p_1_out(12) => \q_mix_reg[15]_i_9_n_7\,
      p_1_out(11) => \q_mix_reg[15]_i_10_n_4\,
      p_1_out(10) => \q_mix_reg[15]_i_10_n_5\,
      p_1_out(9) => \q_mix_reg[15]_i_10_n_6\,
      p_1_out(8) => \q_mix_reg[15]_i_10_n_7\,
      p_1_out(7) => \q_mix_reg[11]_i_10_n_4\,
      p_1_out(6) => \q_mix_reg[11]_i_10_n_5\,
      p_1_out(5) => \q_mix_reg[11]_i_10_n_6\,
      p_1_out(4) => \q_mix_reg[11]_i_10_n_7\,
      p_1_out(3) => \q_mix_reg[7]_i_10_n_4\,
      p_1_out(2) => \q_mix_reg[7]_i_10_n_5\,
      p_1_out(1) => \q_mix_reg[7]_i_10_n_6\,
      p_1_out(0) => \q_mix_reg[7]_i_10_n_7\,
      \q_mix_reg[11]\(3) => \q_mix[11]_i_2_n_0\,
      \q_mix_reg[11]\(2) => \q_mix[11]_i_3_n_0\,
      \q_mix_reg[11]\(1) => \q_mix[11]_i_4_n_0\,
      \q_mix_reg[11]\(0) => \q_mix[11]_i_5_n_0\,
      \q_mix_reg[15]\(2) => \q_mix[15]_i_2_n_0\,
      \q_mix_reg[15]\(1) => \q_mix[15]_i_3_n_0\,
      \q_mix_reg[15]\(0) => \q_mix[15]_i_4_n_0\,
      \q_mix_reg[15]_0\(15 downto 0) => \mix_qq__0\(30 downto 15),
      \q_mix_reg[7]\(3) => \q_mix[7]_i_2_n_0\,
      \q_mix_reg[7]\(2) => \q_mix[7]_i_3_n_0\,
      \q_mix_reg[7]\(1) => \q_mix[7]_i_4_n_0\,
      \q_mix_reg[7]\(0) => \q_mix[7]_i_5_n_0\,
      \q_out_reg[15]_0\(15 downto 0) => q_out(15 downto 0),
      settled_reg_0(0) => D(0)
    );
u_nco: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_nco
     port map (
      B(14 downto 0) => \^b\(14 downto 0),
      D(15) => \sin_out[15]_i_1_n_0\,
      D(14) => \sin_out_reg[14]_i_1_n_0\,
      D(13) => \sin_out[13]_i_1_n_0\,
      D(12) => \sin_out_reg[12]_i_1_n_0\,
      D(11) => \sin_out_reg[11]_i_1_n_0\,
      D(10) => \sin_out_reg[10]_i_1_n_0\,
      D(9) => \sin_out_reg[9]_i_1_n_0\,
      D(8) => \sin_out_reg[8]_i_1_n_0\,
      D(7) => \sin_out_reg[7]_i_1_n_0\,
      D(6) => \sin_out_reg[6]_i_1_n_0\,
      D(5) => \sin_out_reg[5]_i_1_n_0\,
      D(4) => \sin_out_reg[4]_i_1_n_0\,
      D(3) => \sin_out_reg[3]_i_1_n_0\,
      D(2) => \sin_out_reg[2]_i_1_n_0\,
      D(1) => \sin_out_reg[1]_i_1_n_0\,
      D(0) => \sin_out_reg[0]_i_1_n_0\,
      E(0) => adc_valid_d10,
      Q(0) => i_mix(15),
      aclk => aclk,
      adc_valid => adc_valid,
      core_bypass_costas => core_bypass_costas,
      core_enable => core_enable,
      \cos_out_reg[0]_0\ => \^aresetn_0\,
      \cos_out_reg[15]_0\(15 downto 0) => \out\(15 downto 0),
      \cos_out_reg[15]_1\(15 downto 0) => p_0_out(15 downto 0),
      freq_word2(15 downto 1) => q_mix(15 downto 1),
      freq_word2(0) => \^q_mix_reg[0]_0\(0),
      \phase_acc_reg[27]_0\ => u_nco_n_24,
      \phase_acc_reg[27]_1\ => u_nco_n_25,
      \phase_acc_reg[27]_10\(25) => freq_word(29),
      \phase_acc_reg[27]_10\(24 downto 0) => freq_word(24 downto 0),
      \phase_acc_reg[27]_2\ => u_nco_n_26,
      \phase_acc_reg[27]_3\ => u_nco_n_27,
      \phase_acc_reg[27]_4\ => u_nco_n_28,
      \phase_acc_reg[27]_5\ => u_nco_n_29,
      \phase_acc_reg[27]_6\ => u_nco_n_30,
      \phase_acc_reg[27]_7\ => u_nco_n_31,
      \phase_acc_reg[27]_8\ => u_nco_n_32,
      \phase_acc_reg[27]_9\ => u_nco_n_33,
      \phase_acc_reg[31]_0\(7 downto 0) => sel(7 downto 0),
      phase_err_p0(14 downto 0) => phase_err_p0(15 downto 1),
      \sin_out_reg[15]_0\(15) => u_nco_n_34,
      \sin_out_reg[15]_0\(14) => u_nco_n_35,
      \sin_out_reg[15]_0\(13) => u_nco_n_36,
      \sin_out_reg[15]_0\(12) => u_nco_n_37,
      \sin_out_reg[15]_0\(11) => u_nco_n_38,
      \sin_out_reg[15]_0\(10) => u_nco_n_39,
      \sin_out_reg[15]_0\(9) => u_nco_n_40,
      \sin_out_reg[15]_0\(8) => u_nco_n_41,
      \sin_out_reg[15]_0\(7) => u_nco_n_42,
      \sin_out_reg[15]_0\(6) => u_nco_n_43,
      \sin_out_reg[15]_0\(5) => u_nco_n_44,
      \sin_out_reg[15]_0\(4) => u_nco_n_45,
      \sin_out_reg[15]_0\(3) => u_nco_n_46,
      \sin_out_reg[15]_0\(2) => u_nco_n_47,
      \sin_out_reg[15]_0\(1) => u_nco_n_48,
      \sin_out_reg[15]_0\(0) => u_nco_n_49
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_v1_0 is
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
    adc_data : in STD_LOGIC_VECTOR ( 63 downto 0 );
    adc_valid : in STD_LOGIC;
    M_AXIS_BITS_TDATA : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXIS_BITS_TVALID : out STD_LOGIC;
    M_AXIS_BITS_TREADY : in STD_LOGIC
  );
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_v1_0 : entity is 8;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_v1_0 : entity is 32;
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_v1_0;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_v1_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^s_axi_arready\ : STD_LOGIC;
  signal \^s_axi_bvalid\ : STD_LOGIC;
  signal \^s_axi_rvalid\ : STD_LOGIC;
  signal agc_gain_ff1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \aw_addr_reg_n_0_[7]\ : STD_LOGIC;
  signal aw_done : STD_LOGIC;
  signal aw_done_i_1_n_0 : STD_LOGIC;
  signal axi_arready0 : STD_LOGIC;
  signal axi_awready0 : STD_LOGIC;
  signal axi_bvalid_i_1_n_0 : STD_LOGIC;
  signal \axi_rdata[0]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[0]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[0]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[0]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[0]_i_5_n_0\ : STD_LOGIC;
  signal \axi_rdata[10]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[10]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[10]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[10]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[11]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[11]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[11]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[11]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[12]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[12]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[12]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[12]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[13]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[13]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[13]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[13]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[14]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[14]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[14]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[14]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[15]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[15]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[15]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[15]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[15]_i_5_n_0\ : STD_LOGIC;
  signal \axi_rdata[15]_i_6_n_0\ : STD_LOGIC;
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
  signal \axi_rdata[1]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[1]_i_5_n_0\ : STD_LOGIC;
  signal \axi_rdata[20]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[21]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[22]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[23]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[24]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[25]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[26]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[27]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[28]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[29]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[2]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[2]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[2]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[2]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[2]_i_5_n_0\ : STD_LOGIC;
  signal \axi_rdata[30]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[31]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[31]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[3]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[3]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[3]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[3]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[3]_i_5_n_0\ : STD_LOGIC;
  signal \axi_rdata[4]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[4]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[4]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[4]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[4]_i_5_n_0\ : STD_LOGIC;
  signal \axi_rdata[5]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[5]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[5]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[5]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[5]_i_5_n_0\ : STD_LOGIC;
  signal \axi_rdata[6]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[6]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[6]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[6]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[6]_i_5_n_0\ : STD_LOGIC;
  signal \axi_rdata[7]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[7]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[7]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[7]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[7]_i_5_n_0\ : STD_LOGIC;
  signal \axi_rdata[8]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[8]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[8]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[8]_i_4_n_0\ : STD_LOGIC;
  signal \axi_rdata[9]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[9]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[9]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[9]_i_4_n_0\ : STD_LOGIC;
  signal axi_rvalid_i_1_n_0 : STD_LOGIC;
  signal axi_wready0 : STD_LOGIC;
  signal axireg_agc_ki_shift : STD_LOGIC;
  signal axireg_agc_target : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \axireg_agc_target[15]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_agc_target[7]_i_1_n_0\ : STD_LOGIC;
  signal axireg_costas_ki : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \axireg_costas_ki[15]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_costas_ki[7]_i_1_n_0\ : STD_LOGIC;
  signal axireg_costas_kp : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \axireg_costas_kp[15]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_costas_kp[7]_i_1_n_0\ : STD_LOGIC;
  signal axireg_enable : STD_LOGIC;
  signal axireg_enable_i_2_n_0 : STD_LOGIC;
  signal axireg_sps : STD_LOGIC;
  signal \axireg_sps[7]_i_2_n_0\ : STD_LOGIC;
  signal \axireg_sps_reg_n_0_[0]\ : STD_LOGIC;
  signal \axireg_sps_reg_n_0_[1]\ : STD_LOGIC;
  signal \axireg_sps_reg_n_0_[2]\ : STD_LOGIC;
  signal \axireg_sps_reg_n_0_[3]\ : STD_LOGIC;
  signal \axireg_sps_reg_n_0_[4]\ : STD_LOGIC;
  signal \axireg_sps_reg_n_0_[5]\ : STD_LOGIC;
  signal \axireg_sps_reg_n_0_[6]\ : STD_LOGIC;
  signal \axireg_sps_reg_n_0_[7]\ : STD_LOGIC;
  signal axireg_timing_ki : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \axireg_timing_ki[15]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_timing_ki[15]_i_2_n_0\ : STD_LOGIC;
  signal \axireg_timing_ki[7]_i_1_n_0\ : STD_LOGIC;
  signal axireg_timing_kp : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \axireg_timing_kp[15]_i_1_n_0\ : STD_LOGIC;
  signal \axireg_timing_kp[7]_i_1_n_0\ : STD_LOGIC;
  signal bit_cnt_ff1 : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal \bit_cnt_ff2_reg_n_0_[0]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[10]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[11]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[12]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[13]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[14]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[15]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[16]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[17]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[18]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[19]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[1]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[20]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[21]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[22]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[23]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[24]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[25]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[26]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[27]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[28]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[29]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[2]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[30]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[31]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[3]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[4]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[5]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[6]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[7]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[8]\ : STD_LOGIC;
  signal \bit_cnt_ff2_reg_n_0_[9]\ : STD_LOGIC;
  signal core_agc_ki_shift : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal core_agc_target : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal core_bypass_agc : STD_LOGIC;
  signal core_bypass_costas : STD_LOGIC;
  signal core_bypass_timing : STD_LOGIC;
  signal core_costas_ki : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal core_costas_kp : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal core_enable : STD_LOGIC;
  signal core_sps : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal core_timing_ki : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal core_timing_kp : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal data0 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal data12 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal data4 : STD_LOGIC_VECTOR ( 19 downto 0 );
  signal do_write : STD_LOGIC;
  signal freq_int : STD_LOGIC;
  signal freq_int1_i_2_n_0 : STD_LOGIC;
  signal locked_ff : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal p_0_in : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal p_0_in0 : STD_LOGIC;
  signal \p_0_in__0\ : STD_LOGIC;
  signal p_1_in : STD_LOGIC;
  signal p_1_in0 : STD_LOGIC;
  signal phase_err_ff1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal phase_err_ff2 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal q_mix : STD_LOGIC_VECTOR ( 0 to 0 );
  signal raw_agc_gain : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal raw_agc_settled : STD_LOGIC;
  signal raw_bit_count : STD_LOGIC_VECTOR ( 39 downto 0 );
  signal raw_carrier_locked : STD_LOGIC;
  signal raw_phase_err : STD_LOGIC_VECTOR ( 15 downto 1 );
  signal raw_timing_err : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal settled_ff : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal snap_agc_ki_shift : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal snap_agc_target : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal snap_bypass_agc : STD_LOGIC;
  signal snap_bypass_costas : STD_LOGIC;
  signal snap_bypass_timing : STD_LOGIC;
  signal snap_costas_ki : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal snap_costas_kp : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal snap_enable : STD_LOGIC;
  signal snap_sps : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal snap_timing_ki : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal snap_timing_kp : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal timing_err_ff1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal timing_err_ff2 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal timing_int1_i_2_n_0 : STD_LOGIC;
  signal u_demod_core_n_0 : STD_LOGIC;
  signal u_demod_core_n_17 : STD_LOGIC;
  signal \w_data_reg_n_0_[0]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[10]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[11]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[12]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[13]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[14]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[15]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[16]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[17]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[18]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[19]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[1]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[2]\ : STD_LOGIC;
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
  signal wr_pulse_axi : STD_LOGIC;
  signal wr_pulse_core : STD_LOGIC;
  signal \wr_pulse_sync_reg_n_0_[0]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \axi_rdata[0]_i_4\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \axi_rdata[15]_i_4\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \axi_rdata[15]_i_5\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \axi_rdata[16]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \axi_rdata[17]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \axi_rdata[18]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \axi_rdata[19]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \axi_rdata[31]_i_2\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \axi_rdata[7]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \axi_rdata[7]_i_3\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of axireg_enable_i_2 : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \axireg_sps[7]_i_2\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \axireg_timing_ki[15]_i_2\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of wr_pulse_axi_i_1 : label is "soft_lutpair32";
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
\agc_gain_ff1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(0),
      Q => agc_gain_ff1(0),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(10),
      Q => agc_gain_ff1(10),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(11),
      Q => agc_gain_ff1(11),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[12]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(12),
      Q => agc_gain_ff1(12),
      S => \p_0_in__0\
    );
\agc_gain_ff1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(13),
      Q => agc_gain_ff1(13),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(14),
      Q => agc_gain_ff1(14),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(15),
      Q => agc_gain_ff1(15),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(1),
      Q => agc_gain_ff1(1),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(2),
      Q => agc_gain_ff1(2),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(3),
      Q => agc_gain_ff1(3),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(4),
      Q => agc_gain_ff1(4),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(5),
      Q => agc_gain_ff1(5),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(6),
      Q => agc_gain_ff1(6),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(7),
      Q => agc_gain_ff1(7),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(8),
      Q => agc_gain_ff1(8),
      R => \p_0_in__0\
    );
\agc_gain_ff1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_gain(9),
      Q => agc_gain_ff1(9),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(0),
      Q => data4(0),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(10),
      Q => data4(10),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(11),
      Q => data4(11),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[12]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(12),
      Q => data4(12),
      S => \p_0_in__0\
    );
\agc_gain_ff2_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(13),
      Q => data4(13),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(14),
      Q => data4(14),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(15),
      Q => data4(15),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(1),
      Q => data4(1),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(2),
      Q => data4(2),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(3),
      Q => data4(3),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(4),
      Q => data4(4),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(5),
      Q => data4(5),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(6),
      Q => data4(6),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(7),
      Q => data4(7),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(8),
      Q => data4(8),
      R => \p_0_in__0\
    );
\agc_gain_ff2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => agc_gain_ff1(9),
      Q => data4(9),
      R => \p_0_in__0\
    );
\aw_addr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(2),
      Q => p_0_in(0),
      R => \p_0_in__0\
    );
\aw_addr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(3),
      Q => p_0_in(1),
      R => \p_0_in__0\
    );
\aw_addr_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(4),
      Q => p_0_in(2),
      R => \p_0_in__0\
    );
\aw_addr_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(5),
      Q => p_0_in(3),
      R => \p_0_in__0\
    );
\aw_addr_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(6),
      Q => p_0_in0,
      R => \p_0_in__0\
    );
\aw_addr_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_awready0,
      D => S_AXI_AWADDR(7),
      Q => \aw_addr_reg_n_0_[7]\,
      R => \p_0_in__0\
    );
aw_done_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00E0E0E0"
    )
        port map (
      I0 => S_AXI_AWVALID,
      I1 => aw_done,
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
      R => \p_0_in__0\
    );
axi_awready_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => S_AXI_ARESETN,
      O => \p_0_in__0\
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
      R => \p_0_in__0\
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
      R => \p_0_in__0\
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
      I4 => \axi_rdata[0]_i_4_n_0\,
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[0]_i_1_n_0\
    );
\axi_rdata[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFCFAFC0"
    )
        port map (
      I0 => axireg_agc_target(0),
      I1 => \axireg_sps_reg_n_0_[0]\,
      I2 => S_AXI_ARADDR(3),
      I3 => S_AXI_ARADDR(2),
      I4 => data0(0),
      O => \axi_rdata[0]_i_2_n_0\
    );
\axi_rdata[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(0),
      I1 => axireg_costas_ki(0),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(0),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(0),
      O => \axi_rdata[0]_i_3_n_0\
    );
\axi_rdata[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CACAFACA"
    )
        port map (
      I0 => \axi_rdata[0]_i_5_n_0\,
      I1 => S_AXI_ARADDR(3),
      I2 => S_AXI_ARADDR(4),
      I3 => data12(0),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[0]_i_4_n_0\
    );
\axi_rdata[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[0]\,
      I1 => timing_err_ff2(0),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(0),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(0),
      O => \axi_rdata[0]_i_5_n_0\
    );
\axi_rdata[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE2EE2222"
    )
        port map (
      I0 => \axi_rdata[10]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[10]_i_3_n_0\,
      I3 => \axi_rdata[15]_i_4_n_0\,
      I4 => \axi_rdata[15]_i_5_n_0\,
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[10]_i_1_n_0\
    );
\axi_rdata[10]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8888888"
    )
        port map (
      I0 => \axi_rdata[10]_i_4_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_agc_target(10),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[10]_i_2_n_0\
    );
\axi_rdata[10]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[10]\,
      I1 => timing_err_ff2(10),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(10),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(10),
      O => \axi_rdata[10]_i_3_n_0\
    );
\axi_rdata[10]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(10),
      I1 => axireg_costas_ki(10),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(10),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(10),
      O => \axi_rdata[10]_i_4_n_0\
    );
\axi_rdata[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE2EE2222"
    )
        port map (
      I0 => \axi_rdata[11]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[11]_i_3_n_0\,
      I3 => \axi_rdata[15]_i_4_n_0\,
      I4 => \axi_rdata[15]_i_5_n_0\,
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[11]_i_1_n_0\
    );
\axi_rdata[11]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8888888"
    )
        port map (
      I0 => \axi_rdata[11]_i_4_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_agc_target(11),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[11]_i_2_n_0\
    );
\axi_rdata[11]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[11]\,
      I1 => timing_err_ff2(11),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(11),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(11),
      O => \axi_rdata[11]_i_3_n_0\
    );
\axi_rdata[11]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(11),
      I1 => axireg_costas_ki(11),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(11),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(11),
      O => \axi_rdata[11]_i_4_n_0\
    );
\axi_rdata[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE2EE2222"
    )
        port map (
      I0 => \axi_rdata[12]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[12]_i_3_n_0\,
      I3 => \axi_rdata[15]_i_4_n_0\,
      I4 => \axi_rdata[15]_i_5_n_0\,
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[12]_i_1_n_0\
    );
\axi_rdata[12]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8888888"
    )
        port map (
      I0 => \axi_rdata[12]_i_4_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_agc_target(12),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[12]_i_2_n_0\
    );
\axi_rdata[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[12]\,
      I1 => timing_err_ff2(12),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(12),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(12),
      O => \axi_rdata[12]_i_3_n_0\
    );
\axi_rdata[12]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(12),
      I1 => axireg_costas_ki(12),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(12),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(12),
      O => \axi_rdata[12]_i_4_n_0\
    );
\axi_rdata[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE2EE2222"
    )
        port map (
      I0 => \axi_rdata[13]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[13]_i_3_n_0\,
      I3 => \axi_rdata[15]_i_4_n_0\,
      I4 => \axi_rdata[15]_i_5_n_0\,
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[13]_i_1_n_0\
    );
\axi_rdata[13]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8888888"
    )
        port map (
      I0 => \axi_rdata[13]_i_4_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_agc_target(13),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[13]_i_2_n_0\
    );
\axi_rdata[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[13]\,
      I1 => timing_err_ff2(13),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(13),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(13),
      O => \axi_rdata[13]_i_3_n_0\
    );
\axi_rdata[13]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(13),
      I1 => axireg_costas_ki(13),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(13),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(13),
      O => \axi_rdata[13]_i_4_n_0\
    );
\axi_rdata[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000E2222222"
    )
        port map (
      I0 => \axi_rdata[14]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[15]_i_4_n_0\,
      I3 => \axi_rdata[14]_i_3_n_0\,
      I4 => \axi_rdata[15]_i_5_n_0\,
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[14]_i_1_n_0\
    );
\axi_rdata[14]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8888888"
    )
        port map (
      I0 => \axi_rdata[14]_i_4_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_agc_target(14),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[14]_i_2_n_0\
    );
\axi_rdata[14]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[14]\,
      I1 => timing_err_ff2(14),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(14),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(14),
      O => \axi_rdata[14]_i_3_n_0\
    );
\axi_rdata[14]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(14),
      I1 => axireg_costas_ki(14),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(14),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(14),
      O => \axi_rdata[14]_i_4_n_0\
    );
\axi_rdata[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE2EE2222"
    )
        port map (
      I0 => \axi_rdata[15]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[15]_i_3_n_0\,
      I3 => \axi_rdata[15]_i_4_n_0\,
      I4 => \axi_rdata[15]_i_5_n_0\,
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[15]_i_1_n_0\
    );
\axi_rdata[15]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8888888"
    )
        port map (
      I0 => \axi_rdata[15]_i_6_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_agc_target(15),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[15]_i_2_n_0\
    );
\axi_rdata[15]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[15]\,
      I1 => timing_err_ff2(15),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(15),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(15),
      O => \axi_rdata[15]_i_3_n_0\
    );
\axi_rdata[15]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"5D"
    )
        port map (
      I0 => S_AXI_ARADDR(4),
      I1 => S_AXI_ARADDR(2),
      I2 => S_AXI_ARADDR(3),
      O => \axi_rdata[15]_i_4_n_0\
    );
\axi_rdata[15]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => S_AXI_ARADDR(4),
      O => \axi_rdata[15]_i_5_n_0\
    );
\axi_rdata[15]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(15),
      I1 => axireg_costas_ki(15),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(15),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(15),
      O => \axi_rdata[15]_i_6_n_0\
    );
\axi_rdata[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \axi_rdata[16]_i_2_n_0\,
      I1 => S_AXI_ARADDR(6),
      I2 => S_AXI_ARADDR(7),
      O => \axi_rdata[16]_i_1_n_0\
    );
\axi_rdata[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C8C0C8C0C030C000"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[16]\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data4(16),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[16]_i_2_n_0\
    );
\axi_rdata[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => \axi_rdata[17]_i_2_n_0\,
      I1 => S_AXI_ARADDR(6),
      I2 => S_AXI_ARADDR(7),
      O => \axi_rdata[17]_i_1_n_0\
    );
\axi_rdata[17]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0800080000300000"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[17]\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data4(17),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[17]_i_2_n_0\
    );
\axi_rdata[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \axi_rdata[18]_i_2_n_0\,
      I1 => S_AXI_ARADDR(6),
      I2 => S_AXI_ARADDR(7),
      O => \axi_rdata[18]_i_1_n_0\
    );
\axi_rdata[18]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C800C800C030C000"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[18]\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data4(18),
      I5 => S_AXI_ARADDR(2),
      O => \axi_rdata[18]_i_2_n_0\
    );
\axi_rdata[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \axi_rdata[19]_i_2_n_0\,
      I1 => S_AXI_ARADDR(6),
      I2 => S_AXI_ARADDR(7),
      O => \axi_rdata[19]_i_1_n_0\
    );
\axi_rdata[19]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C800C800C030C000"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[19]\,
      I1 => S_AXI_ARADDR(5),
      I2 => S_AXI_ARADDR(4),
      I3 => S_AXI_ARADDR(3),
      I4 => data4(19),
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
      I4 => \axi_rdata[1]_i_4_n_0\,
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[1]_i_1_n_0\
    );
\axi_rdata[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_agc_target(1),
      I1 => \axireg_sps_reg_n_0_[1]\,
      I2 => S_AXI_ARADDR(3),
      I3 => data0(0),
      I4 => S_AXI_ARADDR(2),
      I5 => data0(1),
      O => \axi_rdata[1]_i_2_n_0\
    );
\axi_rdata[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(1),
      I1 => axireg_costas_ki(1),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(1),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(1),
      O => \axi_rdata[1]_i_3_n_0\
    );
\axi_rdata[1]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CACAFACA"
    )
        port map (
      I0 => \axi_rdata[1]_i_5_n_0\,
      I1 => S_AXI_ARADDR(3),
      I2 => S_AXI_ARADDR(4),
      I3 => data12(1),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[1]_i_4_n_0\
    );
\axi_rdata[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[1]\,
      I1 => timing_err_ff2(1),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(1),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(1),
      O => \axi_rdata[1]_i_5_n_0\
    );
\axi_rdata[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000800000"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => \bit_cnt_ff2_reg_n_0_[20]\,
      I2 => S_AXI_ARADDR(2),
      I3 => S_AXI_ARADDR(4),
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[20]_i_1_n_0\
    );
\axi_rdata[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE0A00000"
    )
        port map (
      I0 => S_AXI_ARADDR(4),
      I1 => S_AXI_ARADDR(2),
      I2 => S_AXI_ARADDR(3),
      I3 => \bit_cnt_ff2_reg_n_0_[21]\,
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[21]_i_1_n_0\
    );
\axi_rdata[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000800000"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => \bit_cnt_ff2_reg_n_0_[22]\,
      I2 => S_AXI_ARADDR(2),
      I3 => S_AXI_ARADDR(4),
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[22]_i_1_n_0\
    );
\axi_rdata[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE0A00000"
    )
        port map (
      I0 => S_AXI_ARADDR(4),
      I1 => S_AXI_ARADDR(2),
      I2 => S_AXI_ARADDR(3),
      I3 => \bit_cnt_ff2_reg_n_0_[23]\,
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[23]_i_1_n_0\
    );
\axi_rdata[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000800000"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => \bit_cnt_ff2_reg_n_0_[24]\,
      I2 => S_AXI_ARADDR(2),
      I3 => S_AXI_ARADDR(4),
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[24]_i_1_n_0\
    );
\axi_rdata[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE0A00000"
    )
        port map (
      I0 => S_AXI_ARADDR(4),
      I1 => S_AXI_ARADDR(2),
      I2 => S_AXI_ARADDR(3),
      I3 => \bit_cnt_ff2_reg_n_0_[25]\,
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[25]_i_1_n_0\
    );
\axi_rdata[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE0A00000"
    )
        port map (
      I0 => S_AXI_ARADDR(4),
      I1 => S_AXI_ARADDR(2),
      I2 => S_AXI_ARADDR(3),
      I3 => \bit_cnt_ff2_reg_n_0_[26]\,
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[26]_i_1_n_0\
    );
\axi_rdata[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE0A00000"
    )
        port map (
      I0 => S_AXI_ARADDR(4),
      I1 => S_AXI_ARADDR(2),
      I2 => S_AXI_ARADDR(3),
      I3 => \bit_cnt_ff2_reg_n_0_[27]\,
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[27]_i_1_n_0\
    );
\axi_rdata[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE0A00000"
    )
        port map (
      I0 => S_AXI_ARADDR(4),
      I1 => S_AXI_ARADDR(2),
      I2 => S_AXI_ARADDR(3),
      I3 => \bit_cnt_ff2_reg_n_0_[28]\,
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[28]_i_1_n_0\
    );
\axi_rdata[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000800000"
    )
        port map (
      I0 => S_AXI_ARADDR(3),
      I1 => \bit_cnt_ff2_reg_n_0_[29]\,
      I2 => S_AXI_ARADDR(2),
      I3 => S_AXI_ARADDR(4),
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[29]_i_1_n_0\
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
      I4 => \axi_rdata[2]_i_4_n_0\,
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[2]_i_1_n_0\
    );
\axi_rdata[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_agc_target(2),
      I1 => \axireg_sps_reg_n_0_[2]\,
      I2 => S_AXI_ARADDR(3),
      I3 => locked_ff(1),
      I4 => S_AXI_ARADDR(2),
      I5 => data0(2),
      O => \axi_rdata[2]_i_2_n_0\
    );
\axi_rdata[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(2),
      I1 => axireg_costas_ki(2),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(2),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(2),
      O => \axi_rdata[2]_i_3_n_0\
    );
\axi_rdata[2]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CACAFACA"
    )
        port map (
      I0 => \axi_rdata[2]_i_5_n_0\,
      I1 => S_AXI_ARADDR(3),
      I2 => S_AXI_ARADDR(4),
      I3 => data12(2),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[2]_i_4_n_0\
    );
\axi_rdata[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[2]\,
      I1 => timing_err_ff2(2),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(2),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(2),
      O => \axi_rdata[2]_i_5_n_0\
    );
\axi_rdata[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE0A00000"
    )
        port map (
      I0 => S_AXI_ARADDR(4),
      I1 => S_AXI_ARADDR(2),
      I2 => S_AXI_ARADDR(3),
      I3 => \bit_cnt_ff2_reg_n_0_[30]\,
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[30]_i_1_n_0\
    );
\axi_rdata[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE0A00000"
    )
        port map (
      I0 => S_AXI_ARADDR(4),
      I1 => S_AXI_ARADDR(2),
      I2 => S_AXI_ARADDR(3),
      I3 => \bit_cnt_ff2_reg_n_0_[31]\,
      I4 => S_AXI_ARADDR(5),
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata[31]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => S_AXI_ARADDR(7),
      I1 => S_AXI_ARADDR(6),
      O => \axi_rdata[31]_i_2_n_0\
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
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[3]_i_1_n_0\
    );
\axi_rdata[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_agc_target(3),
      I1 => \axireg_sps_reg_n_0_[3]\,
      I2 => S_AXI_ARADDR(3),
      I3 => settled_ff(1),
      I4 => S_AXI_ARADDR(2),
      I5 => data0(3),
      O => \axi_rdata[3]_i_2_n_0\
    );
\axi_rdata[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(3),
      I1 => axireg_costas_ki(3),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(3),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(3),
      O => \axi_rdata[3]_i_3_n_0\
    );
\axi_rdata[3]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CACAFACA"
    )
        port map (
      I0 => \axi_rdata[3]_i_5_n_0\,
      I1 => S_AXI_ARADDR(3),
      I2 => S_AXI_ARADDR(4),
      I3 => data12(3),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[3]_i_4_n_0\
    );
\axi_rdata[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[3]\,
      I1 => timing_err_ff2(3),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(3),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(3),
      O => \axi_rdata[3]_i_5_n_0\
    );
\axi_rdata[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000E2"
    )
        port map (
      I0 => \axi_rdata[4]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[4]_i_3_n_0\,
      I3 => S_AXI_ARADDR(6),
      I4 => S_AXI_ARADDR(7),
      O => \axi_rdata[4]_i_1_n_0\
    );
\axi_rdata[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
        port map (
      I0 => \axi_rdata[4]_i_4_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => \axireg_sps_reg_n_0_[4]\,
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_agc_target(4),
      O => \axi_rdata[4]_i_2_n_0\
    );
\axi_rdata[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0A0A3A0A"
    )
        port map (
      I0 => \axi_rdata[4]_i_5_n_0\,
      I1 => S_AXI_ARADDR(3),
      I2 => S_AXI_ARADDR(4),
      I3 => data12(4),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[4]_i_3_n_0\
    );
\axi_rdata[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(4),
      I1 => axireg_costas_ki(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(4),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(4),
      O => \axi_rdata[4]_i_4_n_0\
    );
\axi_rdata[4]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[4]\,
      I1 => timing_err_ff2(4),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(4),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(4),
      O => \axi_rdata[4]_i_5_n_0\
    );
\axi_rdata[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFE2"
    )
        port map (
      I0 => \axi_rdata[5]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[5]_i_3_n_0\,
      I3 => S_AXI_ARADDR(6),
      I4 => S_AXI_ARADDR(7),
      O => \axi_rdata[5]_i_1_n_0\
    );
\axi_rdata[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
        port map (
      I0 => \axi_rdata[5]_i_4_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => \axireg_sps_reg_n_0_[5]\,
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_agc_target(5),
      O => \axi_rdata[5]_i_2_n_0\
    );
\axi_rdata[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CACAFACA"
    )
        port map (
      I0 => \axi_rdata[5]_i_5_n_0\,
      I1 => S_AXI_ARADDR(3),
      I2 => S_AXI_ARADDR(4),
      I3 => data12(5),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[5]_i_3_n_0\
    );
\axi_rdata[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(5),
      I1 => axireg_costas_ki(5),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(5),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(5),
      O => \axi_rdata[5]_i_4_n_0\
    );
\axi_rdata[5]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[5]\,
      I1 => timing_err_ff2(5),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(5),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(5),
      O => \axi_rdata[5]_i_5_n_0\
    );
\axi_rdata[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFE2"
    )
        port map (
      I0 => \axi_rdata[6]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[6]_i_3_n_0\,
      I3 => S_AXI_ARADDR(6),
      I4 => S_AXI_ARADDR(7),
      O => \axi_rdata[6]_i_1_n_0\
    );
\axi_rdata[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
        port map (
      I0 => \axi_rdata[6]_i_4_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => \axireg_sps_reg_n_0_[6]\,
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_agc_target(6),
      O => \axi_rdata[6]_i_2_n_0\
    );
\axi_rdata[6]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CACAFACA"
    )
        port map (
      I0 => \axi_rdata[6]_i_5_n_0\,
      I1 => S_AXI_ARADDR(3),
      I2 => S_AXI_ARADDR(4),
      I3 => data12(6),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[6]_i_3_n_0\
    );
\axi_rdata[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(6),
      I1 => axireg_costas_ki(6),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(6),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(6),
      O => \axi_rdata[6]_i_4_n_0\
    );
\axi_rdata[6]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[6]\,
      I1 => timing_err_ff2(6),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(6),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(6),
      O => \axi_rdata[6]_i_5_n_0\
    );
\axi_rdata[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFE2"
    )
        port map (
      I0 => \axi_rdata[7]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[7]_i_3_n_0\,
      I3 => S_AXI_ARADDR(6),
      I4 => S_AXI_ARADDR(7),
      O => \axi_rdata[7]_i_1_n_0\
    );
\axi_rdata[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8B8B8888888B888"
    )
        port map (
      I0 => \axi_rdata[7]_i_4_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => \axireg_sps_reg_n_0_[7]\,
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_agc_target(7),
      O => \axi_rdata[7]_i_2_n_0\
    );
\axi_rdata[7]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CACAFACA"
    )
        port map (
      I0 => \axi_rdata[7]_i_5_n_0\,
      I1 => S_AXI_ARADDR(3),
      I2 => S_AXI_ARADDR(4),
      I3 => data12(7),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[7]_i_3_n_0\
    );
\axi_rdata[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(7),
      I1 => axireg_costas_ki(7),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(7),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(7),
      O => \axi_rdata[7]_i_4_n_0\
    );
\axi_rdata[7]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[7]\,
      I1 => timing_err_ff2(7),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(7),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(7),
      O => \axi_rdata[7]_i_5_n_0\
    );
\axi_rdata[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000E2222222"
    )
        port map (
      I0 => \axi_rdata[8]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[15]_i_4_n_0\,
      I3 => \axi_rdata[8]_i_3_n_0\,
      I4 => \axi_rdata[15]_i_5_n_0\,
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[8]_i_1_n_0\
    );
\axi_rdata[8]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8888888"
    )
        port map (
      I0 => \axi_rdata[8]_i_4_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_agc_target(8),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[8]_i_2_n_0\
    );
\axi_rdata[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[8]\,
      I1 => timing_err_ff2(8),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(8),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(8),
      O => \axi_rdata[8]_i_3_n_0\
    );
\axi_rdata[8]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(8),
      I1 => axireg_costas_ki(8),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(8),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(8),
      O => \axi_rdata[8]_i_4_n_0\
    );
\axi_rdata[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE2EE2222"
    )
        port map (
      I0 => \axi_rdata[9]_i_2_n_0\,
      I1 => S_AXI_ARADDR(5),
      I2 => \axi_rdata[9]_i_3_n_0\,
      I3 => \axi_rdata[15]_i_4_n_0\,
      I4 => \axi_rdata[15]_i_5_n_0\,
      I5 => \axi_rdata[31]_i_2_n_0\,
      O => \axi_rdata[9]_i_1_n_0\
    );
\axi_rdata[9]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8888888"
    )
        port map (
      I0 => \axi_rdata[9]_i_4_n_0\,
      I1 => S_AXI_ARADDR(4),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_agc_target(9),
      I4 => S_AXI_ARADDR(2),
      O => \axi_rdata[9]_i_2_n_0\
    );
\axi_rdata[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \bit_cnt_ff2_reg_n_0_[9]\,
      I1 => timing_err_ff2(9),
      I2 => S_AXI_ARADDR(3),
      I3 => phase_err_ff2(9),
      I4 => S_AXI_ARADDR(2),
      I5 => axireg_timing_ki(9),
      O => \axi_rdata[9]_i_3_n_0\
    );
\axi_rdata[9]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => axireg_timing_kp(9),
      I1 => axireg_costas_ki(9),
      I2 => S_AXI_ARADDR(3),
      I3 => axireg_costas_kp(9),
      I4 => S_AXI_ARADDR(2),
      I5 => data4(9),
      O => \axi_rdata[9]_i_4_n_0\
    );
\axi_rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[0]_i_1_n_0\,
      Q => S_AXI_RDATA(0),
      R => \p_0_in__0\
    );
\axi_rdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[10]_i_1_n_0\,
      Q => S_AXI_RDATA(10),
      R => \p_0_in__0\
    );
\axi_rdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[11]_i_1_n_0\,
      Q => S_AXI_RDATA(11),
      R => \p_0_in__0\
    );
\axi_rdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[12]_i_1_n_0\,
      Q => S_AXI_RDATA(12),
      R => \p_0_in__0\
    );
\axi_rdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[13]_i_1_n_0\,
      Q => S_AXI_RDATA(13),
      R => \p_0_in__0\
    );
\axi_rdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[14]_i_1_n_0\,
      Q => S_AXI_RDATA(14),
      R => \p_0_in__0\
    );
\axi_rdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[15]_i_1_n_0\,
      Q => S_AXI_RDATA(15),
      R => \p_0_in__0\
    );
\axi_rdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[16]_i_1_n_0\,
      Q => S_AXI_RDATA(16),
      R => \p_0_in__0\
    );
\axi_rdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[17]_i_1_n_0\,
      Q => S_AXI_RDATA(17),
      R => \p_0_in__0\
    );
\axi_rdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[18]_i_1_n_0\,
      Q => S_AXI_RDATA(18),
      R => \p_0_in__0\
    );
\axi_rdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[19]_i_1_n_0\,
      Q => S_AXI_RDATA(19),
      R => \p_0_in__0\
    );
\axi_rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[1]_i_1_n_0\,
      Q => S_AXI_RDATA(1),
      R => \p_0_in__0\
    );
\axi_rdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[20]_i_1_n_0\,
      Q => S_AXI_RDATA(20),
      R => \p_0_in__0\
    );
\axi_rdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[21]_i_1_n_0\,
      Q => S_AXI_RDATA(21),
      R => \p_0_in__0\
    );
\axi_rdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[22]_i_1_n_0\,
      Q => S_AXI_RDATA(22),
      R => \p_0_in__0\
    );
\axi_rdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[23]_i_1_n_0\,
      Q => S_AXI_RDATA(23),
      R => \p_0_in__0\
    );
\axi_rdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[24]_i_1_n_0\,
      Q => S_AXI_RDATA(24),
      R => \p_0_in__0\
    );
\axi_rdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[25]_i_1_n_0\,
      Q => S_AXI_RDATA(25),
      R => \p_0_in__0\
    );
\axi_rdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[26]_i_1_n_0\,
      Q => S_AXI_RDATA(26),
      R => \p_0_in__0\
    );
\axi_rdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[27]_i_1_n_0\,
      Q => S_AXI_RDATA(27),
      R => \p_0_in__0\
    );
\axi_rdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[28]_i_1_n_0\,
      Q => S_AXI_RDATA(28),
      R => \p_0_in__0\
    );
\axi_rdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[29]_i_1_n_0\,
      Q => S_AXI_RDATA(29),
      R => \p_0_in__0\
    );
\axi_rdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[2]_i_1_n_0\,
      Q => S_AXI_RDATA(2),
      R => \p_0_in__0\
    );
\axi_rdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[30]_i_1_n_0\,
      Q => S_AXI_RDATA(30),
      R => \p_0_in__0\
    );
\axi_rdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[31]_i_1_n_0\,
      Q => S_AXI_RDATA(31),
      R => \p_0_in__0\
    );
\axi_rdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[3]_i_1_n_0\,
      Q => S_AXI_RDATA(3),
      R => \p_0_in__0\
    );
\axi_rdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[4]_i_1_n_0\,
      Q => S_AXI_RDATA(4),
      R => \p_0_in__0\
    );
\axi_rdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[5]_i_1_n_0\,
      Q => S_AXI_RDATA(5),
      R => \p_0_in__0\
    );
\axi_rdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[6]_i_1_n_0\,
      Q => S_AXI_RDATA(6),
      R => \p_0_in__0\
    );
\axi_rdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[7]_i_1_n_0\,
      Q => S_AXI_RDATA(7),
      R => \p_0_in__0\
    );
\axi_rdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[8]_i_1_n_0\,
      Q => S_AXI_RDATA(8),
      R => \p_0_in__0\
    );
\axi_rdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_arready0,
      D => \axi_rdata[9]_i_1_n_0\,
      Q => S_AXI_RDATA(9),
      R => \p_0_in__0\
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
      R => \p_0_in__0\
    );
\axireg_agc_ki_shift[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => \w_strb_reg_n_0_[2]\,
      I1 => p_0_in(2),
      I2 => p_0_in(0),
      I3 => axireg_enable_i_2_n_0,
      O => axireg_agc_ki_shift
    );
\axireg_agc_ki_shift_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_agc_ki_shift,
      D => \w_data_reg_n_0_[16]\,
      Q => data4(16),
      R => \p_0_in__0\
    );
\axireg_agc_ki_shift_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_agc_ki_shift,
      D => \w_data_reg_n_0_[17]\,
      Q => data4(17),
      S => \p_0_in__0\
    );
\axireg_agc_ki_shift_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_agc_ki_shift,
      D => \w_data_reg_n_0_[18]\,
      Q => data4(18),
      R => \p_0_in__0\
    );
\axireg_agc_ki_shift_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_agc_ki_shift,
      D => \w_data_reg_n_0_[19]\,
      Q => data4(19),
      S => \p_0_in__0\
    );
\axireg_agc_target[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => p_1_in0,
      I1 => p_0_in(0),
      I2 => p_0_in(2),
      I3 => \axireg_sps[7]_i_2_n_0\,
      O => \axireg_agc_target[15]_i_1_n_0\
    );
\axireg_agc_target[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => p_1_in,
      I1 => p_0_in(0),
      I2 => p_0_in(2),
      I3 => \axireg_sps[7]_i_2_n_0\,
      O => \axireg_agc_target[7]_i_1_n_0\
    );
\axireg_agc_target_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[0]\,
      Q => axireg_agc_target(0),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[10]\,
      Q => axireg_agc_target(10),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[11]\,
      Q => axireg_agc_target(11),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[12]\,
      Q => axireg_agc_target(12),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[13]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[13]\,
      Q => axireg_agc_target(13),
      S => \p_0_in__0\
    );
\axireg_agc_target_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[14]\,
      Q => axireg_agc_target(14),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[15]\,
      Q => axireg_agc_target(15),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[1]\,
      Q => axireg_agc_target(1),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[2]\,
      Q => axireg_agc_target(2),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[3]\,
      Q => axireg_agc_target(3),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[4]\,
      Q => axireg_agc_target(4),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[5]\,
      Q => axireg_agc_target(5),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[6]\,
      Q => axireg_agc_target(6),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[7]\,
      Q => axireg_agc_target(7),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[8]\,
      Q => axireg_agc_target(8),
      R => \p_0_in__0\
    );
\axireg_agc_target_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_agc_target[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[9]\,
      Q => axireg_agc_target(9),
      R => \p_0_in__0\
    );
axireg_bypass_agc_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_enable,
      D => \w_data_reg_n_0_[1]\,
      Q => data0(1),
      R => \p_0_in__0\
    );
axireg_bypass_costas_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_enable,
      D => \w_data_reg_n_0_[2]\,
      Q => data0(2),
      R => \p_0_in__0\
    );
axireg_bypass_timing_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_enable,
      D => \w_data_reg_n_0_[3]\,
      Q => data0(3),
      R => \p_0_in__0\
    );
\axireg_costas_ki[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => p_1_in0,
      I1 => p_0_in(2),
      I2 => p_0_in(0),
      I3 => \axireg_sps[7]_i_2_n_0\,
      O => \axireg_costas_ki[15]_i_1_n_0\
    );
\axireg_costas_ki[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => p_0_in(2),
      I1 => p_1_in,
      I2 => p_0_in(0),
      I3 => \axireg_sps[7]_i_2_n_0\,
      O => \axireg_costas_ki[7]_i_1_n_0\
    );
\axireg_costas_ki_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[0]\,
      Q => axireg_costas_ki(0),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[10]\,
      Q => axireg_costas_ki(10),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[11]\,
      Q => axireg_costas_ki(11),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[12]\,
      Q => axireg_costas_ki(12),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[13]\,
      Q => axireg_costas_ki(13),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[14]\,
      Q => axireg_costas_ki(14),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[15]\,
      Q => axireg_costas_ki(15),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[1]\,
      Q => axireg_costas_ki(1),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[2]\,
      Q => axireg_costas_ki(2),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[3]\,
      Q => axireg_costas_ki(3),
      S => \p_0_in__0\
    );
\axireg_costas_ki_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[4]\,
      Q => axireg_costas_ki(4),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[5]\,
      Q => axireg_costas_ki(5),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[6]\,
      Q => axireg_costas_ki(6),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[7]\,
      Q => axireg_costas_ki(7),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[8]\,
      Q => axireg_costas_ki(8),
      R => \p_0_in__0\
    );
\axireg_costas_ki_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[9]\,
      Q => axireg_costas_ki(9),
      R => \p_0_in__0\
    );
\axireg_costas_kp[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => p_1_in0,
      I1 => p_0_in(0),
      I2 => p_0_in(2),
      I3 => axireg_enable_i_2_n_0,
      O => \axireg_costas_kp[15]_i_1_n_0\
    );
\axireg_costas_kp[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => p_1_in,
      I1 => p_0_in(0),
      I2 => p_0_in(2),
      I3 => axireg_enable_i_2_n_0,
      O => \axireg_costas_kp[7]_i_1_n_0\
    );
\axireg_costas_kp_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[0]\,
      Q => axireg_costas_kp(0),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[10]\,
      Q => axireg_costas_kp(10),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[11]\,
      Q => axireg_costas_kp(11),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[12]\,
      Q => axireg_costas_kp(12),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[13]\,
      Q => axireg_costas_kp(13),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[14]\,
      Q => axireg_costas_kp(14),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[15]\,
      Q => axireg_costas_kp(15),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[1]\,
      Q => axireg_costas_kp(1),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[2]\,
      Q => axireg_costas_kp(2),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[3]\,
      Q => axireg_costas_kp(3),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[4]\,
      Q => axireg_costas_kp(4),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[5]\,
      Q => axireg_costas_kp(5),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[6]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[6]\,
      Q => axireg_costas_kp(6),
      S => \p_0_in__0\
    );
\axireg_costas_kp_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[7]\,
      Q => axireg_costas_kp(7),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[8]\,
      Q => axireg_costas_kp(8),
      R => \p_0_in__0\
    );
\axireg_costas_kp_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_costas_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[9]\,
      Q => axireg_costas_kp(9),
      R => \p_0_in__0\
    );
axireg_enable_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => p_0_in(2),
      I1 => p_1_in,
      I2 => p_0_in(0),
      I3 => axireg_enable_i_2_n_0,
      O => axireg_enable
    );
axireg_enable_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000100"
    )
        port map (
      I0 => p_0_in(3),
      I1 => \aw_addr_reg_n_0_[7]\,
      I2 => p_0_in0,
      I3 => do_write,
      I4 => p_0_in(1),
      O => axireg_enable_i_2_n_0
    );
axireg_enable_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_enable,
      D => \w_data_reg_n_0_[0]\,
      Q => data0(0),
      R => \p_0_in__0\
    );
\axireg_sps[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => p_0_in(2),
      I1 => p_1_in,
      I2 => p_0_in(0),
      I3 => \axireg_sps[7]_i_2_n_0\,
      O => axireg_sps
    );
\axireg_sps[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01000000"
    )
        port map (
      I0 => p_0_in(3),
      I1 => \aw_addr_reg_n_0_[7]\,
      I2 => p_0_in0,
      I3 => do_write,
      I4 => p_0_in(1),
      O => \axireg_sps[7]_i_2_n_0\
    );
\axireg_sps_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_sps,
      D => \w_data_reg_n_0_[0]\,
      Q => \axireg_sps_reg_n_0_[0]\,
      R => \p_0_in__0\
    );
\axireg_sps_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_sps,
      D => \w_data_reg_n_0_[1]\,
      Q => \axireg_sps_reg_n_0_[1]\,
      R => \p_0_in__0\
    );
\axireg_sps_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_sps,
      D => \w_data_reg_n_0_[2]\,
      Q => \axireg_sps_reg_n_0_[2]\,
      R => \p_0_in__0\
    );
\axireg_sps_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_sps,
      D => \w_data_reg_n_0_[3]\,
      Q => \axireg_sps_reg_n_0_[3]\,
      S => \p_0_in__0\
    );
\axireg_sps_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_sps,
      D => \w_data_reg_n_0_[4]\,
      Q => \axireg_sps_reg_n_0_[4]\,
      R => \p_0_in__0\
    );
\axireg_sps_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_sps,
      D => \w_data_reg_n_0_[5]\,
      Q => \axireg_sps_reg_n_0_[5]\,
      R => \p_0_in__0\
    );
\axireg_sps_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_sps,
      D => \w_data_reg_n_0_[6]\,
      Q => \axireg_sps_reg_n_0_[6]\,
      R => \p_0_in__0\
    );
\axireg_sps_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axireg_sps,
      D => \w_data_reg_n_0_[7]\,
      Q => \axireg_sps_reg_n_0_[7]\,
      R => \p_0_in__0\
    );
\axireg_timing_ki[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002000000000000"
    )
        port map (
      I0 => p_0_in(3),
      I1 => p_0_in(2),
      I2 => p_0_in(1),
      I3 => p_0_in(0),
      I4 => p_1_in0,
      I5 => \axireg_timing_ki[15]_i_2_n_0\,
      O => \axireg_timing_ki[15]_i_1_n_0\
    );
\axireg_timing_ki[15]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00001000"
    )
        port map (
      I0 => \aw_addr_reg_n_0_[7]\,
      I1 => p_0_in0,
      I2 => w_done_reg_n_0,
      I3 => aw_done,
      I4 => \^s_axi_bvalid\,
      O => \axireg_timing_ki[15]_i_2_n_0\
    );
\axireg_timing_ki[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000020000000000"
    )
        port map (
      I0 => p_1_in,
      I1 => p_0_in(0),
      I2 => p_0_in(2),
      I3 => p_0_in(3),
      I4 => p_0_in(1),
      I5 => \axireg_timing_ki[15]_i_2_n_0\,
      O => \axireg_timing_ki[7]_i_1_n_0\
    );
\axireg_timing_ki_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[0]\,
      Q => axireg_timing_ki(0),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[10]\,
      Q => axireg_timing_ki(10),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[11]\,
      Q => axireg_timing_ki(11),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[12]\,
      Q => axireg_timing_ki(12),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[13]\,
      Q => axireg_timing_ki(13),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[14]\,
      Q => axireg_timing_ki(14),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[15]\,
      Q => axireg_timing_ki(15),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[1]\,
      Q => axireg_timing_ki(1),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[2]\,
      Q => axireg_timing_ki(2),
      S => \p_0_in__0\
    );
\axireg_timing_ki_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[3]\,
      Q => axireg_timing_ki(3),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[4]\,
      Q => axireg_timing_ki(4),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[5]\,
      Q => axireg_timing_ki(5),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[6]\,
      Q => axireg_timing_ki(6),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[7]\,
      Q => axireg_timing_ki(7),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[8]\,
      Q => axireg_timing_ki(8),
      R => \p_0_in__0\
    );
\axireg_timing_ki_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_ki[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[9]\,
      Q => axireg_timing_ki(9),
      R => \p_0_in__0\
    );
\axireg_timing_kp[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => p_1_in0,
      I1 => p_0_in(0),
      I2 => p_0_in(2),
      I3 => \axireg_sps[7]_i_2_n_0\,
      O => \axireg_timing_kp[15]_i_1_n_0\
    );
\axireg_timing_kp[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => p_1_in,
      I1 => p_0_in(0),
      I2 => p_0_in(2),
      I3 => \axireg_sps[7]_i_2_n_0\,
      O => \axireg_timing_kp[7]_i_1_n_0\
    );
\axireg_timing_kp_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[0]\,
      Q => axireg_timing_kp(0),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[10]\,
      Q => axireg_timing_kp(10),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[11]\,
      Q => axireg_timing_kp(11),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[12]\,
      Q => axireg_timing_kp(12),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[13]\,
      Q => axireg_timing_kp(13),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[14]\,
      Q => axireg_timing_kp(14),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[15]\,
      Q => axireg_timing_kp(15),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[1]\,
      Q => axireg_timing_kp(1),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[2]\,
      Q => axireg_timing_kp(2),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[3]\,
      Q => axireg_timing_kp(3),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[4]\,
      Q => axireg_timing_kp(4),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[5]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[5]\,
      Q => axireg_timing_kp(5),
      S => \p_0_in__0\
    );
\axireg_timing_kp_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[6]\,
      Q => axireg_timing_kp(6),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[7]_i_1_n_0\,
      D => \w_data_reg_n_0_[7]\,
      Q => axireg_timing_kp(7),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[8]\,
      Q => axireg_timing_kp(8),
      R => \p_0_in__0\
    );
\axireg_timing_kp_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \axireg_timing_kp[15]_i_1_n_0\,
      D => \w_data_reg_n_0_[9]\,
      Q => axireg_timing_kp(9),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(0),
      Q => bit_cnt_ff1(0),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(10),
      Q => bit_cnt_ff1(10),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(11),
      Q => bit_cnt_ff1(11),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(12),
      Q => bit_cnt_ff1(12),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(13),
      Q => bit_cnt_ff1(13),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(14),
      Q => bit_cnt_ff1(14),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(15),
      Q => bit_cnt_ff1(15),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(16),
      Q => bit_cnt_ff1(16),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(17),
      Q => bit_cnt_ff1(17),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(18),
      Q => bit_cnt_ff1(18),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(19),
      Q => bit_cnt_ff1(19),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(1),
      Q => bit_cnt_ff1(1),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(20),
      Q => bit_cnt_ff1(20),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(21),
      Q => bit_cnt_ff1(21),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(22),
      Q => bit_cnt_ff1(22),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(23),
      Q => bit_cnt_ff1(23),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(24),
      Q => bit_cnt_ff1(24),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(25),
      Q => bit_cnt_ff1(25),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(26),
      Q => bit_cnt_ff1(26),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(27),
      Q => bit_cnt_ff1(27),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(28),
      Q => bit_cnt_ff1(28),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(29),
      Q => bit_cnt_ff1(29),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(2),
      Q => bit_cnt_ff1(2),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(30),
      Q => bit_cnt_ff1(30),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(31),
      Q => bit_cnt_ff1(31),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(32),
      Q => bit_cnt_ff1(32),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(33),
      Q => bit_cnt_ff1(33),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(34),
      Q => bit_cnt_ff1(34),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(35),
      Q => bit_cnt_ff1(35),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(36),
      Q => bit_cnt_ff1(36),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(37),
      Q => bit_cnt_ff1(37),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(38),
      Q => bit_cnt_ff1(38),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(39),
      Q => bit_cnt_ff1(39),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(3),
      Q => bit_cnt_ff1(3),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(4),
      Q => bit_cnt_ff1(4),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(5),
      Q => bit_cnt_ff1(5),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(6),
      Q => bit_cnt_ff1(6),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(7),
      Q => bit_cnt_ff1(7),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(8),
      Q => bit_cnt_ff1(8),
      R => \p_0_in__0\
    );
\bit_cnt_ff1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_bit_count(9),
      Q => bit_cnt_ff1(9),
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(0),
      Q => \bit_cnt_ff2_reg_n_0_[0]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(10),
      Q => \bit_cnt_ff2_reg_n_0_[10]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(11),
      Q => \bit_cnt_ff2_reg_n_0_[11]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(12),
      Q => \bit_cnt_ff2_reg_n_0_[12]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(13),
      Q => \bit_cnt_ff2_reg_n_0_[13]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(14),
      Q => \bit_cnt_ff2_reg_n_0_[14]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(15),
      Q => \bit_cnt_ff2_reg_n_0_[15]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(16),
      Q => \bit_cnt_ff2_reg_n_0_[16]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(17),
      Q => \bit_cnt_ff2_reg_n_0_[17]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(18),
      Q => \bit_cnt_ff2_reg_n_0_[18]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(19),
      Q => \bit_cnt_ff2_reg_n_0_[19]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(1),
      Q => \bit_cnt_ff2_reg_n_0_[1]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(20),
      Q => \bit_cnt_ff2_reg_n_0_[20]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(21),
      Q => \bit_cnt_ff2_reg_n_0_[21]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(22),
      Q => \bit_cnt_ff2_reg_n_0_[22]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(23),
      Q => \bit_cnt_ff2_reg_n_0_[23]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(24),
      Q => \bit_cnt_ff2_reg_n_0_[24]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(25),
      Q => \bit_cnt_ff2_reg_n_0_[25]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(26),
      Q => \bit_cnt_ff2_reg_n_0_[26]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(27),
      Q => \bit_cnt_ff2_reg_n_0_[27]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(28),
      Q => \bit_cnt_ff2_reg_n_0_[28]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(29),
      Q => \bit_cnt_ff2_reg_n_0_[29]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(2),
      Q => \bit_cnt_ff2_reg_n_0_[2]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(30),
      Q => \bit_cnt_ff2_reg_n_0_[30]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(31),
      Q => \bit_cnt_ff2_reg_n_0_[31]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(32),
      Q => data12(0),
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(33),
      Q => data12(1),
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(34),
      Q => data12(2),
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(35),
      Q => data12(3),
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(36),
      Q => data12(4),
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(37),
      Q => data12(5),
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(38),
      Q => data12(6),
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(39),
      Q => data12(7),
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(3),
      Q => \bit_cnt_ff2_reg_n_0_[3]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(4),
      Q => \bit_cnt_ff2_reg_n_0_[4]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(5),
      Q => \bit_cnt_ff2_reg_n_0_[5]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(6),
      Q => \bit_cnt_ff2_reg_n_0_[6]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(7),
      Q => \bit_cnt_ff2_reg_n_0_[7]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(8),
      Q => \bit_cnt_ff2_reg_n_0_[8]\,
      R => \p_0_in__0\
    );
\bit_cnt_ff2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bit_cnt_ff1(9),
      Q => \bit_cnt_ff2_reg_n_0_[9]\,
      R => \p_0_in__0\
    );
\core_agc_ki_shift_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_ki_shift(0),
      Q => core_agc_ki_shift(0)
    );
\core_agc_ki_shift_reg[1]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_agc_ki_shift(1),
      PRE => u_demod_core_n_17,
      Q => core_agc_ki_shift(1)
    );
\core_agc_ki_shift_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_ki_shift(2),
      Q => core_agc_ki_shift(2)
    );
\core_agc_ki_shift_reg[3]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_agc_ki_shift(3),
      PRE => u_demod_core_n_17,
      Q => core_agc_ki_shift(3)
    );
\core_agc_target_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(0),
      Q => core_agc_target(0)
    );
\core_agc_target_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(10),
      Q => core_agc_target(10)
    );
\core_agc_target_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(11),
      Q => core_agc_target(11)
    );
\core_agc_target_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(12),
      Q => core_agc_target(12)
    );
\core_agc_target_reg[13]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_agc_target(13),
      PRE => u_demod_core_n_17,
      Q => core_agc_target(13)
    );
\core_agc_target_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(14),
      Q => core_agc_target(14)
    );
\core_agc_target_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(15),
      Q => core_agc_target(15)
    );
\core_agc_target_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(1),
      Q => core_agc_target(1)
    );
\core_agc_target_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(2),
      Q => core_agc_target(2)
    );
\core_agc_target_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(3),
      Q => core_agc_target(3)
    );
\core_agc_target_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(4),
      Q => core_agc_target(4)
    );
\core_agc_target_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(5),
      Q => core_agc_target(5)
    );
\core_agc_target_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(6),
      Q => core_agc_target(6)
    );
\core_agc_target_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(7),
      Q => core_agc_target(7)
    );
\core_agc_target_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(8),
      Q => core_agc_target(8)
    );
\core_agc_target_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_agc_target(9),
      Q => core_agc_target(9)
    );
core_bypass_agc_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_bypass_agc,
      Q => core_bypass_agc
    );
core_bypass_costas_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_bypass_costas,
      Q => core_bypass_costas
    );
core_bypass_timing_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_bypass_timing,
      Q => core_bypass_timing
    );
\core_costas_ki_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(0),
      Q => core_costas_ki(0)
    );
\core_costas_ki_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(10),
      Q => core_costas_ki(10)
    );
\core_costas_ki_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(11),
      Q => core_costas_ki(11)
    );
\core_costas_ki_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(12),
      Q => core_costas_ki(12)
    );
\core_costas_ki_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(13),
      Q => core_costas_ki(13)
    );
\core_costas_ki_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(14),
      Q => core_costas_ki(14)
    );
\core_costas_ki_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(15),
      Q => core_costas_ki(15)
    );
\core_costas_ki_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(1),
      Q => core_costas_ki(1)
    );
\core_costas_ki_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(2),
      Q => core_costas_ki(2)
    );
\core_costas_ki_reg[3]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_costas_ki(3),
      PRE => u_demod_core_n_17,
      Q => core_costas_ki(3)
    );
\core_costas_ki_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(4),
      Q => core_costas_ki(4)
    );
\core_costas_ki_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(5),
      Q => core_costas_ki(5)
    );
\core_costas_ki_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(6),
      Q => core_costas_ki(6)
    );
\core_costas_ki_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(7),
      Q => core_costas_ki(7)
    );
\core_costas_ki_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(8),
      Q => core_costas_ki(8)
    );
\core_costas_ki_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_ki(9),
      Q => core_costas_ki(9)
    );
\core_costas_kp_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(0),
      Q => core_costas_kp(0)
    );
\core_costas_kp_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(10),
      Q => core_costas_kp(10)
    );
\core_costas_kp_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(11),
      Q => core_costas_kp(11)
    );
\core_costas_kp_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(12),
      Q => core_costas_kp(12)
    );
\core_costas_kp_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(13),
      Q => core_costas_kp(13)
    );
\core_costas_kp_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(14),
      Q => core_costas_kp(14)
    );
\core_costas_kp_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(15),
      Q => core_costas_kp(15)
    );
\core_costas_kp_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(1),
      Q => core_costas_kp(1)
    );
\core_costas_kp_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(2),
      Q => core_costas_kp(2)
    );
\core_costas_kp_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(3),
      Q => core_costas_kp(3)
    );
\core_costas_kp_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(4),
      Q => core_costas_kp(4)
    );
\core_costas_kp_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(5),
      Q => core_costas_kp(5)
    );
\core_costas_kp_reg[6]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_costas_kp(6),
      PRE => u_demod_core_n_17,
      Q => core_costas_kp(6)
    );
\core_costas_kp_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(7),
      Q => core_costas_kp(7)
    );
\core_costas_kp_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(8),
      Q => core_costas_kp(8)
    );
\core_costas_kp_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_costas_kp(9),
      Q => core_costas_kp(9)
    );
core_enable_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_enable,
      Q => core_enable
    );
\core_sps_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_sps(0),
      Q => core_sps(0)
    );
\core_sps_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_sps(1),
      Q => core_sps(1)
    );
\core_sps_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_sps(2),
      Q => core_sps(2)
    );
\core_sps_reg[3]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_sps(3),
      PRE => u_demod_core_n_17,
      Q => core_sps(3)
    );
\core_sps_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_sps(4),
      Q => core_sps(4)
    );
\core_sps_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_sps(5),
      Q => core_sps(5)
    );
\core_sps_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_sps(6),
      Q => core_sps(6)
    );
\core_sps_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_sps(7),
      Q => core_sps(7)
    );
\core_timing_ki_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(0),
      Q => core_timing_ki(0)
    );
\core_timing_ki_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(10),
      Q => core_timing_ki(10)
    );
\core_timing_ki_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(11),
      Q => core_timing_ki(11)
    );
\core_timing_ki_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(12),
      Q => core_timing_ki(12)
    );
\core_timing_ki_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(13),
      Q => core_timing_ki(13)
    );
\core_timing_ki_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(14),
      Q => core_timing_ki(14)
    );
\core_timing_ki_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(15),
      Q => core_timing_ki(15)
    );
\core_timing_ki_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(1),
      Q => core_timing_ki(1)
    );
\core_timing_ki_reg[2]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_timing_ki(2),
      PRE => u_demod_core_n_17,
      Q => core_timing_ki(2)
    );
\core_timing_ki_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(3),
      Q => core_timing_ki(3)
    );
\core_timing_ki_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(4),
      Q => core_timing_ki(4)
    );
\core_timing_ki_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(5),
      Q => core_timing_ki(5)
    );
\core_timing_ki_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(6),
      Q => core_timing_ki(6)
    );
\core_timing_ki_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(7),
      Q => core_timing_ki(7)
    );
\core_timing_ki_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(8),
      Q => core_timing_ki(8)
    );
\core_timing_ki_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_ki(9),
      Q => core_timing_ki(9)
    );
\core_timing_kp_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(0),
      Q => core_timing_kp(0)
    );
\core_timing_kp_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(10),
      Q => core_timing_kp(10)
    );
\core_timing_kp_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(11),
      Q => core_timing_kp(11)
    );
\core_timing_kp_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(12),
      Q => core_timing_kp(12)
    );
\core_timing_kp_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(13),
      Q => core_timing_kp(13)
    );
\core_timing_kp_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(14),
      Q => core_timing_kp(14)
    );
\core_timing_kp_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(15),
      Q => core_timing_kp(15)
    );
\core_timing_kp_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(1),
      Q => core_timing_kp(1)
    );
\core_timing_kp_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(2),
      Q => core_timing_kp(2)
    );
\core_timing_kp_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(3),
      Q => core_timing_kp(3)
    );
\core_timing_kp_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(4),
      Q => core_timing_kp(4)
    );
\core_timing_kp_reg[5]\: unisim.vcomponents.FDPE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      D => snap_timing_kp(5),
      PRE => u_demod_core_n_17,
      Q => core_timing_kp(5)
    );
\core_timing_kp_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(6),
      Q => core_timing_kp(6)
    );
\core_timing_kp_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(7),
      Q => core_timing_kp(7)
    );
\core_timing_kp_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(8),
      Q => core_timing_kp(8)
    );
\core_timing_kp_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => wr_pulse_core,
      CLR => u_demod_core_n_17,
      D => snap_timing_kp(9),
      Q => core_timing_kp(9)
    );
freq_int1_i_2: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => freq_int,
      CLR => u_demod_core_n_17,
      D => '1',
      Q => freq_int1_i_2_n_0
    );
\locked_ff_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_carrier_locked,
      Q => locked_ff(0),
      R => \p_0_in__0\
    );
\locked_ff_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => locked_ff(0),
      Q => locked_ff(1),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => q_mix(0),
      Q => phase_err_ff1(0),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(10),
      Q => phase_err_ff1(10),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(11),
      Q => phase_err_ff1(11),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(12),
      Q => phase_err_ff1(12),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(13),
      Q => phase_err_ff1(13),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(14),
      Q => phase_err_ff1(14),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(15),
      Q => phase_err_ff1(15),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(1),
      Q => phase_err_ff1(1),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(2),
      Q => phase_err_ff1(2),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(3),
      Q => phase_err_ff1(3),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(4),
      Q => phase_err_ff1(4),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(5),
      Q => phase_err_ff1(5),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(6),
      Q => phase_err_ff1(6),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(7),
      Q => phase_err_ff1(7),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(8),
      Q => phase_err_ff1(8),
      R => \p_0_in__0\
    );
\phase_err_ff1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_phase_err(9),
      Q => phase_err_ff1(9),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(0),
      Q => phase_err_ff2(0),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(10),
      Q => phase_err_ff2(10),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(11),
      Q => phase_err_ff2(11),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(12),
      Q => phase_err_ff2(12),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(13),
      Q => phase_err_ff2(13),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(14),
      Q => phase_err_ff2(14),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(15),
      Q => phase_err_ff2(15),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(1),
      Q => phase_err_ff2(1),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(2),
      Q => phase_err_ff2(2),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(3),
      Q => phase_err_ff2(3),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(4),
      Q => phase_err_ff2(4),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(5),
      Q => phase_err_ff2(5),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(6),
      Q => phase_err_ff2(6),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(7),
      Q => phase_err_ff2(7),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(8),
      Q => phase_err_ff2(8),
      R => \p_0_in__0\
    );
\phase_err_ff2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => phase_err_ff1(9),
      Q => phase_err_ff2(9),
      R => \p_0_in__0\
    );
\settled_ff_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_agc_settled,
      Q => settled_ff(0),
      R => \p_0_in__0\
    );
\settled_ff_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => settled_ff(0),
      Q => settled_ff(1),
      R => \p_0_in__0\
    );
\snap_agc_ki_shift_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data4(16),
      Q => snap_agc_ki_shift(0),
      R => \p_0_in__0\
    );
\snap_agc_ki_shift_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data4(17),
      Q => snap_agc_ki_shift(1),
      S => \p_0_in__0\
    );
\snap_agc_ki_shift_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data4(18),
      Q => snap_agc_ki_shift(2),
      R => \p_0_in__0\
    );
\snap_agc_ki_shift_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data4(19),
      Q => snap_agc_ki_shift(3),
      S => \p_0_in__0\
    );
\snap_agc_target_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(0),
      Q => snap_agc_target(0),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(10),
      Q => snap_agc_target(10),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(11),
      Q => snap_agc_target(11),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(12),
      Q => snap_agc_target(12),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[13]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(13),
      Q => snap_agc_target(13),
      S => \p_0_in__0\
    );
\snap_agc_target_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(14),
      Q => snap_agc_target(14),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(15),
      Q => snap_agc_target(15),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(1),
      Q => snap_agc_target(1),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(2),
      Q => snap_agc_target(2),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(3),
      Q => snap_agc_target(3),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(4),
      Q => snap_agc_target(4),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(5),
      Q => snap_agc_target(5),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(6),
      Q => snap_agc_target(6),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(7),
      Q => snap_agc_target(7),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(8),
      Q => snap_agc_target(8),
      R => \p_0_in__0\
    );
\snap_agc_target_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_agc_target(9),
      Q => snap_agc_target(9),
      R => \p_0_in__0\
    );
snap_bypass_agc_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data0(1),
      Q => snap_bypass_agc,
      R => \p_0_in__0\
    );
snap_bypass_costas_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data0(2),
      Q => snap_bypass_costas,
      R => \p_0_in__0\
    );
snap_bypass_timing_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data0(3),
      Q => snap_bypass_timing,
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(0),
      Q => snap_costas_ki(0),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(10),
      Q => snap_costas_ki(10),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(11),
      Q => snap_costas_ki(11),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(12),
      Q => snap_costas_ki(12),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(13),
      Q => snap_costas_ki(13),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(14),
      Q => snap_costas_ki(14),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(15),
      Q => snap_costas_ki(15),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(1),
      Q => snap_costas_ki(1),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(2),
      Q => snap_costas_ki(2),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(3),
      Q => snap_costas_ki(3),
      S => \p_0_in__0\
    );
\snap_costas_ki_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(4),
      Q => snap_costas_ki(4),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(5),
      Q => snap_costas_ki(5),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(6),
      Q => snap_costas_ki(6),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(7),
      Q => snap_costas_ki(7),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(8),
      Q => snap_costas_ki(8),
      R => \p_0_in__0\
    );
\snap_costas_ki_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_ki(9),
      Q => snap_costas_ki(9),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(0),
      Q => snap_costas_kp(0),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(10),
      Q => snap_costas_kp(10),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(11),
      Q => snap_costas_kp(11),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(12),
      Q => snap_costas_kp(12),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(13),
      Q => snap_costas_kp(13),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(14),
      Q => snap_costas_kp(14),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(15),
      Q => snap_costas_kp(15),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(1),
      Q => snap_costas_kp(1),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(2),
      Q => snap_costas_kp(2),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(3),
      Q => snap_costas_kp(3),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(4),
      Q => snap_costas_kp(4),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(5),
      Q => snap_costas_kp(5),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[6]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(6),
      Q => snap_costas_kp(6),
      S => \p_0_in__0\
    );
\snap_costas_kp_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(7),
      Q => snap_costas_kp(7),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(8),
      Q => snap_costas_kp(8),
      R => \p_0_in__0\
    );
\snap_costas_kp_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_costas_kp(9),
      Q => snap_costas_kp(9),
      R => \p_0_in__0\
    );
snap_enable_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => data0(0),
      Q => snap_enable,
      R => \p_0_in__0\
    );
\snap_sps_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \axireg_sps_reg_n_0_[0]\,
      Q => snap_sps(0),
      R => \p_0_in__0\
    );
\snap_sps_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \axireg_sps_reg_n_0_[1]\,
      Q => snap_sps(1),
      R => \p_0_in__0\
    );
\snap_sps_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \axireg_sps_reg_n_0_[2]\,
      Q => snap_sps(2),
      R => \p_0_in__0\
    );
\snap_sps_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \axireg_sps_reg_n_0_[3]\,
      Q => snap_sps(3),
      S => \p_0_in__0\
    );
\snap_sps_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \axireg_sps_reg_n_0_[4]\,
      Q => snap_sps(4),
      R => \p_0_in__0\
    );
\snap_sps_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \axireg_sps_reg_n_0_[5]\,
      Q => snap_sps(5),
      R => \p_0_in__0\
    );
\snap_sps_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \axireg_sps_reg_n_0_[6]\,
      Q => snap_sps(6),
      R => \p_0_in__0\
    );
\snap_sps_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \axireg_sps_reg_n_0_[7]\,
      Q => snap_sps(7),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(0),
      Q => snap_timing_ki(0),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(10),
      Q => snap_timing_ki(10),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(11),
      Q => snap_timing_ki(11),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(12),
      Q => snap_timing_ki(12),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(13),
      Q => snap_timing_ki(13),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(14),
      Q => snap_timing_ki(14),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(15),
      Q => snap_timing_ki(15),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(1),
      Q => snap_timing_ki(1),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(2),
      Q => snap_timing_ki(2),
      S => \p_0_in__0\
    );
\snap_timing_ki_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(3),
      Q => snap_timing_ki(3),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(4),
      Q => snap_timing_ki(4),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(5),
      Q => snap_timing_ki(5),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(6),
      Q => snap_timing_ki(6),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(7),
      Q => snap_timing_ki(7),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(8),
      Q => snap_timing_ki(8),
      R => \p_0_in__0\
    );
\snap_timing_ki_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_ki(9),
      Q => snap_timing_ki(9),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(0),
      Q => snap_timing_kp(0),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(10),
      Q => snap_timing_kp(10),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(11),
      Q => snap_timing_kp(11),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(12),
      Q => snap_timing_kp(12),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(13),
      Q => snap_timing_kp(13),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(14),
      Q => snap_timing_kp(14),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(15),
      Q => snap_timing_kp(15),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(1),
      Q => snap_timing_kp(1),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(2),
      Q => snap_timing_kp(2),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(3),
      Q => snap_timing_kp(3),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(4),
      Q => snap_timing_kp(4),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[5]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(5),
      Q => snap_timing_kp(5),
      S => \p_0_in__0\
    );
\snap_timing_kp_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(6),
      Q => snap_timing_kp(6),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(7),
      Q => snap_timing_kp(7),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(8),
      Q => snap_timing_kp(8),
      R => \p_0_in__0\
    );
\snap_timing_kp_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => axireg_timing_kp(9),
      Q => snap_timing_kp(9),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(0),
      Q => timing_err_ff1(0),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(10),
      Q => timing_err_ff1(10),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(11),
      Q => timing_err_ff1(11),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(12),
      Q => timing_err_ff1(12),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(13),
      Q => timing_err_ff1(13),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(14),
      Q => timing_err_ff1(14),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(15),
      Q => timing_err_ff1(15),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(1),
      Q => timing_err_ff1(1),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(2),
      Q => timing_err_ff1(2),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(3),
      Q => timing_err_ff1(3),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(4),
      Q => timing_err_ff1(4),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(5),
      Q => timing_err_ff1(5),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(6),
      Q => timing_err_ff1(6),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(7),
      Q => timing_err_ff1(7),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(8),
      Q => timing_err_ff1(8),
      R => \p_0_in__0\
    );
\timing_err_ff1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => raw_timing_err(9),
      Q => timing_err_ff1(9),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(0),
      Q => timing_err_ff2(0),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(10),
      Q => timing_err_ff2(10),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(11),
      Q => timing_err_ff2(11),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(12),
      Q => timing_err_ff2(12),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(13),
      Q => timing_err_ff2(13),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(14),
      Q => timing_err_ff2(14),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(15),
      Q => timing_err_ff2(15),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(1),
      Q => timing_err_ff2(1),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(2),
      Q => timing_err_ff2(2),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(3),
      Q => timing_err_ff2(3),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(4),
      Q => timing_err_ff2(4),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(5),
      Q => timing_err_ff2(5),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(6),
      Q => timing_err_ff2(6),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(7),
      Q => timing_err_ff2(7),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(8),
      Q => timing_err_ff2(8),
      R => \p_0_in__0\
    );
\timing_err_ff2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => timing_err_ff1(9),
      Q => timing_err_ff2(9),
      R => \p_0_in__0\
    );
timing_int1_i_2: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => u_demod_core_n_17,
      D => u_demod_core_n_0,
      Q => timing_int1_i_2_n_0
    );
u_demod_core: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_core
     port map (
      B(14 downto 0) => raw_phase_err(15 downto 1),
      D(0) => raw_agc_settled,
      E(0) => freq_int,
      M_AXIS_BITS_TDATA(7 downto 0) => M_AXIS_BITS_TDATA(7 downto 0),
      M_AXIS_BITS_TREADY => M_AXIS_BITS_TREADY,
      M_AXIS_BITS_TVALID => M_AXIS_BITS_TVALID,
      OPMODE(0) => timing_int1_i_2_n_0,
      Q(15 downto 0) => core_agc_target(15 downto 0),
      aclk => aclk,
      adc_data(31 downto 0) => adc_data(31 downto 0),
      adc_valid => adc_valid,
      agc_gain_out(15 downto 0) => raw_agc_gain(15 downto 0),
      aresetn => aresetn,
      aresetn_0 => u_demod_core_n_17,
      bit_count(39 downto 0) => raw_bit_count(39 downto 0),
      c_locked_reg_0(0) => raw_carrier_locked,
      core_bypass_agc => core_bypass_agc,
      core_bypass_costas => core_bypass_costas,
      core_bypass_timing => core_bypass_timing,
      core_enable => core_enable,
      freq_int1_0(0) => freq_int1_i_2_n_0,
      freq_int1_1(15 downto 0) => core_costas_ki(15 downto 0),
      freq_word2_0(15 downto 0) => core_costas_kp(15 downto 0),
      \gain_acc_reg[19]\(3 downto 0) => core_agc_ki_shift(3 downto 0),
      \q_mix_reg[0]_0\(0) => q_mix(0),
      \sps_eff_reg[7]_0\(7 downto 0) => core_sps(7 downto 0),
      timing_adj2_0(15 downto 0) => core_timing_kp(15 downto 0),
      timing_err_out(15 downto 0) => raw_timing_err(15 downto 0),
      timing_int1_0(15 downto 0) => core_timing_ki(15 downto 0),
      timing_int1_i_2 => u_demod_core_n_0
    );
\w_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(0),
      Q => \w_data_reg_n_0_[0]\,
      R => \p_0_in__0\
    );
\w_data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(10),
      Q => \w_data_reg_n_0_[10]\,
      R => \p_0_in__0\
    );
\w_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(11),
      Q => \w_data_reg_n_0_[11]\,
      R => \p_0_in__0\
    );
\w_data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(12),
      Q => \w_data_reg_n_0_[12]\,
      R => \p_0_in__0\
    );
\w_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(13),
      Q => \w_data_reg_n_0_[13]\,
      R => \p_0_in__0\
    );
\w_data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(14),
      Q => \w_data_reg_n_0_[14]\,
      R => \p_0_in__0\
    );
\w_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(15),
      Q => \w_data_reg_n_0_[15]\,
      R => \p_0_in__0\
    );
\w_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(16),
      Q => \w_data_reg_n_0_[16]\,
      R => \p_0_in__0\
    );
\w_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(17),
      Q => \w_data_reg_n_0_[17]\,
      R => \p_0_in__0\
    );
\w_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(18),
      Q => \w_data_reg_n_0_[18]\,
      R => \p_0_in__0\
    );
\w_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(19),
      Q => \w_data_reg_n_0_[19]\,
      R => \p_0_in__0\
    );
\w_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(1),
      Q => \w_data_reg_n_0_[1]\,
      R => \p_0_in__0\
    );
\w_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(2),
      Q => \w_data_reg_n_0_[2]\,
      R => \p_0_in__0\
    );
\w_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(3),
      Q => \w_data_reg_n_0_[3]\,
      R => \p_0_in__0\
    );
\w_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(4),
      Q => \w_data_reg_n_0_[4]\,
      R => \p_0_in__0\
    );
\w_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(5),
      Q => \w_data_reg_n_0_[5]\,
      R => \p_0_in__0\
    );
\w_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(6),
      Q => \w_data_reg_n_0_[6]\,
      R => \p_0_in__0\
    );
\w_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(7),
      Q => \w_data_reg_n_0_[7]\,
      R => \p_0_in__0\
    );
\w_data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(8),
      Q => \w_data_reg_n_0_[8]\,
      R => \p_0_in__0\
    );
\w_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WDATA(9),
      Q => \w_data_reg_n_0_[9]\,
      R => \p_0_in__0\
    );
w_done_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00E0E0E0"
    )
        port map (
      I0 => S_AXI_WVALID,
      I1 => w_done_reg_n_0,
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
      R => \p_0_in__0\
    );
\w_strb_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WSTRB(1),
      Q => p_1_in0,
      R => \p_0_in__0\
    );
\w_strb_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => axi_wready0,
      D => S_AXI_WSTRB(2),
      Q => \w_strb_reg_n_0_[2]\,
      R => \p_0_in__0\
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
      CLR => u_demod_core_n_17,
      D => wr_pulse_axi,
      Q => \wr_pulse_sync_reg_n_0_[0]\
    );
\wr_pulse_sync_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => u_demod_core_n_17,
      D => \wr_pulse_sync_reg_n_0_[0]\,
      Q => wr_pulse_core
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
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
    adc_data : in STD_LOGIC_VECTOR ( 63 downto 0 );
    adc_valid : in STD_LOGIC;
    M_AXIS_BITS_TDATA : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXIS_BITS_TVALID : out STD_LOGIC;
    M_AXIS_BITS_TREADY : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "system_bpsk_demodulator_0_0,bpsk_demod_v1_0,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "bpsk_demod_v1_0,Vivado 2022.2";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \<const0>\ : STD_LOGIC;
  signal NLW_inst_S_AXI_BRESP_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_S_AXI_RRESP_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of inst : label is 8;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of inst : label is 32;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of M_AXIS_BITS_TREADY : signal is "xilinx.com:interface:axis:1.0 M_AXIS_BITS TREADY";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of M_AXIS_BITS_TREADY : signal is "XIL_INTERFACENAME M_AXIS_BITS, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of M_AXIS_BITS_TVALID : signal is "xilinx.com:interface:axis:1.0 M_AXIS_BITS TVALID";
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
  attribute X_INTERFACE_PARAMETER of aclk : signal is "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF M_AXIS_BITS, ASSOCIATED_RESET aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_util_ad9361_divclk_0_clk_out, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of aresetn : signal is "xilinx.com:signal:reset:1.0 aresetn RST";
  attribute X_INTERFACE_PARAMETER of aresetn : signal is "XIL_INTERFACENAME aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of M_AXIS_BITS_TDATA : signal is "xilinx.com:interface:axis:1.0 M_AXIS_BITS TDATA";
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
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_bpsk_demod_v1_0
     port map (
      M_AXIS_BITS_TDATA(7 downto 0) => M_AXIS_BITS_TDATA(7 downto 0),
      M_AXIS_BITS_TREADY => M_AXIS_BITS_TREADY,
      M_AXIS_BITS_TVALID => M_AXIS_BITS_TVALID,
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
      S_AXI_WDATA(31 downto 20) => B"000000000000",
      S_AXI_WDATA(19 downto 0) => S_AXI_WDATA(19 downto 0),
      S_AXI_WREADY => S_AXI_WREADY,
      S_AXI_WSTRB(3) => '0',
      S_AXI_WSTRB(2 downto 0) => S_AXI_WSTRB(2 downto 0),
      S_AXI_WVALID => S_AXI_WVALID,
      aclk => aclk,
      adc_data(63 downto 32) => B"00000000000000000000000000000000",
      adc_data(31 downto 0) => adc_data(31 downto 0),
      adc_valid => adc_valid,
      aresetn => aresetn
    );
end STRUCTURE;
