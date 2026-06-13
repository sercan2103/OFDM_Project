## Stage 2B-1 block design.
##
## Stage 2A.5 (Zynq PS7 + UART1 + EMIO GPIO + SPI0 EMIO + AXI fabric +
## axi_gpio_test) PLUS:
##   - axi_ad9361 IP added on the same smartconnect (now 2 MIs).
##   - FCLK_CLK1 = 200 MHz enabled to drive axi_ad9361/delay_clk for
##     IDELAYCTRL.
##   - Second proc_sys_reset on the 200 MHz domain.
##   - LVDS pins (rx_clk/frame/data, tx_clk/frame/data) exposed at the
##     top level for FMC LPC routing.
##
## We KEEP axi_gpio_test on the bus so SW can run a 2-stage check:
##   1. Read/write axi_gpio_test  -> AXI fabric still works.
##   2. Read axi_ad9361 PCORE_VERSION -> ADI IP responds on the same bus.
## If only step 1 passes, the failure is specific to axi_ad9361, not
## the AXI infrastructure.
##
## EMIO GPIO bit allocation:
##   gpio_o[32]  = phy_tx_start  (Stage 1C)
##   gpio_o[33]  = ad9361_resetb (active low)
##   gpio_o[34]  = ad9361_enable
##   gpio_o[35]  = ad9361_txnrx
##   gpio_i[63:0] = Stage 1C decode counters
##
## Address map (M_AXI_GP0):
##   0x4000_0000 - 0x4000_FFFF : axi_gpio_test (64 KiB)
##   0x4001_0000 - 0x4001_FFFF : axi_ad9361    (64 KiB)

create_bd_design system

create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 sys_ps7
set_property -dict [list \
  CONFIG.PCW_IMPORT_BOARD_PRESET     {ZedBoard} \
  CONFIG.PCW_USE_M_AXI_GP0           {1} \
  CONFIG.PCW_USE_M_AXI_GP1           {0} \
  CONFIG.PCW_USE_S_AXI_HP0           {0} \
  CONFIG.PCW_USE_S_AXI_HP1           {0} \
  CONFIG.PCW_USE_S_AXI_HP2           {0} \
  CONFIG.PCW_USE_S_AXI_HP3           {0} \
  CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
  CONFIG.PCW_EN_CLK0_PORT            {1} \
  CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
  CONFIG.PCW_EN_CLK1_PORT            {1} \
  CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200} \
  CONFIG.PCW_EN_RST1_PORT            {1} \
  CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE   {1} \
  CONFIG.PCW_GPIO_EMIO_GPIO_IO       {64} \
  CONFIG.PCW_SPI0_PERIPHERAL_ENABLE  {1} \
  CONFIG.PCW_SPI0_SPI0_IO            {EMIO} \
] [get_bd_cells sys_ps7]

## ---- External ports ------------------------------------------------
make_bd_intf_pins_external [get_bd_intf_pins sys_ps7/DDR]
make_bd_intf_pins_external [get_bd_intf_pins sys_ps7/FIXED_IO]
set_property name DDR      [get_bd_intf_ports DDR_0]
set_property name FIXED_IO [get_bd_intf_ports FIXED_IO_0]

create_bd_port -dir O -from 63 -to 0 GPIO_O
create_bd_port -dir I -from 63 -to 0 GPIO_I
create_bd_port -dir O -from 63 -to 0 GPIO_T
connect_bd_net [get_bd_pins sys_ps7/GPIO_O] [get_bd_ports GPIO_O]
connect_bd_net [get_bd_pins sys_ps7/GPIO_I] [get_bd_ports GPIO_I]
connect_bd_net [get_bd_pins sys_ps7/GPIO_T] [get_bd_ports GPIO_T]

create_bd_port -dir O -type clk FCLK_CLK0
connect_bd_net [get_bd_pins sys_ps7/FCLK_CLK0] [get_bd_ports FCLK_CLK0]

create_bd_port -dir O -type rst peripheral_aresetn
connect_bd_net [get_bd_pins sys_ps7/FCLK_RESET0_N] [get_bd_ports peripheral_aresetn]

