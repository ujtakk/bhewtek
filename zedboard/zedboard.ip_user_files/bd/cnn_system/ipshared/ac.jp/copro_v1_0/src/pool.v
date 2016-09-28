module pool(/*AUTOARG*/
   // Outputs
   pmap,
   // Inputs
   clk, xrst, o_we, pixel_feat0, pixel_feat1, pixel_feat2,
   pixel_feat3
   );
`include "parameters.vh"

  /*AUTOINPUT*/
  input clk;
  input xrst;
  input o_we;
  input signed [DWIDTH-1:0] pixel_feat0;
  input signed [DWIDTH-1:0] pixel_feat1;
  input signed [DWIDTH-1:0] pixel_feat2;
  input signed [DWIDTH-1:0] pixel_feat3;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] pmap;

  /*AUTOWIRE*/
  wire signed [DWIDTH-1:0] max_0;
  wire signed [DWIDTH-1:0] max_1;
  wire signed [DWIDTH-1:0] max;

  /*AUTOREG*/
  reg signed [DWIDTH-1:0] r_max;
  reg signed [DWIDTH-1:0] r_pixel_feat0;
  reg signed [DWIDTH-1:0] r_pixel_feat1;
  reg signed [DWIDTH-1:0] r_pixel_feat2;
  reg signed [DWIDTH-1:0] r_pixel_feat3;

  assign max_0  = (r_pixel_feat0 > r_pixel_feat1)
                ? r_pixel_feat0
                : r_pixel_feat1;

  assign max_1  = (r_pixel_feat2 > r_pixel_feat3)
                ? r_pixel_feat2
                : r_pixel_feat3;

  assign max  = (max_0 > max_1)
              ? max_0
              : max_1;

  assign pmap = r_max;

  always @(posedge clk)
    if (!xrst)
      r_max <= 0;
    else if (o_we)
      r_max <= max;

  always @(posedge clk)
    if (!xrst)
      r_pixel_feat0 <= 0;
    else
      r_pixel_feat0 <= pixel_feat0;
  always @(posedge clk)
    if (!xrst)
      r_pixel_feat1 <= 0;
    else
      r_pixel_feat1 <= pixel_feat1;
  always @(posedge clk)
    if (!xrst)
      r_pixel_feat2 <= 0;
    else
      r_pixel_feat2 <= pixel_feat2;
  always @(posedge clk)
    if (!xrst)
      r_pixel_feat3 <= 0;
    else
      r_pixel_feat3 <= pixel_feat3;
endmodule
