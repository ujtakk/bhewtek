
module core(/*AUTOARG*/
   // Outputs
   pmap,
   // Inputs
   xrst, wreg_we, w_pool_size, w_fea_size, relu_oe, read_weight,
   read_bias, pool_oe, pixel9, pixel8, pixel7, pixel6, pixel5, pixel4,
   pixel3, pixel24, pixel23, pixel22, pixel21, pixel20, pixel2,
   pixel19, pixel18, pixel17, pixel16, pixel15, pixel14, pixel13,
   pixel12, pixel11, pixel10, pixel1, pixel0, mem_feat_we,
   mem_feat_rst, mem_feat_addr_d1, mem_feat_addr, conv_oe, clk,
   buf_feat_en, breg_we, bias_oe
   );
`include "parameters.vh"

  /*AUTOINPUT*/
  // Beginning of automatic inputs (from unused autoinst inputs)
  input			bias_oe;		// To bias of bias.v
  input			breg_we;		// To bias of bias.v
  input			buf_feat_en;		// To buf_feat of linebuf.v
  input			clk;			// To conv of conv.v, ...
  input			conv_oe;		// To feat_accum of accumulator.v
  input [FACCUM-1:0]	mem_feat_addr;		// To mem_feat of mem_feat.v
  input [FACCUM-1:0]	mem_feat_addr_d1;	// To mem_feat of mem_feat.v
  input			mem_feat_rst;		// To feat_accum of accumulator.v
  input			mem_feat_we;		// To mem_feat of mem_feat.v
  input signed [DWIDTH-1:0] pixel0;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel1;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel10;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel11;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel12;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel13;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel14;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel15;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel16;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel17;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel18;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel19;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel2;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel20;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel21;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel22;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel23;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel24;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel3;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel4;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel5;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel6;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel7;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel8;		// To conv of conv.v
  input signed [DWIDTH-1:0] pixel9;		// To conv of conv.v
  input			pool_oe;		// To pool of pool.v
  input signed [DWIDTH-1:0] read_bias;		// To bias of bias.v
  input signed [DWIDTH-1:0] read_weight;	// To conv of conv.v
  input			relu_oe;		// To relu of relu.v
  input [LWIDTH-1:0]	w_fea_size;		// To buf_feat of linebuf.v
  input [LWIDTH-1:0]	w_pool_size;		// To buf_feat of linebuf.v
  input			wreg_we;		// To conv of conv.v
  input			xrst;			// To conv of conv.v, ...
  // End of automatics

  /*AUTOOUTPUT*/
  // Beginning of automatic outputs (from unused autoinst outputs)
  output signed [DWIDTH-1:0] pmap;		// From pool of pool.v
  // End of automatics

  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire signed [DWIDTH-1:0] actived;		// From relu of relu.v
  wire signed [DWIDTH-1:0] biased;		// From bias of bias.v
  wire signed [DWIDTH-1:0] fmap;		// From feat_accum of accumulator.v
  wire signed [DWIDTH-1:0] pixel_feat0;		// From buf_feat of linebuf.v
  wire signed [DWIDTH-1:0] pixel_feat1;		// From buf_feat of linebuf.v
  wire signed [DWIDTH-1:0] pixel_feat2;		// From buf_feat of linebuf.v
  wire signed [DWIDTH-1:0] pixel_feat3;		// From buf_feat of linebuf.v
  wire signed [DWIDTH-1:0] read_feat;		// From mem_feat of mem_feat.v
  wire signed [DWIDTH-1:0] result;		// From conv of conv.v
  wire signed [DWIDTH-1:0] write_feat;		// From feat_accum of accumulator.v
  // End of automatics

  /*AUTOREG*/

  // AUTO_CONSTANT (DWIDTH)

  /* conv AUTO_TEMPLATE (
      .fmap       (result[DWIDTH-1:0]),
      .wreg_we    (wreg_we),
      .read_data  (read_weight[DWIDTH-1:0]),
  ); */
  conv conv(/*AUTOINST*/
	    // Outputs
	    .fmap			(result[DWIDTH-1:0]),	 // Templated
	    // Inputs
	    .clk			(clk),
	    .pixel0			(pixel0[DWIDTH-1:0]),
	    .pixel1			(pixel1[DWIDTH-1:0]),
	    .pixel10			(pixel10[DWIDTH-1:0]),
	    .pixel11			(pixel11[DWIDTH-1:0]),
	    .pixel12			(pixel12[DWIDTH-1:0]),
	    .pixel13			(pixel13[DWIDTH-1:0]),
	    .pixel14			(pixel14[DWIDTH-1:0]),
	    .pixel15			(pixel15[DWIDTH-1:0]),
	    .pixel16			(pixel16[DWIDTH-1:0]),
	    .pixel17			(pixel17[DWIDTH-1:0]),
	    .pixel18			(pixel18[DWIDTH-1:0]),
	    .pixel19			(pixel19[DWIDTH-1:0]),
	    .pixel2			(pixel2[DWIDTH-1:0]),
	    .pixel20			(pixel20[DWIDTH-1:0]),
	    .pixel21			(pixel21[DWIDTH-1:0]),
	    .pixel22			(pixel22[DWIDTH-1:0]),
	    .pixel23			(pixel23[DWIDTH-1:0]),
	    .pixel24			(pixel24[DWIDTH-1:0]),
	    .pixel3			(pixel3[DWIDTH-1:0]),
	    .pixel4			(pixel4[DWIDTH-1:0]),
	    .pixel5			(pixel5[DWIDTH-1:0]),
	    .pixel6			(pixel6[DWIDTH-1:0]),
	    .pixel7			(pixel7[DWIDTH-1:0]),
	    .pixel8			(pixel8[DWIDTH-1:0]),
	    .pixel9			(pixel9[DWIDTH-1:0]),
	    .read_data			(read_weight[DWIDTH-1:0]), // Templated
	    .wreg_we			(wreg_we),		 // Templated
	    .xrst			(xrst));

  /* mem_feat AUTO_TEMPLATE (
      .read_data1   (),
      .write_data1  (write_feat[DWIDTH-1:0]),
      .mem_we1      (mem_feat_we),
      .mem_addr1    (mem_feat_addr_d1[FACCUM-1:0]),
      .read_data2   (read_feat[DWIDTH-1:0]),
      .write_data2  ({DWIDTH{1'b0}}),
      .mem_we2      (1'b0),
      .mem_addr2    (mem_feat_addr[FACCUM-1:0]),
  ); */
  mem_feat mem_feat(/*AUTOINST*/
		    // Outputs
		    .read_data1		(),			 // Templated
		    .read_data2		(read_feat[DWIDTH-1:0]), // Templated
		    // Inputs
		    .clk		(clk),
		    .mem_we1		(mem_feat_we),		 // Templated
		    .mem_we2		(1'b0),			 // Templated
		    .mem_addr1		(mem_feat_addr_d1[FACCUM-1:0]), // Templated
		    .mem_addr2		(mem_feat_addr[FACCUM-1:0]), // Templated
		    .write_data1	(write_feat[DWIDTH-1:0]), // Templated
		    .write_data2	({DWIDTH{1'b0}}));	 // Templated

  /* accumulator AUTO_TEMPLATE (
      .total    (fmap[DWIDTH-1:0]),
      .result   (result[DWIDTH-1:0]),
      .out_en   (conv_oe),
      .reset    (mem_feat_rst),
      .sum_old  (read_feat[DWIDTH-1:0]),
      .sum_new   (write_feat[DWIDTH-1:0]),
  ); */
  accumulator feat_accum(/*AUTOINST*/
			 // Outputs
			 .total			(fmap[DWIDTH-1:0]), // Templated
			 .sum_new		(write_feat[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .xrst			(xrst),
			 .reset			(mem_feat_rst),	 // Templated
			 .out_en		(conv_oe),	 // Templated
			 .result		(result[DWIDTH-1:0]), // Templated
			 .sum_old		(read_feat[DWIDTH-1:0])); // Templated

  /* bias AUTO_TEMPLATE (
      .read_bias  (read_bias[DWIDTH-1:0]),
      .breg_we    (breg_we),
      .out_en     (bias_oe),
      .pixel_in   (fmap[DWIDTH-1:0]),
      .pixel_out  (biased[DWIDTH-1:0]),
  ); */
  bias bias(/*AUTOINST*/
	    // Outputs
	    .pixel_out			(biased[DWIDTH-1:0]),	 // Templated
	    // Inputs
	    .clk			(clk),
	    .xrst			(xrst),
	    .breg_we			(breg_we),		 // Templated
	    .out_en			(bias_oe),		 // Templated
	    .read_bias			(read_bias[DWIDTH-1:0]), // Templated
	    .pixel_in			(fmap[DWIDTH-1:0]));	 // Templated

  /* relu AUTO_TEMPLATE (
      .out_en     (relu_oe),
      .pixel_in   (biased[DWIDTH-1:0]),
      .pixel_out  (actived[DWIDTH-1:0]),
  ); */
  relu relu(/*AUTOINST*/
	    // Outputs
	    .pixel_out			(actived[DWIDTH-1:0]),	 // Templated
	    // Inputs
	    .clk			(clk),
	    .xrst			(xrst),
	    .out_en			(relu_oe),		 // Templated
	    .pixel_in			(biased[DWIDTH-1:0]));	 // Templated

  /* linebuf AUTO_TEMPLATE (
      .buf_en     (buf_feat_en),
      .buf_input  (actived[DWIDTH-1:0]),
      .img_size   (w_fea_size[LWIDTH-1:0]),
      .fil_size   (w_pool_size[LWIDTH-1:0]),
      .buf_output0_0 (pixel_feat0[DWIDTH-1:0]),
      .buf_output0_1 (pixel_feat1[DWIDTH-1:0]),
      .buf_output0_2 (),
      .buf_output0_3 (),
      .buf_output0_4 (),
      .buf_output1_0 (pixel_feat2[DWIDTH-1:0]),
      .buf_output1_1 (pixel_feat3[DWIDTH-1:0]),
      .buf_output1_2 (),
      .buf_output1_3 (),
      .buf_output1_4 (),
      .buf_output2_0 (),
      .buf_output2_1 (),
      .buf_output2_2 (),
      .buf_output2_3 (),
      .buf_output2_4 (),
      .buf_output3_0 (),
      .buf_output3_1 (),
      .buf_output3_2 (),
      .buf_output3_3 (),
      .buf_output3_4 (),
      .buf_output4_0 (),
      .buf_output4_1 (),
      .buf_output4_2 (),
      .buf_output4_3 (),
      .buf_output4_4 (),
  ); */
  linebuf buf_feat(/*AUTOINST*/
		   // Outputs
		   .buf_output0_0	(pixel_feat0[DWIDTH-1:0]), // Templated
		   .buf_output0_1	(pixel_feat1[DWIDTH-1:0]), // Templated
		   .buf_output0_2	(),			 // Templated
		   .buf_output0_3	(),			 // Templated
		   .buf_output0_4	(),			 // Templated
		   .buf_output1_0	(pixel_feat2[DWIDTH-1:0]), // Templated
		   .buf_output1_1	(pixel_feat3[DWIDTH-1:0]), // Templated
		   .buf_output1_2	(),			 // Templated
		   .buf_output1_3	(),			 // Templated
		   .buf_output1_4	(),			 // Templated
		   .buf_output2_0	(),			 // Templated
		   .buf_output2_1	(),			 // Templated
		   .buf_output2_2	(),			 // Templated
		   .buf_output2_3	(),			 // Templated
		   .buf_output2_4	(),			 // Templated
		   .buf_output3_0	(),			 // Templated
		   .buf_output3_1	(),			 // Templated
		   .buf_output3_2	(),			 // Templated
		   .buf_output3_3	(),			 // Templated
		   .buf_output3_4	(),			 // Templated
		   .buf_output4_0	(),			 // Templated
		   .buf_output4_1	(),			 // Templated
		   .buf_output4_2	(),			 // Templated
		   .buf_output4_3	(),			 // Templated
		   .buf_output4_4	(),			 // Templated
		   // Inputs
		   .clk			(clk),
		   .xrst		(xrst),
		   .buf_en		(buf_feat_en),		 // Templated
		   .img_size		(w_fea_size[LWIDTH-1:0]), // Templated
		   .fil_size		(w_pool_size[LWIDTH-1:0]), // Templated
		   .buf_input		(actived[DWIDTH-1:0]));	 // Templated

  /* pool AUTO_TEMPLATE (
      .pmap             (pmap[DWIDTH-1:0]),
      .out_en           (pool_oe),
      .pixel_feat0 (pixel_feat0[DWIDTH-1:0]),
      .pixel_feat1 (pixel_feat1[DWIDTH-1:0]),
      .pixel_feat2 (pixel_feat2[DWIDTH-1:0]),
      .pixel_feat3 (pixel_feat3[DWIDTH-1:0]),
  ); */
  pool pool(/*AUTOINST*/
	    // Outputs
	    .pmap			(pmap[DWIDTH-1:0]),	 // Templated
	    // Inputs
	    .clk			(clk),
	    .xrst			(xrst),
	    .out_en			(pool_oe),		 // Templated
	    .pixel_feat0		(pixel_feat0[DWIDTH-1:0]), // Templated
	    .pixel_feat1		(pixel_feat1[DWIDTH-1:0]), // Templated
	    .pixel_feat2		(pixel_feat2[DWIDTH-1:0]), // Templated
	    .pixel_feat3		(pixel_feat3[DWIDTH-1:0])); // Templated

endmodule
