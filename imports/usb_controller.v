module usb_controller(
    input  wire [4:0]  okUH,
	output wire [3:0]  okHU,
	input  wire [3:0]  okRSVD,
	inout  wire [31:0] okUHU,
	inout  wire        okAA,
    output wire    okClk,
    output wire pipe_in_write,
    output wire [31:0] pipe_in_data,
    output wire pipe_out_read,
    input wire [31:0] pipe_out_data, //TODO: check these input/output type
    
    output wire mst_reset,
    output wire select

);


wire [112:0]    okHE;
wire [64:0]     okEH;
wire [65*2-1:0] okEHx; // two pipes
wire [31:0] ep00wire, ep02wire, ep05wire;

assign mst_reset = ep00wire[0];
assign select = ep02wire[0];

/* --- Front Panel Implementation --- */
okWireOR # (.N(2)) wireOR (okEH, okEHx); 
okWireIn   wi00(.okHE(okHE), .ep_addr(8'h00), .ep_dataout(ep00wire)); // [0]: mst_reset
okWireIn   wi02(.okHE(okHE), .ep_addr(8'h02), .ep_dataout(ep02wire)); // [0]: select
okWireIn   wi05(.okHE(okHE), .ep_addr(8'h05), .ep_dataout(ep05wire)); // = freq_fpga / freq_file

okHost okHI(
	.okUH   (okUH),
	.okHU   (okHU),
	.okUHU  (okUHU),
	.okAA   (okAA),
	.okClk  (okClk),
	.okHE   (okHE),
	.okEH   (okEH)
);

okPipeIn ep80(
	.okHE           (okHE),
	.okEH           (okEHx[0 * 65 +: 65]),
	.ep_addr        (8'h80),
	.ep_write       (pipe_in_write), // data should be captured when this is asserted
	.ep_dataout     (pipe_in_data) // data out
	
);

okPipeOut epa3(
	.okHE			(okHE),
	.okEH			(okEHx[1 * 65 +: 65]),
	.ep_addr		(8'ha3),
	.ep_datain		(pipe_out_data),
	.ep_read		(pipe_out_read)
);


endmodule