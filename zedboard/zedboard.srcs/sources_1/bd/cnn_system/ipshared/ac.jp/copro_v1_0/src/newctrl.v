/* AUTO_LISP(setq verilog-auto-output-ignore-regexp
    (verilog-regexp-words `(
      "out_core_begin"
      "out_conv_begin"
      "out_pool_begin"
      "out_core_valid"
      "out_conv_valid"
      "out_pool_valid"
      "out_core_end"
      "out_conv_end"
      "out_pool_end"
   ))) */

module newctrl(/*AUTOARG*/
   // Outputs
   buf_pix_en, ack, wreg_we, conv_we, pool_we, buf_feat_en,
   mem_input_addr, mem_weight_addr, mem_feat_we, mem_feat_rst,
   mem_feat_addr, mem_feat_addr_d1, mem_output_we, mem_output_addr,
   w_img_size, w_fil_size, w_fea_size, w_pool_size,
   // Inputs
   pool_size, clk, xrst, req, input_addr, weight_addr, output_addr,
   total_in, total_out, img_size, fil_size
   );
`include "parameters.vh"

  parameter S_CORE_WAIT   = 'd0;
  parameter S_CORE_WEIGHT = 'd1;
  parameter S_CORE_INPUT  = 'd2;
  parameter S_CORE_OUTPUT = 'd3;

  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input [LWIDTH-1:0]	pool_size;		// To ctrl_pool of ctrl_pool.v
  // End of automatics
  input               clk;
  input               xrst;
  input               req;
  input [INSIZE-1:0]  input_addr;
  input [WSIZE-1:0]   weight_addr;
  input [OUTSIZE-1:0] output_addr;
  input [LWIDTH-1:0]  total_in;
  input [LWIDTH-1:0]  total_out;
  input [LWIDTH-1:0]  img_size;
  input [LWIDTH-1:0]  fil_size;

  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output		buf_pix_en;		// From ctrl_core of ctrl_core.v
  // End of automatics
  output                ack;
  output                wreg_we;
  output                conv_we;
  output                pool_we;
  output                buf_feat_en;
  output [INSIZE-1:0]   mem_input_addr;
  output [WSIZE-1:0]    mem_weight_addr;
  output                mem_feat_we;
  output                mem_feat_rst;
  output [FACCUM-1:0]   mem_feat_addr;
  output [FACCUM-1:0]   mem_feat_addr_d1;
  output                mem_output_we;
  output [OUTSIZE-1:0]  mem_output_addr;
  output [LWIDTH-1:0]   w_img_size;
  output [LWIDTH-1:0]   w_fil_size;
  output [LWIDTH-1:0]   w_fea_size;
  output [LWIDTH-1:0]   w_pool_size;

  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire [1:0]		core_state;		// From ctrl_core of ctrl_core.v
  wire			first_input;		// From ctrl_core of ctrl_core.v
  wire			last_input;		// From ctrl_core of ctrl_core.v
  // End of automatics
  wire in_core_begin;
  wire in_conv_begin;
  wire in_pool_begin;
  wire in_relu_begin;
  wire out_core_begin;
  wire out_conv_begin;
  wire out_pool_begin;
  wire out_relu_begin;
  wire in_core_valid;
  wire in_conv_valid;
  wire in_pool_valid;
  wire in_relu_valid;
  wire out_core_valid;
  wire out_conv_valid;
  wire out_pool_valid;
  wire out_relu_valid;
  wire in_core_end;
  wire in_conv_end;
  wire in_pool_end;
  wire in_relu_end;
  wire out_core_end;
  wire out_conv_end;
  wire out_pool_end;
  wire out_relu_end;

  /*AUTOREG*/


//====================================================================
// control modules
//====================================================================

  assign in_conv_begin = out_core_begin;
  assign in_pool_begin = out_conv_begin;
  assign in_core_begin = out_pool_begin;
  assign in_conv_valid = out_core_valid;
  assign in_pool_valid = out_conv_valid;
  assign in_core_valid = out_pool_valid;
  assign in_conv_end = out_core_end;
  assign in_pool_end = out_conv_end;
  assign in_core_end = out_pool_end;

  /* ctrl_core AUTO_TEMPLATE (
      .in_begin    (in_core_begin),
      .out_begin  (out_core_begin),
      .in_valid    (in_core_valid),
      .out_valid  (out_core_valid),
      .in_end    (in_core_end),
      .out_end  (out_core_end),
  ); */
  ctrl_core ctrl_core(/*AUTOINST*/
		      // Outputs
		      .ack		(ack),
		      .core_state	(core_state[2-1:0]),
		      .out_begin	(out_core_begin),	 // Templated
		      .out_valid	(out_core_valid),	 // Templated
		      .out_end		(out_core_end),		 // Templated
		      .buf_pix_en	(buf_pix_en),
		      .mem_input_addr	(mem_input_addr[INSIZE-1:0]),
		      .mem_weight_addr	(mem_weight_addr[WSIZE-1:0]),
		      .mem_output_we	(mem_output_we),
		      .mem_output_addr	(mem_output_addr[OUTSIZE-1:0]),
		      .first_input	(first_input),
		      .last_input	(last_input),
		      .wreg_we		(wreg_we),
		      .w_img_size	(w_img_size[LWIDTH-1:0]),
		      .w_fil_size	(w_fil_size[LWIDTH-1:0]),
		      // Inputs
		      .clk		(clk),
		      .xrst		(xrst),
		      .req		(req),
		      .in_begin		(in_core_begin),	 // Templated
		      .in_valid		(in_core_valid),	 // Templated
		      .in_end		(in_core_end),		 // Templated
		      .input_addr	(input_addr[INSIZE-1:0]),
		      .weight_addr	(weight_addr[WSIZE-1:0]),
		      .output_addr	(output_addr[OUTSIZE-1:0]),
		      .total_out	(total_out[LWIDTH-1:0]),
		      .total_in		(total_in[LWIDTH-1:0]),
		      .img_size		(img_size[LWIDTH-1:0]),
		      .fil_size		(fil_size[LWIDTH-1:0]));

  /* ctrl_conv AUTO_TEMPLATE (
      .in_begin    (in_conv_begin),
      .out_begin  (out_conv_begin),
      .in_valid    (in_conv_valid),
      .out_valid  (out_conv_valid),
      .in_end    (in_conv_end),
      .out_end  (out_conv_end),
  ); */
  ctrl_conv ctrl_conv(/*AUTOINST*/
		      // Outputs
		      .out_begin	(out_conv_begin),	 // Templated
		      .out_valid	(out_conv_valid),	 // Templated
		      .out_end		(out_conv_end),		 // Templated
		      .mem_feat_we	(mem_feat_we),
		      .mem_feat_rst	(mem_feat_rst),
		      .mem_feat_addr	(mem_feat_addr[FACCUM-1:0]),
		      .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]),
		      .conv_we		(conv_we),
		      .w_fea_size	(w_fea_size[LWIDTH-1:0]),
		      // Inputs
		      .clk		(clk),
		      .xrst		(xrst),
		      .in_begin		(in_conv_begin),	 // Templated
		      .in_valid		(in_conv_valid),	 // Templated
		      .in_end		(in_conv_end),		 // Templated
		      .core_state	(core_state[2-1:0]),
		      .w_img_size	(w_img_size[LWIDTH-1:0]),
		      .w_fil_size	(w_fil_size[LWIDTH-1:0]),
		      .first_input	(first_input),
		      .last_input	(last_input));

  /* ctrl_pool AUTO_TEMPLATE (
      .in_begin    (in_pool_begin),
      .out_begin  (out_pool_begin),
      .in_valid    (in_pool_valid),
      .out_valid  (out_pool_valid),
      .in_end    (in_pool_end),
      .out_end  (out_pool_end),
  ); */
  ctrl_pool ctrl_pool(/*AUTOINST*/
		      // Outputs
		      .buf_feat_en	(buf_feat_en),
		      .out_begin	(out_pool_begin),	 // Templated
		      .out_valid	(out_pool_valid),	 // Templated
		      .out_end		(out_pool_end),		 // Templated
		      .pool_we		(pool_we),
		      .w_pool_size	(w_pool_size[LWIDTH-1:0]),
		      // Inputs
		      .clk		(clk),
		      .xrst		(xrst),
		      .in_begin		(in_pool_begin),	 // Templated
		      .in_valid		(in_pool_valid),	 // Templated
		      .in_end		(in_pool_end),		 // Templated
		      .w_fea_size	(w_fea_size[LWIDTH-1:0]),
		      .pool_size	(pool_size[LWIDTH-1:0]));

  /* ctrl_relu AUTO_TEMPLATE (
      .in_begin   (in_relu_begin),
      .out_begin (out_relu_begin),
      .in_valid   (in_relu_valid),
      .out_valid (out_relu_valid),
      .in_end   (in_relu_end),
      .out_end (out_relu_end),
  ); */
  //ctrl_relu ctrl_relu(/*AUTOINST*/);


endmodule
