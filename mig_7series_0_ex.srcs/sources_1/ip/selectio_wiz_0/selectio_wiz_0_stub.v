// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sat Sep 28 23:46:19 2019
// Host        : LAPTOP-R7CLAHA0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/mig_7series_0_ex/mig_7series_0_ex.srcs/sources_1/ip/selectio_wiz_0/selectio_wiz_0_stub.v
// Design      : selectio_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a75tfgg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module selectio_wiz_0(data_out_from_device, data_out_to_pins, 
  clk_in, io_reset)
/* synthesis syn_black_box black_box_pad_pin="data_out_from_device[23:0],data_out_to_pins[11:0],clk_in,io_reset" */;
  input [23:0]data_out_from_device;
  output [11:0]data_out_to_pins;
  input clk_in;
  input io_reset;
endmodule
