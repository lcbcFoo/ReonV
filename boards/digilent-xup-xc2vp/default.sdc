# Synplicity, Inc. constraint file
# C:\work\LEON\grlib-gpl-1.0.10-b1640\boards\xilinx-xup\default.sdc
# Written on Thu Sep 14 18:31:40 2006
# by Synplify Premier with Design Planner, Synplify Premier with Design Planner 8.6.2 Scope Editor

#
# Collections
#

#
# Clocks
#
define_clock            -name {clk}  -freq 100.000 -clockgroup clkgroup_clk
define_clock            -name {etx_clk}  -period 40.000 -clockgroup clkgroup_etx_clk -rise 0.000 -fall 14.000
define_clock            -name {erx_clk}  -period 40.000 -clockgroup clkgroup_erx_clk -rise 0.000 -fall 14.000
define_clock            -name {n:clkm}  -freq 50.000 -clockgroup main_clkgroup
define_clock            -name {n:ddrclk0}  -freq 100.000 -clockgroup ddr_clkgroup -rise 0.000 -fall 5.000
define_clock            -name {n:ddrclk90}  -freq 100.000 -clockgroup ddr_clkgroup -rise 2.500 -fall 7.500
define_clock            -name {n:ddrclk180}  -freq 100.000 -clockgroup ddr_clkgroup -rise 5.000 -fall 10.000
define_clock            -name {n:ddrclk270}  -freq 100.000 -clockgroup ddr_clkgroup -rise 7.500 -fall 2.500

#
# Clock to Clock
#
define_clock_delay           -rise {clkm} -rise {ddrclk0} -false
define_clock_delay           -rise {clkm} -rise {ddrclk90} -false
define_clock_delay           -rise {clkm} -rise {ddrclk180} -false
define_clock_delay           -rise {clkm} -rise {ddrclk270} -false
define_clock_delay           -rise {ddrclk0} -rise {clkm} -false
define_clock_delay           -rise {ddrclk90} -rise {clkm} -false
define_clock_delay           -rise {ddrclk180} -rise {clkm} -false
define_clock_delay           -rise {ddrclk270} -rise {clkm} -false

#
# Inputs/Outputs
#

#
# Registers
#

#
# Multicycle Path
#

#
# False Path
#
define_false_path           -through {n:resetn} 

#
# Path Delay
#

