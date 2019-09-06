module user_dataflow(
    
    input clk, 
    input rst, 

    input init_calib_complete,
    input app_rdy, // ~ memc_cmd_full
    output app_en,
    output[2:0] app_cmd,

    output [5:0] app_addr,
    output app_wdf_wren,
    output app_wdf_end,
    output [DATA_WIDTH/8 - 1:0] app_wdf_mask,
    output [DATA_WIDTH - 1:0] app_wdf_data,
    input ~app_wdf_rdy, // ~ full
    input [DATA_WIDTH - 1:0] app_rd_data,
    input app_rd_data_valid

);




endmodule