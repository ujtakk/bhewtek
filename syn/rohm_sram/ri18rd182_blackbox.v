//
// Copyright (c) 2003 ROHM CO.,LTD.
// CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ROHM CO.,LTD.
// +------------------------------------------------------------+
// | ROHM BU40N1 0.18um 1.8V/3.3V process Dual Port RAM library |
// +------------------------------------------------------------+
//  Verilog model with Timing
//
//  Library Name    :  RI18RD182
//  Revision        :  r2
//  Date            :  24-Feb-2005
//

`timescale 1ns/10ps
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


`timescale 1ns/10ps
module rdpb18_128x24_g1(
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
`define numout 24
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


`timescale 1ns/10ps
module rdpb18_128x32_g1(
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
`define numout 32
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

`timescale 1ns/10ps
module rdpb18_128x8_g1(
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
`define numout 8
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


`timescale 1ns/10ps
module rdpb18_256x16_g1(
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

`define numaddr 8
`define numout 16
`define worddepth 256

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

`timescale 1ns/10ps
module rdpb18_256x8_g1(
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

`define numaddr 8
`define numout 8
`define worddepth 256

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

`timescale 1ns/10ps
module rdpb18_512x16_g1(
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

`define numaddr 9
`define numout 16
`define worddepth 512

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

`timescale 1ns/10ps
module rdpb18_512x8_g1(
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

`define numaddr 9
`define numout 8
`define worddepth 512

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

`timescale 1ns/10ps
module rdpb18_64x16_g1(
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

`define numaddr 6
`define numout 16
`define worddepth 64

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

`timescale 1ns/10ps
module rdpb18_64x8_g1(
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

`define numaddr 6
`define numout 8
`define worddepth 64

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

`timescale 1ns/10ps
module rdpb18_64x18_g1(
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

`define numaddr 6
`define numout 18
`define worddepth 64

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

