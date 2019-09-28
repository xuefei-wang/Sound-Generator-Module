-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Sat Sep 28 23:46:19 2019
-- Host        : LAPTOP-R7CLAHA0 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/mig_7series_0_ex/mig_7series_0_ex.srcs/sources_1/ip/selectio_wiz_0/selectio_wiz_0_sim_netlist.vhdl
-- Design      : selectio_wiz_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a75tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity selectio_wiz_0_selectio_wiz_0_selectio_wiz is
  port (
    data_out_from_device : in STD_LOGIC_VECTOR ( 23 downto 0 );
    data_out_to_pins : out STD_LOGIC_VECTOR ( 11 downto 0 );
    clk_in : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );
  attribute DEV_W : integer;
  attribute DEV_W of selectio_wiz_0_selectio_wiz_0_selectio_wiz : entity is 24;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of selectio_wiz_0_selectio_wiz_0_selectio_wiz : entity is "selectio_wiz_0_selectio_wiz";
  attribute SYS_W : integer;
  attribute SYS_W of selectio_wiz_0_selectio_wiz_0_selectio_wiz : entity is 12;
end selectio_wiz_0_selectio_wiz_0_selectio_wiz;

architecture STRUCTURE of selectio_wiz_0_selectio_wiz_0_selectio_wiz is
  signal data_out_to_pins_int : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \NLW_pins[0].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[10].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[11].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[4].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[5].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[6].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[7].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[8].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[9].oddr_inst_S_UNCONNECTED\ : STD_LOGIC;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \pins[0].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of \pins[0].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[0].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ : string;
  attribute \__SRVAL\ of \pins[0].oddr_inst\ : label is "FALSE";
  attribute BOX_TYPE of \pins[10].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[10].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[10].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \pins[10].oddr_inst\ : label is "FALSE";
  attribute BOX_TYPE of \pins[11].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[11].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[11].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \pins[11].oddr_inst\ : label is "FALSE";
  attribute BOX_TYPE of \pins[1].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[1].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[1].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \pins[1].oddr_inst\ : label is "FALSE";
  attribute BOX_TYPE of \pins[2].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[2].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[2].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \pins[2].oddr_inst\ : label is "FALSE";
  attribute BOX_TYPE of \pins[3].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[3].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[3].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \pins[3].oddr_inst\ : label is "FALSE";
  attribute BOX_TYPE of \pins[4].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[4].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[4].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \pins[4].oddr_inst\ : label is "FALSE";
  attribute BOX_TYPE of \pins[5].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[5].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[5].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \pins[5].oddr_inst\ : label is "FALSE";
  attribute BOX_TYPE of \pins[6].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[6].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[6].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \pins[6].oddr_inst\ : label is "FALSE";
  attribute BOX_TYPE of \pins[7].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[7].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[7].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \pins[7].oddr_inst\ : label is "FALSE";
  attribute BOX_TYPE of \pins[8].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[8].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[8].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \pins[8].oddr_inst\ : label is "FALSE";
  attribute BOX_TYPE of \pins[9].obuf_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[9].obuf_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[9].oddr_inst\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \pins[9].oddr_inst\ : label is "FALSE";
begin
\pins[0].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(0),
      O => data_out_to_pins(0)
    );
\pins[0].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(0),
      D2 => data_out_from_device(12),
      Q => data_out_to_pins_int(0),
      R => io_reset,
      S => \NLW_pins[0].oddr_inst_S_UNCONNECTED\
    );
\pins[10].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(10),
      O => data_out_to_pins(10)
    );
\pins[10].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(10),
      D2 => data_out_from_device(22),
      Q => data_out_to_pins_int(10),
      R => io_reset,
      S => \NLW_pins[10].oddr_inst_S_UNCONNECTED\
    );
\pins[11].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(11),
      O => data_out_to_pins(11)
    );
\pins[11].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(11),
      D2 => data_out_from_device(23),
      Q => data_out_to_pins_int(11),
      R => io_reset,
      S => \NLW_pins[11].oddr_inst_S_UNCONNECTED\
    );
