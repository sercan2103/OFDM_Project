# Package the ADI HDL library IP that v2 actually uses.
#
# v2/boards/zed_fmcs3/system_bd.tcl instantiates exactly one ADI IP:
#   - axi_ad9361
#
# axi_ad9361's own packaging script (axi_ad9361_ip.tcl in adi-hdl)
# bundles all of its internal dependencies (ad_dds, up_axi, ad_data_*,
# etc.) into the same IP -- no separate util_* IPs are needed.
#
# Run once per repo / Vivado version:
#   vivado -mode batch -source build_adi_lib.tcl
#
# Pre-req: adi-hdl/ cloned next to this repo (see README).

set lib [file normalize [file join [file dirname [info script]] adi-hdl library]]
if {![file isdirectory $lib]} {
    puts "ERROR: ADI HDL library not found at $lib"
    puts "       Clone https://github.com/analogdevicesinc/hdl.git into adi-hdl/"
    exit 1
}

set ip axi_ad9361
puts "==== Packaging $ip ===="
cd $lib/$ip
if {[catch {source ${ip}_ip.tcl} err]} {
    puts "  ERROR: $err"
    exit 1
}
close_project -quiet
puts "==== Done ===="
exit
