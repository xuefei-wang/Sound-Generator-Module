// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sat Sep 28 23:46:19 2019
// Host        : LAPTOP-R7CLAHA0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/mig_7series_0_ex/mig_7series_0_ex.srcs/sources_1/ip/selectio_wiz_0/selectio_wiz_0_sim_netlist.v
// Design      : selectio_wiz_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a75tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* DEV_W = "24" *) (* SYS_W = "12" *) 
(* NotValidForBitStream *)
module selectio_wiz_0
   (data_out_from_device,
    data_out_to_pins,
    clk_in,
    io_reset);
  input [23:0]data_out_from_device;
  output [11:0]data_out_to_pins;
  input clk_in;
  input io_reset;

  wire clk_in;
  wire [23:0]data_out_from_device;
  (* DRIVE = "12" *) (* IOSTANDARD = "LVCMOS18" *) (* SLEW = "SLOW" *) wire [11:0]data_out_to_pins;
  wire io_reset;

  (* DEV_W = "24" *) 
  (* SYS_W = "12" *) 
  selectio_wiz_0_selectio_wiz_0_selectio_wiz inst
       (.clk_in(clk_in),
        .data_out_from_device(data_out_from_device),
        .data_out_to_pins(data_out_to_pins),
        .io_reset(io_reset));
endmodule

(* DEV_W = "24" *) (* ORIG_REF_NAME = "selectio_wiz_0_selectio_wiz" *) (* SYS_W = "12" *) 
module selectio_wiz_0_selectio_wiz_0_selectio_wiz
   (data_out_from_device,
    data_out_to_pins,
    clk_in,
    io_reset);
  input [23:0]data_out_from_device;
  output [11:0]data_out_to_pins;
  input clk_in;
  input io_reset;

  wire clk_in;
  wire [23:0]data_out_from_device;
  wire [11:0]data_out_to_pins;
  wire [11:0]data_out_to_pins_int;
  wire io_reset;
  wire \NLW_pins[0].oddr_inst_S_UNCONNECTED ;
  wire \NLW_pins[10].oddr_inst_S_UNCONNECTED ;
  wire \NLW_pins[11].oddr_inst_S_UNCONNECTED ;
  wire \NLW_pins[1].oddr_inst_S_UNCONNECTED ;
  wire \NLW_pins[2].oddr_inst_S_UNCONNECTED ;
  wire \NLW_pins[3].oddr_inst_S_UNCONNECTED ;
  wire \NLW_pins[4].oddr_inst_S_UNCONNECTED ;
  wire \NLW_pins[5].oddr_inst_S_UNCONNECTED ;
  wire \NLW_pins[6].oddr_inst_S_UNCONNECTED ;
  wire \NLW_pins[7].oddr_inst_S_UNCONNECTED ;
  wire \NLW_pins[8].oddr_inst_S_UNCONNECTED ;
  wire \NLW_pins[9].oddr_inst_S_UNCONNECTED ;

  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[0].obuf_inst 
       (.I(data_out_to_pins_int[0]),
        .O(data_out_to_pins[0]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[0].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[0]),
        .D2(data_out_from_device[12]),
        .Q(data_out_to_pins_int[0]),
        .R(io_reset),
        .S(\NLW_pins[0].oddr_inst_S_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[10].obuf_inst 
       (.I(data_out_to_pins_int[10]),
        .O(data_out_to_pins[10]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[10].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[10]),
        .D2(data_out_from_device[22]),
        .Q(data_out_to_pins_int[10]),
        .R(io_reset),
        .S(\NLW_pins[10].oddr_inst_S_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[11].obuf_inst 
       (.I(data_out_to_pins_int[11]),
        .O(data_out_to_pins[11]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[11].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[11]),
        .D2(data_out_from_device[23]),
        .Q(data_out_to_pins_int[11]),
        .R(io_reset),
        .S(\NLW_pins[11].oddr_inst_S_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[1].obuf_inst 
       (.I(data_out_to_pins_int[1]),
        .O(data_out_to_pins[1]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[1].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[1]),
        .D2(data_out_from_device[13]),
        .Q(data_out_to_pins_int[1]),
        .R(io_reset),
        .S(\NLW_pins[1].oddr_inst_S_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[2].obuf_inst 
       (.I(data_out_to_pins_int[2]),
        .O(data_out_to_pins[2]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[2].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[2]),
        .D2(data_out_from_device[14]),
        .Q(data_out_to_pins_int[2]),
        .R(io_reset),
        .S(\NLW_pins[2].oddr_inst_S_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[3].obuf_inst 
       (.I(data_out_to_pins_int[3]),
        .O(data_out_to_pins[3]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[3].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[3]),
        .D2(data_out_from_device[15]),
        .Q(data_out_to_pins_int[3]),
        .R(io_reset),
        .S(\NLW_pins[3].oddr_inst_S_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[4].obuf_inst 
       (.I(data_out_to_pins_int[4]),
        .O(data_out_to_pins[4]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[4].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[4]),
        .D2(data_out_from_device[16]),
        .Q(data_out_to_pins_int[4]),
        .R(io_reset),
        .S(\NLW_pins[4].oddr_inst_S_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[5].obuf_inst 
       (.I(data_out_to_pins_int[5]),
        .O(data_out_to_pins[5]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[5].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[5]),
        .D2(data_out_from_device[17]),
        .Q(data_out_to_pins_int[5]),
        .R(io_reset),
        .S(\NLW_pins[5].oddr_inst_S_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[6].obuf_inst 
       (.I(data_out_to_pins_int[6]),
        .O(data_out_to_pins[6]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[6].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[6]),
        .D2(data_out_from_device[18]),
        .Q(data_out_to_pins_int[6]),
        .R(io_reset),
        .S(\NLW_pins[6].oddr_inst_S_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[7].obuf_inst 
       (.I(data_out_to_pins_int[7]),
        .O(data_out_to_pins[7]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[7].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[7]),
        .D2(data_out_from_device[19]),
        .Q(data_out_to_pins_int[7]),
        .R(io_reset),
        .S(\NLW_pins[7].oddr_inst_S_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[8].obuf_inst 
       (.I(data_out_to_pins_int[8]),
        .O(data_out_to_pins[8]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[8].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[8]),
        .D2(data_out_from_device[20]),
        .Q(data_out_to_pins_int[8]),
        .R(io_reset),
        .S(\NLW_pins[8].oddr_inst_S_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  OBUF \pins[9].obuf_inst 
       (.I(data_out_to_pins_int[9]),
        .O(data_out_to_pins[9]));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("ASYNC")) 
    \pins[9].oddr_inst 
       (.C(clk_in),
        .CE(1'b1),
        .D1(data_out_from_device[9]),
        .D2(data_out_from_device[21]),
        .Q(data_out_to_pins_int[9]),
        .R(io_reset),
        .S(\NLW_pins[9].oddr_inst_S_UNCONNECTED ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
