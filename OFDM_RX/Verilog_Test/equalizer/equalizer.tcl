# Equalizer Module Vivado Project Creation Script
# Author: Generated for OpenWiFi equalizer module extraction
# SPDX-FileCopyrightText: 2026
# SPDX-License-Identifier: AGPL-3.0-or-later

# Process arguments
set ARGUMENT1 [lindex $argv 0]
set ARGUMENT2 [lindex $argv 1]

if {$ARGUMENT1 == ""} {
    set BOARD_NAME "zed_fmcs2"
} else {
    set BOARD_NAME $ARGUMENT1
}

if {$ARGUMENT2 == ""} {
    set NUM_CLK_PER_US 100
} else {
    set NUM_CLK_PER_US $ARGUMENT2
}

puts "BOARD_NAME: $BOARD_NAME"
puts "NUM_CLK_PER_US: $NUM_CLK_PER_US"

# Set project name
set project_name "equalizer"

# Create project
create_project $project_name ./$project_name -part xc7z020clg484-1 -force

# Set project properties
set obj [get_projects $project_name]
set_property "default_lib" "xil_defaultlib" $obj
set_property "part" "xc7z020clg484-1" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "Verilog" $obj

# Create filesets
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Add source files
set obj [get_filesets sources_1]
add_files -norecurse -fileset $obj [glob ./src/*.v]

# Add IP cores
set ip_files [list]
if {[file exists ./src/ip_cores/complex_multiplier/complex_multiplier.xci]} {
    lappend ip_files ./src/ip_cores/complex_multiplier/complex_multiplier.xci
    puts "Adding complex_multiplier IP core"
}
if {[file exists ./src/ip_cores/div_gen_div_gen_0_0/div_gen_div_gen_0_0.xci]} {
    lappend ip_files ./src/ip_cores/div_gen_div_gen_0_0/div_gen_div_gen_0_0.xci
    puts "Adding div_gen_div_gen_0_0 IP core"
}
if {[file exists ./src/ip_cores/div_gen_xlslice_0_0/div_gen_xlslice_0_0.xci]} {
    lappend ip_files ./src/ip_cores/div_gen_xlslice_0_0/div_gen_xlslice_0_0.xci
    puts "Adding div_gen_xlslice_0_0 IP core"
}

if {[llength $ip_files] > 0} {
    add_files -fileset $obj $ip_files
    puts "Added [llength $ip_files] IP core(s) to project"
}

# Set top module
set_property "top" "equalizer" $obj

# Create simulation fileset
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

set obj [get_filesets sim_1]
set_property "top" "equalizer_tb" $obj
set_property "xsim.simulate.runtime" "10us" $obj

# Update compile order
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# Create block design (optional - can be done manually in GUI)
puts "Project $project_name created successfully!"
puts "Location: ./$project_name/$project_name.xpr"
puts ""
puts "To open the project, run:"
puts "  vivado ./$project_name/$project_name.xpr"

# Exit Vivado if running in batch mode
if {[info exists ::env(VIVADO_BATCH_MODE)]} {
    exit
}
