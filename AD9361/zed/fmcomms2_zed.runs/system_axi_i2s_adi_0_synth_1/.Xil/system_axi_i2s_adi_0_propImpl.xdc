set_property SRC_FILE_INFO {cfile:/home/kemal/Desktop/FMCOMM2andos/hdl/projects/fmcomms2/zed/fmcomms2_zed.gen/sources_1/bd/system/ip/system_axi_i2s_adi_0/axi_i2s_adi_constr.xdc rfile:../../../fmcomms2_zed.gen/sources_1/bd/system/ip/system_axi_i2s_adi_0/axi_i2s_adi_constr.xdc id:1 order:LATE scoped_inst:U0} [current_design]
current_instance U0
set_property src_info {type:SCOPED_XDC file:1 line:13 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_clocks -of_objects [get_ports s_axi_aclk]] -to [get_cells -hier out_data_reg* -filter {IS_SEQUENTIAL && NAME =~ *tx_sync*}] [get_property PERIOD [get_clocks -of_objects [get_ports data_clk_i]]] -datapath_only
set_property src_info {type:SCOPED_XDC file:1 line:19 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_clocks -of_objects [get_ports data_clk_i]] -to [get_cells -hier out_data_reg* -filter {IS_SEQUENTIAL && NAME =~ *rx_sync*}] [get_property PERIOD [get_clocks -of_objects [get_ports s_axi_aclk]]] -datapath_only
