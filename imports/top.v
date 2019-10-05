module top(
    /* FrontPanel */
    input  wire [4:0]  okUH,
	output wire [3:0]  okHU,
	input  wire [3:0]  okRSVD,
	inout  wire [31:0] okUHU,
	inout  wire        okAA,

    /* DAC */
	// output wire [11:0] dac_output_data,        // I/Q Data
	// output wire        dac_clk,
	// output wire        dac_reset_pinmd,
	// output wire        dac_sclk,        // SPI Clock
	// inout  wire        dac_sdio,        // SPI Data I/O
	// output wire        dac_cs_n,        // SPI Chip Select

    /* LED */
    output wire [7:0]  led,

	/* DDR3 */ // TODO: check this part
    inout wire [31:0] ddr3_dq,
    inout wire [3:0] ddr3_dqs_n,
    inout wire [3:0] ddr3_dqs_p,

    /* Outputs */
    output wire [14:0] ddr3_addr,
    output wire [2:0] ddr3_ba,
    output wire ddr3_ras_n,
    output wire ddr3_cas_n,
    output wire ddr3_we_n,
    output wire ddr3_reset_n,
    output wire [0:0] ddr3_ck_p,
    output wire [0:0] ddr3_ck_n,
    output wire [0:0] ddr3_cke,

    output wire [3:0] ddr3_dm,

    output wire [0:0] ddr3_odt,

    output wire tg_compare_error,
    
    input wire sys_rst // System reset - Default polarity of sys_rst pin is Active Low, System reset polarity will change based on the option, selected in GUI.
);


//***************************************************************************
// Define variables
//***************************************************************************
wire full, empty;
wire [9:0] data_count; 

/* dac */
// wire [31:0] dout;
// reg  [32:0] dout_r;
// wire [11:0] dac_input_data;


/* USB */
wire okClk;
wire pipe_in_write;
wire [31:0] pipe_in_data;
wire pipe_out_read;
wire [31:0] pipe_out_data;

/* DDR3 */
wire init_calib_complete;
wire [255:0] input_write_data;
wire [255:0] app_rd_data;
wire app_wdf_wren;

wire [28:0] input_read_addr;
wire [28:0] input_write_addr;
wire [5:0] input_read_cnt;
wire [5:0] input_write_cnt;


/* FIFOs */
wire [14:0] rd_data_count_0;
wire [17:0] wr_data_count_0;
wire [19:0] rd_data_count_1;
wire [16:0] wr_data_count_1;



//***************************************************************************
// Assign Variables
//***************************************************************************
// assign dac_input_data = {4'b0, pipe_out_data[7:0]}; // each sample byte = 8bits, so 12 bits should be enough, TODO: for now the preceding 24bits are wasted.
assign input_read_addr = 28'b0;
assign input_write_addr = 28'b0;
assign input_read_cnt = 6'd10;
assign input_write_cnt = 6'd10;

assign sys_rst = mst_reset;

//***************************************************************************
// Instantiate DDR3 controller
//***************************************************************************
// TODO: check these signals, modify the following and define vars accordingly
ddr3_controller my_ddr3_controller(
    // Inouts
    .ddr3_dq(ddr3_dq),
    .ddr3_dqs_n(ddr3_dqs_n),
    .ddr3_dqs_p(ddr3_dqs_p),

    // Outputs
    .ddr3_addr(ddr3_addr),
    .ddr3_ba(ddr3_ba),
    .ddr3_ras_n(ddr3_ras_n),
    .ddr3_cas_n(ddr3_cas_n),
    .ddr3_we_n(ddr3_we_n),
    .ddr3_reset_n(ddr3_reset_n),
    .ddr3_ck_p(ddr3_ck_p),
    .ddr3_ck_n(ddr3_ck_n),
    .ddr3_cke(ddr3_cke),

    .ddr3_dm(ddr3_dm),

    .ddr3_odt(ddr3_odt),
    
    // Inputs
    .input_read_addr(input_read_addr),
    .input_write_addr(input_write_addr),
    .input_read_cnt(input_read_cnt), // TODO: modify this width
    .input_write_cnt(input_write_cnt),

    // Single-ended system clock
    .sys_clk_i(sys_clk_i),

    .tg_compare_error(tg_compare_error),
    .init_calib_complete(init_calib_complete),

    // System reset - Default polarity of sys_rst pin is Active Low.
    // System reset polarity will change based on the option 
    // selected in GUI.
    .sys_rst(sys_rst),

    .input_write_data(input_write_data),
    .app_rd_data(app_rd_data),
    .app_wdf_wren(app_wdf_wren),
    .app_rd_data_valid(app_rd_data_valid)
 );