\pins[1].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(1),
      O => data_out_to_pins(1)
    );
\pins[1].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(1),
      D2 => data_out_from_device(13),
      Q => data_out_to_pins_int(1),
      R => io_reset,
      S => \NLW_pins[1].oddr_inst_S_UNCONNECTED\
    );
\pins[2].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(2),
      O => data_out_to_pins(2)
    );
\pins[2].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(2),
      D2 => data_out_from_device(14),
      Q => data_out_to_pins_int(2),
      R => io_reset,
      S => \NLW_pins[2].oddr_inst_S_UNCONNECTED\
    );
\pins[3].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(3),
      O => data_out_to_pins(3)
    );
\pins[3].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(3),
      D2 => data_out_from_device(15),
      Q => data_out_to_pins_int(3),
      R => io_reset,
      S => \NLW_pins[3].oddr_inst_S_UNCONNECTED\
    );
\pins[4].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(4),
      O => data_out_to_pins(4)
    );
\pins[4].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(4),
      D2 => data_out_from_device(16),
      Q => data_out_to_pins_int(4),
      R => io_reset,
      S => \NLW_pins[4].oddr_inst_S_UNCONNECTED\
    );
\pins[5].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(5),
      O => data_out_to_pins(5)
    );
\pins[5].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(5),
      D2 => data_out_from_device(17),
      Q => data_out_to_pins_int(5),
      R => io_reset,
      S => \NLW_pins[5].oddr_inst_S_UNCONNECTED\
    );
\pins[6].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(6),
      O => data_out_to_pins(6)
    );
\pins[6].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(6),
      D2 => data_out_from_device(18),
      Q => data_out_to_pins_int(6),
      R => io_reset,
      S => \NLW_pins[6].oddr_inst_S_UNCONNECTED\
    );
\pins[7].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(7),
      O => data_out_to_pins(7)
    );
\pins[7].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(7),
      D2 => data_out_from_device(19),
      Q => data_out_to_pins_int(7),
      R => io_reset,
      S => \NLW_pins[7].oddr_inst_S_UNCONNECTED\
    );
\pins[8].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(8),
      O => data_out_to_pins(8)
    );
\pins[8].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(8),
      D2 => data_out_from_device(20),
      Q => data_out_to_pins_int(8),
      R => io_reset,
      S => \NLW_pins[8].oddr_inst_S_UNCONNECTED\
    );
\pins[9].obuf_inst\: unisim.vcomponents.OBUF
     port map (
      I => data_out_to_pins_int(9),
      O => data_out_to_pins(9)
    );
\pins[9].oddr_inst\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "ASYNC"
    )
        port map (
      C => clk_in,
      CE => '1',
      D1 => data_out_from_device(9),
      D2 => data_out_from_device(21),
      Q => data_out_to_pins_int(9),
      R => io_reset,
      S => \NLW_pins[9].oddr_inst_S_UNCONNECTED\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity selectio_wiz_0 is
  port (
    data_out_from_device : in STD_LOGIC_VECTOR ( 23 downto 0 );
    data_out_to_pins : out STD_LOGIC_VECTOR ( 11 downto 0 );
    clk_in : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of selectio_wiz_0 : entity is true;
  attribute DEV_W : integer;
  attribute DEV_W of selectio_wiz_0 : entity is 24;
  attribute SYS_W : integer;
  attribute SYS_W of selectio_wiz_0 : entity is 12;
end selectio_wiz_0;

architecture STRUCTURE of selectio_wiz_0 is
  attribute DEV_W of inst : label is 24;
  attribute SYS_W of inst : label is 12;
begin
inst: entity work.selectio_wiz_0_selectio_wiz_0_selectio_wiz
     port map (
      clk_in => clk_in,
      data_out_from_device(23 downto 0) => data_out_from_device(23 downto 0),
      data_out_to_pins(11 downto 0) => data_out_to_pins(11 downto 0),
      io_reset => io_reset
    );
end STRUCTURE;
