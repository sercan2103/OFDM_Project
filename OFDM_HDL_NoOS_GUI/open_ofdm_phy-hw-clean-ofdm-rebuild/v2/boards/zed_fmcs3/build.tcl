## Stage 1C batch build script.
##
## openofdm_tx -> openofdm_rx HDL loopback (no AXI, no RF). Decode
## status surfaces on gpio_i for SW to read.
##
## Project tree: ./stage1c/
## Outputs:
##   ./stage1c/stage1c.runs/impl_1/system_top.bit
##   ./stage1c/stage1c.xsa
##
## Re-running deletes the project tree -- safe to invoke repeatedly.

set proj_name "stage1c"
set proj_dir  "./stage1c"
set part      "xc7z020clg484-1"
set ip_root   [file normalize ../../ip]

file delete -force $proj_dir
file mkdir $proj_dir

create_project $proj_name $proj_dir -part $part

## ---- IP repository -------------------------------------------------
## Point Vivado at adi-hdl/library/ so axi_ad9361, axi_clkgen, util_pack
## etc. can be found from system_bd.tcl. build_adi_lib.tcl must have
## been run once to package the IPs (component.xml).
set adi_lib [file normalize ../../../adi-hdl/library]
set_property ip_repo_paths $adi_lib [current_project]
update_ip_catalog

## ---- Block design ---------------------------------------------------
source system_bd.tcl

## ---- HDL sources ---------------------------------------------------
add_files -norecurse system_top.v
add_files -norecurse tx_packet_rom_mcs.v
add_files -norecurse tx_packet_rom_ht_mcs.v
add_files -norecurse iq_sample_fifo.v
add_files -norecurse awgn_noise_gen.v
add_files -norecurse [glob $ip_root/openofdm_tx/*.v]
add_files -norecurse [glob $ip_root/openofdm_tx/*.mem]
add_files -norecurse [glob $ip_root/openofdm_rx/*.v]
add_files -norecurse [glob $ip_root/openofdm_rx/usrp2/*.v]
add_files -norecurse [glob $ip_root/common/*.v]

# Xilinx IP cores referenced by openofdm_rx.
foreach xci [glob $ip_root/xilinx_ip/*/*.xci] {
  add_files -norecurse $xci
}

# Mark macro-only files as Verilog Headers.
foreach hdr {openofdm_rx_git_rev.v openofdm_rx_pre_def.v common_params.v} {
  set f [get_files -quiet $hdr]
  if {$f ne ""} {
    set_property file_type "Verilog Header" $f
  }
}

set_property include_dirs [list \
  $ip_root/common \
  $ip_root/openofdm_tx \
  $ip_root/openofdm_rx \
] [get_filesets sources_1]

## ---- Constraints ---------------------------------------------------
add_files -fileset constrs_1 -norecurse system_constr.xdc

set_property top system_top [current_fileset]
update_compile_order -fileset sources_1

## ---- Synth (skip BD sim wrapper -- Vivado 2022.2 Win bug) ----------
generate_target synthesis [get_files system.bd]

launch_runs synth_1 -jobs 12
wait_on_run synth_1

## ---- Insert ILA after synth ----------------------------------------
##   probe0 = tx_result_i               (16)
##   probe1 = tx_result_q               (16)
##   probe2 = tx_result_iq_valid        (1)
##   probe3 = phy_tx_started            (1)
##   probe4 = phy_tx_done               (1)
##   probe5 = rx_byte_out               (8)
##   probe6 = rx_byte_out_strobe        (1)
##   probe7 = rx_fcs_out_strobe         (1)
##   probe8 = rx_fcs_ok                 (1)
##   probe9 = rx_pkt_header_valid_strobe(1)
## clk = bb_clk
##
## NOTE: do NOT call save_constraints -- it appends connect_debug_port
## lines to system_constr.xdc on every run, which accumulates over time.
## Debug cores are persisted in the synth_1 checkpoint and impl_1 picks
## them up automatically.
open_run synth_1 -name synth_1
create_debug_core u_ila ila
set_property C_DATA_DEPTH        4096  [get_debug_cores u_ila]
set_property C_TRIGIN_EN         false [get_debug_cores u_ila]
set_property C_ADV_TRIGGER       true  [get_debug_cores u_ila]
set_property C_INPUT_PIPE_STAGES 0     [get_debug_cores u_ila]
set_property C_EN_STRG_QUAL      0     [get_debug_cores u_ila]
set_property ALL_PROBE_SAME_MU   true  [get_debug_cores u_ila]
set_property ALL_PROBE_SAME_MU_CNT 2   [get_debug_cores u_ila]

set_property port_width 1 [get_debug_ports u_ila/clk]
connect_debug_port u_ila/clk [get_nets bb_clk]

# probe0 already exists by default; configure + connect.
set_property port_width 16 [get_debug_ports u_ila/probe0]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila/probe0]
connect_debug_port u_ila/probe0 [get_nets {tx_result_i[*]}]

proc add_probe {idx width net} {
  create_debug_port u_ila probe
  set_property port_width $width [get_debug_ports u_ila/probe$idx]
  set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila/probe$idx]
  connect_debug_port u_ila/probe$idx [get_nets $net]
}

add_probe 1 16 {tx_result_q[*]}
add_probe 2 1  {tx_result_iq_valid}
add_probe 3 1  {phy_tx_started}
add_probe 4 1  {phy_tx_done}
add_probe 5 8  {rx_byte_out[*]}
add_probe 6 1  {rx_byte_out_strobe}
add_probe 7 1  {rx_fcs_out_strobe}
add_probe 8 1  {rx_fcs_ok}
add_probe 9 1  {rx_pkt_header_valid_strobe}

## ---- Implementation + bitstream ------------------------------------
launch_runs impl_1 -to_step write_bitstream -jobs 12
wait_on_run impl_1

write_hw_platform -fixed -include_bit -force \
  -file $proj_dir/${proj_name}.xsa

puts "==== Stage 1C build complete ===="
puts "Bitstream: $proj_dir/${proj_name}.runs/impl_1/system_top.bit"
puts "XSA:       $proj_dir/${proj_name}.xsa"
puts "ILA debug: probe via Vivado HW Manager after programming."