#
# Attributes
#
define_attribute          {clk} xc_loc {AJ15}
define_attribute          {resetn} xc_loc {AH5}
define_attribute          {dsurx} xc_loc {AJ8}
define_attribute          {dsutx} xc_loc {AE7}
define_attribute          {dsutx} syn_io_slew {SLOW}
define_attribute          {dsutx} syn_io_drive {12}
define_attribute          {ddr_ad[12]} xc_loc {M25}
define_attribute          {ddr_ad[11]} xc_loc {N25}
define_attribute          {ddr_ad[10]} xc_loc {L26}
define_attribute          {ddr_ad[9]} xc_loc {M29}
define_attribute          {ddr_ad[8]} xc_loc {K30}
define_attribute          {ddr_ad[7]} xc_loc {G25}
define_attribute          {ddr_ad[6]} xc_loc {G26}
define_attribute          {ddr_ad[5]} xc_loc {D26}
define_attribute          {ddr_ad[4]} xc_loc {J24}
define_attribute          {ddr_ad[3]} xc_loc {K24}
define_attribute          {ddr_ad[2]} xc_loc {F28}
define_attribute          {ddr_ad[1]} xc_loc {F30}
define_attribute          {ddr_ad[0]} xc_loc {M24}
define_attribute          {ddr_ba[1]} xc_loc {M26}
define_attribute          {ddr_ba[0]} xc_loc {K26}
define_attribute          {ddr_cas} xc_loc {L27}
define_attribute          {ddr_cke} xc_loc {R26}
define_attribute          {ddr_cs} xc_loc {R24}
define_attribute          {ddr_ras} xc_loc {N29}
define_attribute          {ddr_we} xc_loc {N26}
define_attribute          {ddr_dm[7]} xc_loc {U26}
define_attribute          {ddr_dm[6]} xc_loc {V29}
define_attribute          {ddr_dm[5]} xc_loc {W29}
define_attribute          {ddr_dm[4]} xc_loc {T22}
define_attribute          {ddr_dm[3]} xc_loc {W28}
define_attribute          {ddr_dm[2]} xc_loc {W27}
define_attribute          {ddr_dm[1]} xc_loc {W26}
define_attribute          {ddr_dm[0]} xc_loc {W25}
define_attribute          {ddr_dqs[7]} xc_loc {E30}
define_attribute          {ddr_dqs[6]} xc_loc {J29}
define_attribute          {ddr_dqs[5]} xc_loc {M30}
define_attribute          {ddr_dqs[4]} xc_loc {P29}
define_attribute          {ddr_dqs[3]} xc_loc {V23}
define_attribute          {ddr_dqs[2]} xc_loc {AA25}
define_attribute          {ddr_dqs[1]} xc_loc {AC25}
define_attribute          {ddr_dqs[0]} xc_loc {AH26}
define_attribute          {ddr_dq[63]} xc_loc {C27}
define_attribute          {ddr_dq[62]} xc_loc {D28}
define_attribute          {ddr_dq[61]} xc_loc {D29}
define_attribute          {ddr_dq[60]} xc_loc {D30}
define_attribute          {ddr_dq[59]} xc_loc {H25}
define_attribute          {ddr_dq[58]} xc_loc {H26}
define_attribute          {ddr_dq[57]} xc_loc {E27}
define_attribute          {ddr_dq[56]} xc_loc {E28}
define_attribute          {ddr_dq[55]} xc_loc {J26}
define_attribute          {ddr_dq[54]} xc_loc {G27}
define_attribute          {ddr_dq[53]} xc_loc {G28}
define_attribute          {ddr_dq[52]} xc_loc {G30}
define_attribute          {ddr_dq[51]} xc_loc {L23}
define_attribute          {ddr_dq[50]} xc_loc {L24}
define_attribute          {ddr_dq[49]} xc_loc {H27}
define_attribute          {ddr_dq[48]} xc_loc {H28}
define_attribute          {ddr_dq[47]} xc_loc {J27}
define_attribute          {ddr_dq[46]} xc_loc {J28}
define_attribute          {ddr_dq[45]} xc_loc {K29}
define_attribute          {ddr_dq[44]} xc_loc {L29}
define_attribute          {ddr_dq[43]} xc_loc {N23}
define_attribute          {ddr_dq[42]} xc_loc {N24}
define_attribute          {ddr_dq[41]} xc_loc {K27}
define_attribute          {ddr_dq[40]} xc_loc {K28}
define_attribute          {ddr_dq[39]} xc_loc {R22}
define_attribute          {ddr_dq[38]} xc_loc {M27}
define_attribute          {ddr_dq[37]} xc_loc {M28}
define_attribute          {ddr_dq[36]} xc_loc {P30}
define_attribute          {ddr_dq[35]} xc_loc {P23}
define_attribute          {ddr_dq[34]} xc_loc {P24}
define_attribute          {ddr_dq[33]} xc_loc {N27}
define_attribute          {ddr_dq[32]} xc_loc {N28}
define_attribute          {ddr_dq[31]} xc_loc {V27}
define_attribute          {ddr_dq[30]} xc_loc {Y30}
define_attribute          {ddr_dq[29]} xc_loc {U24}
define_attribute          {ddr_dq[28]} xc_loc {U23}
define_attribute          {ddr_dq[27]} xc_loc {V26}
define_attribute          {ddr_dq[26]} xc_loc {V25}
define_attribute          {ddr_dq[25]} xc_loc {Y29}
define_attribute          {ddr_dq[24]} xc_loc {AA29}
define_attribute          {ddr_dq[23]} xc_loc {Y26}
define_attribute          {ddr_dq[22]} xc_loc {AA28}
define_attribute          {ddr_dq[21]} xc_loc {AA27}
define_attribute          {ddr_dq[20]} xc_loc {W24}
define_attribute          {ddr_dq[19]} xc_loc {W23}
define_attribute          {ddr_dq[18]} xc_loc {AB28}
define_attribute          {ddr_dq[17]} xc_loc {AB27}
define_attribute          {ddr_dq[16]} xc_loc {AC29}
define_attribute          {ddr_dq[15]} xc_loc {AB25}
define_attribute          {ddr_dq[14]} xc_loc {AE29}
define_attribute          {ddr_dq[13]} xc_loc {AA24}
define_attribute          {ddr_dq[12]} xc_loc {AA23}
define_attribute          {ddr_dq[11]} xc_loc {AD28}
define_attribute          {ddr_dq[10]} xc_loc {AD27}
define_attribute          {ddr_dq[9]} xc_loc {AF30}
define_attribute          {ddr_dq[8]} xc_loc {AF29}
define_attribute          {ddr_dq[7]} xc_loc {AF25}
define_attribute          {ddr_dq[6]} xc_loc {AG30}
define_attribute          {ddr_dq[5]} xc_loc {AG29}
define_attribute          {ddr_dq[4]} xc_loc {AD26}
define_attribute          {ddr_dq[3]} xc_loc {AD25}
define_attribute          {ddr_dq[2]} xc_loc {AG28}
define_attribute          {ddr_dq[1]} xc_loc {AH27}
define_attribute          {ddr_dq[0]} xc_loc {AH29}
define_attribute          {ddr_clk[2]} xc_loc {AC27}
define_attribute          {ddr_clk[1]} xc_loc {AD29}
define_attribute          {ddr_clk[0]} xc_loc {AB23}
define_attribute          {ddr_clkn[2]} xc_loc {AC28}
define_attribute          {ddr_clkn[1]} xc_loc {AD30}
define_attribute          {ddr_clkn[0]} xc_loc {AB24}
define_attribute          {ddr_clk_fb} xc_loc {C16}
define_attribute          {ddr_clk_fb_out} xc_loc {G23}
define_attribute          {erxd[3]} xc_nodelay {1}
define_attribute          {erxd[2]} xc_nodelay {1}
define_attribute          {erxd[1]} xc_nodelay {1}
define_attribute          {erxd[0]} xc_nodelay {1}
define_attribute          {erx_dv} xc_nodelay {1}
define_attribute          {erx_er} xc_nodelay {1}
define_attribute          {erx_crs} xc_nodelay {1}
define_attribute          {erx_col} xc_nodelay {1}
define_attribute          {em_slew1} xc_loc {B3}
define_attribute          {em_slew1} syn_io_slew {SLOW}
define_attribute          {em_slew1} syn_io_drive {8}
define_attribute          {em_slew2} xc_loc {A3}
define_attribute          {em_slew2} syn_io_slew {SLOW}
define_attribute          {em_slew2} syn_io_drive {8}
define_attribute          {em_resetn} xc_loc {G6}
define_attribute          {em_resetn} syn_io_slew {SLOW}
define_attribute          {em_resetn} syn_io_drive {8}
define_attribute          {erx_crs} xc_loc {C5}
define_attribute          {erx_col} xc_loc {D5}
define_attribute          {etxd[3]} xc_loc {C2}
define_attribute          {etxd[3]} syn_io_slew {SLOW}
define_attribute          {etxd[3]} syn_io_drive {8}
define_attribute          {etxd[2]} xc_loc {C1}
define_attribute          {etxd[2]} syn_io_slew {SLOW}
define_attribute          {etxd[2]} syn_io_drive {8}
define_attribute          {etxd[1]} xc_loc {J8}
define_attribute          {etxd[1]} syn_io_slew {SLOW}
define_attribute          {etxd[1]} syn_io_drive {8}
define_attribute          {etxd[0]} xc_loc {J7}
define_attribute          {etxd[0]} syn_io_slew {SLOW}
define_attribute          {etxd[0]} syn_io_drive {8}
define_attribute          {etx_en} xc_loc {C4}
define_attribute          {etx_en} syn_io_slew {SLOW}
define_attribute          {etx_en} syn_io_drive {8}
define_attribute          {etx_clk} xc_loc {D3}
define_attribute          {etx_er} xc_loc {H2}
define_attribute          {erx_er} xc_loc {J2}
define_attribute          {erx_clk} xc_loc {M8}
define_attribute          {erx_dv} xc_loc {M7}
define_attribute          {erxd[0]} xc_loc {K6}
define_attribute          {erxd[1]} xc_loc {K5}
define_attribute          {erxd[2]} xc_loc {J1}
define_attribute          {erxd[3]} xc_loc {K1}
define_attribute          {emdc} xc_loc {M6}
define_attribute          {emdc} syn_io_slew {SLOW}
define_attribute          {emdc} syn_io_drive {8}
define_attribute          {emdio} xc_loc {M5}
define_attribute          {emdio} syn_io_slew {SLOW}
define_attribute          {emdio} syn_io_drive {8}
define_attribute          {dsuact} xc_loc {AC4}
define_attribute          {dsuact} syn_io_drive {12}
define_attribute          {dsuact} syn_io_slew {SLOW}
define_attribute          {errorn} xc_loc {AC3}
define_attribute          {errorn} syn_io_drive {12}
define_attribute          {errorn} syn_io_slew {SLOW}

