
################################################################
# This is a generated script based on design: smf_c2c_master
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source smf_c2c_master_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu4eg-fbvb900-2-e
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name smf

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:vio:3.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:zynq_ultra_ps_e:3.4\
xilinx.com:ip:aurora_64b66b:12.0\
xilinx.com:ip:axi_chip2chip:5.0\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:util_ds_buf:2.2\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: sysclk
proc create_hier_cell_sysclk { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_sysclk() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sysclk


  # Create pins
  create_bd_pin -dir O -type clk clk_75
  create_bd_pin -dir O -type clk clk_125

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [list \
    CONFIG.AUTO_PRIMITIVE {PLL} \
    CONFIG.CLKIN1_JITTER_PS {80.0} \
    CONFIG.CLKOUT1_DRIVES {Buffer} \
    CONFIG.CLKOUT1_JITTER {143.091} \
    CONFIG.CLKOUT1_PHASE_ERROR {112.379} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {75} \
    CONFIG.CLKOUT1_USED {true} \
    CONFIG.CLKOUT2_DRIVES {Buffer} \
    CONFIG.CLKOUT2_JITTER {128.871} \
    CONFIG.CLKOUT2_PHASE_ERROR {112.379} \
    CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {125} \
    CONFIG.CLKOUT2_USED {true} \
    CONFIG.CLKOUT3_DRIVES {Buffer} \
    CONFIG.CLKOUT4_DRIVES {Buffer} \
    CONFIG.CLKOUT5_DRIVES {Buffer} \
    CONFIG.CLKOUT6_DRIVES {Buffer} \
    CONFIG.CLKOUT7_DRIVES {Buffer} \
    CONFIG.CLK_OUT1_PORT {clk_75} \
    CONFIG.CLK_OUT2_PORT {clk_125} \
    CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
    CONFIG.MMCM_BANDWIDTH {OPTIMIZED} \
    CONFIG.MMCM_CLKFBOUT_MULT_F {6} \
    CONFIG.MMCM_CLKIN1_PERIOD {8.0} \
    CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
    CONFIG.MMCM_CLKOUT0_DIVIDE_F {10} \
    CONFIG.MMCM_CLKOUT1_DIVIDE {6} \
    CONFIG.MMCM_COMPENSATION {AUTO} \
    CONFIG.MMCM_DIVCLK_DIVIDE {1} \
    CONFIG.NUM_OUT_CLKS {2} \
    CONFIG.OPTIMIZE_CLOCKING_STRUCTURE_EN {true} \
    CONFIG.PRIMITIVE {Auto} \
    CONFIG.PRIM_IN_FREQ {125} \
    CONFIG.PRIM_SOURCE {Global_buffer} \
    CONFIG.USE_LOCKED {false} \
    CONFIG.USE_RESET {false} \
  ] $clk_wiz_0


  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_0 ]

  # Create instance: util_ds_buf_1, and set properties
  set util_ds_buf_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_1 ]
  set_property CONFIG.C_BUF_TYPE {BUFG} $util_ds_buf_1


  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_pins sysclk] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]

  # Create port connections
  connect_bd_net -net clk_wiz_0_clk_200 [get_bd_pins clk_125] [get_bd_pins clk_wiz_0/clk_125]
  connect_bd_net -net init_clk_1 [get_bd_pins clk_75] [get_bd_pins clk_wiz_0/clk_75]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins util_ds_buf_0/IBUF_OUT] [get_bd_pins util_ds_buf_1/BUFG_I]
  connect_bd_net -net util_ds_buf_1_BUFG_O [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins util_ds_buf_1/BUFG_O]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: c2c
