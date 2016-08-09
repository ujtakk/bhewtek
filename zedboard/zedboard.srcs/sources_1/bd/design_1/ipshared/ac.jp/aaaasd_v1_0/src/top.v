module top(/*AUTOARG*/
   // Outputs
   probe, read_output, ack,
   // Inputs
   xrst, write_weight, write_input, weight_we, weight_addr, total_out,
   total_in, req, output_re, output_addr, input_we, input_addr,
   img_size, fil_size, clk
   );
`include "parameters.vh"

    /*AUTOINPUT*/
    // Beginning of automatic inputs (from unused autoinst inputs)
    input		clk;			// To mem_input of sram_input.v, ...
    input [LWIDTH-1:0]	fil_size;		// To ctrl of ctrl.v, ...
    input [LWIDTH-1:0]	img_size;		// To ctrl of ctrl.v, ...
    input [INSIZE-1:0]	input_addr;		// To ctrl of ctrl.v
    input		input_we;		// To mem_input of sram_input.v
    input [OUTSIZE-1:0]	output_addr;		// To ctrl of ctrl.v
    input [3:0]		output_re;		// To select_out of mux_output.v
    input		req;			// To ctrl of ctrl.v
    input [LWIDTH-1:0]	total_in;		// To ctrl of ctrl.v
    input [LWIDTH-1:0]	total_out;		// To ctrl of ctrl.v
    input [WSIZE-1:0]	weight_addr;		// To ctrl of ctrl.v
    input [3:0]		weight_we;		// To dec_weight of decoder.v
    input signed [DWIDTH-1:0] write_input;	// To mem_input of sram_input.v
    input signed [DWIDTH-1:0] write_weight;	// To mem_weight0 of sram_weight.v, ...
    input		xrst;			// To ctrl of ctrl.v, ...
    // End of automatics

    /*AUTOOUTPUT*/
    // Beginning of automatic outputs (from unused autoinst outputs)
    output		ack;			// From ctrl of ctrl.v
    output signed [DWIDTH-1:0] read_output;	// From select_out of mux_output.v
    output signed [DWIDTH-1:0] probe;
    // End of automatics

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		conv_we;		// From ctrl of ctrl.v
    wire [FACCUM-1:0]	mem_feat_addr;		// From ctrl of ctrl.v
    wire [FACCUM-1:0]	mem_feat_addr_d1;	// From ctrl of ctrl.v
    wire		mem_feat_rst;		// From ctrl of ctrl.v
    wire		mem_feat_we;		// From ctrl of ctrl.v
    wire [INSIZE-1:0]	mem_input_addr;		// From ctrl of ctrl.v
    wire [OUTSIZE-1:0]	mem_output_addr;	// From ctrl of ctrl.v
    wire		mem_output_we;		// From ctrl of ctrl.v
    wire [WSIZE-1:0]	mem_weight_addr;	// From ctrl of ctrl.v
    wire [7:0]		mem_weight_we;		// From dec_weight of decoder.v
    wire [DWIDTH-1:0]	pixel0;			// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel1;			// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel10;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel11;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel12;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel13;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel14;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel15;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel16;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel17;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel18;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel19;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel2;			// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel20;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel21;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel22;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel23;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel24;		// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel3;			// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel4;			// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel5;			// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel6;			// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel7;			// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel8;			// From buf_pix of linebuf_pix.v
    wire [DWIDTH-1:0]	pixel9;			// From buf_pix of linebuf_pix.v
    wire signed [DWIDTH-1:0] pmap0;		// From core0 of core.v
    wire signed [DWIDTH-1:0] pmap1;		// From core1 of core.v
    wire signed [DWIDTH-1:0] pmap2;		// From core2 of core.v
    wire signed [DWIDTH-1:0] pmap3;		// From core3 of core.v
    wire signed [DWIDTH-1:0] pmap4;		// From core4 of core.v
    wire signed [DWIDTH-1:0] pmap5;		// From core5 of core.v
    wire signed [DWIDTH-1:0] pmap6;		// From core6 of core.v
    wire signed [DWIDTH-1:0] pmap7;		// From core7 of core.v
    wire		pool_we;		// From ctrl of ctrl.v
    wire signed [DWIDTH-1:0] read_input;	// From mem_input of sram_input.v
    wire signed [DWIDTH-1:0] read_output0;	// From mem_output0 of sram_output.v
    wire signed [DWIDTH-1:0] read_output1;	// From mem_output1 of sram_output.v
    wire signed [DWIDTH-1:0] read_output2;	// From mem_output2 of sram_output.v
    wire signed [DWIDTH-1:0] read_output3;	// From mem_output3 of sram_output.v
    wire signed [DWIDTH-1:0] read_output4;	// From mem_output4 of sram_output.v
    wire signed [DWIDTH-1:0] read_output5;	// From mem_output5 of sram_output.v
    wire signed [DWIDTH-1:0] read_output6;	// From mem_output6 of sram_output.v
    wire signed [DWIDTH-1:0] read_output7;	// From mem_output7 of sram_output.v
    wire signed [DWIDTH-1:0] read_weight0;	// From mem_weight0 of sram_weight.v
    wire signed [DWIDTH-1:0] read_weight1;	// From mem_weight1 of sram_weight.v
    wire signed [DWIDTH-1:0] read_weight2;	// From mem_weight2 of sram_weight.v
    wire signed [DWIDTH-1:0] read_weight3;	// From mem_weight3 of sram_weight.v
    wire signed [DWIDTH-1:0] read_weight4;	// From mem_weight4 of sram_weight.v
    wire signed [DWIDTH-1:0] read_weight5;	// From mem_weight5 of sram_weight.v
    wire signed [DWIDTH-1:0] read_weight6;	// From mem_weight6 of sram_weight.v
    wire signed [DWIDTH-1:0] read_weight7;	// From mem_weight7 of sram_weight.v
    wire		wreg_we;		// From ctrl of ctrl.v
    // End of automatics

    /*AUTOREG*/

    // AUTO_CONSTANT (DWIDTH)

    assign probe = read_input;

    /* sram_input AUTO_TEMPLATE (
        .read_data  (read_input[DWIDTH-1:0]),
        .write_data (write_input[DWIDTH-1:0]),
        .mem_we     (input_we),
        .mem_addr   (mem_input_addr[INSIZE-1:0]),
    ); */
    sram_input mem_input(/*AUTOINST*/
			 // Outputs
			 .read_data		(read_input[DWIDTH-1:0]), // Templated
			 // Inputs
			 .clk			(clk),
			 .mem_we		(input_we),	 // Templated
			 .mem_addr		(mem_input_addr[INSIZE-1:0]), // Templated
			 .write_data		(write_input[DWIDTH-1:0])); // Templated

    /* decoder AUTO_TEMPLATE (
        .in_code (weight_we[3:0]),
        .out_code (mem_weight_we[7:0]),
    ); */
    decoder dec_weight(/*AUTOINST*/
		       // Outputs
		       .out_code	(mem_weight_we[7:0]),	 // Templated
		       // Inputs
		       .clk		(clk),
		       .in_code		(weight_we[3:0]));	 // Templated

    /* sram_weight AUTO_TEMPLATE (
        .read_data  (read_weight0[DWIDTH-1:0]),
        .write_data (write_weight[DWIDTH-1:0]),
        .mem_we     (mem_weight_we[0]),
        .mem_addr   (mem_weight_addr[WSIZE-1:0]),
    ); */
    sram_weight mem_weight0(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_weight0[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_weight_we[0]), // Templated
			    .mem_addr		(mem_weight_addr[WSIZE-1:0]), // Templated
			    .write_data		(write_weight[DWIDTH-1:0])); // Templated
    /* sram_weight AUTO_TEMPLATE (
        .read_data  (read_weight1[DWIDTH-1:0]),
        .write_data (write_weight[DWIDTH-1:0]),
        .mem_we     (mem_weight_we[1]),
        .mem_addr   (mem_weight_addr[WSIZE-1:0]),
    ); */
    sram_weight mem_weight1(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_weight1[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_weight_we[1]), // Templated
			    .mem_addr		(mem_weight_addr[WSIZE-1:0]), // Templated
			    .write_data		(write_weight[DWIDTH-1:0])); // Templated
    /* sram_weight AUTO_TEMPLATE (
        .read_data  (read_weight2[DWIDTH-1:0]),
        .write_data (write_weight[DWIDTH-1:0]),
        .mem_we     (mem_weight_we[2]),
        .mem_addr   (mem_weight_addr[WSIZE-1:0]),
    ); */
    sram_weight mem_weight2(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_weight2[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_weight_we[2]), // Templated
			    .mem_addr		(mem_weight_addr[WSIZE-1:0]), // Templated
			    .write_data		(write_weight[DWIDTH-1:0])); // Templated
    /* sram_weight AUTO_TEMPLATE (
        .read_data  (read_weight3[DWIDTH-1:0]),
        .write_data (write_weight[DWIDTH-1:0]),
        .mem_we     (mem_weight_we[3]),
        .mem_addr   (mem_weight_addr[WSIZE-1:0]),
    ); */
    sram_weight mem_weight3(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_weight3[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_weight_we[3]), // Templated
			    .mem_addr		(mem_weight_addr[WSIZE-1:0]), // Templated
			    .write_data		(write_weight[DWIDTH-1:0])); // Templated
    /* sram_weight AUTO_TEMPLATE (
        .read_data  (read_weight4[DWIDTH-1:0]),
        .write_data (write_weight[DWIDTH-1:0]),
        .mem_we     (mem_weight_we[4]),
        .mem_addr   (mem_weight_addr[WSIZE-1:0]),
    ); */
    sram_weight mem_weight4(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_weight4[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_weight_we[4]), // Templated
			    .mem_addr		(mem_weight_addr[WSIZE-1:0]), // Templated
			    .write_data		(write_weight[DWIDTH-1:0])); // Templated
    /* sram_weight AUTO_TEMPLATE (
        .read_data  (read_weight5[DWIDTH-1:0]),
        .write_data (write_weight[DWIDTH-1:0]),
        .mem_we     (mem_weight_we[5]),
        .mem_addr   (mem_weight_addr[WSIZE-1:0]),
    ); */
    sram_weight mem_weight5(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_weight5[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_weight_we[5]), // Templated
			    .mem_addr		(mem_weight_addr[WSIZE-1:0]), // Templated
			    .write_data		(write_weight[DWIDTH-1:0])); // Templated
    /* sram_weight AUTO_TEMPLATE (
        .read_data  (read_weight6[DWIDTH-1:0]),
        .write_data (write_weight[DWIDTH-1:0]),
        .mem_we     (mem_weight_we[6]),
        .mem_addr   (mem_weight_addr[WSIZE-1:0]),
    ); */
    sram_weight mem_weight6(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_weight6[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_weight_we[6]), // Templated
			    .mem_addr		(mem_weight_addr[WSIZE-1:0]), // Templated
			    .write_data		(write_weight[DWIDTH-1:0])); // Templated
    /* sram_weight AUTO_TEMPLATE (
        .read_data  (read_weight7[DWIDTH-1:0]),
        .write_data (write_weight[DWIDTH-1:0]),
        .mem_we     (mem_weight_we[7]),
        .mem_addr   (mem_weight_addr[WSIZE-1:0]),
    ); */
    sram_weight mem_weight7(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_weight7[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_weight_we[7]), // Templated
			    .mem_addr		(mem_weight_addr[WSIZE-1:0]), // Templated
			    .write_data		(write_weight[DWIDTH-1:0])); // Templated

    /* linebuf_pix AUTO_TEMPLATE (
        .read_data (read_input[DWIDTH-1:0]),
    ); */
    linebuf_pix buf_pix(/*AUTOINST*/
			// Outputs
			.pixel0		(pixel0[DWIDTH-1:0]),
			.pixel1		(pixel1[DWIDTH-1:0]),
			.pixel2		(pixel2[DWIDTH-1:0]),
			.pixel3		(pixel3[DWIDTH-1:0]),
			.pixel4		(pixel4[DWIDTH-1:0]),
			.pixel5		(pixel5[DWIDTH-1:0]),
			.pixel6		(pixel6[DWIDTH-1:0]),
			.pixel7		(pixel7[DWIDTH-1:0]),
			.pixel8		(pixel8[DWIDTH-1:0]),
			.pixel9		(pixel9[DWIDTH-1:0]),
			.pixel10	(pixel10[DWIDTH-1:0]),
			.pixel11	(pixel11[DWIDTH-1:0]),
			.pixel12	(pixel12[DWIDTH-1:0]),
			.pixel13	(pixel13[DWIDTH-1:0]),
			.pixel14	(pixel14[DWIDTH-1:0]),
			.pixel15	(pixel15[DWIDTH-1:0]),
			.pixel16	(pixel16[DWIDTH-1:0]),
			.pixel17	(pixel17[DWIDTH-1:0]),
			.pixel18	(pixel18[DWIDTH-1:0]),
			.pixel19	(pixel19[DWIDTH-1:0]),
			.pixel20	(pixel20[DWIDTH-1:0]),
			.pixel21	(pixel21[DWIDTH-1:0]),
			.pixel22	(pixel22[DWIDTH-1:0]),
			.pixel23	(pixel23[DWIDTH-1:0]),
			.pixel24	(pixel24[DWIDTH-1:0]),
			// Inputs
			.clk		(clk),
			.read_data	(read_input[DWIDTH-1:0])); // Templated

    /* ctrl AUTO_TEMPLATE (
        .fil_h (fil_size[LWIDTH-1:0]),
        .fil_w (fil_size[LWIDTH-1:0]),
        .img_h (img_size[LWIDTH-1:0]),
        .img_w (img_size[LWIDTH-1:0]),
    ); */
    ctrl ctrl(/*AUTOINST*/
	      // Outputs
	      .ack			(ack),
	      .wreg_we			(wreg_we),
	      .conv_we			(conv_we),
	      .pool_we			(pool_we),
	      .mem_input_addr		(mem_input_addr[INSIZE-1:0]),
	      .mem_weight_addr		(mem_weight_addr[WSIZE-1:0]),
	      .mem_feat_we		(mem_feat_we),
	      .mem_feat_rst		(mem_feat_rst),
	      .mem_feat_addr		(mem_feat_addr[FACCUM-1:0]),
	      .mem_feat_addr_d1		(mem_feat_addr_d1[FACCUM-1:0]),
	      .mem_output_we		(mem_output_we),
	      .mem_output_addr		(mem_output_addr[OUTSIZE-1:0]),
	      // Inputs
	      .clk			(clk),
	      .xrst			(xrst),
	      .req			(req),
	      .input_addr		(input_addr[INSIZE-1:0]),
	      .weight_addr		(weight_addr[WSIZE-1:0]),
	      .output_addr		(output_addr[OUTSIZE-1:0]),
	      .total_in			(total_in[LWIDTH-1:0]),
	      .total_out		(total_out[LWIDTH-1:0]),
	      .img_w			(img_size[LWIDTH-1:0]),	 // Templated
	      .img_h			(img_size[LWIDTH-1:0]),	 // Templated
	      .fil_w			(fil_size[LWIDTH-1:0]),	 // Templated
	      .fil_h			(fil_size[LWIDTH-1:0]));	 // Templated

    /* core AUTO_TEMPLATE (
        .conv_we          (conv_we),
        .mem_feat_addr    (mem_feat_addr[FACCUM-1:0]),
        .mem_feat_addr_d1 (mem_feat_addr_d1[FACCUM-1:0]),
        .mem_feat_rst     (mem_feat_rst),
        .mem_feat_we      (mem_feat_we),
        .pool_we          (pool_we),
        .read_weight      (read_weight0[DWIDTH-1:0]),
        .wreg_we          (wreg_we),
        .pmap             (pmap0[DWIDTH-1:0]),
    ); */
    core core0(/*AUTOINST*/
	       // Outputs
	       .pmap			(pmap0[DWIDTH-1:0]),	 // Templated
	       // Inputs
	       .clk			(clk),
	       .conv_we			(conv_we),		 // Templated
	       .mem_feat_addr		(mem_feat_addr[FACCUM-1:0]), // Templated
	       .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]), // Templated
	       .mem_feat_rst		(mem_feat_rst),		 // Templated
	       .mem_feat_we		(mem_feat_we),		 // Templated
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
	       .pool_we			(pool_we),		 // Templated
	       .read_weight		(read_weight0[DWIDTH-1:0]), // Templated
	       .wreg_we			(wreg_we),		 // Templated
	       .xrst			(xrst));
    /* core AUTO_TEMPLATE (
        .conv_we          (conv_we),
        .mem_feat_addr    (mem_feat_addr[FACCUM-1:0]),
        .mem_feat_addr_d1 (mem_feat_addr_d1[FACCUM-1:0]),
        .mem_feat_rst     (mem_feat_rst),
        .mem_feat_we      (mem_feat_we),
        .pool_we          (pool_we),
        .read_weight      (read_weight1[DWIDTH-1:0]),
        .wreg_we          (wreg_we),
        .pmap             (pmap1[DWIDTH-1:0]),
    ); */
    core core1(/*AUTOINST*/
	       // Outputs
	       .pmap			(pmap1[DWIDTH-1:0]),	 // Templated
	       // Inputs
	       .clk			(clk),
	       .conv_we			(conv_we),		 // Templated
	       .mem_feat_addr		(mem_feat_addr[FACCUM-1:0]), // Templated
	       .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]), // Templated
	       .mem_feat_rst		(mem_feat_rst),		 // Templated
	       .mem_feat_we		(mem_feat_we),		 // Templated
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
	       .pool_we			(pool_we),		 // Templated
	       .read_weight		(read_weight1[DWIDTH-1:0]), // Templated
	       .wreg_we			(wreg_we),		 // Templated
	       .xrst			(xrst));
    /* core AUTO_TEMPLATE (
        .conv_we          (conv_we),
        .mem_feat_addr    (mem_feat_addr[FACCUM-1:0]),
        .mem_feat_addr_d1 (mem_feat_addr_d1[FACCUM-1:0]),
        .mem_feat_rst     (mem_feat_rst),
        .mem_feat_we      (mem_feat_we),
        .pool_we          (pool_we),
        .read_weight      (read_weight2[DWIDTH-1:0]),
        .wreg_we          (wreg_we),
        .pmap             (pmap2[DWIDTH-1:0]),
    ); */
    core core2(/*AUTOINST*/
	       // Outputs
	       .pmap			(pmap2[DWIDTH-1:0]),	 // Templated
	       // Inputs
	       .clk			(clk),
	       .conv_we			(conv_we),		 // Templated
	       .mem_feat_addr		(mem_feat_addr[FACCUM-1:0]), // Templated
	       .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]), // Templated
	       .mem_feat_rst		(mem_feat_rst),		 // Templated
	       .mem_feat_we		(mem_feat_we),		 // Templated
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
	       .pool_we			(pool_we),		 // Templated
	       .read_weight		(read_weight2[DWIDTH-1:0]), // Templated
	       .wreg_we			(wreg_we),		 // Templated
	       .xrst			(xrst));
    /* core AUTO_TEMPLATE (
        .conv_we          (conv_we),
        .mem_feat_addr    (mem_feat_addr[FACCUM-1:0]),
        .mem_feat_addr_d1 (mem_feat_addr_d1[FACCUM-1:0]),
        .mem_feat_rst     (mem_feat_rst),
        .mem_feat_we      (mem_feat_we),
        .pool_we          (pool_we),
        .read_weight      (read_weight3[DWIDTH-1:0]),
        .wreg_we          (wreg_we),
        .pmap             (pmap3[DWIDTH-1:0]),
    ); */
    core core3(/*AUTOINST*/
	       // Outputs
	       .pmap			(pmap3[DWIDTH-1:0]),	 // Templated
	       // Inputs
	       .clk			(clk),
	       .conv_we			(conv_we),		 // Templated
	       .mem_feat_addr		(mem_feat_addr[FACCUM-1:0]), // Templated
	       .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]), // Templated
	       .mem_feat_rst		(mem_feat_rst),		 // Templated
	       .mem_feat_we		(mem_feat_we),		 // Templated
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
	       .pool_we			(pool_we),		 // Templated
	       .read_weight		(read_weight3[DWIDTH-1:0]), // Templated
	       .wreg_we			(wreg_we),		 // Templated
	       .xrst			(xrst));
    /* core AUTO_TEMPLATE (
        .conv_we          (conv_we),
        .mem_feat_addr    (mem_feat_addr[FACCUM-1:0]),
        .mem_feat_addr_d1 (mem_feat_addr_d1[FACCUM-1:0]),
        .mem_feat_rst     (mem_feat_rst),
        .mem_feat_we      (mem_feat_we),
        .pool_we          (pool_we),
        .read_weight      (read_weight4[DWIDTH-1:0]),
        .wreg_we          (wreg_we),
        .pmap             (pmap4[DWIDTH-1:0]),
    ); */
    core core4(/*AUTOINST*/
	       // Outputs
	       .pmap			(pmap4[DWIDTH-1:0]),	 // Templated
	       // Inputs
	       .clk			(clk),
	       .conv_we			(conv_we),		 // Templated
	       .mem_feat_addr		(mem_feat_addr[FACCUM-1:0]), // Templated
	       .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]), // Templated
	       .mem_feat_rst		(mem_feat_rst),		 // Templated
	       .mem_feat_we		(mem_feat_we),		 // Templated
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
	       .pool_we			(pool_we),		 // Templated
	       .read_weight		(read_weight4[DWIDTH-1:0]), // Templated
	       .wreg_we			(wreg_we),		 // Templated
	       .xrst			(xrst));
    /* core AUTO_TEMPLATE (
        .conv_we          (conv_we),
        .mem_feat_addr    (mem_feat_addr[FACCUM-1:0]),
        .mem_feat_addr_d1 (mem_feat_addr_d1[FACCUM-1:0]),
        .mem_feat_rst     (mem_feat_rst),
        .mem_feat_we      (mem_feat_we),
        .pool_we          (pool_we),
        .read_weight      (read_weight5[DWIDTH-1:0]),
        .wreg_we          (wreg_we),
        .pmap             (pmap5[DWIDTH-1:0]),
    ); */
    core core5(/*AUTOINST*/
	       // Outputs
	       .pmap			(pmap5[DWIDTH-1:0]),	 // Templated
	       // Inputs
	       .clk			(clk),
	       .conv_we			(conv_we),		 // Templated
	       .mem_feat_addr		(mem_feat_addr[FACCUM-1:0]), // Templated
	       .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]), // Templated
	       .mem_feat_rst		(mem_feat_rst),		 // Templated
	       .mem_feat_we		(mem_feat_we),		 // Templated
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
	       .pool_we			(pool_we),		 // Templated
	       .read_weight		(read_weight5[DWIDTH-1:0]), // Templated
	       .wreg_we			(wreg_we),		 // Templated
	       .xrst			(xrst));
    /* core AUTO_TEMPLATE (
        .conv_we          (conv_we),
        .mem_feat_addr    (mem_feat_addr[FACCUM-1:0]),
        .mem_feat_addr_d1 (mem_feat_addr_d1[FACCUM-1:0]),
        .mem_feat_rst     (mem_feat_rst),
        .mem_feat_we      (mem_feat_we),
        .pool_we          (pool_we),
        .read_weight      (read_weight6[DWIDTH-1:0]),
        .wreg_we          (wreg_we),
        .pmap             (pmap6[DWIDTH-1:0]),
    ); */
    core core6(/*AUTOINST*/
	       // Outputs
	       .pmap			(pmap6[DWIDTH-1:0]),	 // Templated
	       // Inputs
	       .clk			(clk),
	       .conv_we			(conv_we),		 // Templated
	       .mem_feat_addr		(mem_feat_addr[FACCUM-1:0]), // Templated
	       .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]), // Templated
	       .mem_feat_rst		(mem_feat_rst),		 // Templated
	       .mem_feat_we		(mem_feat_we),		 // Templated
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
	       .pool_we			(pool_we),		 // Templated
	       .read_weight		(read_weight6[DWIDTH-1:0]), // Templated
	       .wreg_we			(wreg_we),		 // Templated
	       .xrst			(xrst));
    /* core AUTO_TEMPLATE (
        .conv_we          (conv_we),
        .mem_feat_addr    (mem_feat_addr[FACCUM-1:0]),
        .mem_feat_addr_d1 (mem_feat_addr_d1[FACCUM-1:0]),
        .mem_feat_rst     (mem_feat_rst),
        .mem_feat_we      (mem_feat_we),
        .pool_we          (pool_we),
        .read_weight      (read_weight7[DWIDTH-1:0]),
        .wreg_we          (wreg_we),
        .pmap             (pmap7[DWIDTH-1:0]),
    ); */
    core core7(/*AUTOINST*/
	       // Outputs
	       .pmap			(pmap7[DWIDTH-1:0]),	 // Templated
	       // Inputs
	       .clk			(clk),
	       .conv_we			(conv_we),		 // Templated
	       .mem_feat_addr		(mem_feat_addr[FACCUM-1:0]), // Templated
	       .mem_feat_addr_d1	(mem_feat_addr_d1[FACCUM-1:0]), // Templated
	       .mem_feat_rst		(mem_feat_rst),		 // Templated
	       .mem_feat_we		(mem_feat_we),		 // Templated
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
	       .pool_we			(pool_we),		 // Templated
	       .read_weight		(read_weight7[DWIDTH-1:0]), // Templated
	       .wreg_we			(wreg_we),		 // Templated
	       .xrst			(xrst));

    /* sram_output AUTO_TEMPLATE (
        .read_data  (read_output0[DWIDTH-1:0]),
        .write_data (pmap0[DWIDTH-1:0]),
        .mem_we     (mem_output_we),
        .mem_addr   (mem_output_addr[OUTSIZE-1:0]),
    ); */
    sram_output mem_output0(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_output0[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_output_we), // Templated
			    .mem_addr		(mem_output_addr[OUTSIZE-1:0]), // Templated
			    .write_data		(pmap0[DWIDTH-1:0])); // Templated
    /* sram_output AUTO_TEMPLATE (
        .read_data  (read_output1[DWIDTH-1:0]),
        .write_data (pmap1[DWIDTH-1:0]),
        .mem_we     (mem_output_we),
        .mem_addr   (mem_output_addr[OUTSIZE-1:0]),
    ); */
    sram_output mem_output1(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_output1[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_output_we), // Templated
			    .mem_addr		(mem_output_addr[OUTSIZE-1:0]), // Templated
			    .write_data		(pmap1[DWIDTH-1:0])); // Templated
    /* sram_output AUTO_TEMPLATE (
        .read_data  (read_output2[DWIDTH-1:0]),
        .write_data (pmap2[DWIDTH-1:0]),
        .mem_we     (mem_output_we),
        .mem_addr   (mem_output_addr[OUTSIZE-1:0]),
    ); */
    sram_output mem_output2(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_output2[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_output_we), // Templated
			    .mem_addr		(mem_output_addr[OUTSIZE-1:0]), // Templated
			    .write_data		(pmap2[DWIDTH-1:0])); // Templated
    /* sram_output AUTO_TEMPLATE (
        .read_data  (read_output3[DWIDTH-1:0]),
        .write_data (pmap3[DWIDTH-1:0]),
        .mem_we     (mem_output_we),
        .mem_addr   (mem_output_addr[OUTSIZE-1:0]),
    ); */
    sram_output mem_output3(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_output3[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_output_we), // Templated
			    .mem_addr		(mem_output_addr[OUTSIZE-1:0]), // Templated
			    .write_data		(pmap3[DWIDTH-1:0])); // Templated
    /* sram_output AUTO_TEMPLATE (
        .read_data  (read_output4[DWIDTH-1:0]),
        .write_data (pmap4[DWIDTH-1:0]),
        .mem_we     (mem_output_we),
        .mem_addr   (mem_output_addr[OUTSIZE-1:0]),
    ); */
    sram_output mem_output4(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_output4[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_output_we), // Templated
			    .mem_addr		(mem_output_addr[OUTSIZE-1:0]), // Templated
			    .write_data		(pmap4[DWIDTH-1:0])); // Templated
    /* sram_output AUTO_TEMPLATE (
        .read_data  (read_output5[DWIDTH-1:0]),
        .write_data (pmap5[DWIDTH-1:0]),
        .mem_we     (mem_output_we),
        .mem_addr   (mem_output_addr[OUTSIZE-1:0]),
    ); */
    sram_output mem_output5(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_output5[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_output_we), // Templated
			    .mem_addr		(mem_output_addr[OUTSIZE-1:0]), // Templated
			    .write_data		(pmap5[DWIDTH-1:0])); // Templated
    /* sram_output AUTO_TEMPLATE (
        .read_data  (read_output6[DWIDTH-1:0]),
        .write_data (pmap6[DWIDTH-1:0]),
        .mem_we     (mem_output_we),
        .mem_addr   (mem_output_addr[OUTSIZE-1:0]),
    ); */
    sram_output mem_output6(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_output6[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_output_we), // Templated
			    .mem_addr		(mem_output_addr[OUTSIZE-1:0]), // Templated
			    .write_data		(pmap6[DWIDTH-1:0])); // Templated
    /* sram_output AUTO_TEMPLATE (
        .read_data  (read_output7[DWIDTH-1:0]),
        .write_data (pmap7[DWIDTH-1:0]),
        .mem_we     (mem_output_we),
        .mem_addr   (mem_output_addr[OUTSIZE-1:0]),
    ); */
    sram_output mem_output7(/*AUTOINST*/
			    // Outputs
			    .read_data		(read_output7[DWIDTH-1:0]), // Templated
			    // Inputs
			    .clk		(clk),
			    .mem_we		(mem_output_we), // Templated
			    .mem_addr		(mem_output_addr[OUTSIZE-1:0]), // Templated
			    .write_data		(pmap7[DWIDTH-1:0])); // Templated

    mux_output select_out(/*AUTOINST*/
			  // Outputs
			  .read_output		(read_output[DWIDTH-1:0]),
			  // Inputs
			  .clk			(clk),
			  .output_re		(output_re[3:0]),
			  .read_output0		(read_output0[DWIDTH-1:0]),
			  .read_output1		(read_output1[DWIDTH-1:0]),
			  .read_output2		(read_output2[DWIDTH-1:0]),
			  .read_output3		(read_output3[DWIDTH-1:0]),
			  .read_output4		(read_output4[DWIDTH-1:0]),
			  .read_output5		(read_output5[DWIDTH-1:0]),
			  .read_output6		(read_output6[DWIDTH-1:0]),
			  .read_output7		(read_output7[DWIDTH-1:0]));
endmodule
