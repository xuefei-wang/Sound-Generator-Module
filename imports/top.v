module top(
    // FrontPanel
    input  wire [4:0]  okUH,
	output wire [3:0]  okHU,
	input  wire [3:0]  okRSVD,
	inout  wire [31:0] okUHU,
	inout  wire        okAA,

    // DAC
	output wire [11:0] dac_output_data,        // I/Q Data
	output wire        dac_clk,
	output wire        dac_reset_pinmd,
	output wire        dac_sclk,        // SPI Clock
	inout  wire        dac_sdio,        // SPI Data I/O
	output wire        dac_cs_n,        // SPI Chip Select

    // LED
    output wire [7:0]  led
);


//***************************************************************************
// Define variables
//***************************************************************************
wire            okClk;
wire [112:0]    okHE;
wire [64:0]     okEH;
wire [65*2-1:0] okEHx; // two pipes
wire [31:0] ep00wire, ep02wire, ep05wire;
 
wire mst_reset;
wire select; 
wire [31:0] pipe_out_data;
wire [31:0] pipe_in_data;
wire pipe_in_write;
wire pipe_out_read;
wire full, empty;
wire [9:0] data_count; 

/* dac */
wire [31:0] dout;
reg  [32:0] dout_r;
wire [11:0] dac_input_data;


/* --- Assign Variables --- */
assign mst_reset = ep00wire[0];
assign select = ep02wire[0];
assign dac_input_data = {4'b0, pipe_out_data[7:0]}; // each sample byte = 8bits, so 12 bits should be enough, TODO: for now the preceding 24bits are wasted.


//***************************************************************************
// Instantiate DAC controller
//***************************************************************************
my_dac_top dac_top(
	.clk             (okClk),
	.reset           (mst_reset),

	.ampl            (dac_input_data),
	.dac_data        (dac_output_data),
	.dac_clk         (dac_clk),
	.dac_reset_pinmd (dac_reset_pinmd),
	.dac_sclk        (dac_sclk),
	.dac_sdio        (dac_sdio),
	.dac_cs_n        (dac_cs_n)
);


//***************************************************************************
// Instantiate DDR3 controller
//***************************************************************************
// TODO: check these signals, modify the following and define vars accordingly
ddr3_controller
(
    // Inouts
    inout [31:0] ddr3_dq,
    inout [3:0]ddr3_dqs_n,
    inout [3:0]ddr3_dqs_p,

    // Outputs
    output [14:0] ddr3_addr,
    output [2:0]ddr3_ba,
    output ddr3_ras_n,
    output ddr3_cas_n,
    output ddr3_we_n,
    output ddr3_reset_n,
    output [0:0]ddr3_ck_p,
    output [0:0]ddr3_ck_n,
    output [0:0] ddr3_cke,

    output [3:0]ddr3_dm,

    output [0:0] ddr3_odt,


    // Inputs

    // Single-ended system clock
    input sys_clk_i,

    output tg_compare_error,
    output init_calib_complete,

    // System reset - Default polarity of sys_rst pin is Active Low.
    // System reset polarity will change based on the option 
    // selected in GUI.
    input sys_rst
 );

//***************************************************************************
// Instantiate USB controller (via frontpanel API)
//***************************************************************************
my_usb_controller usb_controller();

// TODO: encapsulate this part
// /* --- Front Panel Implementation --- */
// okWireOR # (.N(2)) wireOR (okEH, okEHx); 
// okWireIn   wi00(.okHE(okHE), .ep_addr(8'h00), .ep_dataout(ep00wire)); // [0]: mst_reset
// okWireIn   wi02(.okHE(okHE), .ep_addr(8'h02), .ep_dataout(ep02wire)); // [0]: select
// okWireIn   wi05(.okHE(okHE), .ep_addr(8'h05), .ep_dataout(ep05wire)); // = freq_fpga / freq_file

// okHost okHI(
// 	.okUH   (okUH),
// 	.okHU   (okHU),
// 	.okUHU  (okUHU),
// 	.okAA   (okAA),
// 	.okClk  (okClk),
// 	.okHE   (okHE),
// 	.okEH   (okEH)
// );

// okPipeIn ep80(
// 	.okHE           (okHE),
// 	.okEH           (okEHx[0 * 65 +: 65]),
// 	.ep_addr        (8'h80),
// 	.ep_write       (pipe_in_write), // data should be captured when this is asserted
// 	.ep_dataout     (pipe_in_data) // data out
	
// );

// okPipeOut epa3(
// 	.okHE			(okHE),
// 	.okEH			(okEHx[1 * 65 +: 65]),
// 	.ep_addr		(8'ha3),
// 	.ep_datain		(pipe_out_data),
// 	.ep_read		(pipe_out_read)
// );


//***************************************************************************
// Instantiate FIFO module (USB - DDR3 SDRAM)
//***************************************************************************
// TODO: need to create ip, FIFO (32 x 1024)? maybe add the size?
// TODO: change the design according to the need of DDR3
fifo_generator_0 fifo(
	.clk        (okClk),
	.srst       (mst_reset),
	// FIFO_WRITE
	.full       (full), // output full signal
	.din        (pipe_in_data), // write data
	.wr_en      (pipe_in_write), // write enable, data should be written when it's asserted
	// FIFO_READ
	.empty      (empty), // output empty signal
	.dout       (pipe_out_data), // 32bit
	.rd_en      (pipe_out_read), // read enable
	// Data Count
	.data_count (data_count) // 10 bit, data count, number of words, should range from 0-1024
);



//***************************************************************************
// Instantiate FIFO module (DDR3 SDRAM - DAC)
//***************************************************************************
// TODO: need to create ip, FIFO (32 x 1024)? maybe add the size?
// TODO: change the design according to the need of DDR3
fifo_generator_0 fifo(
	.clk        (okClk),
	.srst       (mst_reset),
	// FIFO_WRITE
	.full       (full), // output full signal
	.din        (pipe_in_data), // write data
	.wr_en      (pipe_in_write), // write enable, data should be written when it's asserted
	// FIFO_READ
	.empty      (empty), // output empty signal
	.dout       (pipe_out_data), // 32bit
	.rd_en      (pipe_out_read), // read enable
	// Data Count
	.data_count (data_count) // 10 bit, data count, number of words, should range from 0-1024
);



//***************************************************************************
// Use LED for state prompt
//***************************************************************************
function [7:0] xem7320_led;
	input [7:0] a;
	integer i;
	begin
		for(i = 0; i < 8; i =i + 1) begin: u
			xem7320_led[i] = (a[i]==1'b1) ? (1'b0) : (1'bz);
		end
	end
endfunction

assign led = xem7320_led({empty, full});  // TODO: assign these to more useful vars



//***************************************************************************
// controller for receiving arduino signal and play sound
//***************************************************************************


endmodule