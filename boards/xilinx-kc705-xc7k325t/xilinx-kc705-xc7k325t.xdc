# Define and contraint system clock
create_clock -period 5.000 -name clk200 [get_ports clk200p]
set_propagated_clock [get_clocks clk200]

# --- Clock Domain Crossings

# --- False paths
set_false_path -to [get_ports {led[*]}]
set_false_path -from [get_ports {button[*]}]
set_false_path -from [get_ports reset]
set_false_path -from [get_ports switch*]
set_false_path -to [get_ports switch*]

# --- Flash
# Outputs
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports oen]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports oen]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports writen]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports writen]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports romsn]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports romsn]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports adv]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports adv]

# --- SPI FLASH
set_input_delay   -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000 [get_ports spi_sel_n]
#set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports spi_clk  ]
set_input_delay   -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000 [get_ports spi_miso ]
set_output_delay  -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports spi_mosi ]

# BiDir
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000 [get_ports data*]
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay 1.000 [get_ports data*]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max -add_delay 1.000 [get_ports data*]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports data*]

# --- UART
# Inputs
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000 [get_ports dsurx]
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay 1.000 [get_ports dsurx]
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000 [get_ports dsuctsn]
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay 1.000 [get_ports dsuctsn]

# Outputs
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports dsutx]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports dsutx]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports dsurtsn]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports dsurtsn]

# --- JTAG
# TBD....

# --- I2C
# BiDir
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000 [get_ports iic_scl*]
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay 1.000 [get_ports iic_scl*]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max -add_delay 1.000 [get_ports iic_scl*]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports iic_scl*]
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000 [get_ports iic_sda*]
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay 1.000 [get_ports iic_sda*]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max -add_delay 1.000 [get_ports iic_sda*]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports iic_sda*]

#-----------------------------------------------------------
#              Ethernet / GMII                            -
#-----------------------------------------------------------

set_property IOSTANDARD LVCMOS25 [get_ports phy_tx*]
set_property IOSTANDARD LVCMOS25 [get_ports phy_rx*]
set_property IOSTANDARD LVCMOS25 [get_ports phy_m*]
set_property IOSTANDARD LVCMOS25 [get_ports phy_c*]
set_property IOSTANDARD LVCMOS25 [get_ports phy_int]

set_property PACKAGE_PIN G8 [get_ports gtrefclk_p]
set_property PACKAGE_PIN G7 [get_ports gtrefclk_n]

set_property PACKAGE_PIN K30 [get_ports phy_gtxclk]
set_property PACKAGE_PIN L28 [get_ports {phy_txd[3]}]
set_property PACKAGE_PIN M29 [get_ports {phy_txd[2]}]
set_property PACKAGE_PIN N25 [get_ports {phy_txd[1]}]
set_property PACKAGE_PIN N27 [get_ports {phy_txd[0]}]
set_property PACKAGE_PIN M27 [get_ports phy_txctl_txen]

set_property PACKAGE_PIN U28 [get_ports {phy_rxd[3]}]
set_property PACKAGE_PIN T25 [get_ports {phy_rxd[2]}]
set_property PACKAGE_PIN U25 [get_ports {phy_rxd[1]}]
set_property PACKAGE_PIN U30 [get_ports {phy_rxd[0]}]
set_property PACKAGE_PIN R28 [get_ports phy_rxctl_rxdv]
set_property PACKAGE_PIN U27 [get_ports phy_rxclk]

set_property PACKAGE_PIN L20 [get_ports phy_reset]

set_property PACKAGE_PIN J21 [get_ports phy_mdio]
set_property PACKAGE_PIN R23 [get_ports phy_mdc]
set_property PACKAGE_PIN N30 [get_ports phy_int]

# The following are required to maximise setup/hold
set_property SLEW FAST [get_ports phy_tx*]

create_clock -period 8.000 -name phy_rxclk [get_ports phy_rxclk]
set_propagated_clock [get_clocks phy_rxclk]

