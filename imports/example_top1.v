`timescale 1ps/1ps

module example_top1
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

// define variables, related to mig
reg [28:0] app_addr;
reg [2:0] app_cmd;
reg app_en; 

reg [255:0] app_wdf_data;
wire app_wdf_end;
reg app_wdf_wren;

wire [255:0] app_rd_data;
wire app_rd_data_end; 
wire app_rd_data_valid;
    
wire app_rdy; 
wire app_wdf_rdy; 
    
wire [31:0] app_wdf_mask;

wire app_sr_req;
wire app_ref_req;
wire app_zq_req;
wire app_sr_active;
wire app_ref_ack;
wire app_zq_ack;
    
wire ui_clk; 
wire ui_clk_sync_rst;
    

assign app_wdf_end = app_wdf_wren;
assign app_wdf_mask = 32'd0;

assign app_sr_req = 0;
assign app_ref_req = 0;
assign app_zq_req = 0;


// define variables, related  to user design (my state machine)
reg [4:0] read_cnt;
reg [4:0] write_cnt;
reg [28:0] read_addr;
reg [28:0] write_addr;
reg [2:0] state;
reg [2:0] next;
reg [255:0] save_data [32:0];
reg [4:0] save_cnt;

parameter [2:0] s_idle_begin = 3'b000,
                s_write = 3'b001,
                s_idle_w2r = 3'b010,
                s_read = 3'b011,
                s_idle_end = 3'b100,
                s_initialize = 3'b101,
                s_write_wait = 3'b110,
                s_read_wait = 3'b111;

parameter [2:0] cmd_write = 3'b000,
                cmd_read = 3'b001;

 mig_7series_0 u_mig_7series_0 (

    // Memory interface ports, connect to top module directly
    .ddr3_addr (ddr3_addr), // output [14:0]
    .ddr3_ba (ddr3_ba), // output [2:0]
    .ddr3_cas_n (ddr3_cas_n), // output
    .ddr3_ck_n (ddr3_ck_n), // output [0:0]
    .ddr3_ck_p (ddr3_ck_p), // output [0:0]
    .ddr3_cke (ddr3_cke), // output [0:0]
    .ddr3_ras_n (ddr3_ras_n), // output
    .ddr3_reset_n (ddr3_reset_n), // output
    .ddr3_we_n (ddr3_we_n), // output
    .ddr3_dq (ddr3_dq), // inout [31:0]
    .ddr3_dqs_n (ddr3_dqs_n), // inout [3:0]
    .ddr3_dqs_p (ddr3_dqs_p), // inout [3:0]
    .init_calib_complete (init_calib_complete), // output
    .ddr3_dm (ddr3_dm), // output [3:0]
    .ddr3_odt (ddr3_odt), // output [0:0]
    
    // Application interface ports, useful
    .app_addr (app_addr), // input [28:0], 好�?是按照8增加？？
    .app_cmd (app_cmd), // input [2:0], 3'b000: write, 3'b001: read
    .app_en(app_en), // input, 

    .app_wdf_data (app_wdf_data), // input [255:0], 
    .app_wdf_end(app_wdf_end), // input, just directly connect to app_wdf_wren, https://www.xilinx.com/support/answers/62568.html
    .app_wdf_wren (app_wdf_wren), // input, for reference, app_wdf_wren = app_en & app_wdf_rdy & app_rdy & (app_cmd == 3'd0);

    .app_rd_data(app_rd_data), // output [255:0], valid when app_rd_data_valid = 1
    .app_rd_data_end (app_rd_data_end), // output, ignore
    .app_rd_data_valid (app_rd_data_valid), // output
    
    .app_rdy (app_rdy), // output, 
    .app_wdf_rdy(app_wdf_rdy), // output,
    
    .app_wdf_mask (app_wdf_mask), // input [31:0]

    // Application interface, not important, TODO: temp set to 1, check later
    .app_sr_req (app_sr_req), // input
    .app_ref_req(app_ref_req), // input
    .app_zq_req (app_zq_req), // input
    .app_sr_active (app_sr_active), // output
    .app_ref_ack(app_ref_ack), // output
    .app_zq_ack (app_zq_ack), // output
    
    // 
    .ui_clk(ui_clk), // output, TODO: check this
    .ui_clk_sync_rst (ui_clk_sync_rst), // output,ignore 
    
    
    // System Clock Ports, connect to top module directly
    .sys_clk_i(sys_clk_i),
    .sys_rst(sys_rst) 
 );


always @(posedge ui_clk or posedge ui_clk_sync_rst)
begin
    if(ui_clk_sync_rst)
        state <= s_initialize;
    else 
        state <= next;
end

always @(*)
begin
    next = 3'bxxx;
    case(state)
    s_initialize:
    begin
        write_cnt = 5'd20;
        read_cnt = 5'd20;
        app_addr = 29'b0;
        app_wdf_data = 256'b0;
        app_en = 1'b0;
        if(init_calib_complete)
            next = s_write;
        else
            next = s_initialize;
    end

    s_write:
    begin
        app_en = 1'b1;
        app_wdf_wren = 1'b1;
        app_cmd = cmd_write;
        
        if(write_cnt == 0)
        begin
            next = s_read;
            app_addr = 29'b0;
        end 
        else if(app_rdy == 1 && app_wdf_rdy == 1)
        begin
            next = s_write;
            app_addr = app_addr + 29'd8;
            app_wdf_data = app_wdf_data + 256'd2;
            write_cnt = write_cnt - 5'd1;
        end
    end


    s_read:
    begin
        app_en = 1'b1;
        app_wdf_wren = 1'b0;
        app_cmd = cmd_read;

        if(read_cnt == 0)
            next = s_idle_end;
        else if(app_rdy == 1)
        begin
            next = s_read;
            app_addr = app_addr + 29'd8;
            read_cnt = read_cnt - 5'b1;
        end

    end


    s_idle_end:
    begin
        app_en = 1'b0;
    end

    endcase
end


always @(posedge ui_clk)
begin
    if(app_rd_data_valid)
    begin
        save_data[save_cnt] <= app_rd_data;
        save_cnt <= save_cnt + 5'b1;
    end
end


endmodule