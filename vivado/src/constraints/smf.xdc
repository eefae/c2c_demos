set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

create_clock -period 6.400 -name aurora_refclk_clk_p -waveform {0.000 3.200} [get_ports aurora_refclk_clk_p]
set_property PACKAGE_PIN R8 [get_ports aurora_refclk_clk_p]

create_clock -period 8.000 -name sysclk_clk_p -waveform {0.000 4.000} [get_ports sysclk_clk_p]
set_property PACKAGE_PIN E17 [get_ports {sysclk_clk_p[0]}]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports {sysclk_clk_p[0]}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {smf_c2c_master_i/sysclk/util_ds_buf_0/U0/USE_IBUFDS.GEN_IBUFDS[0].IBUFDS_I/O}]

set_property PACKAGE_PIN H16 [get_ports {led_out[0]}]
set_property PACKAGE_PIN J16 [get_ports {led_out[1]}]
set_property PACKAGE_PIN J14 [get_ports {led_out[2]}]
set_property PACKAGE_PIN J15 [get_ports {led_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[3]}]


set_false_path -from [get_pins smf_c2c_master_i/c2c/aurora_master/inst/smf_c2c_master_aurora_master_0_core_i/global_logic_i/channel_init_sm_i/CHANNEL_UP_RX_IF_reg/C] -to [get_pins {smf_c2c_master_i/vio_0/inst/PROBE_IN_INST/probe_in_reg_reg[3]/D}]
set_false_path -from [get_pins smf_c2c_master_i/c2c/aurora_master/inst/smf_c2c_master_aurora_master_0_core_i/aurora_lane_1_i/lane_init_sm_i/lane_up_flop_i/C] -to [get_pins {smf_c2c_master_i/vio_0/inst/PROBE_IN_INST/probe_in_reg_reg[1]/D}]
set_false_path -from [get_pins smf_c2c_master_i/c2c/aurora_master/inst/smf_c2c_master_aurora_master_0_core_i/aurora_lane_0_i/lane_init_sm_i/lane_up_flop_i/C] -to [get_pins {smf_c2c_master_i/vio_0/inst/PROBE_IN_INST/probe_in_reg_reg[2]/D}]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]

