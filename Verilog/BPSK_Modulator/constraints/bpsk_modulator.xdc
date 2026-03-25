# =============================================================================
# bpsk_modulator.xdc  –  Timing constraints for BPSK Modulator IP
#
# Include this file in the Vivado IP constraint set when packaging the IP.
# It declares the two clock domains as asynchronous so Vivado does not try
# to time the CDC paths between S_AXI_ACLK (100 MHz) and aclk (~245 MHz).
#
# The internal 2-FF synchronizers make the CDC safe by design.
# =============================================================================

# Declare the two clocks as asynchronous groups.
# Replace the clock names with the actual names generated in your design
# (visible in Vivado's Clock Summary report after synthesis).
#
# Typical names in the FMCOMM2 ZED reference design:
#   S_AXI_ACLK  → sys_cpu_clk          (from PS7 FCLK_CLK0, 100 MHz)
#   aclk        → util_ad9361_divclk   (from AD9361 RX clock divider)

set_clock_groups -asynchronous \
    -group [get_clocks -include_generated_clocks -of_objects \
                [get_ports S_AXI_ACLK]] \
    -group [get_clocks -include_generated_clocks -of_objects \
                [get_ports aclk]]

# False path on the CDC registers used for multi-bit snapshot transfer.
# These are the holding registers in the AXI domain (snap_*) read by the
# aclk domain on a handshake pulse.  The 2-FF synchronizer on the pulse
# guarantees the data is stable before it is sampled.
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *snap_*_reg*}] \
               -to   [get_cells -hierarchical -filter {NAME =~ *core_*_reg*}]

# False path on the sym_count back-synchronization (diagnostic counter;
# short glitches are acceptable).
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *sym_count_reg*}] \
               -to   [get_cells -hierarchical -filter {NAME =~ *sym_cnt_ff*_reg*}]
