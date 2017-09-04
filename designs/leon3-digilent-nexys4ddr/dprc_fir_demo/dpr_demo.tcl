#synthesize and create design checkpoints for reconfigurable modules
add_files -norecurse ./dprc_fir_demo/fir_v1.vhd
synth_design -mode out_of_context -flatten_hierarchy rebuilt -top fir -part xc7a100tcsg324-1
write_checkpoint firv1.dcp
close_project
add_files -norecurse ./dprc_fir_demo/fir_v2.vhd
synth_design -mode out_of_context -flatten_hierarchy rebuilt -top fir -part xc7a100tcsg324-1
write_checkpoint firv2.dcp
close_project

#create the project and import static logic files
source ./vivado/leon3mp_vivado.tcl

#synthesize static logic
synth_design -directive runtimeoptimized -resource_sharing off -keep_equivalent_registers -no_lc -rtl -name rtl_1
set_property flow {Vivado Synthesis 2012} [get_runs synth_1]
set_property strategy {Vivado Synthesis Defaults} [get_runs synth_1]
reset_run synth_1
launch_runs synth_1
wait_on_run -timeout 360 synth_1
get_ips
open_run synth_1 -name synth_1

#import first reconfigurable module and floorplan
read_checkpoint -cell prc.fir_ex/fir_core firv1.dcp
set_property HD.RECONFIGURABLE true [get_cells prc.fir_ex/fir_core]
create_pblock pblock_fir_core
resize_pblock pblock_fir_core -add {SLICE_X10Y150:SLICE_X11Y199 DSP48_X0Y60:DSP48_X0Y79}
add_cells_to_pblock pblock_fir_core [get_cells [list prc.fir_ex/fir_core]] -clear_locs
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_fir_core]
report_drc -checks [get_drc_checks HDPR*]

#implement the first design configuration
opt_design
place_design
route_design
source ./bitstream.tcl
write_bitstream -raw_bitfile config1
write_checkpoint config1_routed.dcp

#load second reconfigurable module
update_design -cell prc.fir_ex/fir_core -black_box
lock_design -level routing
read_checkpoint -cell prc.fir_ex/fir_core firv2.dcp

#implement the second design configuration
opt_design
place_design
route_design
source ./bitstream.tcl
write_bitstream -raw_bitfile config2
write_checkpoint config2_routed.dcp

#verify configurations compatibility
pr_verify -full_check config1_routed.dcp config2_routed.dcp -file pr_verify.log

close_project
exit
