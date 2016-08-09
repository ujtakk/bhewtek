module pool(/*AUTOARG*/
   // Outputs
   pmap,
   // Inputs
   clk, o_we, pixel_feat0, pixel_feat1, pixel_feat2, pixel_feat3
   );
`include "parameters.vh"

    /*AUTOINPUT*/
    input clk;
    input o_we;
    input signed [DWIDTH-1:0] pixel_feat0;
    input signed [DWIDTH-1:0] pixel_feat1;
    input signed [DWIDTH-1:0] pixel_feat2;
    input signed [DWIDTH-1:0] pixel_feat3;

    /*AUTOOUTPUT*/
    output signed [DWIDTH-1:0] pmap;

    /*AUTOWIRE*/
    wire signed [DWIDTH-1:0] max_1;
    wire signed [DWIDTH-1:0] max_2;
    wire signed [DWIDTH-1:0] max;

    /*AUTOREG*/
    reg signed [DWIDTH-1:0] r_max;

    assign max_1 = (pixel_feat0 >= pixel_feat1) ? pixel_feat0 : pixel_feat1;
    assign max_2 = (pixel_feat2 >= pixel_feat3) ? pixel_feat2 : pixel_feat3;
    assign max = (max_1 >= max_2) ? max_1 : max_2;

    assign pmap = r_max;

    always @(posedge clk)
        if(o_we) r_max <= max;

endmodule
