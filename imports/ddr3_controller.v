`timescale 1ps/1ps

module ddr3_controller
(
    // Inouts
    inout wire [31:0] ddr3_dq,
    inout wire [3:0] ddr3_dqs_n,
    inout wire [3:0] ddr3_dqs_p,

    // Outputs
    output wire [14:0] ddr3_addr,
    output wire [2:0]ddr3_ba,
    output wire ddr3_ras_n,
    output wire ddr3_cas_n,
    output wire ddr3_we_n,
    output wire ddr3_reset_n,
    output wire [0:0] ddr3_ck_p,
    output wire [0:0] ddr3_ck_n,
    output wire [0:0] ddr3_cke,

    output wire [3:0]ddr3_dm,

    output wire [0:0] ddr3_odt,

    // Inputs
    input wire [28:0] input_read_addr,
    input wire [28:0] input_write_addr,
    input wire [5:0] input_read_cnt, // TODO: modify this width
    input wire [5:0] input_write_cnt,

    // Single-ended system clock
    input wire sys_clk_i,

    output wire tg_compare_error,
    output wire init_calib_complete,

    // System reset - Default polarity of sys_rst pin is Active Low.
    // System reset polarity will change based on the option 
    // selected in GUI.
    input wire sys_rst,

    // TODO: not sure if this is a correct design
    input [255:0] input_write_data,
    output [255:0] app_rd_data,
    output wire app_wdf_wren,
    output wire app_rd_data_valid
 );

//***************************************************************************
// Define Variables (MIG)
//***************************************************************************
reg [28:0] app_addr_next, app_addr;
reg [2:0] app_cmd_next, app_cmd;
reg app_en_next, app_en; 

reg [255:0] app_wdf_data_next, app_wdf_data;
wire app_wdf_end;

wire app_rd_data_end; 

    
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
    
assign app_wdf_wren = app_en & app_wdf_rdy & app_rdy & (app_cmd == 3'd0);
assign app_wdf_end = app_wdf_wren;
assign app_wdf_mask = 32'd0;

assign app_sr_req = 0;
assign app_ref_req = 0;
assign app_zq_req = 0;


//***************************************************************************
// Define Variables (FSM)
//***************************************************************************
reg [4:0] read_cnt_next, read_cnt_reg;
reg [4:0] write_cnt_next, write_cnt_reg;
reg [28:0] read_addr_next, read_addr_reg;
reg [28:0] write_addr_next, write_addr_reg;
reg [2:0] state;
reg [2:0] next;
reg [255:0] save_data [32:0];
reg [4:0] save_cnt;

parameter [2:0] s_idle_write = 3'b000,
                s_write = 3'b001,
                s_idle_read = 3'b010,
                s_read = 3'b011,
                s_end = 3'b100,
                s_initialize = 3'b101;

parameter [2:0] cmd_write = 3'b000,
                cmd_read = 3'b001;

//***************************************************************************
// Instantiate MIG
//***************************************************************************
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
    .app_wdf_wren (app_wdf_wren), // input

    .app_rd_data(app_rd_data), // output [255:0], valid when app_rd_data_valid = 1
    .app_rd_data_end (app_rd_data_end), // output, ignore
    .app_rd_data_valid (app_rd_data_valid), // output
    
    .app_rdy (app_rdy), // output, 
    .app_wdf_rdy(app_wdf_rdy), // output,
    
    .app_wdf_mask (app_wdf_mask), // input [31:0]

    // Application interface
    .app_sr_req (app_sr_req), // input
    .app_ref_req(app_ref_req), // input
    .app_zq_req (app_zq_req), // input
    .app_sr_active (app_sr_active), // output
    .app_ref_ack(app_ref_ack), // output
    .app_zq_ack (app_zq_ack), // output
    
    // ui clock & reset
    .ui_clk(ui_clk), // output
    .ui_clk_sync_rst (ui_clk_sync_rst), // output,ignore 
    
    
    // System Clock Ports, connect to top module directly
    .sys_clk_i(sys_clk_i),
    .sys_rst(sys_rst) 
 );


//***************************************************************************
// State combinatorial block
//***************************************************************************
always @(posedge ui_clk or posedge ui_clk_sync_rst)
begin
    if(ui_clk_sync_rst)
        state <= s_initialize;
    else 
        state <= next;
end


//***************************************************************************
// Output combinatorial block
//***************************************************************************
always @(posedge ui_clk or posedge ui_clk_sync_rst)
begin
    if(ui_clk_sync_rst)
    begin
        read_cnt_reg <= input_read_cnt;
        write_cnt_reg <= input_write_cnt;
        read_addr_reg <= input_read_addr;
        write_addr_reg <= input_write_addr;
        app_addr <= 29'b0;
        app_cmd <= cmd_write;
        app_en <= 1'b0; 

        app_wdf_data <= 256'b0;
        save_cnt <= 5'b0;

    end
    else 
    begin
        if(app_rdy && app_wdf_rdy)
        begin
            write_cnt_reg <= write_cnt_next;
            write_addr_reg <= write_addr_next;
            app_wdf_data <= app_wdf_data_next;    
        end
        
        if(app_rdy)
        begin
            app_addr <= app_addr_next;
            app_cmd <= app_cmd_next;
            app_en <= app_en_next;
            read_cnt_reg <= read_cnt_next;
            read_addr_reg <= read_addr_next;
        end
        
        if(app_rd_data_valid)
        begin
            save_data[save_cnt] <= app_rd_data;
            save_cnt <= save_cnt + 5'b1;
        end
        
    end
end

//***************************************************************************
// State sequential block
//***************************************************************************
always @(*)
begin
    next = 3'bxxx;
    case(state)
    s_initialize:
    begin
        if(init_calib_complete)
            next = s_idle_write;
        else
            next = s_initialize;
    end

    s_idle_write:
    begin
        if(app_rdy && app_wdf_rdy)
        begin
            next = s_write;
        end
        else  
            next = s_idle_write;
    end 

    s_write:
    begin
        if(write_cnt_reg == 0)
        begin
            next = s_read;
        end 
        else if(app_rdy != 1 || app_wdf_rdy != 1)
            next = s_idle_write;
        else
        begin
            next = s_write;
        end 
    end


    s_idle_read:
    begin
        if(app_rdy)
        begin
            next = s_read;
        end   
        else
            next = s_idle_read;
    end

    s_read:
    begin
        if(read_cnt_reg == 0)
            next = s_end;
        else if(app_rdy != 1)
            next = s_idle_read;
        else
        begin
            next = s_read;
        end

    end

    s_end:
    begin
        next = s_end;
    end

    endcase
end


//***************************************************************************
// Output sequential block
//***************************************************************************
always @(*)
begin
    case(state)
    s_initialize:
    begin
        write_cnt_next = 5'd10;
        read_cnt_next = 5'd10;
        app_addr_next = 29'b0;
        read_addr_next = 29'b0;
        write_addr_next = 29'b0;
        app_wdf_data_next = 256'b0;
    end

    s_idle_write:
    begin
        app_en_next = 1'b1;
        
        app_cmd_next = cmd_write;
    end 

    s_write:
    begin
        app_en_next = 1'b1;
        
        app_cmd_next = cmd_write;
        
        if(app_rdy == 1 && app_wdf_rdy == 1)
        begin
            app_addr_next = write_addr_reg;
            write_addr_next = write_addr_reg + 29'd8;
            app_wdf_data_next = input_write_data;
            // input_write_enable = 1;
            write_cnt_next = write_cnt_reg - 5'd1;
        end 
    end


    s_idle_read:
    begin
        app_en_next = 1'b1;
        
        app_cmd_next = cmd_read;
    end

    s_read:
    begin
        app_en_next = 1'b1;
        
        app_cmd_next = cmd_read;
        if(app_rdy == 1)
        begin
            app_addr_next = read_addr_reg;
            read_addr_next = read_addr_reg + 8;
            read_cnt_next = read_cnt_reg - 1;
        end

    end

    s_end:
    begin
        app_en_next = 1'b0;
    end

    endcase
end

endmodule