// TODO: find how to write sys_clk_i signal
// sys_rst? how many resets can be used in this system?

//***************************************************************************
// Instantiate USB controller (via frontpanel API)
//***************************************************************************
usb_controller my_usb_controller(
	.okUH(okUH),
	.okHU(okHU),
	.okRSVD(okRSVD),
	.okUHU(okUHU),
	.okAA(okAA),
    .okClk(okClk),
    .ep_write(pipe_in_write), // from host to target
    .ep_dataout(pipe_in_data), // from host to target
    .ep_read(pipe_out_read),
    .ep_datain(pipe_out_data),
    
    .mst_reset(mst_reset)
    // .select(select)

);


//***************************************************************************
// Instantiate DAC controller
//***************************************************************************
// dac_top my_dac_top(
// 	.clk             (okClk),
// 	.reset           (mst_reset),

// 	.ampl            (dac_input_data),
// 	.dac_data        (dac_output_data),
// 	.dac_clk         (dac_clk),
// 	.dac_reset_pinmd (dac_reset_pinmd),
// 	.dac_sclk        (dac_sclk),
// 	.dac_sdio        (dac_sdio),
// 	.dac_cs_n        (dac_cs_n)
// );



//***************************************************************************
// Instantiate FIFO module (USB - DDR3 SDRAM)
//***************************************************************************
// TODO: need to create ip, FIFO (32 x 1024)? maybe add the size?
// TODO: change the design according to the need of DDR3
fifo_generator_0 fifo_generator_usb2ddr(
	.clk        (okClk),
	.srst       (mst_reset),
	// FIFO_WRITE
	.full       (full), // output full signal
	.din        (pipe_in_data), // write data, [31:0]
	.wr_en      (pipe_in_write), // write enable, data should be written when it's asserted
	// FIFO_READ
	.empty      (empty), // output empty signal
	.dout       (input_write_data), // [255:0]
	.rd_en      (app_wdf_wren), // read enable
	// Data Count
	.rd_data_count(rd_data_count_0),  // output wire [14 : 0] rd_data_count_0
    .wr_data_count(wr_data_count_0)  // output wire [17 : 0] wr_data_count_0

);


//***************************************************************************
// Instantiate FIFO module (DDR3 - USB SDRAM) TODO: delete this when DAC is incorporated
//***************************************************************************
fifo_generator_1 fifo_generator_ddr2usb (
	.clk        (okClk),
	.srst       (mst_reset),
	// FIFO_WRITE
	.full       (full), // output full signal
	.din        (app_rd_data), // write data, [255 : 0]
	.wr_en      (app_rd_data_valid), // write enable, data should be written when it's asserted
	// FIFO_READ
	.empty      (empty), // output empty signal
	.dout       (pipe_out_data), // [31 : 0]
	.rd_en      (pipe_out_read), // read enable
	// Data Count
	.rd_data_count(rd_data_count_1),  // output wire [19 : 0] rd_data_count_1
    .wr_data_count(wr_data_count_1)  // output wire [16 : 0] wr_data_count_1
);

//***************************************************************************
// Instantiate FIFO module (DDR3 SDRAM - DAC)
//***************************************************************************
// // TODO: need to create ip, FIFO (32 x 1024)? maybe add the size?
// // TODO: change the design according to the need of DDR3
// fifo_generator_0 fifo(
// 	.clk        (okClk),
// 	.srst       (mst_reset),
// 	// FIFO_WRITE
// 	.full       (full), // output full signal
// 	.din        (pipe_in_data), // write data
// 	.wr_en      (pipe_in_write), // write enable, data should be written when it's asserted
// 	// FIFO_READ
// 	.empty      (empty), // output empty signal
// 	.dout       (pipe_out_data), // 32bit
// 	.rd_en      (pipe_out_read), // read enable
// 	// Data Count
// 	.data_count (data_count) // 10 bit, data count, number of words, should range from 0-1024
// );



//***************************************************************************
// Use LED for state prompt
//***************************************************************************
// function [7:0] xem7320_led;
// 	input [7:0] a;
// 	integer i;
// 	begin
// 		for(i = 0; i < 8; i =i + 1) begin: u
// 			xem7320_led[i] = (a[i]==1'b1) ? (1'b0) : (1'bz);
// 		end
// 	end
// endfunction

// assign led = xem7320_led({empty, full});  // TODO: assign these to more useful vars



//***************************************************************************
// controller for receiving arduino signal and play sound
//***************************************************************************


endmodule