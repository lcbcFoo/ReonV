
# Script to build Zynq stub and export files for EDK/SDK
# Jiri Gaisler 2014-04-05

set_property target_language VHDL [current_project]
source {leon3_zc702_stub.tcl}
generate_target all [get_files  vivado/leon3-zc702/leon3-zc702.srcs/sources_1/bd/leon3_zc702_stub/leon3_zc702_stub.bd]
make_wrapper -files [get_files vivado/leon3-zc702/leon3-zc702.srcs/sources_1/bd/leon3_zc702_stub/leon3_zc702_stub.bd] -top
add_files -norecurse vivado/leon3-zc702/leon3-zc702.srcs/sources_1/bd/leon3_zc702_stub/hdl/leon3_zc702_stub_wrapper.vhd
update_compile_order -fileset sources_1
export_hardware [get_files vivado/leon3-zc702/leon3-zc702.srcs/sources_1/bd/leon3_zc702_stub/leon3_zc702_stub.bd] 
