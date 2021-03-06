
module ctrl_core(/*AUTOARG*/
   // Outputs
   ack, core_state, out_begin, out_valid, out_end, buf_pix_en,
   mem_input_addr, mem_weight_addr, mem_bias_addr, mem_output_we,
   mem_output_addr, first_input, last_input, wreg_we, breg_we,
   w_img_size, w_fil_size,
   // Inputs
   clk, xrst, req, in_begin, in_valid, in_end, input_addr,
   weight_addr, bias_addr, output_addr, total_out, total_in, img_size,
   fil_size
   );
`include "parameters.vh"

  parameter S_WAIT    = 'd0;
  parameter S_WEIGHT  = 'd1;
  parameter S_INPUT   = 'd2;
  parameter S_OUTPUT  = 'd3;

  parameter S_W_WEIGHT  = 'd0;
  parameter S_W_BIAS    = 'd1;

  /*AUTOINPUT*/
  input               clk;
  input               xrst;
  input               req;
  input               in_begin;
  input               in_valid;
  input               in_end;
  input [INSIZE-1:0]  input_addr;
  input [WSIZE-1:0]   weight_addr;
  input [BSIZE-1:0]   bias_addr;
  input [OUTSIZE-1:0] output_addr;
  input [LWIDTH-1:0]  total_out;
  input [LWIDTH-1:0]  total_in;
  input [LWIDTH-1:0]  img_size;
  input [LWIDTH-1:0]  fil_size;

  /*AUTOOUTPUT*/
  output                ack;
  output [2-1:0]        core_state;
  output                out_begin;
  output                out_valid;
  output                out_end;
  output                buf_pix_en;
  output [INSIZE-1:0]   mem_input_addr;
  output [WSIZE-1:0]    mem_weight_addr;
  output [BSIZE-1:0]    mem_bias_addr;
  output                mem_output_we;
  output [OUTSIZE-1:0]  mem_output_addr;
  output                first_input;
  output                last_input;
  output                wreg_we;
  output                breg_we;
  output [LWIDTH-1:0]   w_img_size;
  output [LWIDTH-1:0]   w_fil_size;

  /*AUTOWIRE*/
  wire s_weight_end;
  wire s_input_end;
  wire s_output_end;
  wire s_w_weight_end;
  wire s_w_bias_end;
  wire final_iter;

  /*AUTOREG*/
  reg [2-1:0]       r_state;
  reg               r_state_weight;
  reg               r_ack;
  reg [LWIDTH-1:0]  r_total_out;
  reg [LWIDTH-1:0]  r_total_in;
  reg [LWIDTH-1:0]  r_img_size;
  reg [LWIDTH-1:0]  r_fil_size;
  reg [LWIDTH-1:0]  r_pool_size;
  reg [LWIDTH-1:0]  r_count_out;
  reg [LWIDTH-1:0]  r_count_in;
  reg [LWIDTH-1:0]  r_weight_x;
  reg [LWIDTH-1:0]  r_weight_y;
  reg [WSIZE-1:0]   r_weight_addr;
  reg [WSIZE-1:0]   r_weight_offset;
  reg [BSIZE-1:0]   r_bias_addr;
  reg [BSIZE-1:0]   r_bias_offset;
  reg [LWIDTH-1:0]  r_input_x;
  reg [LWIDTH-1:0]  r_input_y;
  reg [INSIZE-1:0]  r_input_addr;
  reg               r_output_we;
  reg [OUTSIZE-1:0] r_output_addr;
  reg [2-1:0]       r_state_d         [32:0];
  reg               r_state_weight_d  [32:0];
  reg               r_wreg_we_d       [32-1:0];
  reg               r_out_begin_d     [32-1:0];
  reg               r_out_valid_d     [32-1:0];
  reg               r_out_end_d       [32-1:0];
  reg               r_first_input_d   [32-1:0];
  reg               r_last_input_d    [32-1:0];
  reg               r_buf_pix_en;
  reg [LWIDTH-1:0]  r_d_pixelbuf;

//==========================================================
// core control
//==========================================================

  assign final_iter = r_count_in == r_total_in - 1
                        && r_count_out >= r_total_out - CORE;

  //main FSM
  always @(posedge clk)
    if (!xrst)
    begin
      r_state     <= S_WAIT;
      r_count_in  <= 0;
      r_count_out <= 0;
    end
    else
      case (r_state)
        S_WAIT:
          if (req)
            r_state <= S_WEIGHT;

        S_WEIGHT:
          if (s_weight_end)
            r_state <= S_INPUT;

        S_INPUT:
          if (s_input_end)
            if (r_count_in == r_total_in - 1)
            begin
              r_state     <= S_OUTPUT;
              r_count_in  <= 0;
            end
            else
            begin
              r_state     <= S_WEIGHT;
              r_count_in  <= r_count_in + 1;
            end

        S_OUTPUT:
          if (s_output_end)
            if (r_count_out >= r_total_out - CORE)
            begin
              r_state     <= S_WAIT;
              r_count_out <= 0;
            end
            else
            begin
              r_state     <= S_WEIGHT;
              r_count_out <= r_count_out + CORE;
            end
      endcase

  assign core_state = r_state_d[r_d_pixelbuf];

  always @(posedge clk)
    if (!xrst)
      r_state_d[1] <= 0;
    else
      r_state_d[1] <= r_state;
  always @(posedge clk)
    if (!xrst)
      r_state_d[2] <= 0;
    else
      r_state_d[2] <= r_state_d[1];
  always @(posedge clk)
    if (!xrst)
      r_state_d[3] <= 0;
    else
      r_state_d[3] <= r_state_d[2];
  always @(posedge clk)
    if (!xrst)
      r_state_d[4] <= 0;
    else
      r_state_d[4] <= r_state_d[3];
  always @(posedge clk)
    if (!xrst)
      r_state_d[5] <= 0;
    else
      r_state_d[5] <= r_state_d[4];
  always @(posedge clk)
    if (!xrst)
      r_state_d[6] <= 0;
    else
      r_state_d[6] <= r_state_d[5];
  always @(posedge clk)
    if (!xrst)
      r_state_d[7] <= 0;
    else
      r_state_d[7] <= r_state_d[6];
  always @(posedge clk)
    if (!xrst)
      r_state_d[8] <= 0;
    else
      r_state_d[8] <= r_state_d[7];
  always @(posedge clk)
    if (!xrst)
      r_state_d[9] <= 0;
    else
      r_state_d[9] <= r_state_d[8];
  always @(posedge clk)
    if (!xrst)
      r_state_d[10] <= 0;
    else
      r_state_d[10] <= r_state_d[9];
  always @(posedge clk)
    if (!xrst)
      r_state_d[11] <= 0;
    else
      r_state_d[11] <= r_state_d[10];
  always @(posedge clk)
    if (!xrst)
      r_state_d[12] <= 0;
    else
      r_state_d[12] <= r_state_d[11];
  always @(posedge clk)
    if (!xrst)
      r_state_d[13] <= 0;
    else
      r_state_d[13] <= r_state_d[12];
  always @(posedge clk)
    if (!xrst)
      r_state_d[14] <= 0;
    else
      r_state_d[14] <= r_state_d[13];
  always @(posedge clk)
    if (!xrst)
      r_state_d[15] <= 0;
    else
      r_state_d[15] <= r_state_d[14];
  always @(posedge clk)
    if (!xrst)
      r_state_d[16] <= 0;
    else
      r_state_d[16] <= r_state_d[15];
  always @(posedge clk)
    if (!xrst)
      r_state_d[17] <= 0;
    else
      r_state_d[17] <= r_state_d[16];
  always @(posedge clk)
    if (!xrst)
      r_state_d[18] <= 0;
    else
      r_state_d[18] <= r_state_d[17];
  always @(posedge clk)
    if (!xrst)
      r_state_d[19] <= 0;
    else
      r_state_d[19] <= r_state_d[18];
  always @(posedge clk)
    if (!xrst)
      r_state_d[20] <= 0;
    else
      r_state_d[20] <= r_state_d[19];
  always @(posedge clk)
    if (!xrst)
      r_state_d[21] <= 0;
    else
      r_state_d[21] <= r_state_d[20];
  always @(posedge clk)
    if (!xrst)
      r_state_d[22] <= 0;
    else
      r_state_d[22] <= r_state_d[21];
  always @(posedge clk)
    if (!xrst)
      r_state_d[23] <= 0;
    else
      r_state_d[23] <= r_state_d[22];
  always @(posedge clk)
    if (!xrst)
      r_state_d[24] <= 0;
    else
      r_state_d[24] <= r_state_d[23];
  always @(posedge clk)
    if (!xrst)
      r_state_d[25] <= 0;
    else
      r_state_d[25] <= r_state_d[24];
  always @(posedge clk)
    if (!xrst)
      r_state_d[26] <= 0;
    else
      r_state_d[26] <= r_state_d[25];
  always @(posedge clk)
    if (!xrst)
      r_state_d[27] <= 0;
    else
      r_state_d[27] <= r_state_d[26];
  always @(posedge clk)
    if (!xrst)
      r_state_d[28] <= 0;
    else
      r_state_d[28] <= r_state_d[27];
  always @(posedge clk)
    if (!xrst)
      r_state_d[29] <= 0;
    else
      r_state_d[29] <= r_state_d[28];
  always @(posedge clk)
    if (!xrst)
      r_state_d[30] <= 0;
    else
      r_state_d[30] <= r_state_d[29];
  always @(posedge clk)
    if (!xrst)
      r_state_d[31] <= 0;
    else
      r_state_d[31] <= r_state_d[30];
  always @(posedge clk)
    if (!xrst)
      r_state_d[32] <= 0;
    else
      r_state_d[32] <= r_state_d[31];

  assign w_img_size = r_img_size;
  assign w_fil_size = r_fil_size;

  //wait exec (initialize)
  always @(posedge clk)
    if (!xrst)
    begin
      r_total_in    <= 0;
      r_total_out   <= 0;
      r_img_size    <= 0;
      r_fil_size    <= 0;
      r_d_pixelbuf  <= 0;
    end
    else if (r_state == S_WAIT && req)
    begin
      r_total_in    <= total_in;
      r_total_out   <= total_out;
      r_img_size    <= img_size;
      r_fil_size    <= fil_size;
      r_d_pixelbuf  <= img_size - fil_size + 8 - 1;
    end

  assign first_input = r_first_input_d[r_d_pixelbuf];
  assign last_input  = r_last_input_d[r_d_pixelbuf];

  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[0] <= 0;
      r_last_input_d[0]  <= 0;
    end
    else
    begin
      r_first_input_d[0] <= r_state == S_INPUT && r_count_in == 0;
      r_last_input_d[0]  <= r_state == S_INPUT && r_count_in == r_total_in - 1;
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[1] <= 0;
      r_last_input_d[1]  <= 0;
    end
    else
    begin
      r_first_input_d[1] <= r_first_input_d[0];
      r_last_input_d[1]  <= r_last_input_d[0];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[2] <= 0;
      r_last_input_d[2]  <= 0;
    end
    else
    begin
      r_first_input_d[2] <= r_first_input_d[1];
      r_last_input_d[2]  <= r_last_input_d[1];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[3] <= 0;
      r_last_input_d[3]  <= 0;
    end
    else
    begin
      r_first_input_d[3] <= r_first_input_d[2];
      r_last_input_d[3]  <= r_last_input_d[2];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[4] <= 0;
      r_last_input_d[4]  <= 0;
    end
    else
    begin
      r_first_input_d[4] <= r_first_input_d[3];
      r_last_input_d[4]  <= r_last_input_d[3];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[5] <= 0;
      r_last_input_d[5]  <= 0;
    end
    else
    begin
      r_first_input_d[5] <= r_first_input_d[4];
      r_last_input_d[5]  <= r_last_input_d[4];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[6] <= 0;
      r_last_input_d[6]  <= 0;
    end
    else
    begin
      r_first_input_d[6] <= r_first_input_d[5];
      r_last_input_d[6]  <= r_last_input_d[5];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[7] <= 0;
      r_last_input_d[7]  <= 0;
    end
    else
    begin
      r_first_input_d[7] <= r_first_input_d[6];
      r_last_input_d[7]  <= r_last_input_d[6];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[8] <= 0;
      r_last_input_d[8]  <= 0;
    end
    else
    begin
      r_first_input_d[8] <= r_first_input_d[7];
      r_last_input_d[8]  <= r_last_input_d[7];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[9] <= 0;
      r_last_input_d[9]  <= 0;
    end
    else
    begin
      r_first_input_d[9] <= r_first_input_d[8];
      r_last_input_d[9]  <= r_last_input_d[8];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[10] <= 0;
      r_last_input_d[10]  <= 0;
    end
    else
    begin
      r_first_input_d[10] <= r_first_input_d[9];
      r_last_input_d[10]  <= r_last_input_d[9];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[11] <= 0;
      r_last_input_d[11]  <= 0;
    end
    else
    begin
      r_first_input_d[11] <= r_first_input_d[10];
      r_last_input_d[11]  <= r_last_input_d[10];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[12] <= 0;
      r_last_input_d[12]  <= 0;
    end
    else
    begin
      r_first_input_d[12] <= r_first_input_d[11];
      r_last_input_d[12]  <= r_last_input_d[11];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[13] <= 0;
      r_last_input_d[13]  <= 0;
    end
    else
    begin
      r_first_input_d[13] <= r_first_input_d[12];
      r_last_input_d[13]  <= r_last_input_d[12];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[14] <= 0;
      r_last_input_d[14]  <= 0;
    end
    else
    begin
      r_first_input_d[14] <= r_first_input_d[13];
      r_last_input_d[14]  <= r_last_input_d[13];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[15] <= 0;
      r_last_input_d[15]  <= 0;
    end
    else
    begin
      r_first_input_d[15] <= r_first_input_d[14];
      r_last_input_d[15]  <= r_last_input_d[14];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[16] <= 0;
      r_last_input_d[16]  <= 0;
    end
    else
    begin
      r_first_input_d[16] <= r_first_input_d[15];
      r_last_input_d[16]  <= r_last_input_d[15];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[17] <= 0;
      r_last_input_d[17]  <= 0;
    end
    else
    begin
      r_first_input_d[17] <= r_first_input_d[16];
      r_last_input_d[17]  <= r_last_input_d[16];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[18] <= 0;
      r_last_input_d[18]  <= 0;
    end
    else
    begin
      r_first_input_d[18] <= r_first_input_d[17];
      r_last_input_d[18]  <= r_last_input_d[17];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[19] <= 0;
      r_last_input_d[19]  <= 0;
    end
    else
    begin
      r_first_input_d[19] <= r_first_input_d[18];
      r_last_input_d[19]  <= r_last_input_d[18];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[20] <= 0;
      r_last_input_d[20]  <= 0;
    end
    else
    begin
      r_first_input_d[20] <= r_first_input_d[19];
      r_last_input_d[20]  <= r_last_input_d[19];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[21] <= 0;
      r_last_input_d[21]  <= 0;
    end
    else
    begin
      r_first_input_d[21] <= r_first_input_d[20];
      r_last_input_d[21]  <= r_last_input_d[20];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[22] <= 0;
      r_last_input_d[22]  <= 0;
    end
    else
    begin
      r_first_input_d[22] <= r_first_input_d[21];
      r_last_input_d[22]  <= r_last_input_d[21];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[23] <= 0;
      r_last_input_d[23]  <= 0;
    end
    else
    begin
      r_first_input_d[23] <= r_first_input_d[22];
      r_last_input_d[23]  <= r_last_input_d[22];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[24] <= 0;
      r_last_input_d[24]  <= 0;
    end
    else
    begin
      r_first_input_d[24] <= r_first_input_d[23];
      r_last_input_d[24]  <= r_last_input_d[23];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[25] <= 0;
      r_last_input_d[25]  <= 0;
    end
    else
    begin
      r_first_input_d[25] <= r_first_input_d[24];
      r_last_input_d[25]  <= r_last_input_d[24];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[26] <= 0;
      r_last_input_d[26]  <= 0;
    end
    else
    begin
      r_first_input_d[26] <= r_first_input_d[25];
      r_last_input_d[26]  <= r_last_input_d[25];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[27] <= 0;
      r_last_input_d[27]  <= 0;
    end
    else
    begin
      r_first_input_d[27] <= r_first_input_d[26];
      r_last_input_d[27]  <= r_last_input_d[26];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[28] <= 0;
      r_last_input_d[28]  <= 0;
    end
    else
    begin
      r_first_input_d[28] <= r_first_input_d[27];
      r_last_input_d[28]  <= r_last_input_d[27];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[29] <= 0;
      r_last_input_d[29]  <= 0;
    end
    else
    begin
      r_first_input_d[29] <= r_first_input_d[28];
      r_last_input_d[29]  <= r_last_input_d[28];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[30] <= 0;
      r_last_input_d[30]  <= 0;
    end
    else
    begin
      r_first_input_d[30] <= r_first_input_d[29];
      r_last_input_d[30]  <= r_last_input_d[29];
    end
  always @(posedge clk)
    if (!xrst)
    begin
      r_first_input_d[31] <= 0;
      r_last_input_d[31]  <= 0;
    end
    else
    begin
      r_first_input_d[31] <= r_first_input_d[30];
      r_last_input_d[31]  <= r_last_input_d[30];
    end

//==========================================================
// weight control
//==========================================================

  assign mem_weight_addr = r_weight_addr + r_weight_offset;
  assign mem_bias_addr = r_bias_addr + r_bias_offset;

  assign s_weight_end     = r_state == S_WEIGHT && r_count_in == r_total_in - 1
                          ? s_w_bias_end
                          : s_w_weight_end;

  assign s_w_weight_end = r_state_weight == S_W_WEIGHT
                          && r_weight_x == r_fil_size - 1
                          && r_weight_y == r_fil_size - 1;

  assign s_w_bias_end   = r_state_weight == S_W_BIAS;

  always @(posedge clk)
    if (!xrst)
      r_state_weight <= S_W_WEIGHT;
    else
      case (r_state_weight)
        S_W_WEIGHT:
          if (s_w_weight_end && r_count_in == r_total_in - 1)
            r_state_weight <= S_W_BIAS;

        S_W_BIAS:
          if (s_w_bias_end)
            r_state_weight <= S_W_WEIGHT;

        default:
          r_state_weight <= S_W_WEIGHT;
      endcase

  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[1] <= 0;
    else
      r_state_weight_d[1] <= r_state_weight;
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[2] <= 0;
    else
      r_state_weight_d[2] <= r_state_weight_d[1];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[3] <= 0;
    else
      r_state_weight_d[3] <= r_state_weight_d[2];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[4] <= 0;
    else
      r_state_weight_d[4] <= r_state_weight_d[3];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[5] <= 0;
    else
      r_state_weight_d[5] <= r_state_weight_d[4];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[6] <= 0;
    else
      r_state_weight_d[6] <= r_state_weight_d[5];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[7] <= 0;
    else
      r_state_weight_d[7] <= r_state_weight_d[6];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[8] <= 0;
    else
      r_state_weight_d[8] <= r_state_weight_d[7];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[9] <= 0;
    else
      r_state_weight_d[9] <= r_state_weight_d[8];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[10] <= 0;
    else
      r_state_weight_d[10] <= r_state_weight_d[9];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[11] <= 0;
    else
      r_state_weight_d[11] <= r_state_weight_d[10];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[12] <= 0;
    else
      r_state_weight_d[12] <= r_state_weight_d[11];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[13] <= 0;
    else
      r_state_weight_d[13] <= r_state_weight_d[12];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[14] <= 0;
    else
      r_state_weight_d[14] <= r_state_weight_d[13];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[15] <= 0;
    else
      r_state_weight_d[15] <= r_state_weight_d[14];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[16] <= 0;
    else
      r_state_weight_d[16] <= r_state_weight_d[15];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[17] <= 0;
    else
      r_state_weight_d[17] <= r_state_weight_d[16];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[18] <= 0;
    else
      r_state_weight_d[18] <= r_state_weight_d[17];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[19] <= 0;
    else
      r_state_weight_d[19] <= r_state_weight_d[18];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[20] <= 0;
    else
      r_state_weight_d[20] <= r_state_weight_d[19];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[21] <= 0;
    else
      r_state_weight_d[21] <= r_state_weight_d[20];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[22] <= 0;
    else
      r_state_weight_d[22] <= r_state_weight_d[21];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[23] <= 0;
    else
      r_state_weight_d[23] <= r_state_weight_d[22];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[24] <= 0;
    else
      r_state_weight_d[24] <= r_state_weight_d[23];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[25] <= 0;
    else
      r_state_weight_d[25] <= r_state_weight_d[24];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[26] <= 0;
    else
      r_state_weight_d[26] <= r_state_weight_d[25];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[27] <= 0;
    else
      r_state_weight_d[27] <= r_state_weight_d[26];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[28] <= 0;
    else
      r_state_weight_d[28] <= r_state_weight_d[27];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[29] <= 0;
    else
      r_state_weight_d[29] <= r_state_weight_d[28];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[30] <= 0;
    else
      r_state_weight_d[30] <= r_state_weight_d[29];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[31] <= 0;
    else
      r_state_weight_d[31] <= r_state_weight_d[30];
  always @(posedge clk)
    if (!xrst)
      r_state_weight_d[32] <= 0;
    else
      r_state_weight_d[32] <= r_state_weight_d[31];

  always @(posedge clk)
    if (!xrst)
    begin
      r_weight_offset <= 0;
      r_bias_offset   <= 0;
    end
    else if (req || ack)
    begin
      r_weight_offset <= weight_addr;
      r_bias_offset   <= bias_addr;
    end

  always @(posedge clk)
    if (!xrst)
    begin
      r_weight_addr <= 0;
      r_bias_addr   <= 0;
    end
    else if (final_iter && r_state_weight_d[r_d_pixelbuf] == S_W_BIAS)
    begin
      r_weight_addr <= 0;
      r_bias_addr   <= 0;
    end
    else if (r_state_d[r_d_pixelbuf] == S_WEIGHT)
      case (r_state_weight_d[r_d_pixelbuf])
        S_W_WEIGHT:
          r_weight_addr <= r_weight_addr + 1;
        S_W_BIAS:
          r_bias_addr   <= r_bias_addr + 1;
        default:
        begin
          r_weight_addr <= r_weight_addr;
          r_bias_addr   <= r_bias_addr;
        end
      endcase

  always @(posedge clk)
    if (!xrst)
    begin
      r_weight_x <= 0;
      r_weight_y <= 0;
    end
    else
      case (r_state)
        S_WEIGHT:
          case (r_state_weight)
            S_W_WEIGHT:
              if (r_weight_x == r_fil_size - 1)
              begin
                r_weight_x <= 0;
                if (r_weight_y == r_fil_size - 1)
                  r_weight_y <= 0;
                else
                  r_weight_y <= r_weight_y + 1;
              end
              else
                r_weight_x <= r_weight_x + 1;

            default:
            begin
              r_weight_x <= 0;
              r_weight_y <= 0;
            end
          endcase

        default:
        begin
          r_weight_x <= 0;
          r_weight_y <= 0;
        end
      endcase

//==========================================================
// wreg & bias control
//==========================================================

  assign wreg_we = r_state_d[r_d_pixelbuf+1] == S_WEIGHT
                   && r_state_weight_d[r_d_pixelbuf+1] == S_W_WEIGHT;

  assign breg_we = r_state_d[r_d_pixelbuf+1] == S_WEIGHT
                   && r_state_weight_d[r_d_pixelbuf+1] == S_W_BIAS;

//==========================================================
// input control
//==========================================================

  assign mem_input_addr = input_addr + r_input_addr;

  assign s_input_end    = (r_state == S_INPUT)
                            && r_input_x == r_img_size - 1
                            && r_input_y == r_img_size - 1;

  always @(posedge clk)
    if (!xrst)
    begin
      r_input_x <= 0;
      r_input_y <= 0;
    end
    else
      case (r_state)
        S_INPUT:
          if (r_input_x == r_img_size - 1)
          begin
            r_input_x <= 0;
            if (r_input_y == r_img_size - 1)
              r_input_y <= 0;
            else
              r_input_y <= r_input_y + 1;
          end
          else
            r_input_x <= r_input_x + 1;

        default:
        begin
          r_input_x <= 0;
          r_input_y <= 0;
        end
    endcase

  always @(posedge clk)
    if (!xrst)
      r_input_addr <= 0;
    else if (r_state == S_OUTPUT)
      r_input_addr <= 0;
    else if (r_state == S_INPUT)
      r_input_addr <= r_input_addr + 1;

  assign buf_pix_en = r_buf_pix_en;

  always @(posedge clk)
    if (!xrst)
      r_buf_pix_en <= 0;
    else
      r_buf_pix_en <= (r_state == S_INPUT) && r_out_begin_d[0];

//==========================================================
// output control
//==========================================================

  assign ack              = r_ack;

  assign mem_output_we    = r_output_we;
  assign mem_output_addr  = output_addr + r_output_addr;

  assign out_begin        = r_out_begin_d[r_d_pixelbuf];
  assign out_valid        = r_out_valid_d[r_d_pixelbuf];
  assign out_end          = r_out_end_d[r_d_pixelbuf];

  assign s_output_end     = (r_state == S_OUTPUT) && in_end;

  always @(posedge clk)
    if (!xrst)
      r_ack <= 1;
    else if (req)
      r_ack <= 0;
    else if (s_output_end && r_count_out + CORE >= r_total_out)
      r_ack <= 1;

  always @(posedge clk)
    if (!xrst)
      r_output_we <= 0;
    else
      r_output_we <= (r_state == S_OUTPUT) && in_valid;

  always @(posedge clk)
    if (!xrst)
      r_output_addr <= 0;
    else if (ack)
      r_output_addr <= 0;
    else if (mem_output_we)
      r_output_addr <= r_output_addr + 1;

  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[0] <= 0;
    else
      r_out_begin_d[0] <= req
                        || s_weight_end
                        || s_input_end  && (r_count_in != r_total_in - 1);
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[1] <= 0;
    else
      r_out_begin_d[1] <= r_out_begin_d[0];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[2] <= 0;
    else
      r_out_begin_d[2] <= r_out_begin_d[1];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[3] <= 0;
    else
      r_out_begin_d[3] <= r_out_begin_d[2];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[4] <= 0;
    else
      r_out_begin_d[4] <= r_out_begin_d[3];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[5] <= 0;
    else
      r_out_begin_d[5] <= r_out_begin_d[4];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[6] <= 0;
    else
      r_out_begin_d[6] <= r_out_begin_d[5];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[7] <= 0;
    else
      r_out_begin_d[7] <= r_out_begin_d[6];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[8] <= 0;
    else
      r_out_begin_d[8] <= r_out_begin_d[7];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[9] <= 0;
    else
      r_out_begin_d[9] <= r_out_begin_d[8];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[10] <= 0;
    else
      r_out_begin_d[10] <= r_out_begin_d[9];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[11] <= 0;
    else
      r_out_begin_d[11] <= r_out_begin_d[10];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[12] <= 0;
    else
      r_out_begin_d[12] <= r_out_begin_d[11];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[13] <= 0;
    else
      r_out_begin_d[13] <= r_out_begin_d[12];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[14] <= 0;
    else
      r_out_begin_d[14] <= r_out_begin_d[13];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[15] <= 0;
    else
      r_out_begin_d[15] <= r_out_begin_d[14];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[16] <= 0;
    else
      r_out_begin_d[16] <= r_out_begin_d[15];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[17] <= 0;
    else
      r_out_begin_d[17] <= r_out_begin_d[16];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[18] <= 0;
    else
      r_out_begin_d[18] <= r_out_begin_d[17];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[19] <= 0;
    else
      r_out_begin_d[19] <= r_out_begin_d[18];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[20] <= 0;
    else
      r_out_begin_d[20] <= r_out_begin_d[19];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[21] <= 0;
    else
      r_out_begin_d[21] <= r_out_begin_d[20];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[22] <= 0;
    else
      r_out_begin_d[22] <= r_out_begin_d[21];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[23] <= 0;
    else
      r_out_begin_d[23] <= r_out_begin_d[22];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[24] <= 0;
    else
      r_out_begin_d[24] <= r_out_begin_d[23];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[25] <= 0;
    else
      r_out_begin_d[25] <= r_out_begin_d[24];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[26] <= 0;
    else
      r_out_begin_d[26] <= r_out_begin_d[25];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[27] <= 0;
    else
      r_out_begin_d[27] <= r_out_begin_d[26];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[28] <= 0;
    else
      r_out_begin_d[28] <= r_out_begin_d[27];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[29] <= 0;
    else
      r_out_begin_d[29] <= r_out_begin_d[28];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[30] <= 0;
    else
      r_out_begin_d[30] <= r_out_begin_d[29];
  always @(posedge clk)
    if (!xrst)
      r_out_begin_d[31] <= 0;
    else
      r_out_begin_d[31] <= r_out_begin_d[30];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[0] <= 0;
    else
      r_out_valid_d[0] <= (r_state == S_WEIGHT || r_state == S_INPUT);
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[1] <= 0;
    else
      r_out_valid_d[1] <= r_out_valid_d[0];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[2] <= 0;
    else
      r_out_valid_d[2] <= r_out_valid_d[1];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[3] <= 0;
    else
      r_out_valid_d[3] <= r_out_valid_d[2];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[4] <= 0;
    else
      r_out_valid_d[4] <= r_out_valid_d[3];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[5] <= 0;
    else
      r_out_valid_d[5] <= r_out_valid_d[4];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[6] <= 0;
    else
      r_out_valid_d[6] <= r_out_valid_d[5];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[7] <= 0;
    else
      r_out_valid_d[7] <= r_out_valid_d[6];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[8] <= 0;
    else
      r_out_valid_d[8] <= r_out_valid_d[7];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[9] <= 0;
    else
      r_out_valid_d[9] <= r_out_valid_d[8];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[10] <= 0;
    else
      r_out_valid_d[10] <= r_out_valid_d[9];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[11] <= 0;
    else
      r_out_valid_d[11] <= r_out_valid_d[10];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[12] <= 0;
    else
      r_out_valid_d[12] <= r_out_valid_d[11];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[13] <= 0;
    else
      r_out_valid_d[13] <= r_out_valid_d[12];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[14] <= 0;
    else
      r_out_valid_d[14] <= r_out_valid_d[13];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[15] <= 0;
    else
      r_out_valid_d[15] <= r_out_valid_d[14];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[16] <= 0;
    else
      r_out_valid_d[16] <= r_out_valid_d[15];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[17] <= 0;
    else
      r_out_valid_d[17] <= r_out_valid_d[16];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[18] <= 0;
    else
      r_out_valid_d[18] <= r_out_valid_d[17];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[19] <= 0;
    else
      r_out_valid_d[19] <= r_out_valid_d[18];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[20] <= 0;
    else
      r_out_valid_d[20] <= r_out_valid_d[19];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[21] <= 0;
    else
      r_out_valid_d[21] <= r_out_valid_d[20];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[22] <= 0;
    else
      r_out_valid_d[22] <= r_out_valid_d[21];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[23] <= 0;
    else
      r_out_valid_d[23] <= r_out_valid_d[22];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[24] <= 0;
    else
      r_out_valid_d[24] <= r_out_valid_d[23];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[25] <= 0;
    else
      r_out_valid_d[25] <= r_out_valid_d[24];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[26] <= 0;
    else
      r_out_valid_d[26] <= r_out_valid_d[25];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[27] <= 0;
    else
      r_out_valid_d[27] <= r_out_valid_d[26];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[28] <= 0;
    else
      r_out_valid_d[28] <= r_out_valid_d[27];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[29] <= 0;
    else
      r_out_valid_d[29] <= r_out_valid_d[28];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[30] <= 0;
    else
      r_out_valid_d[30] <= r_out_valid_d[29];
  always @(posedge clk)
    if (!xrst)
      r_out_valid_d[31] <= 0;
    else
      r_out_valid_d[31] <= r_out_valid_d[30];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[0] <= 0;
    else
      r_out_end_d[0]   <= s_weight_end || s_input_end;
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[1] <= 0;
    else
      r_out_end_d[1] <= r_out_end_d[0];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[2] <= 0;
    else
      r_out_end_d[2] <= r_out_end_d[1];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[3] <= 0;
    else
      r_out_end_d[3] <= r_out_end_d[2];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[4] <= 0;
    else
      r_out_end_d[4] <= r_out_end_d[3];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[5] <= 0;
    else
      r_out_end_d[5] <= r_out_end_d[4];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[6] <= 0;
    else
      r_out_end_d[6] <= r_out_end_d[5];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[7] <= 0;
    else
      r_out_end_d[7] <= r_out_end_d[6];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[8] <= 0;
    else
      r_out_end_d[8] <= r_out_end_d[7];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[9] <= 0;
    else
      r_out_end_d[9] <= r_out_end_d[8];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[10] <= 0;
    else
      r_out_end_d[10] <= r_out_end_d[9];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[11] <= 0;
    else
      r_out_end_d[11] <= r_out_end_d[10];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[12] <= 0;
    else
      r_out_end_d[12] <= r_out_end_d[11];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[13] <= 0;
    else
      r_out_end_d[13] <= r_out_end_d[12];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[14] <= 0;
    else
      r_out_end_d[14] <= r_out_end_d[13];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[15] <= 0;
    else
      r_out_end_d[15] <= r_out_end_d[14];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[16] <= 0;
    else
      r_out_end_d[16] <= r_out_end_d[15];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[17] <= 0;
    else
      r_out_end_d[17] <= r_out_end_d[16];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[18] <= 0;
    else
      r_out_end_d[18] <= r_out_end_d[17];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[19] <= 0;
    else
      r_out_end_d[19] <= r_out_end_d[18];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[20] <= 0;
    else
      r_out_end_d[20] <= r_out_end_d[19];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[21] <= 0;
    else
      r_out_end_d[21] <= r_out_end_d[20];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[22] <= 0;
    else
      r_out_end_d[22] <= r_out_end_d[21];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[23] <= 0;
    else
      r_out_end_d[23] <= r_out_end_d[22];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[24] <= 0;
    else
      r_out_end_d[24] <= r_out_end_d[23];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[25] <= 0;
    else
      r_out_end_d[25] <= r_out_end_d[24];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[26] <= 0;
    else
      r_out_end_d[26] <= r_out_end_d[25];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[27] <= 0;
    else
      r_out_end_d[27] <= r_out_end_d[26];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[28] <= 0;
    else
      r_out_end_d[28] <= r_out_end_d[27];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[29] <= 0;
    else
      r_out_end_d[29] <= r_out_end_d[28];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[30] <= 0;
    else
      r_out_end_d[30] <= r_out_end_d[29];
  always @(posedge clk)
    if (!xrst)
      r_out_end_d[31] <= 0;
    else
      r_out_end_d[31] <= r_out_end_d[30];

endmodule
