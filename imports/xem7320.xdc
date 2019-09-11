############################################################################
# XEM7320 - Xilinx constraints file
#
# Pin mappings for the XEM7320.  Use this as a template and comment out 
# the pins that are not used in your design.  (By default, map will fail
# if this file contains constraints for signals not in your design).
#
# Copyright (c) 2004-2018 Opal Kelly Incorporated
############################################################################

set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS True [current_design]

############################################################################
## FrontPanel Host Interface
############################################################################
set_property PACKAGE_PIN Y19 [get_ports {okHU[0]}]
set_property PACKAGE_PIN R18 [get_ports {okHU[1]}]
set_property PACKAGE_PIN R16 [get_ports {okHU[2]}]
set_property PACKAGE_PIN P14 [get_ports {okHU[3]}]
set_property SLEW FAST [get_ports {okHU[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports {okHU[*]}]

set_property PACKAGE_PIN W19 [get_ports {okUH[0]}]
set_property PACKAGE_PIN V18 [get_ports {okUH[1]}]
set_property PACKAGE_PIN U17 [get_ports {okUH[2]}]
set_property PACKAGE_PIN W17 [get_ports {okUH[3]}]
set_property PACKAGE_PIN T19 [get_ports {okUH[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {okUH[*]}]

set_property PACKAGE_PIN AB22 [get_ports {okUHU[0]}]
set_property PACKAGE_PIN AB21 [get_ports {okUHU[1]}]
set_property PACKAGE_PIN Y22 [get_ports {okUHU[2]}]
set_property PACKAGE_PIN AA21 [get_ports {okUHU[3]}]
set_property PACKAGE_PIN AA20 [get_ports {okUHU[4]}]
set_property PACKAGE_PIN W22 [get_ports {okUHU[5]}]
set_property PACKAGE_PIN W21 [get_ports {okUHU[6]}]
set_property PACKAGE_PIN T20 [get_ports {okUHU[7]}]
set_property PACKAGE_PIN R19 [get_ports {okUHU[8]}]
set_property PACKAGE_PIN P19 [get_ports {okUHU[9]}]
set_property PACKAGE_PIN U21 [get_ports {okUHU[10]}]
set_property PACKAGE_PIN T21 [get_ports {okUHU[11]}]
set_property PACKAGE_PIN R21 [get_ports {okUHU[12]}]
set_property PACKAGE_PIN P21 [get_ports {okUHU[13]}]
set_property PACKAGE_PIN R22 [get_ports {okUHU[14]}]
set_property PACKAGE_PIN P22 [get_ports {okUHU[15]}]
set_property PACKAGE_PIN R14 [get_ports {okUHU[16]}]
set_property PACKAGE_PIN W20 [get_ports {okUHU[17]}]
set_property PACKAGE_PIN Y21 [get_ports {okUHU[18]}]
set_property PACKAGE_PIN P17 [get_ports {okUHU[19]}]
set_property PACKAGE_PIN U20 [get_ports {okUHU[20]}]
set_property PACKAGE_PIN N17 [get_ports {okUHU[21]}]
set_property PACKAGE_PIN N14 [get_ports {okUHU[22]}]
set_property PACKAGE_PIN V20 [get_ports {okUHU[23]}]
set_property PACKAGE_PIN P16 [get_ports {okUHU[24]}]
set_property PACKAGE_PIN T18 [get_ports {okUHU[25]}]
set_property PACKAGE_PIN V19 [get_ports {okUHU[26]}]
set_property PACKAGE_PIN AB20 [get_ports {okUHU[27]}]
set_property PACKAGE_PIN P15 [get_ports {okUHU[28]}]
set_property PACKAGE_PIN V22 [get_ports {okUHU[29]}]
set_property PACKAGE_PIN U18 [get_ports {okUHU[30]}]
set_property PACKAGE_PIN AB18 [get_ports {okUHU[31]}]
set_property SLEW FAST [get_ports {okUHU[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports {okUHU[*]}]

set_property PACKAGE_PIN AA19 [get_ports {okRSVD[0]}]
set_property PACKAGE_PIN V17 [get_ports {okRSVD[1]}]
set_property PACKAGE_PIN AA18 [get_ports {okRSVD[2]}]
set_property PACKAGE_PIN R17 [get_ports {okRSVD[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {okRSVD[*]}]

set_property PACKAGE_PIN N13 [get_ports {okAA}]
set_property IOSTANDARD LVCMOS18 [get_ports {okAA}]


create_clock -name okUH0 -period 9.920 [get_ports {okUH[0]}]

set_input_delay -add_delay -max -clock [get_clocks {okUH0}]  8.000 [get_ports {okUH[*]}]
set_input_delay -add_delay -min -clock [get_clocks {okUH0}] 10.000 [get_ports {okUH[*]}]
set_multicycle_path -setup -from [get_ports {okUH[*]}] 2

set_input_delay -add_delay -max -clock [get_clocks {okUH0}]  8.000 [get_ports {okUHU[*]}]
set_input_delay -add_delay -min -clock [get_clocks {okUH0}]  2.000 [get_ports {okUHU[*]}]
set_multicycle_path -setup -from [get_ports {okUHU[*]}] 2

set_output_delay -add_delay -max -clock [get_clocks {okUH0}]  2.000 [get_ports {okHU[*]}]
set_output_delay -add_delay -min -clock [get_clocks {okUH0}]  -0.500 [get_ports {okHU[*]}]

set_output_delay -add_delay -max -clock [get_clocks {okUH0}]  2.000 [get_ports {okUHU[*]}]
set_output_delay -add_delay -min -clock [get_clocks {okUH0}]  -0.500 [get_ports {okUHU[*]}]


############################################################################
## System Clock
############################################################################
set_property IOSTANDARD LVDS_25 [get_ports {sys_clkp}]
set_property PACKAGE_PIN D17 [get_ports {sys_clkp}]

set_property IOSTANDARD LVDS_25 [get_ports {sys_clkn}]
set_property PACKAGE_PIN C17 [get_ports {sys_clkn}]

create_clock -name sys_clk -period 5 [get_ports sys_clkp]
set_clock_groups -asynchronous -group [get_clocks {sys_clk}] -group [get_clocks {mmcm0_clk0 okUH0}]

############################################################################
## User Reset
############################################################################
set_property PACKAGE_PIN Y18 [get_ports {reset}]
set_property IOSTANDARD LVCMOS18 [get_ports {reset}]
set_property SLEW FAST [get_ports {reset}]


# PORTA-1 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-2 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-3 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-4 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-5 
set_property PACKAGE_PIN AA10 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-6 
set_property PACKAGE_PIN AA9 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-7 
set_property PACKAGE_PIN AA11 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-8 
set_property PACKAGE_PIN AB10 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-9 
set_property PACKAGE_PIN Y11 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-10 
set_property PACKAGE_PIN AA13 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-11 
set_property PACKAGE_PIN Y12 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-12 
set_property PACKAGE_PIN AB13 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-13 
set_property PACKAGE_PIN AB16 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-14 
set_property PACKAGE_PIN V10 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-15 
set_property PACKAGE_PIN AB17 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-16 
set_property PACKAGE_PIN W10 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-17 
set_property PACKAGE_PIN AB11 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-18 
set_property PACKAGE_PIN Y16 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-19 
set_property PACKAGE_PIN AB12 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-20 
set_property PACKAGE_PIN AA16 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-21 
set_property PACKAGE_PIN Y14 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-22 
set_property PACKAGE_PIN W14 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-23 
set_property PACKAGE_PIN AA15 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-24 
set_property PACKAGE_PIN V13 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-25 
set_property PACKAGE_PIN U15 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-26 
set_property PACKAGE_PIN V14 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-27 
set_property PACKAGE_PIN AB15 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-28 
set_property PACKAGE_PIN V15 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-29 
set_property PACKAGE_PIN AA14 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-30 
set_property PACKAGE_PIN T14 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-31 
set_property PACKAGE_PIN Y13 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-32 
set_property PACKAGE_PIN T15 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-33 
set_property PACKAGE_PIN W11 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-34 
set_property PACKAGE_PIN W15 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-35 
set_property PACKAGE_PIN W12 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-36 
set_property PACKAGE_PIN W16 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-37 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-38 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-39 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTA-40 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-1 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-2 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-3 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-4 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-5 
set_property PACKAGE_PIN W1 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-6 
set_property PACKAGE_PIN U3 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-7 
set_property PACKAGE_PIN Y1 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-8 
set_property PACKAGE_PIN V3 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-9 
set_property PACKAGE_PIN U6 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-10 
set_property PACKAGE_PIN W6 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-11 
set_property PACKAGE_PIN V5 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-12 
set_property PACKAGE_PIN W5 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-13 
set_property PACKAGE_PIN U2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-14 
set_property PACKAGE_PIN AA1 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-15 
set_property PACKAGE_PIN V2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-16 
set_property PACKAGE_PIN AB1 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-17 
set_property PACKAGE_PIN W2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-18 
set_property PACKAGE_PIN Y3 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-19 
set_property PACKAGE_PIN Y2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-20 
set_property PACKAGE_PIN AA3 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-21 
set_property PACKAGE_PIN AB3 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-22 
set_property PACKAGE_PIN AB2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-23 
set_property PACKAGE_PIN AA5 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-24 
set_property PACKAGE_PIN AA4 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-25 
set_property PACKAGE_PIN Y7 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-26 
set_property PACKAGE_PIN Y6 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-27 
set_property PACKAGE_PIN AB5 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-28 
set_property PACKAGE_PIN U5 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-29 
set_property PACKAGE_PIN AB6 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-30 
set_property PACKAGE_PIN AB7 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-31 
set_property PACKAGE_PIN AA6 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-32 
set_property PACKAGE_PIN Y4 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-33 
set_property PACKAGE_PIN V4 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-34 
set_property PACKAGE_PIN AA8 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-35 
set_property PACKAGE_PIN W4 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-36 
set_property PACKAGE_PIN AB8 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-37 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-38 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-39 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTB-40 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-1 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-2 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-3 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-4 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-5 
set_property PACKAGE_PIN B8 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-6 
set_property PACKAGE_PIN B4 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-7 
set_property PACKAGE_PIN A8 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-8 
set_property PACKAGE_PIN A4 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-9 
set_property PACKAGE_PIN D11 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-10 
set_property PACKAGE_PIN D5 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-11 
set_property PACKAGE_PIN C11 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-12 
set_property PACKAGE_PIN C5 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-13 
set_property PACKAGE_PIN F6 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-14 
set_property PACKAGE_PIN F3 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-15 
set_property PACKAGE_PIN E6 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-16 
set_property PACKAGE_PIN J5 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-17 
set_property PACKAGE_PIN E2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-18 
set_property PACKAGE_PIN E3 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-19 
set_property PACKAGE_PIN G3 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-20 
set_property PACKAGE_PIN H3 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-21 
set_property PACKAGE_PIN D2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-22 
set_property PACKAGE_PIN H2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-23 
set_property PACKAGE_PIN G2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-24 
set_property PACKAGE_PIN H5 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-25 
set_property PACKAGE_PIN C2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-26 
set_property PACKAGE_PIN B2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-27 
set_property PACKAGE_PIN G1 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-28 
set_property PACKAGE_PIN J2 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-29 
set_property PACKAGE_PIN A1 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-30 
set_property PACKAGE_PIN B1 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-31 
set_property PACKAGE_PIN F1 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-32 
set_property PACKAGE_PIN J1 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-33 
set_property PACKAGE_PIN H4 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-34 
set_property PACKAGE_PIN E1 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-35 
set_property PACKAGE_PIN G4 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-36 
set_property PACKAGE_PIN D1 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-37 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-38 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-39 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# PORTC-40 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-1 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-2 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-3 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-4 
set_property PACKAGE_PIN T13 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-5 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-6 
set_property PACKAGE_PIN V12 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-7 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-8 
set_property PACKAGE_PIN U13 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-9 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-10 
set_property PACKAGE_PIN R13 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-11 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-12 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-13 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# J2-14 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# LEDs #####################################################################
set_property PACKAGE_PIN A13 [get_ports {led[0]}]
set_property PACKAGE_PIN B13 [get_ports {led[1]}]
set_property PACKAGE_PIN A14 [get_ports {led[2]}]
set_property PACKAGE_PIN A15 [get_ports {led[3]}]
set_property PACKAGE_PIN B15 [get_ports {led[4]}]
set_property PACKAGE_PIN A16 [get_ports {led[5]}]
set_property PACKAGE_PIN B16 [get_ports {led[6]}]
set_property PACKAGE_PIN B17 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[*]}]

# Flash ####################################################################
set_property PACKAGE_PIN F15 [get_ports {spi_dq0}]
set_property PACKAGE_PIN F13 [get_ports {spi_c}]
set_property PACKAGE_PIN F14 [get_ports {spi_s}]
set_property PACKAGE_PIN F16 [get_ports {spi_dq1}]
set_property PACKAGE_PIN E17 [get_ports {spi_w_dq2}]
set_property PACKAGE_PIN C14 [get_ports {spi_hold_dq3}]
set_property IOSTANDARD LVCMOS15 [get_ports {spi_dq0}]
set_property IOSTANDARD LVCMOS15 [get_ports {spi_c}]
set_property IOSTANDARD LVCMOS15 [get_ports {spi_s}]
set_property IOSTANDARD LVCMOS15 [get_ports {spi_dq1}]
set_property IOSTANDARD LVCMOS15 [get_ports {spi_w_dq2}]
set_property IOSTANDARD LVCMOS15 [get_ports {spi_hold_dq3}]

# DRAM #####################################################################
set_property PACKAGE_PIN N18 [get_ports {ddr3_dq[0]}]
set_property PACKAGE_PIN L20 [get_ports {ddr3_dq[1]}]
set_property PACKAGE_PIN N20 [get_ports {ddr3_dq[2]}]
set_property PACKAGE_PIN K18 [get_ports {ddr3_dq[3]}]
set_property PACKAGE_PIN M18 [get_ports {ddr3_dq[4]}]
set_property PACKAGE_PIN K19 [get_ports {ddr3_dq[5]}]
set_property PACKAGE_PIN N19 [get_ports {ddr3_dq[6]}]
set_property PACKAGE_PIN L18 [get_ports {ddr3_dq[7]}]
set_property PACKAGE_PIN L16 [get_ports {ddr3_dq[8]}]
set_property PACKAGE_PIN L14 [get_ports {ddr3_dq[9]}]
set_property PACKAGE_PIN K14 [get_ports {ddr3_dq[10]}]
set_property PACKAGE_PIN M15 [get_ports {ddr3_dq[11]}]
set_property PACKAGE_PIN K16 [get_ports {ddr3_dq[12]}]
set_property PACKAGE_PIN M13 [get_ports {ddr3_dq[13]}]
set_property PACKAGE_PIN K13 [get_ports {ddr3_dq[14]}]
set_property PACKAGE_PIN L13 [get_ports {ddr3_dq[15]}]
set_property PACKAGE_PIN D22 [get_ports {ddr3_dq[16]}]
set_property PACKAGE_PIN C20 [get_ports {ddr3_dq[17]}]
set_property PACKAGE_PIN E21 [get_ports {ddr3_dq[18]}]
set_property PACKAGE_PIN D21 [get_ports {ddr3_dq[19]}]
set_property PACKAGE_PIN G21 [get_ports {ddr3_dq[20]}]
set_property PACKAGE_PIN C22 [get_ports {ddr3_dq[21]}]
set_property PACKAGE_PIN E22 [get_ports {ddr3_dq[22]}]
set_property PACKAGE_PIN B22 [get_ports {ddr3_dq[23]}]
set_property PACKAGE_PIN A20 [get_ports {ddr3_dq[24]}]
set_property PACKAGE_PIN D19 [get_ports {ddr3_dq[25]}]
set_property PACKAGE_PIN A19 [get_ports {ddr3_dq[26]}]
set_property PACKAGE_PIN F19 [get_ports {ddr3_dq[27]}]
set_property PACKAGE_PIN C18 [get_ports {ddr3_dq[28]}]
set_property PACKAGE_PIN E19 [get_ports {ddr3_dq[29]}]
set_property PACKAGE_PIN A18 [get_ports {ddr3_dq[30]}]
set_property PACKAGE_PIN C19 [get_ports {ddr3_dq[31]}]
set_property SLEW FAST [get_ports {ddr3_dq[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[*]}]

set_property PACKAGE_PIN J21 [get_ports {ddr3_addr[0]}]
set_property PACKAGE_PIN J22 [get_ports {ddr3_addr[1]}]
set_property PACKAGE_PIN K21 [get_ports {ddr3_addr[2]}]
set_property PACKAGE_PIN H22 [get_ports {ddr3_addr[3]}]
set_property PACKAGE_PIN G13 [get_ports {ddr3_addr[4]}]
set_property PACKAGE_PIN G17 [get_ports {ddr3_addr[5]}]
set_property PACKAGE_PIN H15 [get_ports {ddr3_addr[6]}]
set_property PACKAGE_PIN G16 [get_ports {ddr3_addr[7]}]
set_property PACKAGE_PIN G20 [get_ports {ddr3_addr[8]}]
set_property PACKAGE_PIN M21 [get_ports {ddr3_addr[9]}]
set_property PACKAGE_PIN J15 [get_ports {ddr3_addr[10]}]
set_property PACKAGE_PIN G15 [get_ports {ddr3_addr[11]}]
set_property PACKAGE_PIN H13 [get_ports {ddr3_addr[12]}]
set_property PACKAGE_PIN K22 [get_ports {ddr3_addr[13]}]
set_property PACKAGE_PIN L21 [get_ports {ddr3_addr[14]}]
set_property SLEW FAST [get_ports {ddr3_addr[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[*]}]

set_property PACKAGE_PIN H18 [get_ports {ddr3_ba[0]}]
set_property PACKAGE_PIN J19 [get_ports {ddr3_ba[1]}]
set_property PACKAGE_PIN H19 [get_ports {ddr3_ba[2]}]
set_property SLEW FAST [get_ports {ddr3_ba[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[*]}]

set_property PACKAGE_PIN J16 [get_ports {ddr3_ras_n}]
set_property SLEW FAST [get_ports {ddr3_ras_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ras_n}]

set_property PACKAGE_PIN H17 [get_ports {ddr3_cas_n}]
set_property SLEW FAST [get_ports {ddr3_cas_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cas_n}]

set_property PACKAGE_PIN J20 [get_ports {ddr3_we_n}]
set_property SLEW FAST [get_ports {ddr3_we_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_we_n}]

set_property PACKAGE_PIN F21 [get_ports {ddr3_reset_n}]
set_property SLEW FAST [get_ports {ddr3_reset_n}]
set_property IOSTANDARD LVCMOS15 [get_ports {ddr3_reset_n}]

set_property PACKAGE_PIN G18 [get_ports {ddr3_cke[0]}]
set_property SLEW FAST [get_ports {ddr3_cke[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cke[*]}]

set_property PACKAGE_PIN H20 [get_ports {ddr3_odt[0]}]
set_property SLEW FAST [get_ports {ddr3_odt[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_odt[*]}]

set_property PACKAGE_PIN L19 [get_ports {ddr3_dm[0]}]
set_property PACKAGE_PIN L15 [get_ports {ddr3_dm[1]}]
set_property PACKAGE_PIN D20 [get_ports {ddr3_dm[2]}]
set_property PACKAGE_PIN B20 [get_ports {ddr3_dm[3]}]
set_property SLEW FAST [get_ports {ddr3_dm[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[*]}]

set_property PACKAGE_PIN N22 [get_ports {ddr3_dqs_p[0]}]
set_property PACKAGE_PIN M22 [get_ports {ddr3_dqs_n[0]}]
set_property PACKAGE_PIN K17 [get_ports {ddr3_dqs_p[1]}]
set_property PACKAGE_PIN J17 [get_ports {ddr3_dqs_n[1]}]
set_property PACKAGE_PIN B21 [get_ports {ddr3_dqs_p[2]}]
set_property PACKAGE_PIN A21 [get_ports {ddr3_dqs_n[2]}]
set_property PACKAGE_PIN F18 [get_ports {ddr3_dqs_p[3]}]
set_property PACKAGE_PIN E18 [get_ports {ddr3_dqs_n[3]}]
set_property SLEW FAST [get_ports {ddr3_dqs*}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_dqs*}]

set_property PACKAGE_PIN J14 [get_ports {ddr3_ck_p[0]}]
set_property PACKAGE_PIN H14 [get_ports {ddr3_ck_n[0]}]
set_property SLEW FAST [get_ports {ddr3_ck*}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_*}]

