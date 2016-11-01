module accumulator(/*AUTOARG*/
   // Outputs
   total, sum_new,
   // Inputs
   clk, xrst, reset, out_en, result, sum_old
   );
`include "parameters.vh"

  /*AUTOINPUT*/
  input clk;
  input xrst;
  input reset;
  input out_en;
  input signed [DWIDTH-1:0] result;
  input signed [DWIDTH-1:0] sum_old;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] total;
  output signed [DWIDTH-1:0] sum_new;

  /*AUTOWIRE*/
  wire signed [DWIDTH-1:0] sum;

  /*AUTOREG*/
  reg signed [DWIDTH-1:0] r_total;

  assign total   = r_total;
  assign sum_new = sum;

  assign sum = reset
             ? result
             : result + sum_old;

  always @(posedge clk)
    if (!xrst)
      r_total <= 0;
    else if(out_en)
      r_total <= sum;

endmodule
