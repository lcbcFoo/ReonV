#set_property PACKAGE_PIN T22 [get_ports {led[0]}]

set_property PACKAGE_PIN P17 [get_ports {led[7]}]
set_property PACKAGE_PIN P18 [get_ports {led[6]}]
set_property PACKAGE_PIN W10 [get_ports {led[5]}]
set_property PACKAGE_PIN V7 [get_ports {led[4]}]
set_property PACKAGE_PIN W5 [get_ports {led[3]}]
set_property PACKAGE_PIN W17 [get_ports {led[2]}]
set_property PACKAGE_PIN D15 [get_ports {led[1]}]
set_property PACKAGE_PIN E15 [get_ports {led[0]}]

set_property IOSTANDARD LVCMOS18 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[0]}]

#LEFT btn
set_property PACKAGE_PIN G19 [get_ports {button[0]}] 
#RIGHT btn
set_property PACKAGE_PIN F19 [get_ports {button[1]}]

set_property PACKAGE_PIN J18 [get_ports {button[2]}] 
set_property PACKAGE_PIN K18 [get_ports {button[3]}] 

set_property PACKAGE_PIN N19 [get_ports {switch[0]}]
set_property PACKAGE_PIN N20 [get_ports {switch[1]}]
set_property PACKAGE_PIN N17 [get_ports {switch[2]}]
set_property PACKAGE_PIN N18 [get_ports {switch[3]}]
set_property PACKAGE_PIN M15 [get_ports {switch[4]}]
set_property PACKAGE_PIN M16 [get_ports {switch[5]}]
set_property PACKAGE_PIN P16 [get_ports {switch[6]}]
set_property PACKAGE_PIN R16 [get_ports {switch[7]}]

#create_clock -name clk100 -period 10.0 [get_ports gclk]
set_false_path -from  [get_clocks clk_fpga_0] -to [get_clocks clk_fpga_1]
set_false_path -from  [get_clocks clk_fpga_1] -to [get_clocks clk_fpga_0]
