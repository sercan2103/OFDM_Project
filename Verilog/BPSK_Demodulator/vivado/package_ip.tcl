# =============================================================================
# package_ip.tcl  –  Package BPSK Demodulator as a Vivado IP Core
#
# Prerequisites:
#   1. Run create_project.tcl first  (project must be open in Vivado)
#   2. Synthesis must have completed:
#        launch_runs synth_1 -jobs 4
#        wait_on_run synth_1
#
# Usage – in the Vivado Tcl console with the bpsk_demodulator project open:
#   source package_ip.tcl
#
# Output:
#   IP repository at:  <BPSK_Demodulator>/ip_repo/bpsk_demodulator_v1_0/
#
# To add this IP to the FMCOMM2 ZED project:
#   1. Tools → Settings → IP → Repository
#      Add:  /home/kemal/Desktop/FMCOMM2andos/BPSK_Demodulator/ip_repo
#   2. Click "Update IP Catalog"
#   3. Search "BPSK Demodulator" in the IP catalog and add to block design
# =============================================================================

set script_dir   [file dirname [file normalize [info script]]]
set project_root [file normalize "$script_dir/.."]
set ip_root      "$project_root/ip_repo/bpsk_demodulator_v1_0"

puts "INFO: Packaging BPSK Demodulator IP..."
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
#      S_AXI_*       → AXI4-Lite slave
#      M_AXIS_BITS_* → AXI4-Stream master
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
set_property name            bpsk_demodulator          $core
set_property version         1.0                       $core
set_property display_name   "BPSK Demodulator v1.0"   $core
set_property description \
    "Conventional BPSK demodulator with AGC, Costas loop, and Mueller-Müller\
 symbol timing recovery. Taps the ADI util_ad9361_adc_pack FIFO_WR output\
 on the ZED/FMCOMM2 board without breaking the existing ADC DMA path.\
 Decoded bytes output via AXI4-Stream. AXI4-Lite control registers at\
 base address 0x43C0_0000." \
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
#    aclk        drives the AXI4-Stream master (M_AXIS_BITS)
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

set_clock_assoc S_AXI_ACLK "S_AXI"          $core
set_clock_assoc aclk        "M_AXIS_BITS"    $core

# ---------------------------------------------------------------------------
# 5. Reset polarity
#    Set POLARITY on the bus *parameter* of each reset interface.
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
puts "   3. Find 'BPSK Demodulator v1.0' in IP catalog → add to block design"
puts "   4. See TUTORIAL.md for full connection instructions"
puts "============================================================"
