module ctrl(/*AUTOARG*/
   // Outputs
   ack, wreg_we, conv_we, pool_we, mem_input_addr, mem_weight_addr,
   mem_feat_we, mem_feat_rst, mem_feat_addr, mem_feat_addr_d1,
   mem_output_we, mem_output_addr,
   // Inputs
   clk, xrst, req, input_addr, weight_addr, output_addr, total_in,
   total_out, img_w, img_h, fil_w, fil_h
   );
`include "parameters.vh"

  parameter WAIT = 'd0;
  parameter WREG = 'd1;
  parameter CONV = 'd2;
  parameter POOL = 'd3;

  /*AUTOINPUT*/
  input clk;
  input xrst;
  input req;
  input [INSIZE-1:0] input_addr;
  input [WSIZE-1:0]  weight_addr;
  input [OUTSIZE-1:0]  output_addr;
  input [LWIDTH-1:0] total_in;
  input [LWIDTH-1:0] total_out;
  input [LWIDTH-1:0] img_w;
  input [LWIDTH-1:0] img_h;
  input [LWIDTH-1:0] fil_w;
  input [LWIDTH-1:0] fil_h;

  /*AUTOOUTPUT*/
  output ack;
  output wreg_we;
  output conv_we;
  output pool_we;
  output [INSIZE-1:0] mem_input_addr;
  output [WSIZE-1:0] mem_weight_addr;
  output mem_feat_we;
  output mem_feat_rst;
  output [FACCUM-1:0] mem_feat_addr;
  output [FACCUM-1:0] mem_feat_addr_d1;
  output mem_output_we;
  output [OUTSIZE-1:0] mem_output_addr;

  /*AUTOWIRE*/
  wire wreg_start;
  wire wreg_valid;
  wire wreg_end;
  wire conv_start;
  wire conv_valid;
  wire conv_end;
  wire pool_start;
  wire pool_valid;
  wire pool_end;

  /*AUTOREG*/
  reg r_wreg_we;
  reg [1:0] r_state;
  reg [INSIZE-1:0] r_input_addr;
  reg [WSIZE-1:0]  r_weight_addr;
  reg [LWIDTH-1:0] r_img_w;
  reg [LWIDTH-1:0] r_img_h;
  reg [LWIDTH-1:0] r_fil_w;
  reg [LWIDTH-1:0] r_fil_h;
  reg [LWIDTH-1:0] r_fea_w;
  reg [LWIDTH-1:0] r_fea_h;
  reg [LWIDTH-1:0] r_wreg_x;
  reg [LWIDTH-1:0] r_wreg_y;
  reg [LWIDTH-1:0] r_conv_x;
  reg [LWIDTH-1:0] r_conv_y;
  reg [LWIDTH-1:0] r_pool_x;
  reg [LWIDTH-1:0] r_pool_y;
  reg [LWIDTH-1:0] r_total_in;
  reg [LWIDTH-1:0] r_total_out;
  reg [LWIDTH-1:0] r_count_in;
  reg [LWIDTH-1:0] r_count_out;
  reg r_feat_we_d0;
  reg r_feat_rst_d0;
  reg [FACCUM-1:0] r_feat_addr_d0;
  reg r_conv_we_d0;
  reg r_feat_we_d1;
  reg r_feat_rst_d1;
  reg [FACCUM-1:0] r_feat_addr_d1;
  reg r_conv_we_d1;
  reg r_feat_we_d2;
  reg r_feat_rst_d2;
  reg [FACCUM-1:0] r_feat_addr_d2;
  reg r_conv_we_d2;
  reg r_feat_we_d3;
  reg r_feat_rst_d3;
  reg [FACCUM-1:0] r_feat_addr_d3;
  reg r_conv_we_d3;
  reg r_feat_we_d4;
  reg r_feat_rst_d4;
  reg [FACCUM-1:0] r_feat_addr_d4;
  reg r_conv_we_d4;
  reg r_feat_we_d5;
  reg r_feat_rst_d5;
  reg [FACCUM-1:0] r_feat_addr_d5;
  reg r_conv_we_d5;
  reg [FACCUM-1:0] r_feat_addr_d6;
    reg r_pool_we_d0;
  reg r_ack_d0;
  reg r_pool_we_d1;
  reg r_ack_d1;
  reg r_pool_we_d2;
  reg r_ack_d2;
  reg r_pool_we_d3;
  reg r_ack_d3;
  reg r_pool_we_d4;
  reg r_ack_d4;
  reg r_pool_we_d5;
  reg r_ack_d5;
  reg r_pool_we_d6;
  reg r_ack_d6;
  reg r_pool_we_d7;
  reg r_ack_d7;
  reg r_pool_we_d8;
  reg r_ack_d8;
  reg r_ack_d9;
  reg [OUTSIZE-1:0] r_output_addr;

  //main FSM
  always @(posedge clk)
    if (!xrst)
    begin
      r_state <= WAIT;
      r_count_in <= 0;
      r_count_out <= 0;
    end
    else
      case (r_state)
        WAIT:
          if (req)
            r_state <= WREG;

        WREG:
          if (wreg_end)
            if (r_count_in == r_total_in - 1)
              r_state <= POOL;
            else
              r_state <= CONV;

        CONV:
          if (conv_end)
          begin
            r_state  <= WREG;
            r_count_in <= r_count_in + 1;
          end

        POOL:
          if (pool_end)
            if (r_count_out + 8 < r_total_out)
            begin
              r_state <= WREG;
              r_count_in <= 0;
              r_count_out <= r_count_out + 8;
            end
            else
            begin
              r_state <= WAIT;
              r_count_in <= 0;
              r_count_out <= 0;
            end
      endcase

  //wait exec (initialize)
  always @(posedge clk)
    if (!xrst)
    begin
      r_total_in  <= 0;
      r_total_out <= 0;
      r_img_w <= 0;
      r_img_h <= 0;
      r_fil_w <= 0;
      r_fil_h <= 0;
      r_fea_w <= 0;
      r_fea_h <= 0;
    end
    else if (r_state == WAIT && req)
    begin
      r_total_in  <= total_in;
      r_total_out <= total_out;
      r_img_w <= img_w;
      r_img_h <= img_h;
      r_fil_w <= fil_w;
      r_fil_h <= fil_h;
      r_fea_w <= img_w - fil_w + 1;
      r_fea_h <= img_h - fil_h + 1;
    end

  assign mem_input_addr = input_addr + ((r_state == CONV || r_state == POOL)
                                          ? r_input_addr + 1
                                          : r_input_addr);

  always @(posedge clk)
    if (!xrst)
      r_input_addr <= 0;
    else if (r_state == WAIT && req == 1 || pool_end)
      r_input_addr <= 0;
    else if (r_state == CONV || r_state == POOL)
      r_input_addr <= r_input_addr + 1;

  assign mem_weight_addr = weight_addr + ((r_state == WREG)
                                            ? r_weight_addr + 1
                                            : r_weight_addr);

  assign wreg_we = wreg_valid;

  always @(posedge clk)
    if (!xrst)
      r_weight_addr <= 0;
    else if (r_state == WAIT && req == 1 || ack)
      r_weight_addr <= 0;
    else if (r_state == WREG)
      r_weight_addr <= r_weight_addr + 1;

  always @(posedge clk)
    if (wreg_valid)
      r_wreg_we <= 1;
    else
      r_wreg_we <= 0;

  //convwreg write
  always @(posedge clk)
    if (!xrst)
      r_wreg_x <= 0;
    else if (r_state == WAIT)
      r_wreg_x <= 0;
    else if (r_state == WREG)
      if (r_wreg_x == r_fil_w - 1)
        r_wreg_x <= 0;
      else
        r_wreg_x <= r_wreg_x + 1;

  always @(posedge clk)
    if (!xrst)
      r_wreg_y <= 0;
    else if (r_state == WAIT)
      r_wreg_y <= 0;
    else if (r_state == WREG && r_wreg_x == r_fil_w - 1)
      if (r_wreg_y == r_fil_h - 1)
        r_wreg_y <= 0;
      else
        r_wreg_y <= r_wreg_y + 1;

  assign wreg_start = (r_state == WREG
            && r_wreg_x == 0 && r_wreg_y == 0);

  assign wreg_valid = (r_state == WREG
            && r_wreg_x >= 0 && r_wreg_x < r_fil_w
            && r_wreg_y >=0 && r_wreg_y < r_fil_h);

  assign wreg_end   = (r_state == WREG
            && r_wreg_x == r_fil_w - 1 && r_wreg_y == r_fil_h - 1);

  //conv exec
  always @(posedge clk)
    if (!xrst)
      r_conv_x <= 0;
    else if (r_state == WAIT)
      r_conv_x <= 0;
    else if ((r_state == CONV || r_state == POOL))
      if (r_conv_x == r_img_w - 1)
        r_conv_x <= 0;
      else
        r_conv_x <= r_conv_x + 1;

  always @(posedge clk)
    if (!xrst)
      r_conv_y <= 0;
    else if (r_state == WAIT)
      r_conv_y <= 0;
    else if ((r_state == CONV || r_state == POOL) && r_conv_x == r_img_w - 1)
      if (r_conv_y == r_img_h - 1)
        r_conv_y <= 0;
      else
        r_conv_y <= r_conv_y + 1;

  assign conv_start = (r_state == CONV || r_state == POOL)
            && r_conv_x == r_fil_w - 1 && r_conv_y == r_fil_h - 1;
  assign conv_valid = (r_state == CONV || r_state == POOL)
            && r_conv_x >= r_fil_w - 1 && r_conv_x < r_img_w
            && r_conv_y >= r_fil_h - 1 && r_conv_y < r_img_h;
  assign conv_end   = (r_state == CONV || r_state == POOL)
            && r_conv_x == r_img_w - 1 && r_conv_y == r_img_h - 1;

  //accum exec
  assign mem_feat_we      = r_feat_we_d5;
  assign mem_feat_rst     = r_feat_rst_d5;
  assign mem_feat_addr_d1 = r_feat_addr_d6;
  assign mem_feat_addr    = r_feat_addr_d5;
  assign conv_we          = r_conv_we_d5;

  always @(posedge clk)
    if (r_state == CONV && conv_valid)
      r_feat_we_d0 <= 1;
    else
      r_feat_we_d0 <= 0;

  always @(posedge clk)
    if (r_state == CONV && conv_valid && r_count_in == 0)
      r_feat_rst_d0 <= 1;
    else
      r_feat_rst_d0 <= 0;

  always @(posedge clk)
    if (!xrst)
      r_feat_we_d1 <= 0;
    else
      r_feat_we_d1 <= r_feat_we_d0;
  always @(posedge clk)
    if (!xrst)
      r_feat_we_d2 <= 0;
    else
      r_feat_we_d2 <= r_feat_we_d1;
  always @(posedge clk)
    if (!xrst)
      r_feat_we_d3 <= 0;
    else
      r_feat_we_d3 <= r_feat_we_d2;
  always @(posedge clk)
    if (!xrst)
      r_feat_we_d4 <= 0;
    else
      r_feat_we_d4 <= r_feat_we_d3;
  always @(posedge clk)
    if (!xrst)
      r_feat_we_d5 <= 0;
    else
      r_feat_we_d5 <= r_feat_we_d4;

  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d1 <= 0;
    else
      r_feat_addr_d1 <= r_feat_addr_d0;
  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d2 <= 0;
    else
      r_feat_addr_d2 <= r_feat_addr_d1;
  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d3 <= 0;
    else
      r_feat_addr_d3 <= r_feat_addr_d2;
  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d4 <= 0;
    else
      r_feat_addr_d4 <= r_feat_addr_d3;
  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d5 <= 0;
    else
      r_feat_addr_d5 <= r_feat_addr_d4;
  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d6 <= 0;
    else
      r_feat_addr_d6 <= r_feat_addr_d5;

  always @(posedge clk)
    if (!xrst)
      r_feat_rst_d1 <= 0;
    else
      r_feat_rst_d1 <= r_feat_rst_d0;
  always @(posedge clk)
    if (!xrst)
      r_feat_rst_d2 <= 0;
    else
      r_feat_rst_d2 <= r_feat_rst_d1;
  always @(posedge clk)
    if (!xrst)
      r_feat_rst_d3 <= 0;
    else
      r_feat_rst_d3 <= r_feat_rst_d2;
  always @(posedge clk)
    if (!xrst)
      r_feat_rst_d4 <= 0;
    else
      r_feat_rst_d4 <= r_feat_rst_d3;
  always @(posedge clk)
    if (!xrst)
      r_feat_rst_d5 <= 0;
    else
      r_feat_rst_d5 <= r_feat_rst_d4;

  always @(posedge clk)
    if (!xrst)
      r_conv_we_d1 <= 0;
    else
      r_conv_we_d1 <= r_conv_we_d0;
  always @(posedge clk)
    if (!xrst)
      r_conv_we_d2 <= 0;
    else
      r_conv_we_d2 <= r_conv_we_d1;
  always @(posedge clk)
    if (!xrst)
      r_conv_we_d3 <= 0;
    else
      r_conv_we_d3 <= r_conv_we_d2;
  always @(posedge clk)
    if (!xrst)
      r_conv_we_d4 <= 0;
    else
      r_conv_we_d4 <= r_conv_we_d3;
  always @(posedge clk)
    if (!xrst)
      r_conv_we_d5 <= 0;
    else
      r_conv_we_d5 <= r_conv_we_d4;

  always @(posedge clk)
    if (!xrst)
      r_feat_addr_d0 <= 0;
    else if (conv_end)
      r_feat_addr_d0 <= 0;
    else if (conv_valid)
      r_feat_addr_d0 <= r_feat_addr_d0 + 1;

  always @(posedge clk)
    if (r_state == POOL && conv_valid)
      r_conv_we_d0 <= 1;
    else
      r_conv_we_d0 <= 0;

  always @(posedge clk)
    if (!xrst)
      r_pool_x <= 0;
    else if (r_state == WAIT)
      r_pool_x <= 0;
    else if (r_state == POOL && conv_valid)
      if (r_pool_x == r_fea_w - 1)
        r_pool_x <= 0;
      else
        r_pool_x <= r_pool_x + 1;

  always @(posedge clk)
    if (!xrst)
      r_pool_y <= 0;
    else if (r_state == WAIT)
      r_pool_y <= 0;
    else if (r_state == POOL && conv_valid && r_pool_x == r_fea_w - 1)
      if (r_pool_y == r_fea_h - 1)
        r_pool_y <= 0;
      else
        r_pool_y <= r_pool_y + 1;

  assign pool_start = r_state == POOL
            && r_pool_x == 1 && r_pool_y == 1;

  assign pool_valid = r_state == POOL
            && r_pool_x >= 1 && r_pool_x < r_fea_w
            && r_pool_y >= 1 && r_pool_y < r_fea_h;

  assign pool_end   = r_state == POOL
            && r_pool_x == r_fea_w - 1 && r_pool_y == r_fea_h - 1;

  //pool exec
  assign pool_we     = r_pool_we_d7;
  assign mem_output_we   = r_pool_we_d8;
  assign mem_output_addr = output_addr + r_output_addr;

  always @(posedge clk)
    if (pool_valid && r_pool_x[0] == 1 && r_pool_y[0] == 1)
      r_pool_we_d0 <= 1;
    else
      r_pool_we_d0 <= 0;

  always @(posedge clk)
    if (!xrst)
      r_pool_we_d1 <= 0;
    else
      r_pool_we_d1 <= r_pool_we_d0;
  always @(posedge clk)
    if (!xrst)
      r_pool_we_d2 <= 0;
    else
      r_pool_we_d2 <= r_pool_we_d1;
  always @(posedge clk)
    if (!xrst)
      r_pool_we_d3 <= 0;
    else
      r_pool_we_d3 <= r_pool_we_d2;
  always @(posedge clk)
    if (!xrst)
      r_pool_we_d4 <= 0;
    else
      r_pool_we_d4 <= r_pool_we_d3;
  always @(posedge clk)
    if (!xrst)
      r_pool_we_d5 <= 0;
    else
      r_pool_we_d5 <= r_pool_we_d4;
  always @(posedge clk)
    if (!xrst)
      r_pool_we_d6 <= 0;
    else
      r_pool_we_d6 <= r_pool_we_d5;
  always @(posedge clk)
    if (!xrst)
      r_pool_we_d7 <= 0;
    else
      r_pool_we_d7 <= r_pool_we_d6;
  always @(posedge clk)
    if (!xrst)
      r_pool_we_d8 <= 0;
    else
      r_pool_we_d8 <= r_pool_we_d7;

  //always @(posedge clk or negedge xrst)
  always @(posedge clk)
    if (!xrst)
      r_output_addr <= 0;
    else if (ack)
      r_output_addr <= 0;
    else if (r_pool_we_d8)
      r_output_addr <= r_output_addr + 1;

  //assign ack = pool_end && r_count_out + 8 >= r_total_out;
  assign ack = r_ack_d9;

  always @(posedge clk)
    if (!xrst)
      r_ack_d0 <= 0;
    else if (req)
      r_ack_d0 <= 0;
    else if (pool_end && r_count_out + 8 >= r_total_out)
      r_ack_d0 <= 1;

  always @(posedge clk)
    if (!xrst)
      r_ack_d1 <= 0;
    else
      r_ack_d1 <= r_ack_d0;
  always @(posedge clk)
    if (!xrst)
      r_ack_d2 <= 0;
    else
      r_ack_d2 <= r_ack_d1;
  always @(posedge clk)
    if (!xrst)
      r_ack_d3 <= 0;
    else
      r_ack_d3 <= r_ack_d2;
  always @(posedge clk)
    if (!xrst)
      r_ack_d4 <= 0;
    else
      r_ack_d4 <= r_ack_d3;
  always @(posedge clk)
    if (!xrst)
      r_ack_d5 <= 0;
    else
      r_ack_d5 <= r_ack_d4;
  always @(posedge clk)
    if (!xrst)
      r_ack_d6 <= 0;
    else
      r_ack_d6 <= r_ack_d5;
  always @(posedge clk)
    if (!xrst)
      r_ack_d7 <= 0;
    else
      r_ack_d7 <= r_ack_d6;
  always @(posedge clk)
    if (!xrst)
      r_ack_d8 <= 0;
    else
      r_ack_d8 <= r_ack_d7;
  always @(posedge clk)
    if (!xrst)
      r_ack_d9 <= 0;
    else
      r_ack_d9 <= r_ack_d8;

endmodule
