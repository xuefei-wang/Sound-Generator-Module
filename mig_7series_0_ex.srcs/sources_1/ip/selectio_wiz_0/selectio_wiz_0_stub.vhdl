-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Sat Sep 28 23:46:19 2019
-- Host        : LAPTOP-R7CLAHA0 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/mig_7series_0_ex/mig_7series_0_ex.srcs/sources_1/ip/selectio_wiz_0/selectio_wiz_0_stub.vhdl
-- Design      : selectio_wiz_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a75tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity selectio_wiz_0 is
  Port ( 
    data_out_from_device : in STD_LOGIC_VECTOR ( 23 downto 0 );
    data_out_to_pins : out STD_LOGIC_VECTOR ( 11 downto 0 );
    clk_in : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );

end selectio_wiz_0;

architecture stub of selectio_wiz_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "data_out_from_device[23:0],data_out_to_pins[11:0],clk_in,io_reset";
begin
end;
