module core(/*AUTOARG*/
   // Outputs
   pmap,
   // Inputs
   xrst, wreg_we, read_weight, pool_we, pixel9, pixel8, pixel7,
   pixel6, pixel5, pixel4, pixel3, pixel24, pixel23, pixel22, pixel21,
   pixel20, pixel2, pixel19, pixel18, pixel17, pixel16, pixel15,
   pixel14, pixel13, pixel12, pixel11, pixel10, pixel1, pixel0,
   mem_feat_we, mem_feat_rst, mem_feat_addr_d1, mem_feat_addr,
   conv_we, clk
   );
`include "parameters.vh"

    /*AUTOINPUT*/
    // Beginning of automatic inputs (from unused autoinst inputs)
    input		clk;			// To conv of conv.v, ...
    input		conv_we;		// To feat_accum of accumulator.v
    input [FACCUM-1:0]	mem_feat_addr;		// To mem_feat of sram_feat.v
    input [FACCUM-1:0]	mem_feat_addr_d1;	// To mem_feat of sram_feat.v
    input		mem_feat_rst;		// To feat_accum of accumulator.v
    input		mem_feat_we;		// To mem_feat of sram_feat.v
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
    input		pool_we;		// To pool of pool.v
    input signed [DWIDTH-1:0] read_weight;	// To conv of conv.v
    input		wreg_we;		// To conv of conv.v
    input		xrst;			// To conv of conv.v
    // End of automatics

    /*AUTOOUTPUT*/
    // Beginning of automatic outputs (from unused autoinst outputs)
    output signed [DWIDTH-1:0] pmap;		// From pool of pool.v
    // End of automatics

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire signed [DWIDTH-1:0] fmap;		// From feat_accum of accumulator.v
    wire signed [DWIDTH-1:0] pixel_feat0;	// From buf_feat of linebuf_feat.v
    wire signed [DWIDTH-1:0] pixel_feat1;	// From buf_feat of linebuf_feat.v
    wire signed [DWIDTH-1:0] pixel_feat2;	// From buf_feat of linebuf_feat.v
    wire signed [DWIDTH-1:0] pixel_feat3;	// From buf_feat of linebuf_feat.v
    wire signed [DWIDTH-1:0] read_feat;		// From mem_feat of sram_feat.v
    wire signed [DWIDTH-1:0] result;		// From conv of conv.v
    wire signed [DWIDTH-1:0] write_feat;	// From feat_accum of accumulator.v
    // End of automatics

    /*AUTOREG*/

    // AUTO_CONSTANT (DWIDTH)

    /* conv AUTO_TEMPLATE (
        .fmap      (result[DWIDTH-1:0]),
        .wreg_we   (wreg_we),
        .read_data (read_weight[DWIDTH-1:0]),
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
	      .read_data		(read_weight[DWIDTH-1:0]), // Templated
	      .wreg_we			(wreg_we),		 // Templated
	      .xrst			(xrst));

    /* sram_feat AUTO_TEMPLATE (
        //.read_data1  ({DWIDTH{1'b0}}),
        .read_data1  (),
        .write_data1 (write_feat[DWIDTH-1:0]),
        .mem_we1     (mem_feat_we),
        .mem_addr1   (mem_feat_addr_d1[FACCUM-1:0]),
        .read_data2  (read_feat[DWIDTH-1:0]),
        .write_data2 ({DWIDTH{1'b0}}),
        .mem_we2     (1'b0),
        .mem_addr2   (mem_feat_addr[FACCUM-1:0]),
    ); */
    sram_feat mem_feat(/*AUTOINST*/
		       // Outputs
		       .read_data1	(),			 // Templated
		       .read_data2	(read_feat[DWIDTH-1:0]), // Templated
		       // Inputs
		       .clk		(clk),
		       .mem_we1		(mem_feat_we),		 // Templated
		       .mem_we2		(1'b0),			 // Templated
		       .mem_addr1	(mem_feat_addr_d1[FACCUM-1:0]), // Templated
		       .mem_addr2	(mem_feat_addr[FACCUM-1:0]), // Templated
		       .write_data1	(write_feat[DWIDTH-1:0]), // Templated
		       .write_data2	({DWIDTH{1'b0}}));	 // Templated

    /* accumulator AUTO_TEMPLATE (
        .total   (fmap[DWIDTH-1:0]),
        .result  (result[DWIDTH-1:0]),
        .o_we    (conv_we),
        .reset   (mem_feat_rst),
        .sum_old (read_feat[DWIDTH-1:0]),
        .sum_wb  (write_feat[DWIDTH-1:0]),
    ); */
    accumulator feat_accum(/*AUTOINST*/
			   // Outputs
			   .total		(fmap[DWIDTH-1:0]), // Templated
			   .sum_wb		(write_feat[DWIDTH-1:0]), // Templated
			   // Inputs
			   .clk			(clk),
			   .reset		(mem_feat_rst),	 // Templated
			   .o_we		(conv_we),	 // Templated
			   .result		(result[DWIDTH-1:0]), // Templated
			   .sum_old		(read_feat[DWIDTH-1:0])); // Templated

    /* linebuf_feat AUTO_TEMPLATE (
        .pixel_feat0 (pixel_feat0[DWIDTH-1:0]),
        .pixel_feat1 (pixel_feat1[DWIDTH-1:0]),
        .pixel_feat2 (pixel_feat2[DWIDTH-1:0]),
        .pixel_feat3 (pixel_feat3[DWIDTH-1:0]),
        .read_data        (fmap[DWIDTH-1:0]),
    ); */
    linebuf_feat buf_feat(/*AUTOINST*/
			  // Outputs
			  .pixel_feat0		(pixel_feat0[DWIDTH-1:0]), // Templated
			  .pixel_feat1		(pixel_feat1[DWIDTH-1:0]), // Templated
			  .pixel_feat2		(pixel_feat2[DWIDTH-1:0]), // Templated
			  .pixel_feat3		(pixel_feat3[DWIDTH-1:0]), // Templated
			  // Inputs
			  .clk			(clk),
			  .read_data		(fmap[DWIDTH-1:0])); // Templated

    /* pool AUTO_TEMPLATE (
        .pmap             (pmap[DWIDTH-1:0]),
        .o_we             (pool_we),
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
	      .o_we			(pool_we),		 // Templated
	      .pixel_feat0		(pixel_feat0[DWIDTH-1:0]), // Templated
	      .pixel_feat1		(pixel_feat1[DWIDTH-1:0]), // Templated
	      .pixel_feat2		(pixel_feat2[DWIDTH-1:0]), // Templated
	      .pixel_feat3		(pixel_feat3[DWIDTH-1:0])); // Templated

endmodule
