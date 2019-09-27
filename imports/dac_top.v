module dac_top(
    input  wire        clk,
	input  wire        reset,

    input  wire [11:0] ampl,
	output wire [11:0] dac_data,
	output wire        dac_clk,
	output wire        dac_reset_pinmd,
	output wire        dac_sclk, // SPI clock
	inout  wire        dac_sdio, // SPI data I/O
	output wire        dac_cs_n  // SPI Chip Select

);

// SPI
wire [5:0]  spi_reg;
wire [7:0]  spi_data_in, spi_data_out;
wire        spi_send, spi_done, spi_rw;

dac_spi spi(
	.clk          (clk),
	.reset        (reset),

	.dac_sclk     (dac_sclk),
	.dac_sdio     (dac_sdio),
	.dac_cs_n     (dac_cs_n),
	.dac_reset    (dac_reset_pinmd),

	.spi_reg      (spi_reg),      // DAC SPI register address
	.spi_data_in  (spi_data_in),  // Data to DAC
	.spi_data_out (spi_data_out), // Data from DAC (unused here)
	.spi_send     (spi_send),     // Send command
	.spi_done     (spi_done),     // Command is complete, data_out valid
	.spi_rw       (spi_rw)        // Read or write
);


wire        dac_ready;

dac_controller controller(
	.clk         (clk),
	.reset       (reset),

	.dac_fsadj   (16'h2020),

	.spi_reg     (spi_reg),
	.spi_data_in (spi_data_in),
	.spi_send    (spi_send),
	.spi_done    (spi_done),
	.spi_rw      (spi_rw),

	.dac_ready   (dac_ready)
);


dac_phy phy(
	.clk      (clk),
	.reset    (reset),

	.data_i   (ampl),
	.data_q   (ampl), // Output the same data on both channels

	.dac_data (dac_data),
	.dac_clk  (dac_clk)
);

endmodule


