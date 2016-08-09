module linebuf_pix(/*AUTOARG*/
   // Outputs
   pixel0, pixel1, pixel2, pixel3, pixel4, pixel5, pixel6, pixel7,
   pixel8, pixel9, pixel10, pixel11, pixel12, pixel13, pixel14,
   pixel15, pixel16, pixel17, pixel18, pixel19, pixel20, pixel21,
   pixel22, pixel23, pixel24,
   // Inputs
   clk, read_data
   );
`include "parameters.vh"

    /*AUTOINPUT*/
    input clk;
    input [DWIDTH-1:0] read_data;

    /*AUTOOUTPUT*/
    output [DWIDTH-1:0] pixel0;
    output [DWIDTH-1:0] pixel1;
    output [DWIDTH-1:0] pixel2;
    output [DWIDTH-1:0] pixel3;
    output [DWIDTH-1:0] pixel4;
    output [DWIDTH-1:0] pixel5;
    output [DWIDTH-1:0] pixel6;
    output [DWIDTH-1:0] pixel7;
    output [DWIDTH-1:0] pixel8;
    output [DWIDTH-1:0] pixel9;
    output [DWIDTH-1:0] pixel10;
    output [DWIDTH-1:0] pixel11;
    output [DWIDTH-1:0] pixel12;
    output [DWIDTH-1:0] pixel13;
    output [DWIDTH-1:0] pixel14;
    output [DWIDTH-1:0] pixel15;
    output [DWIDTH-1:0] pixel16;
    output [DWIDTH-1:0] pixel17;
    output [DWIDTH-1:0] pixel18;
    output [DWIDTH-1:0] pixel19;
    output [DWIDTH-1:0] pixel20;
    output [DWIDTH-1:0] pixel21;
    output [DWIDTH-1:0] pixel22;
    output [DWIDTH-1:0] pixel23;
    output [DWIDTH-1:0] pixel24;

    /*AUTOWIRE*/

    /*AUTOREG*/

    reg [DWIDTH-1:0]    r_pix0_0;
    reg [DWIDTH-1:0]    r_pix0_1;
    reg [DWIDTH-1:0]    r_pix0_2;
    reg [DWIDTH-1:0]    r_pix0_3;
    reg [DWIDTH-1:0]    r_pix0_4;
    reg [DWIDTH-1:0]    r_pix0_5;
    reg [DWIDTH-1:0]    r_pix0_6;
    reg [DWIDTH-1:0]    r_pix0_7;
    reg [DWIDTH-1:0]    r_pix0_8;
    reg [DWIDTH-1:0]    r_pix0_9;
    reg [DWIDTH-1:0]    r_pix0_10;
    reg [DWIDTH-1:0]    r_pix0_11;
    reg [DWIDTH-1:0]    r_pix1_0;
    reg [DWIDTH-1:0]    r_pix1_1;
    reg [DWIDTH-1:0]    r_pix1_2;
    reg [DWIDTH-1:0]    r_pix1_3;
    reg [DWIDTH-1:0]    r_pix1_4;
    reg [DWIDTH-1:0]    r_pix1_5;
    reg [DWIDTH-1:0]    r_pix1_6;
    reg [DWIDTH-1:0]    r_pix1_7;
    reg [DWIDTH-1:0]    r_pix1_8;
    reg [DWIDTH-1:0]    r_pix1_9;
    reg [DWIDTH-1:0]    r_pix1_10;
    reg [DWIDTH-1:0]    r_pix1_11;
    reg [DWIDTH-1:0]    r_pix2_0;
    reg [DWIDTH-1:0]    r_pix2_1;
    reg [DWIDTH-1:0]    r_pix2_2;
    reg [DWIDTH-1:0]    r_pix2_3;
    reg [DWIDTH-1:0]    r_pix2_4;
    reg [DWIDTH-1:0]    r_pix2_5;
    reg [DWIDTH-1:0]    r_pix2_6;
    reg [DWIDTH-1:0]    r_pix2_7;
    reg [DWIDTH-1:0]    r_pix2_8;
    reg [DWIDTH-1:0]    r_pix2_9;
    reg [DWIDTH-1:0]    r_pix2_10;
    reg [DWIDTH-1:0]    r_pix2_11;
    reg [DWIDTH-1:0]    r_pix3_0;
    reg [DWIDTH-1:0]    r_pix3_1;
    reg [DWIDTH-1:0]    r_pix3_2;
    reg [DWIDTH-1:0]    r_pix3_3;
    reg [DWIDTH-1:0]    r_pix3_4;
    reg [DWIDTH-1:0]    r_pix3_5;
    reg [DWIDTH-1:0]    r_pix3_6;
    reg [DWIDTH-1:0]    r_pix3_7;
    reg [DWIDTH-1:0]    r_pix3_8;
    reg [DWIDTH-1:0]    r_pix3_9;
    reg [DWIDTH-1:0]    r_pix3_10;
    reg [DWIDTH-1:0]    r_pix3_11;
    reg [DWIDTH-1:0]    r_pix4_0;
    reg [DWIDTH-1:0]    r_pix4_1;
    reg [DWIDTH-1:0]    r_pix4_2;
    reg [DWIDTH-1:0]    r_pix4_3;
    reg [DWIDTH-1:0]    r_pix4_4;

    assign pixel0 = r_pix0_0;
    assign pixel1 = r_pix0_1;
    assign pixel2 = r_pix0_2;
    assign pixel3 = r_pix0_3;
    assign pixel4 = r_pix0_4;
    assign pixel5 = r_pix1_0;
    assign pixel6 = r_pix1_1;
    assign pixel7 = r_pix1_2;
    assign pixel8 = r_pix1_3;
    assign pixel9 = r_pix1_4;
    assign pixel10 = r_pix2_0;
    assign pixel11 = r_pix2_1;
    assign pixel12 = r_pix2_2;
    assign pixel13 = r_pix2_3;
    assign pixel14 = r_pix2_4;
    assign pixel15 = r_pix3_0;
    assign pixel16 = r_pix3_1;
    assign pixel17 = r_pix3_2;
    assign pixel18 = r_pix3_3;
    assign pixel19 = r_pix3_4;
    assign pixel20 = r_pix4_0;
    assign pixel21 = r_pix4_1;
    assign pixel22 = r_pix4_2;
    assign pixel23 = r_pix4_3;
    assign pixel24 = r_pix4_4;

    always @(posedge clk)
        r_pix0_0 <= r_pix0_1;
    always @(posedge clk)
        r_pix0_1 <= r_pix0_2;
    always @(posedge clk)
        r_pix0_2 <= r_pix0_3;
    always @(posedge clk)
        r_pix0_3 <= r_pix0_4;
    always @(posedge clk)
        r_pix0_4 <= r_pix0_5;
    always @(posedge clk)
        r_pix0_5 <= r_pix0_6;
    always @(posedge clk)
        r_pix0_6 <= r_pix0_7;
    always @(posedge clk)
        r_pix0_7 <= r_pix0_8;
    always @(posedge clk)
        r_pix0_8 <= r_pix0_9;
    always @(posedge clk)
        r_pix0_9 <= r_pix0_10;
    always @(posedge clk)
        r_pix0_10 <= r_pix0_11;
    always @(posedge clk)
        r_pix0_11 <= r_pix1_0;
    always @(posedge clk)
        r_pix1_0 <= r_pix1_1;
    always @(posedge clk)
        r_pix1_1 <= r_pix1_2;
    always @(posedge clk)
        r_pix1_2 <= r_pix1_3;
    always @(posedge clk)
        r_pix1_3 <= r_pix1_4;
    always @(posedge clk)
        r_pix1_4 <= r_pix1_5;
    always @(posedge clk)
        r_pix1_5 <= r_pix1_6;
    always @(posedge clk)
        r_pix1_6 <= r_pix1_7;
    always @(posedge clk)
        r_pix1_7 <= r_pix1_8;
    always @(posedge clk)
        r_pix1_8 <= r_pix1_9;
    always @(posedge clk)
        r_pix1_9 <= r_pix1_10;
    always @(posedge clk)
        r_pix1_10 <= r_pix1_11;
    always @(posedge clk)
        r_pix1_11 <= r_pix2_0;
    always @(posedge clk)
        r_pix2_0 <= r_pix2_1;
    always @(posedge clk)
        r_pix2_1 <= r_pix2_2;
    always @(posedge clk)
        r_pix2_2 <= r_pix2_3;
    always @(posedge clk)
        r_pix2_3 <= r_pix2_4;
    always @(posedge clk)
        r_pix2_4 <= r_pix2_5;
    always @(posedge clk)
        r_pix2_5 <= r_pix2_6;
    always @(posedge clk)
        r_pix2_6 <= r_pix2_7;
    always @(posedge clk)
        r_pix2_7 <= r_pix2_8;
    always @(posedge clk)
        r_pix2_8 <= r_pix2_9;
    always @(posedge clk)
        r_pix2_9 <= r_pix2_10;
    always @(posedge clk)
        r_pix2_10 <= r_pix2_11;
    always @(posedge clk)
        r_pix2_11 <= r_pix3_0;
    always @(posedge clk)
        r_pix3_0 <= r_pix3_1;
    always @(posedge clk)
        r_pix3_1 <= r_pix3_2;
    always @(posedge clk)
        r_pix3_2 <= r_pix3_3;
    always @(posedge clk)
        r_pix3_3 <= r_pix3_4;
    always @(posedge clk)
        r_pix3_4 <= r_pix3_5;
    always @(posedge clk)
        r_pix3_5 <= r_pix3_6;
    always @(posedge clk)
        r_pix3_6 <= r_pix3_7;
    always @(posedge clk)
        r_pix3_7 <= r_pix3_8;
    always @(posedge clk)
        r_pix3_8 <= r_pix3_9;
    always @(posedge clk)
        r_pix3_9 <= r_pix3_10;
    always @(posedge clk)
        r_pix3_10 <= r_pix3_11;
    always @(posedge clk)
        r_pix3_11 <= r_pix4_0;
    always @(posedge clk)
        r_pix4_0 <= r_pix4_1;
    always @(posedge clk)
        r_pix4_1 <= r_pix4_2;
    always @(posedge clk)
        r_pix4_2 <= r_pix4_3;
    always @(posedge clk)
        r_pix4_3 <= r_pix4_4;
    always @(posedge clk)
        r_pix4_4 <= read_data;

endmodule
