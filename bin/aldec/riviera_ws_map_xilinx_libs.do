workspace.open riviera_ws/riviera_ws.rwsp
workspace.design.setactive techmap
amap secureip_ver ../xilinx_lib/secureip
amap secureip ../xilinx_lib/secureip
amap axi_bfm ../xilinx_lib/secureip
amap unisims_ver ../xilinx_lib/unisims_ver
amap unisim ../xilinx_lib/unisim
amap unimacro_ver ../xilinx_lib/unimacro_ver
amap unimacro ../xilinx_lib/unimacro
amap simprim_ver ../xilinx_lib/simprims_ver
amap simprim ../xilinx_lib/simprims
amap unifast_ver ../xilinx_lib/unifast_ver
amap unifast ../xilinx_lib/unifast_ver
# Do the map for gaisler lib as well since mig is compiled into it
workspace.design.setactive gaisler
amap secureip_ver ../xilinx_lib/secureip
amap secureip ../xilinx_lib/secureip
amap axi_bfm ../xilinx_lib/secureip
amap unisims_ver ../xilinx_lib/unisims_ver
amap unisim ../xilinx_lib/unisim
amap unimacro_ver ../xilinx_lib/unimacro_ver
amap unimacro ../xilinx_lib/unimacro
amap simprim_ver ../xilinx_lib/simprims_ver
amap simprim ../xilinx_lib/simprims
amap unifast_ver ../xilinx_lib/unifast_ver
amap unifast ../xilinx_lib/unifast_ver
workspace.design.setactive work
amap secureip_ver ../xilinx_lib/secureip
amap secureip ../xilinx_lib/secureip
amap axi_bfm ../xilinx_lib/secureip
amap unisims_ver ../xilinx_lib/unisims_ver
amap unisim ../xilinx_lib/unisim
amap unimacro_ver ../xilinx_lib/unimacro_ver
amap unimacro ../xilinx_lib/unimacro
amap simprim_ver ../xilinx_lib/simprims_ver
amap simprim ../xilinx_lib/simprims
amap unifast_ver ../xilinx_lib/unifast_ver
amap unifast ../xilinx_lib/unifast_ver
quit