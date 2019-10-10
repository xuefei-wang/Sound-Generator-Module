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

	/* DDR3 */
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

    /* Clock */
    input wire sys_clkn,
    input wire sys_clkp
    
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

wire sys_rst;
wire tg_compare_error;
wire sys_clk_i;
wire app_rd_data_valid;


/* FIFOs */
wire [3:0] rd_data_count_0;
wire [6:0] wr_data_count_0;
wire [6:0] rd_data_count_1;
wire [3:0] wr_data_count_1;

wire full_0;
wire empty_0;
wire full_1;
wire empty_1;

wire rd_rst_busy_0;
wire wr_rst_busy_0;
wire rd_rst_busy_1;
wire wr_rst_busy_1;

//***************************************************************************
// Assign Variables
//***************************************************************************
// assign dac_input_data = {4'b0, pipe_out_data[7:0]}; // each sample byte = 8bits, so 12 bits should be enough, TODO: for now the preceding 24bits are wasted.
assign input_read_addr = 29'b0;
assign input_write_addr = 29'b0;
assign input_read_cnt = 6'd10;
assign input_write_cnt = 6'd10;

assign sys_rst = mst_reset;
assign dac_clk = okClk;

//***************************************************************************
// Turn double-ended clock into single-ended
//***************************************************************************

IBUFDS #(
    .DIFF_TERM    ("TRUE")
)IBUFDS_data_inst(
    .O(sys_clk_ibufg),
    .I(sys_clkp),
    .IB(sys_clkn)
);

IBUFG  u_ibufg_sys_clk(
    .I  (sys_clk_ibufg),
    .O  (sys_clk_i)
);

//***************************************************************************
// Instantiate DDR3 controller
//***************************************************************************
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
fifo_generator_0 fifo_generator_usb2ddr (
  .rst(mst_reset),                      // input wire rst
  .wr_clk(okClk),                // input wire wr_clk
  .rd_clk(sys_clk_i),                // input wire rd_clk
  .din(pipe_in_data),                      // input wire [31 : 0] din
  .wr_en(pipe_in_write),                  // input wire wr_en
  .rd_en(app_wdf_wren),                  // input wire rd_en
  .dout(input_write_data),                    // output wire [255 : 0] dout
  .full(full_0),                    // output wire full
  .empty(empty_0),                  // output wire empty
  .rd_data_count(rd_data_count_0),  // output wire [3 : 0] rd_data_count
  .wr_data_count(wr_data_count_0),  // output wire [6 : 0] wr_data_count
  .wr_rst_busy(wr_rst_busy_0),      // output wire wr_rst_busy
  .rd_rst_busy(rd_rst_busy_0)      // output wire rd_rst_busy
);

//***************************************************************************
// Instantiate FIFO module (DDR3 - USB SDRAM) TODO: delete this when DAC is incorporated
//***************************************************************************
fifo_generator_1 fifo_generator_ddr2usb(
  .rst(mst_reset),                      // input wire rst
  .wr_clk(sys_clk_i),                // input wire wr_clk
  .rd_clk(okClk),                // input wire rd_clk //TODO: change this when DAC is incorporated
  .din(app_rd_data),                      // input wire [255 : 0] din
  .wr_en(app_rd_data_valid),                  // input wire wr_en
  .rd_en(pipe_out_read),                  // input wire rd_en
  .dout(pipe_out_data),                    // output wire [31 : 0] dout
  .full(full_1),                    // output wire full
  .empty(empty_1),                  // output wire empty
  .rd_data_count(rd_data_count_1),  // output wire [6 : 0] rd_data_count
  .wr_data_count(wr_data_count_1),  // output wire [3 : 0] wr_data_count
  .wr_rst_busy(wr_rst_busy_1),      // output wire wr_rst_busy
  .rd_rst_busy(rd_rst_busy_1)      // output wire rd_rst_busy
);


//***************************************************************************
// Instantiate FIFO module (DDR3 SDRAM - DAC)
//***************************************************************************
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