proc create_hier_cell_c2c { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_c2c() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 aurora_refclk

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 aurora_rx_master

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 aurora_tx_master

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi


  # Create pins
  create_bd_pin -dir I -type rst aurora_pma_init_in
  create_bd_pin -dir O axi_c2c_link_status_out
  create_bd_pin -dir O channel_up
  create_bd_pin -dir O -from 4 -to 0 dout1
  create_bd_pin -dir O gt_pll_lock
  create_bd_pin -dir I -type clk init_clk
  create_bd_pin -dir O -from 0 -to 0 lane0
  create_bd_pin -dir O -from 0 -to 0 lane1
  create_bd_pin -dir I -type clk s_aclk
  create_bd_pin -dir I -type rst s_aresetn

  # Create instance: aurora_master, and set properties
  set aurora_master [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_64b66b:12.0 aurora_master ]
  set_property -dict [list \
    CONFIG.C_AURORA_LANES {2} \
    CONFIG.C_INIT_CLK {75} \
    CONFIG.C_LINE_RATE {6.25} \
    CONFIG.C_REFCLK_FREQUENCY {156.25} \
    CONFIG.C_USE_BYTESWAP {true} \
    CONFIG.SupportLevel {1} \
    CONFIG.drp_mode {Disabled} \
    CONFIG.interface_mode {Streaming} \
  ] $aurora_master


  # Create instance: c2c_master, and set properties
  set c2c_master [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_chip2chip:5.0 c2c_master ]
  set_property -dict [list \
    CONFIG.C_AXI_ADDR_WIDTH {40} \
    CONFIG.C_AXI_DATA_WIDTH {64} \
    CONFIG.C_INCLUDE_AXILITE {0} \
    CONFIG.C_INTERFACE_MODE {0} \
    CONFIG.C_INTERFACE_TYPE {2} \
    CONFIG.C_SUPPORT_NARROWBURST {true} \
  ] $c2c_master


  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property CONFIG.NUM_PORTS {5} $xlconcat_0


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property CONFIG.DIN_WIDTH {2} $xlslice_0


  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {1} \
    CONFIG.DIN_TO {1} \
    CONFIG.DIN_WIDTH {2} \
  ] $xlslice_1


  # Create interface connections
  connect_bd_intf_net -intf_net GT_DIFF_REFCLK1_0_1 [get_bd_intf_pins aurora_refclk] [get_bd_intf_pins aurora_master/GT_DIFF_REFCLK1]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_0_1 [get_bd_intf_pins aurora_rx_master] [get_bd_intf_pins aurora_master/GT_SERIAL_RX]
  connect_bd_intf_net -intf_net aurora_master_GT_SERIAL_TX [get_bd_intf_pins aurora_tx_master] [get_bd_intf_pins aurora_master/GT_SERIAL_TX]
  connect_bd_intf_net -intf_net aurora_master_USER_DATA_M_AXIS_RX [get_bd_intf_pins aurora_master/USER_DATA_M_AXIS_RX] [get_bd_intf_pins c2c_master/AXIS_RX]
  connect_bd_intf_net -intf_net c2c_master_AXIS_TX [get_bd_intf_pins aurora_master/USER_DATA_S_AXIS_TX] [get_bd_intf_pins c2c_master/AXIS_TX]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins s_axi] [get_bd_intf_pins c2c_master/s_axi]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins aurora_master/lane_up] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net aurora_master_gt_pll_lock [get_bd_pins gt_pll_lock] [get_bd_pins aurora_master/gt_pll_lock] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net aurora_master_mmcm_not_locked_out [get_bd_pins aurora_master/mmcm_not_locked_out] [get_bd_pins c2c_master/aurora_mmcm_not_locked]
  connect_bd_net -net aurora_master_user_clk_out [get_bd_pins aurora_master/user_clk_out] [get_bd_pins c2c_master/axi_c2c_phy_clk]
  connect_bd_net -net c2c_block_axi_c2c_aurora_channel_up [get_bd_pins channel_up] [get_bd_pins aurora_master/channel_up] [get_bd_pins c2c_master/axi_c2c_aurora_channel_up] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net c2c_master_aurora_pma_init_out [get_bd_pins aurora_master/pma_init] [get_bd_pins c2c_master/aurora_pma_init_out]
  connect_bd_net -net c2c_master_aurora_reset_pb [get_bd_pins aurora_master/reset_pb] [get_bd_pins c2c_master/aurora_reset_pb]
  connect_bd_net -net c2c_master_axi_c2c_link_status_out [get_bd_pins axi_c2c_link_status_out] [get_bd_pins c2c_master/axi_c2c_link_status_out] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net clk_wiz_0_clk_200 [get_bd_pins s_aclk] [get_bd_pins c2c_master/s_aclk]
  connect_bd_net -net init_clk_1 [get_bd_pins init_clk] [get_bd_pins aurora_master/init_clk] [get_bd_pins c2c_master/aurora_init_clk]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins s_aresetn] [get_bd_pins c2c_master/s_aresetn]
  connect_bd_net -net vio_0_probe_out1 [get_bd_pins aurora_pma_init_in] [get_bd_pins c2c_master/aurora_pma_init_in]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins dout1] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins lane1] [get_bd_pins xlconcat_0/In1] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins lane0] [get_bd_pins xlconcat_0/In2] [get_bd_pins xlslice_1/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set aurora_refclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 aurora_refclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $aurora_refclk

  set aurora_rx_master [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 aurora_rx_master ]

  set aurora_tx_master [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 aurora_tx_master ]

  set sysclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sysclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {125000000} \
   ] $sysclk


  # Create ports
  set led_out [ create_bd_port -dir O -from 3 -to 0 led_out ]

  # Create instance: c2c
  create_hier_cell_c2c [current_bd_instance .] c2c

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property CONFIG.NUM_SI {1} $smartconnect_0


  # Create instance: sysclk
  create_hier_cell_sysclk [current_bd_instance .] sysclk

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {4} \
  ] $util_vector_logic_0


  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [list \
    CONFIG.C_NUM_PROBE_IN {5} \
    CONFIG.C_NUM_PROBE_OUT {2} \
    CONFIG.C_PROBE_OUT0_INIT_VAL {0x1} \
  ] $vio_0


  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property CONFIG.NUM_PORTS {4} $xlconcat_0


  # Create instance: zynq_ultra_ps_e_0, and set properties
  set zynq_ultra_ps_e_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.4 zynq_ultra_ps_e_0 ]
  set_property -dict [list \
    CONFIG.CAN0_BOARD_INTERFACE {custom} \
    CONFIG.CAN1_BOARD_INTERFACE {custom} \
    CONFIG.CSU_BOARD_INTERFACE {custom} \
    CONFIG.DP_BOARD_INTERFACE {custom} \
    CONFIG.GEM0_BOARD_INTERFACE {custom} \
    CONFIG.GEM1_BOARD_INTERFACE {custom} \
    CONFIG.GEM2_BOARD_INTERFACE {custom} \
    CONFIG.GEM3_BOARD_INTERFACE {custom} \
    CONFIG.GPIO_BOARD_INTERFACE {custom} \
    CONFIG.IIC0_BOARD_INTERFACE {custom} \
    CONFIG.IIC1_BOARD_INTERFACE {custom} \
    CONFIG.NAND_BOARD_INTERFACE {custom} \
    CONFIG.PCIE_BOARD_INTERFACE {custom} \
    CONFIG.PJTAG_BOARD_INTERFACE {custom} \
    CONFIG.PMU_BOARD_INTERFACE {custom} \
    CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS33} \
    CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
    CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
    CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
    CONFIG.PSU_IMPORT_BOARD_PRESET {} \
    CONFIG.PSU_MIO_0_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_0_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_0_POLARITY {Default} \
    CONFIG.PSU_MIO_0_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_0_SLEW {slow} \
    CONFIG.PSU_MIO_10_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_10_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_10_POLARITY {Default} \
    CONFIG.PSU_MIO_10_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_10_SLEW {slow} \
    CONFIG.PSU_MIO_11_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_11_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_11_POLARITY {Default} \
    CONFIG.PSU_MIO_11_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_11_SLEW {slow} \
    CONFIG.PSU_MIO_12_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_12_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_12_POLARITY {Default} \
    CONFIG.PSU_MIO_12_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_12_SLEW {slow} \
    CONFIG.PSU_MIO_13_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_13_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_13_POLARITY {Default} \
    CONFIG.PSU_MIO_13_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_13_SLEW {slow} \
    CONFIG.PSU_MIO_14_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_14_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_14_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_14_SLEW {slow} \
    CONFIG.PSU_MIO_15_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_15_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_15_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_15_SLEW {slow} \
    CONFIG.PSU_MIO_16_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_16_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_16_POLARITY {Default} \
    CONFIG.PSU_MIO_16_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_16_SLEW {slow} \
    CONFIG.PSU_MIO_17_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_17_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_17_POLARITY {Default} \
    CONFIG.PSU_MIO_17_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_17_SLEW {slow} \
    CONFIG.PSU_MIO_18_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_18_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_18_POLARITY {Default} \
    CONFIG.PSU_MIO_18_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_18_SLEW {slow} \
    CONFIG.PSU_MIO_19_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_19_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_19_POLARITY {Default} \
    CONFIG.PSU_MIO_19_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_19_SLEW {slow} \
    CONFIG.PSU_MIO_1_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_1_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_1_POLARITY {Default} \
    CONFIG.PSU_MIO_1_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_1_SLEW {slow} \
    CONFIG.PSU_MIO_20_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_20_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_20_POLARITY {Default} \
    CONFIG.PSU_MIO_20_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_20_SLEW {slow} \
    CONFIG.PSU_MIO_21_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_21_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_21_POLARITY {Default} \
    CONFIG.PSU_MIO_21_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_21_SLEW {slow} \
    CONFIG.PSU_MIO_22_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_22_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_22_POLARITY {Default} \
    CONFIG.PSU_MIO_22_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_22_SLEW {slow} \
    CONFIG.PSU_MIO_23_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_23_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_23_POLARITY {Default} \
    CONFIG.PSU_MIO_23_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_23_SLEW {slow} \
    CONFIG.PSU_MIO_24_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_24_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_24_POLARITY {Default} \
    CONFIG.PSU_MIO_24_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_24_SLEW {slow} \
    CONFIG.PSU_MIO_25_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_25_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_25_POLARITY {Default} \
    CONFIG.PSU_MIO_25_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_25_SLEW {slow} \
    CONFIG.PSU_MIO_26_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_26_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_26_POLARITY {Default} \
    CONFIG.PSU_MIO_26_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_26_SLEW {slow} \
    CONFIG.PSU_MIO_27_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_27_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_27_SLEW {slow} \
    CONFIG.PSU_MIO_28_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_28_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_29_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_29_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_29_SLEW {slow} \
    CONFIG.PSU_MIO_2_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_2_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_2_POLARITY {Default} \
    CONFIG.PSU_MIO_2_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_2_SLEW {slow} \
    CONFIG.PSU_MIO_30_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_30_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_31_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_31_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_31_POLARITY {Default} \
    CONFIG.PSU_MIO_31_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_31_SLEW {slow} \
    CONFIG.PSU_MIO_32_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_32_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_32_POLARITY {Default} \
    CONFIG.PSU_MIO_32_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_32_SLEW {slow} \
    CONFIG.PSU_MIO_33_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_33_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_33_POLARITY {Default} \
    CONFIG.PSU_MIO_33_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_33_SLEW {slow} \
    CONFIG.PSU_MIO_34_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_34_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_35_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_35_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_35_SLEW {slow} \
    CONFIG.PSU_MIO_36_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_36_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_36_POLARITY {Default} \
    CONFIG.PSU_MIO_36_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_36_SLEW {slow} \
    CONFIG.PSU_MIO_37_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_37_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_37_POLARITY {Default} \
    CONFIG.PSU_MIO_37_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_37_SLEW {slow} \
    CONFIG.PSU_MIO_38_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_38_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_38_POLARITY {Default} \
    CONFIG.PSU_MIO_38_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_38_SLEW {slow} \
    CONFIG.PSU_MIO_39_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_39_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_39_POLARITY {Default} \
    CONFIG.PSU_MIO_39_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_39_SLEW {slow} \
    CONFIG.PSU_MIO_3_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_3_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_3_POLARITY {Default} \
    CONFIG.PSU_MIO_3_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_3_SLEW {slow} \
    CONFIG.PSU_MIO_40_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_40_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_40_POLARITY {Default} \
    CONFIG.PSU_MIO_40_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_40_SLEW {slow} \
    CONFIG.PSU_MIO_41_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_41_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_41_POLARITY {Default} \
    CONFIG.PSU_MIO_41_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_41_SLEW {slow} \
    CONFIG.PSU_MIO_42_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_42_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_42_POLARITY {Default} \
    CONFIG.PSU_MIO_42_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_42_SLEW {slow} \
    CONFIG.PSU_MIO_43_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_43_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_43_SLEW {slow} \
    CONFIG.PSU_MIO_44_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_44_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_45_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_45_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_46_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_46_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_46_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_46_SLEW {slow} \
    CONFIG.PSU_MIO_47_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_47_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_47_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_47_SLEW {slow} \
    CONFIG.PSU_MIO_48_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_48_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_48_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_48_SLEW {slow} \
    CONFIG.PSU_MIO_49_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_49_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_49_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_49_SLEW {slow} \
    CONFIG.PSU_MIO_4_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_4_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_4_POLARITY {Default} \
    CONFIG.PSU_MIO_4_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_4_SLEW {slow} \
    CONFIG.PSU_MIO_50_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_50_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_50_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_50_SLEW {slow} \
    CONFIG.PSU_MIO_51_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_51_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_51_SLEW {slow} \
    CONFIG.PSU_MIO_52_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_52_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_53_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_53_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_54_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_54_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_54_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_54_SLEW {slow} \
    CONFIG.PSU_MIO_55_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_55_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_56_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_56_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_56_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_56_SLEW {slow} \
    CONFIG.PSU_MIO_57_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_57_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_57_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_57_SLEW {slow} \
    CONFIG.PSU_MIO_58_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_58_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_58_SLEW {slow} \
    CONFIG.PSU_MIO_59_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_59_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_59_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_59_SLEW {slow} \
    CONFIG.PSU_MIO_5_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_5_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_5_POLARITY {Default} \
    CONFIG.PSU_MIO_5_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_5_SLEW {slow} \
    CONFIG.PSU_MIO_60_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_60_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_60_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_60_SLEW {slow} \
    CONFIG.PSU_MIO_61_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_61_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_61_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_61_SLEW {slow} \
    CONFIG.PSU_MIO_62_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_62_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_62_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_62_SLEW {slow} \
    CONFIG.PSU_MIO_63_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_63_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_63_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_63_SLEW {slow} \
    CONFIG.PSU_MIO_64_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_64_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_64_SLEW {slow} \
    CONFIG.PSU_MIO_65_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_65_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_65_SLEW {slow} \
    CONFIG.PSU_MIO_66_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_66_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_66_SLEW {slow} \
    CONFIG.PSU_MIO_67_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_67_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_67_SLEW {slow} \
    CONFIG.PSU_MIO_68_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_68_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_68_SLEW {slow} \
    CONFIG.PSU_MIO_69_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_69_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_69_SLEW {slow} \
    CONFIG.PSU_MIO_6_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_6_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_6_POLARITY {Default} \
    CONFIG.PSU_MIO_6_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_6_SLEW {slow} \
    CONFIG.PSU_MIO_70_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_70_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_71_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_71_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_72_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_72_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_73_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_73_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_74_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_74_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_75_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_75_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_76_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_76_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_76_SLEW {slow} \
    CONFIG.PSU_MIO_77_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_77_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_77_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_77_SLEW {slow} \
    CONFIG.PSU_MIO_7_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_7_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_7_POLARITY {Default} \
    CONFIG.PSU_MIO_7_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_7_SLEW {slow} \
    CONFIG.PSU_MIO_8_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_8_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_8_POLARITY {Default} \
    CONFIG.PSU_MIO_8_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_8_SLEW {slow} \
    CONFIG.PSU_MIO_9_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_9_INPUT_TYPE {schmitt} \
    CONFIG.PSU_MIO_9_POLARITY {Default} \
    CONFIG.PSU_MIO_9_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_9_SLEW {slow} \
    CONFIG.PSU_MIO_TREE_PERIPHERALS {GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#I2C 0#I2C 0#GPIO0 MIO#GPIO0\
MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO1 MIO#DPAUX#DPAUX#DPAUX#DPAUX#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#UART 0#UART 0#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1\
MIO#GPIO1 MIO#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem\
3#Gem 3#MDIO 3#MDIO 3} \
    CONFIG.PSU_MIO_TREE_SIGNALS {gpio0[0]#gpio0[1]#gpio0[2]#gpio0[3]#gpio0[4]#gpio0[5]#gpio0[6]#gpio0[7]#gpio0[8]#gpio0[9]#gpio0[10]#gpio0[11]#gpio0[12]#gpio0[13]#scl_out#sda_out#gpio0[16]#gpio0[17]#gpio0[18]#gpio0[19]#gpio0[20]#gpio0[21]#gpio0[22]#gpio0[23]#gpio0[24]#gpio0[25]#gpio1[26]#dp_aux_data_out#dp_hot_plug_detect#dp_aux_data_oe#dp_aux_data_in#gpio1[31]#gpio1[32]#gpio1[33]#rxd#txd#gpio1[36]#gpio1[37]#gpio1[38]#gpio1[39]#gpio1[40]#gpio1[41]#gpio1[42]#sdio1_bus_pow#sdio1_wp#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out#ulpi_clk_in#ulpi_dir#ulpi_tx_data[2]#ulpi_nxt#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_stp#ulpi_tx_data[3]#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#gem3_mdc#gem3_mdio_out}\
\
    CONFIG.PSU_PERIPHERAL_BOARD_PRESET {} \
    CONFIG.PSU_SD0_INTERNAL_BUS_WIDTH {8} \
    CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {4} \
    CONFIG.PSU_SMC_CYCLE_T0 {NA} \
    CONFIG.PSU_SMC_CYCLE_T1 {NA} \
    CONFIG.PSU_SMC_CYCLE_T2 {NA} \
    CONFIG.PSU_SMC_CYCLE_T3 {NA} \
    CONFIG.PSU_SMC_CYCLE_T4 {NA} \
    CONFIG.PSU_SMC_CYCLE_T5 {NA} \
    CONFIG.PSU_SMC_CYCLE_T6 {NA} \
    CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {1} \
    CONFIG.PSU_VALUE_SILVERSION {3} \
    CONFIG.PSU__ACPU0__POWER__ON {1} \
    CONFIG.PSU__ACPU1__POWER__ON {1} \
    CONFIG.PSU__ACPU2__POWER__ON {1} \
    CONFIG.PSU__ACPU3__POWER__ON {1} \
    CONFIG.PSU__ACTUAL__IP {1} \
    CONFIG.PSU__ACT_DDR_FREQ_MHZ {1050.000000} \
    CONFIG.PSU__AUX_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__CAN0_LOOP_CAN1__ENABLE {0} \
    CONFIG.PSU__CAN0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1200.000000} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1200} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__ACPU__FRAC_ENABLED {0} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI0_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI1_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI2_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI3_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI4_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI5_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__APLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRF_APB__APM_CTRL__ACT_FREQMHZ {1} \
    CONFIG.PSU__CRF_APB__APM_CTRL__DIVISOR0 {1} \
    CONFIG.PSU__CRF_APB__APM_CTRL__FREQMHZ {1} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {250.000000} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {250.000000} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {525.000000} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1067} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {600.000000} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {25.000000} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__FREQMHZ {25} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRF_APB__DP_AUDIO__FRAC_ENABLED {0} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {26.666666} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__FREQMHZ {27} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {300.000000} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__FREQMHZ {300} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
    CONFIG.PSU__CRF_APB__DP_VIDEO__FRAC_ENABLED {0} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {600.000000} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__ACT_FREQMHZ {500.000000} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__ACT_FREQMHZ {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__DIVISOR0 {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__FREQMHZ {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__SRCSEL {NA} \
    CONFIG.PSU__CRF_APB__GTGREF0__ENABLE {NA} \
    CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__SATA_REF_CTRL__ACT_FREQMHZ {250.000005} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {525.000000} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {533.33} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {500.000000} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__AFI6__ENABLE {0} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {50.000000} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__FREQMHZ {50} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__ACT_FREQMHZ {100.000002} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {500.000000} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__ACT_FREQMHZ {180} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__DIVISOR0 {3} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__SRCSEL {SysOsc} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {250.000000} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__ACT_FREQMHZ {1000} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__DIVISOR0 {6} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__FREQMHZ {1000} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1500.000000} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__FREQMHZ {1500} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {125.000000} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {250.000000} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {250.000000} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {500.000000} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__DIVISOR0 {3} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.500000} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__ACT_FREQMHZ {50.000000} \
    CONFIG.PSU__CRL_APB__PL2_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__PL3_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {125.000000} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__ACT_FREQMHZ {200.000000} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {187.500000} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__ACT_FREQMHZ {214} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__ACT_FREQMHZ {214} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {250.000000} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {20.000000} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB3__ENABLE {1} \
    CONFIG.PSU__CSUPMU__PERIPHERAL__VALID {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_0__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_10__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_11__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_12__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_1__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_2__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_3__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_4__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_5__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_6__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_7__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_8__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_9__ENABLE {0} \
    CONFIG.PSU__CSU__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__DDRC__AL {0} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
    CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
    CONFIG.PSU__DDRC__CL {16} \
    CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \
    CONFIG.PSU__DDRC__COMPONENTS {Components} \
    CONFIG.PSU__DDRC__CWL {14} \
    CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \
    CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
    CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
    CONFIG.PSU__DDRC__DDR4_MAXPWR_SAVING_EN {0} \
    CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
    CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
    CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
    CONFIG.PSU__DDRC__ECC {Disabled} \
    CONFIG.PSU__DDRC__ECC_SCRUB {0} \
    CONFIG.PSU__DDRC__ENABLE {1} \
    CONFIG.PSU__DDRC__ENABLE_2T_TIMING {0} \
    CONFIG.PSU__DDRC__ENABLE_DP_SWITCH {0} \
    CONFIG.PSU__DDRC__EN_2ND_CLK {0} \
    CONFIG.PSU__DDRC__FGRM {1X} \
    CONFIG.PSU__DDRC__FREQ_MHZ {1} \
    CONFIG.PSU__DDRC__LPDDR3_DUALRANK_SDP {0} \
    CONFIG.PSU__DDRC__LP_ASR {manual normal} \
    CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
    CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
    CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
    CONFIG.PSU__DDRC__PLL_BYPASS {0} \
    CONFIG.PSU__DDRC__PWR_DOWN_EN {0} \
    CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
    CONFIG.PSU__DDRC__RD_DQS_CENTER {0} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
    CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400P} \
    CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
    CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
    CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
    CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
    CONFIG.PSU__DDRC__T_FAW {32} \
    CONFIG.PSU__DDRC__T_RAS_MIN {36} \
    CONFIG.PSU__DDRC__T_RC {52} \
    CONFIG.PSU__DDRC__T_RCD {16} \
    CONFIG.PSU__DDRC__T_RP {16} \
    CONFIG.PSU__DDRC__VIDEO_BUFFER_SIZE {0} \
    CONFIG.PSU__DDRC__VREF {1} \
    CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
    CONFIG.PSU__DDR_QOS_ENABLE {0} \
    CONFIG.PSU__DDR_QOS_HP0_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP0_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP1_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP1_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP2_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP2_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP3_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP3_WRQOS {} \
    CONFIG.PSU__DDR_SW_REFRESH_ENABLED {1} \
    CONFIG.PSU__DDR__INTERFACE__FREQMHZ {533.500} \
    CONFIG.PSU__DEVICE_TYPE {EG} \
    CONFIG.PSU__DISPLAYPORT__LANE0__ENABLE {1} \
    CONFIG.PSU__DISPLAYPORT__LANE0__IO {GT Lane1} \
    CONFIG.PSU__DISPLAYPORT__LANE1__ENABLE {1} \
    CONFIG.PSU__DISPLAYPORT__LANE1__IO {GT Lane0} \
    CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__DLL__ISUSED {1} \
    CONFIG.PSU__DPAUX__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__DPAUX__PERIPHERAL__IO {MIO 27 .. 30} \
    CONFIG.PSU__DP__LANE_SEL {Dual Lower} \
    CONFIG.PSU__DP__REF_CLK_FREQ {27} \
    CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk1} \
    CONFIG.PSU__ENABLE__DDR__REFRESH__SIGNALS {0} \
    CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET2__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET3__FIFO__ENABLE {0} \
    CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
    CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \
    CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \
    CONFIG.PSU__ENET3__PTP__ENABLE {0} \
    CONFIG.PSU__ENET3__TSU__ENABLE {0} \
    CONFIG.PSU__EN_AXI_STATUS_PORTS {0} \
    CONFIG.PSU__EN_EMIO_TRACE {0} \
    CONFIG.PSU__EP__IP {0} \
    CONFIG.PSU__EXPAND__CORESIGHT {0} \
    CONFIG.PSU__EXPAND__FPD_SLAVES {0} \
    CONFIG.PSU__EXPAND__GIC {0} \
    CONFIG.PSU__EXPAND__LOWER_LPS_SLAVES {0} \
    CONFIG.PSU__EXPAND__UPPER_LPS_SLAVES {0} \
    CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__FPGA_PL0_ENABLE {1} \
    CONFIG.PSU__FPGA_PL1_ENABLE {0} \
    CONFIG.PSU__FPGA_PL2_ENABLE {0} \
    CONFIG.PSU__FPGA_PL3_ENABLE {0} \
    CONFIG.PSU__FP__POWER__ON {1} \
    CONFIG.PSU__FTM__CTI_IN_0 {0} \
    CONFIG.PSU__FTM__CTI_IN_1 {0} \
    CONFIG.PSU__FTM__CTI_IN_2 {0} \
    CONFIG.PSU__FTM__CTI_IN_3 {0} \
    CONFIG.PSU__FTM__CTI_OUT_0 {0} \
    CONFIG.PSU__FTM__CTI_OUT_1 {0} \
    CONFIG.PSU__FTM__CTI_OUT_2 {0} \
    CONFIG.PSU__FTM__CTI_OUT_3 {0} \
    CONFIG.PSU__FTM__GPI {0} \
    CONFIG.PSU__FTM__GPO {0} \
    CONFIG.PSU__GEM3_COHERENCY {0} \
    CONFIG.PSU__GEM3_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__GEM__TSU__ENABLE {0} \
    CONFIG.PSU__GEN_IPI_0__MASTER {APU} \
    CONFIG.PSU__GEN_IPI_10__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_1__MASTER {RPU0} \
    CONFIG.PSU__GEN_IPI_2__MASTER {RPU1} \
    CONFIG.PSU__GEN_IPI_3__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_4__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_5__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_6__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_7__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_8__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_9__MASTER {NONE} \
    CONFIG.PSU__GPIO0_MIO__IO {MIO 0 .. 25} \
    CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO1_MIO__IO {MIO 26 .. 51} \
    CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO2_MIO__IO {MIO 52 .. 77} \
    CONFIG.PSU__GPIO2_MIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO_EMIO_WIDTH {5} \
    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__IO {5} \
    CONFIG.PSU__GPIO_EMIO__WIDTH {[94:0]} \
    CONFIG.PSU__GPU_PP0__POWER__ON {1} \
    CONFIG.PSU__GPU_PP1__POWER__ON {1} \
    CONFIG.PSU__GT_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__GT__LINK_SPEED {HBR} \
    CONFIG.PSU__GT__PRE_EMPH_LVL_4 {0} \
    CONFIG.PSU__GT__VLT_SWNG_LVL_4 {0} \
    CONFIG.PSU__HPM0_FPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM0_FPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__HPM0_LPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM0_LPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__HPM1_FPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM1_FPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__I2C0_LOOP_I2C1__ENABLE {0} \
    CONFIG.PSU__I2C0__GRP_INT__ENABLE {0} \
    CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 14 .. 15} \
    CONFIG.PSU__I2C1__GRP_INT__ENABLE {0} \
    CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IRQ_P2F_ADMA_CHAN__INT {0} \
    CONFIG.PSU__IRQ_P2F_AIB_AXI__INT {0} \
    CONFIG.PSU__IRQ_P2F_AMS__INT {0} \
    CONFIG.PSU__IRQ_P2F_APM_FPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_COMM__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_CPUMNT__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_CTI__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_EXTERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_L2ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_PMU__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_REGS__INT {0} \
    CONFIG.PSU__IRQ_P2F_ATB_LPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_CLKMON__INT {0} \
    CONFIG.PSU__IRQ_P2F_DDR_SS__INT {0} \
    CONFIG.PSU__IRQ_P2F_DPDMA__INT {0} \
    CONFIG.PSU__IRQ_P2F_DPORT__INT {0} \
    CONFIG.PSU__IRQ_P2F_EFUSE__INT {0} \
    CONFIG.PSU__IRQ_P2F_ENT3_WAKEUP__INT {0} \
    CONFIG.PSU__IRQ_P2F_ENT3__INT {0} \
    CONFIG.PSU__IRQ_P2F_FPD_APB__INT {0} \
    CONFIG.PSU__IRQ_P2F_FPD_ATB_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_FP_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_GDMA_CHAN__INT {0} \
    CONFIG.PSU__IRQ_P2F_GPIO__INT {0} \
    CONFIG.PSU__IRQ_P2F_GPU__INT {0} \
    CONFIG.PSU__IRQ_P2F_I2C0__INT {0} \
    CONFIG.PSU__IRQ_P2F_LPD_APB__INT {0} \
    CONFIG.PSU__IRQ_P2F_LPD_APM__INT {0} \
    CONFIG.PSU__IRQ_P2F_LP_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_OCM_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_DMA__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_LEGACY__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_MSC__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_MSI__INT {0} \
    CONFIG.PSU__IRQ_P2F_PL_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_R5_CORE0_ECC_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_R5_CORE1_ECC_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_RPU_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_RPU_PERMON__INT {0} \
    CONFIG.PSU__IRQ_P2F_RTC_ALARM__INT {0} \
    CONFIG.PSU__IRQ_P2F_RTC_SECONDS__INT {0} \
    CONFIG.PSU__IRQ_P2F_SATA__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO0_WAKE__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO0__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO1_WAKE__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO1__INT {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_UART0__INT {0} \
    CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_OTG__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_OTG__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_PMU_WAKEUP__INT {0} \
    CONFIG.PSU__IRQ_P2F_XMPU_FPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_XMPU_LPD__INT {0} \
    CONFIG.PSU__IRQ_P2F__INTF_FPD_SMMU__INT {0} \
    CONFIG.PSU__IRQ_P2F__INTF_PPD_CCI__INT {0} \
    CONFIG.PSU__L2_BANK0__POWER__ON {1} \
    CONFIG.PSU__LPDMA0_COHERENCY {0} \
    CONFIG.PSU__LPDMA1_COHERENCY {0} \
    CONFIG.PSU__LPDMA2_COHERENCY {0} \
    CONFIG.PSU__LPDMA3_COHERENCY {0} \
    CONFIG.PSU__LPDMA4_COHERENCY {0} \
    CONFIG.PSU__LPDMA5_COHERENCY {0} \
    CONFIG.PSU__LPDMA6_COHERENCY {0} \
    CONFIG.PSU__LPDMA7_COHERENCY {0} \
    CONFIG.PSU__LPD_SLCR__CSUPMU_WDT_CLK_SEL__SELECT {APB} \
    CONFIG.PSU__LPD_SLCR__CSUPMU__ACT_FREQMHZ {100} \
    CONFIG.PSU__LPD_SLCR__CSUPMU__FREQMHZ {100} \
    CONFIG.PSU__MAXIGP0__DATA_WIDTH {128} \
    CONFIG.PSU__M_AXI_GP0_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__M_AXI_GP1_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__M_AXI_GP2_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__NAND__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__NAND__READY_BUSY__ENABLE {0} \
    CONFIG.PSU__NUM_FABRIC_RESETS {1} \
    CONFIG.PSU__OCM_BANK0__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK1__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK2__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK3__POWER__ON {1} \
    CONFIG.PSU__OVERRIDE_HPX_QOS {0} \
    CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
    CONFIG.PSU__PCIE__ACS_VIOLAION {0} \
    CONFIG.PSU__PCIE__AER_CAPABILITY {0} \
    CONFIG.PSU__PCIE__CLASS_CODE_BASE {} \
    CONFIG.PSU__PCIE__CLASS_CODE_INTERFACE {} \
    CONFIG.PSU__PCIE__CLASS_CODE_SUB {} \
    CONFIG.PSU__PCIE__DEVICE_ID {} \
    CONFIG.PSU__PCIE__INTX_GENERATION {0} \
    CONFIG.PSU__PCIE__MSIX_CAPABILITY {0} \
    CONFIG.PSU__PCIE__MSI_CAPABILITY {0} \
    CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_ENABLE {1} \
    CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_ENABLE {0} \
    CONFIG.PSU__PCIE__RESET__POLARITY {Active Low} \
    CONFIG.PSU__PCIE__REVISION_ID {} \
    CONFIG.PSU__PCIE__SUBSYSTEM_ID {} \
    CONFIG.PSU__PCIE__SUBSYSTEM_VENDOR_ID {} \
    CONFIG.PSU__PCIE__VENDOR_ID {} \
    CONFIG.PSU__PJTAG__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PL_CLK0_BUF {TRUE} \
    CONFIG.PSU__PL__POWER__ON {1} \
    CONFIG.PSU__PMU__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PRESET_APPLIED {1} \
    CONFIG.PSU__PROTECTION__DDR_SEGMENTS {NONE} \
    CONFIG.PSU__PROTECTION__ENABLE {0} \
    CONFIG.PSU__PROTECTION__FPD_SEGMENTS {SA:0xFD1A0000 ;SIZE:1280;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  |  SA:0xFD000000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU\
Firmware  |  SA:0xFD010000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  |  SA:0xFD020000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware\
|  SA:0xFD030000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  |  SA:0xFD040000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  | SA:0xFD050000\
;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  |  SA:0xFD610000 ;SIZE:512;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware  |  SA:0xFD5D0000 ;SIZE:64;UNIT:KB\
;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware} \
    CONFIG.PSU__PROTECTION__LPD_SEGMENTS {SA:0xFF980000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF5E0000 ;SIZE:2560;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU\
Firmware|SA:0xFFCC0000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF180000 ;SIZE:768;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF410000\
;SIZE:640;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFFA70000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF9A0000 ;SIZE:64;UNIT:KB\
;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware} \
    CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;1|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;0|S_AXI_HP3_FPD:NA;0|S_AXI_HP2_FPD:NA;0|S_AXI_HP1_FPD:NA;0|S_AXI_HP0_FPD:NA;1|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;1|SATA1:NonSecure;0|SATA0:NonSecure;0|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;0|PMU:NA;1|PCIe:NonSecure;0|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;1|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;1|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1}\
