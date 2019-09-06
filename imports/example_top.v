`timescale 1ps/1ps

module example_top
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



 
 reg [3:0] test_state;
 reg [15:0] send_cnt;
 reg [28:0] write_addr;
 reg [28:0] read_addr;
 reg [255:0] data_buff;
 wire app_rd_data_end;
 wire app_sr_req = 0;
 wire app_ref_req = 0;
 wire app_zq_req = 0;
 wire app_sr_active;
 wire app_ref_ack;
 wire app_zq_ack;
 reg [2:0] app_cmd;
 
 wire app_rd_data_valid;
 wire [28:0] app_addr;
 reg app_en;
 wire app_rdy;

 reg [255:0] app_wdf_data;
 wire app_wdf_end;
 wire app_wdf_wren;
 wire app_wdf_rdy;

 wire [255:0] app_rd_data;
 wire [31:0] app_wdf_mask;
 
 wire ui_clk_sync_rst;
 wire ui_clk;
 wire sys_clk_i;

IBUFDS ibufds_clk(
    .O(sys_clk_i),
    .I(sys_clk_p),
    .IB(sys_clk_n)
);
 
 
 assign app_wdf_wren = 	app_en & app_wdf_rdy & app_rdy & (app_cmd == 3'd0);
 assign app_wdf_end = 	app_wdf_wren;

 assign app_addr = (app_cmd == 3'd0) ? write_addr : read_addr;

 assign app_wdf_mask = 32'd0;


 mig_7series_0 u_mig_7series_0 (

    // Memory interface ports
    .ddr3_addr (ddr3_addr), // output [14:0]
    .ddr3_ba (ddr3_ba), // output [2:0]
    .ddr3_cas_n (ddr3_cas_n), // output, 
    .ddr3_ck_n (ddr3_ck_n), // output [0:0]		ddr3_ck_n
    .ddr3_ck_p (ddr3_ck_p), // output [0:0]		ddr3_ck_p
    .ddr3_cke (ddr3_cke), // output [0:0]		ddr3_cke
    .ddr3_ras_n (ddr3_ras_n), // output			ddr3_ras_n
    .ddr3_reset_n (ddr3_reset_n), // output			ddr3_reset_n
    .ddr3_we_n (ddr3_we_n), // output			ddr3_we_n
    .ddr3_dq (ddr3_dq), // inout [31:0]		ddr3_dq
    .ddr3_dqs_n (ddr3_dqs_n), // inout [3:0]		ddr3_dqs_n
    .ddr3_dqs_p (ddr3_dqs_p), // inout [3:0]		ddr3_dqs_p
    .init_calib_complete (init_calib_complete), // output			init_calib_complete

    .ddr3_dm (ddr3_dm), // output [3:0]		ddr3_dm
    .ddr3_odt (ddr3_odt), // output [0:0]		ddr3_odt
    
    // Application interface ports
    .app_addr (app_addr), // input [28:0], 好�?是按照8增加？？
    .app_cmd (app_cmd), // input [2:0], 指令,3'b000: write, 3'b001: read
    .app_en(app_en), // input, 无论读写，都需�?设置这个=1

    .app_wdf_data (app_wdf_data), // input [255:0], 写入数�?�
    .app_wdf_end(app_wdf_end), // input,直接跟app_wdf_wren连在一起就行，https://www.xilinx.com/support/answers/62568.html
    .app_wdf_wren (app_wdf_wren), // input,写入数�?��?�使能，=1写入数�?��?有效, �?�考 app_wdf_wren = 	app_en & app_wdf_rdy & app_rdy & (app_cmd == 3'd0);

    .app_rd_data(app_rd_data), // output [255:0],读出的数�?�（在app_rd_data_valid=1的时候有效）
    .app_rd_data_end (app_rd_data_end), // output, ignore
    .app_rd_data_valid (app_rd_data_valid), // output,=1的时候app_rd_data有效
    
    .app_rdy (app_rdy), // output, 无论读写，都需�?等到这个=1
    .app_wdf_rdy(app_wdf_rdy), // output, =1 表示�?�以写了
    
    .app_sr_req (app_sr_req), // input,�?留
    .app_ref_req(app_ref_req), // input,刷新 
    .app_zq_req (app_zq_req), // input,校准
    .app_sr_active (app_sr_active), // output,�?留功能�?应 
    .app_ref_ack(app_ref_ack), // output, ignore
    .app_zq_ack (app_zq_ack), // output, ignore
    
    .ui_clk(ui_clk), // output, �?�?，用�?�写时�?逻辑
    .ui_clk_sync_rst (ui_clk_sync_rst), // output,ignore 
    .app_wdf_mask (app_wdf_mask), // input [31:0], =0�?��?�
    
    // System Clock Ports
    .sys_clk_i(sys_clk_i),
    .sys_rst(sys_rst) // input sys_rst
 );


always@(posedge ui_clk or negedge sys_rst)
begin
    if(!sys_rst)
    begin
        test_state <= 4'd0;
        send_cnt <= 16'd0;
        write_addr <= 29'd0;
        read_addr <= 29'd0;
        app_cmd <= 3'd0;
        app_en <= 1'b0;
        app_wdf_data <= 256'd0;
    end 
    else
    begin
        case (test_state)
            4'd0 : // initialize
            begin
                app_cmd <= 3'd0;
                app_en <= 1'b0;
                app_wdf_data <= 256'd0;
                send_cnt <= 16'd0;
                write_addr <= 29'd0;
                read_addr <= 29'd0;
                if(init_calib_complete)
                    test_state <= 4'd1; //如果DDR�?始化完�?就进入下一个状�?
                else
                    test_state <= 4'd0; //�?�则等待DDR�?始化完�?
            end
    
            4'd1 :
            begin
                if(app_rdy & app_wdf_rdy) // prepare to write
                begin
                    app_cmd <= 3'd0;
                    app_en <= 1'b1;
                    send_cnt <= send_cnt + 1'b1;
                    test_state <= 4'd2;
                end
            end
    
            4'd2 : 
            begin
                if(app_rdy & app_wdf_rdy) // keep writing
                begin
                    if(send_cnt == 16'd199) 
                    begin
                        app_wdf_data <= 256'd0;
                        write_addr <= 29'd0;
                        send_cnt <= 16'd0;
                        test_state <= 4'd3; //进入读状�?
                        app_en <= 1'b0;
                        end
                    else
                    begin
                        send_cnt <= send_cnt + 1'b1;
                        app_cmd <= 3'd0;
                        app_en <= 1'b1;
                        write_addr <= write_addr + 29'd8;
                        app_wdf_data <= app_wdf_data + 256'd1;//写入的数�?�，从1到198
                    end
                end
            end
            
            4'd3 : 
            begin
                if(app_rdy) // start reading
                begin
                    app_cmd <= 3'd1; //读命令有效，实际上这时候已�?有数�?�出�?�了
                    app_en <= 1'b1;
                    send_cnt <= send_cnt + 1'b1;
                    test_state <= 4'd4;
                end
            end
            
            4'd4 :
            begin
                if(app_rdy) // keep reading
                begin
                    if(send_cnt == 16'd199) 
                    begin
                        read_addr <= 29'd0;
                        send_cnt <= 16'd0;
                        test_state <= 4'd5;
                        app_en <= 1'b0;
                    end
                    else 
                    begin
                        send_cnt <= send_cnt + 1'b1;
                        app_cmd <= 3'd1;
                        app_en <= 1'b1;
                        read_addr <= read_addr + 29'd8; 
                    end
                end
            end
            
            4'd5 :// do nothing and go back to 'write'
            begin
                app_cmd <= 3'd0;
                app_en <= 1'b0;
                send_cnt <= send_cnt + 1'b1;
                if(send_cnt == 16'd200)
                begin
                    send_cnt <= 16'd0;
                    test_state <= 4'd1;
                end
            end
            
            default : test_state <= 4'd0;
            
        endcase
    end
end
        //比较写入与独处的数�?�是�?�相等
reg ddrdata_test_err;
always@(posedge ui_clk or negedge sys_rst)
begin
    if(!sys_rst)
    begin
        data_buff <= 256'd0;
        ddrdata_test_err <= 1'b0;
    end
    else if (test_state == 4'd3) 
    begin
        data_buff <= 256'd0;
    end
    else
    begin
        if(app_rd_data_valid)
        begin
            data_buff <= data_buff + 256'd1;
            if(data_buff != app_rd_data) //如果写入与独处的数�?��?相等就拉高
                ddrdata_test_err <= 1'b1;
        end
    end
end


// TODO: 研究一下，好�?似乎是因为时钟一开始会�?稳定
 // Power-on-reset generator circuit.
 // Asserts sys_rst for 1023 cycles, then deasserts
 // `sys_rst` is Active low reset
 // ，�?�一个例�?里使用clocking wizard的LOCKED赋值给reset
 //（管脚是时钟�?定管脚，因为PLL的输出时钟是需�?一定时间�?会稳定的，
 // 当LOCKED管脚为高的时候，就说明输出时钟稳定了)
reg [9:0] por_counter;
always @ (posedge sys_clk_i) begin
    por_counter <= 1023;
    if (por_counter) begin
        por_counter <= por_counter - 1 ;
    end
end

assign sys_rst = (por_counter == 0);
assign led = app_rd_data[7:0];





endmodule