#create_clock -period 8.000 -name phy_gtxclk [get_pins eth0.gtrefclk_pad/xcv.u0/*/O]
create_clock -period 8.000 -name phy_gtxclk [get_pins eth0.ibufds_gtrefclk/O]
set_propagated_clock [get_clocks phy_gtxclk]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets -of [get_pins eth0.ibufds_gtrefclk/O]]

# CDC
set_max_delay -datapath_only -from [all_registers -clock [get_clocks -include_generated_clocks clk200]    ] -to [all_registers -clock [get_clocks phy_rxclk]                           ] 8.000
set_max_delay -datapath_only -from [all_registers -clock [get_clocks -include_generated_clocks clk200]    ] -to [all_registers -clock [get_clocks -include_generated_clocks phy_gtxclk]] 8.000
set_max_delay -datapath_only -from [all_registers -clock [get_clocks phy_rxclk]                           ] -to [all_registers -clock [get_clocks -include_generated_clocks clk200]    ] 8.000
set_max_delay -datapath_only -from [all_registers -clock [get_clocks -include_generated_clocks phy_gtxclk]] -to [all_registers -clock [get_clocks -include_generated_clocks clk200]    ] 8.000

# Output MUX 
# Data and Control
## set_false_path -from [get_clocks -include_generated_clocks clk200] -through [get_ports phy_tx*] -to [get_clocks -include_generated_clocks phy_gtxclk]
## set_false_path -from [get_clocks -include_generated_clocks phy_gtxclk] -through [get_ports phy_tx*] -to [get_clocks -include_generated_clocks clk200]

# Outputs
#set_output_delay -clock [get_clocks -include_generated_clocks phy_gtxclk] -max 2.000 [get_ports phy_txd[*]]
#set_output_delay -clock [get_clocks -include_generated_clocks phy_gtxclk] -min 1.000 [get_ports phy_txd[*]]
#set_output_delay -clock [get_clocks -include_generated_clocks phy_gtxclk] -max 2.000 [get_ports phy_txd[*]] -add_delay -clock_fall
#set_output_delay -clock [get_clocks -include_generated_clocks phy_gtxclk] -min 1.000 [get_ports phy_txd[*]] -add_delay -clock_fall

#set_output_delay -clock [get_clocks -include_generated_clocks phy_gtxclk] -max 2.000 [get_ports phy_txctl_txen]
#set_output_delay -clock [get_clocks -include_generated_clocks phy_gtxclk] -min 1.000 [get_ports phy_txctl_txen]
#set_output_delay -clock [get_clocks -include_generated_clocks phy_gtxclk] -max 2.000 [get_ports phy_txctl_txen] -add_delay -clock_fall
#set_output_delay -clock [get_clocks -include_generated_clocks phy_gtxclk] -min 1.000 [get_ports phy_txctl_txen] -add_delay -clock_fall

#output timing for rgmii - derated slightly due to pessimism in the tools
create_generated_clock -name rgmii_tx_clk -divide_by 1 -source [get_pins eth0.rgmii0/*rgmii_tx_clk/*/*/C] [get_ports phy_gtxclk]

set_output_delay 0.75 -max -clock [get_clocks rgmii_tx_clk] [get_ports {phy_txd[*] phy_txctl_txen}]
set_output_delay -0.7 -min -clock [get_clocks rgmii_tx_clk] [get_ports {phy_txd[*] phy_txctl_txen}]
set_output_delay 0.75 -max -clock [get_clocks rgmii_tx_clk] [get_ports {phy_txd[*] phy_txctl_txen}] -clock_fall -add_delay
set_output_delay -0.7 -min -clock [get_clocks rgmii_tx_clk] [get_ports {phy_txd[*] phy_txctl_txen}] -clock_fall -add_delay