## ---- PS SPI0 EMIO -> top-level FMC pins ---------------------------
## Master mode: drive MOSI/SCLK/SS out, receive MISO. The PS7 IP
## exposes _O / _I / _T triplets for each pin; for master we drive
## from _O and tie _I/_T as appropriate at top level.
create_bd_port -dir O spi0_sclk_o
create_bd_port -dir O spi0_mosi_o
create_bd_port -dir I spi0_miso_i
create_bd_port -dir O spi0_ss_o
connect_bd_net [get_bd_pins sys_ps7/SPI0_SCLK_O] [get_bd_ports spi0_sclk_o]
connect_bd_net [get_bd_pins sys_ps7/SPI0_MOSI_O] [get_bd_ports spi0_mosi_o]
connect_bd_net [get_bd_pins sys_ps7/SPI0_MISO_I] [get_bd_ports spi0_miso_i]
connect_bd_net [get_bd_pins sys_ps7/SPI0_SS_O]   [get_bd_ports spi0_ss_o]
# Tie unused PS-side SPI inputs to safe defaults.
connect_bd_net [get_bd_pins sys_ps7/SPI0_SCLK_I] [get_bd_pins sys_ps7/SPI0_SCLK_O]
connect_bd_net [get_bd_pins sys_ps7/SPI0_SS_I]   [get_bd_pins sys_ps7/SPI0_SS_O]
connect_bd_net [get_bd_pins sys_ps7/SPI0_MOSI_I] [get_bd_pins sys_ps7/SPI0_MOSI_O]

## ---- AXI fabric (M_AXI_GP0 -> Smartconnect -> axi_gpio_test) ------
## Stage 2A.5: prove AXI works on a clean topology before adding
## axi_ad9361 in Stage 2B. axi_gpio_test is a 32-bit output-only GPIO
## used as a write-then-read AXI sanity slave.
##
## Wiring lessons applied (from prior Stage 1B failures):
##   - Don't use apply_bd_automation; wire every signal explicitly.
##   - proc_sys_reset's aux_reset_in / mb_debug_sys_rst / dcm_locked
##     must all be tied via xlconstant cells (Vivado 2022.2 doesn't
##     default them safely).
##   - Slow PS_AXI_ACLK to FCLK_CLK0 explicitly (not via auto-clock).

create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0    sys_rst
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0      axi_smc
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0          axi_gpio_test
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1        const_high
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1        const_low

set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {3}] [get_bd_cells axi_smc]

set_property -dict [list \
  CONFIG.C_GPIO_WIDTH  {32} \
  CONFIG.C_ALL_OUTPUTS {1} \
  CONFIG.C_IS_DUAL     {0} \
] [get_bd_cells axi_gpio_test]

set_property -dict [list CONFIG.CONST_VAL {1}] [get_bd_cells const_high]
set_property -dict [list CONFIG.CONST_VAL {0}] [get_bd_cells const_low]

# Second proc_sys_reset on the 200 MHz domain (for axi_ad9361/delay_clk
# and IDELAYCTRL).
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_rst_200

# axi_ad9361 IP. Defaults are mostly fine; ADC_INIT_DELAY=23 matches
# the ZedBoard/FMCOMMS2 reference design. TDD_DISABLE=1 since we don't
# use TDD; enable/txnrx are driven by EMIO GPIO instead.
create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361
set_property -dict [list \
  CONFIG.ID                 {0} \
  CONFIG.MODE_1R1T          {0} \
  CONFIG.TDD_DISABLE        {1} \
  CONFIG.ADC_INIT_DELAY     {23} \
] [get_bd_cells axi_ad9361]

# proc_sys_reset wiring (100 MHz domain)
connect_bd_net [get_bd_pins sys_ps7/FCLK_CLK0]      [get_bd_pins sys_rst/slowest_sync_clk]
connect_bd_net [get_bd_pins sys_ps7/FCLK_RESET0_N]  [get_bd_pins sys_rst/ext_reset_in]
connect_bd_net [get_bd_pins const_high/dout]        [get_bd_pins sys_rst/aux_reset_in]
connect_bd_net [get_bd_pins const_high/dout]        [get_bd_pins sys_rst/dcm_locked]
connect_bd_net [get_bd_pins const_low/dout]         [get_bd_pins sys_rst/mb_debug_sys_rst]

