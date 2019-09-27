module dac_phy(
	input  wire        clk,
	input  wire        reset,

	input  wire [11:0] data_i,
	input  wire [11:0] data_q,

	output wire [11:0] dac_data,
	output wire        dac_clk
);

ODDR #(
      .DDR_CLK_EDGE ("OPPOSITE_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
      .INIT         (1'b0),            // Initial value of Q: 1'b0 or 1'b1
      .SRTYPE       ("SYNC")           // Set/Reset type: "SYNC" or "ASYNC" 
   ) ODDR_inst(
      .Q            (dac_clk),         // 1-bit DDR output
      .C            (clk),             // 1-bit clock input
      .CE           (1'b1),            // 1-bit clock enable input
      .D1           (1'b1),            // 1-bit data input (positive edge)
      .D2           (1'b0),            // 1-bit data input (negative edge)
      .R            (1'b0),            // 1-bit reset
      .S            (1'b0)             // 1-bit set
);

wire        phy_clk, locked;
reg  [11:0] data_i_r, data_q_r;

always @(posedge phy_clk) begin
	if (reset) begin
		data_i_r <= 12'd0;
		data_q_r <= 12'd0;
	end else begin
		data_i_r <= data_i;
		data_q_r <= data_q;
	end
end

// TODO: create and instantiate the two ip cores
clk_wiz_0 phy_pll(
	// Clock out ports
	.clk_out1 (phy_clk),
	// Status and control signals
	.reset    (reset),
	.locked   (locked),
	// Clock in ports
	.clk_in1  (clk)
);

selectio_wiz_0 dac_io(
	.data_out_from_device ({data_q_r, data_i_r}),
	.data_out_to_pins     (dac_data),
	.clk_in               (phy_clk),
	.io_reset             (~locked)
);




endmodule