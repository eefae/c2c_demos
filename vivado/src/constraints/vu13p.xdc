set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

create_clock -period 6.400 -name aurora_refclk_clk_p -waveform {0.000 3.200} [get_ports aurora_refclk_clk_p]
set_property PACKAGE_PIN AY38 [get_ports aurora_refclk_clk_p]

create_clock -period 10.000 -name sysclk_clk_p -waveform {0.000 5.000} [get_ports sysclk_clk_p]
set_property PACKAGE_PIN K18 [get_ports sysclk_clk_p]
set_property IOSTANDARD LVDS [get_ports sysclk_clk_p]


# AURORA SLAVE LANE0
set_property PACKAGE_PIN AW40 [get_ports {aurora_tx_slave_txp[0]}]

# AURORA SLAVE LANE1
set_property PACKAGE_PIN BB42 [get_ports {aurora_tx_slave_txp[1]}]


set_false_path -from [get_pins top_i/c2c/aurora_64b66b_0/inst/top_aurora_64b66b_0_2_core_i/global_logic_i/channel_init_sm_i/CHANNEL_UP_RX_IF_reg/C] -to [get_pins {top_i/vio_0/inst/PROBE_IN_INST/probe_in_reg_reg[3]/D}]
set_false_path -from [get_pins top_i/c2c/aurora_64b66b_0/inst/top_aurora_64b66b_0_2_core_i/aurora_lane_0_i/lane_init_sm_i/lane_up_flop_i/C] -to [get_pins {top_i/vio_0/inst/PROBE_IN_INST/probe_in_reg_reg[2]/D}]
set_false_path -from [get_pins top_i/c2c/aurora_64b66b_0/inst/top_aurora_64b66b_0_2_core_i/aurora_lane_1_i/lane_init_sm_i/lane_up_flop_i/C] -to [get_pins {top_i/vio_0/inst/PROBE_IN_INST/probe_in_reg_reg[1]/D}]
set_false_path -from [get_pins top_i/c2c/aurora_64b66b_0/inst/top_aurora_64b66b_0_2_core_i/top_aurora_64b66b_0_2_wrapper_i/u_cdc_tx_fsm_resetdone_i/s_level_out_d5_reg/C] -to [get_pins {top_i/vio_0/inst/PROBE_IN_INST/probe_in_reg_reg[0]/D}]
set_false_path -from [get_pins {top_i/vio_0/inst/PROBE_OUT_ALL_INST/G_PROBE_OUT[1].PROBE_OUT0_INST/Probe_out_reg[0]/C}] -to [get_pins {top_i/c2c/axi_chip2chip_0/inst/slave_fpga_gen.axi_chip2chip_slave_phy_inst/aurora_phy.standard_cc_module_inst/pma_init_stage_reg[0]/D}]
set_false_path -from [get_pins top_i/c2c/aurora_64b66b_0/inst/top_aurora_64b66b_0_2_core_i/top_aurora_64b66b_0_2_wrapper_i/u_cdc_gt_cplllock_i/s_level_out_d5_reg/C] -to [get_pins {top_i/vio_0/inst/PROBE_IN_INST/probe_in_reg_reg[0]/D}]


##=====================  DDR PIN CONSTRAINTS  ======================
##==================================================================
#set_property PACKAGE_PIN J14 [get_ports c0_sys_clk_clk_p]
#set_property PACKAGE_PIN H14 [get_ports c0_sys_clk_clk_n]

#set_property IOSTANDARD DIFF_SSTL12 [get_ports c0_sys_clk_clk_p]
#set_property IOSTANDARD DIFF_SSTL12 [get_ports c0_sys_clk_clk_n]
##==================================================================


