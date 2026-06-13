## Stage 2A physical pin constraints.
##
## ZedBoard reference: AVNET XTP040 schematic.
## FMCOMMS3 pins lifted from adi-hdl/projects/fmcomms2/zed/system_constr.xdc
## (FMCOMMS2 and FMCOMMS3 share the same AD9361 + same FMC LPC pinout).
##
## Stage 2A only routes the SPI lines + 3 control GPIOs. The data path
## (rx_clk_in, rx_data_in, tx_clk_out, tx_data_out, etc.) is added in
## Stage 2B once SPI bring-up is confirmed.
##
## ILA debug-core constraints are created in build.tcl after synth and
## persisted in the synth_1 checkpoint -- do NOT save them here.
set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS33} [get_ports led]

# AD9361 control (FMC LPC LVCMOS25 single-ended)
set_property -dict {PACKAGE_PIN A16 IOSTANDARD LVCMOS25} [get_ports ad9361_resetb]   ; ## H31  FMC_LPC_LA28_P
set_property -dict {PACKAGE_PIN J20 IOSTANDARD LVCMOS25} [get_ports ad9361_enable]   ; ## G18  FMC_LPC_LA16_P
set_property -dict {PACKAGE_PIN K21 IOSTANDARD LVCMOS25} [get_ports ad9361_txnrx]    ; ## G19  FMC_LPC_LA16_N

# AD9361 SPI (FMC LPC LVCMOS25)
set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVCMOS25 PULLTYPE PULLUP} [get_ports ad9361_spi_csn]  ; ## D26  FMC_LPC_LA26_P
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS25} [get_ports ad9361_spi_clk]                  ; ## D27  FMC_LPC_LA26_N
set_property -dict {PACKAGE_PIN E21 IOSTANDARD LVCMOS25} [get_ports ad9361_spi_mosi]                 ; ## C26  FMC_LPC_LA27_P
set_property -dict {PACKAGE_PIN D21 IOSTANDARD LVCMOS25} [get_ports ad9361_spi_miso]                 ; ## C27  FMC_LPC_LA27_N

# AD9361 LVDS data interface (FMC LPC, LVDS_25 with diff term on RX)
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_clk_in_p]      ; ## G6   FMC_LPC_LA00_CC_P
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_clk_in_n]      ; ## G7   FMC_LPC_LA00_CC_N
set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_frame_in_p]    ; ## D8   FMC_LPC_LA01_CC_P
set_property -dict {PACKAGE_PIN N20 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_frame_in_n]    ; ## D9   FMC_LPC_LA01_CC_N
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[0]]  ; ## H7   FMC_LPC_LA02_P
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[0]]  ; ## H8   FMC_LPC_LA02_N
set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[1]]  ; ## G9   FMC_LPC_LA03_P
set_property -dict {PACKAGE_PIN P22 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[1]]  ; ## G10  FMC_LPC_LA03_N
set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[2]]  ; ## H10  FMC_LPC_LA04_P
set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[2]]  ; ## H11  FMC_LPC_LA04_N
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[3]]  ; ## D11  FMC_LPC_LA05_P
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[3]]  ; ## D12  FMC_LPC_LA05_N
set_property -dict {PACKAGE_PIN L21 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[4]]  ; ## C10  FMC_LPC_LA06_P
set_property -dict {PACKAGE_PIN L22 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[4]]  ; ## C11  FMC_LPC_LA06_N
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_p[5]]  ; ## H13  FMC_LPC_LA07_P
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports rx_data_in_n[5]]  ; ## H14  FMC_LPC_LA07_N
set_property -dict {PACKAGE_PIN J21 IOSTANDARD LVDS_25} [get_ports tx_clk_out_p]                    ; ## G12  FMC_LPC_LA08_P
set_property -dict {PACKAGE_PIN J22 IOSTANDARD LVDS_25} [get_ports tx_clk_out_n]                    ; ## G13  FMC_LPC_LA08_N
set_property -dict {PACKAGE_PIN R20 IOSTANDARD LVDS_25} [get_ports tx_frame_out_p]                  ; ## D14  FMC_LPC_LA09_P
set_property -dict {PACKAGE_PIN R21 IOSTANDARD LVDS_25} [get_ports tx_frame_out_n]                  ; ## D15  FMC_LPC_LA09_N
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVDS_25} [get_ports tx_data_out_p[0]]                ; ## H16  FMC_LPC_LA11_P
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVDS_25} [get_ports tx_data_out_n[0]]                ; ## H17  FMC_LPC_LA11_N
set_property -dict {PACKAGE_PIN P20 IOSTANDARD LVDS_25} [get_ports tx_data_out_p[1]]                ; ## G15  FMC_LPC_LA12_P
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVDS_25} [get_ports tx_data_out_n[1]]                ; ## G16  FMC_LPC_LA12_N
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVDS_25} [get_ports tx_data_out_p[2]]                ; ## D17  FMC_LPC_LA13_P
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVDS_25} [get_ports tx_data_out_n[2]]                ; ## D18  FMC_LPC_LA13_N
set_property -dict {PACKAGE_PIN R19 IOSTANDARD LVDS_25} [get_ports tx_data_out_p[3]]                ; ## C14  FMC_LPC_LA10_P
set_property -dict {PACKAGE_PIN T19 IOSTANDARD LVDS_25} [get_ports tx_data_out_n[3]]                ; ## C15  FMC_LPC_LA10_N
set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVDS_25} [get_ports tx_data_out_p[4]]                ; ## C18  FMC_LPC_LA14_P
set_property -dict {PACKAGE_PIN K20 IOSTANDARD LVDS_25} [get_ports tx_data_out_n[4]]                ; ## C19  FMC_LPC_LA14_N
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVDS_25} [get_ports tx_data_out_p[5]]                ; ## H19  FMC_LPC_LA15_P
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVDS_25} [get_ports tx_data_out_n[5]]                ; ## H20  FMC_LPC_LA15_N

# AD9361 RX clock: 250 MHz (DDR @ 125 MHz nominal at chip's max sample rate;
# we'll likely run slower but the IP needs a worst-case constraint).
create_clock -name rx_clk -period 4.0 [get_ports rx_clk_in_p]
