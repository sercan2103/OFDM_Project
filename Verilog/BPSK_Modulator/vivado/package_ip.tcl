# =============================================================================
# package_ip.tcl  –  Package BPSK Modulator as a Vivado IP Core
#
# Prerequisites:
#   1. Run create_project.tcl first  (project must be open in Vivado)
#   2. Synthesis must have completed:
#        launch_runs synth_1 -jobs 4
#        wait_on_run synth_1
#
# Usage – in the Vivado Tcl console with the bpsk_modulator project open:
#   source package_ip.tcl
#
# Output:
#   IP repository at:  <BPSK_Modulator>/ip_repo/bpsk_modulator_v1_0/
#
# To add this IP to the FMCOMM2 ZED project:
#   1. Tools → Settings → IP → Repository
#      Add:  /home/kemal/Desktop/FMCOMM2andos/BPSK_Modulator/ip_repo
#   2. Click "Update IP Catalog"
#   3. Search "BPSK Modulator" in the IP catalog and add to block design
# =============================================================================

set script_dir   [file dirname [file normalize [info script]]]
set project_root [file normalize "$script_dir/.."]
set ip_root      "$project_root/ip_repo/bpsk_modulator_v1_0"

puts "INFO: Packaging BPSK Modulator IP..."
puts "INFO: Output directory: $ip_root"

# Remove stale IP output directory
if {[file exists $ip_root]} {
    puts "INFO: Removing existing IP directory"
    file delete -force $ip_root
}
file mkdir $ip_root

# ---------------------------------------------------------------------------
# 1. Package the project
#    -import_files copies HDL into the IP directory and auto-infers all bus
#    interfaces from port naming conventions:
#      S_AXI_*     → AXI4-Lite slave
#      S_AXIS_*    → AXI4-Stream slave
#      M_AXIS_*    → AXI4-Stream master
#      aclk/aresetn, S_AXI_ACLK/S_AXI_ARESETN → clock/reset interfaces
#
#    Do NOT call ipx::infer_bus_interfaces afterwards – that creates duplicates.
# ---------------------------------------------------------------------------
ipx::package_project \
    -root_dir        $ip_root \
    -vendor          user.org \
    -library         user \
    -taxonomy        /UserIP \
    -import_files \
    -set_current     true

set core [ipx::current_core]

# ---------------------------------------------------------------------------
# 2. Core identity / metadata
# ---------------------------------------------------------------------------
set_property name            bpsk_modulator          $core
set_property version         1.0                     $core
set_property display_name   "BPSK Modulator v1.0"    $core
set_property description \
    "BPSK modulator with AXI4-Lite control registers and 64-bit AXI4-Stream\
 I/Q output. Inserts into the Analog Devices FMCOMM2/AD9361 DAC data path\
 on the ZED board, replacing the DAC DMA stream to util_ad9361_dac_upack.\
 Supports internal test patterns, register patterns, or serial bit input." \
    $core
set_property vendor              user.org    $core
set_property vendor_display_name "User"      $core
set_property company_url         ""          $core
set_property supported_families  {zynq Production}  $core

# ---------------------------------------------------------------------------
# 3. Print what was auto-inferred (for diagnostics)
# ---------------------------------------------------------------------------
puts "INFO: Auto-inferred bus interfaces:"
foreach bi [ipx::get_bus_interfaces -of_objects $core] {
    puts "       [get_property name $bi]  ([get_property interface_mode $bi])"
}

# ---------------------------------------------------------------------------
# 4. Clock → interface associations
#    These are NOT auto-inferred; must be set manually.
#    S_AXI_ACLK  drives the AXI4-Lite slave
#    aclk        drives the three AXI4-Stream interfaces
# ---------------------------------------------------------------------------
proc set_clock_assoc {clk_name busif_value core} {
    set clk_if [ipx::get_bus_interfaces $clk_name -of_objects $core]
    if {$clk_if eq ""} {
        puts "WARNING: clock interface '$clk_name' not found – skipping"
        return
    }
    set param [ipx::get_bus_parameters ASSOCIATED_BUSIF -of_objects $clk_if]
    if {$param eq ""} {
        ipx::add_bus_parameter ASSOCIATED_BUSIF $clk_if
        set param [ipx::get_bus_parameters ASSOCIATED_BUSIF -of_objects $clk_if]
    }
    set_property value $busif_value $param
    puts "INFO: clock '$clk_name' associated with: $busif_value"
}

set_clock_assoc S_AXI_ACLK "S_AXI"                              $core
set_clock_assoc aclk        "S_AXIS_BITS:S_AXIS_DMA:M_AXIS_DAC" $core

# ---------------------------------------------------------------------------
# 5. Reset polarity
#    Set POLARITY on the bus *parameter* of each reset interface.
#    Setting it on the interface object itself is incorrect (Vivado API bug).
# ---------------------------------------------------------------------------
proc set_reset_polarity {rst_name polarity core} {
    set rst_if [ipx::get_bus_interfaces $rst_name -of_objects $core]
    if {$rst_if eq ""} {
        puts "WARNING: reset interface '$rst_name' not found – skipping"
        return
    }
    set param [ipx::get_bus_parameters POLARITY -of_objects $rst_if]
    if {$param eq ""} {
        ipx::add_bus_parameter POLARITY $rst_if
        set param [ipx::get_bus_parameters POLARITY -of_objects $rst_if]
    }
    set_property value $polarity $param
    puts "INFO: reset '$rst_name' polarity set to $polarity"
}

set_reset_polarity S_AXI_ARESETN ACTIVE_LOW $core
set_reset_polarity aresetn        ACTIVE_LOW $core

# ---------------------------------------------------------------------------
# 6. Verify memory map exists (auto-inferred by ipx::package_project)
#    Just log it; do NOT try to set slave_memory_map_ref manually –
#    the auto-inference wires this up correctly.
# ---------------------------------------------------------------------------
set mmaps [ipx::get_memory_maps -of_objects $core]
if {[llength $mmaps] > 0} {
    puts "INFO: Memory maps found: [llength $mmaps]"
    foreach mm $mmaps {
        puts "       [get_property name $mm]"
    }
} else {
    puts "WARNING: No memory map inferred – AXI4-Lite register access may not appear in Address Editor"
}

# ---------------------------------------------------------------------------
# 7. Generate xgui, checksum, validate, save
# ---------------------------------------------------------------------------
ipx::create_xgui_files $core
ipx::update_checksums   $core

set check_result [ipx::check_integrity $core]
if {$check_result == 0} {
    puts "INFO: IP integrity check PASSED"
} else {
    puts "WARNING: IP integrity check returned issues – review messages above"
}

ipx::save_core $core

puts ""
puts "============================================================"
puts " IP core packaged successfully."
puts " Location: $ip_root"
puts ""
puts " To use in the FMCOMM2 ZED project:"
puts "   1. Tools → Settings → IP → Repository"
puts "      Add: $project_root/ip_repo"
puts "   2. Click Refresh IP Catalog"
puts "   3. Find 'BPSK Modulator v1.0' in IP catalog → add to block design"
puts "   4. See connection notes in bpsk_modulator_v1_0.v header"
puts "============================================================"
