#################################################################################
# LEON3-ASIC Create reports scripts
#
# This file generates the following reports and files:
#
# 1. Timing
#      General Timing
#      SPW IO timing
#      JTAG
#      UART
#      I2C
#      SPI
#      GPIO
#      DSU
#      MCTRL
#      Clock Domain Crossings
# 2. Area
#      General Area
# 3. Power
#      Test Case power report
# 4. Clock Gating
#      Clock gating status and coverage
# 5. Constraint checks
# 6. Design DRC Violations
# 7. Case Analysis in design
#
#################################################################################

#################################################################################
# Report setup for Leon3 ASIC Ref Design
#################################################################################

# Select to use scan mode
if { ![info exists use_scan_clk] } {
  echo "Info: Normal Functional mode clocks"
  set use_scan_clk 0
} else {
  if { $use_scan_clk == 0 } {
     echo "Info: Normal Functional mode clocks"
  } else { 
     echo "Info: Scan mode clocks"
  }
}

# Select to ignore io timing (only use for debug and area)
if { ![info exists ignore_io_timing] } {
  set ignore_io_timing 0
} else {
  if { $ignore_io_timing == 1 } {
    echo "Warning: No IO Constraints set for the design"
  }
}

### create dir
sh mkdir -p synopsys/$report_run
set report_dir synopsys/$report_run

#################################################################################
# Start Report timing for Leon3 ASIC Ref Design
#################################################################################

### Report Quality of Result
echo "Info: Generate QoR Reports"
report_qor -summary > $report_dir/qor_$report_run.log

### Check for Design Errors
echo "Info: Generate Design Error Reports"
check_design -summary > $report_dir/check_design_$report_run.log

### Check Clock gating in design
echo "Info: Generate Clock Gate Reports"
report_clock_gating -multi_stage -nosplit > $report_dir/clockgate_$report_run.log

### General timing report
echo "Info: Generate General Timing Reports"
report_timing -transition_time -capacitance -nosplit -delay max > $report_dir/timing_$report_run.log
report_timing -transition_time -capacitance -nosplit -delay min >> $report_dir/timing_$report_run.log

### IO timing
if { $ignore_io_timing == 0 } {
 echo "Info: Generate IO Timing Reports"
 
 # SPW CMOS interface
 echo "Info: Generate SPW CMOS IO Timing Reports"
 for { set port 0 } { $port <= 2 } { incr port } {
    report_timing -transition_time -capacitance -nosplit -unique -to   [get_ports spw_txd[$port]] -delay max >  $report_dir/spw_port_${port}_${report_run}.log
    report_timing -transition_time -capacitance -nosplit -unique -from [get_ports spw_rxd[$port]] -delay max >> $report_dir/spw_port_${port}_${report_run}.log
    report_timing -transition_time -capacitance -nosplit -unique -to   [get_ports spw_txs[$port]] -delay max >> $report_dir/spw_port_${port}_${report_run}.log
    report_timing -transition_time -capacitance -nosplit -unique -from [get_ports spw_rxs[$port]] -delay max >> $report_dir/spw_port_${port}_${report_run}.log
    report_timing -transition_time -capacitance -nosplit -unique -to   [get_ports spw_txd[$port]] -delay min >> $report_dir/spw_port_${port}_${report_run}.log
    report_timing -transition_time -capacitance -nosplit -unique -from [get_ports spw_rxd[$port]] -delay min >> $report_dir/spw_port_${port}_${report_run}.log
    report_timing -transition_time -capacitance -nosplit -unique -to   [get_ports spw_txs[$port]] -delay min >> $report_dir/spw_port_${port}_${report_run}.log
    report_timing -transition_time -capacitance -nosplit -unique -from [get_ports spw_rxs[$port]] -delay min >> $report_dir/spw_port_${port}_${report_run}.log
 }
 
 # JTAG
 echo "Info: Generate JTAG IO Timing Reports"
 report_timing -transition_time -capacitance -nosplit -to   [get_ports tdo] >  $report_dir/jtag_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports tck] >> $report_dir/jtag_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports tms] >> $report_dir/jtag_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports tdi] >> $report_dir/jtag_$report_run.log
 
 # UART
 echo "Info: Generate UART IO Timing Reports"
 report_timing -transition_time -capacitance -nosplit -to   [get_ports txd1] >  $report_dir/uart1_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports rxd1] >> $report_dir/uart1_$report_run.log
 report_timing -transition_time -capacitance -nosplit -to   [get_ports txd2] >  $report_dir/uart2_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports rxd2] >> $report_dir/uart2_$report_run.log
 
 ### I2C
 echo "Info: Generate I2C IO Timing Reports"
 report_timing -transition_time -capacitance -nosplit -to   [get_ports i2c_scl] >  $report_dir/i2c_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports i2c_scl] >> $report_dir/i2c_$report_run.log
 report_timing -transition_time -capacitance -nosplit -to   [get_ports i2c_sda] >> $report_dir/i2c_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports i2c_sda] >> $report_dir/i2c_$report_run.log
 
 # SPI
 echo "Info: Generate SPI IO Timing Reports"
 report_timing -transition_time -capacitance -nosplit -from [get_ports spi_miso  ] >  $report_dir/spi_$report_run.log
 report_timing -transition_time -capacitance -nosplit -to   [get_ports spi_mosi  ] >> $report_dir/spi_$report_run.log
 report_timing -transition_time -capacitance -nosplit -to   [get_ports spi_sck   ] >> $report_dir/spi_$report_run.log
 report_timing -transition_time -capacitance -nosplit -to   [get_ports spi_slvsel] >> $report_dir/spi_$report_run.log
 
 # GPIO
 echo "Info: Generate GPIO IO Timing Reports"
 report_timing -transition_time -capacitance -nosplit -to   [get_ports gpio[0]] >  $report_dir/gpio_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports gpio[0]] >> $report_dir/gpio_$report_run.log
 for { set port 1 } { $port <= 15 } { incr port } {
    report_timing -transition_time -capacitance -nosplit -to   [get_ports gpio[$port]] >> $report_dir/gpio_$report_run.log
    report_timing -transition_time -capacitance -nosplit -from [get_ports gpio[$port]] >> $report_dir/gpio_$report_run.log
 }
 
 ### DSU
 echo "Info: Generate DSU IO Timing Reports"
 report_timing -transition_time -capacitance -nosplit -to   [get_ports dsutx]  >  $report_dir/dsu_$report_run.log
 report_timing -transition_time -capacitance -nosplit -to   [get_ports dsuact] >> $report_dir/dsu_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports dsurx]  >> $report_dir/dsu_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports dsuen]  >> $report_dir/dsu_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports dsubre] >> $report_dir/dsu_$report_run.log
 
 ### PROM/SRAM/SDRAM Interface
 echo "Info: Generate MCTRL IO Timing Reports"
 report_timing -transition_time -capacitance -nosplit -to   [get_ports sdclk  ] >  $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports data   ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports cb     ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -to   [get_ports data   ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -to   [get_ports cb     ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports brdyn  ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports bexcn  ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports address] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports sdcsn  ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports sdwen  ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports sdrasn ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports sdcasn ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports sddqm  ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports ramsn  ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports ramoen ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports rwen   ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports oen    ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports writen ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports read   ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports iosn   ] >> $report_dir/mctrl_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [get_ports romsn  ] >> $report_dir/mctrl_$report_run.log
}