# Inputs
set_input_delay -clock [get_clocks phy_rxclk] -max 1.000 [get_ports {phy_rxd[*] phy_rxctl_rxdv}]
set_input_delay -clock [get_clocks phy_rxclk] -min 0.000 [get_ports {phy_rxd[*] phy_rxctl_rxdv}]
set_input_delay -clock [get_clocks phy_rxclk] -max 1.000 [get_ports {phy_rxd[*] phy_rxctl_rxdv}] -add_delay -clock_fall
set_input_delay -clock [get_clocks phy_rxclk] -min 0.000 [get_ports {phy_rxd[*] phy_rxctl_rxdv}] -add_delay -clock_fall

# False paths
set_false_path -to [get_ports phy_reset]
#set_false_path -from [get_ports phy_col]
#set_false_path -from [get_ports phy_crs]
set_false_path -from [get_ports phy_int]

# MDIO BiDir
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 5.000 [get_ports phy_mdio]
set_input_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay 1.000 [get_ports phy_mdio]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max -add_delay 1.000 [get_ports phy_mdio]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports phy_mdio]

# MDIO - Outputs
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports phy_mdc]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports phy_mdc]

# apply the same IDELAY_VALUE to all GMII RX inputs
#set_property IDELAY_VALUE 20 [get_cells {eth0.delay* eth0.rgmii*.delay*}]

# Group IODELAY and IDELAYCTRL components to aid placement
set_property IODELAY_GROUP kc705_ethernet_rgmii_grp1 [get_cells {eth0.delay* eth0.rgmii*.delay*}]
set_property IODELAY_GROUP kc705_ethernet_rgmii_grp1 [get_cells {eth0.dlyctrl0}]


#-----------------------------------------------------------
# Pins etc.
#-----------------------------------------------------------

set_property PACKAGE_PIN AD12 [get_ports clk200p]
set_property PACKAGE_PIN AD11 [get_ports clk200n]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk200p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk200n]
set_property VCCAUX_IO DONTCARE [get_ports clk200p]
set_property VCCAUX_IO DONTCARE [get_ports clk200n]

#set_property slave_banks {32 34} [get_iobanks 33]
set_property DCI_CASCADE {32 34} [get_iobanks 33]

# Reset is set to GPIO_SW_E
set_property PACKAGE_PIN AG5 [get_ports reset]

set_property PACKAGE_PIN AB8 [get_ports {led[0]}]
set_property PACKAGE_PIN AA8 [get_ports {led[1]}]
set_property PACKAGE_PIN AC9 [get_ports {led[2]}]
set_property PACKAGE_PIN AB9 [get_ports {led[3]}]
set_property PACKAGE_PIN AE26 [get_ports {led[4]}]
set_property PACKAGE_PIN G19 [get_ports {led[5]}]
set_property PACKAGE_PIN E18 [get_ports {led[6]}]

set_property IOSTANDARD LVCMOS15 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {led[6]}]

set_property PACKAGE_PIN P24 [get_ports {data[0]}]
set_property PACKAGE_PIN R25 [get_ports {data[1]}]
set_property PACKAGE_PIN R20 [get_ports {data[2]}]
set_property PACKAGE_PIN R21 [get_ports {data[3]}]
set_property PACKAGE_PIN T20 [get_ports {data[4]}]
set_property PACKAGE_PIN T21 [get_ports {data[5]}]
set_property PACKAGE_PIN T22 [get_ports {data[6]}]
set_property PACKAGE_PIN T23 [get_ports {data[7]}]
set_property PACKAGE_PIN U20 [get_ports {data[8]}]
set_property PACKAGE_PIN P29 [get_ports {data[9]}]
set_property PACKAGE_PIN R29 [get_ports {data[10]}]
set_property PACKAGE_PIN P27 [get_ports {data[11]}]
set_property PACKAGE_PIN P28 [get_ports {data[12]}]
set_property PACKAGE_PIN T30 [get_ports {data[13]}]
set_property PACKAGE_PIN P26 [get_ports {data[14]}]
set_property PACKAGE_PIN R26 [get_ports {data[15]}]

set_property IOSTANDARD LVCMOS25 [get_ports data*]

