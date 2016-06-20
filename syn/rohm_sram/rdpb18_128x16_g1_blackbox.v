`timescale 1ns/10ps

`celldefine
`suppress_faults
`enable_portfaults

module rdpb18_128x16_g1(
	AA,
	CPA,
	WEBA,
	REBA,
	OEBA,
	CSBA,
	IA,
	OA,
	AB,
	CPB,
	WEBB,
	REBB,
	OEBB,
	CSBB,
	IB,
	OB
	);

`define numaddr 7
`define numout 16
`define worddepth 128

input [`numaddr-1:0] AA;
input CPA;
input WEBA;
input REBA;
input OEBA;
input CSBA;
input [`numout-1:0] IA;
output [`numout-1:0] OA;

input [`numaddr-1:0] AB;
input CPB;
input WEBB;
input REBB;
input OEBB;
input CSBB;
input [`numout-1:0] IB;
output [`numout-1:0] OB;

`undef numaddr
`undef numout
`undef worddepth
endmodule
