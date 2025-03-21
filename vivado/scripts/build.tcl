# Check the version of Vivado used
set version_required "2022.2"
set ver [lindex [split $::env(XILINX_VIVADO) /] end]
if {![string equal $ver $version_required]} {
  puts "###############################"
  puts "### Failed to build project ###"
  puts "###############################"
  puts "This project was designed for use with Vivado $version_required."
  puts "You are using Vivado $ver. Please install Vivado $version_required."
  return
}


create_project -force vu13p ./vu13p -part xcvu13p-fhgb2104-2-e

add_files -fileset constrs_1 -norecurse {./src/constraints/vu13p.xdc}
source ./src/bd/vu13p.tcl

make_wrapper -files [get_files vu13p.bd] -top
add_files -fileset sources_1 -norecurse vu13p/vu13p.gen/sources_1/bd/vu13p/hdl/vu13p_wrapper.v

import_files -force

update_compile_order -fileset sources_1
update_compile_order -fileset constrs_1

close_bd_design [current_bd_design]
open_bd_design [get_files vu13p.bd]
validate_bd_design -force
save_bd_design