set_property PACKAGE_PIN M22 [get_ports {address[25]}]
set_property PACKAGE_PIN M23 [get_ports {address[24]}]
set_property PACKAGE_PIN N26 [get_ports {address[23]}]
set_property PACKAGE_PIN N19 [get_ports {address[22]}]
set_property PACKAGE_PIN N20 [get_ports {address[21]}]
set_property PACKAGE_PIN N21 [get_ports {address[20]}]
set_property PACKAGE_PIN N22 [get_ports {address[19]}]
set_property PACKAGE_PIN N24 [get_ports {address[18]}]
set_property PACKAGE_PIN P21 [get_ports {address[17]}]
set_property PACKAGE_PIN P22 [get_ports {address[16]}]
set_property PACKAGE_PIN V27 [get_ports {address[15]}]
set_property PACKAGE_PIN V29 [get_ports {address[14]}]
set_property PACKAGE_PIN V30 [get_ports {address[13]}]
set_property PACKAGE_PIN V25 [get_ports {address[12]}]
set_property PACKAGE_PIN W26 [get_ports {address[11]}]
set_property PACKAGE_PIN V19 [get_ports {address[10]}]
set_property PACKAGE_PIN V20 [get_ports {address[9]}]
set_property PACKAGE_PIN W23 [get_ports {address[8]}]
set_property PACKAGE_PIN W24 [get_ports {address[7]}]
set_property PACKAGE_PIN U23 [get_ports {address[6]}]
set_property PACKAGE_PIN V21 [get_ports {address[5]}]
set_property PACKAGE_PIN V22 [get_ports {address[4]}]
set_property PACKAGE_PIN U24 [get_ports {address[3]}]
set_property PACKAGE_PIN V24 [get_ports {address[2]}]
set_property PACKAGE_PIN W21 [get_ports {address[1]}]
set_property PACKAGE_PIN W22 [get_ports {address[0]}]

set_property IOSTANDARD LVCMOS25 [get_ports address*]

set_property PACKAGE_PIN M30 [get_ports adv]
set_property PACKAGE_PIN U19 [get_ports romsn]
set_property PACKAGE_PIN M24 [get_ports oen]
set_property PACKAGE_PIN M25 [get_ports writen]

set_property IOSTANDARD LVCMOS25 [get_ports adv]
set_property IOSTANDARD LVCMOS25 [get_ports romsn]
set_property IOSTANDARD LVCMOS25 [get_ports oen]
set_property IOSTANDARD LVCMOS25 [get_ports writen]

set_property PACKAGE_PIN K24 [get_ports dsutx]
set_property PACKAGE_PIN K23 [get_ports dsuctsn]
set_property PACKAGE_PIN M19 [get_ports dsurx]
set_property PACKAGE_PIN L27 [get_ports dsurtsn]

set_property IOSTANDARD LVCMOS25 [get_ports dsu*]

set_property PACKAGE_PIN G12 [get_ports {button[0]}]
set_property PACKAGE_PIN AA12 [get_ports {button[1]}]
set_property PACKAGE_PIN AB12 [get_ports {button[2]}]
set_property PACKAGE_PIN AC6 [get_ports {button[3]}]

set_property IOSTANDARD LVCMOS15 [get_ports button*]
set_property IOSTANDARD LVCMOS25 [get_ports {button[0]}]

set_property PACKAGE_PIN Y28 [get_ports {switch[0]}]
set_property PACKAGE_PIN AA28 [get_ports {switch[1]}]
set_property PACKAGE_PIN W29 [get_ports {switch[2]}]
set_property PACKAGE_PIN Y29 [get_ports {switch[3]}]

set_property IOSTANDARD LVCMOS25 [get_ports switch*]

set_property PACKAGE_PIN K21 [get_ports iic_scl]
set_property PACKAGE_PIN L21 [get_ports iic_sda]

set_property IOSTANDARD LVCMOS25 [get_ports iic*]

# --- SPI FLASH
# Use same pins as FLASH

