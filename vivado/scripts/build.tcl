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


# Possible targets & their respective part numbers
dict set target_dict smf { xczu4eg-fbvb900-2-e }
dict set target_dict vu13p { xcvu13p-fhgb2104-2-e }
dict set target_dict vu19p { xilinx.com kc705 { X1 } mb }


# Define variables
set target [lindex $argv 0]
set fpga_part [lindex [dict get $target_dict $target] 0]




# Vivado scripts to create project & wrappers
create_project -force $target $target -part $fpga_part
add_files -fileset constrs_1 -norecurse ./src/constraints/${target}.xdc

source ./src/bd/${target}.tcl

make_wrapper -files [get_files ${target}.bd] -top
add_files -fileset sources_1 -norecurse ${target}/${target}.gen/sources_1/bd/${target}/hdl/${target}_wrapper.v

import_files -force
update_compile_order -fileset sources_1
update_compile_order -fileset constrs_1

close_bd_design [current_bd_design]
open_bd_design [get_files ${target}.bd]
validate_bd_design -force
save_bd_design


