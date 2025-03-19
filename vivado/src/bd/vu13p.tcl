
################################################################
# This is a generated script based on design: top
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
# source top_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvu13p-fhgb2104-2-e
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name vu13p

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
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:vio:3.0\
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:aurora_64b66b:12.0\
xilinx.com:ip:axi_chip2chip:5.0\
xilinx.com:ip:xlslice:1.0\
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 aurora_rx_slave

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 aurora_tx_slave

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi


  # Create pins
  create_bd_pin -dir I -type rst aurora_pma_init_in
  create_bd_pin -dir O axi_c2c_link_status_out
  create_bd_pin -dir O channel_up
  create_bd_pin -dir O gt_pll_lock
  create_bd_pin -dir I -type clk init_clk
  create_bd_pin -dir O -from 0 -to 0 lane0
  create_bd_pin -dir O -from 0 -to 0 lane1
  create_bd_pin -dir I -type clk m_aclk
  create_bd_pin -dir I -type rst m_aresetn

  # Create instance: aurora_64b66b_0, and set properties
  set aurora_64b66b_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_64b66b:12.0 aurora_64b66b_0 ]
  set_property -dict [list \
    CONFIG.C_AURORA_LANES {2} \
    CONFIG.C_INIT_CLK {75} \
    CONFIG.C_LINE_RATE {6.25} \
    CONFIG.C_REFCLK_FREQUENCY {156.25} \
    CONFIG.C_REFCLK_SOURCE {MGTREFCLK1_of_Quad_X0Y4} \
    CONFIG.C_UCOLUMN_USED {left} \
    CONFIG.C_USE_BYTESWAP {true} \
    CONFIG.SupportLevel {1} \
    CONFIG.drp_mode {Disabled} \
    CONFIG.interface_mode {Streaming} \
  ] $aurora_64b66b_0


  # Create instance: axi_chip2chip_0, and set properties
  set axi_chip2chip_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_chip2chip:5.0 axi_chip2chip_0 ]
  set_property -dict [list \
    CONFIG.C_AXI_ADDR_WIDTH {40} \
    CONFIG.C_AXI_DATA_WIDTH {64} \
    CONFIG.C_INTERFACE_MODE {0} \
    CONFIG.C_INTERFACE_TYPE {2} \
    CONFIG.C_MASTER_FPGA {0} \
    CONFIG.C_M_AXI_ID_WIDTH {0} \
    CONFIG.C_M_AXI_WUSER_WIDTH {0} \
    CONFIG.C_SUPPORT_NARROWBURST {true} \
  ] $axi_chip2chip_0


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
  connect_bd_intf_net -intf_net GT_DIFF_REFCLK1_0_1 [get_bd_intf_pins aurora_refclk] [get_bd_intf_pins aurora_64b66b_0/GT_DIFF_REFCLK1]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_0_1 [get_bd_intf_pins aurora_rx_slave] [get_bd_intf_pins aurora_64b66b_0/GT_SERIAL_RX]
  connect_bd_intf_net -intf_net aurora_64b66b_0_GT_SERIAL_TX [get_bd_intf_pins aurora_tx_slave] [get_bd_intf_pins aurora_64b66b_0/GT_SERIAL_TX]
  connect_bd_intf_net -intf_net aurora_64b66b_0_USER_DATA_M_AXIS_RX [get_bd_intf_pins aurora_64b66b_0/USER_DATA_M_AXIS_RX] [get_bd_intf_pins axi_chip2chip_0/AXIS_RX]
  connect_bd_intf_net -intf_net axi_chip2chip_0_AXIS_TX [get_bd_intf_pins aurora_64b66b_0/USER_DATA_S_AXIS_TX] [get_bd_intf_pins axi_chip2chip_0/AXIS_TX]
  connect_bd_intf_net -intf_net axi_chip2chip_0_m_axi [get_bd_intf_pins m_axi] [get_bd_intf_pins axi_chip2chip_0/m_axi]

  # Create port connections
  connect_bd_net -net aurora_64b66b_0_channel_up [get_bd_pins channel_up] [get_bd_pins aurora_64b66b_0/channel_up] [get_bd_pins axi_chip2chip_0/axi_c2c_aurora_channel_up]
  connect_bd_net -net aurora_64b66b_0_gt_pll_lock [get_bd_pins gt_pll_lock] [get_bd_pins aurora_64b66b_0/gt_pll_lock]
  connect_bd_net -net aurora_64b66b_0_lane_up [get_bd_pins aurora_64b66b_0/lane_up] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net aurora_64b66b_0_mmcm_not_locked_out [get_bd_pins aurora_64b66b_0/mmcm_not_locked_out] [get_bd_pins axi_chip2chip_0/aurora_mmcm_not_locked]
  connect_bd_net -net aurora_64b66b_0_user_clk_out [get_bd_pins aurora_64b66b_0/user_clk_out] [get_bd_pins axi_chip2chip_0/axi_c2c_phy_clk]
  connect_bd_net -net axi_chip2chip_0_aurora_pma_init_out [get_bd_pins aurora_64b66b_0/pma_init] [get_bd_pins axi_chip2chip_0/aurora_pma_init_out]
  connect_bd_net -net axi_chip2chip_0_aurora_reset_pb [get_bd_pins aurora_64b66b_0/reset_pb] [get_bd_pins axi_chip2chip_0/aurora_reset_pb]
  connect_bd_net -net axi_chip2chip_0_axi_c2c_link_status_out [get_bd_pins axi_c2c_link_status_out] [get_bd_pins axi_chip2chip_0/axi_c2c_link_status_out]
  connect_bd_net -net clk_wiz_0_clk_156_25 [get_bd_pins init_clk] [get_bd_pins aurora_64b66b_0/init_clk] [get_bd_pins axi_chip2chip_0/aurora_init_clk]
  connect_bd_net -net clk_wiz_0_clk_200 [get_bd_pins m_aclk] [get_bd_pins axi_chip2chip_0/m_aclk]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins m_aresetn] [get_bd_pins axi_chip2chip_0/m_aresetn]
  connect_bd_net -net vio_0_probe_out1 [get_bd_pins aurora_pma_init_in] [get_bd_pins axi_chip2chip_0/aurora_pma_init_in]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins lane1] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins lane0] [get_bd_pins xlslice_1/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: bram
proc create_hier_cell_bram { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_bram() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [list \
    CONFIG.DATA_WIDTH {64} \
    CONFIG.SINGLE_PORT_BRAM {1} \
  ] $axi_bram_ctrl_0


  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTA]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]

  # Create port connections
  connect_bd_net -net clk_wiz_0_clk_200 [get_bd_pins s_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn]

  # Perform GUI Layout
  regenerate_bd_layout -hierarchy [get_bd_cells /bram] -layout_string {
   "ActiveEmotionalView":"Default View",
   "Default View_ScaleFactor":"1.0",
   "Default View_TopLeft":"-346,-177",
   "ExpandedHierarchyInLayout":"",
   "guistr":"# # String gsaved with Nlview 7.0r4  2019-12-20 bk=1.5203 VDI=41 GEI=36 GUI=JA:10.0 TLS
#  -string -flagsOSRD
preplace port S_AXI -pg 1 -lvl 0 -x -10 -y 50 -defaultsOSRD
preplace port port-id_s_axi_aclk -pg 1 -lvl 0 -x -10 -y 70 -defaultsOSRD
preplace port port-id_s_axi_aresetn -pg 1 -lvl 0 -x -10 -y 90 -defaultsOSRD
preplace inst axi_bram_ctrl_0 -pg 1 -lvl 1 -x 150 -y 70 -defaultsOSRD
preplace inst blk_mem_gen_0 -pg 1 -lvl 2 -x 430 -y 70 -defaultsOSRD
preplace netloc clk_wiz_0_clk_200 1 0 1 NJ 70
preplace netloc proc_sys_reset_0_peripheral_aresetn 1 0 1 NJ 90
preplace netloc axi_bram_ctrl_0_BRAM_PORTA 1 1 1 N 70
preplace netloc smartconnect_0_M00_AXI 1 0 1 NJ 50
levelinfo -pg 1 -10 150 430 570
pagesize -pg 1 -db -bbox -sgen -160 -10 570 150
"
}

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

  set aurora_rx_slave [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 aurora_rx_slave ]

  set aurora_tx_slave [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 aurora_tx_slave ]

  set sysclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sysclk ]


  # Create ports

  # Create instance: bram
  create_hier_cell_bram [current_bd_instance .] bram

  # Create instance: c2c
  create_hier_cell_c2c [current_bd_instance .] c2c

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [list \
    CONFIG.CLKOUT1_JITTER {102.086} \
    CONFIG.CLKOUT1_PHASE_ERROR {87.180} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200.000} \
    CONFIG.CLKOUT2_JITTER {122.158} \
    CONFIG.CLKOUT2_PHASE_ERROR {87.180} \
    CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {75} \
    CONFIG.CLKOUT2_USED {true} \
    CONFIG.CLK_OUT1_PORT {clk_200} \
    CONFIG.CLK_OUT2_PORT {clk_75} \
    CONFIG.MMCM_CLKFBOUT_MULT_F {12.000} \
    CONFIG.MMCM_CLKOUT0_DIVIDE_F {6.000} \
    CONFIG.MMCM_CLKOUT1_DIVIDE {16} \
    CONFIG.NUM_OUT_CLKS {2} \
    CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
    CONFIG.USE_LOCKED {false} \
    CONFIG.USE_RESET {false} \
  ] $clk_wiz_0


  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property CONFIG.NUM_SI {1} $smartconnect_0


  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [list \
    CONFIG.C_NUM_PROBE_IN {5} \
    CONFIG.C_NUM_PROBE_OUT {2} \
    CONFIG.C_PROBE_OUT0_INIT_VAL {0x1} \
  ] $vio_0


  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN1_D_0_1 [get_bd_intf_ports sysclk] [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]
  connect_bd_intf_net -intf_net GT_DIFF_REFCLK1_0_1 [get_bd_intf_ports aurora_refclk] [get_bd_intf_pins c2c/aurora_refclk]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_0_1 [get_bd_intf_ports aurora_rx_slave] [get_bd_intf_pins c2c/aurora_rx_slave]
  connect_bd_intf_net -intf_net aurora_64b66b_0_GT_SERIAL_TX [get_bd_intf_ports aurora_tx_slave] [get_bd_intf_pins c2c/aurora_tx_slave]
  connect_bd_intf_net -intf_net axi_chip2chip_0_m_axi [get_bd_intf_pins c2c/m_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins bram/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]

  # Create port connections
  connect_bd_net -net aurora_64b66b_0_channel_up [get_bd_pins c2c/channel_up] [get_bd_pins vio_0/probe_in3]
  connect_bd_net -net aurora_64b66b_0_gt_pll_lock [get_bd_pins c2c/gt_pll_lock] [get_bd_pins vio_0/probe_in0]
  connect_bd_net -net axi_chip2chip_0_axi_c2c_link_status_out [get_bd_pins c2c/axi_c2c_link_status_out] [get_bd_pins vio_0/probe_in4]
  connect_bd_net -net c2c_Dout [get_bd_pins c2c/lane0] [get_bd_pins vio_0/probe_in2]
  connect_bd_net -net c2c_Dout1 [get_bd_pins c2c/lane1] [get_bd_pins vio_0/probe_in1]
  connect_bd_net -net clk_wiz_0_clk_156_25 [get_bd_pins c2c/init_clk] [get_bd_pins clk_wiz_0/clk_75]
  connect_bd_net -net clk_wiz_0_clk_200 [get_bd_pins bram/s_axi_aclk] [get_bd_pins c2c/m_aclk] [get_bd_pins clk_wiz_0/clk_200] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins vio_0/clk]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins bram/s_axi_aresetn] [get_bd_pins c2c/m_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net vio_0_probe_out0 [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins vio_0/probe_out0]
  connect_bd_net -net vio_0_probe_out1 [get_bd_pins c2c/aurora_pma_init_in] [get_bd_pins vio_0/probe_out1]

  # Create address segments
  assign_bd_address -offset 0xA0000000 -range 0x00004000 -target_address_space [get_bd_addr_spaces c2c/axi_chip2chip_0/MAXI] [get_bd_addr_segs bram/axi_bram_ctrl_0/S_AXI/Mem0] -force

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   "ActiveEmotionalView":"Default View",
   "Default View_ScaleFactor":"0.505872",
   "Default View_TopLeft":"-312,-235",
   "ExpandedHierarchyInLayout":"",
   "guistr":"# # String gsaved with Nlview 7.0r4  2019-12-20 bk=1.5203 VDI=41 GEI=36 GUI=JA:10.0 TLS
#  -string -flagsOSRD
preplace port aurora_tx_slave -pg 1 -lvl 6 -x 1890 -y 90 -defaultsOSRD
preplace port aurora_rx_slave -pg 1 -lvl 0 -x -90 -y 100 -defaultsOSRD
preplace port aurora_refclk -pg 1 -lvl 0 -x -90 -y 80 -defaultsOSRD
preplace port sysclk -pg 1 -lvl 0 -x -90 -y 360 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 1 -x 130 -y 320 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 1 -x 130 -y 490 -defaultsOSRD
preplace inst vio_0 -pg 1 -lvl 2 -x 520 -y 220 -defaultsOSRD
preplace inst smartconnect_0 -pg 1 -lvl 4 -x 1520 -y 170 -defaultsOSRD
preplace inst bram -pg 1 -lvl 5 -x 1770 -y 190 -defaultsOSRD
preplace inst c2c -pg 1 -lvl 3 -x 1150 -y 130 -defaultsOSRD
preplace netloc aurora_64b66b_0_channel_up 1 1 3 340 10 NJ 10 1330
preplace netloc aurora_64b66b_0_gt_pll_lock 1 1 3 380 90 700J 240 1330
preplace netloc axi_chip2chip_0_axi_c2c_link_status_out 1 1 3 350 30 730J 250 1360
preplace netloc clk_wiz_0_clk_156_25 1 1 2 310J 40 740J
preplace netloc clk_wiz_0_clk_200 1 0 5 -50 390 320 50 720 260 1370 250 1660J
preplace netloc proc_sys_reset_0_peripheral_aresetn 1 1 4 330 70 680 290 1380 260 1670J
preplace netloc vio_0_probe_out0 1 0 3 -60 20 N 20 660
preplace netloc vio_0_probe_out1 1 2 1 710J 160n
preplace netloc c2c_Dout 1 1 3 370 110 670J 270 1350
preplace netloc c2c_Dout1 1 1 3 360 60 690J 280 1340
preplace netloc CLK_IN1_D_0_1 1 0 1 -70J 320n
preplace netloc GT_DIFF_REFCLK1_0_1 1 0 3 NJ 80 NJ 80 NJ
preplace netloc GT_SERIAL_RX_0_1 1 0 3 NJ 100 NJ 100 NJ
preplace netloc aurora_64b66b_0_GT_SERIAL_TX 1 3 3 NJ 90 NJ 90 NJ
preplace netloc axi_chip2chip_0_m_axi 1 3 1 1380 70n
preplace netloc smartconnect_0_M00_AXI 1 4 1 N 170
levelinfo -pg 1 -90 130 520 1150 1520 1770 1890
pagesize -pg 1 -db -bbox -sgen -260 0 2060 590
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