### Check clock domain crossings
echo "Info: Generate Clock Domain Crossings Timing Reports"
if { $use_scan_clk == 0 } {
 echo "Info: Check clock domain crossings"
 report_timing -transition_time -capacitance -nosplit -from [all_registers -clock clk       -clock_pins] -to [all_registers -clock spwclk    -data_pins] >  $report_dir/cdc_spw_paths_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [all_registers -clock spwclk    -clock_pins] -to [all_registers -clock clk       -data_pins] >  $report_dir/cdc_spw_paths_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [all_registers -clock clk       -clock_pins] -to [all_registers -clock tck       -data_pins] >> $report_dir/cdc_jtag_paths_$report_run.log
 report_timing -transition_time -capacitance -nosplit -from [all_registers -clock tck       -clock_pins] -to [all_registers -clock clk       -data_pins] >> $report_dir/cdc_jtag_paths_$report_run.log
}

### Area
echo "Info: Check Design Area"
report_area -all       > $report_dir/area_all_$report_run.log
report_area -hierarchy > $report_dir/area_hier_$report_run.log

### Clock gating
echo "Info: Check Clock Gating"
report_clock_gating -style -multi_stage -ungated > $report_dir/clockgating_$report_run.log

### Constraints
echo "Info: Check constraints"
report_constraints -all_violators > $report_dir/check_constraints_$report_run.log

### Check design
echo "Info: Check Design"
check_design > $report_dir/check_design_$report_run.log

### Report dont touch nets
report_dont_touch > $report_dir/dont_touch_$report_run.log

### Report size only cells
report_size_only  > $report_dir/size_only_$report_run.log

### Summary report of the design and cells used etc
report_design > $report_dir/report_design_$report_run.log

### Report blocks instantiated etc.
report_reference -hierarchy > $report_dir/report_reference_$report_run.log

### Checks for possible timing problems in the current design.
check_timing -include {unconstrained_endpoints} > $report_dir/check_timing_$report_run.log

### Displays minimum pulse width check information about specified sequential device clock pins.
report_min_pulse_width -all_violators  > $report_dir/report_min_pulse_width_$report_run.log

### Case analysis
#   - Writes sdc files for case analysis in PrimeTime
#   - Only test for worst paths.
#   - SCAN test case anlysis has been moved to external script to be able to create new timing constrints for scan.

# TODO