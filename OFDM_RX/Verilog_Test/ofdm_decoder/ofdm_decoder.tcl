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

set project_name "ofdm_decoder"

create_project $project_name ./$project_name -part xc7z020clg484-1 -force

set obj [get_projects $project_name]
set_property "default_lib" "xil_defaultlib" $obj
set_property "part" "xc7z020clg484-1" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "Verilog" $obj

if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

set obj [get_filesets sources_1]
add_files -norecurse -fileset $obj [glob ./src/*.v]

# Add IP cores
set ip_files [list]
if {[file exists ./src/ip_cores/viterbi_v7_0/viterbi_v7_0.xci]} {
    lappend ip_files ./src/ip_cores/viterbi_v7_0/viterbi_v7_0.xci
    puts "Adding viterbi_v7_0 IP core"
}
if {[file exists ./src/ip_cores/complex_multiplier/complex_multiplier.xci]} {
    lappend ip_files ./src/ip_cores/complex_multiplier/complex_multiplier.xci
    puts "Adding complex_multiplier IP core"
}
if {[file exists ./src/ip_cores/div_gen_csi_over_nova/div_gen_csi_over_nova.xci]} {
    lappend ip_files ./src/ip_cores/div_gen_csi_over_nova/div_gen_csi_over_nova.xci
    puts "Adding div_gen_csi_over_nova IP core"
}
if {[file exists ./src/ip_cores/deinter_lut/deinter_lut.xci]} {
    lappend ip_files ./src/ip_cores/deinter_lut/deinter_lut.xci
    puts "Adding deinter_lut IP core"
}

if {[llength $ip_files] > 0} {
    add_files -fileset $obj $ip_files
    puts "Added [llength $ip_files] IP core(s) to project"
}

set_property "top" "ofdm_decoder" $obj

if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

set obj [get_filesets sim_1]
set_property "top" "ofdm_decoder_tb" $obj
set_property "xsim.simulate.runtime" "200us" $obj

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "Project $project_name created successfully!"
puts "Location: ./$project_name/$project_name.xpr"
puts ""
puts "To open the project, run:"
puts "  vivado ./$project_name/$project_name.xpr"

if {[info exists ::env(VIVADO_BATCH_MODE)]} {
    exit
}