# proc_sys_reset wiring (200 MHz domain for delay_clk)
connect_bd_net [get_bd_pins sys_ps7/FCLK_CLK1]      [get_bd_pins sys_rst_200/slowest_sync_clk]
connect_bd_net [get_bd_pins sys_ps7/FCLK_RESET1_N]  [get_bd_pins sys_rst_200/ext_reset_in]
connect_bd_net [get_bd_pins const_high/dout]        [get_bd_pins sys_rst_200/aux_reset_in]
connect_bd_net [get_bd_pins const_high/dout]        [get_bd_pins sys_rst_200/dcm_locked]
connect_bd_net [get_bd_pins const_low/dout]         [get_bd_pins sys_rst_200/mb_debug_sys_rst]

# AXI bus -- 2 slaves on the smartconnect
connect_bd_intf_net [get_bd_intf_pins sys_ps7/M_AXI_GP0] [get_bd_intf_pins axi_smc/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins axi_smc/M00_AXI]   [get_bd_intf_pins axi_gpio_test/S_AXI]
connect_bd_intf_net [get_bd_intf_pins axi_smc/M01_AXI]   [get_bd_intf_pins axi_ad9361/s_axi]

# Clocks
connect_bd_net [get_bd_pins sys_ps7/FCLK_CLK0] [get_bd_pins sys_ps7/M_AXI_GP0_ACLK]
connect_bd_net [get_bd_pins sys_ps7/FCLK_CLK0] [get_bd_pins axi_smc/aclk]
connect_bd_net [get_bd_pins sys_ps7/FCLK_CLK0] [get_bd_pins axi_gpio_test/s_axi_aclk]
connect_bd_net [get_bd_pins sys_ps7/FCLK_CLK0] [get_bd_pins axi_ad9361/s_axi_aclk]
connect_bd_net [get_bd_pins sys_ps7/FCLK_CLK1] [get_bd_pins axi_ad9361/delay_clk]
# axi_ad9361/clk loops back from its own l_clk output (per ADI ref).
connect_bd_net [get_bd_pins axi_ad9361/l_clk]  [get_bd_pins axi_ad9361/clk]

# Resets
connect_bd_net [get_bd_pins sys_rst/peripheral_aresetn] [get_bd_pins axi_smc/aresetn]
connect_bd_net [get_bd_pins sys_rst/peripheral_aresetn] [get_bd_pins axi_gpio_test/s_axi_aresetn]
connect_bd_net [get_bd_pins sys_rst/peripheral_aresetn] [get_bd_pins axi_ad9361/s_axi_aresetn]

# Tie off all axi_ad9361 inputs that we don't drive at top-level.
# Multi-bit zeros via xlconstant cells.
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_z32
set_property -dict [list CONFIG.CONST_WIDTH {32} CONFIG.CONST_VAL {0}] [get_bd_cells const_z32]

connect_bd_net [get_bd_pins const_low/dout] [get_bd_pins axi_ad9361/adc_dovf]
connect_bd_net [get_bd_pins const_low/dout] [get_bd_pins axi_ad9361/dac_dunf]
connect_bd_net [get_bd_pins const_low/dout] [get_bd_pins axi_ad9361/dac_sync_in]
connect_bd_net [get_bd_pins const_low/dout] [get_bd_pins axi_ad9361/tdd_sync]
connect_bd_net [get_bd_pins const_low/dout] [get_bd_pins axi_ad9361/gps_pps]
connect_bd_net [get_bd_pins const_low/dout] [get_bd_pins axi_ad9361/up_enable]
connect_bd_net [get_bd_pins const_low/dout] [get_bd_pins axi_ad9361/up_txnrx]
connect_bd_net [get_bd_pins const_z32/dout] [get_bd_pins axi_ad9361/up_dac_gpio_in]
connect_bd_net [get_bd_pins const_z32/dout] [get_bd_pins axi_ad9361/up_adc_gpio_in]

## ---- Stage 2B-3: data-path ports out to PL (system_top.v) ---------
## Expose axi_ad9361's DAC inputs, ADC outputs, valid/enable strobes,
## and l_clk to the top-level so PL logic can drive a test pattern and
## capture the BIST mode 2 internal loopback. l_clk is the IP's data
## clock (~61.44 MHz for the chip's 30.72 MSPS LVDS DDR chain).
create_bd_port -dir O -type clk l_clk
connect_bd_net [get_bd_pins axi_ad9361/l_clk] [get_bd_ports l_clk]

