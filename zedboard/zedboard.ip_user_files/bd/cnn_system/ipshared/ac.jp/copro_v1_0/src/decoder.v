
module decoder(/*AUTOARG*/
   // Outputs
   out_code,
   // Inputs
   clk, xrst, in_code
   );
`include "parameters.vh"

  /*AUTOINPUT*/
  input clk;
  input xrst;
  input [CORELOG:0] in_code;

  /*AUTOOUTPUT*/
  output [CORE-1:0] out_code;

  /*AUTOWIRE*/

  /*AUTOREG*/
  reg [CORE-1:0] r_code;

  assign out_code = r_code;

  always @(posedge clk)
    if (!xrst)
      r_code <= 0;
    else
      case (in_code)
        4'd0:    r_code <= 8'b00000000;
        4'd1:    r_code <= 8'b00000001;
        4'd2:    r_code <= 8'b00000010;
        4'd3:    r_code <= 8'b00000100;
        4'd4:    r_code <= 8'b00001000;
        4'd5:    r_code <= 8'b00010000;
        4'd6:    r_code <= 8'b00100000;
        4'd7:    r_code <= 8'b01000000;
        4'd8:    r_code <= 8'b10000000;
        default: r_code <= 8'b00000000;
      endcase

endmodule
