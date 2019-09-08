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
reg [255:0] save_data [32:0];
reg [4:0] save_cnt;

/***
    000: Initialize
    001: Idle
    010: Write
    011: Read
***/


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



always @(posedge ui_clk)
begin
    if(ui_clk_sync_rst)
    begin
        //TODO
        state <= 3'b000;
    end
    else
    begin
        case(state)
        3'b000: // Initialize
        begin
            app_en = 1'b0;
            read_cnt <= 5'd30;
            write_cnt <= 5'd30;
            save_cnt <= 5'd30;
            write_addr <= 29'd0;
            read_addr <= 29'd0;
            app_wdf_data <= 256'b0;

            if(init_calib_complete)
                state <= 3'b001;
            else
                state <= 3'b000;
            
        end 

        3'b001: // Idle
        begin
            app_en = 1'b0;
            if(app_rdy)
            begin
                if(write_cnt)
                    state <= 3'b010;
                else if(read_cnt)
                    state <= 3'b011; 
                else
                    state <= 3'b001;
            end
            else 
                state <= 3'b001;
        end

        3'b010: // Write
        begin
            if(app_wdf_rdy & app_rdy)
            begin
                if(!write_cnt)
                    state <= 3'b011;
                else
                begin
                    app_en <= 1'b1;
                    app_wdf_wren <= 1'b1;
                    app_cmd <= 3'b000;
                    // app_wdf_data <= app_wdf_data + 256'd2;
                    app_wdf_data <= 256'd5;
                    app_addr <= write_addr;
                    write_addr <= write_addr + 29'd8;
                    write_cnt <= write_cnt - 5'b1;
                    state <= 3'b010;
                end
            end
            else
                state <= 3'b001;
        end

        3'b011: // Read
        begin
            if(app_rdy)
            begin
                if(!read_cnt)
                    state <= 3'b001;
                else
                begin
                    app_en <= 1'b1;
                    app_addr <= read_addr;
                    app_cmd <= 3'b001;
                    read_addr <= read_addr + 29'd8;
                    read_cnt <= read_cnt - 5'b1;
                    state <= 3'b011;
                end
            end
            else
                state <= 3'b001;
        end

        default:
            state = 3'b000; // TODO: when it first starts, state = xxx (unknown) and calib is done, it goes to default

        endcase
    end
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