#
# I/O standards
#
define_io_standard               {clk} syn_pad_type {LVCMOS25}
define_io_standard               {resetn} syn_pad_type {LVTTL}
define_io_standard               {dsurx} syn_pad_type {LVCMOS25}
define_io_standard               {dsutx} syn_pad_type {LVCMOS25}
define_io_standard               {ddr_ad[12]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[11]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[10]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[9]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[8]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[7]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[6]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[5]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[4]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[3]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[2]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[1]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ad[0]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ba[1]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ba[0]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_cas} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_cke} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_cs} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_ras} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_we} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dm[7]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dm[6]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dm[5]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dm[4]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dm[3]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dm[2]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dm[1]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dm[0]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dqs[7]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dqs[6]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dqs[5]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dqs[4]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dqs[3]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dqs[2]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dqs[1]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dqs[0]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[63]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[62]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[61]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[60]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[59]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[58]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[57]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[56]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[55]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[54]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[53]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[52]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[51]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[50]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[49]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[48]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[47]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[46]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[45]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[44]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[43]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[42]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[41]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[40]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[39]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[38]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[37]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[36]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[35]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[34]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[33]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[32]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[31]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[30]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[29]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[28]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[27]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[26]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[25]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[24]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[23]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[22]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[21]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[20]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[19]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[18]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[17]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[16]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[15]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[14]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[13]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[12]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[11]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[10]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[9]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[8]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[7]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[6]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[5]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[4]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[3]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[2]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[1]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_dq[0]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_clk[2]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_clk[1]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_clk[0]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_clkn[2]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_clkn[1]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_clkn[0]} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_clk_fb} syn_pad_type {SSTL2_II}
define_io_standard               {ddr_clk_fb_out} syn_pad_type {SSTL2_II}
define_io_standard               {em_slew1} syn_pad_type {LVTTL}
define_io_standard               {em_slew2} syn_pad_type {LVTTL}
define_io_standard               {em_resetn} syn_pad_type {LVTTL}
define_io_standard               {erx_crs} syn_pad_type {LVTTL}
define_io_standard               {erx_col} syn_pad_type {LVTTL}
define_io_standard               {etxd[3]} syn_pad_type {LVTTL}
define_io_standard               {etxd[2]} syn_pad_type {LVTTL}
define_io_standard               {etxd[1]} syn_pad_type {LVTTL}
define_io_standard               {etxd[0]} syn_pad_type {LVTTL}
define_io_standard               {etx_en} syn_pad_type {LVTTL}
define_io_standard               {etx_clk} syn_pad_type {LVTTL}
define_io_standard               {etx_er} syn_pad_type {LVTTL}
define_io_standard               {erx_er} syn_pad_type {LVTTL}
define_io_standard               {erx_clk} syn_pad_type {LVTTL}
define_io_standard               {erx_dv} syn_pad_type {LVTTL}
define_io_standard               {erxd[0]} syn_pad_type {LVTTL}
define_io_standard               {erxd[1]} syn_pad_type {LVTTL}
define_io_standard               {erxd[2]} syn_pad_type {LVTTL}
define_io_standard               {erxd[3]} syn_pad_type {LVTTL}
define_io_standard               {emdc} syn_pad_type {LVTTL}
define_io_standard               {emdio} syn_pad_type {LVTTL}
define_io_standard               {dsuact} syn_pad_type {LVTTL}
define_io_standard               {errorn} syn_pad_type {LVTTL}

#
# Compile Points
#

#
# Other Constraints
#