\
    CONFIG.PSU__PROTECTION__MASTERS_TZ {GEM0:NonSecure|SD1:NonSecure|GEM2:NonSecure|GEM1:NonSecure|GEM3:NonSecure|PCIe:NonSecure|DP:NonSecure|NAND:NonSecure|GPU:NonSecure|USB1:NonSecure|USB0:NonSecure|LDMA:NonSecure|FDMA:NonSecure|QSPI:NonSecure|SD0:NonSecure}\
\
    CONFIG.PSU__PROTECTION__OCM_SEGMENTS {NONE} \
    CONFIG.PSU__PROTECTION__PRESUBSYSTEMS {NONE} \
    CONFIG.PSU__PROTECTION__SLAVES {LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;1|LPD;USB3_0;FF9D0000;FF9DFFFF;1|LPD;UART1;FF010000;FF01FFFF;0|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;1|LPD;SWDT0;FF150000;FF15FFFF;1|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;1|FPD;SATA;FD0C0000;FD0CFFFF;0|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;0|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;0|FPD;PCIE_LOW;E0000000;EFFFFFFF;0|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;0|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;0|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;0|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;0|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;0|LPD;I2C0;FF020000;FF02FFFF;1|FPD;GPU;FD4B0000;FD4BFFFF;1|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;1|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display\
Port;FD4A0000;FD4AFFFF;1|FPD;DPDMA;FD4C0000;FD4CFFFF;1|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;87FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;1|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;0|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1}\
\
    CONFIG.PSU__PROTECTION__SUBSYSTEMS {PMU Firmware:PMU} \
    CONFIG.PSU__PSS_ALT_REF_CLK__ENABLE {0} \
    CONFIG.PSU__PSS_ALT_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.333333} \
    CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__REPORT__DBGLOG {0} \
    CONFIG.PSU__RPU_COHERENCY {0} \
    CONFIG.PSU__RPU__POWER__ON {1} \
    CONFIG.PSU__SATA__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
    CONFIG.PSU__SD0_COHERENCY {0} \
    CONFIG.PSU__SD0_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__SD0__CLK_200_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD0__CLK_50_DDR_ITAP_DLY {0x12} \
    CONFIG.PSU__SD0__CLK_50_DDR_OTAP_DLY {0x6} \
    CONFIG.PSU__SD0__CLK_50_SDR_ITAP_DLY {0x15} \
    CONFIG.PSU__SD0__CLK_50_SDR_OTAP_DLY {0x6} \
    CONFIG.PSU__SD0__DATA_TRANSFER_MODE {8Bit} \
    CONFIG.PSU__SD0__GRP_POW__ENABLE {0} \
    CONFIG.PSU__SD0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SD0__PERIPHERAL__IO {EMIO} \
    CONFIG.PSU__SD0__RESET__ENABLE {0} \
    CONFIG.PSU__SD0__SLOT_TYPE {eMMC} \
    CONFIG.PSU__SD1_COHERENCY {0} \
    CONFIG.PSU__SD1_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__SD1__CLK_50_SDR_ITAP_DLY {0x15} \
    CONFIG.PSU__SD1__CLK_50_SDR_OTAP_DLY {0x5} \
    CONFIG.PSU__SD1__DATA_TRANSFER_MODE {4Bit} \
    CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
    CONFIG.PSU__SD1__GRP_POW__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_POW__IO {MIO 43} \
    CONFIG.PSU__SD1__GRP_WP__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_WP__IO {MIO 44} \
    CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 46 .. 51} \
    CONFIG.PSU__SD1__SLOT_TYPE {SD 2.0} \
    CONFIG.PSU__SPI0_LOOP_SPI1__ENABLE {0} \
    CONFIG.PSU__SPI0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SPI1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SWDT0__CLOCK__ENABLE {0} \
    CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SWDT0__PERIPHERAL__IO {NA} \
    CONFIG.PSU__SWDT0__RESET__ENABLE {0} \
    CONFIG.PSU__SWDT1__CLOCK__ENABLE {0} \
    CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SWDT1__PERIPHERAL__IO {NA} \
    CONFIG.PSU__SWDT1__RESET__ENABLE {0} \
    CONFIG.PSU__TCM0A__POWER__ON {1} \
    CONFIG.PSU__TCM0B__POWER__ON {1} \
    CONFIG.PSU__TCM1A__POWER__ON {1} \
    CONFIG.PSU__TCM1B__POWER__ON {1} \
    CONFIG.PSU__TESTSCAN__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__TRACE__INTERNAL_WIDTH {32} \
    CONFIG.PSU__TRACE__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__TRISTATE__INVERTED {1} \
    CONFIG.PSU__TSU__BUFG_PORT_PAIR {0} \
    CONFIG.PSU__TTC0__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC0__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC0__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__TTC1__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC1__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC1__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__TTC2__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC2__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC2__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__TTC3__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC3__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC3__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__UART0_LOOP_UART1__ENABLE {0} \
    CONFIG.PSU__UART0__BAUD_RATE {115200} \
    CONFIG.PSU__UART0__MODEM__ENABLE {0} \
    CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 34 .. 35} \
    CONFIG.PSU__UART1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__USB0_COHERENCY {0} \
    CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__USB0__PERIPHERAL__IO {MIO 52 .. 63} \
    CONFIG.PSU__USB0__REF_CLK_FREQ {26} \
    CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk0} \
    CONFIG.PSU__USB1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__USB2_0__EMIO__ENABLE {0} \
    CONFIG.PSU__USB3_0__EMIO__ENABLE {0} \
    CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
    CONFIG.PSU__USB__RESET__MODE {Boot Pin} \
    CONFIG.PSU__USB__RESET__POLARITY {Active Low} \
    CONFIG.PSU__USE_DIFF_RW_CLK_GP2 {0} \
    CONFIG.PSU__USE__ADMA {0} \
    CONFIG.PSU__USE__APU_LEGACY_INTERRUPT {0} \
    CONFIG.PSU__USE__AUDIO {0} \
    CONFIG.PSU__USE__CLK {0} \
    CONFIG.PSU__USE__CLK0 {0} \
    CONFIG.PSU__USE__CLK1 {0} \
    CONFIG.PSU__USE__CLK2 {0} \
    CONFIG.PSU__USE__CLK3 {0} \
    CONFIG.PSU__USE__CROSS_TRIGGER {0} \
    CONFIG.PSU__USE__DDR_INTF_REQUESTED {0} \
    CONFIG.PSU__USE__DEBUG__TEST {0} \
    CONFIG.PSU__USE__EVENT_RPU {0} \
    CONFIG.PSU__USE__FABRIC__RST {1} \
    CONFIG.PSU__USE__FTM {0} \
    CONFIG.PSU__USE__GDMA {0} \
    CONFIG.PSU__USE__IRQ {0} \
    CONFIG.PSU__USE__IRQ0 {1} \
    CONFIG.PSU__USE__IRQ1 {0} \
    CONFIG.PSU__USE__M_AXI_GP0 {1} \
    CONFIG.PSU__USE__M_AXI_GP1 {0} \
    CONFIG.PSU__USE__M_AXI_GP2 {0} \
    CONFIG.PSU__USE__PROC_EVENT_BUS {0} \
    CONFIG.PSU__USE__RPU_LEGACY_INTERRUPT {0} \
    CONFIG.PSU__USE__RST0 {0} \
    CONFIG.PSU__USE__RST1 {0} \
    CONFIG.PSU__USE__RST2 {0} \
    CONFIG.PSU__USE__RST3 {0} \
    CONFIG.PSU__USE__RTC {0} \
    CONFIG.PSU__USE__STM {0} \
    CONFIG.PSU__USE__S_AXI_ACE {0} \
    CONFIG.PSU__USE__S_AXI_ACP {0} \
    CONFIG.PSU__USE__S_AXI_GP0 {0} \
    CONFIG.PSU__USE__S_AXI_GP1 {0} \
    CONFIG.PSU__USE__S_AXI_GP2 {1} \
    CONFIG.PSU__USE__S_AXI_GP3 {0} \
    CONFIG.PSU__USE__S_AXI_GP4 {0} \
    CONFIG.PSU__USE__S_AXI_GP5 {0} \
    CONFIG.PSU__USE__S_AXI_GP6 {0} \
    CONFIG.PSU__USE__USB3_0_HUB {0} \
    CONFIG.PSU__USE__USB3_1_HUB {0} \
    CONFIG.PSU__USE__VIDEO {0} \
    CONFIG.PSU__VIDEO_REF_CLK__ENABLE {0} \
    CONFIG.PSU__VIDEO_REF_CLK__FREQMHZ {33.333} \
    CONFIG.QSPI_BOARD_INTERFACE {custom} \
    CONFIG.SATA_BOARD_INTERFACE {custom} \
    CONFIG.SD0_BOARD_INTERFACE {custom} \
    CONFIG.SD1_BOARD_INTERFACE {custom} \
    CONFIG.SPI0_BOARD_INTERFACE {custom} \
    CONFIG.SPI1_BOARD_INTERFACE {custom} \
    CONFIG.SUBPRESET1 {Custom} \
    CONFIG.SUBPRESET2 {Custom} \
    CONFIG.SWDT0_BOARD_INTERFACE {custom} \
    CONFIG.SWDT1_BOARD_INTERFACE {custom} \
    CONFIG.TRACE_BOARD_INTERFACE {custom} \
    CONFIG.TTC0_BOARD_INTERFACE {custom} \
    CONFIG.TTC1_BOARD_INTERFACE {custom} \
    CONFIG.TTC2_BOARD_INTERFACE {custom} \
    CONFIG.TTC3_BOARD_INTERFACE {custom} \
    CONFIG.UART0_BOARD_INTERFACE {custom} \
    CONFIG.UART1_BOARD_INTERFACE {custom} \
    CONFIG.USB0_BOARD_INTERFACE {custom} \
    CONFIG.USB1_BOARD_INTERFACE {custom} \
  ] $zynq_ultra_ps_e_0


  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_ports sysclk] [get_bd_intf_pins sysclk/sysclk]
  connect_bd_intf_net -intf_net GT_DIFF_REFCLK1_0_1 [get_bd_intf_ports aurora_refclk] [get_bd_intf_pins c2c/aurora_refclk]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_0_1 [get_bd_intf_ports aurora_rx_master] [get_bd_intf_pins c2c/aurora_rx_master]
  connect_bd_intf_net -intf_net aurora_master_GT_SERIAL_TX [get_bd_intf_ports aurora_tx_master] [get_bd_intf_pins c2c/aurora_tx_master]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins c2c/s_axi] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_FPD [get_bd_intf_pins smartconnect_0/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_FPD]

  # Create port connections
  connect_bd_net -net aurora_master_gt_pll_lock [get_bd_pins c2c/gt_pll_lock] [get_bd_pins vio_0/probe_in0] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net c2c_block_axi_c2c_aurora_channel_up [get_bd_pins c2c/channel_up] [get_bd_pins vio_0/probe_in3] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net c2c_master_axi_c2c_link_status_out [get_bd_pins c2c/axi_c2c_link_status_out] [get_bd_pins vio_0/probe_in4] [get_bd_pins xlconcat_0/In2] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net clk_wiz_0_clk_200 [get_bd_pins c2c/s_aclk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins sysclk/clk_125] [get_bd_pins vio_0/clk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/saxihp0_fpd_aclk]
  connect_bd_net -net init_clk_1 [get_bd_pins c2c/init_clk] [get_bd_pins sysclk/clk_75]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins c2c/s_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_ports led_out] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net vio_0_probe_out0 [get_bd_pins proc_sys_reset_0/aux_reset_in] [get_bd_pins vio_0/probe_out0]
  connect_bd_net -net vio_0_probe_out1 [get_bd_pins c2c/aurora_pma_init_in] [get_bd_pins vio_0/probe_out1]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins c2c/dout1] [get_bd_pins zynq_ultra_ps_e_0/emio_gpio_i]
  connect_bd_net -net xlconcat_0_dout1 [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins c2c/lane1] [get_bd_pins vio_0/probe_in1]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins c2c/lane0] [get_bd_pins vio_0/probe_in2]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_resetn0 [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0]

  # Create address segments
  assign_bd_address -offset 0x001000000000 -range 0x000400000000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs c2c/c2c_master/s_axi/Mem0] -force

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   "ActiveEmotionalView":"Default View",
   "Default View_ScaleFactor":"0.688663",
   "Default View_TopLeft":"-42,225",
   "ExpandedHierarchyInLayout":"",
   "guistr":"# # String gsaved with Nlview 7.0r4  2019-12-20 bk=1.5203 VDI=41 GEI=36 GUI=JA:10.0 TLS
