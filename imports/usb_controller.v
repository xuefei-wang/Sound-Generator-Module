module usb_controller(
    input  wire [4:0]  okUH,
	output wire [3:0]  okHU,
	input  wire [3:0]  okRSVD,
	inout  wire [31:0] okUHU,
	inout  wire        okAA,
    output wire    okClk,
    output wire ep_write,
    output wire [31:0] ep_dataout,
    output wire ep_read,
    input wire [31:0] ep_datain,
    
    output wire mst_reset
	// output wire select

);


wire [112:0]    okHE;
wire [64:0]     okEH;
wire [65*2-1:0] okEHx; // two pipes
wire [31:0] ep00wire, ep02wire, ep05wire;

assign mst_reset = ep00wire[0];
// assign select = ep02wire[0];

/* --- Front Panel Implementation --- */
okWireOR # (.N(2)) wireOR (okEH, okEHx); 
okWireIn   wi00(.okHE(okHE), .ep_addr(8'h00), .ep_dataout(ep00wire)); // [0]: mst_reset
// okWireIn   wi02(.okHE(okHE), .ep_addr(8'h02), .ep_dataout(ep02wire)); // [0]: select
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

// from host to target
okPipeIn ep80( 
	.okHE           (okHE),
	.okEH           (okEHx[0 * 65 +: 65]),
	.ep_addr        (8'h80),
	.ep_write       (ep_write), // data should be captured when this is asserted
	.ep_dataout     (ep_dataout) // data out
	
);


// from target to host
okPipeOut epa3(
	.okHE			(okHE),
	.okEH			(okEHx[1 * 65 +: 65]),
	.ep_addr		(8'ha3),
	.ep_datain		(ep_datain),
	.ep_read		(ep_read)
);


endmodule