#create project and add static logic netlists and constraints
create_project dpr_demo ./dpr_demo -part xc4vlx100ff1513-10
set_property design_mode GateLvl [current_fileset]
add_files -norecurse ./leon3mp.ngc
import_files -fileset constrs_1 -norecurse { ../../boards/gr-cpci-xc4v/leon3mp.ucf ../../lib/testgrouppolito/pr/icapv4v5.ucf}
set_property name config_1 [current_run]
set_property is_partial_reconfig true [current_project]
link_design -top leon3mp -name netlist_1
#add first reconfigurable module
create_reconfig_module -name firv1 -cell prc.fir_ex/fir_core
set_property edif_top_file ./dprc_fir_demo/firv1.ngc [get_filesets prc.fir_ex~fir_core#firv1]
save_constraints
load_reconfig_modules -reconfig_modules prc.fir_ex/fir_core:firv1
#add second reconfigurable module
create_reconfig_module -name firv2 -cell prc.fir_ex/fir_core
set_property edif_top_file ./dprc_fir_demo/firv2.ngc [get_filesets prc.fir_ex~fir_core#firv2]
#add third reconfigurable module
create_reconfig_module -name fir_bb -cell prc.fir_ex/fir_core -blackbox
#define Partition constraints
resize_pblock pblock_prc.fir_ex_fir_core -add {SLICE_X18Y336:SLICE_X27Y383 DSP48_X0Y84:DSP48_X0Y95} -locs keep_all -replace
save_constraints
#implement first configuration and promote static logic
launch_runs config_1 -jobs 8
wait_on_run config_1
open_run config_1
current_design netlist_1
promote_run -run config_1 -partition_names {leon3mp prc.fir_ex/fir_core}
create_run config_2 -flow {ISE 14} -strategy {ISE Defaults}
#create and implement second configuration
config_partition -run config_2 -import -import_dir ./dpr_demo/dpr_demo.promote/Xconfig_1 -preservation routing
config_partition -run config_2 -cell prc.fir_ex/fir_core -reconfig_module firv2 -implement
launch_runs config_2 -jobs 8
wait_on_run config_2
#create and implement third configuration
create_run config_3 -flow {ISE 14} -strategy {ISE Defaults}
config_partition -run config_3 -import -import_dir ./dpr_demo/dpr_demo.promote/Xconfig_1 -preservation routing
config_partition -run config_3 -cell prc.fir_ex/fir_core -reconfig_module fir_bb -implement
launch_runs config_3 -jobs 8
wait_on_run config_3
#verify configurations
verify_config -runs {config_1 config_2 config_3} -file ./dpr_demo/pr_verify.log
#generate full and partial bitstreams for the three configurations
set_property steps.bitgen.args.d true [get_runs config_1]
set_property steps.bitgen.args.b true [get_runs config_1]
set_property steps.bitgen.args.m true [get_runs config_1]
launch_runs config_1 -to_step Bitgen -jobs 8
wait_on_run config_1
set_property steps.bitgen.args.d true [get_runs config_2]
set_property steps.bitgen.args.b true [get_runs config_2]
set_property steps.bitgen.args.m true [get_runs config_2]
launch_runs config_2 -to_step Bitgen -jobs 8
wait_on_run config_2
set_property steps.bitgen.args.d true [get_runs config_3]
set_property steps.bitgen.args.b true [get_runs config_3]
set_property steps.bitgen.args.m true [get_runs config_3]
launch_runs config_3 -to_step Bitgen -jobs 8
wait_on_run config_3
close_project
exit
