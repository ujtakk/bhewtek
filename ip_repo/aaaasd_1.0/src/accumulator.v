module accumulator(/*AUTOARG*/
   // Outputs
   total, sum_wb,
   // Inputs
   clk, reset, o_we, result, sum_old
   );
`include "parameters.vh"

    /*AUTOINPUT*/
    input clk;
    input reset;
    input o_we;
    input signed [DWIDTH-1:0] result;
    input signed [DWIDTH-1:0] sum_old;

    /*AUTOOUTPUT*/
    output signed [DWIDTH-1:0] total;
    output signed [DWIDTH-1:0] sum_wb;

    /*AUTOWIRE*/
    wire signed [DWIDTH-1:0] sum;

    /*AUTOREG*/
    // Beginning of automatic regs (for this module's undeclared outputs)
    reg signed [DWIDTH-1:0] total;
    // End of automatics

    assign sum = reset
                    ? result
                    : result + sum_old;

    assign sum_wb = sum;

    always @(posedge clk)
        if(o_we)
            total <= sum;
        else
            total <= total;

endmodule
