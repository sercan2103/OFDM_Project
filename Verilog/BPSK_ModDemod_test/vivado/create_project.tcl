# =============================================================================
# create_project.tcl  –  BPSK Mod/Demod End-to-End BER Test Project
#
# Creates a Vivado simulation-only project that includes:
#   • bpsk_core.v          (from BPSK_Modulator/src)
#   • bpsk_demod_nco.v     (from BPSK_Demodulator/src)
#   • bpsk_demod_agc.v     (from BPSK_Demodulator/src)
#   • bpsk_demod_core.v    (from BPSK_Demodulator/src)
#   • lfsr.v               (from BPSK_ModDemod_test/src)
#   • moddemod_tb.v        (from BPSK_ModDemod_test/tb)
#
# Usage – in Vivado Tcl console:
#   cd /home/kemal/Desktop/FMCOMM2andos/BPSK_ModDemod_test/vivado
#   source create_project.tcl
#
# Then run simulation:
#   set_property top moddemod_tb [get_filesets sim_1]
#   launch_simulation
#   run all
# =============================================================================

set script_dir   [file dirname [file normalize [info script]]]
set project_root [file normalize "$script_dir/.."]
set repo_root    [file normalize "$project_root/.."]
set project_name "bpsk_moddemod_test"
set project_dir  "$script_dir/project"
set part         "xc7z020clg484-1"

puts "INFO: Creating BER test project '$project_name'"
puts "INFO: Location : $project_dir"

if {[file exists $project_dir]} {
    file delete -force $project_dir
}

create_project $project_name $project_dir -part $part

if {[catch {set_property board_part em.avnet.com:zed:part0:1.4 [current_project]} err]} {
    puts "INFO: Board part not installed, continuing device-only. ($err)"
}

# ---------------------------------------------------------------------------
# Source files (no AXI wrappers needed – cores only)
# ---------------------------------------------------------------------------
set src_files [list \
    "$project_root/src/lfsr.v" \
    "$repo_root/BPSK_Modulator/src/bpsk_core.v" \
    "$repo_root/BPSK_Demodulator/src/bpsk_demod_nco.v" \
    "$repo_root/BPSK_Demodulator/src/bpsk_demod_agc.v" \
    "$repo_root/BPSK_Demodulator/src/bpsk_demod_core.v" \
]

add_files -norecurse $src_files
set_property file_type Verilog [get_files $src_files]
update_compile_order -fileset sources_1

# ---------------------------------------------------------------------------
# Testbench
# ---------------------------------------------------------------------------
set tb_file "$project_root/tb/moddemod_tb.v"
add_files -fileset sim_1 -norecurse $tb_file
set_property file_type Verilog [get_files -of_objects [get_filesets sim_1] $tb_file]
update_compile_order -fileset sim_1
set_property top moddemod_tb [get_filesets sim_1]

# ---------------------------------------------------------------------------
# Simulation settings
# ---------------------------------------------------------------------------
set_property -name {xsim.simulate.runtime} -value {50ms} -objects [get_filesets sim_1]
set_property -name {xsim.simulate.log_all_signals} -value {true} -objects [get_filesets sim_1]

puts ""
puts "============================================================"
puts " Project created: $project_dir/$project_name.xpr"
puts ""
puts " Run simulation:"
puts "   launch_simulation"
puts "   run all"
puts ""
puts " Expected output at end of simulation:"
puts "   RESULT: PERFECT  – BER = 0 (zero bit errors)"
puts "============================================================"
