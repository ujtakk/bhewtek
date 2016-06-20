
`timescale 1 ns / 1 ps

	module myip_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S_AXI
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_ADDR_WIDTH	= 5
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S_AXI
		input wire  s_axi_aclk,
		input wire  s_axi_aresetn,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_axi_awaddr,
		input wire [2 : 0] s_axi_awprot,
		input wire  s_axi_awvalid,
		output wire  s_axi_awready,
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] s_axi_wdata,
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] s_axi_wstrb,
		input wire  s_axi_wvalid,
		output wire  s_axi_wready,
		output wire [1 : 0] s_axi_bresp,
		output wire  s_axi_bvalid,
		input wire  s_axi_bready,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_axi_araddr,
		input wire [2 : 0] s_axi_arprot,
		input wire  s_axi_arvalid,
		output wire  s_axi_arready,
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] s_axi_rdata,
		output wire [1 : 0] s_axi_rresp,
		output wire  s_axi_rvalid,
		input wire  s_axi_rready
	);
// Instantiation of Axi Bus Interface S_AXI
	wire [C_S_AXI_DATA_WIDTH-1:0]	port0;
	wire [C_S_AXI_DATA_WIDTH-1:0]	port1;
	wire [C_S_AXI_DATA_WIDTH-1:0]	port2;
	wire [C_S_AXI_DATA_WIDTH-1:0]	port3;
	wire [C_S_AXI_DATA_WIDTH-1:0]	port4;
	wire [C_S_AXI_DATA_WIDTH-1:0]	port5;
	wire [C_S_AXI_DATA_WIDTH-1:0]	port6;
	wire [C_S_AXI_DATA_WIDTH-1:0]	port7;

	myip_v1_0_S_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
	) myip_v1_0_S_AXI_inst (
	  .port0(port0),
	  .port1(port1),
	  .port2(port2),
	  .port3(port3),
	  .port4(port4),
	  .port5(port5),
	  .port6(port6),
	  .port7(port7),
		.S_AXI_ACLK(s_axi_aclk),
		.S_AXI_ARESETN(s_axi_aresetn),
		.S_AXI_AWADDR(s_axi_awaddr),
		.S_AXI_AWPROT(s_axi_awprot),
		.S_AXI_AWVALID(s_axi_awvalid),
		.S_AXI_AWREADY(s_axi_awready),
		.S_AXI_WDATA(s_axi_wdata),
		.S_AXI_WSTRB(s_axi_wstrb),
		.S_AXI_WVALID(s_axi_wvalid),
		.S_AXI_WREADY(s_axi_wready),
		.S_AXI_BRESP(s_axi_bresp),
		.S_AXI_BVALID(s_axi_bvalid),
		.S_AXI_BREADY(s_axi_bready),
		.S_AXI_ARADDR(s_axi_araddr),
		.S_AXI_ARPROT(s_axi_arprot),
		.S_AXI_ARVALID(s_axi_arvalid),
		.S_AXI_ARREADY(s_axi_arready),
		.S_AXI_RDATA(s_axi_rdata),
		.S_AXI_RRESP(s_axi_rresp),
		.S_AXI_RVALID(s_axi_rvalid),
		.S_AXI_RREADY(s_axi_rready)
	);

	// Add user logic here

`include "parameters.vh"

  wire               clk;
  wire               xrst;
  wire               req;
  wire               input_we;
  wire [3:0]         weight_we;
  wire [3:0]         output_re;
  wire [LWIDTH-1:0]  total_out;
  wire [LWIDTH-1:0]  total_in;
  wire [LWIDTH-1:0]  img_size;
  wire [LWIDTH-1:0]  fil_size;
  wire [INSIZE-1:0]  input_addr;
  wire [DWIDTH-1:0]  write_input;
  wire [WSIZE-1:0]   weight_addr;
  wire [DWIDTH-1:0]  write_weight;
  wire [OUTSIZE-1:0] output_addr;

  wire [DWIDTH-1:0]  read_output;
  wire               ack;

  /*
   * TODO:
   *  Should I make sending burst for input, weight, output?
   * // INPUT
   * clk;
   * xrst;
   * port[0]                req;
   * port[1]                input_we;
   * port[1]  [3:0]         weight_we;
   * port[1]  [3:0]         output_re;
   * port[2]  [LWIDTH-1:0]  total_out;
   * port[2]  [LWIDTH-1:0]  total_in;
   * port[2]  [LWIDTH-1:0]  img_size;
   * port[2]  [LWIDTH-1:0]  fil_size;
   * port[3]  [INSIZE-1:0]  input_addr;
   * port[3]  [DWIDTH-1:0]  write_input;
   * port[4]  [WSIZE-1:0]   weight_addr;
   * port[4]  [DWIDTH-1:0]  write_weight;
   * port[5]  [OUTSIZE-1:0] output_addr;
   *
   * // OUTPUT
   * port[6]  [DWIDTH-1:0]  read_output;
   * port[7]                ack;
   */

  assign clk          = s_axi_aclk;
  assign xrst         = s_axi_aresetn;
  assign req          = port0[0];
  assign output_re    = port1[8:5];
  assign weight_we    = port1[4:1];
  assign input_we     = port1[0];
  assign total_out    = port2[31:24];
  assign total_in     = port2[23:16];
  assign img_size     = port2[15:8];
  assign fil_size     = port2[7:0];
  assign input_addr   = port3[27:16];
  assign write_input  = port3[15:0];
  assign weight_addr  = port4[28:16];
  assign write_weight = port4[15:0];
  assign output_addr  = port5[9:0];

  assign port6 = {16'b0 , read_output};
  assign port7 = {31'b0, ack};

  top top0(/*AUTOINST*/
    // Outputs
    .ack			(ack),
    .read_output		(read_output[DWIDTH-1:0]),
    // Inputs
    .clk			(clk),
    .fil_size			(fil_size[LWIDTH-1:0]),
    .img_size			(img_size[LWIDTH-1:0]),
    .input_addr		(input_addr[INSIZE-1:0]),
    .input_we			(input_we),
    .output_addr		(output_addr[OUTSIZE-1:0]),
    .output_re			(output_re[3:0]),
    .req			(req),
    .total_in			(total_in[LWIDTH-1:0]),
    .total_out			(total_out[LWIDTH-1:0]),
    .weight_addr		(weight_addr[WSIZE-1:0]),
    .weight_we			(weight_we[3:0]),
    .write_input		(write_input[DWIDTH-1:0]),
    .write_weight		(write_weight[DWIDTH-1:0]),
    .xrst			(xrst)
  );

	// User logic ends

	endmodule
