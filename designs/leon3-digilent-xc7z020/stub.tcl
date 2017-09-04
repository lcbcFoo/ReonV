
# Script to build Zynq stub and export files for EDK/SDK
# Jiri Gaisler 2014-04-05

set_property target_language VHDL [current_project]
source {leon3_zedboard_stub.tcl}
generate_target all [get_files  vivado/leon3-zedboard-xc7z020/leon3-zedboard-xc7z020.srcs/sources_1/bd/leon3_zedboard_stub/leon3_zedboard_stub.bd]
make_wrapper -files [get_files vivado/leon3-zedboard-xc7z020/leon3-zedboard-xc7z020.srcs/sources_1/bd/leon3_zedboard_stub/leon3_zedboard_stub.bd] -top
add_files -norecurse vivado/leon3-zedboard-xc7z020/leon3-zedboard-xc7z020.srcs/sources_1/bd/leon3_zedboard_stub/hdl/leon3_zedboard_stub_wrapper.vhd
update_compile_order -fileset sources_1
export_hardware [get_files vivado/leon3-zedboard-xc7z020/leon3-zedboard-xc7z020.srcs/sources_1/bd/leon3_zedboard_stub/leon3_zedboard_stub.bd]
