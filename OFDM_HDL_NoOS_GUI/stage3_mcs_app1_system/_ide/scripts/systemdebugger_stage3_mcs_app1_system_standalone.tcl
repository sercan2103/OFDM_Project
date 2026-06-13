# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/kemal/Desktop/OFDMPROJECTCURRENT/stage3_mcs_app1_system/_ide/scripts/systemdebugger_stage3_mcs_app1_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/kemal/Desktop/OFDMPROJECTCURRENT/stage3_mcs_app1_system/_ide/scripts/systemdebugger_stage3_mcs_app1_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zed 210248A2760C" && level==0 && jtag_device_ctx=="jsn-Zed-210248A2760C-23727093-0"}
fpga -file /home/kemal/Desktop/OFDMPROJECTCURRENT/stage3_mcs_app1/_ide/bitstream/stage1c.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/kemal/Desktop/OFDMPROJECTCURRENT/stage3_mcs_platform/export/stage3_mcs_platform/hw/stage1c.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /home/kemal/Desktop/OFDMPROJECTCURRENT/stage3_mcs_app1/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /home/kemal/Desktop/OFDMPROJECTCURRENT/stage3_mcs_app1/Debug/stage3_mcs_app1.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
