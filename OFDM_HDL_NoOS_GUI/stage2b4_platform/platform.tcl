# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/kemal/Desktop/OFDMPROJECTCURRENT/stage2b4_platform/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/kemal/Desktop/OFDMPROJECTCURRENT/stage2b4_platform/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {stage2b4_platform}\
-hw {/home/kemal/Desktop/OFDMPROJECTCURRENT/open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3/stage1c/stage1c.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -no-boot-bsp -out {/home/kemal/Desktop/OFDMPROJECTCURRENT}

platform write
platform generate -domains 
platform active {stage2b4_platform}
platform generate
platform clean
platform generate
platform active {stage2b4_platform}
platform config -updatehw {/home/kemal/Desktop/OFDMPROJECTCURRENT/open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3/stage1c/stage1c.xsa}
platform clean
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform active {stage2b4_platform}
platform config -updatehw {/home/kemal/Desktop/OFDMPROJECTCURRENT/open_ofdm_phy-hw-clean-ofdm-rebuild/v2/boards/zed_fmcs3/stage1c/stage1c.xsa}
platform generate -domains 
platform clean
platform generate -domains standalone_domain 