# DAC data: four 16-bit input ports from PL.
foreach ch {i0 q0 i1 q1} {
  create_bd_port -dir I -from 15 -to 0 dac_data_${ch}
  connect_bd_net [get_bd_ports dac_data_${ch}] [get_bd_pins axi_ad9361/dac_data_${ch}]
}
# DAC valid / enable strobes: four single-bit outputs.
foreach ch {i0 q0 i1 q1} {
  create_bd_port -dir O dac_valid_${ch}
  connect_bd_net [get_bd_pins axi_ad9361/dac_valid_${ch}]  [get_bd_ports dac_valid_${ch}]
  create_bd_port -dir O dac_enable_${ch}
  connect_bd_net [get_bd_pins axi_ad9361/dac_enable_${ch}] [get_bd_ports dac_enable_${ch}]
}
# ADC: four 16-bit data outs + valid/enable.
foreach ch {i0 q0 i1 q1} {
  create_bd_port -dir O -from 15 -to 0 adc_data_${ch}
  connect_bd_net [get_bd_pins axi_ad9361/adc_data_${ch}] [get_bd_ports adc_data_${ch}]
  create_bd_port -dir O adc_valid_${ch}
  connect_bd_net [get_bd_pins axi_ad9361/adc_valid_${ch}]  [get_bd_ports adc_valid_${ch}]
  create_bd_port -dir O adc_enable_${ch}
  connect_bd_net [get_bd_pins axi_ad9361/adc_enable_${ch}] [get_bd_ports adc_enable_${ch}]
}

# LVDS top-level ports (FMC LPC pins -> XDC).
create_bd_port -dir I rx_clk_in_p
create_bd_port -dir I rx_clk_in_n
create_bd_port -dir I rx_frame_in_p
create_bd_port -dir I rx_frame_in_n
create_bd_port -dir I -from 5 -to 0 rx_data_in_p
create_bd_port -dir I -from 5 -to 0 rx_data_in_n
create_bd_port -dir O tx_clk_out_p
create_bd_port -dir O tx_clk_out_n
create_bd_port -dir O tx_frame_out_p
create_bd_port -dir O tx_frame_out_n
create_bd_port -dir O -from 5 -to 0 tx_data_out_p
create_bd_port -dir O -from 5 -to 0 tx_data_out_n
connect_bd_net [get_bd_ports rx_clk_in_p]   [get_bd_pins axi_ad9361/rx_clk_in_p]
connect_bd_net [get_bd_ports rx_clk_in_n]   [get_bd_pins axi_ad9361/rx_clk_in_n]
connect_bd_net [get_bd_ports rx_frame_in_p] [get_bd_pins axi_ad9361/rx_frame_in_p]
connect_bd_net [get_bd_ports rx_frame_in_n] [get_bd_pins axi_ad9361/rx_frame_in_n]
connect_bd_net [get_bd_ports rx_data_in_p]  [get_bd_pins axi_ad9361/rx_data_in_p]
connect_bd_net [get_bd_ports rx_data_in_n]  [get_bd_pins axi_ad9361/rx_data_in_n]
connect_bd_net [get_bd_pins axi_ad9361/tx_clk_out_p]    [get_bd_ports tx_clk_out_p]
connect_bd_net [get_bd_pins axi_ad9361/tx_clk_out_n]    [get_bd_ports tx_clk_out_n]
connect_bd_net [get_bd_pins axi_ad9361/tx_frame_out_p]  [get_bd_ports tx_frame_out_p]
connect_bd_net [get_bd_pins axi_ad9361/tx_frame_out_n]  [get_bd_ports tx_frame_out_n]
connect_bd_net [get_bd_pins axi_ad9361/tx_data_out_p]   [get_bd_ports tx_data_out_p]
connect_bd_net [get_bd_pins axi_ad9361/tx_data_out_n]   [get_bd_ports tx_data_out_n]

# Address assignments
assign_bd_address -offset 0x40000000 -range 64K \
  [get_bd_addr_segs {axi_gpio_test/S_AXI/Reg}]
assign_bd_address -offset 0x40010000 -range 64K \
  [get_bd_addr_segs {axi_ad9361/s_axi/axi_lite}]

