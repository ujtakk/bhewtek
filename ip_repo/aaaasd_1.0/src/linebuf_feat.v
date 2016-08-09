module linebuf_feat(/*AUTOARG*/
   // Outputs
   pixel_feat0, pixel_feat1, pixel_feat2, pixel_feat3,
   // Inputs
   clk, read_data
   );
`include "parameters.vh"

    /*AUTOINPUT*/
    input clk;
    input signed [DWIDTH-1:0] read_data;

    /*AUTOOUTPUT*/
    output signed [DWIDTH-1:0] pixel_feat0;
    output signed [DWIDTH-1:0] pixel_feat1;
    output signed [DWIDTH-1:0] pixel_feat2;
    output signed [DWIDTH-1:0] pixel_feat3;

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

    assign pixel_feat0 = r_pix0_0;
    assign pixel_feat1 = r_pix0_1;
    assign pixel_feat2 = r_pix1_0;
    assign pixel_feat3 = r_pix1_1;

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
        r_pix1_1 <= read_data;

endmodule
