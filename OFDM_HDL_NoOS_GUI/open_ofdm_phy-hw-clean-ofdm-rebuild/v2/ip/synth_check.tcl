## Stage 1A standalone synth check.
##
## Runs out-of-context synthesis on openofdm_tx and openofdm_rx
## independently to confirm the vendored sources are clean (no missing
## files, no parse errors, no critical warnings).
##
## Usage:
##   cd v2/ip
##   vivado -mode batch -source synth_check.tcl
## or from inside Vivado:
##   source ./synth_check.tcl
##
## Pass criteria:
##   - both runs print "PASS" at the end
##   - 0 errors, 0 critical warnings reported per run
##
## Project lives in ./synth_check_proj/ -- delete to re-run cleanly.

set proj_dir "./synth_check_proj"
set part     "xc7z020clg484-1"

file delete -force $proj_dir
file mkdir $proj_dir
create_project synth_check $proj_dir -part $part

# -- Add all RTL + headers + ROM init files.
add_files -norecurse [glob ./openofdm_tx/*.v]
add_files -norecurse [glob ./openofdm_rx/*.v]
add_files -norecurse [glob ./openofdm_rx/usrp2/*.v]
add_files -norecurse [glob ./common/*.v]
add_files -norecurse [glob ./openofdm_tx/*.mem]

# -- Add the 8 Xilinx IP cores openofdm_rx depends on. add_files (not
#    import_ip) matches the prior project's working flow: Vivado uses
#    the .xci in place and auto-generates synthesis targets during
#    launch_runs. .coe init files for the BRAM ROMs (rot_lut, atan_lut,
#    deinter_lut) are referenced relative to the .xci, so adding the
#    .xci alone is enough.
foreach xci [glob ./xilinx_ip/*/*.xci] {
  add_files -norecurse $xci
}

# Tell Vivado where to find included headers (absolute paths -- relative
# paths break when Vivado evaluates them from the run subdir).
set ip_root [file normalize [file dirname [info script]]]
set_property include_dirs [list \
  $ip_root/common \
  $ip_root/openofdm_rx \
  $ip_root/openofdm_tx \
] [get_filesets sources_1]

# Mark the macro-only .v files as Verilog Headers so Vivado doesn't try
# to elaborate them as top-level modules (they have no module body).
foreach hdr {openofdm_rx_git_rev.v openofdm_rx_pre_def.v common_params.v} {
  set_property file_type "Verilog Header" [get_files $hdr]
}

update_compile_order -fileset sources_1

# -- Out-of-context synth, top = openofdm_tx.
proc synth_top {top} {
  global part
  puts "==== synth $top ===="
  set_property top $top [current_fileset]
  reset_run synth_1 -quiet
  # Disable auto-incremental synth: each iteration of synth_top runs a
  # different top, so reusing the previous checkpoint as a reference is
  # never useful and emits a misleading [Synth 8-6895] warning.
  set_property AUTO_INCREMENTAL_CHECKPOINT 0 [get_runs synth_1]
  launch_runs synth_1 -jobs 4
  wait_on_run synth_1
  set status [get_property STATUS [get_runs synth_1]]
  set errors [get_property STATS.ERRORS [get_runs synth_1]]
  set crits  [get_property STATS.CRITICAL_WARNINGS [get_runs synth_1]]
  # Empty values mean Vivado didn't populate them (older versions or
  # non-compile-stat runs) -- treat as 0 only if synth actually
  # completed. Otherwise the run never finished and is a failure.
  if {$errors eq ""} {set errors 0}
  if {$crits  eq ""} {set crits  0}
  puts "==== $top: status=\"$status\" errors=$errors critical_warnings=$crits ===="
  if {[string match "*Complete*" $status] && $errors == 0 && $crits == 0} {
    puts "PASS: $top"
    return 0
  } else {
    puts "FAIL: $top -- status=\"$status\" errors=$errors crits=$crits"
    return 1
  }
}

set rc 0
incr rc [synth_top openofdm_tx]
incr rc [synth_top openofdm_rx]

if {$rc == 0} {
  puts "==== Stage 1A overall: PASS ===="
} else {
  puts "==== Stage 1A overall: FAIL ===="
}
