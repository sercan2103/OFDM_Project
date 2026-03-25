# =============================================================================
# create_project.tcl  –  Create Vivado GUI project for BPSK Modulator IP
#
# Usage – in the Vivado Tcl console:
#   cd /home/kemal/Desktop/FMCOMM2andos/BPSK_Modulator/vivado
#   source create_project.tcl
#
# This script creates a Vivado project (.xpr) that you can:
#   - Open with File → Open Project in the Vivado GUI
#   - Synthesize, simulate, and package as an IP core
#
# After this script finishes, the project is already open in Vivado.
# To package the IP, run:
#   source package_ip.tcl
# =============================================================================

set script_dir   [file dirname [file normalize [info script]]]
set project_root [file normalize "$script_dir/.."]
set project_name "bpsk_modulator"
set project_dir  "$script_dir/project"
set part         "xc7z020clg484-1"

puts "INFO: Creating Vivado project '$project_name'"
puts "INFO: Location : $project_dir"
puts "INFO: Device   : $part"

# Remove stale project directory if it exists
if {[file exists $project_dir]} {
    puts "INFO: Removing existing project directory"
    file delete -force $project_dir
}

# ---------------------------------------------------------------------------
# 1. Create project
# ---------------------------------------------------------------------------
create_project $project_name $project_dir -part $part

# Set board part (optional – only works if the ZED board files are installed)
if {[catch {set_property board_part em.avnet.com:zed:part0:1.4 [current_project]} err]} {
    puts "INFO: Board part not installed – continuing with device-only targeting."
    puts "      ($err)"
}

# ---------------------------------------------------------------------------
# 2. Add HDL source files
# ---------------------------------------------------------------------------
set src_dir "$project_root/src"
set src_files [list \
    "$src_dir/bpsk_core.v" \
    "$src_dir/bpsk_modulator_v1_0.v" \
]

add_files -norecurse $src_files
set_property file_type Verilog [get_files $src_files]
update_compile_order -fileset sources_1
set_property top bpsk_modulator_v1_0 [get_filesets sources_1]

puts "INFO: Added [llength $src_files] source file(s)"

# ---------------------------------------------------------------------------
# 3. Add testbench to simulation fileset
# ---------------------------------------------------------------------------
set tb_file "$project_root/tb/bpsk_tb.v"
add_files -fileset sim_1 -norecurse $tb_file
set_property file_type Verilog [get_files -of_objects [get_filesets sim_1] $tb_file]
set_property top bpsk_tb [get_filesets sim_1]
update_compile_order -fileset sim_1

puts "INFO: Added testbench: $tb_file"

# ---------------------------------------------------------------------------
# 4. Add XDC constraints
# ---------------------------------------------------------------------------
set xdc_file "$project_root/constraints/bpsk_modulator.xdc"
add_files -fileset constrs_1 -norecurse $xdc_file
# Mark OOC so it applies during IP packaging, not full implementation
set_property USED_IN {out_of_context} [get_files $xdc_file]

puts "INFO: Added constraints: $xdc_file"

# ---------------------------------------------------------------------------
# 5. Configure synthesis run for out-of-context (needed for IP packaging)
# ---------------------------------------------------------------------------
set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} \
             -value {-mode out_of_context} \
             -objects [get_runs synth_1]

# ---------------------------------------------------------------------------
# 6. Save project
# ---------------------------------------------------------------------------
# The .xpr file is at: $project_dir/$project_name.xpr
# You can reopen it with: File → Open Project in the Vivado GUI

puts ""
puts "============================================================"
puts " Project created successfully."
puts ""
puts " Project file: $project_dir/$project_name.xpr"
puts ""
puts " Next steps:"
puts "   Run synthesis   : launch_runs synth_1 -jobs 4"
puts "   Run simulation  : launch_simulation"
puts "   Package as IP   : source $script_dir/package_ip.tcl"
puts "============================================================"