#set_property PACKAGE_PIN L13 [get_ports {C0_DDR4_adr[0]}]
#set_property PACKAGE_PIN K13 [get_ports {C0_DDR4_adr[1]}]
#set_property PACKAGE_PIN K16 [get_ports {C0_DDR4_adr[2]}]
#set_property PACKAGE_PIN K15 [get_ports {C0_DDR4_adr[3]}]
#set_property PACKAGE_PIN J13 [get_ports {C0_DDR4_adr[4]}]
#set_property PACKAGE_PIN H13 [get_ports {C0_DDR4_adr[5]}]
#set_property PACKAGE_PIN J16 [get_ports {C0_DDR4_adr[6]}]
#set_property PACKAGE_PIN J15 [get_ports {C0_DDR4_adr[7]}]
#set_property PACKAGE_PIN L15 [get_ports {C0_DDR4_adr[8]}]
#set_property PACKAGE_PIN G14 [get_ports {C0_DDR4_adr[9]}]
#set_property PACKAGE_PIN F14 [get_ports {C0_DDR4_adr[10]}]
#set_property PACKAGE_PIN G15 [get_ports {C0_DDR4_adr[11]}]
#set_property PACKAGE_PIN F15 [get_ports {C0_DDR4_adr[12]}]
#set_property PACKAGE_PIN F13 [get_ports {C0_DDR4_adr[13]}]
#set_property PACKAGE_PIN E13 [get_ports {C0_DDR4_adr[14]}]
#set_property PACKAGE_PIN G17 [get_ports {C0_DDR4_adr[15]}]
#set_property PACKAGE_PIN G16 [get_ports {C0_DDR4_adr[16]}]
#set_property PACKAGE_PIN E15 [get_ports {C0_DDR4_ba[0]}]
#set_property PACKAGE_PIN D15 [get_ports {C0_DDR4_ba[1]}]
#set_property PACKAGE_PIN E16 [get_ports C0_DDR4_bg]
#set_property PACKAGE_PIN H17 [get_ports C0_DDR4_ck_t]
#set_property PACKAGE_PIN H16 [get_ports C0_DDR4_ck_c]
#set_property PACKAGE_PIN D14 [get_ports C0_DDR4_cke]
#set_property PACKAGE_PIN C13 [get_ports C0_DDR4_act_n]
#set_property PACKAGE_PIN C17 [get_ports C0_DDR4_reset_n]
#set_property PACKAGE_PIN N13 [get_ports C0_DDR4_odt]
#set_property PACKAGE_PIN D16 [get_ports C0_DDR4_cs_n]

#set_property PACKAGE_PIN M16 [get_ports {C0_DDR4_dq[0]}]
#set_property PACKAGE_PIN N14 [get_ports {C0_DDR4_dq[1]}]
#set_property PACKAGE_PIN M14 [get_ports {C0_DDR4_dq[2]}]
#set_property PACKAGE_PIN P14 [get_ports {C0_DDR4_dq[3]}]
#set_property PACKAGE_PIN N16 [get_ports {C0_DDR4_dq[4]}]
#set_property PACKAGE_PIN P15 [get_ports {C0_DDR4_dq[5]}]
#set_property PACKAGE_PIN L14 [get_ports {C0_DDR4_dq[6]}]
#set_property PACKAGE_PIN R15 [get_ports {C0_DDR4_dq[7]}]
#set_property PACKAGE_PIN B17 [get_ports {C0_DDR4_dq[8]}]
#set_property PACKAGE_PIN A14 [get_ports {C0_DDR4_dq[9]}]
#set_property PACKAGE_PIN A17 [get_ports {C0_DDR4_dq[10]}]
#set_property PACKAGE_PIN C14 [get_ports {C0_DDR4_dq[11]}]
#set_property PACKAGE_PIN C16 [get_ports {C0_DDR4_dq[12]}]
#set_property PACKAGE_PIN B14 [get_ports {C0_DDR4_dq[13]}]
#set_property PACKAGE_PIN B16 [get_ports {C0_DDR4_dq[14]}]
#set_property PACKAGE_PIN A13 [get_ports {C0_DDR4_dq[15]}]
#set_property PACKAGE_PIN R16 [get_ports {C0_DDR4_dqs_t[0]}]
#set_property PACKAGE_PIN P16 [get_ports {C0_DDR4_dqs_c[0]}]
#set_property PACKAGE_PIN B15 [get_ports {C0_DDR4_dqs_t[1]}]
#set_property PACKAGE_PIN A15 [get_ports {C0_DDR4_dqs_c[1]}]
#set_property PACKAGE_PIN P13 [get_ports {C0_DDR4_dm_n[0]}]
#set_property PACKAGE_PIN D13 [get_ports {C0_DDR4_dm_n[1]}]


set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]