#  -string -flagsOSRD
preplace port aurora_refclk -pg 1 -lvl 0 -x 0 -y 470 -defaultsOSRD
preplace port aurora_rx_master -pg 1 -lvl 0 -x 0 -y 490 -defaultsOSRD
preplace port aurora_tx_master -pg 1 -lvl 6 -x 2190 -y 470 -defaultsOSRD
preplace port sysclk -pg 1 -lvl 0 -x 0 -y 560 -defaultsOSRD
preplace portBus led_out -pg 1 -lvl 6 -x 2190 -y 120 -defaultsOSRD
preplace inst c2c -pg 1 -lvl 5 -x 1940 -y 530 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 3 -x 890 -y 110 -defaultsOSRD
preplace inst smartconnect_0 -pg 1 -lvl 4 -x 1410 -y 380 -defaultsOSRD
preplace inst sysclk -pg 1 -lvl 1 -x 120 -y 560 -defaultsOSRD
preplace inst util_vector_logic_0 -pg 1 -lvl 5 -x 1940 -y 120 -defaultsOSRD
preplace inst vio_0 -pg 1 -lvl 2 -x 420 -y 350 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 4 -x 1410 -y 120 -defaultsOSRD
preplace inst zynq_ultra_ps_e_0 -pg 1 -lvl 3 -x 890 -y 350 -defaultsOSRD
preplace netloc aurora_master_gt_pll_lock 1 1 5 250 210 NJ 210 1200 210 NJ 210 2170
preplace netloc c2c_block_axi_c2c_aurora_channel_up 1 1 5 230 10 NJ 10 1230 30 NJ 30 2160
preplace netloc c2c_master_axi_c2c_link_status_out 1 1 5 240 220 NJ 220 1230 220 NJ 220 2150
preplace netloc clk_wiz_0_clk_200 1 1 4 220 480 570 480 1230 480 1560J
preplace netloc init_clk_1 1 1 4 N 550 NJ 550 NJ 550 NJ
preplace netloc proc_sys_reset_0_peripheral_aresetn 1 3 2 1220 540 1550
preplace netloc util_vector_logic_0_Res 1 5 1 NJ 120
preplace netloc vio_0_probe_out0 1 2 1 560 110n
preplace netloc vio_0_probe_out1 1 2 3 560 500 NJ 500 1550J
preplace netloc xlconcat_0_dout 1 3 3 1230J 300 NJ 300 2140
preplace netloc xlconcat_0_dout1 1 4 1 NJ 120
preplace netloc xlslice_0_Dout 1 1 5 250 510 NJ 510 NJ 510 1570J 410 2120
preplace netloc xlslice_1_Dout 1 1 5 260 230 NJ 230 NJ 230 NJ 230 2130
preplace netloc zynq_ultra_ps_e_0_pl_resetn0 1 2 2 580 240 1200
preplace netloc CLK_IN_D_0_1 1 0 1 NJ 560
preplace netloc GT_DIFF_REFCLK1_0_1 1 0 5 NJ 470 NJ 470 NJ 470 NJ 470 NJ
preplace netloc GT_SERIAL_RX_0_1 1 0 5 NJ 490 NJ 490 NJ 490 NJ 490 NJ
preplace netloc aurora_master_GT_SERIAL_TX 1 5 1 NJ 470
preplace netloc smartconnect_0_M00_AXI 1 4 1 1580 380n
preplace netloc zynq_ultra_ps_e_0_M_AXI_HPM0_FPD 1 3 1 1210 300n
levelinfo -pg 1 0 120 420 890 1410 1940 2190
pagesize -pg 1 -db -bbox -sgen -180 0 2370 1030
"
}

  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


