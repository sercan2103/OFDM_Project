# =============================================================================
# bpsk_demod.xdc  –  BPSK Demodulator CDC Constraints
#
# Two asynchronous clock domains:
#   S_AXI_ACLK  : 100 MHz system clock (AXI4-Lite registers)
#   aclk        : ~245 MHz ADI divclk (ADC data path / demodulator core)
#
# These constraints suppress timing analysis across the 2-FF synchronizer
# register chains. All CDC paths use double-register synchronizers and
# snapshot registers – no combinational paths cross domain boundaries.
# =============================================================================

# Declare virtual clocks for out-of-context (OOC) synthesis.
# In the full block design these are driven by real clock nets.
create_clock -period 10.000 -name S_AXI_ACLK [get_ports S_AXI_ACLK]
create_clock -period  4.069 -name aclk        [get_ports aclk]

# The two clocks are asynchronous – no phase relationship.
set_clock_groups -asynchronous \
    -group [get_clocks S_AXI_ACLK] \
    -group [get_clocks aclk]

# ---- AXI → Core (config) CDC false paths ------------------------------------
# wr_pulse_sync: 2-FF synchronizer chain
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *wr_pulse_axi*}] \
               -to   [get_cells -hierarchical -filter {NAME =~ *wr_pulse_sync*}]

# Snapshot registers (stable before pulse, sampled in aclk domain)
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *snap_enable*}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *snap_bypass*}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *snap_sps*}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *snap_agc*}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *snap_costas*}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *snap_timing*}]

# ---- Core → AXI (status) CDC false paths ------------------------------------
# carrier_locked / agc_settled single-bit synchronizer chains
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *raw_carrier_locked*}] \
               -to   [get_cells -hierarchical -filter {NAME =~ *locked_ff*}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *raw_agc_settled*}] \
               -to   [get_cells -hierarchical -filter {NAME =~ *settled_ff*}]

# Multi-bit diagnostic registers (glitch-tolerant, read by software)
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *agc_gain_ff1*}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *phase_err_ff1*}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *timing_err_ff1*}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *bit_cnt_ff1*}]
