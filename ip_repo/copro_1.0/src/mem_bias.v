module mem_bias(/*AUTOARG*/
   // Outputs
   read_data,
   // Inputs
   clk, mem_we, mem_addr, write_data
   );
`include "parameters.vh"
  parameter WORDS = 2 ** BSIZE;

  /*AUTOINPUT*/
  input                     clk;
  input                     mem_we;
  input [BSIZE-1:0]         mem_addr;
  input signed [DWIDTH-1:0] write_data;

  /*AUTOOUTPUT*/
  output signed [DWIDTH-1:0] read_data;

  /*AUTOWIRE*/

  /*AUTOREG*/

  reg signed [DWIDTH-1:0] mem [WORDS-1:0];
  reg [DWIDTH-1:0]        addr_reg;

  always @(posedge clk)
  begin
    if(mem_we)
      mem[mem_addr] <= write_data;
    addr_reg <= mem_addr;
  end

  assign read_data = mem[addr_reg];

endmodule
