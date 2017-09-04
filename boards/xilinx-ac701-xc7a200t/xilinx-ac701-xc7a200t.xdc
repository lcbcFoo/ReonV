# Define and contraint system clock
create_clock -period 5.000 -name clk200 [get_ports clk200p]
set_propagated_clock [get_clocks clk200]

# --- Clock Domain Crossings

# --- False paths
set_false_path -to   [get_ports {led[*]}]
set_false_path -from [get_ports {button[*]}]
set_false_path -from [get_ports reset]
set_false_path -from [get_ports switch*]

# --- SPI FLASH
set_input_delay   -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000 [get_ports spi_sel_n]
#set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports spi_clk  ]
set_input_delay   -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000 [get_ports spi_miso ]
set_output_delay  -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports spi_mosi ]

# --- SDCARD FLASH
set_input_delay  -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000 [get_ports sdcard_spi_cs_b ]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports sdcard_spi_clk  ]
set_input_delay  -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 2.000 [get_ports sdcard_spi_miso ]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 1.000 [get_ports sdcard_spi_mosi ]

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
# N/A

# --- I2C
# BiDir
set_input_delay  -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000             [get_ports iic_scl*]
set_input_delay  -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay 1.000  [get_ports iic_scl*]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max -add_delay 1.000  [get_ports iic_scl*]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports iic_scl*]
set_input_delay  -clock [get_clocks -include_generated_clocks CLKFBOUT] -max 3.000             [get_ports iic_sda*]
set_input_delay  -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay 1.000  [get_ports iic_sda*]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -max -add_delay 1.000  [get_ports iic_sda*]
set_output_delay -clock [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay -1.000 [get_ports iic_sda*]

#-----------------------------------------------------------
#              Ethernet / GMII                            -
#-----------------------------------------------------------

# The RGMII receive interface requirement allows a 1ns setup and 1ns hold - this is met but only just so constraints are relaxed
#set_input_delay -clock [get_clocks ac701_ethernet_rgmii_rgmii_rx_clk] -max -1.5 [get_ports {rgmii_rxd[*] rgmii_rx_ctl}]
#set_input_delay -clock [get_clocks ac701_ethernet_rgmii_rgmii_rx_clk] -min -2.8 [get_ports {rgmii_rxd[*] rgmii_rx_ctl}]
#set_input_delay -clock [get_clocks ac701_ethernet_rgmii_rgmii_rx_clk] -clock_fall -max -1.5 -add_delay [get_ports {rgmii_rxd[*] rgmii_rx_ctl}]
#set_input_delay -clock [get_clocks ac701_ethernet_rgmii_rgmii_rx_clk] -clock_fall -min -2.8 -add_delay [get_ports {rgmii_rxd[*] rgmii_rx_ctl}]

# the following properties can be adjusted if requried to adjuct the IO timing
# the value shown is the default used by the IP
# increasing this value will improve the hold timing but will also add jitter.
#set_property IDELAY_VALUE 12 [get_cells {trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_i/*/rgmii_interface/delay_rgmii_rx* trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_i/*/rgmii_interface/rxdata_bus[*].delay_rgmii_rx*}]

set_property IOSTANDARD LVCMOS18 [get_ports phy_*]
set_property IOSTANDARD LVDS_25  [get_ports gtrefclk_*]

set_property PACKAGE_PIN AA13 [get_ports gtrefclk_p]
set_property PACKAGE_PIN AB13 [get_ports gtrefclk_n]

set_property PACKAGE_PIN U22 [get_ports phy_txclk]
set_property PACKAGE_PIN T17 [get_ports {phy_txd[3]}]
set_property PACKAGE_PIN T18 [get_ports {phy_txd[2]}]
set_property PACKAGE_PIN U15 [get_ports {phy_txd[1]}]
set_property PACKAGE_PIN U16 [get_ports {phy_txd[0]}]
set_property PACKAGE_PIN T15 [get_ports phy_txctl_txen]

set_property PACKAGE_PIN V14 [get_ports {phy_rxd[3]}]
set_property PACKAGE_PIN V16 [get_ports {phy_rxd[2]}]
set_property PACKAGE_PIN V17 [get_ports {phy_rxd[1]}]
set_property PACKAGE_PIN U17 [get_ports {phy_rxd[0]}]
set_property PACKAGE_PIN U14 [get_ports phy_rxctl_rxdv]
set_property PACKAGE_PIN U21 [get_ports phy_rxclk]

set_property PACKAGE_PIN V18 [get_ports phy_reset]

set_property PACKAGE_PIN T14 [get_ports phy_mdio]
set_property PACKAGE_PIN W18 [get_ports phy_mdc]

# Clock select
# Should be set to constant '0' to get 125Mhz GTX clock
set_property PACKAGE_PIN B26     [get_ports {sfp_clock_mux[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sfp_clock_mux[0]}]
set_property PACKAGE_PIN C24     [get_ports {sfp_clock_mux[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sfp_clock_mux[1]}]

# The following are required to maximise setup/hold
set_property SLEW FAST [get_ports phy_tx*]

create_clock -period 8.000 -name phy_rxclk [get_ports phy_rxclk]
set_propagated_clock [get_clocks phy_rxclk]

#create_clock -period 8.000 -name phy_txclk [get_pins eth0.gtrefclk_pad/xcv.u0/*/O]
create_clock -period 8.000 -name phy_txclk [get_pins eth0.ibufds_gtrefclk/O]
set_propagated_clock [get_clocks phy_txclk]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets -of [get_pins eth0.ibufds_gtrefclk/O]]

# CDC
set_max_delay -datapath_only -from [all_registers -clock [get_clocks -include_generated_clocks clk200]    ] -to [all_registers -clock [get_clocks phy_rxclk]                           ] 8.000
set_max_delay -datapath_only -from [all_registers -clock [get_clocks -include_generated_clocks clk200]    ] -to [all_registers -clock [get_clocks -include_generated_clocks phy_txclk] ] 8.000
set_max_delay -datapath_only -from [all_registers -clock [get_clocks phy_rxclk]                           ] -to [all_registers -clock [get_clocks -include_generated_clocks clk200]    ] 8.000
set_max_delay -datapath_only -from [all_registers -clock [get_clocks -include_generated_clocks phy_txclk]]  -to [all_registers -clock [get_clocks -include_generated_clocks clk200]    ] 8.000

#set_false_path -from [get_clocks {CLKOUT0_1}] -to [get_clocks {CLKOUT1_1}]
#set_false_path -from [get_clocks {CLKOUT0_1}] -to [get_clocks {CLKOUT1_1}]

# Output MUX 
# Data and Control
## set_false_path -from [get_clocks -include_generated_clocks clk200] -through [get_ports phy_tx*] -to [get_clocks -include_generated_clocks phy_txclk]
## set_false_path -from [get_clocks -include_generated_clocks phy_txclk] -through [get_ports phy_tx*] -to [get_clocks -include_generated_clocks clk200]

# Outputs
#set_output_delay -clock [get_clocks -include_generated_clocks phy_txclk] -max 2.000 [get_ports phy_txd[*]]
#set_output_delay -clock [get_clocks -include_generated_clocks phy_txclk] -min 1.000 [get_ports phy_txd[*]]
#set_output_delay -clock [get_clocks -include_generated_clocks phy_txclk] -max 2.000 [get_ports phy_txd[*]] -add_delay -clock_fall
#set_output_delay -clock [get_clocks -include_generated_clocks phy_txclk] -min 1.000 [get_ports phy_txd[*]] -add_delay -clock_fall

#set_output_delay -clock [get_clocks -include_generated_clocks phy_txclk] -max  2.000 [get_ports phy_txctl_txen]
#set_output_delay -clock [get_clocks -include_generated_clocks phy_txclk] -min 1.000 [get_ports phy_txctl_txen]
#set_output_delay -clock [get_clocks -include_generated_clocks phy_txclk] -max 2.000 [get_ports phy_txctl_txen] -add_delay -clock_fall
#set_output_delay -clock [get_clocks -include_generated_clocks phy_txclk] -min 1.000 [get_ports phy_txctl_txen] -add_delay -clock_fall

#output timing for rgmii - derated slightly due to pessimism in the tools
create_generated_clock -name rgmii_tx_clk -divide_by 1 -source [get_pins eth0.rgmii0/*rgmii_tx_clk/*/*/C] [get_ports phy_txclk]

set_output_delay 0.75 -max -clock [get_clocks rgmii_tx_clk] [get_ports {phy_txd[*] phy_txctl_txen}]
set_output_delay -0.7 -min -clock [get_clocks rgmii_tx_clk] [get_ports {phy_txd[*] phy_txctl_txen}]
set_output_delay 0.75 -max -clock [get_clocks rgmii_tx_clk] [get_ports {phy_txd[*] phy_txctl_txen}] -clock_fall -add_delay
set_output_delay -0.7 -min -clock [get_clocks rgmii_tx_clk] [get_ports {phy_txd[*] phy_txctl_txen}] -clock_fall -add_delay


# Inputs
set_input_delay -clock [get_clocks phy_rxclk] -max 1.000 [get_ports {phy_rxd[*] phy_rxctl_rxdv}]
set_input_delay -clock [get_clocks phy_rxclk] -min 0.100 [get_ports {phy_rxd[*] phy_rxctl_rxdv}]
set_input_delay -clock [get_clocks phy_rxclk] -max 1.000 [get_ports {phy_rxd[*] phy_rxctl_rxdv}] -add_delay -clock_fall
set_input_delay -clock [get_clocks phy_rxclk] -min 0.100 [get_ports {phy_rxd[*] phy_rxctl_rxdv}] -add_delay -clock_fall

# False paths
set_false_path -to [get_ports phy_reset]

# MDIO BiDir
set_input_delay -clock  [get_clocks -include_generated_clocks CLKFBOUT] -max 5.000 [get_ports phy_mdio]
set_input_delay -clock  [get_clocks -include_generated_clocks CLKFBOUT] -min -add_delay 1.000 [get_ports phy_mdio]
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

# System Clock
set_property PACKAGE_PIN R3         [get_ports clk200p]
set_property PACKAGE_PIN P3         [get_ports clk200n]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk200p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk200n]
set_property VCCAUX_IO DONTCARE     [get_ports clk200p]
set_property VCCAUX_IO DONTCARE     [get_ports clk200n]

#set_property slave_banks {32 34} [get_iobanks 33]
#set_property DCI_CASCADE {32 34} [get_iobanks 33]

# Reset is set to CPU_RESET
set_property PACKAGE_PIN U4      [get_ports reset]
set_property IOSTANDARD LVCMOS15 [get_ports reset]

# --- SPI FLASH
set_property PACKAGE_PIN P18 [get_ports spi_sel_n]
#set_property PACKAGE_PIN H13 [get_ports spi_clk]
set_property PACKAGE_PIN R15 [get_ports spi_miso]
set_property PACKAGE_PIN R14 [get_ports spi_mosi]

set_property IOSTANDARD LVCMOS33 [get_ports spi_*]

# --- SPI SDCARD
set_property PACKAGE_PIN P21 [get_ports sdcard_spi_cs_b]
set_property PACKAGE_PIN N24 [get_ports sdcard_spi_clk]
set_property PACKAGE_PIN P19 [get_ports sdcard_spi_miso]
set_property PACKAGE_PIN N23 [get_ports sdcard_spi_mosi]

set_property IOSTANDARD LVCMOS33 [get_ports sdcard_spi_*]

# UART - Checked
set_property PACKAGE_PIN T19 [get_ports dsutx]
set_property PACKAGE_PIN W19 [get_ports dsuctsn]
set_property PACKAGE_PIN U19 [get_ports dsurx]
set_property PACKAGE_PIN V19 [get_ports dsurtsn]

set_property IOSTANDARD LVCMOS18 [get_ports dsu*]

# Buttons
set_property PACKAGE_PIN P6 [get_ports {button[0]}]
set_property PACKAGE_PIN T5 [get_ports {button[1]}]
set_property PACKAGE_PIN R5 [get_ports {button[2]}]
set_property PACKAGE_PIN U6 [get_ports {button[3]}]

set_property IOSTANDARD LVCMOS15 [get_ports {button[0]}]
set_property IOSTANDARD SSTL15   [get_ports {button[1]}]
set_property IOSTANDARD SSTL15   [get_ports {button[2]}]
set_property IOSTANDARD SSTL15   [get_ports {button[3]}]

# LED Interface
set_property PACKAGE_PIN M26 [get_ports {led[0]}]
set_property PACKAGE_PIN T24 [get_ports {led[1]}]
set_property PACKAGE_PIN T25 [get_ports {led[2]}]
set_property PACKAGE_PIN R26 [get_ports {led[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports led*]

# Switches
set_property PACKAGE_PIN R8  [get_ports {switch[0]}]
set_property PACKAGE_PIN P8  [get_ports {switch[1]}]
set_property PACKAGE_PIN R7  [get_ports {switch[2]}]
set_property PACKAGE_PIN R6  [get_ports {switch[3]}]

set_property IOSTANDARD SSTL15 [get_ports switch*]

# I2C
set_property PACKAGE_PIN N18 [get_ports iic_scl]
set_property PACKAGE_PIN K25 [get_ports iic_sda]

set_property IOSTANDARD LVCMOS33 [get_ports iic*]