## ---- Phase 3: xcvr relay BRAM + AXI BRAM Controller ------------------
##
## A 64-word × 64-bit (512 byte) True Dual Port BRAM:
##   Port A (32-bit): PS write via AXI BRAM Controller (M_AXI_GP0 → M02_AXI)
##   Port B (64-bit): openofdm_tx read (exposed as BRAM_PORTB_XCVR BD port)
##
## IMPORTANT: No extra output pipeline register on Port B.
## blk_mem_gen block RAM has inherent 1-cycle read latency, matching the
## existing tx_packet_rom_mcs behavior that openofdm_tx was tuned for.
## Adding Register_PortB_Output_of_Memory_Primitives would make it 2 cycles
## and silently corrupt every relayed packet.
##
## Address: 0x4002_0000 (auto-range).  Default xcvr_bram_sel = 0 (gpio_o[24])
## so the bitstream falls back to the Phase-2 ROM path when relay is not
## active.  Bring up Phase 1/2 on hardware before enabling Phase 3 relay.
##
## NOTE: These TCL commands were written offline and have not been validated
## interactively.  Before batch-building, run the BD section once in the
## Vivado GUI (source this file, watch validate_bd_design output) and
## confirm: (a) blk_mem_gen Read Latency = 1 for Port B, (b) AXI address
## is correctly assigned, (c) wrapper port names match system_top.v.

# True Dual Port BRAM: Port A 32-bit / 128 words, Port B 64-bit / 64 words.
# Memory size: 128 × 32 = 64 × 64 = 4096 bits = 512 bytes.
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_xcvr
set_property -dict [list \
  CONFIG.Memory_Type   {True_Dual_Port_RAM} \
  CONFIG.Write_Width_A {32} \
  CONFIG.Write_Depth_A {128} \
  CONFIG.Read_Width_A  {32} \
  CONFIG.Operating_Mode_A {READ_FIRST} \
  CONFIG.Write_Width_B {64} \
  CONFIG.Write_Depth_B {64} \
  CONFIG.Read_Width_B  {64} \
  CONFIG.Operating_Mode_B {READ_FIRST} \
  CONFIG.Enable_B      {Use_ENB_Pin} \
] [get_bd_cells blk_mem_gen_xcvr]
## Register_PortB_Output_of_Memory_Primitives is intentionally left at its
## default (false) so Port B has exactly 1-cycle read latency.

# AXI BRAM Controller: single-port, 32-bit AXI data, no ECC.
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_xcvr
set_property -dict [list \
  CONFIG.SINGLE_PORT_BRAM {1} \
  CONFIG.ECC_TYPE         {0} \
] [get_bd_cells axi_bram_ctrl_xcvr]

# Port A: AXI BRAM Ctrl <-> blk_mem_gen Port A.
connect_bd_intf_net \
  [get_bd_intf_pins axi_bram_ctrl_xcvr/BRAM_PORTA] \
  [get_bd_intf_pins blk_mem_gen_xcvr/BRAM_PORTA]

# AXI path: smartconnect M02_AXI -> axi_bram_ctrl_xcvr.
connect_bd_intf_net \
  [get_bd_intf_pins axi_smc/M02_AXI] \
  [get_bd_intf_pins axi_bram_ctrl_xcvr/S_AXI]

# Clock and reset for the new controller.
connect_bd_net [get_bd_pins sys_ps7/FCLK_CLK0] \
               [get_bd_pins axi_bram_ctrl_xcvr/s_axi_aclk]
connect_bd_net [get_bd_pins sys_rst/peripheral_aresetn] \
               [get_bd_pins axi_bram_ctrl_xcvr/s_axi_aresetn]

# Expose Port B as an external BD interface driven by system_top.v.
# The -name option gives a predictable port name so system_top.v can
# reference it without guessing the auto-generated suffix.
make_bd_intf_pins_external -name BRAM_PORTB_XCVR \
  [get_bd_intf_pins blk_mem_gen_xcvr/BRAM_PORTB]

# AXI address assignment for PS access.
# Let Vivado auto-pick the range to match the actual BRAM size (512 bytes),
# then override the offset to 0x4002_0000.
assign_bd_address -offset 0x40020000 \
  [get_bd_addr_segs {axi_bram_ctrl_xcvr/S_AXI/Mem0}]

regenerate_bd_layout
validate_bd_design
save_bd_design

make_wrapper -files [get_files system.bd] -top
add_files -norecurse [glob */*/sources_1/bd/system/hdl/system_wrapper.v]
