module conv(/*AUTOARG*/
   // Outputs
   fmap,
   // Inputs
   xrst, wreg_we, read_data, pixel9, pixel8, pixel7, pixel6, pixel5,
   pixel4, pixel3, pixel24, pixel23, pixel22, pixel21, pixel20,
   pixel2, pixel19, pixel18, pixel17, pixel16, pixel15, pixel14,
   pixel13, pixel12, pixel11, pixel10, pixel1, pixel0, clk
   );
    `include "parameters.vh"

    /*AUTOINPUT*/
    // Beginning of automatic inputs (from unused autoinst inputs)
    input		clk;			// To tree of conv_tree.v, ...
    input signed [DWIDTH-1:0] pixel0;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel1;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel10;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel11;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel12;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel13;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel14;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel15;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel16;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel17;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel18;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel19;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel2;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel20;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel21;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel22;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel23;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel24;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel3;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel4;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel5;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel6;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel7;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel8;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] pixel9;		// To tree of conv_tree.v
    input signed [DWIDTH-1:0] read_data;	// To wreg of conv_wreg.v
    input		wreg_we;		// To wreg of conv_wreg.v
    input		xrst;			// To tree of conv_tree.v
    // End of automatics

    /*AUTOOUTPUT*/
    // Beginning of automatic outputs (from unused autoinst outputs)
    output signed [DWIDTH-1:0] fmap;		// From tree of conv_tree.v
    // End of automatics

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire signed [DWIDTH-1:0] weight0;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight1;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight10;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight11;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight12;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight13;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight14;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight15;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight16;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight17;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight18;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight19;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight2;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight20;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight21;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight22;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight23;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight24;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight3;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight4;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight5;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight6;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight7;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight8;		// From wreg of conv_wreg.v
    wire signed [DWIDTH-1:0] weight9;		// From wreg of conv_wreg.v
    // End of automatics

    /*AUTOREG*/

    conv_tree tree(/*AUTOINST*/
		   // Outputs
		   .fmap		(fmap[DWIDTH-1:0]),
		   // Inputs
		   .clk			(clk),
		   .xrst		(xrst),
		   .pixel0		(pixel0[DWIDTH-1:0]),
		   .weight0		(weight0[DWIDTH-1:0]),
		   .pixel1		(pixel1[DWIDTH-1:0]),
		   .weight1		(weight1[DWIDTH-1:0]),
		   .pixel2		(pixel2[DWIDTH-1:0]),
		   .weight2		(weight2[DWIDTH-1:0]),
		   .pixel3		(pixel3[DWIDTH-1:0]),
		   .weight3		(weight3[DWIDTH-1:0]),
		   .pixel4		(pixel4[DWIDTH-1:0]),
		   .weight4		(weight4[DWIDTH-1:0]),
		   .pixel5		(pixel5[DWIDTH-1:0]),
		   .weight5		(weight5[DWIDTH-1:0]),
		   .pixel6		(pixel6[DWIDTH-1:0]),
		   .weight6		(weight6[DWIDTH-1:0]),
		   .pixel7		(pixel7[DWIDTH-1:0]),
		   .weight7		(weight7[DWIDTH-1:0]),
		   .pixel8		(pixel8[DWIDTH-1:0]),
		   .weight8		(weight8[DWIDTH-1:0]),
		   .pixel9		(pixel9[DWIDTH-1:0]),
		   .weight9		(weight9[DWIDTH-1:0]),
		   .pixel10		(pixel10[DWIDTH-1:0]),
		   .weight10		(weight10[DWIDTH-1:0]),
		   .pixel11		(pixel11[DWIDTH-1:0]),
		   .weight11		(weight11[DWIDTH-1:0]),
		   .pixel12		(pixel12[DWIDTH-1:0]),
		   .weight12		(weight12[DWIDTH-1:0]),
		   .pixel13		(pixel13[DWIDTH-1:0]),
		   .weight13		(weight13[DWIDTH-1:0]),
		   .pixel14		(pixel14[DWIDTH-1:0]),
		   .weight14		(weight14[DWIDTH-1:0]),
		   .pixel15		(pixel15[DWIDTH-1:0]),
		   .weight15		(weight15[DWIDTH-1:0]),
		   .pixel16		(pixel16[DWIDTH-1:0]),
		   .weight16		(weight16[DWIDTH-1:0]),
		   .pixel17		(pixel17[DWIDTH-1:0]),
		   .weight17		(weight17[DWIDTH-1:0]),
		   .pixel18		(pixel18[DWIDTH-1:0]),
		   .weight18		(weight18[DWIDTH-1:0]),
		   .pixel19		(pixel19[DWIDTH-1:0]),
		   .weight19		(weight19[DWIDTH-1:0]),
		   .pixel20		(pixel20[DWIDTH-1:0]),
		   .weight20		(weight20[DWIDTH-1:0]),
		   .pixel21		(pixel21[DWIDTH-1:0]),
		   .weight21		(weight21[DWIDTH-1:0]),
		   .pixel22		(pixel22[DWIDTH-1:0]),
		   .weight22		(weight22[DWIDTH-1:0]),
		   .pixel23		(pixel23[DWIDTH-1:0]),
		   .weight23		(weight23[DWIDTH-1:0]),
		   .pixel24		(pixel24[DWIDTH-1:0]),
		   .weight24		(weight24[DWIDTH-1:0]));

    conv_wreg wreg(/*AUTOINST*/
		   // Outputs
		   .weight0		(weight0[DWIDTH-1:0]),
		   .weight1		(weight1[DWIDTH-1:0]),
		   .weight2		(weight2[DWIDTH-1:0]),
		   .weight3		(weight3[DWIDTH-1:0]),
		   .weight4		(weight4[DWIDTH-1:0]),
		   .weight5		(weight5[DWIDTH-1:0]),
		   .weight6		(weight6[DWIDTH-1:0]),
		   .weight7		(weight7[DWIDTH-1:0]),
		   .weight8		(weight8[DWIDTH-1:0]),
		   .weight9		(weight9[DWIDTH-1:0]),
		   .weight10		(weight10[DWIDTH-1:0]),
		   .weight11		(weight11[DWIDTH-1:0]),
		   .weight12		(weight12[DWIDTH-1:0]),
		   .weight13		(weight13[DWIDTH-1:0]),
		   .weight14		(weight14[DWIDTH-1:0]),
		   .weight15		(weight15[DWIDTH-1:0]),
		   .weight16		(weight16[DWIDTH-1:0]),
		   .weight17		(weight17[DWIDTH-1:0]),
		   .weight18		(weight18[DWIDTH-1:0]),
		   .weight19		(weight19[DWIDTH-1:0]),
		   .weight20		(weight20[DWIDTH-1:0]),
		   .weight21		(weight21[DWIDTH-1:0]),
		   .weight22		(weight22[DWIDTH-1:0]),
		   .weight23		(weight23[DWIDTH-1:0]),
		   .weight24		(weight24[DWIDTH-1:0]),
		   // Inputs
		   .read_data		(read_data[DWIDTH-1:0]),
		   .wreg_we		(wreg_we),
		   .clk			(clk));

endmodule
