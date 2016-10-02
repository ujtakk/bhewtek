// TODO: parameterize r_code

module decoder(/*AUTOARG*/
   // Outputs
   out_code,
   // Inputs
   clk, xrst, in_code
   );
  /*AUTOINPUT*/
  input clk;
  input xrst;
  input [3:0] in_code;

  /*AUTOOUTPUT*/
  output [7:0] out_code;

  /*AUTOWIRE*/

  /*AUTOREG*/
  reg [7:0] r_code;

  assign out_code = r_code;

  always @(posedge clk)
    if (!xrst)
      r_code <= 0;
    else
      case (in_code)
        4'd0:    r_code <= 8'b0000_0000;
        4'd1:    r_code <= 8'b0000_0001;
        4'd2:    r_code <= 8'b0000_0010;
        4'd3:    r_code <= 8'b0000_0100;
        4'd4:    r_code <= 8'b0000_1000;
        4'd5:    r_code <= 8'b0001_0000;
        4'd6:    r_code <= 8'b0010_0000;
        4'd7:    r_code <= 8'b0100_0000;
        4'd8:    r_code <= 8'b1000_0000;
        default: r_code <= 8'b0000_0000;
      endcase

endmodule
