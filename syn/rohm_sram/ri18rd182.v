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
module rdpb18_128x16_g1_behave(
	a_state_a,
	cp_state_a,
	web_state_a,
	reb_state_a,
	oeb_state_a,
	csb_state_a,
	i_state_a,
	int_bus_a,
	sh_a_error_a,
	sh_cp_error_a,
	sh_web_error_a,
	sh_reb_error_a,
//	sh_oeb_error_a,
	sh_csb_error_a,
	sh_i_error_a,
	outctrl_a,
	error_a,
	a_state_b,
	cp_state_b,
	web_state_b,
	reb_state_b,
	oeb_state_b,
	csb_state_b,
	i_state_b,
	int_bus_b,
	sh_a_error_b,
	sh_cp_error_b,
	sh_web_error_b,
	sh_reb_error_b,
//	sh_oeb_error_b,
	sh_csb_error_b,
	sh_i_error_b,
	outctrl_b,
	error_b,
	confa,
	confb,
	cm_cp_error
	);

`define numaddr 7
`define numout 16
`define worddepth 128

`define verbose 2
`ifdef verbose_0
`undef verbose
`define verbose 0
`else
`endif
`ifdef verbose_1
`undef verbose
`define  verbose 1
`endif
`ifdef verbose_2
`undef verbose
`define verbose 2
`endif

input [`numaddr-1:0] a_state_a;
input cp_state_a;
input web_state_a;
input reb_state_a;
input oeb_state_a;
input csb_state_a;
input [`numout-1:0] i_state_a;
output [`numout-1:0] int_bus_a;
input sh_a_error_a;
input sh_web_error_a;
input sh_reb_error_a;
//input sh_oeb_error_a;
input sh_cp_error_a;
input sh_csb_error_a;
input sh_i_error_a;
output outctrl_a;
output error_a;

input [`numaddr-1:0] a_state_b;
input cp_state_b;
input web_state_b;
input reb_state_b;
input oeb_state_b;
input csb_state_b;
input [`numout-1:0] i_state_b;
output [`numout-1:0] int_bus_b;
input sh_a_error_b;
input sh_web_error_b;
input sh_reb_error_b;
//input sh_oeb_error_b;
input sh_cp_error_b;
input sh_csb_error_b;
input sh_i_error_b;
output outctrl_b;
output error_b;

output confa;
output confb;
input cm_cp_error;

reg [`numout-1:0] memory[`worddepth-1:0];
reg [`numout-1:0] int_bus_a;
reg outctrl_a;
reg error_a;
reg web_reg_a;
reg reb_reg_a;
reg oeb_reg_a;
reg csb_reg_a;
reg [`numaddr-1:0] a_reg_a;
reg [`numout-1:0] i_reg_a;
reg [`numout-1:0] out_bus_a;
integer n;
integer address_a;

reg [`numout-1:0] int_bus_b;
reg outctrl_b;
reg error_b;
reg web_reg_b;
reg reb_reg_b;
reg oeb_reg_b;
reg csb_reg_b;
reg [`numaddr-1:0] a_reg_b;
reg [`numout-1:0] i_reg_b;
reg [`numout-1:0] out_bus_b;
integer address_b;

reg confa;
reg confb;

initial
begin : initialize
  error_a = 1'b0;
  web_reg_a = 1'bx;
  reb_reg_a = 1'bx;
  oeb_reg_a = 1'bx;
  csb_reg_a = 1'bx;
  a_reg_a = `numaddr'bx;
  i_reg_a = `numout'bx;
  int_bus_a = `numout'bx;
  out_bus_a = `numout'bx;
  error_b = 1'b0;
  web_reg_b = 1'bx;
  reb_reg_b = 1'bx;
  oeb_reg_b = 1'bx;
  csb_reg_b = 1'bx;
  a_reg_b = `numaddr'bx;
  i_reg_b = `numout'bx;
  int_bus_b = `numout'bx;
  out_bus_b = `numout'bx;
  confa = 1'b0;
  confb = 1'b0;
  for (n=0; n < `worddepth; n = n + 1)
    memory[n] = `numout'bx;
end

task memoryerror_a;
  begin
    if (`verbose == 2)
    begin
      if (address_a == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_a] = `numout'bx;
      end
    end
  end
endtask

task memoryerror_b;
  begin
    if (`verbose == 2)
    begin
      if (address_b == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_b] = `numout'bx;
      end
    end
  end
endtask

task warning;
  input [1024:1] msg;
  begin
    if ($realtime != 0 && `verbose != 0)
    begin
      $display("%.1f : %m : %0s",$realtime,msg);
    end
  end
endtask

always @(negedge cp_state_a)
begin
  confa = 0;
end

always @(negedge cp_state_b)
begin
  confb = 0;
end

always @(cp_state_a or csb_state_a)
begin
  if ((cp_state_a === 1'bx || cp_state_a === 1'bz) && csb_state_a === 1'b0)
  begin
    warning("CPA is unknown.");
    address_a = -1;
    memoryerror_a;
    int_bus_a = `numout'bx;
    error_a = 1;
  end
end

always @(cp_state_b or csb_state_b)
begin
  if ((cp_state_b === 1'bx || cp_state_b === 1'bz) && csb_state_b === 1'b0)
  begin
    warning("CPB is unknown.");
    address_b = -1;
    memoryerror_b;
    int_bus_b = `numout'bx;
    error_b = 1;
  end
end

always @(oeb_state_a or csb_state_a)
begin
  outctrl_a = oeb_state_a | csb_state_a;
end

always @(oeb_state_b or csb_state_b)
begin
  outctrl_b = oeb_state_b | csb_state_b;
end

always @(posedge cp_state_a)
begin : ck_active_edge_a
  web_reg_a = web_state_a;
  reb_reg_a = reb_state_a;
  oeb_reg_a = oeb_state_a;
  csb_reg_a = csb_state_a;
  a_reg_a = a_state_a;
  i_reg_a = i_state_a;

  if ((csb_reg_a === 1'bx || csb_reg_a === 1'bz) && web_reg_a != 1'b1)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((web_reg_a === 1'bx || web_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((oeb_reg_a === 1'bx || oeb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((reb_reg_a === 1'bx || reb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ( ^a_reg_a === 1'bx || ^a_reg_a === 1'bz)
  begin
    address_a = -1;
    error_a = 1;
    warning("AA is unknown.");
    if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
    begin
      memoryerror_a;
    end
  end

  else if (address_a >= `worddepth)
  begin
    warning("AA is out of range.");
    error_a = 1;
  end

  else
  begin
    address_a = a_reg_a;
    error_a = 0;
  end

  if (!error_a)
  begin
    if (csb_reg_a === 1'b0)
    begin
      if (web_reg_a === 1'b0 && reb_reg_a === 1'b1)
      begin
	memory[address_a] = i_reg_a;
      end
      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b0)
      begin
        int_bus_a <= memory[address_a];
      end
      else if (web_reg_a === 1'b0 && reb_reg_a === 1'b0)
      begin
	memory[address_a] = i_reg_a;
        int_bus_a = i_reg_a;
      end
//      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b1)
//      begin
//	warning("both WEBA and REBA are not active.");
//      end
    end
  end
end

always @(posedge cp_state_b)
begin : ck_active_edge_b
  web_reg_b = web_state_b;
  reb_reg_b = reb_state_b;
  oeb_reg_b = oeb_state_b;
  csb_reg_b = csb_state_b;
  a_reg_b = a_state_b;
  i_reg_b = i_state_b;

  if ((csb_reg_b === 1'bx || csb_reg_b === 1'bz) && web_reg_b != 1'b1)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ((web_reg_b === 1'bx || web_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((oeb_reg_b === 1'bx || oeb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((reb_reg_b === 1'bx || reb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ( ^a_reg_b === 1'bx || ^a_reg_b === 1'bz)
  begin
    address_b = -1;
    error_b = 1;
    warning("AB is unknown.");
    if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
    begin
      memoryerror_b;
    end
  end

  else if (address_b >= `worddepth)
  begin
    warning("AB is out of range.");
    error_b = 1;
  end

  else
  begin
    address_b = a_reg_b;
    error_b = 0;
  end

  if (!error_b)
  begin
    if (csb_reg_b === 1'b0)
    begin
      if (web_reg_b === 1'b0 && reb_reg_b === 1'b1)
      begin
	memory[address_b] = i_reg_b;
      end
      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b0)
      begin
        int_bus_b <= memory[address_b];
      end
      else if (web_reg_b === 1'b0 && reb_reg_b === 1'b0)
      begin
	memory[address_b] = i_reg_b;
        int_bus_b = i_reg_b;
      end
//      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b1)
//      begin
//	warning("both WEBB and REBB are not active.");
//      end
    end
  end
end

always @(posedge cp_state_a)
begin
  if (a_state_a == a_state_b &&
//    web_state_a === 1'b0 &&
      csb_state_a === 1'b0 &&
      ~(web_state_a === 1'b1 && reb_state_a === 1'b1))
  begin
    confa = 1'b1;
  end
  else
  begin
    confa = 1'b0;
  end
end

always @(posedge cp_state_b)
begin
  if (a_state_a == a_state_b &&
//    web_state_b === 1'b0 &&
      csb_state_b === 1'b0 &&
      ~(web_state_b === 1'b1 && reb_state_b === 1'b1))
  begin
    confb = 1'b1;
  end
  else
  begin
    confb = 1'b0;
  end
end

always @(cm_cp_error)
begin : Write_conflict_Error
  if (reb_state_a === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_a = `numout'bx;
  end
  if (reb_state_b === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_b = `numout'bx;
  end
  if (web_state_a === 1'b0 && web_state_b === 1'b0)
  begin
    address_a = -1;
    address_b = -1;
    memoryerror_a;
  end
end  

always @(sh_cp_error_a)
begin : setup_ck_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_csb_error_a)
begin : setup_csb_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_a_error_a)
begin : setuphold_address_error_a
  if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_i_error_a)
begin : setuphold_i_error_a
  if (web_state_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_web_error_a)
begin : setuphold_web_error_a
  if (csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_reb_error_a)
begin : setuphold_reb_error_a
  if (csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
  end
end

//always @(sh_oeb_error_a)
//begin : setuphold_oeb_error_a
//  if (csb_reg_a === 1'b0)
//  begin
//    #0.01 int_bus_a = `numout'bx;
//  end
//end

always @(sh_cp_error_b)
begin : setup_ck_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_csb_error_b)
begin : setup_csb_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_a_error_b)
begin : setuphold_address_error_b
  if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_i_error_b)
begin : setuphold_i_error_b
  if (web_state_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_web_error_b)
begin : setuphold_web_error_b
  if (csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_reb_error_b)
begin : setuphold_reb_error_b
  if (csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
  end
end

//always @(sh_oeb_error_b)
//begin : setuphold_oeb_error_b
//  if (csb_reg_b === 1'b0)
//  begin
//    #0.01 int_bus_b = `numout'bx;
//  end
//end

endmodule

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

wire [`numaddr-1:0] AA;
wire CPA;
wire WEBA;
wire REBA;
wire OEBA;
wire CSBA;
wire [`numout-1:0] IA;
wire [`numout-1:0] OA;
wire [`numaddr-1:0] a_state_a;
wire cp_state_a;
wire web_state_a;
wire reb_state_a;
wire oeb_state_a;
wire csb_state_a;
wire [`numout-1:0] i_state_a;
wire [`numout-1:0] int_bus_a;

wire [`numaddr-1:0] AB;
wire CPB;
wire WEBB;
wire REBB;
wire OEBB;
wire CSBB;
wire [`numout-1:0] IB;
wire [`numout-1:0] OB;
wire [`numaddr-1:0] a_state_b;
wire cp_state_b;
wire web_state_b;
wire reb_state_b;
wire oeb_state_b;
wire csb_state_b;
wire [`numout-1:0] i_state_b;
wire [`numout-1:0] int_bus_b;

buf (a_state_a[6],AA[6]),
    (a_state_a[5],AA[5]),
    (a_state_a[4],AA[4]),
    (a_state_a[3],AA[3]),
    (a_state_a[2],AA[2]),
    (a_state_a[1],AA[1]),
    (a_state_a[0],AA[0]);

buf (a_state_b[6],AB[6]),
    (a_state_b[5],AB[5]),
    (a_state_b[4],AB[4]),
    (a_state_b[3],AB[3]),
    (a_state_b[2],AB[2]),
    (a_state_b[1],AB[1]),
    (a_state_b[0],AB[0]);

buf (cp_state_a,CPA);
buf (web_state_a,WEBA);
buf (reb_state_a,REBA);
buf (oeb_state_a,OEBA);
buf (csb_state_a,CSBA);

buf (cp_state_b,CPB);
buf (web_state_b,WEBB);
buf (reb_state_b,REBB);
buf (oeb_state_b,OEBB);
buf (csb_state_b,CSBB);

buf (i_state_a[15],IA[15]),
    (i_state_a[14],IA[14]),
    (i_state_a[13],IA[13]),
    (i_state_a[12],IA[12]),
    (i_state_a[11],IA[11]),
    (i_state_a[10],IA[10]),
    (i_state_a[9],IA[9]),
    (i_state_a[8],IA[8]),
    (i_state_a[7],IA[7]),
    (i_state_a[6],IA[6]),
    (i_state_a[5],IA[5]),
    (i_state_a[4],IA[4]),
    (i_state_a[3],IA[3]),
    (i_state_a[2],IA[2]),
    (i_state_a[1],IA[1]),
    (i_state_a[0],IA[0]);

buf (i_state_b[15],IB[15]),
    (i_state_b[14],IB[14]),
    (i_state_b[13],IB[13]),
    (i_state_b[12],IB[12]),
    (i_state_b[11],IB[11]),
    (i_state_b[10],IB[10]),
    (i_state_b[9],IB[9]),
    (i_state_b[8],IB[8]),
    (i_state_b[7],IB[7]),
    (i_state_b[6],IB[6]),
    (i_state_b[5],IB[5]),
    (i_state_b[4],IB[4]),
    (i_state_b[3],IB[3]),
    (i_state_b[2],IB[2]),
    (i_state_b[1],IB[1]),
    (i_state_b[0],IB[0]);

bufif0 (OA[15],int_bus_a[15],outctrl_a),
       (OA[14],int_bus_a[14],outctrl_a),
       (OA[13],int_bus_a[13],outctrl_a),
       (OA[12],int_bus_a[12],outctrl_a),
       (OA[11],int_bus_a[11],outctrl_a),
       (OA[10],int_bus_a[10],outctrl_a),
       (OA[9],int_bus_a[9],outctrl_a),
       (OA[8],int_bus_a[8],outctrl_a),
       (OA[7],int_bus_a[7],outctrl_a),
       (OA[6],int_bus_a[6],outctrl_a),
       (OA[5],int_bus_a[5],outctrl_a),
       (OA[4],int_bus_a[4],outctrl_a),
       (OA[3],int_bus_a[3],outctrl_a),
       (OA[2],int_bus_a[2],outctrl_a),
       (OA[1],int_bus_a[1],outctrl_a),
       (OA[0],int_bus_a[0],outctrl_a);

bufif0 (OB[15],int_bus_b[15],outctrl_b),
       (OB[14],int_bus_b[14],outctrl_b),
       (OB[13],int_bus_b[13],outctrl_b),
       (OB[12],int_bus_b[12],outctrl_b),
       (OB[11],int_bus_b[11],outctrl_b),
       (OB[10],int_bus_b[10],outctrl_b),
       (OB[9],int_bus_b[9],outctrl_b),
       (OB[8],int_bus_b[8],outctrl_b),
       (OB[7],int_bus_b[7],outctrl_b),
       (OB[6],int_bus_b[6],outctrl_b),
       (OB[5],int_bus_b[5],outctrl_b),
       (OB[4],int_bus_b[4],outctrl_b),
       (OB[3],int_bus_b[3],outctrl_b),
       (OB[2],int_bus_b[2],outctrl_b),
       (OB[1],int_bus_b[1],outctrl_b),
       (OB[0],int_bus_b[0],outctrl_b);

reg sh_a_error_a;
reg sh_cp_error_a;
reg sh_web_error_a;
reg sh_reb_error_a;
//reg sh_oeb_error_a;
reg sh_csb_error_a;
reg sh_i_error_a;
wire error_a;

reg sh_a_error_b;
reg sh_cp_error_b;
reg sh_web_error_b;
reg sh_reb_error_b;
//reg sh_oeb_error_b;
reg sh_csb_error_b;
reg sh_i_error_b;
wire error_b;

reg cm_cp_error;

rdpb18_128x16_g1_behave u1 (
	.a_state_a(a_state_a),
	.cp_state_a(cp_state_a),
	.web_state_a(web_state_a),
	.reb_state_a(reb_state_a),
	.oeb_state_a(oeb_state_a),
	.csb_state_a(csb_state_a),
	.i_state_a(i_state_a),
	.int_bus_a(int_bus_a),
	.sh_a_error_a(sh_a_error_a),
	.sh_cp_error_a(sh_cp_error_a),
	.sh_web_error_a(sh_web_error_a),
	.sh_reb_error_a(sh_reb_error_a),
//	.sh_oeb_error_a(sh_oeb_error_a),
	.sh_csb_error_a(sh_csb_error_a),
	.sh_i_error_a(sh_i_error_a),
	.outctrl_a(outctrl_a),
	.error_a(error_a),
	
	.a_state_b(a_state_b),
	.cp_state_b(cp_state_b),
	.web_state_b(web_state_b),
	.reb_state_b(reb_state_b),
	.oeb_state_b(oeb_state_b),
	.csb_state_b(csb_state_b),
	.i_state_b(i_state_b),
	.int_bus_b(int_bus_b),
	.sh_a_error_b(sh_a_error_b),
	.sh_cp_error_b(sh_cp_error_b),
	.sh_web_error_b(sh_web_error_b),
	.sh_reb_error_b(sh_reb_error_b),
//	.sh_oeb_error_b(sh_oeb_error_b),
	.sh_csb_error_b(sh_csb_error_b),
	.sh_i_error_b(sh_i_error_b),
	.outctrl_b(outctrl_b),
	.error_b(error_b),

	.confa(confa),
	.confb(confb),
	.cm_cp_error(cm_cp_error)
	);
	
specify
  specparam df    = 1.0,
	    tacr  = 2.70*df,  // rise access time @Cload=0.0pF
	    tacf  = 2.70*df,  // fall access time @Cload=0.0pF
            tcyc  = 6.00*df,  // cycle time
            twh   = 3.00*df,  // minimum clock high time.
	    twl   = 3.00*df,  // minimum clock low time.
	    twes  = 0.75*df,  // web setup time
	    tweh  = 0.35*df,  // web hold time
	    tres  = 0.75*df,  // reb setup time
	    treh  = 0.35*df,  // reb hold time
	    tcs   = 0.75*df,  // csb setup time
	    tch   = 0.35*df,  // csb hold time
	    tadds = 0.50*df,  // address setup time
	    taddh = 0.65*df,  // address hold time
	    tis   = 0.40*df,  // data setup time
	    tih   = 1.30*df,  // data hold time
	    toh   = 1.50*df,  // oeb disbale time
	    tcm   = 4.65*df;  // cp conflict margin (if AA=AB && WEBA=WEBB="L")

  if (!error_a) (CPA => OA[0]) = (tacr,tacf);
  if (!error_a) (CPA => OA[1]) = (tacr,tacf);
  if (!error_a) (CPA => OA[2]) = (tacr,tacf);
  if (!error_a) (CPA => OA[3]) = (tacr,tacf);
  if (!error_a) (CPA => OA[4]) = (tacr,tacf);
  if (!error_a) (CPA => OA[5]) = (tacr,tacf);
  if (!error_a) (CPA => OA[6]) = (tacr,tacf);
  if (!error_a) (CPA => OA[7]) = (tacr,tacf);
  if (!error_a) (CPA => OA[8]) = (tacr,tacf);
  if (!error_a) (CPA => OA[9]) = (tacr,tacf);
  if (!error_a) (CPA => OA[10]) = (tacr,tacf);
  if (!error_a) (CPA => OA[11]) = (tacr,tacf);
  if (!error_a) (CPA => OA[12]) = (tacr,tacf);
  if (!error_a) (CPA => OA[13]) = (tacr,tacf);
  if (!error_a) (CPA => OA[14]) = (tacr,tacf);
  if (!error_a) (CPA => OA[15]) = (tacr,tacf);
  if (!error_a) (OEBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);

  if (!error_b) (CPB => OB[0]) = (tacr,tacf);
  if (!error_b) (CPB => OB[1]) = (tacr,tacf);
  if (!error_b) (CPB => OB[2]) = (tacr,tacf);
  if (!error_b) (CPB => OB[3]) = (tacr,tacf);
  if (!error_b) (CPB => OB[4]) = (tacr,tacf);
  if (!error_b) (CPB => OB[5]) = (tacr,tacf);
  if (!error_b) (CPB => OB[6]) = (tacr,tacf);
  if (!error_b) (CPB => OB[7]) = (tacr,tacf);
  if (!error_b) (CPB => OB[8]) = (tacr,tacf);
  if (!error_b) (CPB => OB[9]) = (tacr,tacf);
  if (!error_b) (CPB => OB[10]) = (tacr,tacf);
  if (!error_b) (CPB => OB[11]) = (tacr,tacf);
  if (!error_b) (CPB => OB[12]) = (tacr,tacf);
  if (!error_b) (CPB => OB[13]) = (tacr,tacf);
  if (!error_b) (CPB => OB[14]) = (tacr,tacf);
  if (!error_b) (CPB => OB[15]) = (tacr,tacf);
  if (!error_b) (OEBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);

  $setup(posedge WEBA,posedge CPA,twes,sh_web_error_a);
  $setup(negedge WEBA,posedge CPA,twes,sh_web_error_a);
  $hold(posedge CPA,negedge WEBA,tweh,sh_web_error_a);
  $hold(posedge CPA,posedge WEBA,tweh,sh_web_error_a);
  $setup(posedge REBA,posedge CPA,tres,sh_reb_error_a);
  $setup(negedge REBA,posedge CPA,tres,sh_reb_error_a);
  $hold(posedge CPA,posedge REBA,treh,sh_reb_error_a);
  $hold(posedge CPA,negedge REBA,treh,sh_reb_error_a);
//  $setup(posedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $setup(negedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $hold(posedge CPA,posedge OEBA,toeh,sh_oeb_error_a);
//  $hold(posedge CPA,negedge OEBA,toeh,sh_oeb_error_a);
  $setup(posedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[0],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[0],taddh,sh_a_error_a);
  $setup(posedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[1],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[1],taddh,sh_a_error_a);
  $setup(posedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[2],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[2],taddh,sh_a_error_a);
  $setup(posedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[3],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[3],taddh,sh_a_error_a);
  $setup(posedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[4],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[4],taddh,sh_a_error_a);
  $setup(posedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[5],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[5],taddh,sh_a_error_a);
  $setup(posedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[6],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[6],taddh,sh_a_error_a);
  $setup(posedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $setup(negedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $hold(posedge CPA,posedge CSBA,tch,sh_csb_error_a);
  $hold(posedge CPA,negedge CSBA,tch,sh_csb_error_a);
  $setup(posedge IA[0],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[0],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[0],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[0],tih,sh_i_error_a);
  $setup(posedge IA[1],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[1],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[1],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[1],tih,sh_i_error_a);
  $setup(posedge IA[2],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[2],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[2],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[2],tih,sh_i_error_a);
  $setup(posedge IA[3],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[3],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[3],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[3],tih,sh_i_error_a);
  $setup(posedge IA[4],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[4],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[4],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[4],tih,sh_i_error_a);
  $setup(posedge IA[5],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[5],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[5],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[5],tih,sh_i_error_a);
  $setup(posedge IA[6],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[6],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[6],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[6],tih,sh_i_error_a);
  $setup(posedge IA[7],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[7],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[7],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[7],tih,sh_i_error_a);
  $setup(posedge IA[8],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[8],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[8],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[8],tih,sh_i_error_a);
  $setup(posedge IA[9],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[9],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[9],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[9],tih,sh_i_error_a);
  $setup(posedge IA[10],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[10],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[10],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[10],tih,sh_i_error_a);
  $setup(posedge IA[11],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[11],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[11],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[11],tih,sh_i_error_a);
  $setup(posedge IA[12],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[12],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[12],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[12],tih,sh_i_error_a);
  $setup(posedge IA[13],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[13],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[13],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[13],tih,sh_i_error_a);
  $setup(posedge IA[14],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[14],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[14],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[14],tih,sh_i_error_a);
  $setup(posedge IA[15],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[15],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[15],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[15],tih,sh_i_error_a);
  $width(posedge CPA,twh,0,sh_cp_error_a);
  $width(negedge CPA,twl,0,sh_cp_error_a);
  $period(posedge CPA,tcyc,sh_cp_error_a);
  $period(negedge CPA,tcyc);

  $setup(posedge WEBB,posedge CPB,twes,sh_web_error_b);
  $setup(negedge WEBB,posedge CPB,twes,sh_web_error_b);
  $hold(posedge CPB,negedge WEBB,tweh,sh_web_error_b);
  $hold(posedge CPB,posedge WEBB,tweh,sh_web_error_b);
  $setup(posedge REBB,posedge CPB,tres,sh_reb_error_b);
  $setup(negedge REBB,posedge CPB,tres,sh_reb_error_b);
  $hold(posedge CPB,posedge REBB,treh,sh_reb_error_b);
  $hold(posedge CPB,negedge REBB,treh,sh_reb_error_b);
//  $setup(posedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $setup(negedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $hold(posedge CPB,posedge OEBB,toeh,sh_oeb_error_b);
//  $hold(posedge CPB,negedge OEBB,toeh,sh_oeb_error_b);
  $setup(posedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[0],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[0],taddh,sh_a_error_b);
  $setup(posedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[1],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[1],taddh,sh_a_error_b);
  $setup(posedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[2],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[2],taddh,sh_a_error_b);
  $setup(posedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[3],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[3],taddh,sh_a_error_b);
  $setup(posedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[4],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[4],taddh,sh_a_error_b);
  $setup(posedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[5],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[5],taddh,sh_a_error_b);
  $setup(posedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[6],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[6],taddh,sh_a_error_b);
  $setup(posedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $setup(negedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $hold(posedge CPB,posedge CSBB,tch,sh_csb_error_b);
  $hold(posedge CPB,negedge CSBB,tch,sh_csb_error_b);
  $setup(posedge IB[0],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[0],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[0],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[0],tih,sh_i_error_b);
  $setup(posedge IB[1],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[1],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[1],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[1],tih,sh_i_error_b);
  $setup(posedge IB[2],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[2],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[2],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[2],tih,sh_i_error_b);
  $setup(posedge IB[3],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[3],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[3],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[3],tih,sh_i_error_b);
  $setup(posedge IB[4],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[4],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[4],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[4],tih,sh_i_error_b);
  $setup(posedge IB[5],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[5],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[5],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[5],tih,sh_i_error_b);
  $setup(posedge IB[6],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[6],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[6],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[6],tih,sh_i_error_b);
  $setup(posedge IB[7],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[7],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[7],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[7],tih,sh_i_error_b);
  $setup(posedge IB[8],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[8],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[8],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[8],tih,sh_i_error_b);
  $setup(posedge IB[9],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[9],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[9],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[9],tih,sh_i_error_b);
  $setup(posedge IB[10],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[10],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[10],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[10],tih,sh_i_error_b);
  $setup(posedge IB[11],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[11],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[11],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[11],tih,sh_i_error_b);
  $setup(posedge IB[12],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[12],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[12],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[12],tih,sh_i_error_b);
  $setup(posedge IB[13],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[13],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[13],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[13],tih,sh_i_error_b);
  $setup(posedge IB[14],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[14],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[14],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[14],tih,sh_i_error_b);
  $setup(posedge IB[15],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[15],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[15],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[15],tih,sh_i_error_b);
  $width(posedge CPB,twh,0,sh_cp_error_b);
  $width(negedge CPB,twl,0,sh_cp_error_b);
  $period(posedge CPB,tcyc,sh_cp_error_b);
  $period(negedge CPB,tcyc);
  
  $setup(posedge confa,posedge confb,tcm,cm_cp_error);
  $setup(posedge confb,posedge confa,tcm,cm_cp_error);
  $hold(posedge confa,posedge confb,tcm,cm_cp_error);
  $hold(posedge confb,posedge confa,tcm,cm_cp_error);

endspecify

`undef numaddr
`undef numout
`undef worddepth
`undef verbose
endmodule
`nosuppress_faults
`disable_portfaults
`endcelldefine

`timescale 1ns/10ps
module rdpb18_128x24_g1_behave(
	a_state_a,
	cp_state_a,
	web_state_a,
	reb_state_a,
	oeb_state_a,
	csb_state_a,
	i_state_a,
	int_bus_a,
	sh_a_error_a,
	sh_cp_error_a,
	sh_web_error_a,
	sh_reb_error_a,
//	sh_oeb_error_a,
	sh_csb_error_a,
	sh_i_error_a,
	outctrl_a,
	error_a,
	a_state_b,
	cp_state_b,
	web_state_b,
	reb_state_b,
	oeb_state_b,
	csb_state_b,
	i_state_b,
	int_bus_b,
	sh_a_error_b,
	sh_cp_error_b,
	sh_web_error_b,
	sh_reb_error_b,
//	sh_oeb_error_b,
	sh_csb_error_b,
	sh_i_error_b,
	outctrl_b,
	error_b,
	confa,
	confb,
	cm_cp_error
	);

`define numaddr 7
`define numout 24
`define worddepth 128

`define verbose 2
`ifdef verbose_0
`undef verbose
`define verbose 0
`else
`endif
`ifdef verbose_1
`undef verbose
`define  verbose 1
`endif
`ifdef verbose_2
`undef verbose
`define verbose 2
`endif

input [`numaddr-1:0] a_state_a;
input cp_state_a;
input web_state_a;
input reb_state_a;
input oeb_state_a;
input csb_state_a;
input [`numout-1:0] i_state_a;
output [`numout-1:0] int_bus_a;
input sh_a_error_a;
input sh_web_error_a;
input sh_reb_error_a;
//input sh_oeb_error_a;
input sh_cp_error_a;
input sh_csb_error_a;
input sh_i_error_a;
output outctrl_a;
output error_a;

input [`numaddr-1:0] a_state_b;
input cp_state_b;
input web_state_b;
input reb_state_b;
input oeb_state_b;
input csb_state_b;
input [`numout-1:0] i_state_b;
output [`numout-1:0] int_bus_b;
input sh_a_error_b;
input sh_web_error_b;
input sh_reb_error_b;
//input sh_oeb_error_b;
input sh_cp_error_b;
input sh_csb_error_b;
input sh_i_error_b;
output outctrl_b;
output error_b;

output confa;
output confb;
input cm_cp_error;

reg [`numout-1:0] memory[`worddepth-1:0];
reg [`numout-1:0] int_bus_a;
reg outctrl_a;
reg error_a;
reg web_reg_a;
reg reb_reg_a;
reg oeb_reg_a;
reg csb_reg_a;
reg [`numaddr-1:0] a_reg_a;
reg [`numout-1:0] i_reg_a;
reg [`numout-1:0] out_bus_a;
integer n;
integer address_a;

reg [`numout-1:0] int_bus_b;
reg outctrl_b;
reg error_b;
reg web_reg_b;
reg reb_reg_b;
reg oeb_reg_b;
reg csb_reg_b;
reg [`numaddr-1:0] a_reg_b;
reg [`numout-1:0] i_reg_b;
reg [`numout-1:0] out_bus_b;
integer address_b;

reg confa;
reg confb;

initial
begin : initialize
  error_a = 1'b0;
  web_reg_a = 1'bx;
  reb_reg_a = 1'bx;
  oeb_reg_a = 1'bx;
  csb_reg_a = 1'bx;
  a_reg_a = `numaddr'bx;
  i_reg_a = `numout'bx;
  int_bus_a = `numout'bx;
  out_bus_a = `numout'bx;
  error_b = 1'b0;
  web_reg_b = 1'bx;
  reb_reg_b = 1'bx;
  oeb_reg_b = 1'bx;
  csb_reg_b = 1'bx;
  a_reg_b = `numaddr'bx;
  i_reg_b = `numout'bx;
  int_bus_b = `numout'bx;
  out_bus_b = `numout'bx;
  confa = 1'b0;
  confb = 1'b0;
  for (n=0; n < `worddepth; n = n + 1)
    memory[n] = `numout'bx;
end

task memoryerror_a;
  begin
    if (`verbose == 2)
    begin
      if (address_a == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_a] = `numout'bx;
      end
    end
  end
endtask

task memoryerror_b;
  begin
    if (`verbose == 2)
    begin
      if (address_b == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_b] = `numout'bx;
      end
    end
  end
endtask

task warning;
  input [1024:1] msg;
  begin
    if ($realtime != 0 && `verbose != 0)
    begin
      $display("%.1f : %m : %0s",$realtime,msg);
    end
  end
endtask

always @(negedge cp_state_a)
begin
  confa = 0;
end

always @(negedge cp_state_b)
begin
  confb = 0;
end

always @(cp_state_a or csb_state_a)
begin
  if ((cp_state_a === 1'bx || cp_state_a === 1'bz) && csb_state_a === 1'b0)
  begin
    warning("CPA is unknown.");
    address_a = -1;
    memoryerror_a;
    int_bus_a = `numout'bx;
    error_a = 1;
  end
end

always @(cp_state_b or csb_state_b)
begin
  if ((cp_state_b === 1'bx || cp_state_b === 1'bz) && csb_state_b === 1'b0)
  begin
    warning("CPB is unknown.");
    address_b = -1;
    memoryerror_b;
    int_bus_b = `numout'bx;
    error_b = 1;
  end
end

always @(oeb_state_a or csb_state_a)
begin
  outctrl_a = oeb_state_a | csb_state_a;
end

always @(oeb_state_b or csb_state_b)
begin
  outctrl_b = oeb_state_b | csb_state_b;
end

always @(posedge cp_state_a)
begin : ck_active_edge_a
  web_reg_a = web_state_a;
  reb_reg_a = reb_state_a;
  oeb_reg_a = oeb_state_a;
  csb_reg_a = csb_state_a;
  a_reg_a = a_state_a;
  i_reg_a = i_state_a;

  if ((csb_reg_a === 1'bx || csb_reg_a === 1'bz) && web_reg_a != 1'b1)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((web_reg_a === 1'bx || web_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((oeb_reg_a === 1'bx || oeb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((reb_reg_a === 1'bx || reb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ( ^a_reg_a === 1'bx || ^a_reg_a === 1'bz)
  begin
    address_a = -1;
    error_a = 1;
    warning("AA is unknown.");
    if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
    begin
      memoryerror_a;
    end
  end

  else if (address_a >= `worddepth)
  begin
    warning("AA is out of range.");
    error_a = 1;
  end

  else
  begin
    address_a = a_reg_a;
    error_a = 0;
  end

  if (!error_a)
  begin
    if (csb_reg_a === 1'b0)
    begin
      if (web_reg_a === 1'b0 && reb_reg_a === 1'b1)
      begin
	memory[address_a] = i_reg_a;
      end
      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b0)
      begin
        int_bus_a <= memory[address_a];
      end
      else if (web_reg_a === 1'b0 && reb_reg_a === 1'b0)
      begin
	memory[address_a] = i_reg_a;
        int_bus_a = i_reg_a;
      end
//      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b1)
//      begin
//	warning("both WEBA and REBA are not active.");
//      end
    end
  end
end

always @(posedge cp_state_b)
begin : ck_active_edge_b
  web_reg_b = web_state_b;
  reb_reg_b = reb_state_b;
  oeb_reg_b = oeb_state_b;
  csb_reg_b = csb_state_b;
  a_reg_b = a_state_b;
  i_reg_b = i_state_b;

  if ((csb_reg_b === 1'bx || csb_reg_b === 1'bz) && web_reg_b != 1'b1)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ((web_reg_b === 1'bx || web_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((oeb_reg_b === 1'bx || oeb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((reb_reg_b === 1'bx || reb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ( ^a_reg_b === 1'bx || ^a_reg_b === 1'bz)
  begin
    address_b = -1;
    error_b = 1;
    warning("AB is unknown.");
    if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
    begin
      memoryerror_b;
    end
  end

  else if (address_b >= `worddepth)
  begin
    warning("AB is out of range.");
    error_b = 1;
  end

  else
  begin
    address_b = a_reg_b;
    error_b = 0;
  end

  if (!error_b)
  begin
    if (csb_reg_b === 1'b0)
    begin
      if (web_reg_b === 1'b0 && reb_reg_b === 1'b1)
      begin
	memory[address_b] = i_reg_b;
      end
      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b0)
      begin
        int_bus_b <= memory[address_b];
      end
      else if (web_reg_b === 1'b0 && reb_reg_b === 1'b0)
      begin
	memory[address_b] = i_reg_b;
        int_bus_b = i_reg_b;
      end
//      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b1)
//      begin
//	warning("both WEBB and REBB are not active.");
//      end
    end
  end
end

always @(posedge cp_state_a)
begin
  if (a_state_a == a_state_b &&
//    web_state_a === 1'b0 &&
      csb_state_a === 1'b0 &&
      ~(web_state_a === 1'b1 && reb_state_a === 1'b1))
  begin
    confa = 1'b1;
  end
  else
  begin
    confa = 1'b0;
  end
end

always @(posedge cp_state_b)
begin
  if (a_state_a == a_state_b &&
//    web_state_b === 1'b0 &&
      csb_state_b === 1'b0 &&
      ~(web_state_b === 1'b1 && reb_state_b === 1'b1))
  begin
    confb = 1'b1;
  end
  else
  begin
    confb = 1'b0;
  end
end

always @(cm_cp_error)
begin : Write_conflict_Error
  if (reb_state_a === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_a = `numout'bx;
  end
  if (reb_state_b === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_b = `numout'bx;
  end
  if (web_state_a === 1'b0 && web_state_b === 1'b0)
  begin
    address_a = -1;
    address_b = -1;
    memoryerror_a;
  end
end  

always @(sh_cp_error_a)
begin : setup_ck_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_csb_error_a)
begin : setup_csb_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_a_error_a)
begin : setuphold_address_error_a
  if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_i_error_a)
begin : setuphold_i_error_a
  if (web_state_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_web_error_a)
begin : setuphold_web_error_a
  if (csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_reb_error_a)
begin : setuphold_reb_error_a
  if (csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
  end
end

//always @(sh_oeb_error_a)
//begin : setuphold_oeb_error_a
//  if (csb_reg_a === 1'b0)
//  begin
//    #0.01 int_bus_a = `numout'bx;
//  end
//end

always @(sh_cp_error_b)
begin : setup_ck_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_csb_error_b)
begin : setup_csb_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_a_error_b)
begin : setuphold_address_error_b
  if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_i_error_b)
begin : setuphold_i_error_b
  if (web_state_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_web_error_b)
begin : setuphold_web_error_b
  if (csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_reb_error_b)
begin : setuphold_reb_error_b
  if (csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
  end
end

//always @(sh_oeb_error_b)
//begin : setuphold_oeb_error_b
//  if (csb_reg_b === 1'b0)
//  begin
//    #0.01 int_bus_b = `numout'bx;
//  end
//end

endmodule

`celldefine
`suppress_faults
`enable_portfaults

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

wire [`numaddr-1:0] AA;
wire CPA;
wire WEBA;
wire REBA;
wire OEBA;
wire CSBA;
wire [`numout-1:0] IA;
wire [`numout-1:0] OA;
wire [`numaddr-1:0] a_state_a;
wire cp_state_a;
wire web_state_a;
wire reb_state_a;
wire oeb_state_a;
wire csb_state_a;
wire [`numout-1:0] i_state_a;
wire [`numout-1:0] int_bus_a;

wire [`numaddr-1:0] AB;
wire CPB;
wire WEBB;
wire REBB;
wire OEBB;
wire CSBB;
wire [`numout-1:0] IB;
wire [`numout-1:0] OB;
wire [`numaddr-1:0] a_state_b;
wire cp_state_b;
wire web_state_b;
wire reb_state_b;
wire oeb_state_b;
wire csb_state_b;
wire [`numout-1:0] i_state_b;
wire [`numout-1:0] int_bus_b;

buf (a_state_a[6],AA[6]),
    (a_state_a[5],AA[5]),
    (a_state_a[4],AA[4]),
    (a_state_a[3],AA[3]),
    (a_state_a[2],AA[2]),
    (a_state_a[1],AA[1]),
    (a_state_a[0],AA[0]);

buf (a_state_b[6],AB[6]),
    (a_state_b[5],AB[5]),
    (a_state_b[4],AB[4]),
    (a_state_b[3],AB[3]),
    (a_state_b[2],AB[2]),
    (a_state_b[1],AB[1]),
    (a_state_b[0],AB[0]);

buf (cp_state_a,CPA);
buf (web_state_a,WEBA);
buf (reb_state_a,REBA);
buf (oeb_state_a,OEBA);
buf (csb_state_a,CSBA);

buf (cp_state_b,CPB);
buf (web_state_b,WEBB);
buf (reb_state_b,REBB);
buf (oeb_state_b,OEBB);
buf (csb_state_b,CSBB);

buf (i_state_a[23],IA[23]),
    (i_state_a[22],IA[22]),
    (i_state_a[21],IA[21]),
    (i_state_a[20],IA[20]),
    (i_state_a[19],IA[19]),
    (i_state_a[18],IA[18]),
    (i_state_a[17],IA[17]),
    (i_state_a[16],IA[16]),
    (i_state_a[15],IA[15]),
    (i_state_a[14],IA[14]),
    (i_state_a[13],IA[13]),
    (i_state_a[12],IA[12]),
    (i_state_a[11],IA[11]),
    (i_state_a[10],IA[10]),
    (i_state_a[9],IA[9]),
    (i_state_a[8],IA[8]),
    (i_state_a[7],IA[7]),
    (i_state_a[6],IA[6]),
    (i_state_a[5],IA[5]),
    (i_state_a[4],IA[4]),
    (i_state_a[3],IA[3]),
    (i_state_a[2],IA[2]),
    (i_state_a[1],IA[1]),
    (i_state_a[0],IA[0]);

buf (i_state_b[23],IB[23]),
    (i_state_b[22],IB[22]),
    (i_state_b[21],IB[21]),
    (i_state_b[20],IB[20]),
    (i_state_b[19],IB[19]),
    (i_state_b[18],IB[18]),
    (i_state_b[17],IB[17]),
    (i_state_b[16],IB[16]),
    (i_state_b[15],IB[15]),
    (i_state_b[14],IB[14]),
    (i_state_b[13],IB[13]),
    (i_state_b[12],IB[12]),
    (i_state_b[11],IB[11]),
    (i_state_b[10],IB[10]),
    (i_state_b[9],IB[9]),
    (i_state_b[8],IB[8]),
    (i_state_b[7],IB[7]),
    (i_state_b[6],IB[6]),
    (i_state_b[5],IB[5]),
    (i_state_b[4],IB[4]),
    (i_state_b[3],IB[3]),
    (i_state_b[2],IB[2]),
    (i_state_b[1],IB[1]),
    (i_state_b[0],IB[0]);

bufif0 (OA[23],int_bus_a[23],outctrl_a),
       (OA[22],int_bus_a[22],outctrl_a),
       (OA[21],int_bus_a[21],outctrl_a),
       (OA[20],int_bus_a[20],outctrl_a),
       (OA[19],int_bus_a[19],outctrl_a),
       (OA[18],int_bus_a[18],outctrl_a),
       (OA[17],int_bus_a[17],outctrl_a),
       (OA[16],int_bus_a[16],outctrl_a),
       (OA[15],int_bus_a[15],outctrl_a),
       (OA[14],int_bus_a[14],outctrl_a),
       (OA[13],int_bus_a[13],outctrl_a),
       (OA[12],int_bus_a[12],outctrl_a),
       (OA[11],int_bus_a[11],outctrl_a),
       (OA[10],int_bus_a[10],outctrl_a),
       (OA[9],int_bus_a[9],outctrl_a),
       (OA[8],int_bus_a[8],outctrl_a),
       (OA[7],int_bus_a[7],outctrl_a),
       (OA[6],int_bus_a[6],outctrl_a),
       (OA[5],int_bus_a[5],outctrl_a),
       (OA[4],int_bus_a[4],outctrl_a),
       (OA[3],int_bus_a[3],outctrl_a),
       (OA[2],int_bus_a[2],outctrl_a),
       (OA[1],int_bus_a[1],outctrl_a),
       (OA[0],int_bus_a[0],outctrl_a);

bufif0 (OB[23],int_bus_b[23],outctrl_b),
       (OB[22],int_bus_b[22],outctrl_b),
       (OB[21],int_bus_b[21],outctrl_b),
       (OB[20],int_bus_b[20],outctrl_b),
       (OB[19],int_bus_b[19],outctrl_b),
       (OB[18],int_bus_b[18],outctrl_b),
       (OB[17],int_bus_b[17],outctrl_b),
       (OB[16],int_bus_b[16],outctrl_b),
       (OB[15],int_bus_b[15],outctrl_b),
       (OB[14],int_bus_b[14],outctrl_b),
       (OB[13],int_bus_b[13],outctrl_b),
       (OB[12],int_bus_b[12],outctrl_b),
       (OB[11],int_bus_b[11],outctrl_b),
       (OB[10],int_bus_b[10],outctrl_b),
       (OB[9],int_bus_b[9],outctrl_b),
       (OB[8],int_bus_b[8],outctrl_b),
       (OB[7],int_bus_b[7],outctrl_b),
       (OB[6],int_bus_b[6],outctrl_b),
       (OB[5],int_bus_b[5],outctrl_b),
       (OB[4],int_bus_b[4],outctrl_b),
       (OB[3],int_bus_b[3],outctrl_b),
       (OB[2],int_bus_b[2],outctrl_b),
       (OB[1],int_bus_b[1],outctrl_b),
       (OB[0],int_bus_b[0],outctrl_b);

reg sh_a_error_a;
reg sh_cp_error_a;
reg sh_web_error_a;
reg sh_reb_error_a;
//reg sh_oeb_error_a;
reg sh_csb_error_a;
reg sh_i_error_a;
wire error_a;

reg sh_a_error_b;
reg sh_cp_error_b;
reg sh_web_error_b;
reg sh_reb_error_b;
//reg sh_oeb_error_b;
reg sh_csb_error_b;
reg sh_i_error_b;
wire error_b;

reg cm_cp_error;

rdpb18_128x24_g1_behave u1 (
	.a_state_a(a_state_a),
	.cp_state_a(cp_state_a),
	.web_state_a(web_state_a),
	.reb_state_a(reb_state_a),
	.oeb_state_a(oeb_state_a),
	.csb_state_a(csb_state_a),
	.i_state_a(i_state_a),
	.int_bus_a(int_bus_a),
	.sh_a_error_a(sh_a_error_a),
	.sh_cp_error_a(sh_cp_error_a),
	.sh_web_error_a(sh_web_error_a),
	.sh_reb_error_a(sh_reb_error_a),
//	.sh_oeb_error_a(sh_oeb_error_a),
	.sh_csb_error_a(sh_csb_error_a),
	.sh_i_error_a(sh_i_error_a),
	.outctrl_a(outctrl_a),
	.error_a(error_a),
	
	.a_state_b(a_state_b),
	.cp_state_b(cp_state_b),
	.web_state_b(web_state_b),
	.reb_state_b(reb_state_b),
	.oeb_state_b(oeb_state_b),
	.csb_state_b(csb_state_b),
	.i_state_b(i_state_b),
	.int_bus_b(int_bus_b),
	.sh_a_error_b(sh_a_error_b),
	.sh_cp_error_b(sh_cp_error_b),
	.sh_web_error_b(sh_web_error_b),
	.sh_reb_error_b(sh_reb_error_b),
//	.sh_oeb_error_b(sh_oeb_error_b),
	.sh_csb_error_b(sh_csb_error_b),
	.sh_i_error_b(sh_i_error_b),
	.outctrl_b(outctrl_b),
	.error_b(error_b),

	.confa(confa),
	.confb(confb),
	.cm_cp_error(cm_cp_error)
	);
	
specify
  specparam df    = 1.0,
	    tacr  = 2.70*df,  // rise access time @Cload=0.0pF
	    tacf  = 2.70*df,  // fall access time @Cload=0.0pF
            tcyc  = 6.00*df,  // cycle time
            twh   = 3.00*df,  // minimum clock high time.
	    twl   = 3.00*df,  // minimum clock low time.
	    twes  = 0.75*df,  // web setup time
	    tweh  = 0.35*df,  // web hold time
	    tres  = 0.75*df,  // reb setup time
	    treh  = 0.35*df,  // reb hold time
	    tcs   = 0.75*df,  // csb setup time
	    tch   = 0.35*df,  // csb hold time
	    tadds = 0.50*df,  // address setup time
	    taddh = 0.65*df,  // address hold time
	    tis   = 0.40*df,  // data setup time
	    tih   = 1.30*df,  // data hold time
	    toh   = 1.50*df,  // oeb disbale time
	    tcm   = 4.65*df;  // cp conflict margin (if AA=AB && WEBA=WEBB="L")

  if (!error_a) (CPA => OA[0]) = (tacr,tacf);
  if (!error_a) (CPA => OA[1]) = (tacr,tacf);
  if (!error_a) (CPA => OA[2]) = (tacr,tacf);
  if (!error_a) (CPA => OA[3]) = (tacr,tacf);
  if (!error_a) (CPA => OA[4]) = (tacr,tacf);
  if (!error_a) (CPA => OA[5]) = (tacr,tacf);
  if (!error_a) (CPA => OA[6]) = (tacr,tacf);
  if (!error_a) (CPA => OA[7]) = (tacr,tacf);
  if (!error_a) (CPA => OA[8]) = (tacr,tacf);
  if (!error_a) (CPA => OA[9]) = (tacr,tacf);
  if (!error_a) (CPA => OA[10]) = (tacr,tacf);
  if (!error_a) (CPA => OA[11]) = (tacr,tacf);
  if (!error_a) (CPA => OA[12]) = (tacr,tacf);
  if (!error_a) (CPA => OA[13]) = (tacr,tacf);
  if (!error_a) (CPA => OA[14]) = (tacr,tacf);
  if (!error_a) (CPA => OA[15]) = (tacr,tacf);
  if (!error_a) (CPA => OA[16]) = (tacr,tacf);
  if (!error_a) (CPA => OA[17]) = (tacr,tacf);
  if (!error_a) (CPA => OA[18]) = (tacr,tacf);
  if (!error_a) (CPA => OA[19]) = (tacr,tacf);
  if (!error_a) (CPA => OA[20]) = (tacr,tacf);
  if (!error_a) (CPA => OA[21]) = (tacr,tacf);
  if (!error_a) (CPA => OA[22]) = (tacr,tacf);
  if (!error_a) (CPA => OA[23]) = (tacr,tacf);
  if (!error_a) (OEBA => OA[23]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[22]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[21]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[20]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[19]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[18]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[23]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[22]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[21]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[20]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[19]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[18]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);

  if (!error_b) (CPB => OB[0]) = (tacr,tacf);
  if (!error_b) (CPB => OB[1]) = (tacr,tacf);
  if (!error_b) (CPB => OB[2]) = (tacr,tacf);
  if (!error_b) (CPB => OB[3]) = (tacr,tacf);
  if (!error_b) (CPB => OB[4]) = (tacr,tacf);
  if (!error_b) (CPB => OB[5]) = (tacr,tacf);
  if (!error_b) (CPB => OB[6]) = (tacr,tacf);
  if (!error_b) (CPB => OB[7]) = (tacr,tacf);
  if (!error_b) (CPB => OB[8]) = (tacr,tacf);
  if (!error_b) (CPB => OB[9]) = (tacr,tacf);
  if (!error_b) (CPB => OB[10]) = (tacr,tacf);
  if (!error_b) (CPB => OB[11]) = (tacr,tacf);
  if (!error_b) (CPB => OB[12]) = (tacr,tacf);
  if (!error_b) (CPB => OB[13]) = (tacr,tacf);
  if (!error_b) (CPB => OB[14]) = (tacr,tacf);
  if (!error_b) (CPB => OB[15]) = (tacr,tacf);
  if (!error_b) (CPB => OB[16]) = (tacr,tacf);
  if (!error_b) (CPB => OB[17]) = (tacr,tacf);
  if (!error_b) (CPB => OB[18]) = (tacr,tacf);
  if (!error_b) (CPB => OB[19]) = (tacr,tacf);
  if (!error_b) (CPB => OB[20]) = (tacr,tacf);
  if (!error_b) (CPB => OB[21]) = (tacr,tacf);
  if (!error_b) (CPB => OB[22]) = (tacr,tacf);
  if (!error_b) (CPB => OB[23]) = (tacr,tacf);
  if (!error_b) (OEBB => OB[23]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[22]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[21]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[20]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[19]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[18]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[23]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[22]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[21]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[20]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[19]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[18]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);

  $setup(posedge WEBA,posedge CPA,twes,sh_web_error_a);
  $setup(negedge WEBA,posedge CPA,twes,sh_web_error_a);
  $hold(posedge CPA,negedge WEBA,tweh,sh_web_error_a);
  $hold(posedge CPA,posedge WEBA,tweh,sh_web_error_a);
  $setup(posedge REBA,posedge CPA,tres,sh_reb_error_a);
  $setup(negedge REBA,posedge CPA,tres,sh_reb_error_a);
  $hold(posedge CPA,posedge REBA,treh,sh_reb_error_a);
  $hold(posedge CPA,negedge REBA,treh,sh_reb_error_a);
//  $setup(posedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $setup(negedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $hold(posedge CPA,posedge OEBA,toeh,sh_oeb_error_a);
//  $hold(posedge CPA,negedge OEBA,toeh,sh_oeb_error_a);
  $setup(posedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[0],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[0],taddh,sh_a_error_a);
  $setup(posedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[1],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[1],taddh,sh_a_error_a);
  $setup(posedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[2],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[2],taddh,sh_a_error_a);
  $setup(posedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[3],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[3],taddh,sh_a_error_a);
  $setup(posedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[4],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[4],taddh,sh_a_error_a);
  $setup(posedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[5],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[5],taddh,sh_a_error_a);
  $setup(posedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[6],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[6],taddh,sh_a_error_a);
  $setup(posedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $setup(negedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $hold(posedge CPA,posedge CSBA,tch,sh_csb_error_a);
  $hold(posedge CPA,negedge CSBA,tch,sh_csb_error_a);
  $setup(posedge IA[0],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[0],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[0],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[0],tih,sh_i_error_a);
  $setup(posedge IA[1],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[1],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[1],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[1],tih,sh_i_error_a);
  $setup(posedge IA[2],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[2],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[2],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[2],tih,sh_i_error_a);
  $setup(posedge IA[3],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[3],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[3],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[3],tih,sh_i_error_a);
  $setup(posedge IA[4],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[4],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[4],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[4],tih,sh_i_error_a);
  $setup(posedge IA[5],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[5],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[5],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[5],tih,sh_i_error_a);
  $setup(posedge IA[6],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[6],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[6],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[6],tih,sh_i_error_a);
  $setup(posedge IA[7],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[7],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[7],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[7],tih,sh_i_error_a);
  $setup(posedge IA[8],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[8],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[8],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[8],tih,sh_i_error_a);
  $setup(posedge IA[9],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[9],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[9],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[9],tih,sh_i_error_a);
  $setup(posedge IA[10],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[10],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[10],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[10],tih,sh_i_error_a);
  $setup(posedge IA[11],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[11],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[11],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[11],tih,sh_i_error_a);
  $setup(posedge IA[12],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[12],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[12],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[12],tih,sh_i_error_a);
  $setup(posedge IA[13],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[13],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[13],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[13],tih,sh_i_error_a);
  $setup(posedge IA[14],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[14],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[14],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[14],tih,sh_i_error_a);
  $setup(posedge IA[15],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[15],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[15],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[15],tih,sh_i_error_a);
  $setup(posedge IA[16],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[16],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[16],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[16],tih,sh_i_error_a);
  $setup(posedge IA[17],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[17],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[17],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[17],tih,sh_i_error_a);
  $setup(posedge IA[18],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[18],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[18],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[18],tih,sh_i_error_a);
  $setup(posedge IA[19],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[19],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[19],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[19],tih,sh_i_error_a);
  $setup(posedge IA[20],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[20],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[20],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[20],tih,sh_i_error_a);
  $setup(posedge IA[21],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[21],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[21],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[21],tih,sh_i_error_a);
  $setup(posedge IA[22],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[22],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[22],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[22],tih,sh_i_error_a);
  $setup(posedge IA[23],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[23],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[23],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[23],tih,sh_i_error_a);
  $width(posedge CPA,twh,0,sh_cp_error_a);
  $width(negedge CPA,twl,0,sh_cp_error_a);
  $period(posedge CPA,tcyc,sh_cp_error_a);
  $period(negedge CPA,tcyc);

  $setup(posedge WEBB,posedge CPB,twes,sh_web_error_b);
  $setup(negedge WEBB,posedge CPB,twes,sh_web_error_b);
  $hold(posedge CPB,negedge WEBB,tweh,sh_web_error_b);
  $hold(posedge CPB,posedge WEBB,tweh,sh_web_error_b);
  $setup(posedge REBB,posedge CPB,tres,sh_reb_error_b);
  $setup(negedge REBB,posedge CPB,tres,sh_reb_error_b);
  $hold(posedge CPB,posedge REBB,treh,sh_reb_error_b);
  $hold(posedge CPB,negedge REBB,treh,sh_reb_error_b);
//  $setup(posedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $setup(negedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $hold(posedge CPB,posedge OEBB,toeh,sh_oeb_error_b);
//  $hold(posedge CPB,negedge OEBB,toeh,sh_oeb_error_b);
  $setup(posedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[0],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[0],taddh,sh_a_error_b);
  $setup(posedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[1],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[1],taddh,sh_a_error_b);
  $setup(posedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[2],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[2],taddh,sh_a_error_b);
  $setup(posedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[3],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[3],taddh,sh_a_error_b);
  $setup(posedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[4],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[4],taddh,sh_a_error_b);
  $setup(posedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[5],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[5],taddh,sh_a_error_b);
  $setup(posedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[6],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[6],taddh,sh_a_error_b);
  $setup(posedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $setup(negedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $hold(posedge CPB,posedge CSBB,tch,sh_csb_error_b);
  $hold(posedge CPB,negedge CSBB,tch,sh_csb_error_b);
  $setup(posedge IB[0],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[0],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[0],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[0],tih,sh_i_error_b);
  $setup(posedge IB[1],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[1],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[1],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[1],tih,sh_i_error_b);
  $setup(posedge IB[2],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[2],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[2],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[2],tih,sh_i_error_b);
  $setup(posedge IB[3],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[3],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[3],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[3],tih,sh_i_error_b);
  $setup(posedge IB[4],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[4],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[4],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[4],tih,sh_i_error_b);
  $setup(posedge IB[5],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[5],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[5],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[5],tih,sh_i_error_b);
  $setup(posedge IB[6],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[6],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[6],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[6],tih,sh_i_error_b);
  $setup(posedge IB[7],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[7],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[7],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[7],tih,sh_i_error_b);
  $setup(posedge IB[8],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[8],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[8],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[8],tih,sh_i_error_b);
  $setup(posedge IB[9],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[9],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[9],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[9],tih,sh_i_error_b);
  $setup(posedge IB[10],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[10],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[10],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[10],tih,sh_i_error_b);
  $setup(posedge IB[11],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[11],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[11],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[11],tih,sh_i_error_b);
  $setup(posedge IB[12],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[12],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[12],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[12],tih,sh_i_error_b);
  $setup(posedge IB[13],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[13],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[13],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[13],tih,sh_i_error_b);
  $setup(posedge IB[14],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[14],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[14],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[14],tih,sh_i_error_b);
  $setup(posedge IB[15],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[15],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[15],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[15],tih,sh_i_error_b);
  $setup(posedge IB[16],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[16],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[16],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[16],tih,sh_i_error_b);
  $setup(posedge IB[17],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[17],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[17],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[17],tih,sh_i_error_b);
  $setup(posedge IB[18],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[18],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[18],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[18],tih,sh_i_error_b);
  $setup(posedge IB[19],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[19],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[19],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[19],tih,sh_i_error_b);
  $setup(posedge IB[20],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[20],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[20],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[20],tih,sh_i_error_b);
  $setup(posedge IB[21],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[21],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[21],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[21],tih,sh_i_error_b);
  $setup(posedge IB[22],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[22],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[22],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[22],tih,sh_i_error_b);
  $setup(posedge IB[23],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[23],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[23],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[23],tih,sh_i_error_b);
  $width(posedge CPB,twh,0,sh_cp_error_b);
  $width(negedge CPB,twl,0,sh_cp_error_b);
  $period(posedge CPB,tcyc,sh_cp_error_b);
  $period(negedge CPB,tcyc);
  
  $setup(posedge confa,posedge confb,tcm,cm_cp_error);
  $setup(posedge confb,posedge confa,tcm,cm_cp_error);
  $hold(posedge confa,posedge confb,tcm,cm_cp_error);
  $hold(posedge confb,posedge confa,tcm,cm_cp_error);

endspecify

`undef numaddr
`undef numout
`undef worddepth
`undef verbose
endmodule
`nosuppress_faults
`disable_portfaults
`endcelldefine

`timescale 1ns/10ps
module rdpb18_128x32_g1_behave(
	a_state_a,
	cp_state_a,
	web_state_a,
	reb_state_a,
	oeb_state_a,
	csb_state_a,
	i_state_a,
	int_bus_a,
	sh_a_error_a,
	sh_cp_error_a,
	sh_web_error_a,
	sh_reb_error_a,
//	sh_oeb_error_a,
	sh_csb_error_a,
	sh_i_error_a,
	outctrl_a,
	error_a,
	a_state_b,
	cp_state_b,
	web_state_b,
	reb_state_b,
	oeb_state_b,
	csb_state_b,
	i_state_b,
	int_bus_b,
	sh_a_error_b,
	sh_cp_error_b,
	sh_web_error_b,
	sh_reb_error_b,
//	sh_oeb_error_b,
	sh_csb_error_b,
	sh_i_error_b,
	outctrl_b,
	error_b,
	confa,
	confb,
	cm_cp_error
	);

`define numaddr 7
`define numout 32
`define worddepth 128

`define verbose 2
`ifdef verbose_0
`undef verbose
`define verbose 0
`else
`endif
`ifdef verbose_1
`undef verbose
`define  verbose 1
`endif
`ifdef verbose_2
`undef verbose
`define verbose 2
`endif

input [`numaddr-1:0] a_state_a;
input cp_state_a;
input web_state_a;
input reb_state_a;
input oeb_state_a;
input csb_state_a;
input [`numout-1:0] i_state_a;
output [`numout-1:0] int_bus_a;
input sh_a_error_a;
input sh_web_error_a;
input sh_reb_error_a;
//input sh_oeb_error_a;
input sh_cp_error_a;
input sh_csb_error_a;
input sh_i_error_a;
output outctrl_a;
output error_a;

input [`numaddr-1:0] a_state_b;
input cp_state_b;
input web_state_b;
input reb_state_b;
input oeb_state_b;
input csb_state_b;
input [`numout-1:0] i_state_b;
output [`numout-1:0] int_bus_b;
input sh_a_error_b;
input sh_web_error_b;
input sh_reb_error_b;
//input sh_oeb_error_b;
input sh_cp_error_b;
input sh_csb_error_b;
input sh_i_error_b;
output outctrl_b;
output error_b;

output confa;
output confb;
input cm_cp_error;

reg [`numout-1:0] memory[`worddepth-1:0];
reg [`numout-1:0] int_bus_a;
reg outctrl_a;
reg error_a;
reg web_reg_a;
reg reb_reg_a;
reg oeb_reg_a;
reg csb_reg_a;
reg [`numaddr-1:0] a_reg_a;
reg [`numout-1:0] i_reg_a;
reg [`numout-1:0] out_bus_a;
integer n;
integer address_a;

reg [`numout-1:0] int_bus_b;
reg outctrl_b;
reg error_b;
reg web_reg_b;
reg reb_reg_b;
reg oeb_reg_b;
reg csb_reg_b;
reg [`numaddr-1:0] a_reg_b;
reg [`numout-1:0] i_reg_b;
reg [`numout-1:0] out_bus_b;
integer address_b;

reg confa;
reg confb;

initial
begin : initialize
  error_a = 1'b0;
  web_reg_a = 1'bx;
  reb_reg_a = 1'bx;
  oeb_reg_a = 1'bx;
  csb_reg_a = 1'bx;
  a_reg_a = `numaddr'bx;
  i_reg_a = `numout'bx;
  int_bus_a = `numout'bx;
  out_bus_a = `numout'bx;
  error_b = 1'b0;
  web_reg_b = 1'bx;
  reb_reg_b = 1'bx;
  oeb_reg_b = 1'bx;
  csb_reg_b = 1'bx;
  a_reg_b = `numaddr'bx;
  i_reg_b = `numout'bx;
  int_bus_b = `numout'bx;
  out_bus_b = `numout'bx;
  confa = 1'b0;
  confb = 1'b0;
  for (n=0; n < `worddepth; n = n + 1)
    memory[n] = `numout'bx;
end

task memoryerror_a;
  begin
    if (`verbose == 2)
    begin
      if (address_a == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_a] = `numout'bx;
      end
    end
  end
endtask

task memoryerror_b;
  begin
    if (`verbose == 2)
    begin
      if (address_b == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_b] = `numout'bx;
      end
    end
  end
endtask

task warning;
  input [1024:1] msg;
  begin
    if ($realtime != 0 && `verbose != 0)
    begin
      $display("%.1f : %m : %0s",$realtime,msg);
    end
  end
endtask

always @(negedge cp_state_a)
begin
  confa = 0;
end

always @(negedge cp_state_b)
begin
  confb = 0;
end

always @(cp_state_a or csb_state_a)
begin
  if ((cp_state_a === 1'bx || cp_state_a === 1'bz) && csb_state_a === 1'b0)
  begin
    warning("CPA is unknown.");
    address_a = -1;
    memoryerror_a;
    int_bus_a = `numout'bx;
    error_a = 1;
  end
end

always @(cp_state_b or csb_state_b)
begin
  if ((cp_state_b === 1'bx || cp_state_b === 1'bz) && csb_state_b === 1'b0)
  begin
    warning("CPB is unknown.");
    address_b = -1;
    memoryerror_b;
    int_bus_b = `numout'bx;
    error_b = 1;
  end
end

always @(oeb_state_a or csb_state_a)
begin
  outctrl_a = oeb_state_a | csb_state_a;
end

always @(oeb_state_b or csb_state_b)
begin
  outctrl_b = oeb_state_b | csb_state_b;
end

always @(posedge cp_state_a)
begin : ck_active_edge_a
  web_reg_a = web_state_a;
  reb_reg_a = reb_state_a;
  oeb_reg_a = oeb_state_a;
  csb_reg_a = csb_state_a;
  a_reg_a = a_state_a;
  i_reg_a = i_state_a;

  if ((csb_reg_a === 1'bx || csb_reg_a === 1'bz) && web_reg_a != 1'b1)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((web_reg_a === 1'bx || web_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((oeb_reg_a === 1'bx || oeb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((reb_reg_a === 1'bx || reb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ( ^a_reg_a === 1'bx || ^a_reg_a === 1'bz)
  begin
    address_a = -1;
    error_a = 1;
    warning("AA is unknown.");
    if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
    begin
      memoryerror_a;
    end
  end

  else if (address_a >= `worddepth)
  begin
    warning("AA is out of range.");
    error_a = 1;
  end

  else
  begin
    address_a = a_reg_a;
    error_a = 0;
  end

  if (!error_a)
  begin
    if (csb_reg_a === 1'b0)
    begin
      if (web_reg_a === 1'b0 && reb_reg_a === 1'b1)
      begin
	memory[address_a] = i_reg_a;
      end
      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b0)
      begin
        int_bus_a <= memory[address_a];
      end
      else if (web_reg_a === 1'b0 && reb_reg_a === 1'b0)
      begin
	memory[address_a] = i_reg_a;
        int_bus_a = i_reg_a;
      end
//      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b1)
//      begin
//	warning("both WEBA and REBA are not active.");
//      end
    end
  end
end

always @(posedge cp_state_b)
begin : ck_active_edge_b
  web_reg_b = web_state_b;
  reb_reg_b = reb_state_b;
  oeb_reg_b = oeb_state_b;
  csb_reg_b = csb_state_b;
  a_reg_b = a_state_b;
  i_reg_b = i_state_b;

  if ((csb_reg_b === 1'bx || csb_reg_b === 1'bz) && web_reg_b != 1'b1)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ((web_reg_b === 1'bx || web_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((oeb_reg_b === 1'bx || oeb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((reb_reg_b === 1'bx || reb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ( ^a_reg_b === 1'bx || ^a_reg_b === 1'bz)
  begin
    address_b = -1;
    error_b = 1;
    warning("AB is unknown.");
    if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
    begin
      memoryerror_b;
    end
  end

  else if (address_b >= `worddepth)
  begin
    warning("AB is out of range.");
    error_b = 1;
  end

  else
  begin
    address_b = a_reg_b;
    error_b = 0;
  end

  if (!error_b)
  begin
    if (csb_reg_b === 1'b0)
    begin
      if (web_reg_b === 1'b0 && reb_reg_b === 1'b1)
      begin
	memory[address_b] = i_reg_b;
      end
      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b0)
      begin
        int_bus_b <= memory[address_b];
      end
      else if (web_reg_b === 1'b0 && reb_reg_b === 1'b0)
      begin
	memory[address_b] = i_reg_b;
        int_bus_b = i_reg_b;
      end
//      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b1)
//      begin
//	warning("both WEBB and REBB are not active.");
//      end
    end
  end
end

always @(posedge cp_state_a)
begin
  if (a_state_a == a_state_b &&
//    web_state_a === 1'b0 &&
      csb_state_a === 1'b0 &&
      ~(web_state_a === 1'b1 && reb_state_a === 1'b1))
  begin
    confa = 1'b1;
  end
  else
  begin
    confa = 1'b0;
  end
end

always @(posedge cp_state_b)
begin
  if (a_state_a == a_state_b &&
//    web_state_b === 1'b0 &&
      csb_state_b === 1'b0 &&
      ~(web_state_b === 1'b1 && reb_state_b === 1'b1))
  begin
    confb = 1'b1;
  end
  else
  begin
    confb = 1'b0;
  end
end

always @(cm_cp_error)
begin : Write_conflict_Error
  if (reb_state_a === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_a = `numout'bx;
  end
  if (reb_state_b === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_b = `numout'bx;
  end
  if (web_state_a === 1'b0 && web_state_b === 1'b0)
  begin
    address_a = -1;
    address_b = -1;
    memoryerror_a;
  end
end

always @(sh_cp_error_a)
begin : setup_ck_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_csb_error_a)
begin : setup_csb_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_a_error_a)
begin : setuphold_address_error_a
  if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_i_error_a)
begin : setuphold_i_error_a
  if (web_state_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_web_error_a)
begin : setuphold_web_error_a
  if (csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_reb_error_a)
begin : setuphold_reb_error_a
  if (csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
  end
end

//always @(sh_oeb_error_a)
//begin : setuphold_oeb_error_a
//  if (csb_reg_a === 1'b0)
//  begin
//    #0.01 int_bus_a = `numout'bx;
//  end
//end

always @(sh_cp_error_b)
begin : setup_ck_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_csb_error_b)
begin : setup_csb_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_a_error_b)
begin : setuphold_address_error_b
  if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_i_error_b)
begin : setuphold_i_error_b
  if (web_state_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_web_error_b)
begin : setuphold_web_error_b
  if (csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_reb_error_b)
begin : setuphold_reb_error_b
  if (csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
  end
end

//always @(sh_oeb_error_b)
//begin : setuphold_oeb_error_b
//  if (csb_reg_b === 1'b0)
//  begin
//    #0.01 int_bus_b = `numout'bx;
//  end
//end

endmodule

`celldefine
`suppress_faults
`enable_portfaults

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

wire [`numaddr-1:0] AA;
wire CPA;
wire WEBA;
wire REBA;
wire OEBA;
wire CSBA;
wire [`numout-1:0] IA;
wire [`numout-1:0] OA;
wire [`numaddr-1:0] a_state_a;
wire cp_state_a;
wire web_state_a;
wire reb_state_a;
wire oeb_state_a;
wire csb_state_a;
wire [`numout-1:0] i_state_a;
wire [`numout-1:0] int_bus_a;

wire [`numaddr-1:0] AB;
wire CPB;
wire WEBB;
wire REBB;
wire OEBB;
wire CSBB;
wire [`numout-1:0] IB;
wire [`numout-1:0] OB;
wire [`numaddr-1:0] a_state_b;
wire cp_state_b;
wire web_state_b;
wire reb_state_b;
wire oeb_state_b;
wire csb_state_b;
wire [`numout-1:0] i_state_b;
wire [`numout-1:0] int_bus_b;

buf (a_state_a[6],AA[6]),
    (a_state_a[5],AA[5]),
    (a_state_a[4],AA[4]),
    (a_state_a[3],AA[3]),
    (a_state_a[2],AA[2]),
    (a_state_a[1],AA[1]),
    (a_state_a[0],AA[0]);

buf (a_state_b[6],AB[6]),
    (a_state_b[5],AB[5]),
    (a_state_b[4],AB[4]),
    (a_state_b[3],AB[3]),
    (a_state_b[2],AB[2]),
    (a_state_b[1],AB[1]),
    (a_state_b[0],AB[0]);

buf (cp_state_a,CPA);
buf (web_state_a,WEBA);
buf (reb_state_a,REBA);
buf (oeb_state_a,OEBA);
buf (csb_state_a,CSBA);

buf (cp_state_b,CPB);
buf (web_state_b,WEBB);
buf (reb_state_b,REBB);
buf (oeb_state_b,OEBB);
buf (csb_state_b,CSBB);

buf (i_state_a[31],IA[31]),
    (i_state_a[30],IA[30]),
    (i_state_a[29],IA[29]),
    (i_state_a[28],IA[28]),
    (i_state_a[27],IA[27]),
    (i_state_a[26],IA[26]),
    (i_state_a[25],IA[25]),
    (i_state_a[24],IA[24]),
    (i_state_a[23],IA[23]),
    (i_state_a[22],IA[22]),
    (i_state_a[21],IA[21]),
    (i_state_a[20],IA[20]),
    (i_state_a[19],IA[19]),
    (i_state_a[18],IA[18]),
    (i_state_a[17],IA[17]),
    (i_state_a[16],IA[16]),
    (i_state_a[15],IA[15]),
    (i_state_a[14],IA[14]),
    (i_state_a[13],IA[13]),
    (i_state_a[12],IA[12]),
    (i_state_a[11],IA[11]),
    (i_state_a[10],IA[10]),
    (i_state_a[9],IA[9]),
    (i_state_a[8],IA[8]),
    (i_state_a[7],IA[7]),
    (i_state_a[6],IA[6]),
    (i_state_a[5],IA[5]),
    (i_state_a[4],IA[4]),
    (i_state_a[3],IA[3]),
    (i_state_a[2],IA[2]),
    (i_state_a[1],IA[1]),
    (i_state_a[0],IA[0]);

buf (i_state_b[31],IB[31]),
    (i_state_b[30],IB[30]),
    (i_state_b[29],IB[29]),
    (i_state_b[28],IB[28]),
    (i_state_b[27],IB[27]),
    (i_state_b[26],IB[26]),
    (i_state_b[25],IB[25]),
    (i_state_b[24],IB[24]),
    (i_state_b[23],IB[23]),
    (i_state_b[22],IB[22]),
    (i_state_b[21],IB[21]),
    (i_state_b[20],IB[20]),
    (i_state_b[19],IB[19]),
    (i_state_b[18],IB[18]),
    (i_state_b[17],IB[17]),
    (i_state_b[16],IB[16]),
    (i_state_b[15],IB[15]),
    (i_state_b[14],IB[14]),
    (i_state_b[13],IB[13]),
    (i_state_b[12],IB[12]),
    (i_state_b[11],IB[11]),
    (i_state_b[10],IB[10]),
    (i_state_b[9],IB[9]),
    (i_state_b[8],IB[8]),
    (i_state_b[7],IB[7]),
    (i_state_b[6],IB[6]),
    (i_state_b[5],IB[5]),
    (i_state_b[4],IB[4]),
    (i_state_b[3],IB[3]),
    (i_state_b[2],IB[2]),
    (i_state_b[1],IB[1]),
    (i_state_b[0],IB[0]);

bufif0 (OA[31],int_bus_a[31],outctrl_a),
       (OA[30],int_bus_a[30],outctrl_a),
       (OA[29],int_bus_a[29],outctrl_a),
       (OA[28],int_bus_a[28],outctrl_a),
       (OA[27],int_bus_a[27],outctrl_a),
       (OA[26],int_bus_a[26],outctrl_a),
       (OA[25],int_bus_a[25],outctrl_a),
       (OA[24],int_bus_a[24],outctrl_a),
       (OA[23],int_bus_a[23],outctrl_a),
       (OA[22],int_bus_a[22],outctrl_a),
       (OA[21],int_bus_a[21],outctrl_a),
       (OA[20],int_bus_a[20],outctrl_a),
       (OA[19],int_bus_a[19],outctrl_a),
       (OA[18],int_bus_a[18],outctrl_a),
       (OA[17],int_bus_a[17],outctrl_a),
       (OA[16],int_bus_a[16],outctrl_a),
       (OA[15],int_bus_a[15],outctrl_a),
       (OA[14],int_bus_a[14],outctrl_a),
       (OA[13],int_bus_a[13],outctrl_a),
       (OA[12],int_bus_a[12],outctrl_a),
       (OA[11],int_bus_a[11],outctrl_a),
       (OA[10],int_bus_a[10],outctrl_a),
       (OA[9],int_bus_a[9],outctrl_a),
       (OA[8],int_bus_a[8],outctrl_a),
       (OA[7],int_bus_a[7],outctrl_a),
       (OA[6],int_bus_a[6],outctrl_a),
       (OA[5],int_bus_a[5],outctrl_a),
       (OA[4],int_bus_a[4],outctrl_a),
       (OA[3],int_bus_a[3],outctrl_a),
       (OA[2],int_bus_a[2],outctrl_a),
       (OA[1],int_bus_a[1],outctrl_a),
       (OA[0],int_bus_a[0],outctrl_a);

bufif0 (OB[31],int_bus_b[31],outctrl_b),
       (OB[30],int_bus_b[30],outctrl_b),
       (OB[29],int_bus_b[29],outctrl_b),
       (OB[28],int_bus_b[28],outctrl_b),
       (OB[27],int_bus_b[27],outctrl_b),
       (OB[26],int_bus_b[26],outctrl_b),
       (OB[25],int_bus_b[25],outctrl_b),
       (OB[24],int_bus_b[24],outctrl_b),
       (OB[23],int_bus_b[23],outctrl_b),
       (OB[22],int_bus_b[22],outctrl_b),
       (OB[21],int_bus_b[21],outctrl_b),
       (OB[20],int_bus_b[20],outctrl_b),
       (OB[19],int_bus_b[19],outctrl_b),
       (OB[18],int_bus_b[18],outctrl_b),
       (OB[17],int_bus_b[17],outctrl_b),
       (OB[16],int_bus_b[16],outctrl_b),
       (OB[15],int_bus_b[15],outctrl_b),
       (OB[14],int_bus_b[14],outctrl_b),
       (OB[13],int_bus_b[13],outctrl_b),
       (OB[12],int_bus_b[12],outctrl_b),
       (OB[11],int_bus_b[11],outctrl_b),
       (OB[10],int_bus_b[10],outctrl_b),
       (OB[9],int_bus_b[9],outctrl_b),
       (OB[8],int_bus_b[8],outctrl_b),
       (OB[7],int_bus_b[7],outctrl_b),
       (OB[6],int_bus_b[6],outctrl_b),
       (OB[5],int_bus_b[5],outctrl_b),
       (OB[4],int_bus_b[4],outctrl_b),
       (OB[3],int_bus_b[3],outctrl_b),
       (OB[2],int_bus_b[2],outctrl_b),
       (OB[1],int_bus_b[1],outctrl_b),
       (OB[0],int_bus_b[0],outctrl_b);

reg sh_a_error_a;
reg sh_cp_error_a;
reg sh_web_error_a;
reg sh_reb_error_a;
//reg sh_oeb_error_a;
reg sh_csb_error_a;
reg sh_i_error_a;
wire error_a;

reg sh_a_error_b;
reg sh_cp_error_b;
reg sh_web_error_b;
reg sh_reb_error_b;
//reg sh_oeb_error_b;
reg sh_csb_error_b;
reg sh_i_error_b;
wire error_b;

reg cm_cp_error;

rdpb18_128x32_g1_behave u1 (
	.a_state_a(a_state_a),
	.cp_state_a(cp_state_a),
	.web_state_a(web_state_a),
	.reb_state_a(reb_state_a),
	.oeb_state_a(oeb_state_a),
	.csb_state_a(csb_state_a),
	.i_state_a(i_state_a),
	.int_bus_a(int_bus_a),
	.sh_a_error_a(sh_a_error_a),
	.sh_cp_error_a(sh_cp_error_a),
	.sh_web_error_a(sh_web_error_a),
	.sh_reb_error_a(sh_reb_error_a),
//	.sh_oeb_error_a(sh_oeb_error_a),
	.sh_csb_error_a(sh_csb_error_a),
	.sh_i_error_a(sh_i_error_a),
	.outctrl_a(outctrl_a),
	.error_a(error_a),
	
	.a_state_b(a_state_b),
	.cp_state_b(cp_state_b),
	.web_state_b(web_state_b),
	.reb_state_b(reb_state_b),
	.oeb_state_b(oeb_state_b),
	.csb_state_b(csb_state_b),
	.i_state_b(i_state_b),
	.int_bus_b(int_bus_b),
	.sh_a_error_b(sh_a_error_b),
	.sh_cp_error_b(sh_cp_error_b),
	.sh_web_error_b(sh_web_error_b),
	.sh_reb_error_b(sh_reb_error_b),
//	.sh_oeb_error_b(sh_oeb_error_b),
	.sh_csb_error_b(sh_csb_error_b),
	.sh_i_error_b(sh_i_error_b),
	.outctrl_b(outctrl_b),
	.error_b(error_b),

	.confa(confa),
	.confb(confb),
	.cm_cp_error(cm_cp_error)
	);
	
specify
  specparam df    = 1.0,
	    tacr  = 2.70*df,  // rise access time @Cload=0.0pF
	    tacf  = 2.70*df,  // fall access time @Cload=0.0pF
            tcyc  = 6.00*df,  // cycle time
            twh   = 3.00*df,  // minimum clock high time.
	    twl   = 3.00*df,  // minimum clock low time.
	    twes  = 0.75*df,  // web setup time
	    tweh  = 0.35*df,  // web hold time
	    tres  = 0.75*df,  // reb setup time
	    treh  = 0.35*df,  // reb hold time
	    tcs   = 0.75*df,  // csb setup time
	    tch   = 0.35*df,  // csb hold time
	    tadds = 0.50*df,  // address setup time
	    taddh = 0.65*df,  // address hold time
	    tis   = 0.40*df,  // data setup time
	    tih   = 1.30*df,  // data hold time
	    toh   = 1.50*df,  // oeb disbale time
	    tcm   = 4.65*df;  // cp conflict margin (if AA=AB && WEBA=WEBB="L")

  if (!error_a) (CPA => OA[0]) = (tacr,tacf);
  if (!error_a) (CPA => OA[1]) = (tacr,tacf);
  if (!error_a) (CPA => OA[2]) = (tacr,tacf);
  if (!error_a) (CPA => OA[3]) = (tacr,tacf);
  if (!error_a) (CPA => OA[4]) = (tacr,tacf);
  if (!error_a) (CPA => OA[5]) = (tacr,tacf);
  if (!error_a) (CPA => OA[6]) = (tacr,tacf);
  if (!error_a) (CPA => OA[7]) = (tacr,tacf);
  if (!error_a) (CPA => OA[8]) = (tacr,tacf);
  if (!error_a) (CPA => OA[9]) = (tacr,tacf);
  if (!error_a) (CPA => OA[10]) = (tacr,tacf);
  if (!error_a) (CPA => OA[11]) = (tacr,tacf);
  if (!error_a) (CPA => OA[12]) = (tacr,tacf);
  if (!error_a) (CPA => OA[13]) = (tacr,tacf);
  if (!error_a) (CPA => OA[14]) = (tacr,tacf);
  if (!error_a) (CPA => OA[15]) = (tacr,tacf);
  if (!error_a) (CPA => OA[16]) = (tacr,tacf);
  if (!error_a) (CPA => OA[17]) = (tacr,tacf);
  if (!error_a) (CPA => OA[18]) = (tacr,tacf);
  if (!error_a) (CPA => OA[19]) = (tacr,tacf);
  if (!error_a) (CPA => OA[20]) = (tacr,tacf);
  if (!error_a) (CPA => OA[21]) = (tacr,tacf);
  if (!error_a) (CPA => OA[22]) = (tacr,tacf);
  if (!error_a) (CPA => OA[23]) = (tacr,tacf);
  if (!error_a) (CPA => OA[24]) = (tacr,tacf);
  if (!error_a) (CPA => OA[25]) = (tacr,tacf);
  if (!error_a) (CPA => OA[26]) = (tacr,tacf);
  if (!error_a) (CPA => OA[27]) = (tacr,tacf);
  if (!error_a) (CPA => OA[28]) = (tacr,tacf);
  if (!error_a) (CPA => OA[29]) = (tacr,tacf);
  if (!error_a) (CPA => OA[30]) = (tacr,tacf);
  if (!error_a) (CPA => OA[31]) = (tacr,tacf);
  if (!error_a) (OEBA => OA[31]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[30]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[29]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[28]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[27]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[26]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[25]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[24]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[23]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[22]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[21]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[20]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[19]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[18]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[31]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[30]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[29]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[28]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[27]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[26]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[25]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[24]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[23]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[22]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[21]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[20]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[19]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[18]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);

  if (!error_b) (CPB => OB[0]) = (tacr,tacf);
  if (!error_b) (CPB => OB[1]) = (tacr,tacf);
  if (!error_b) (CPB => OB[2]) = (tacr,tacf);
  if (!error_b) (CPB => OB[3]) = (tacr,tacf);
  if (!error_b) (CPB => OB[4]) = (tacr,tacf);
  if (!error_b) (CPB => OB[5]) = (tacr,tacf);
  if (!error_b) (CPB => OB[6]) = (tacr,tacf);
  if (!error_b) (CPB => OB[7]) = (tacr,tacf);
  if (!error_b) (CPB => OB[8]) = (tacr,tacf);
  if (!error_b) (CPB => OB[9]) = (tacr,tacf);
  if (!error_b) (CPB => OB[10]) = (tacr,tacf);
  if (!error_b) (CPB => OB[11]) = (tacr,tacf);
  if (!error_b) (CPB => OB[12]) = (tacr,tacf);
  if (!error_b) (CPB => OB[13]) = (tacr,tacf);
  if (!error_b) (CPB => OB[14]) = (tacr,tacf);
  if (!error_b) (CPB => OB[15]) = (tacr,tacf);
  if (!error_b) (CPB => OB[16]) = (tacr,tacf);
  if (!error_b) (CPB => OB[17]) = (tacr,tacf);
  if (!error_b) (CPB => OB[18]) = (tacr,tacf);
  if (!error_b) (CPB => OB[19]) = (tacr,tacf);
  if (!error_b) (CPB => OB[20]) = (tacr,tacf);
  if (!error_b) (CPB => OB[21]) = (tacr,tacf);
  if (!error_b) (CPB => OB[22]) = (tacr,tacf);
  if (!error_b) (CPB => OB[23]) = (tacr,tacf);
  if (!error_b) (CPB => OB[24]) = (tacr,tacf);
  if (!error_b) (CPB => OB[25]) = (tacr,tacf);
  if (!error_b) (CPB => OB[26]) = (tacr,tacf);
  if (!error_b) (CPB => OB[27]) = (tacr,tacf);
  if (!error_b) (CPB => OB[28]) = (tacr,tacf);
  if (!error_b) (CPB => OB[29]) = (tacr,tacf);
  if (!error_b) (CPB => OB[30]) = (tacr,tacf);
  if (!error_b) (CPB => OB[31]) = (tacr,tacf);
  if (!error_b) (OEBB => OB[31]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[30]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[29]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[28]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[27]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[26]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[25]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[24]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[23]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[22]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[21]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[20]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[19]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[18]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[31]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[30]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[29]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[28]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[27]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[26]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[25]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[24]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[23]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[22]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[21]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[20]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[19]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[18]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);

  $setup(posedge WEBA,posedge CPA,twes,sh_web_error_a);
  $setup(negedge WEBA,posedge CPA,twes,sh_web_error_a);
  $hold(posedge CPA,negedge WEBA,tweh,sh_web_error_a);
  $hold(posedge CPA,posedge WEBA,tweh,sh_web_error_a);
  $setup(posedge REBA,posedge CPA,tres,sh_reb_error_a);
  $setup(negedge REBA,posedge CPA,tres,sh_reb_error_a);
  $hold(posedge CPA,posedge REBA,treh,sh_reb_error_a);
  $hold(posedge CPA,negedge REBA,treh,sh_reb_error_a);
//  $setup(posedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $setup(negedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $hold(posedge CPA,posedge OEBA,toeh,sh_oeb_error_a);
//  $hold(posedge CPA,negedge OEBA,toeh,sh_oeb_error_a);
  $setup(posedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[0],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[0],taddh,sh_a_error_a);
  $setup(posedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[1],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[1],taddh,sh_a_error_a);
  $setup(posedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[2],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[2],taddh,sh_a_error_a);
  $setup(posedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[3],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[3],taddh,sh_a_error_a);
  $setup(posedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[4],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[4],taddh,sh_a_error_a);
  $setup(posedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[5],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[5],taddh,sh_a_error_a);
  $setup(posedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[6],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[6],taddh,sh_a_error_a);
  $setup(posedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $setup(negedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $hold(posedge CPA,posedge CSBA,tch,sh_csb_error_a);
  $hold(posedge CPA,negedge CSBA,tch,sh_csb_error_a);
  $setup(posedge IA[0],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[0],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[0],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[0],tih,sh_i_error_a);
  $setup(posedge IA[1],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[1],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[1],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[1],tih,sh_i_error_a);
  $setup(posedge IA[2],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[2],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[2],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[2],tih,sh_i_error_a);
  $setup(posedge IA[3],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[3],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[3],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[3],tih,sh_i_error_a);
  $setup(posedge IA[4],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[4],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[4],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[4],tih,sh_i_error_a);
  $setup(posedge IA[5],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[5],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[5],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[5],tih,sh_i_error_a);
  $setup(posedge IA[6],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[6],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[6],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[6],tih,sh_i_error_a);
  $setup(posedge IA[7],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[7],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[7],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[7],tih,sh_i_error_a);
  $setup(posedge IA[8],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[8],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[8],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[8],tih,sh_i_error_a);
  $setup(posedge IA[9],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[9],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[9],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[9],tih,sh_i_error_a);
  $setup(posedge IA[10],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[10],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[10],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[10],tih,sh_i_error_a);
  $setup(posedge IA[11],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[11],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[11],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[11],tih,sh_i_error_a);
  $setup(posedge IA[12],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[12],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[12],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[12],tih,sh_i_error_a);
  $setup(posedge IA[13],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[13],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[13],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[13],tih,sh_i_error_a);
  $setup(posedge IA[14],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[14],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[14],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[14],tih,sh_i_error_a);
  $setup(posedge IA[15],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[15],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[15],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[15],tih,sh_i_error_a);
  $setup(posedge IA[16],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[16],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[16],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[16],tih,sh_i_error_a);
  $setup(posedge IA[17],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[17],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[17],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[17],tih,sh_i_error_a);
  $setup(posedge IA[18],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[18],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[18],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[18],tih,sh_i_error_a);
  $setup(posedge IA[19],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[19],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[19],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[19],tih,sh_i_error_a);
  $setup(posedge IA[20],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[20],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[20],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[20],tih,sh_i_error_a);
  $setup(posedge IA[21],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[21],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[21],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[21],tih,sh_i_error_a);
  $setup(posedge IA[22],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[22],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[22],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[22],tih,sh_i_error_a);
  $setup(posedge IA[23],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[23],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[23],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[23],tih,sh_i_error_a);
  $setup(posedge IA[24],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[24],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[24],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[24],tih,sh_i_error_a);
  $setup(posedge IA[25],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[25],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[25],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[25],tih,sh_i_error_a);
  $setup(posedge IA[26],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[26],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[26],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[26],tih,sh_i_error_a);
  $setup(posedge IA[27],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[27],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[27],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[27],tih,sh_i_error_a);
  $setup(posedge IA[28],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[28],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[28],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[28],tih,sh_i_error_a);
  $setup(posedge IA[29],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[29],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[29],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[29],tih,sh_i_error_a);
  $setup(posedge IA[30],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[30],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[30],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[30],tih,sh_i_error_a);
  $setup(posedge IA[31],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[31],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[31],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[31],tih,sh_i_error_a);
  $width(posedge CPA,twh,0,sh_cp_error_a);
  $width(negedge CPA,twl,0,sh_cp_error_a);
  $period(posedge CPA,tcyc,sh_cp_error_a);
  $period(negedge CPA,tcyc);

  $setup(posedge WEBB,posedge CPB,twes,sh_web_error_b);
  $setup(negedge WEBB,posedge CPB,twes,sh_web_error_b);
  $hold(posedge CPB,negedge WEBB,tweh,sh_web_error_b);
  $hold(posedge CPB,posedge WEBB,tweh,sh_web_error_b);
  $setup(posedge REBB,posedge CPB,tres,sh_reb_error_b);
  $setup(negedge REBB,posedge CPB,tres,sh_reb_error_b);
  $hold(posedge CPB,posedge REBB,treh,sh_reb_error_b);
  $hold(posedge CPB,negedge REBB,treh,sh_reb_error_b);
//  $setup(posedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $setup(negedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $hold(posedge CPB,posedge OEBB,toeh,sh_oeb_error_b);
//  $hold(posedge CPB,negedge OEBB,toeh,sh_oeb_error_b);
  $setup(posedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[0],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[0],taddh,sh_a_error_b);
  $setup(posedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[1],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[1],taddh,sh_a_error_b);
  $setup(posedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[2],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[2],taddh,sh_a_error_b);
  $setup(posedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[3],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[3],taddh,sh_a_error_b);
  $setup(posedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[4],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[4],taddh,sh_a_error_b);
  $setup(posedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[5],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[5],taddh,sh_a_error_b);
  $setup(posedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[6],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[6],taddh,sh_a_error_b);
  $setup(posedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $setup(negedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $hold(posedge CPB,posedge CSBB,tch,sh_csb_error_b);
  $hold(posedge CPB,negedge CSBB,tch,sh_csb_error_b);
  $setup(posedge IB[0],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[0],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[0],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[0],tih,sh_i_error_b);
  $setup(posedge IB[1],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[1],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[1],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[1],tih,sh_i_error_b);
  $setup(posedge IB[2],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[2],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[2],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[2],tih,sh_i_error_b);
  $setup(posedge IB[3],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[3],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[3],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[3],tih,sh_i_error_b);
  $setup(posedge IB[4],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[4],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[4],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[4],tih,sh_i_error_b);
  $setup(posedge IB[5],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[5],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[5],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[5],tih,sh_i_error_b);
  $setup(posedge IB[6],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[6],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[6],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[6],tih,sh_i_error_b);
  $setup(posedge IB[7],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[7],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[7],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[7],tih,sh_i_error_b);
  $setup(posedge IB[8],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[8],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[8],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[8],tih,sh_i_error_b);
  $setup(posedge IB[9],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[9],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[9],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[9],tih,sh_i_error_b);
  $setup(posedge IB[10],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[10],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[10],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[10],tih,sh_i_error_b);
  $setup(posedge IB[11],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[11],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[11],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[11],tih,sh_i_error_b);
  $setup(posedge IB[12],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[12],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[12],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[12],tih,sh_i_error_b);
  $setup(posedge IB[13],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[13],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[13],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[13],tih,sh_i_error_b);
  $setup(posedge IB[14],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[14],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[14],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[14],tih,sh_i_error_b);
  $setup(posedge IB[15],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[15],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[15],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[15],tih,sh_i_error_b);
  $setup(posedge IB[16],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[16],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[16],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[16],tih,sh_i_error_b);
  $setup(posedge IB[17],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[17],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[17],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[17],tih,sh_i_error_b);
  $setup(posedge IB[18],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[18],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[18],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[18],tih,sh_i_error_b);
  $setup(posedge IB[19],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[19],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[19],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[19],tih,sh_i_error_b);
  $setup(posedge IB[20],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[20],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[20],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[20],tih,sh_i_error_b);
  $setup(posedge IB[21],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[21],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[21],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[21],tih,sh_i_error_b);
  $setup(posedge IB[22],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[22],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[22],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[22],tih,sh_i_error_b);
  $setup(posedge IB[23],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[23],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[23],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[23],tih,sh_i_error_b);
  $setup(posedge IB[24],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[24],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[24],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[24],tih,sh_i_error_b);
  $setup(posedge IB[25],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[25],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[25],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[25],tih,sh_i_error_b);
  $setup(posedge IB[26],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[26],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[26],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[26],tih,sh_i_error_b);
  $setup(posedge IB[27],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[27],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[27],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[27],tih,sh_i_error_b);
  $setup(posedge IB[28],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[28],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[28],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[28],tih,sh_i_error_b);
  $setup(posedge IB[29],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[29],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[29],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[29],tih,sh_i_error_b);
  $setup(posedge IB[30],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[30],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[30],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[30],tih,sh_i_error_b);
  $setup(posedge IB[31],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[31],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[31],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[31],tih,sh_i_error_b);
  $width(posedge CPB,twh,0,sh_cp_error_b);
  $width(negedge CPB,twl,0,sh_cp_error_b);
  $period(posedge CPB,tcyc,sh_cp_error_b);
  $period(negedge CPB,tcyc);
  
  $setup(posedge confa,posedge confb,tcm,cm_cp_error);
  $setup(posedge confb,posedge confa,tcm,cm_cp_error);
  $hold(posedge confa,posedge confb,tcm,cm_cp_error);
  $hold(posedge confb,posedge confa,tcm,cm_cp_error);

endspecify

`undef numaddr
`undef numout
`undef worddepth
`undef verbose
endmodule
`nosuppress_faults
`disable_portfaults
`endcelldefine

`timescale 1ns/10ps
module rdpb18_128x8_g1_behave(
	a_state_a,
	cp_state_a,
	web_state_a,
	reb_state_a,
	oeb_state_a,
	csb_state_a,
	i_state_a,
	int_bus_a,
	sh_a_error_a,
	sh_cp_error_a,
	sh_web_error_a,
	sh_reb_error_a,
//	sh_oeb_error_a,
	sh_csb_error_a,
	sh_i_error_a,
	outctrl_a,
	error_a,
	a_state_b,
	cp_state_b,
	web_state_b,
	reb_state_b,
	oeb_state_b,
	csb_state_b,
	i_state_b,
	int_bus_b,
	sh_a_error_b,
	sh_cp_error_b,
	sh_web_error_b,
	sh_reb_error_b,
//	sh_oeb_error_b,
	sh_csb_error_b,
	sh_i_error_b,
	outctrl_b,
	error_b,
	confa,
	confb,
	cm_cp_error
	);

`define numaddr 7
`define numout 8
`define worddepth 128

`define verbose 2
`ifdef verbose_0
`undef verbose
`define verbose 0
`else
`endif
`ifdef verbose_1
`undef verbose
`define  verbose 1
`endif
`ifdef verbose_2
`undef verbose
`define verbose 2
`endif

input [`numaddr-1:0] a_state_a;
input cp_state_a;
input web_state_a;
input reb_state_a;
input oeb_state_a;
input csb_state_a;
input [`numout-1:0] i_state_a;
output [`numout-1:0] int_bus_a;
input sh_a_error_a;
input sh_web_error_a;
input sh_reb_error_a;
//input sh_oeb_error_a;
input sh_cp_error_a;
input sh_csb_error_a;
input sh_i_error_a;
output outctrl_a;
output error_a;

input [`numaddr-1:0] a_state_b;
input cp_state_b;
input web_state_b;
input reb_state_b;
input oeb_state_b;
input csb_state_b;
input [`numout-1:0] i_state_b;
output [`numout-1:0] int_bus_b;
input sh_a_error_b;
input sh_web_error_b;
input sh_reb_error_b;
//input sh_oeb_error_b;
input sh_cp_error_b;
input sh_csb_error_b;
input sh_i_error_b;
output outctrl_b;
output error_b;

output confa;
output confb;
input cm_cp_error;

reg [`numout-1:0] memory[`worddepth-1:0];
reg [`numout-1:0] int_bus_a;
reg outctrl_a;
reg error_a;
reg web_reg_a;
reg reb_reg_a;
reg oeb_reg_a;
reg csb_reg_a;
reg [`numaddr-1:0] a_reg_a;
reg [`numout-1:0] i_reg_a;
reg [`numout-1:0] out_bus_a;
integer n;
integer address_a;

reg [`numout-1:0] int_bus_b;
reg outctrl_b;
reg error_b;
reg web_reg_b;
reg reb_reg_b;
reg oeb_reg_b;
reg csb_reg_b;
reg [`numaddr-1:0] a_reg_b;
reg [`numout-1:0] i_reg_b;
reg [`numout-1:0] out_bus_b;
integer address_b;

reg confa;
reg confb;

initial
begin : initialize
  error_a = 1'b0;
  web_reg_a = 1'bx;
  reb_reg_a = 1'bx;
  oeb_reg_a = 1'bx;
  csb_reg_a = 1'bx;
  a_reg_a = `numaddr'bx;
  i_reg_a = `numout'bx;
  int_bus_a = `numout'bx;
  out_bus_a = `numout'bx;
  error_b = 1'b0;
  web_reg_b = 1'bx;
  reb_reg_b = 1'bx;
  oeb_reg_b = 1'bx;
  csb_reg_b = 1'bx;
  a_reg_b = `numaddr'bx;
  i_reg_b = `numout'bx;
  int_bus_b = `numout'bx;
  out_bus_b = `numout'bx;
  confa = 1'b0;
  confb = 1'b0;
  for (n=0; n < `worddepth; n = n + 1)
    memory[n] = `numout'bx;
end

task memoryerror_a;
  begin
    if (`verbose == 2)
    begin
      if (address_a == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_a] = `numout'bx;
      end
    end
  end
endtask

task memoryerror_b;
  begin
    if (`verbose == 2)
    begin
      if (address_b == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_b] = `numout'bx;
      end
    end
  end
endtask

task warning;
  input [1024:1] msg;
  begin
    if ($realtime != 0 && `verbose != 0)
    begin
      $display("%.1f : %m : %0s",$realtime,msg);
    end
  end
endtask

always @(negedge cp_state_a)
begin
  confa = 0;
end

always @(negedge cp_state_b)
begin
  confb = 0;
end

always @(cp_state_a or csb_state_a)
begin
  if ((cp_state_a === 1'bx || cp_state_a === 1'bz) && csb_state_a === 1'b0)
  begin
    warning("CPA is unknown.");
    address_a = -1;
    memoryerror_a;
    int_bus_a = `numout'bx;
    error_a = 1;
  end
end

always @(cp_state_b or csb_state_b)
begin
  if ((cp_state_b === 1'bx || cp_state_b === 1'bz) && csb_state_b === 1'b0)
  begin
    warning("CPB is unknown.");
    address_b = -1;
    memoryerror_b;
    int_bus_b = `numout'bx;
    error_b = 1;
  end
end

always @(oeb_state_a or csb_state_a)
begin
  outctrl_a = oeb_state_a | csb_state_a;
end

always @(oeb_state_b or csb_state_b)
begin
  outctrl_b = oeb_state_b | csb_state_b;
end

always @(posedge cp_state_a)
begin : ck_active_edge_a
  web_reg_a = web_state_a;
  reb_reg_a = reb_state_a;
  oeb_reg_a = oeb_state_a;
  csb_reg_a = csb_state_a;
  a_reg_a = a_state_a;
  i_reg_a = i_state_a;

  if ((csb_reg_a === 1'bx || csb_reg_a === 1'bz) && web_reg_a != 1'b1)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((web_reg_a === 1'bx || web_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((oeb_reg_a === 1'bx || oeb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((reb_reg_a === 1'bx || reb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ( ^a_reg_a === 1'bx || ^a_reg_a === 1'bz)
  begin
    address_a = -1;
    error_a = 1;
    warning("AA is unknown.");
    if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
    begin
      memoryerror_a;
    end
  end

  else if (address_a >= `worddepth)
  begin
    warning("AA is out of range.");
    error_a = 1;
  end

  else
  begin
    address_a = a_reg_a;
    error_a = 0;
  end

  if (!error_a)
  begin
    if (csb_reg_a === 1'b0)
    begin
      if (web_reg_a === 1'b0 && reb_reg_a === 1'b1)
      begin
	memory[address_a] = i_reg_a;
      end
      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b0)
      begin
        int_bus_a <= memory[address_a];
      end
      else if (web_reg_a === 1'b0 && reb_reg_a === 1'b0)
      begin
	memory[address_a] = i_reg_a;
        int_bus_a = i_reg_a;
      end
//      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b1)
//      begin
//	warning("both WEBA and REBA are not active.");
//      end
    end
  end
end

always @(posedge cp_state_b)
begin : ck_active_edge_b
  web_reg_b = web_state_b;
  reb_reg_b = reb_state_b;
  oeb_reg_b = oeb_state_b;
  csb_reg_b = csb_state_b;
  a_reg_b = a_state_b;
  i_reg_b = i_state_b;

  if ((csb_reg_b === 1'bx || csb_reg_b === 1'bz) && web_reg_b != 1'b1)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ((web_reg_b === 1'bx || web_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((oeb_reg_b === 1'bx || oeb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((reb_reg_b === 1'bx || reb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ( ^a_reg_b === 1'bx || ^a_reg_b === 1'bz)
  begin
    address_b = -1;
    error_b = 1;
    warning("AB is unknown.");
    if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
    begin
      memoryerror_b;
    end
  end

  else if (address_b >= `worddepth)
  begin
    warning("AB is out of range.");
    error_b = 1;
  end

  else
  begin
    address_b = a_reg_b;
    error_b = 0;
  end

  if (!error_b)
  begin
    if (csb_reg_b === 1'b0)
    begin
      if (web_reg_b === 1'b0 && reb_reg_b === 1'b1)
      begin
	memory[address_b] = i_reg_b;
      end
      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b0)
      begin
        int_bus_b <= memory[address_b];
      end
      else if (web_reg_b === 1'b0 && reb_reg_b === 1'b0)
      begin
	memory[address_b] = i_reg_b;
        int_bus_b = i_reg_b;
      end
//      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b1)
//      begin
//	warning("both WEBB and REBB are not active.");
//      end
    end
  end
end

always @(posedge cp_state_a)
begin
  if (a_state_a == a_state_b &&
//    web_state_a === 1'b0 &&
      csb_state_a === 1'b0 &&
      ~(web_state_a === 1'b1 && reb_state_a === 1'b1))
  begin
    confa = 1'b1;
  end
  else
  begin
    confa = 1'b0;
  end
end

always @(posedge cp_state_b)
begin
  if (a_state_a == a_state_b &&
//    web_state_b === 1'b0 &&
      csb_state_b === 1'b0 &&
      ~(web_state_b === 1'b1 && reb_state_b === 1'b1))
  begin
    confb = 1'b1;
  end
  else
  begin
    confb = 1'b0;
  end
end

always @(cm_cp_error)
begin : Write_conflict_Error
  if (reb_state_a === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_a = `numout'bx;
  end
  if (reb_state_b === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_b = `numout'bx;
  end
  if (web_state_a === 1'b0 && web_state_b === 1'b0)
  begin
    address_a = -1;
    address_b = -1;
    memoryerror_a;
  end
end  

always @(sh_cp_error_a)
begin : setup_ck_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_csb_error_a)
begin : setup_csb_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_a_error_a)
begin : setuphold_address_error_a
  if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_i_error_a)
begin : setuphold_i_error_a
  if (web_state_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_web_error_a)
begin : setuphold_web_error_a
  if (csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_reb_error_a)
begin : setuphold_reb_error_a
  if (csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
  end
end

//always @(sh_oeb_error_a)
//begin : setuphold_oeb_error_a
//  if (csb_reg_a === 1'b0)
//  begin
//    #0.01 int_bus_a = `numout'bx;
//  end
//end

always @(sh_cp_error_b)
begin : setup_ck_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_csb_error_b)
begin : setup_csb_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_a_error_b)
begin : setuphold_address_error_b
  if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_i_error_b)
begin : setuphold_i_error_b
  if (web_state_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_web_error_b)
begin : setuphold_web_error_b
  if (csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_reb_error_b)
begin : setuphold_reb_error_b
  if (csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
  end
end

//always @(sh_oeb_error_b)
//begin : setuphold_oeb_error_b
//  if (csb_reg_b === 1'b0)
//  begin
//    #0.01 int_bus_b = `numout'bx;
//  end
//end

endmodule

`celldefine
`suppress_faults
`enable_portfaults

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

wire [`numaddr-1:0] AA;
wire CPA;
wire WEBA;
wire REBA;
wire OEBA;
wire CSBA;
wire [`numout-1:0] IA;
wire [`numout-1:0] OA;
wire [`numaddr-1:0] a_state_a;
wire cp_state_a;
wire web_state_a;
wire reb_state_a;
wire oeb_state_a;
wire csb_state_a;
wire [`numout-1:0] i_state_a;
wire [`numout-1:0] int_bus_a;

wire [`numaddr-1:0] AB;
wire CPB;
wire WEBB;
wire REBB;
wire OEBB;
wire CSBB;
wire [`numout-1:0] IB;
wire [`numout-1:0] OB;
wire [`numaddr-1:0] a_state_b;
wire cp_state_b;
wire web_state_b;
wire reb_state_b;
wire oeb_state_b;
wire csb_state_b;
wire [`numout-1:0] i_state_b;
wire [`numout-1:0] int_bus_b;

buf (a_state_a[6],AA[6]),
    (a_state_a[5],AA[5]),
    (a_state_a[4],AA[4]),
    (a_state_a[3],AA[3]),
    (a_state_a[2],AA[2]),
    (a_state_a[1],AA[1]),
    (a_state_a[0],AA[0]);

buf (a_state_b[6],AB[6]),
    (a_state_b[5],AB[5]),
    (a_state_b[4],AB[4]),
    (a_state_b[3],AB[3]),
    (a_state_b[2],AB[2]),
    (a_state_b[1],AB[1]),
    (a_state_b[0],AB[0]);

buf (cp_state_a,CPA);
buf (web_state_a,WEBA);
buf (reb_state_a,REBA);
buf (oeb_state_a,OEBA);
buf (csb_state_a,CSBA);

buf (cp_state_b,CPB);
buf (web_state_b,WEBB);
buf (reb_state_b,REBB);
buf (oeb_state_b,OEBB);
buf (csb_state_b,CSBB);

buf (i_state_a[7],IA[7]),
    (i_state_a[6],IA[6]),
    (i_state_a[5],IA[5]),
    (i_state_a[4],IA[4]),
    (i_state_a[3],IA[3]),
    (i_state_a[2],IA[2]),
    (i_state_a[1],IA[1]),
    (i_state_a[0],IA[0]);

buf (i_state_b[7],IB[7]),
    (i_state_b[6],IB[6]),
    (i_state_b[5],IB[5]),
    (i_state_b[4],IB[4]),
    (i_state_b[3],IB[3]),
    (i_state_b[2],IB[2]),
    (i_state_b[1],IB[1]),
    (i_state_b[0],IB[0]);

bufif0 (OA[7],int_bus_a[7],outctrl_a),
       (OA[6],int_bus_a[6],outctrl_a),
       (OA[5],int_bus_a[5],outctrl_a),
       (OA[4],int_bus_a[4],outctrl_a),
       (OA[3],int_bus_a[3],outctrl_a),
       (OA[2],int_bus_a[2],outctrl_a),
       (OA[1],int_bus_a[1],outctrl_a),
       (OA[0],int_bus_a[0],outctrl_a);

bufif0 (OB[7],int_bus_b[7],outctrl_b),
       (OB[6],int_bus_b[6],outctrl_b),
       (OB[5],int_bus_b[5],outctrl_b),
       (OB[4],int_bus_b[4],outctrl_b),
       (OB[3],int_bus_b[3],outctrl_b),
       (OB[2],int_bus_b[2],outctrl_b),
       (OB[1],int_bus_b[1],outctrl_b),
       (OB[0],int_bus_b[0],outctrl_b);

reg sh_a_error_a;
reg sh_cp_error_a;
reg sh_web_error_a;
reg sh_reb_error_a;
//reg sh_oeb_error_a;
reg sh_csb_error_a;
reg sh_i_error_a;
wire error_a;

reg sh_a_error_b;
reg sh_cp_error_b;
reg sh_web_error_b;
reg sh_reb_error_b;
//reg sh_oeb_error_b;
reg sh_csb_error_b;
reg sh_i_error_b;
wire error_b;

reg cm_cp_error;

rdpb18_128x8_g1_behave u1 (
	.a_state_a(a_state_a),
	.cp_state_a(cp_state_a),
	.web_state_a(web_state_a),
	.reb_state_a(reb_state_a),
	.oeb_state_a(oeb_state_a),
	.csb_state_a(csb_state_a),
	.i_state_a(i_state_a),
	.int_bus_a(int_bus_a),
	.sh_a_error_a(sh_a_error_a),
	.sh_cp_error_a(sh_cp_error_a),
	.sh_web_error_a(sh_web_error_a),
	.sh_reb_error_a(sh_reb_error_a),
//	.sh_oeb_error_a(sh_oeb_error_a),
	.sh_csb_error_a(sh_csb_error_a),
	.sh_i_error_a(sh_i_error_a),
	.outctrl_a(outctrl_a),
	.error_a(error_a),
	
	.a_state_b(a_state_b),
	.cp_state_b(cp_state_b),
	.web_state_b(web_state_b),
	.reb_state_b(reb_state_b),
	.oeb_state_b(oeb_state_b),
	.csb_state_b(csb_state_b),
	.i_state_b(i_state_b),
	.int_bus_b(int_bus_b),
	.sh_a_error_b(sh_a_error_b),
	.sh_cp_error_b(sh_cp_error_b),
	.sh_web_error_b(sh_web_error_b),
	.sh_reb_error_b(sh_reb_error_b),
//	.sh_oeb_error_b(sh_oeb_error_b),
	.sh_csb_error_b(sh_csb_error_b),
	.sh_i_error_b(sh_i_error_b),
	.outctrl_b(outctrl_b),
	.error_b(error_b),

	.confa(confa),
	.confb(confb),
	.cm_cp_error(cm_cp_error)
	);
	
specify
  specparam df    = 1.0,
	    tacr  = 2.60*df,  // rise access time @Cload=0.0pF
	    tacf  = 2.60*df,  // fall access time @Cload=0.0pF
            tcyc  = 6.00*df,  // cycle time
            twh   = 3.00*df,  // minimum clock high time.
	    twl   = 3.00*df,  // minimum clock low time.
	    twes  = 0.75*df,  // web setup time
	    tweh  = 0.35*df,  // web hold time
	    tres  = 0.75*df,  // reb setup time
	    treh  = 0.35*df,  // reb hold time
	    tcs   = 0.75*df,  // csb setup time
	    tch   = 0.35*df,  // csb hold time
	    tadds = 0.50*df,  // address setup time
	    taddh = 0.65*df,  // address hold time
	    tis   = 0.40*df,  // data setup time
	    tih   = 1.30*df,  // data hold time
	    toh   = 1.50*df,  // oeb disbale time
	    tcm   = 4.65*df;  // cp conflict margin (if AA=AB && WEBA=WEBB="L")

  if (!error_a) (CPA => OA[0]) = (tacr,tacf);
  if (!error_a) (CPA => OA[1]) = (tacr,tacf);
  if (!error_a) (CPA => OA[2]) = (tacr,tacf);
  if (!error_a) (CPA => OA[3]) = (tacr,tacf);
  if (!error_a) (CPA => OA[4]) = (tacr,tacf);
  if (!error_a) (CPA => OA[5]) = (tacr,tacf);
  if (!error_a) (CPA => OA[6]) = (tacr,tacf);
  if (!error_a) (CPA => OA[7]) = (tacr,tacf);
  if (!error_a) (OEBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  
  if (!error_b) (CPB => OB[0]) = (tacr,tacf);
  if (!error_b) (CPB => OB[1]) = (tacr,tacf);
  if (!error_b) (CPB => OB[2]) = (tacr,tacf);
  if (!error_b) (CPB => OB[3]) = (tacr,tacf);
  if (!error_b) (CPB => OB[4]) = (tacr,tacf);
  if (!error_b) (CPB => OB[5]) = (tacr,tacf);
  if (!error_b) (CPB => OB[6]) = (tacr,tacf);
  if (!error_b) (CPB => OB[7]) = (tacr,tacf);
  if (!error_a) (OEBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  
  $setup(posedge WEBA,posedge CPA,twes,sh_web_error_a);
  $setup(negedge WEBA,posedge CPA,twes,sh_web_error_a);
  $hold(posedge CPA,negedge WEBA,tweh,sh_web_error_a);
  $hold(posedge CPA,posedge WEBA,tweh,sh_web_error_a);
  $setup(posedge REBA,posedge CPA,tres,sh_reb_error_a);
  $setup(negedge REBA,posedge CPA,tres,sh_reb_error_a);
  $hold(posedge CPA,posedge REBA,treh,sh_reb_error_a);
  $hold(posedge CPA,negedge REBA,treh,sh_reb_error_a);
//  $setup(posedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $setup(negedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $hold(posedge CPA,posedge OEBA,toeh,sh_oeb_error_a);
//  $hold(posedge CPA,negedge OEBA,toeh,sh_oeb_error_a);
  $setup(posedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[0],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[0],taddh,sh_a_error_a);
  $setup(posedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[1],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[1],taddh,sh_a_error_a);
  $setup(posedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[2],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[2],taddh,sh_a_error_a);
  $setup(posedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[3],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[3],taddh,sh_a_error_a);
  $setup(posedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[4],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[4],taddh,sh_a_error_a);
  $setup(posedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[5],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[5],taddh,sh_a_error_a);
  $setup(posedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[6],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[6],taddh,sh_a_error_a);
  $setup(posedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $setup(negedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $hold(posedge CPA,posedge CSBA,tch,sh_csb_error_a);
  $hold(posedge CPA,negedge CSBA,tch,sh_csb_error_a);
  $setup(posedge IA[0],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[0],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[0],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[0],tih,sh_i_error_a);
  $setup(posedge IA[1],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[1],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[1],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[1],tih,sh_i_error_a);
  $setup(posedge IA[2],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[2],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[2],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[2],tih,sh_i_error_a);
  $setup(posedge IA[3],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[3],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[3],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[3],tih,sh_i_error_a);
  $setup(posedge IA[4],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[4],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[4],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[4],tih,sh_i_error_a);
  $setup(posedge IA[5],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[5],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[5],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[5],tih,sh_i_error_a);
  $setup(posedge IA[6],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[6],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[6],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[6],tih,sh_i_error_a);
  $setup(posedge IA[7],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[7],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[7],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[7],tih,sh_i_error_a);
  $width(posedge CPA,twh,0,sh_cp_error_a);
  $width(negedge CPA,twl,0,sh_cp_error_a);
  $period(posedge CPA,tcyc,sh_cp_error_a);
  $period(negedge CPA,tcyc);

  $setup(posedge WEBB,posedge CPB,twes,sh_web_error_b);
  $setup(negedge WEBB,posedge CPB,twes,sh_web_error_b);
  $hold(posedge CPB,negedge WEBB,tweh,sh_web_error_b);
  $hold(posedge CPB,posedge WEBB,tweh,sh_web_error_b);
  $setup(posedge REBB,posedge CPB,tres,sh_reb_error_b);
  $setup(negedge REBB,posedge CPB,tres,sh_reb_error_b);
  $hold(posedge CPB,posedge REBB,treh,sh_reb_error_b);
  $hold(posedge CPB,negedge REBB,treh,sh_reb_error_b);
//  $setup(posedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $setup(negedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $hold(posedge CPB,posedge OEBB,toeh,sh_oeb_error_b);
//  $hold(posedge CPB,negedge OEBB,toeh,sh_oeb_error_b);
  $setup(posedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[0],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[0],taddh,sh_a_error_b);
  $setup(posedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[1],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[1],taddh,sh_a_error_b);
  $setup(posedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[2],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[2],taddh,sh_a_error_b);
  $setup(posedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[3],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[3],taddh,sh_a_error_b);
  $setup(posedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[4],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[4],taddh,sh_a_error_b);
  $setup(posedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[5],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[5],taddh,sh_a_error_b);
  $setup(posedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[6],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[6],taddh,sh_a_error_b);
  $setup(posedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $setup(negedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $hold(posedge CPB,posedge CSBB,tch,sh_csb_error_b);
  $hold(posedge CPB,negedge CSBB,tch,sh_csb_error_b);
  $setup(posedge IB[0],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[0],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[0],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[0],tih,sh_i_error_b);
  $setup(posedge IB[1],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[1],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[1],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[1],tih,sh_i_error_b);
  $setup(posedge IB[2],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[2],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[2],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[2],tih,sh_i_error_b);
  $setup(posedge IB[3],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[3],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[3],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[3],tih,sh_i_error_b);
  $setup(posedge IB[4],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[4],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[4],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[4],tih,sh_i_error_b);
  $setup(posedge IB[5],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[5],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[5],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[5],tih,sh_i_error_b);
  $setup(posedge IB[6],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[6],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[6],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[6],tih,sh_i_error_b);
  $setup(posedge IB[7],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[7],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[7],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[7],tih,sh_i_error_b);
  $width(posedge CPB,twh,0,sh_cp_error_b);
  $width(negedge CPB,twl,0,sh_cp_error_b);
  $period(posedge CPB,tcyc,sh_cp_error_b);
  $period(negedge CPB,tcyc);
  
  $setup(posedge confa,posedge confb,tcm,cm_cp_error);
  $setup(posedge confb,posedge confa,tcm,cm_cp_error);
  $hold(posedge confa,posedge confb,tcm,cm_cp_error);
  $hold(posedge confb,posedge confa,tcm,cm_cp_error);

endspecify

`undef numaddr
`undef numout
`undef worddepth
`undef verbose
endmodule
`nosuppress_faults
`disable_portfaults
`endcelldefine

`timescale 1ns/10ps
module rdpb18_256x16_g1_behave(
	a_state_a,
	cp_state_a,
	web_state_a,
	reb_state_a,
	oeb_state_a,
	csb_state_a,
	i_state_a,
	int_bus_a,
	sh_a_error_a,
	sh_cp_error_a,
	sh_web_error_a,
	sh_reb_error_a,
//	sh_oeb_error_a,
	sh_csb_error_a,
	sh_i_error_a,
	outctrl_a,
	error_a,
	a_state_b,
	cp_state_b,
	web_state_b,
	reb_state_b,
	oeb_state_b,
	csb_state_b,
	i_state_b,
	int_bus_b,
	sh_a_error_b,
	sh_cp_error_b,
	sh_web_error_b,
	sh_reb_error_b,
//	sh_oeb_error_b,
	sh_csb_error_b,
	sh_i_error_b,
	outctrl_b,
	error_b,
	confa,
	confb,
	cm_cp_error
	);

`define numaddr 8
`define numout 16
`define worddepth 256

`define verbose 2
`ifdef verbose_0
`undef verbose
`define verbose 0
`else
`endif
`ifdef verbose_1
`undef verbose
`define  verbose 1
`endif
`ifdef verbose_2
`undef verbose
`define verbose 2
`endif

input [`numaddr-1:0] a_state_a;
input cp_state_a;
input web_state_a;
input reb_state_a;
input oeb_state_a;
input csb_state_a;
input [`numout-1:0] i_state_a;
output [`numout-1:0] int_bus_a;
input sh_a_error_a;
input sh_web_error_a;
input sh_reb_error_a;
//input sh_oeb_error_a;
input sh_cp_error_a;
input sh_csb_error_a;
input sh_i_error_a;
output outctrl_a;
output error_a;

input [`numaddr-1:0] a_state_b;
input cp_state_b;
input web_state_b;
input reb_state_b;
input oeb_state_b;
input csb_state_b;
input [`numout-1:0] i_state_b;
output [`numout-1:0] int_bus_b;
input sh_a_error_b;
input sh_web_error_b;
input sh_reb_error_b;
//input sh_oeb_error_b;
input sh_cp_error_b;
input sh_csb_error_b;
input sh_i_error_b;
output outctrl_b;
output error_b;

output confa;
output confb;
input cm_cp_error;

reg [`numout-1:0] memory[`worddepth-1:0];
reg [`numout-1:0] int_bus_a;
reg outctrl_a;
reg error_a;
reg web_reg_a;
reg reb_reg_a;
reg oeb_reg_a;
reg csb_reg_a;
reg [`numaddr-1:0] a_reg_a;
reg [`numout-1:0] i_reg_a;
reg [`numout-1:0] out_bus_a;
integer n;
integer address_a;

reg [`numout-1:0] int_bus_b;
reg outctrl_b;
reg error_b;
reg web_reg_b;
reg reb_reg_b;
reg oeb_reg_b;
reg csb_reg_b;
reg [`numaddr-1:0] a_reg_b;
reg [`numout-1:0] i_reg_b;
reg [`numout-1:0] out_bus_b;
integer address_b;

reg confa;
reg confb;

initial
begin : initialize
  error_a = 1'b0;
  web_reg_a = 1'bx;
  reb_reg_a = 1'bx;
  oeb_reg_a = 1'bx;
  csb_reg_a = 1'bx;
  a_reg_a = `numaddr'bx;
  i_reg_a = `numout'bx;
  int_bus_a = `numout'bx;
  out_bus_a = `numout'bx;
  error_b = 1'b0;
  web_reg_b = 1'bx;
  reb_reg_b = 1'bx;
  oeb_reg_b = 1'bx;
  csb_reg_b = 1'bx;
  a_reg_b = `numaddr'bx;
  i_reg_b = `numout'bx;
  int_bus_b = `numout'bx;
  out_bus_b = `numout'bx;
  confa = 1'b0;
  confb = 1'b0;
  for (n=0; n < `worddepth; n = n + 1)
    memory[n] = `numout'bx;
end

task memoryerror_a;
  begin
    if (`verbose == 2)
    begin
      if (address_a == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_a] = `numout'bx;
      end
    end
  end
endtask

task memoryerror_b;
  begin
    if (`verbose == 2)
    begin
      if (address_b == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_b] = `numout'bx;
      end
    end
  end
endtask

task warning;
  input [1024:1] msg;
  begin
    if ($realtime != 0 && `verbose != 0)
    begin
      $display("%.1f : %m : %0s",$realtime,msg);
    end
  end
endtask

always @(negedge cp_state_a)
begin
  confa = 0;
end

always @(negedge cp_state_b)
begin
  confb = 0;
end

always @(cp_state_a or csb_state_a)
begin
  if ((cp_state_a === 1'bx || cp_state_a === 1'bz) && csb_state_a === 1'b0)
  begin
    warning("CPA is unknown.");
    address_a = -1;
    memoryerror_a;
    int_bus_a = `numout'bx;
    error_a = 1;
  end
end

always @(cp_state_b or csb_state_b)
begin
  if ((cp_state_b === 1'bx || cp_state_b === 1'bz) && csb_state_b === 1'b0)
  begin
    warning("CPB is unknown.");
    address_b = -1;
    memoryerror_b;
    int_bus_b = `numout'bx;
    error_b = 1;
  end
end

always @(oeb_state_a or csb_state_a)
begin
  outctrl_a = oeb_state_a | csb_state_a;
end

always @(oeb_state_b or csb_state_b)
begin
  outctrl_b = oeb_state_b | csb_state_b;
end

always @(posedge cp_state_a)
begin : ck_active_edge_a
  web_reg_a = web_state_a;
  reb_reg_a = reb_state_a;
  oeb_reg_a = oeb_state_a;
  csb_reg_a = csb_state_a;
  a_reg_a = a_state_a;
  i_reg_a = i_state_a;

  if ((csb_reg_a === 1'bx || csb_reg_a === 1'bz) && web_reg_a != 1'b1)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((web_reg_a === 1'bx || web_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((oeb_reg_a === 1'bx || oeb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((reb_reg_a === 1'bx || reb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ( ^a_reg_a === 1'bx || ^a_reg_a === 1'bz)
  begin
    address_a = -1;
    error_a = 1;
    warning("AA is unknown.");
    if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
    begin
      memoryerror_a;
    end
  end

  else if (address_a >= `worddepth)
  begin
    warning("AA is out of range.");
    error_a = 1;
  end

  else
  begin
    address_a = a_reg_a;
    error_a = 0;
  end

  if (!error_a)
  begin
    if (csb_reg_a === 1'b0)
    begin
      if (web_reg_a === 1'b0 && reb_reg_a === 1'b1)
      begin
	memory[address_a] = i_reg_a;
      end
      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b0)
      begin
        int_bus_a <= memory[address_a];
      end
      else if (web_reg_a === 1'b0 && reb_reg_a === 1'b0)
      begin
	memory[address_a] = i_reg_a;
        int_bus_a = i_reg_a;
      end
//      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b1)
//      begin
//	warning("both WEBA and REBA are not active.");
//      end
    end
  end
end

always @(posedge cp_state_b)
begin : ck_active_edge_b
  web_reg_b = web_state_b;
  reb_reg_b = reb_state_b;
  oeb_reg_b = oeb_state_b;
  csb_reg_b = csb_state_b;
  a_reg_b = a_state_b;
  i_reg_b = i_state_b;

  if ((csb_reg_b === 1'bx || csb_reg_b === 1'bz) && web_reg_b != 1'b1)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ((web_reg_b === 1'bx || web_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((oeb_reg_b === 1'bx || oeb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((reb_reg_b === 1'bx || reb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ( ^a_reg_b === 1'bx || ^a_reg_b === 1'bz)
  begin
    address_b = -1;
    error_b = 1;
    warning("AB is unknown.");
    if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
    begin
      memoryerror_b;
    end
  end

  else if (address_b >= `worddepth)
  begin
    warning("AB is out of range.");
    error_b = 1;
  end

  else
  begin
    address_b = a_reg_b;
    error_b = 0;
  end

  if (!error_b)
  begin
    if (csb_reg_b === 1'b0)
    begin
      if (web_reg_b === 1'b0 && reb_reg_b === 1'b1)
      begin
	memory[address_b] = i_reg_b;
      end
      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b0)
      begin
        int_bus_b <= memory[address_b];
      end
      else if (web_reg_b === 1'b0 && reb_reg_b === 1'b0)
      begin
	memory[address_b] = i_reg_b;
        int_bus_b = i_reg_b;
      end
//      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b1)
//      begin
//	warning("both WEBB and REBB are not active.");
//      end
    end
  end
end

always @(posedge cp_state_a)
begin
  if (a_state_a == a_state_b &&
//    web_state_a === 1'b0 &&
      csb_state_a === 1'b0 &&
      ~(web_state_a === 1'b1 && reb_state_a === 1'b1))
  begin
    confa = 1'b1;
  end
  else
  begin
    confa = 1'b0;
  end
end

always @(posedge cp_state_b)
begin
  if (a_state_a == a_state_b &&
//    web_state_b === 1'b0 &&
      csb_state_b === 1'b0 &&
      ~(web_state_b === 1'b1 && reb_state_b === 1'b1))
  begin
    confb = 1'b1;
  end
  else
  begin
    confb = 1'b0;
  end
end

always @(cm_cp_error)
begin : Write_conflict_Error
  if (reb_state_a === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_a = `numout'bx;
  end
  if (reb_state_b === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_b = `numout'bx;
  end
  if (web_state_a === 1'b0 && web_state_b === 1'b0)
  begin
    address_a = -1;
    address_b = -1;
    memoryerror_a;
  end
end  

always @(sh_cp_error_a)
begin : setup_ck_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_csb_error_a)
begin : setup_csb_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_a_error_a)
begin : setuphold_address_error_a
  if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_i_error_a)
begin : setuphold_i_error_a
  if (web_state_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_web_error_a)
begin : setuphold_web_error_a
  if (csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_reb_error_a)
begin : setuphold_reb_error_a
  if (csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
  end
end

//always @(sh_oeb_error_a)
//begin : setuphold_oeb_error_a
//  if (csb_reg_a === 1'b0)
//  begin
//    #0.01 int_bus_a = `numout'bx;
//  end
//end

always @(sh_cp_error_b)
begin : setup_ck_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_csb_error_b)
begin : setup_csb_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_a_error_b)
begin : setuphold_address_error_b
  if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_i_error_b)
begin : setuphold_i_error_b
  if (web_state_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_web_error_b)
begin : setuphold_web_error_b
  if (csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_reb_error_b)
begin : setuphold_reb_error_b
  if (csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
  end
end

//always @(sh_oeb_error_b)
//begin : setuphold_oeb_error_b
//  if (csb_reg_b === 1'b0)
//  begin
//    #0.01 int_bus_b = `numout'bx;
//  end
//end

endmodule

`celldefine
`suppress_faults
`enable_portfaults

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

wire [`numaddr-1:0] AA;
wire CPA;
wire WEBA;
wire REBA;
wire OEBA;
wire CSBA;
wire [`numout-1:0] IA;
wire [`numout-1:0] OA;
wire [`numaddr-1:0] a_state_a;
wire cp_state_a;
wire web_state_a;
wire reb_state_a;
wire oeb_state_a;
wire csb_state_a;
wire [`numout-1:0] i_state_a;
wire [`numout-1:0] int_bus_a;

wire [`numaddr-1:0] AB;
wire CPB;
wire WEBB;
wire REBB;
wire OEBB;
wire CSBB;
wire [`numout-1:0] IB;
wire [`numout-1:0] OB;
wire [`numaddr-1:0] a_state_b;
wire cp_state_b;
wire web_state_b;
wire reb_state_b;
wire oeb_state_b;
wire csb_state_b;
wire [`numout-1:0] i_state_b;
wire [`numout-1:0] int_bus_b;

buf (a_state_a[7],AA[7]),
    (a_state_a[6],AA[6]),
    (a_state_a[5],AA[5]),
    (a_state_a[4],AA[4]),
    (a_state_a[3],AA[3]),
    (a_state_a[2],AA[2]),
    (a_state_a[1],AA[1]),
    (a_state_a[0],AA[0]);

buf (a_state_b[7],AB[7]),
    (a_state_b[6],AB[6]),
    (a_state_b[5],AB[5]),
    (a_state_b[4],AB[4]),
    (a_state_b[3],AB[3]),
    (a_state_b[2],AB[2]),
    (a_state_b[1],AB[1]),
    (a_state_b[0],AB[0]);

buf (cp_state_a,CPA);
buf (web_state_a,WEBA);
buf (reb_state_a,REBA);
buf (oeb_state_a,OEBA);
buf (csb_state_a,CSBA);

buf (cp_state_b,CPB);
buf (web_state_b,WEBB);
buf (reb_state_b,REBB);
buf (oeb_state_b,OEBB);
buf (csb_state_b,CSBB);

buf (i_state_a[15],IA[15]),
    (i_state_a[14],IA[14]),
    (i_state_a[13],IA[13]),
    (i_state_a[12],IA[12]),
    (i_state_a[11],IA[11]),
    (i_state_a[10],IA[10]),
    (i_state_a[9],IA[9]),
    (i_state_a[8],IA[8]),
    (i_state_a[7],IA[7]),
    (i_state_a[6],IA[6]),
    (i_state_a[5],IA[5]),
    (i_state_a[4],IA[4]),
    (i_state_a[3],IA[3]),
    (i_state_a[2],IA[2]),
    (i_state_a[1],IA[1]),
    (i_state_a[0],IA[0]);

buf (i_state_b[15],IB[15]),
    (i_state_b[14],IB[14]),
    (i_state_b[13],IB[13]),
    (i_state_b[12],IB[12]),
    (i_state_b[11],IB[11]),
    (i_state_b[10],IB[10]),
    (i_state_b[9],IB[9]),
    (i_state_b[8],IB[8]),
    (i_state_b[7],IB[7]),
    (i_state_b[6],IB[6]),
    (i_state_b[5],IB[5]),
    (i_state_b[4],IB[4]),
    (i_state_b[3],IB[3]),
    (i_state_b[2],IB[2]),
    (i_state_b[1],IB[1]),
    (i_state_b[0],IB[0]);

bufif0 (OA[15],int_bus_a[15],outctrl_a),
       (OA[14],int_bus_a[14],outctrl_a),
       (OA[13],int_bus_a[13],outctrl_a),
       (OA[12],int_bus_a[12],outctrl_a),
       (OA[11],int_bus_a[11],outctrl_a),
       (OA[10],int_bus_a[10],outctrl_a),
       (OA[9],int_bus_a[9],outctrl_a),
       (OA[8],int_bus_a[8],outctrl_a),
       (OA[7],int_bus_a[7],outctrl_a),
       (OA[6],int_bus_a[6],outctrl_a),
       (OA[5],int_bus_a[5],outctrl_a),
       (OA[4],int_bus_a[4],outctrl_a),
       (OA[3],int_bus_a[3],outctrl_a),
       (OA[2],int_bus_a[2],outctrl_a),
       (OA[1],int_bus_a[1],outctrl_a),
       (OA[0],int_bus_a[0],outctrl_a);

bufif0 (OB[15],int_bus_b[15],outctrl_b),
       (OB[14],int_bus_b[14],outctrl_b),
       (OB[13],int_bus_b[13],outctrl_b),
       (OB[12],int_bus_b[12],outctrl_b),
       (OB[11],int_bus_b[11],outctrl_b),
       (OB[10],int_bus_b[10],outctrl_b),
       (OB[9],int_bus_b[9],outctrl_b),
       (OB[8],int_bus_b[8],outctrl_b),
       (OB[7],int_bus_b[7],outctrl_b),
       (OB[6],int_bus_b[6],outctrl_b),
       (OB[5],int_bus_b[5],outctrl_b),
       (OB[4],int_bus_b[4],outctrl_b),
       (OB[3],int_bus_b[3],outctrl_b),
       (OB[2],int_bus_b[2],outctrl_b),
       (OB[1],int_bus_b[1],outctrl_b),
       (OB[0],int_bus_b[0],outctrl_b);

reg sh_a_error_a;
reg sh_cp_error_a;
reg sh_web_error_a;
reg sh_reb_error_a;
//reg sh_oeb_error_a;
reg sh_csb_error_a;
reg sh_i_error_a;
wire error_a;

reg sh_a_error_b;
reg sh_cp_error_b;
reg sh_web_error_b;
reg sh_reb_error_b;
//reg sh_oeb_error_b;
reg sh_csb_error_b;
reg sh_i_error_b;
wire error_b;

reg cm_cp_error;

rdpb18_256x16_g1_behave u1 (
	.a_state_a(a_state_a),
	.cp_state_a(cp_state_a),
	.web_state_a(web_state_a),
	.reb_state_a(reb_state_a),
	.oeb_state_a(oeb_state_a),
	.csb_state_a(csb_state_a),
	.i_state_a(i_state_a),
	.int_bus_a(int_bus_a),
	.sh_a_error_a(sh_a_error_a),
	.sh_cp_error_a(sh_cp_error_a),
	.sh_web_error_a(sh_web_error_a),
	.sh_reb_error_a(sh_reb_error_a),
//	.sh_oeb_error_a(sh_oeb_error_a),
	.sh_csb_error_a(sh_csb_error_a),
	.sh_i_error_a(sh_i_error_a),
	.outctrl_a(outctrl_a),
	.error_a(error_a),
	
	.a_state_b(a_state_b),
	.cp_state_b(cp_state_b),
	.web_state_b(web_state_b),
	.reb_state_b(reb_state_b),
	.oeb_state_b(oeb_state_b),
	.csb_state_b(csb_state_b),
	.i_state_b(i_state_b),
	.int_bus_b(int_bus_b),
	.sh_a_error_b(sh_a_error_b),
	.sh_cp_error_b(sh_cp_error_b),
	.sh_web_error_b(sh_web_error_b),
	.sh_reb_error_b(sh_reb_error_b),
//	.sh_oeb_error_b(sh_oeb_error_b),
	.sh_csb_error_b(sh_csb_error_b),
	.sh_i_error_b(sh_i_error_b),
	.outctrl_b(outctrl_b),
	.error_b(error_b),

	.confa(confa),
	.confb(confb),
	.cm_cp_error(cm_cp_error)
	);
	
specify
  specparam df    = 1.0,
	    tacr  = 2.70*df,  // rise access time @Cload=0.0pF
	    tacf  = 2.70*df,  // fall access time @Cload=0.0pF
            tcyc  = 6.00*df,  // cycle time
            twh   = 3.00*df,  // minimum clock high time.
	    twl   = 3.00*df,  // minimum clock low time.
	    twes  = 0.75*df,  // web setup time
	    tweh  = 0.35*df,  // web hold time
	    tres  = 0.75*df,  // reb setup time
	    treh  = 0.35*df,  // reb hold time
	    tcs   = 0.75*df,  // csb setup time
	    tch   = 0.35*df,  // csb hold time
	    tadds = 0.50*df,  // address setup time
	    taddh = 0.65*df,  // address hold time
	    tis   = 0.40*df,  // data setup time
	    tih   = 1.30*df,  // data hold time
	    toh   = 1.50*df,  // oeb disbale time
	    tcm   = 4.65*df;  // cp conflict margin (if AA=AB && WEBA=WEBB="L")

  if (!error_a) (CPA => OA[0]) = (tacr,tacf);
  if (!error_a) (CPA => OA[1]) = (tacr,tacf);
  if (!error_a) (CPA => OA[2]) = (tacr,tacf);
  if (!error_a) (CPA => OA[3]) = (tacr,tacf);
  if (!error_a) (CPA => OA[4]) = (tacr,tacf);
  if (!error_a) (CPA => OA[5]) = (tacr,tacf);
  if (!error_a) (CPA => OA[6]) = (tacr,tacf);
  if (!error_a) (CPA => OA[7]) = (tacr,tacf);
  if (!error_a) (CPA => OA[8]) = (tacr,tacf);
  if (!error_a) (CPA => OA[9]) = (tacr,tacf);
  if (!error_a) (CPA => OA[10]) = (tacr,tacf);
  if (!error_a) (CPA => OA[11]) = (tacr,tacf);
  if (!error_a) (CPA => OA[12]) = (tacr,tacf);
  if (!error_a) (CPA => OA[13]) = (tacr,tacf);
  if (!error_a) (CPA => OA[14]) = (tacr,tacf);
  if (!error_a) (CPA => OA[15]) = (tacr,tacf);
  if (!error_a) (OEBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);

  if (!error_b) (CPB => OB[0]) = (tacr,tacf);
  if (!error_b) (CPB => OB[1]) = (tacr,tacf);
  if (!error_b) (CPB => OB[2]) = (tacr,tacf);
  if (!error_b) (CPB => OB[3]) = (tacr,tacf);
  if (!error_b) (CPB => OB[4]) = (tacr,tacf);
  if (!error_b) (CPB => OB[5]) = (tacr,tacf);
  if (!error_b) (CPB => OB[6]) = (tacr,tacf);
  if (!error_b) (CPB => OB[7]) = (tacr,tacf);
  if (!error_b) (CPB => OB[8]) = (tacr,tacf);
  if (!error_b) (CPB => OB[9]) = (tacr,tacf);
  if (!error_b) (CPB => OB[10]) = (tacr,tacf);
  if (!error_b) (CPB => OB[11]) = (tacr,tacf);
  if (!error_b) (CPB => OB[12]) = (tacr,tacf);
  if (!error_b) (CPB => OB[13]) = (tacr,tacf);
  if (!error_b) (CPB => OB[14]) = (tacr,tacf);
  if (!error_b) (CPB => OB[15]) = (tacr,tacf);
  if (!error_b) (OEBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (OEBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_b) (CSBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);

  $setup(posedge WEBA,posedge CPA,twes,sh_web_error_a);
  $setup(negedge WEBA,posedge CPA,twes,sh_web_error_a);
  $hold(posedge CPA,negedge WEBA,tweh,sh_web_error_a);
  $hold(posedge CPA,posedge WEBA,tweh,sh_web_error_a);
  $setup(posedge REBA,posedge CPA,tres,sh_reb_error_a);
  $setup(negedge REBA,posedge CPA,tres,sh_reb_error_a);
  $hold(posedge CPA,posedge REBA,treh,sh_reb_error_a);
  $hold(posedge CPA,negedge REBA,treh,sh_reb_error_a);
//  $setup(posedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $setup(negedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $hold(posedge CPA,posedge OEBA,toeh,sh_oeb_error_a);
//  $hold(posedge CPA,negedge OEBA,toeh,sh_oeb_error_a);
  $setup(posedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[0],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[0],taddh,sh_a_error_a);
  $setup(posedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[1],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[1],taddh,sh_a_error_a);
  $setup(posedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[2],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[2],taddh,sh_a_error_a);
  $setup(posedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[3],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[3],taddh,sh_a_error_a);
  $setup(posedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[4],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[4],taddh,sh_a_error_a);
  $setup(posedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[5],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[5],taddh,sh_a_error_a);
  $setup(posedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[6],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[6],taddh,sh_a_error_a);
  $setup(posedge AA[7],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[7],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[7],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[7],taddh,sh_a_error_a);
  $setup(posedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $setup(negedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $hold(posedge CPA,posedge CSBA,tch,sh_csb_error_a);
  $hold(posedge CPA,negedge CSBA,tch,sh_csb_error_a);
  $setup(posedge IA[0],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[0],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[0],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[0],tih,sh_i_error_a);
  $setup(posedge IA[1],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[1],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[1],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[1],tih,sh_i_error_a);
  $setup(posedge IA[2],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[2],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[2],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[2],tih,sh_i_error_a);
  $setup(posedge IA[3],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[3],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[3],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[3],tih,sh_i_error_a);
  $setup(posedge IA[4],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[4],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[4],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[4],tih,sh_i_error_a);
  $setup(posedge IA[5],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[5],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[5],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[5],tih,sh_i_error_a);
  $setup(posedge IA[6],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[6],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[6],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[6],tih,sh_i_error_a);
  $setup(posedge IA[7],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[7],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[7],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[7],tih,sh_i_error_a);
  $setup(posedge IA[8],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[8],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[8],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[8],tih,sh_i_error_a);
  $setup(posedge IA[9],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[9],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[9],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[9],tih,sh_i_error_a);
  $setup(posedge IA[10],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[10],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[10],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[10],tih,sh_i_error_a);
  $setup(posedge IA[11],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[11],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[11],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[11],tih,sh_i_error_a);
  $setup(posedge IA[12],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[12],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[12],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[12],tih,sh_i_error_a);
  $setup(posedge IA[13],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[13],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[13],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[13],tih,sh_i_error_a);
  $setup(posedge IA[14],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[14],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[14],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[14],tih,sh_i_error_a);
  $setup(posedge IA[15],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[15],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[15],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[15],tih,sh_i_error_a);
  $width(posedge CPA,twh,0,sh_cp_error_a);
  $width(negedge CPA,twl,0,sh_cp_error_a);
  $period(posedge CPA,tcyc,sh_cp_error_a);
  $period(negedge CPA,tcyc);

  $setup(posedge WEBB,posedge CPB,twes,sh_web_error_b);
  $setup(negedge WEBB,posedge CPB,twes,sh_web_error_b);
  $hold(posedge CPB,negedge WEBB,tweh,sh_web_error_b);
  $hold(posedge CPB,posedge WEBB,tweh,sh_web_error_b);
  $setup(posedge REBB,posedge CPB,tres,sh_reb_error_b);
  $setup(negedge REBB,posedge CPB,tres,sh_reb_error_b);
  $hold(posedge CPB,posedge REBB,treh,sh_reb_error_b);
  $hold(posedge CPB,negedge REBB,treh,sh_reb_error_b);
//  $setup(posedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $setup(negedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $hold(posedge CPB,posedge OEBB,toeh,sh_oeb_error_b);
//  $hold(posedge CPB,negedge OEBB,toeh,sh_oeb_error_b);
  $setup(posedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[0],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[0],taddh,sh_a_error_b);
  $setup(posedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[1],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[1],taddh,sh_a_error_b);
  $setup(posedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[2],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[2],taddh,sh_a_error_b);
  $setup(posedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[3],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[3],taddh,sh_a_error_b);
  $setup(posedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[4],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[4],taddh,sh_a_error_b);
  $setup(posedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[5],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[5],taddh,sh_a_error_b);
  $setup(posedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[6],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[6],taddh,sh_a_error_b);
  $setup(posedge AB[7],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[7],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[7],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[7],taddh,sh_a_error_b);
  $setup(posedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $setup(negedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $hold(posedge CPB,posedge CSBB,tch,sh_csb_error_b);
  $hold(posedge CPB,negedge CSBB,tch,sh_csb_error_b);
  $setup(posedge IB[0],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[0],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[0],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[0],tih,sh_i_error_b);
  $setup(posedge IB[1],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[1],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[1],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[1],tih,sh_i_error_b);
  $setup(posedge IB[2],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[2],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[2],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[2],tih,sh_i_error_b);
  $setup(posedge IB[3],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[3],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[3],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[3],tih,sh_i_error_b);
  $setup(posedge IB[4],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[4],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[4],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[4],tih,sh_i_error_b);
  $setup(posedge IB[5],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[5],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[5],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[5],tih,sh_i_error_b);
  $setup(posedge IB[6],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[6],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[6],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[6],tih,sh_i_error_b);
  $setup(posedge IB[7],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[7],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[7],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[7],tih,sh_i_error_b);
  $setup(posedge IB[8],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[8],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[8],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[8],tih,sh_i_error_b);
  $setup(posedge IB[9],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[9],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[9],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[9],tih,sh_i_error_b);
  $setup(posedge IB[10],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[10],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[10],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[10],tih,sh_i_error_b);
  $setup(posedge IB[11],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[11],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[11],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[11],tih,sh_i_error_b);
  $setup(posedge IB[12],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[12],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[12],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[12],tih,sh_i_error_b);
  $setup(posedge IB[13],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[13],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[13],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[13],tih,sh_i_error_b);
  $setup(posedge IB[14],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[14],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[14],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[14],tih,sh_i_error_b);
  $setup(posedge IB[15],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[15],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[15],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[15],tih,sh_i_error_b);
  $width(posedge CPB,twh,0,sh_cp_error_b);
  $width(negedge CPB,twl,0,sh_cp_error_b);
  $period(posedge CPB,tcyc,sh_cp_error_b);
  $period(negedge CPB,tcyc);
  
  $setup(posedge confa,posedge confb,tcm,cm_cp_error);
  $setup(posedge confb,posedge confa,tcm,cm_cp_error);
  $hold(posedge confa,posedge confb,tcm,cm_cp_error);
  $hold(posedge confb,posedge confa,tcm,cm_cp_error);

endspecify

`undef numaddr
`undef numout
`undef worddepth
`undef verbose
endmodule
`nosuppress_faults
`disable_portfaults
`endcelldefine

`timescale 1ns/10ps
module rdpb18_256x8_g1_behave(
	a_state_a,
	cp_state_a,
	web_state_a,
	reb_state_a,
	oeb_state_a,
	csb_state_a,
	i_state_a,
	int_bus_a,
	sh_a_error_a,
	sh_cp_error_a,
	sh_web_error_a,
	sh_reb_error_a,
//	sh_oeb_error_a,
	sh_csb_error_a,
	sh_i_error_a,
	outctrl_a,
	error_a,
	a_state_b,
	cp_state_b,
	web_state_b,
	reb_state_b,
	oeb_state_b,
	csb_state_b,
	i_state_b,
	int_bus_b,
	sh_a_error_b,
	sh_cp_error_b,
	sh_web_error_b,
	sh_reb_error_b,
//	sh_oeb_error_b,
	sh_csb_error_b,
	sh_i_error_b,
	outctrl_b,
	error_b,
	confa,
	confb,
	cm_cp_error
	);

`define numaddr 8
`define numout 8
`define worddepth 256

`define verbose 2
`ifdef verbose_0
`undef verbose
`define verbose 0
`else
`endif
`ifdef verbose_1
`undef verbose
`define  verbose 1
`endif
`ifdef verbose_2
`undef verbose
`define verbose 2
`endif

input [`numaddr-1:0] a_state_a;
input cp_state_a;
input web_state_a;
input reb_state_a;
input oeb_state_a;
input csb_state_a;
input [`numout-1:0] i_state_a;
output [`numout-1:0] int_bus_a;
input sh_a_error_a;
input sh_web_error_a;
input sh_reb_error_a;
//input sh_oeb_error_a;
input sh_cp_error_a;
input sh_csb_error_a;
input sh_i_error_a;
output outctrl_a;
output error_a;

input [`numaddr-1:0] a_state_b;
input cp_state_b;
input web_state_b;
input reb_state_b;
input oeb_state_b;
input csb_state_b;
input [`numout-1:0] i_state_b;
output [`numout-1:0] int_bus_b;
input sh_a_error_b;
input sh_web_error_b;
input sh_reb_error_b;
//input sh_oeb_error_b;
input sh_cp_error_b;
input sh_csb_error_b;
input sh_i_error_b;
output outctrl_b;
output error_b;

output confa;
output confb;
input cm_cp_error;

reg [`numout-1:0] memory[`worddepth-1:0];
reg [`numout-1:0] int_bus_a;
reg outctrl_a;
reg error_a;
reg web_reg_a;
reg reb_reg_a;
reg oeb_reg_a;
reg csb_reg_a;
reg [`numaddr-1:0] a_reg_a;
reg [`numout-1:0] i_reg_a;
reg [`numout-1:0] out_bus_a;
integer n;
integer address_a;

reg [`numout-1:0] int_bus_b;
reg outctrl_b;
reg error_b;
reg web_reg_b;
reg reb_reg_b;
reg oeb_reg_b;
reg csb_reg_b;
reg [`numaddr-1:0] a_reg_b;
reg [`numout-1:0] i_reg_b;
reg [`numout-1:0] out_bus_b;
integer address_b;

reg confa;
reg confb;

initial
begin : initialize
  error_a = 1'b0;
  web_reg_a = 1'bx;
  reb_reg_a = 1'bx;
  oeb_reg_a = 1'bx;
  csb_reg_a = 1'bx;
  a_reg_a = `numaddr'bx;
  i_reg_a = `numout'bx;
  int_bus_a = `numout'bx;
  out_bus_a = `numout'bx;
  error_b = 1'b0;
  web_reg_b = 1'bx;
  reb_reg_b = 1'bx;
  oeb_reg_b = 1'bx;
  csb_reg_b = 1'bx;
  a_reg_b = `numaddr'bx;
  i_reg_b = `numout'bx;
  int_bus_b = `numout'bx;
  out_bus_b = `numout'bx;
  confa = 1'b0;
  confb = 1'b0;
  for (n=0; n < `worddepth; n = n + 1)
    memory[n] = `numout'bx;
end

task memoryerror_a;
  begin
    if (`verbose == 2)
    begin
      if (address_a == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_a] = `numout'bx;
      end
    end
  end
endtask

task memoryerror_b;
  begin
    if (`verbose == 2)
    begin
      if (address_b == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_b] = `numout'bx;
      end
    end
  end
endtask

task warning;
  input [1024:1] msg;
  begin
    if ($realtime != 0 && `verbose != 0)
    begin
      $display("%.1f : %m : %0s",$realtime,msg);
    end
  end
endtask

always @(negedge cp_state_a)
begin
  confa = 0;
end

always @(negedge cp_state_b)
begin
  confb = 0;
end

always @(cp_state_a or csb_state_a)
begin
  if ((cp_state_a === 1'bx || cp_state_a === 1'bz) && csb_state_a === 1'b0)
  begin
    warning("CPA is unknown.");
    address_a = -1;
    memoryerror_a;
    int_bus_a = `numout'bx;
    error_a = 1;
  end
end

always @(cp_state_b or csb_state_b)
begin
  if ((cp_state_b === 1'bx || cp_state_b === 1'bz) && csb_state_b === 1'b0)
  begin
    warning("CPB is unknown.");
    address_b = -1;
    memoryerror_b;
    int_bus_b = `numout'bx;
    error_b = 1;
  end
end

always @(oeb_state_a or csb_state_a)
begin
  outctrl_a = oeb_state_a | csb_state_a;
end

always @(oeb_state_b or csb_state_b)
begin
  outctrl_b = oeb_state_b | csb_state_b;
end

always @(posedge cp_state_a)
begin : ck_active_edge_a
  web_reg_a = web_state_a;
  reb_reg_a = reb_state_a;
  oeb_reg_a = oeb_state_a;
  csb_reg_a = csb_state_a;
  a_reg_a = a_state_a;
  i_reg_a = i_state_a;

  if ((csb_reg_a === 1'bx || csb_reg_a === 1'bz) && web_reg_a != 1'b1)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((web_reg_a === 1'bx || web_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((oeb_reg_a === 1'bx || oeb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((reb_reg_a === 1'bx || reb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ( ^a_reg_a === 1'bx || ^a_reg_a === 1'bz)
  begin
    address_a = -1;
    error_a = 1;
    warning("AA is unknown.");
    if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
    begin
      memoryerror_a;
    end
  end

  else if (address_a >= `worddepth)
  begin
    warning("AA is out of range.");
    error_a = 1;
  end

  else
  begin
    address_a = a_reg_a;
    error_a = 0;
  end

  if (!error_a)
  begin
    if (csb_reg_a === 1'b0)
    begin
      if (web_reg_a === 1'b0 && reb_reg_a === 1'b1)
      begin
	memory[address_a] = i_reg_a;
      end
      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b0)
      begin
        int_bus_a <= memory[address_a];
      end
      else if (web_reg_a === 1'b0 && reb_reg_a === 1'b0)
      begin
	memory[address_a] = i_reg_a;
        int_bus_a = i_reg_a;
      end
//      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b1)
//      begin
//	warning("both WEBA and REBA are not active.");
//      end
    end
  end
end

always @(posedge cp_state_b)
begin : ck_active_edge_b
  web_reg_b = web_state_b;
  reb_reg_b = reb_state_b;
  oeb_reg_b = oeb_state_b;
  csb_reg_b = csb_state_b;
  a_reg_b = a_state_b;
  i_reg_b = i_state_b;

  if ((csb_reg_b === 1'bx || csb_reg_b === 1'bz) && web_reg_b != 1'b1)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ((web_reg_b === 1'bx || web_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((oeb_reg_b === 1'bx || oeb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((reb_reg_b === 1'bx || reb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ( ^a_reg_b === 1'bx || ^a_reg_b === 1'bz)
  begin
    address_b = -1;
    error_b = 1;
    warning("AB is unknown.");
    if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
    begin
      memoryerror_b;
    end
  end

  else if (address_b >= `worddepth)
  begin
    warning("AB is out of range.");
    error_b = 1;
  end

  else
  begin
    address_b = a_reg_b;
    error_b = 0;
  end

  if (!error_b)
  begin
    if (csb_reg_b === 1'b0)
    begin
      if (web_reg_b === 1'b0 && reb_reg_b === 1'b1)
      begin
	memory[address_b] = i_reg_b;
      end
      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b0)
      begin
        int_bus_b <= memory[address_b];
      end
      else if (web_reg_b === 1'b0 && reb_reg_b === 1'b0)
      begin
	memory[address_b] = i_reg_b;
        int_bus_b = i_reg_b;
      end
//      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b1)
//      begin
//	warning("both WEBB and REBB are not active.");
//      end
    end
  end
end

always @(posedge cp_state_a)
begin
  if (a_state_a == a_state_b &&
//    web_state_a === 1'b0 &&
      csb_state_a === 1'b0 &&
      ~(web_state_a === 1'b1 && reb_state_a === 1'b1))
  begin
    confa = 1'b1;
  end
  else
  begin
    confa = 1'b0;
  end
end

always @(posedge cp_state_b)
begin
  if (a_state_a == a_state_b &&
//    web_state_b === 1'b0 &&
      csb_state_b === 1'b0 &&
      ~(web_state_b === 1'b1 && reb_state_b === 1'b1))
  begin
    confb = 1'b1;
  end
  else
  begin
    confb = 1'b0;
  end
end

always @(cm_cp_error)
begin : Write_conflict_Error
  if (reb_state_a === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_a = `numout'bx;
  end
  if (reb_state_b === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_b = `numout'bx;
  end
  if (web_state_a === 1'b0 && web_state_b === 1'b0)
  begin
    address_a = -1;
    address_b = -1;
    memoryerror_a;
  end
end  

always @(sh_cp_error_a)
begin : setup_ck_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_csb_error_a)
begin : setup_csb_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_a_error_a)
begin : setuphold_address_error_a
  if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_i_error_a)
begin : setuphold_i_error_a
  if (web_state_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_web_error_a)
begin : setuphold_web_error_a
  if (csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_reb_error_a)
begin : setuphold_reb_error_a
  if (csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
  end
end

//always @(sh_oeb_error_a)
//begin : setuphold_oeb_error_a
//  if (csb_reg_a === 1'b0)
//  begin
//    #0.01 int_bus_a = `numout'bx;
//  end
//end

always @(sh_cp_error_b)
begin : setup_ck_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_csb_error_b)
begin : setup_csb_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_a_error_b)
begin : setuphold_address_error_b
  if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_i_error_b)
begin : setuphold_i_error_b
  if (web_state_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_web_error_b)
begin : setuphold_web_error_b
  if (csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_reb_error_b)
begin : setuphold_reb_error_b
  if (csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
  end
end

//always @(sh_oeb_error_b)
//begin : setuphold_oeb_error_b
//  if (csb_reg_b === 1'b0)
//  begin
//    #0.01 int_bus_b = `numout'bx;
//  end
//end

endmodule

`celldefine
`suppress_faults
`enable_portfaults

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

wire [`numaddr-1:0] AA;
wire CPA;
wire WEBA;
wire REBA;
wire OEBA;
wire CSBA;
wire [`numout-1:0] IA;
wire [`numout-1:0] OA;
wire [`numaddr-1:0] a_state_a;
wire cp_state_a;
wire web_state_a;
wire reb_state_a;
wire oeb_state_a;
wire csb_state_a;
wire [`numout-1:0] i_state_a;
wire [`numout-1:0] int_bus_a;

wire [`numaddr-1:0] AB;
wire CPB;
wire WEBB;
wire REBB;
wire OEBB;
wire CSBB;
wire [`numout-1:0] IB;
wire [`numout-1:0] OB;
wire [`numaddr-1:0] a_state_b;
wire cp_state_b;
wire web_state_b;
wire reb_state_b;
wire oeb_state_b;
wire csb_state_b;
wire [`numout-1:0] i_state_b;
wire [`numout-1:0] int_bus_b;

buf (a_state_a[7],AA[7]),
    (a_state_a[6],AA[6]),
    (a_state_a[5],AA[5]),
    (a_state_a[4],AA[4]),
    (a_state_a[3],AA[3]),
    (a_state_a[2],AA[2]),
    (a_state_a[1],AA[1]),
    (a_state_a[0],AA[0]);

buf (a_state_b[7],AB[7]),
    (a_state_b[6],AB[6]),
    (a_state_b[5],AB[5]),
    (a_state_b[4],AB[4]),
    (a_state_b[3],AB[3]),
    (a_state_b[2],AB[2]),
    (a_state_b[1],AB[1]),
    (a_state_b[0],AB[0]);

buf (cp_state_a,CPA);
buf (web_state_a,WEBA);
buf (reb_state_a,REBA);
buf (oeb_state_a,OEBA);
buf (csb_state_a,CSBA);

buf (cp_state_b,CPB);
buf (web_state_b,WEBB);
buf (reb_state_b,REBB);
buf (oeb_state_b,OEBB);
buf (csb_state_b,CSBB);

buf (i_state_a[7],IA[7]),
    (i_state_a[6],IA[6]),
    (i_state_a[5],IA[5]),
    (i_state_a[4],IA[4]),
    (i_state_a[3],IA[3]),
    (i_state_a[2],IA[2]),
    (i_state_a[1],IA[1]),
    (i_state_a[0],IA[0]);

buf (i_state_b[7],IB[7]),
    (i_state_b[6],IB[6]),
    (i_state_b[5],IB[5]),
    (i_state_b[4],IB[4]),
    (i_state_b[3],IB[3]),
    (i_state_b[2],IB[2]),
    (i_state_b[1],IB[1]),
    (i_state_b[0],IB[0]);

bufif0 (OA[7],int_bus_a[7],outctrl_a),
       (OA[6],int_bus_a[6],outctrl_a),
       (OA[5],int_bus_a[5],outctrl_a),
       (OA[4],int_bus_a[4],outctrl_a),
       (OA[3],int_bus_a[3],outctrl_a),
       (OA[2],int_bus_a[2],outctrl_a),
       (OA[1],int_bus_a[1],outctrl_a),
       (OA[0],int_bus_a[0],outctrl_a);

bufif0 (OB[7],int_bus_b[7],outctrl_b),
       (OB[6],int_bus_b[6],outctrl_b),
       (OB[5],int_bus_b[5],outctrl_b),
       (OB[4],int_bus_b[4],outctrl_b),
       (OB[3],int_bus_b[3],outctrl_b),
       (OB[2],int_bus_b[2],outctrl_b),
       (OB[1],int_bus_b[1],outctrl_b),
       (OB[0],int_bus_b[0],outctrl_b);

reg sh_a_error_a;
reg sh_cp_error_a;
reg sh_web_error_a;
reg sh_reb_error_a;
//reg sh_oeb_error_a;
reg sh_csb_error_a;
reg sh_i_error_a;
wire error_a;

reg sh_a_error_b;
reg sh_cp_error_b;
reg sh_web_error_b;
reg sh_reb_error_b;
//reg sh_oeb_error_b;
reg sh_csb_error_b;
reg sh_i_error_b;
wire error_b;

reg cm_cp_error;

rdpb18_256x8_g1_behave u1 (
	.a_state_a(a_state_a),
	.cp_state_a(cp_state_a),
	.web_state_a(web_state_a),
	.reb_state_a(reb_state_a),
	.oeb_state_a(oeb_state_a),
	.csb_state_a(csb_state_a),
	.i_state_a(i_state_a),
	.int_bus_a(int_bus_a),
	.sh_a_error_a(sh_a_error_a),
	.sh_cp_error_a(sh_cp_error_a),
	.sh_web_error_a(sh_web_error_a),
	.sh_reb_error_a(sh_reb_error_a),
//	.sh_oeb_error_a(sh_oeb_error_a),
	.sh_csb_error_a(sh_csb_error_a),
	.sh_i_error_a(sh_i_error_a),
	.outctrl_a(outctrl_a),
	.error_a(error_a),
	
	.a_state_b(a_state_b),
	.cp_state_b(cp_state_b),
	.web_state_b(web_state_b),
	.reb_state_b(reb_state_b),
	.oeb_state_b(oeb_state_b),
	.csb_state_b(csb_state_b),
	.i_state_b(i_state_b),
	.int_bus_b(int_bus_b),
	.sh_a_error_b(sh_a_error_b),
	.sh_cp_error_b(sh_cp_error_b),
	.sh_web_error_b(sh_web_error_b),
	.sh_reb_error_b(sh_reb_error_b),
//	.sh_oeb_error_b(sh_oeb_error_b),
	.sh_csb_error_b(sh_csb_error_b),
	.sh_i_error_b(sh_i_error_b),
	.outctrl_b(outctrl_b),
	.error_b(error_b),

	.confa(confa),
	.confb(confb),
	.cm_cp_error(cm_cp_error)
	);
	
specify
  specparam df    = 1.0,
	    tacr  = 2.60*df,  // rise access time @Cload=0.0pF
	    tacf  = 2.60*df,  // fall access time @Cload=0.0pF
            tcyc  = 6.00*df,  // cycle time
            twh   = 3.00*df,  // minimum clock high time.
	    twl   = 3.00*df,  // minimum clock low time.
	    twes  = 0.75*df,  // web setup time
	    tweh  = 0.35*df,  // web hold time
	    tres  = 0.75*df,  // reb setup time
	    treh  = 0.35*df,  // reb hold time
	    tcs   = 0.75*df,  // csb setup time
	    tch   = 0.35*df,  // csb hold time
	    tadds = 0.50*df,  // address setup time
	    taddh = 0.65*df,  // address hold time
	    tis   = 0.40*df,  // data setup time
	    tih   = 1.30*df,  // data hold time
	    toh   = 1.50*df,  // oeb disbale time
	    tcm   = 4.65*df;  // cp conflict margin (if AA=AB && WEBA=WEBB="L")

  if (!error_a) (CPA => OA[0]) = (tacr,tacf);
  if (!error_a) (CPA => OA[1]) = (tacr,tacf);
  if (!error_a) (CPA => OA[2]) = (tacr,tacf);
  if (!error_a) (CPA => OA[3]) = (tacr,tacf);
  if (!error_a) (CPA => OA[4]) = (tacr,tacf);
  if (!error_a) (CPA => OA[5]) = (tacr,tacf);
  if (!error_a) (CPA => OA[6]) = (tacr,tacf);
  if (!error_a) (CPA => OA[7]) = (tacr,tacf);
  if (!error_a) (OEBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  
  if (!error_b) (CPB => OB[0]) = (tacr,tacf);
  if (!error_b) (CPB => OB[1]) = (tacr,tacf);
  if (!error_b) (CPB => OB[2]) = (tacr,tacf);
  if (!error_b) (CPB => OB[3]) = (tacr,tacf);
  if (!error_b) (CPB => OB[4]) = (tacr,tacf);
  if (!error_b) (CPB => OB[5]) = (tacr,tacf);
  if (!error_b) (CPB => OB[6]) = (tacr,tacf);
  if (!error_b) (CPB => OB[7]) = (tacr,tacf);
  if (!error_a) (OEBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  
  $setup(posedge WEBA,posedge CPA,twes,sh_web_error_a);
  $setup(negedge WEBA,posedge CPA,twes,sh_web_error_a);
  $hold(posedge CPA,negedge WEBA,tweh,sh_web_error_a);
  $hold(posedge CPA,posedge WEBA,tweh,sh_web_error_a);
  $setup(posedge REBA,posedge CPA,tres,sh_reb_error_a);
  $setup(negedge REBA,posedge CPA,tres,sh_reb_error_a);
  $hold(posedge CPA,posedge REBA,treh,sh_reb_error_a);
  $hold(posedge CPA,negedge REBA,treh,sh_reb_error_a);
//  $setup(posedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $setup(negedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $hold(posedge CPA,posedge OEBA,toeh,sh_oeb_error_a);
//  $hold(posedge CPA,negedge OEBA,toeh,sh_oeb_error_a);
  $setup(posedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[0],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[0],taddh,sh_a_error_a);
  $setup(posedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[1],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[1],taddh,sh_a_error_a);
  $setup(posedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[2],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[2],taddh,sh_a_error_a);
  $setup(posedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[3],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[3],taddh,sh_a_error_a);
  $setup(posedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[4],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[4],taddh,sh_a_error_a);
  $setup(posedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[5],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[5],taddh,sh_a_error_a);
  $setup(posedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[6],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[6],taddh,sh_a_error_a);
  $setup(posedge AA[7],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[7],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[7],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[7],taddh,sh_a_error_a);
  $setup(posedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $setup(negedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $hold(posedge CPA,posedge CSBA,tch,sh_csb_error_a);
  $hold(posedge CPA,negedge CSBA,tch,sh_csb_error_a);
  $setup(posedge IA[0],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[0],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[0],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[0],tih,sh_i_error_a);
  $setup(posedge IA[1],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[1],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[1],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[1],tih,sh_i_error_a);
  $setup(posedge IA[2],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[2],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[2],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[2],tih,sh_i_error_a);
  $setup(posedge IA[3],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[3],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[3],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[3],tih,sh_i_error_a);
  $setup(posedge IA[4],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[4],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[4],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[4],tih,sh_i_error_a);
  $setup(posedge IA[5],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[5],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[5],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[5],tih,sh_i_error_a);
  $setup(posedge IA[6],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[6],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[6],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[6],tih,sh_i_error_a);
  $setup(posedge IA[7],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[7],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[7],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[7],tih,sh_i_error_a);
  $width(posedge CPA,twh,0,sh_cp_error_a);
  $width(negedge CPA,twl,0,sh_cp_error_a);
  $period(posedge CPA,tcyc,sh_cp_error_a);
  $period(negedge CPA,tcyc);

  $setup(posedge WEBB,posedge CPB,twes,sh_web_error_b);
  $setup(negedge WEBB,posedge CPB,twes,sh_web_error_b);
  $hold(posedge CPB,negedge WEBB,tweh,sh_web_error_b);
  $hold(posedge CPB,posedge WEBB,tweh,sh_web_error_b);
  $setup(posedge REBB,posedge CPB,tres,sh_reb_error_b);
  $setup(negedge REBB,posedge CPB,tres,sh_reb_error_b);
  $hold(posedge CPB,posedge REBB,treh,sh_reb_error_b);
  $hold(posedge CPB,negedge REBB,treh,sh_reb_error_b);
//  $setup(posedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $setup(negedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $hold(posedge CPB,posedge OEBB,toeh,sh_oeb_error_b);
//  $hold(posedge CPB,negedge OEBB,toeh,sh_oeb_error_b);
  $setup(posedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[0],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[0],taddh,sh_a_error_b);
  $setup(posedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[1],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[1],taddh,sh_a_error_b);
  $setup(posedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[2],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[2],taddh,sh_a_error_b);
  $setup(posedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[3],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[3],taddh,sh_a_error_b);
  $setup(posedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[4],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[4],taddh,sh_a_error_b);
  $setup(posedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[5],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[5],taddh,sh_a_error_b);
  $setup(posedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[6],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[6],taddh,sh_a_error_b);
  $setup(posedge AB[7],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[7],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[7],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[7],taddh,sh_a_error_b);
  $setup(posedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $setup(negedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $hold(posedge CPB,posedge CSBB,tch,sh_csb_error_b);
  $hold(posedge CPB,negedge CSBB,tch,sh_csb_error_b);
  $setup(posedge IB[0],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[0],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[0],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[0],tih,sh_i_error_b);
  $setup(posedge IB[1],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[1],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[1],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[1],tih,sh_i_error_b);
  $setup(posedge IB[2],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[2],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[2],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[2],tih,sh_i_error_b);
  $setup(posedge IB[3],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[3],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[3],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[3],tih,sh_i_error_b);
  $setup(posedge IB[4],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[4],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[4],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[4],tih,sh_i_error_b);
  $setup(posedge IB[5],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[5],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[5],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[5],tih,sh_i_error_b);
  $setup(posedge IB[6],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[6],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[6],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[6],tih,sh_i_error_b);
  $setup(posedge IB[7],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[7],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[7],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[7],tih,sh_i_error_b);
  $width(posedge CPB,twh,0,sh_cp_error_b);
  $width(negedge CPB,twl,0,sh_cp_error_b);
  $period(posedge CPB,tcyc,sh_cp_error_b);
  $period(negedge CPB,tcyc);
  
  $setup(posedge confa,posedge confb,tcm,cm_cp_error);
  $setup(posedge confb,posedge confa,tcm,cm_cp_error);
  $hold(posedge confa,posedge confb,tcm,cm_cp_error);
  $hold(posedge confb,posedge confa,tcm,cm_cp_error);

endspecify

`undef numaddr
`undef numout
`undef worddepth
`undef verbose
endmodule
`nosuppress_faults
`disable_portfaults
`endcelldefine

`timescale 1ns/10ps
module rdpb18_512x16_g1_behave(
	a_state_a,
	cp_state_a,
	web_state_a,
	reb_state_a,
	oeb_state_a,
	csb_state_a,
	i_state_a,
	int_bus_a,
	sh_a_error_a,
	sh_cp_error_a,
	sh_web_error_a,
	sh_reb_error_a,
//	sh_oeb_error_a,
	sh_csb_error_a,
	sh_i_error_a,
	outctrl_a,
	error_a,
	a_state_b,
	cp_state_b,
	web_state_b,
	reb_state_b,
	oeb_state_b,
	csb_state_b,
	i_state_b,
	int_bus_b,
	sh_a_error_b,
	sh_cp_error_b,
	sh_web_error_b,
	sh_reb_error_b,
//	sh_oeb_error_b,
	sh_csb_error_b,
	sh_i_error_b,
	outctrl_b,
	error_b,
	confa,
	confb,
	cm_cp_error
	);

`define numaddr 9
`define numout 16
`define worddepth 512

`define verbose 2
`ifdef verbose_0
`undef verbose
`define verbose 0
`else
`endif
`ifdef verbose_1
`undef verbose
`define  verbose 1
`endif
`ifdef verbose_2
`undef verbose
`define verbose 2
`endif

input [`numaddr-1:0] a_state_a;
input cp_state_a;
input web_state_a;
input reb_state_a;
input oeb_state_a;
input csb_state_a;
input [`numout-1:0] i_state_a;
output [`numout-1:0] int_bus_a;
input sh_a_error_a;
input sh_web_error_a;
input sh_reb_error_a;
//input sh_oeb_error_a;
input sh_cp_error_a;
input sh_csb_error_a;
input sh_i_error_a;
output outctrl_a;
output error_a;

input [`numaddr-1:0] a_state_b;
input cp_state_b;
input web_state_b;
input reb_state_b;
input oeb_state_b;
input csb_state_b;
input [`numout-1:0] i_state_b;
output [`numout-1:0] int_bus_b;
input sh_a_error_b;
input sh_web_error_b;
input sh_reb_error_b;
//input sh_oeb_error_b;
input sh_cp_error_b;
input sh_csb_error_b;
input sh_i_error_b;
output outctrl_b;
output error_b;

output confa;
output confb;
input cm_cp_error;

reg [`numout-1:0] memory[`worddepth-1:0];
reg [`numout-1:0] int_bus_a;
reg outctrl_a;
reg error_a;
reg web_reg_a;
reg reb_reg_a;
reg oeb_reg_a;
reg csb_reg_a;
reg [`numaddr-1:0] a_reg_a;
reg [`numout-1:0] i_reg_a;
reg [`numout-1:0] out_bus_a;
integer n;
integer address_a;

reg [`numout-1:0] int_bus_b;
reg outctrl_b;
reg error_b;
reg web_reg_b;
reg reb_reg_b;
reg oeb_reg_b;
reg csb_reg_b;
reg [`numaddr-1:0] a_reg_b;
reg [`numout-1:0] i_reg_b;
reg [`numout-1:0] out_bus_b;
integer address_b;

reg confa;
reg confb;

initial
begin : initialize
  error_a = 1'b0;
  web_reg_a = 1'bx;
  reb_reg_a = 1'bx;
  oeb_reg_a = 1'bx;
  csb_reg_a = 1'bx;
  a_reg_a = `numaddr'bx;
  i_reg_a = `numout'bx;
  int_bus_a = `numout'bx;
  out_bus_a = `numout'bx;
  error_b = 1'b0;
  web_reg_b = 1'bx;
  reb_reg_b = 1'bx;
  oeb_reg_b = 1'bx;
  csb_reg_b = 1'bx;
  a_reg_b = `numaddr'bx;
  i_reg_b = `numout'bx;
  int_bus_b = `numout'bx;
  out_bus_b = `numout'bx;
  confa = 1'b0;
  confb = 1'b0;
  for (n=0; n < `worddepth; n = n + 1)
    memory[n] = `numout'bx;
end

task memoryerror_a;
  begin
    if (`verbose == 2)
    begin
      if (address_a == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_a] = `numout'bx;
      end
    end
  end
endtask

task memoryerror_b;
  begin
    if (`verbose == 2)
    begin
      if (address_b == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_b] = `numout'bx;
      end
    end
  end
endtask

task warning;
  input [1024:1] msg;
  begin
    if ($realtime != 0 && `verbose != 0)
    begin
      $display("%.1f : %m : %0s",$realtime,msg);
    end
  end
endtask

always @(negedge cp_state_a)
begin
  confa = 0;
end

always @(negedge cp_state_b)
begin
  confb = 0;
end

always @(cp_state_a or csb_state_a)
begin
  if ((cp_state_a === 1'bx || cp_state_a === 1'bz) && csb_state_a === 1'b0)
  begin
    warning("CPA is unknown.");
    address_a = -1;
    memoryerror_a;
    int_bus_a = `numout'bx;
    error_a = 1;
  end
end

always @(cp_state_b or csb_state_b)
begin
  if ((cp_state_b === 1'bx || cp_state_b === 1'bz) && csb_state_b === 1'b0)
  begin
    warning("CPB is unknown.");
    address_b = -1;
    memoryerror_b;
    int_bus_b = `numout'bx;
    error_b = 1;
  end
end

always @(oeb_state_a or csb_state_a)
begin
  outctrl_a = oeb_state_a | csb_state_a;
end

always @(oeb_state_b or csb_state_b)
begin
  outctrl_b = oeb_state_b | csb_state_b;
end

always @(posedge cp_state_a)
begin : ck_active_edge_a
  web_reg_a = web_state_a;
  reb_reg_a = reb_state_a;
  oeb_reg_a = oeb_state_a;
  csb_reg_a = csb_state_a;
  a_reg_a = a_state_a;
  i_reg_a = i_state_a;

  if ((csb_reg_a === 1'bx || csb_reg_a === 1'bz) && web_reg_a != 1'b1)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((web_reg_a === 1'bx || web_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((oeb_reg_a === 1'bx || oeb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((reb_reg_a === 1'bx || reb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ( ^a_reg_a === 1'bx || ^a_reg_a === 1'bz)
  begin
    address_a = -1;
    error_a = 1;
    warning("AA is unknown.");
    if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
    begin
      memoryerror_a;
    end
  end

  else if (address_a >= `worddepth)
  begin
    warning("AA is out of range.");
    error_a = 1;
  end

  else
  begin
    address_a = a_reg_a;
    error_a = 0;
  end

  if (!error_a)
  begin
    if (csb_reg_a === 1'b0)
    begin
      if (web_reg_a === 1'b0 && reb_reg_a === 1'b1)
      begin
	memory[address_a] = i_reg_a;
      end
      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b0)
      begin
        int_bus_a <= memory[address_a];
      end
      else if (web_reg_a === 1'b0 && reb_reg_a === 1'b0)
      begin
	memory[address_a] = i_reg_a;
        int_bus_a = i_reg_a;
      end
//      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b1)
//      begin
//	warning("both WEBA and REBA are not active.");
//      end
    end
  end
end

always @(posedge cp_state_b)
begin : ck_active_edge_b
  web_reg_b = web_state_b;
  reb_reg_b = reb_state_b;
  oeb_reg_b = oeb_state_b;
  csb_reg_b = csb_state_b;
  a_reg_b = a_state_b;
  i_reg_b = i_state_b;

  if ((csb_reg_b === 1'bx || csb_reg_b === 1'bz) && web_reg_b != 1'b1)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ((web_reg_b === 1'bx || web_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((oeb_reg_b === 1'bx || oeb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((reb_reg_b === 1'bx || reb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ( ^a_reg_b === 1'bx || ^a_reg_b === 1'bz)
  begin
    address_b = -1;
    error_b = 1;
    warning("AB is unknown.");
    if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
    begin
      memoryerror_b;
    end
  end

  else if (address_b >= `worddepth)
  begin
    warning("AB is out of range.");
    error_b = 1;
  end

  else
  begin
    address_b = a_reg_b;
    error_b = 0;
  end

  if (!error_b)
  begin
    if (csb_reg_b === 1'b0)
    begin
      if (web_reg_b === 1'b0 && reb_reg_b === 1'b1)
      begin
	memory[address_b] = i_reg_b;
      end
      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b0)
      begin
        int_bus_b <= memory[address_b];
      end
      else if (web_reg_b === 1'b0 && reb_reg_b === 1'b0)
      begin
	memory[address_b] = i_reg_b;
        int_bus_b = i_reg_b;
      end
//      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b1)
//      begin
//	warning("both WEBB and REBB are not active.");
//      end
    end
  end
end

always @(posedge cp_state_a)
begin
  if (a_state_a == a_state_b &&
//    web_state_a === 1'b0 &&
      csb_state_a === 1'b0 &&
      ~(web_state_a === 1'b1 && reb_state_a === 1'b1))
  begin
    confa = 1'b1;
  end
  else
  begin
    confa = 1'b0;
  end
end

always @(posedge cp_state_b)
begin
  if (a_state_a == a_state_b &&
//    web_state_b === 1'b0 &&
      csb_state_b === 1'b0 &&
      ~(web_state_b === 1'b1 && reb_state_b === 1'b1))
  begin
    confb = 1'b1;
  end
  else
  begin
    confb = 1'b0;
  end
end

always @(cm_cp_error)
begin : Write_conflict_Error
  if (reb_state_a === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_a = `numout'bx;
  end
  if (reb_state_b === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_b = `numout'bx;
  end
  if (web_state_a === 1'b0 && web_state_b === 1'b0)
  begin
    address_a = -1;
    address_b = -1;
    memoryerror_a;
  end
end  

always @(sh_cp_error_a)
begin : setup_ck_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_csb_error_a)
begin : setup_csb_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_a_error_a)
begin : setuphold_address_error_a
  if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_i_error_a)
begin : setuphold_i_error_a
  if (web_state_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_web_error_a)
begin : setuphold_web_error_a
  if (csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_reb_error_a)
begin : setuphold_reb_error_a
  if (csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
  end
end

//always @(sh_oeb_error_a)
//begin : setuphold_oeb_error_a
//  if (csb_reg_a === 1'b0)
//  begin
//    #0.01 int_bus_a = `numout'bx;
//  end
//end

always @(sh_cp_error_b)
begin : setup_ck_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_csb_error_b)
begin : setup_csb_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_a_error_b)
begin : setuphold_address_error_b
  if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_i_error_b)
begin : setuphold_i_error_b
  if (web_state_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_web_error_b)
begin : setuphold_web_error_b
  if (csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_reb_error_b)
begin : setuphold_reb_error_b
  if (csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
  end
end

//always @(sh_oeb_error_b)
//begin : setuphold_oeb_error_b
//  if (csb_reg_b === 1'b0)
//  begin
//    #0.01 int_bus_b = `numout'bx;
//  end
//end

endmodule

`celldefine
`suppress_faults
`enable_portfaults

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

wire [`numaddr-1:0] AA;
wire CPA;
wire WEBA;
wire REBA;
wire OEBA;
wire CSBA;
wire [`numout-1:0] IA;
wire [`numout-1:0] OA;
wire [`numaddr-1:0] a_state_a;
wire cp_state_a;
wire web_state_a;
wire reb_state_a;
wire oeb_state_a;
wire csb_state_a;
wire [`numout-1:0] i_state_a;
wire [`numout-1:0] int_bus_a;

wire [`numaddr-1:0] AB;
wire CPB;
wire WEBB;
wire REBB;
wire OEBB;
wire CSBB;
wire [`numout-1:0] IB;
wire [`numout-1:0] OB;
wire [`numaddr-1:0] a_state_b;
wire cp_state_b;
wire web_state_b;
wire reb_state_b;
wire oeb_state_b;
wire csb_state_b;
wire [`numout-1:0] i_state_b;
wire [`numout-1:0] int_bus_b;

buf (a_state_a[8],AA[8]),
    (a_state_a[7],AA[7]),
    (a_state_a[6],AA[6]),
    (a_state_a[5],AA[5]),
    (a_state_a[4],AA[4]),
    (a_state_a[3],AA[3]),
    (a_state_a[2],AA[2]),
    (a_state_a[1],AA[1]),
    (a_state_a[0],AA[0]);

buf (a_state_b[8],AB[8]),
    (a_state_b[7],AB[7]),
    (a_state_b[6],AB[6]),
    (a_state_b[5],AB[5]),
    (a_state_b[4],AB[4]),
    (a_state_b[3],AB[3]),
    (a_state_b[2],AB[2]),
    (a_state_b[1],AB[1]),
    (a_state_b[0],AB[0]);

buf (cp_state_a,CPA);
buf (web_state_a,WEBA);
buf (reb_state_a,REBA);
buf (oeb_state_a,OEBA);
buf (csb_state_a,CSBA);

buf (cp_state_b,CPB);
buf (web_state_b,WEBB);
buf (reb_state_b,REBB);
buf (oeb_state_b,OEBB);
buf (csb_state_b,CSBB);

buf (i_state_a[15],IA[15]),
    (i_state_a[14],IA[14]),
    (i_state_a[13],IA[13]),
    (i_state_a[12],IA[12]),
    (i_state_a[11],IA[11]),
    (i_state_a[10],IA[10]),
    (i_state_a[9],IA[9]),
    (i_state_a[8],IA[8]),
    (i_state_a[7],IA[7]),
    (i_state_a[6],IA[6]),
    (i_state_a[5],IA[5]),
    (i_state_a[4],IA[4]),
    (i_state_a[3],IA[3]),
    (i_state_a[2],IA[2]),
    (i_state_a[1],IA[1]),
    (i_state_a[0],IA[0]);

buf (i_state_b[15],IB[15]),
    (i_state_b[14],IB[14]),
    (i_state_b[13],IB[13]),
    (i_state_b[12],IB[12]),
    (i_state_b[11],IB[11]),
    (i_state_b[10],IB[10]),
    (i_state_b[9],IB[9]),
    (i_state_b[8],IB[8]),
    (i_state_b[7],IB[7]),
    (i_state_b[6],IB[6]),
    (i_state_b[5],IB[5]),
    (i_state_b[4],IB[4]),
    (i_state_b[3],IB[3]),
    (i_state_b[2],IB[2]),
    (i_state_b[1],IB[1]),
    (i_state_b[0],IB[0]);

bufif0 (OA[15],int_bus_a[15],outctrl_a),
       (OA[14],int_bus_a[14],outctrl_a),
       (OA[13],int_bus_a[13],outctrl_a),
       (OA[12],int_bus_a[12],outctrl_a),
       (OA[11],int_bus_a[11],outctrl_a),
       (OA[10],int_bus_a[10],outctrl_a),
       (OA[9],int_bus_a[9],outctrl_a),
       (OA[8],int_bus_a[8],outctrl_a),
       (OA[7],int_bus_a[7],outctrl_a),
       (OA[6],int_bus_a[6],outctrl_a),
       (OA[5],int_bus_a[5],outctrl_a),
       (OA[4],int_bus_a[4],outctrl_a),
       (OA[3],int_bus_a[3],outctrl_a),
       (OA[2],int_bus_a[2],outctrl_a),
       (OA[1],int_bus_a[1],outctrl_a),
       (OA[0],int_bus_a[0],outctrl_a);

bufif0 (OB[15],int_bus_b[15],outctrl_b),
       (OB[14],int_bus_b[14],outctrl_b),
       (OB[13],int_bus_b[13],outctrl_b),
       (OB[12],int_bus_b[12],outctrl_b),
       (OB[11],int_bus_b[11],outctrl_b),
       (OB[10],int_bus_b[10],outctrl_b),
       (OB[9],int_bus_b[9],outctrl_b),
       (OB[8],int_bus_b[8],outctrl_b),
       (OB[7],int_bus_b[7],outctrl_b),
       (OB[6],int_bus_b[6],outctrl_b),
       (OB[5],int_bus_b[5],outctrl_b),
       (OB[4],int_bus_b[4],outctrl_b),
       (OB[3],int_bus_b[3],outctrl_b),
       (OB[2],int_bus_b[2],outctrl_b),
       (OB[1],int_bus_b[1],outctrl_b),
       (OB[0],int_bus_b[0],outctrl_b);

reg sh_a_error_a;
reg sh_cp_error_a;
reg sh_web_error_a;
reg sh_reb_error_a;
//reg sh_oeb_error_a;
reg sh_csb_error_a;
reg sh_i_error_a;
wire error_a;

reg sh_a_error_b;
reg sh_cp_error_b;
reg sh_web_error_b;
reg sh_reb_error_b;
//reg sh_oeb_error_b;
reg sh_csb_error_b;
reg sh_i_error_b;
wire error_b;

reg cm_cp_error;

rdpb18_512x16_g1_behave u1 (
	.a_state_a(a_state_a),
	.cp_state_a(cp_state_a),
	.web_state_a(web_state_a),
	.reb_state_a(reb_state_a),
	.oeb_state_a(oeb_state_a),
	.csb_state_a(csb_state_a),
	.i_state_a(i_state_a),
	.int_bus_a(int_bus_a),
	.sh_a_error_a(sh_a_error_a),
	.sh_cp_error_a(sh_cp_error_a),
	.sh_web_error_a(sh_web_error_a),
	.sh_reb_error_a(sh_reb_error_a),
//	.sh_oeb_error_a(sh_oeb_error_a),
	.sh_csb_error_a(sh_csb_error_a),
	.sh_i_error_a(sh_i_error_a),
	.outctrl_a(outctrl_a),
	.error_a(error_a),
	
	.a_state_b(a_state_b),
	.cp_state_b(cp_state_b),
	.web_state_b(web_state_b),
	.reb_state_b(reb_state_b),
	.oeb_state_b(oeb_state_b),
	.csb_state_b(csb_state_b),
	.i_state_b(i_state_b),
	.int_bus_b(int_bus_b),
	.sh_a_error_b(sh_a_error_b),
	.sh_cp_error_b(sh_cp_error_b),
	.sh_web_error_b(sh_web_error_b),
	.sh_reb_error_b(sh_reb_error_b),
//	.sh_oeb_error_b(sh_oeb_error_b),
	.sh_csb_error_b(sh_csb_error_b),
	.sh_i_error_b(sh_i_error_b),
	.outctrl_b(outctrl_b),
	.error_b(error_b),

	.confa(confa),
	.confb(confb),
	.cm_cp_error(cm_cp_error)
	);
	
specify
  specparam df    = 1.0,
	    tacr  = 2.70*df,  // rise access time @Cload=0.0pF
	    tacf  = 2.70*df,  // fall access time @Cload=0.0pF
            tcyc  = 6.00*df,  // cycle time
            twh   = 3.00*df,  // minimum clock high time.
	    twl   = 3.00*df,  // minimum clock low time.
	    twes  = 0.75*df,  // web setup time
	    tweh  = 0.35*df,  // web hold time
	    tres  = 0.75*df,  // reb setup time
	    treh  = 0.35*df,  // reb hold time
	    tcs   = 0.75*df,  // csb setup time
	    tch   = 0.35*df,  // csb hold time
	    tadds = 0.50*df,  // address setup time
	    taddh = 0.65*df,  // address hold time
	    tis   = 0.40*df,  // data setup time
	    tih   = 1.30*df,  // data hold time
	    toh   = 1.50*df,  // oeb disbale time
	    tcm   = 4.65*df;  // cp conflict margin (if AA=AB && WEBA=WEBB="L")

  if (!error_a) (CPA => OA[0]) = (tacr,tacf);
  if (!error_a) (CPA => OA[1]) = (tacr,tacf);
  if (!error_a) (CPA => OA[2]) = (tacr,tacf);
  if (!error_a) (CPA => OA[3]) = (tacr,tacf);
  if (!error_a) (CPA => OA[4]) = (tacr,tacf);
  if (!error_a) (CPA => OA[5]) = (tacr,tacf);
  if (!error_a) (CPA => OA[6]) = (tacr,tacf);
  if (!error_a) (CPA => OA[7]) = (tacr,tacf);
  if (!error_a) (CPA => OA[8]) = (tacr,tacf);
  if (!error_a) (CPA => OA[9]) = (tacr,tacf);
  if (!error_a) (CPA => OA[10]) = (tacr,tacf);
  if (!error_a) (CPA => OA[11]) = (tacr,tacf);
  if (!error_a) (CPA => OA[12]) = (tacr,tacf);
  if (!error_a) (CPA => OA[13]) = (tacr,tacf);
  if (!error_a) (CPA => OA[14]) = (tacr,tacf);
  if (!error_a) (CPA => OA[15]) = (tacr,tacf);
  if (!error_a) (OEBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  
  if (!error_b) (CPB => OB[0]) = (tacr,tacf);
  if (!error_b) (CPB => OB[1]) = (tacr,tacf);
  if (!error_b) (CPB => OB[2]) = (tacr,tacf);
  if (!error_b) (CPB => OB[3]) = (tacr,tacf);
  if (!error_b) (CPB => OB[4]) = (tacr,tacf);
  if (!error_b) (CPB => OB[5]) = (tacr,tacf);
  if (!error_b) (CPB => OB[6]) = (tacr,tacf);
  if (!error_b) (CPB => OB[7]) = (tacr,tacf);
  if (!error_b) (CPB => OB[8]) = (tacr,tacf);
  if (!error_b) (CPB => OB[9]) = (tacr,tacf);
  if (!error_b) (CPB => OB[10]) = (tacr,tacf);
  if (!error_b) (CPB => OB[11]) = (tacr,tacf);
  if (!error_b) (CPB => OB[12]) = (tacr,tacf);
  if (!error_b) (CPB => OB[13]) = (tacr,tacf);
  if (!error_b) (CPB => OB[14]) = (tacr,tacf);
  if (!error_b) (CPB => OB[15]) = (tacr,tacf);
  if (!error_a) (OEBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);

  $setup(posedge WEBA,posedge CPA,twes,sh_web_error_a);
  $setup(negedge WEBA,posedge CPA,twes,sh_web_error_a);
  $hold(posedge CPA,negedge WEBA,tweh,sh_web_error_a);
  $hold(posedge CPA,posedge WEBA,tweh,sh_web_error_a);
  $setup(posedge REBA,posedge CPA,tres,sh_reb_error_a);
  $setup(negedge REBA,posedge CPA,tres,sh_reb_error_a);
  $hold(posedge CPA,posedge REBA,treh,sh_reb_error_a);
  $hold(posedge CPA,negedge REBA,treh,sh_reb_error_a);
//  $setup(posedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $setup(negedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $hold(posedge CPA,posedge OEBA,toeh,sh_oeb_error_a);
//  $hold(posedge CPA,negedge OEBA,toeh,sh_oeb_error_a);
  $setup(posedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[0],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[0],taddh,sh_a_error_a);
  $setup(posedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[1],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[1],taddh,sh_a_error_a);
  $setup(posedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[2],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[2],taddh,sh_a_error_a);
  $setup(posedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[3],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[3],taddh,sh_a_error_a);
  $setup(posedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[4],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[4],taddh,sh_a_error_a);
  $setup(posedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[5],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[5],taddh,sh_a_error_a);
  $setup(posedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[6],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[6],taddh,sh_a_error_a);
  $setup(posedge AA[7],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[7],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[7],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[7],taddh,sh_a_error_a);
  $setup(posedge AA[8],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[8],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[8],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[8],taddh,sh_a_error_a);
  $setup(posedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $setup(negedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $hold(posedge CPA,posedge CSBA,tch,sh_csb_error_a);
  $hold(posedge CPA,negedge CSBA,tch,sh_csb_error_a);
  $setup(posedge IA[0],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[0],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[0],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[0],tih,sh_i_error_a);
  $setup(posedge IA[1],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[1],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[1],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[1],tih,sh_i_error_a);
  $setup(posedge IA[2],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[2],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[2],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[2],tih,sh_i_error_a);
  $setup(posedge IA[3],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[3],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[3],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[3],tih,sh_i_error_a);
  $setup(posedge IA[4],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[4],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[4],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[4],tih,sh_i_error_a);
  $setup(posedge IA[5],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[5],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[5],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[5],tih,sh_i_error_a);
  $setup(posedge IA[6],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[6],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[6],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[6],tih,sh_i_error_a);
  $setup(posedge IA[7],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[7],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[7],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[7],tih,sh_i_error_a);
  $setup(posedge IA[8],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[8],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[8],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[8],tih,sh_i_error_a);
  $setup(posedge IA[9],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[9],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[9],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[9],tih,sh_i_error_a);
  $setup(posedge IA[10],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[10],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[10],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[10],tih,sh_i_error_a);
  $setup(posedge IA[11],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[11],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[11],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[11],tih,sh_i_error_a);
  $setup(posedge IA[12],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[12],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[12],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[12],tih,sh_i_error_a);
  $setup(posedge IA[13],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[13],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[13],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[13],tih,sh_i_error_a);
  $setup(posedge IA[14],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[14],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[14],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[14],tih,sh_i_error_a);
  $setup(posedge IA[15],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[15],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[15],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[15],tih,sh_i_error_a);
  $width(posedge CPA,twh,0,sh_cp_error_a);
  $width(negedge CPA,twl,0,sh_cp_error_a);
  $period(posedge CPA,tcyc,sh_cp_error_a);
  $period(negedge CPA,tcyc);

  $setup(posedge WEBB,posedge CPB,twes,sh_web_error_b);
  $setup(negedge WEBB,posedge CPB,twes,sh_web_error_b);
  $hold(posedge CPB,negedge WEBB,tweh,sh_web_error_b);
  $hold(posedge CPB,posedge WEBB,tweh,sh_web_error_b);
  $setup(posedge REBB,posedge CPB,tres,sh_reb_error_b);
  $setup(negedge REBB,posedge CPB,tres,sh_reb_error_b);
  $hold(posedge CPB,posedge REBB,treh,sh_reb_error_b);
  $hold(posedge CPB,negedge REBB,treh,sh_reb_error_b);
//  $setup(posedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $setup(negedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $hold(posedge CPB,posedge OEBB,toeh,sh_oeb_error_b);
//  $hold(posedge CPB,negedge OEBB,toeh,sh_oeb_error_b);
  $setup(posedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[0],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[0],taddh,sh_a_error_b);
  $setup(posedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[1],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[1],taddh,sh_a_error_b);
  $setup(posedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[2],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[2],taddh,sh_a_error_b);
  $setup(posedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[3],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[3],taddh,sh_a_error_b);
  $setup(posedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[4],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[4],taddh,sh_a_error_b);
  $setup(posedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[5],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[5],taddh,sh_a_error_b);
  $setup(posedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[6],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[6],taddh,sh_a_error_b);
  $setup(posedge AB[7],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[7],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[7],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[7],taddh,sh_a_error_b);
  $setup(posedge AB[8],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[8],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[8],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[8],taddh,sh_a_error_b);
  $setup(posedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $setup(negedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $hold(posedge CPB,posedge CSBB,tch,sh_csb_error_b);
  $hold(posedge CPB,negedge CSBB,tch,sh_csb_error_b);
  $setup(posedge IB[0],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[0],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[0],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[0],tih,sh_i_error_b);
  $setup(posedge IB[1],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[1],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[1],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[1],tih,sh_i_error_b);
  $setup(posedge IB[2],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[2],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[2],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[2],tih,sh_i_error_b);
  $setup(posedge IB[3],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[3],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[3],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[3],tih,sh_i_error_b);
  $setup(posedge IB[4],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[4],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[4],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[4],tih,sh_i_error_b);
  $setup(posedge IB[5],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[5],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[5],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[5],tih,sh_i_error_b);
  $setup(posedge IB[6],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[6],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[6],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[6],tih,sh_i_error_b);
  $setup(posedge IB[7],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[7],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[7],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[7],tih,sh_i_error_b);
  $setup(posedge IB[8],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[8],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[8],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[8],tih,sh_i_error_b);
  $setup(posedge IB[9],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[9],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[9],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[9],tih,sh_i_error_b);
  $setup(posedge IB[10],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[10],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[10],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[10],tih,sh_i_error_b);
  $setup(posedge IB[11],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[11],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[11],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[11],tih,sh_i_error_b);
  $setup(posedge IB[12],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[12],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[12],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[12],tih,sh_i_error_b);
  $setup(posedge IB[13],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[13],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[13],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[13],tih,sh_i_error_b);
  $setup(posedge IB[14],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[14],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[14],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[14],tih,sh_i_error_b);
  $setup(posedge IB[15],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[15],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[15],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[15],tih,sh_i_error_b);
  $width(posedge CPB,twh,0,sh_cp_error_b);
  $width(negedge CPB,twl,0,sh_cp_error_b);
  $period(posedge CPB,tcyc,sh_cp_error_b);
  $period(negedge CPB,tcyc);
  
  $setup(posedge confa,posedge confb,tcm,cm_cp_error);
  $setup(posedge confb,posedge confa,tcm,cm_cp_error);
  $hold(posedge confa,posedge confb,tcm,cm_cp_error);
  $hold(posedge confb,posedge confa,tcm,cm_cp_error);

endspecify

`undef numaddr
`undef numout
`undef worddepth
`undef verbose
endmodule
`nosuppress_faults
`disable_portfaults
`endcelldefine

`timescale 1ns/10ps
module rdpb18_512x8_g1_behave(
	a_state_a,
	cp_state_a,
	web_state_a,
	reb_state_a,
	oeb_state_a,
	csb_state_a,
	i_state_a,
	int_bus_a,
	sh_a_error_a,
	sh_cp_error_a,
	sh_web_error_a,
	sh_reb_error_a,
//	sh_oeb_error_a,
	sh_csb_error_a,
	sh_i_error_a,
	outctrl_a,
	error_a,
	a_state_b,
	cp_state_b,
	web_state_b,
	reb_state_b,
	oeb_state_b,
	csb_state_b,
	i_state_b,
	int_bus_b,
	sh_a_error_b,
	sh_cp_error_b,
	sh_web_error_b,
	sh_reb_error_b,
//	sh_oeb_error_b,
	sh_csb_error_b,
	sh_i_error_b,
	outctrl_b,
	error_b,
	confa,
	confb,
	cm_cp_error
	);

`define numaddr 9
`define numout 8
`define worddepth 512

`define verbose 2
`ifdef verbose_0
`undef verbose
`define verbose 0
`else
`endif
`ifdef verbose_1
`undef verbose
`define  verbose 1
`endif
`ifdef verbose_2
`undef verbose
`define verbose 2
`endif

input [`numaddr-1:0] a_state_a;
input cp_state_a;
input web_state_a;
input reb_state_a;
input oeb_state_a;
input csb_state_a;
input [`numout-1:0] i_state_a;
output [`numout-1:0] int_bus_a;
input sh_a_error_a;
input sh_web_error_a;
input sh_reb_error_a;
//input sh_oeb_error_a;
input sh_cp_error_a;
input sh_csb_error_a;
input sh_i_error_a;
output outctrl_a;
output error_a;

input [`numaddr-1:0] a_state_b;
input cp_state_b;
input web_state_b;
input reb_state_b;
input oeb_state_b;
input csb_state_b;
input [`numout-1:0] i_state_b;
output [`numout-1:0] int_bus_b;
input sh_a_error_b;
input sh_web_error_b;
input sh_reb_error_b;
//input sh_oeb_error_b;
input sh_cp_error_b;
input sh_csb_error_b;
input sh_i_error_b;
output outctrl_b;
output error_b;

output confa;
output confb;
input cm_cp_error;

reg [`numout-1:0] memory[`worddepth-1:0];
reg [`numout-1:0] int_bus_a;
reg outctrl_a;
reg error_a;
reg web_reg_a;
reg reb_reg_a;
reg oeb_reg_a;
reg csb_reg_a;
reg [`numaddr-1:0] a_reg_a;
reg [`numout-1:0] i_reg_a;
reg [`numout-1:0] out_bus_a;
integer n;
integer address_a;

reg [`numout-1:0] int_bus_b;
reg outctrl_b;
reg error_b;
reg web_reg_b;
reg reb_reg_b;
reg oeb_reg_b;
reg csb_reg_b;
reg [`numaddr-1:0] a_reg_b;
reg [`numout-1:0] i_reg_b;
reg [`numout-1:0] out_bus_b;
integer address_b;

reg confa;
reg confb;

initial
begin : initialize
  error_a = 1'b0;
  web_reg_a = 1'bx;
  reb_reg_a = 1'bx;
  oeb_reg_a = 1'bx;
  csb_reg_a = 1'bx;
  a_reg_a = `numaddr'bx;
  i_reg_a = `numout'bx;
  int_bus_a = `numout'bx;
  out_bus_a = `numout'bx;
  error_b = 1'b0;
  web_reg_b = 1'bx;
  reb_reg_b = 1'bx;
  oeb_reg_b = 1'bx;
  csb_reg_b = 1'bx;
  a_reg_b = `numaddr'bx;
  i_reg_b = `numout'bx;
  int_bus_b = `numout'bx;
  out_bus_b = `numout'bx;
  confa = 1'b0;
  confb = 1'b0;
  for (n=0; n < `worddepth; n = n + 1)
    memory[n] = `numout'bx;
end

task memoryerror_a;
  begin
    if (`verbose == 2)
    begin
      if (address_a == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_a] = `numout'bx;
      end
    end
  end
endtask

task memoryerror_b;
  begin
    if (`verbose == 2)
    begin
      if (address_b == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_b] = `numout'bx;
      end
    end
  end
endtask

task warning;
  input [1024:1] msg;
  begin
    if ($realtime != 0 && `verbose != 0)
    begin
      $display("%.1f : %m : %0s",$realtime,msg);
    end
  end
endtask

always @(negedge cp_state_a)
begin
  confa = 0;
end

always @(negedge cp_state_b)
begin
  confb = 0;
end

always @(cp_state_a or csb_state_a)
begin
  if ((cp_state_a === 1'bx || cp_state_a === 1'bz) && csb_state_a === 1'b0)
  begin
    warning("CPA is unknown.");
    address_a = -1;
    memoryerror_a;
    int_bus_a = `numout'bx;
    error_a = 1;
  end
end

always @(cp_state_b or csb_state_b)
begin
  if ((cp_state_b === 1'bx || cp_state_b === 1'bz) && csb_state_b === 1'b0)
  begin
    warning("CPB is unknown.");
    address_b = -1;
    memoryerror_b;
    int_bus_b = `numout'bx;
    error_b = 1;
  end
end

always @(oeb_state_a or csb_state_a)
begin
  outctrl_a = oeb_state_a | csb_state_a;
end

always @(oeb_state_b or csb_state_b)
begin
  outctrl_b = oeb_state_b | csb_state_b;
end

always @(posedge cp_state_a)
begin : ck_active_edge_a
  web_reg_a = web_state_a;
  reb_reg_a = reb_state_a;
  oeb_reg_a = oeb_state_a;
  csb_reg_a = csb_state_a;
  a_reg_a = a_state_a;
  i_reg_a = i_state_a;

  if ((csb_reg_a === 1'bx || csb_reg_a === 1'bz) && web_reg_a != 1'b1)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((web_reg_a === 1'bx || web_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((oeb_reg_a === 1'bx || oeb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((reb_reg_a === 1'bx || reb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ( ^a_reg_a === 1'bx || ^a_reg_a === 1'bz)
  begin
    address_a = -1;
    error_a = 1;
    warning("AA is unknown.");
    if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
    begin
      memoryerror_a;
    end
  end

  else if (address_a >= `worddepth)
  begin
    warning("AA is out of range.");
    error_a = 1;
  end

  else
  begin
    address_a = a_reg_a;
    error_a = 0;
  end

  if (!error_a)
  begin
    if (csb_reg_a === 1'b0)
    begin
      if (web_reg_a === 1'b0 && reb_reg_a === 1'b1)
      begin
	memory[address_a] = i_reg_a;
      end
      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b0)
      begin
        int_bus_a <= memory[address_a];
      end
      else if (web_reg_a === 1'b0 && reb_reg_a === 1'b0)
      begin
	memory[address_a] = i_reg_a;
        int_bus_a = i_reg_a;
      end
//      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b1)
//      begin
//	warning("both WEBA and REBA are not active.");
//      end
    end
  end
end

always @(posedge cp_state_b)
begin : ck_active_edge_b
  web_reg_b = web_state_b;
  reb_reg_b = reb_state_b;
  oeb_reg_b = oeb_state_b;
  csb_reg_b = csb_state_b;
  a_reg_b = a_state_b;
  i_reg_b = i_state_b;

  if ((csb_reg_b === 1'bx || csb_reg_b === 1'bz) && web_reg_b != 1'b1)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ((web_reg_b === 1'bx || web_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((oeb_reg_b === 1'bx || oeb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((reb_reg_b === 1'bx || reb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ( ^a_reg_b === 1'bx || ^a_reg_b === 1'bz)
  begin
    address_b = -1;
    error_b = 1;
    warning("AB is unknown.");
    if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
    begin
      memoryerror_b;
    end
  end

  else if (address_b >= `worddepth)
  begin
    warning("AB is out of range.");
    error_b = 1;
  end

  else
  begin
    address_b = a_reg_b;
    error_b = 0;
  end

  if (!error_b)
  begin
    if (csb_reg_b === 1'b0)
    begin
      if (web_reg_b === 1'b0 && reb_reg_b === 1'b1)
      begin
	memory[address_b] = i_reg_b;
      end
      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b0)
      begin
        int_bus_b <= memory[address_b];
      end
      else if (web_reg_b === 1'b0 && reb_reg_b === 1'b0)
      begin
	memory[address_b] = i_reg_b;
        int_bus_b = i_reg_b;
      end
//      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b1)
//      begin
//	warning("both WEBB and REBB are not active.");
//      end
    end
  end
end

always @(posedge cp_state_a)
begin
  if (a_state_a == a_state_b &&
//    web_state_a === 1'b0 &&
      csb_state_a === 1'b0 &&
      ~(web_state_a === 1'b1 && reb_state_a === 1'b1))
  begin
    confa = 1'b1;
  end
  else
  begin
    confa = 1'b0;
  end
end

always @(posedge cp_state_b)
begin
  if (a_state_a == a_state_b &&
//    web_state_b === 1'b0 &&
      csb_state_b === 1'b0 &&
      ~(web_state_b === 1'b1 && reb_state_b === 1'b1))
  begin
    confb = 1'b1;
  end
  else
  begin
    confb = 1'b0;
  end
end

always @(cm_cp_error)
begin : Write_conflict_Error
  if (reb_state_a === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_a = `numout'bx;
  end
  if (reb_state_b === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_b = `numout'bx;
  end
  if (web_state_a === 1'b0 && web_state_b === 1'b0)
  begin
    address_a = -1;
    address_b = -1;
    memoryerror_a;
  end
end  

always @(sh_cp_error_a)
begin : setup_ck_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_csb_error_a)
begin : setup_csb_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_a_error_a)
begin : setuphold_address_error_a
  if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_i_error_a)
begin : setuphold_i_error_a
  if (web_state_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_web_error_a)
begin : setuphold_web_error_a
  if (csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_reb_error_a)
begin : setuphold_reb_error_a
  if (csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
  end
end

//always @(sh_oeb_error_a)
//begin : setuphold_oeb_error_a
//  if (csb_reg_a === 1'b0)
//  begin
//    #0.01 int_bus_a = `numout'bx;
//  end
//end

always @(sh_cp_error_b)
begin : setup_ck_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_csb_error_b)
begin : setup_csb_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_a_error_b)
begin : setuphold_address_error_b
  if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_i_error_b)
begin : setuphold_i_error_b
  if (web_state_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_web_error_b)
begin : setuphold_web_error_b
  if (csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_reb_error_b)
begin : setuphold_reb_error_b
  if (csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
  end
end

//always @(sh_oeb_error_b)
//begin : setuphold_oeb_error_b
//  if (csb_reg_b === 1'b0)
//  begin
//    #0.01 int_bus_b = `numout'bx;
//  end
//end

endmodule

`celldefine
`suppress_faults
`enable_portfaults

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

wire [`numaddr-1:0] AA;
wire CPA;
wire WEBA;
wire REBA;
wire OEBA;
wire CSBA;
wire [`numout-1:0] IA;
wire [`numout-1:0] OA;
wire [`numaddr-1:0] a_state_a;
wire cp_state_a;
wire web_state_a;
wire reb_state_a;
wire oeb_state_a;
wire csb_state_a;
wire [`numout-1:0] i_state_a;
wire [`numout-1:0] int_bus_a;

wire [`numaddr-1:0] AB;
wire CPB;
wire WEBB;
wire REBB;
wire OEBB;
wire CSBB;
wire [`numout-1:0] IB;
wire [`numout-1:0] OB;
wire [`numaddr-1:0] a_state_b;
wire cp_state_b;
wire web_state_b;
wire reb_state_b;
wire oeb_state_b;
wire csb_state_b;
wire [`numout-1:0] i_state_b;
wire [`numout-1:0] int_bus_b;

buf (a_state_a[8],AA[8]),
    (a_state_a[7],AA[7]),
    (a_state_a[6],AA[6]),
    (a_state_a[5],AA[5]),
    (a_state_a[4],AA[4]),
    (a_state_a[3],AA[3]),
    (a_state_a[2],AA[2]),
    (a_state_a[1],AA[1]),
    (a_state_a[0],AA[0]);

buf (a_state_b[8],AB[8]),
    (a_state_b[7],AB[7]),
    (a_state_b[6],AB[6]),
    (a_state_b[5],AB[5]),
    (a_state_b[4],AB[4]),
    (a_state_b[3],AB[3]),
    (a_state_b[2],AB[2]),
    (a_state_b[1],AB[1]),
    (a_state_b[0],AB[0]);

buf (cp_state_a,CPA);
buf (web_state_a,WEBA);
buf (reb_state_a,REBA);
buf (oeb_state_a,OEBA);
buf (csb_state_a,CSBA);

buf (cp_state_b,CPB);
buf (web_state_b,WEBB);
buf (reb_state_b,REBB);
buf (oeb_state_b,OEBB);
buf (csb_state_b,CSBB);

buf (i_state_a[7],IA[7]),
    (i_state_a[6],IA[6]),
    (i_state_a[5],IA[5]),
    (i_state_a[4],IA[4]),
    (i_state_a[3],IA[3]),
    (i_state_a[2],IA[2]),
    (i_state_a[1],IA[1]),
    (i_state_a[0],IA[0]);

buf (i_state_b[7],IB[7]),
    (i_state_b[6],IB[6]),
    (i_state_b[5],IB[5]),
    (i_state_b[4],IB[4]),
    (i_state_b[3],IB[3]),
    (i_state_b[2],IB[2]),
    (i_state_b[1],IB[1]),
    (i_state_b[0],IB[0]);

bufif0 (OA[7],int_bus_a[7],outctrl_a),
       (OA[6],int_bus_a[6],outctrl_a),
       (OA[5],int_bus_a[5],outctrl_a),
       (OA[4],int_bus_a[4],outctrl_a),
       (OA[3],int_bus_a[3],outctrl_a),
       (OA[2],int_bus_a[2],outctrl_a),
       (OA[1],int_bus_a[1],outctrl_a),
       (OA[0],int_bus_a[0],outctrl_a);

bufif0 (OB[7],int_bus_b[7],outctrl_b),
       (OB[6],int_bus_b[6],outctrl_b),
       (OB[5],int_bus_b[5],outctrl_b),
       (OB[4],int_bus_b[4],outctrl_b),
       (OB[3],int_bus_b[3],outctrl_b),
       (OB[2],int_bus_b[2],outctrl_b),
       (OB[1],int_bus_b[1],outctrl_b),
       (OB[0],int_bus_b[0],outctrl_b);

reg sh_a_error_a;
reg sh_cp_error_a;
reg sh_web_error_a;
reg sh_reb_error_a;
//reg sh_oeb_error_a;
reg sh_csb_error_a;
reg sh_i_error_a;
wire error_a;

reg sh_a_error_b;
reg sh_cp_error_b;
reg sh_web_error_b;
reg sh_reb_error_b;
//reg sh_oeb_error_b;
reg sh_csb_error_b;
reg sh_i_error_b;
wire error_b;

reg cm_cp_error;

rdpb18_512x8_g1_behave u1 (
	.a_state_a(a_state_a),
	.cp_state_a(cp_state_a),
	.web_state_a(web_state_a),
	.reb_state_a(reb_state_a),
	.oeb_state_a(oeb_state_a),
	.csb_state_a(csb_state_a),
	.i_state_a(i_state_a),
	.int_bus_a(int_bus_a),
	.sh_a_error_a(sh_a_error_a),
	.sh_cp_error_a(sh_cp_error_a),
	.sh_web_error_a(sh_web_error_a),
	.sh_reb_error_a(sh_reb_error_a),
//	.sh_oeb_error_a(sh_oeb_error_a),
	.sh_csb_error_a(sh_csb_error_a),
	.sh_i_error_a(sh_i_error_a),
	.outctrl_a(outctrl_a),
	.error_a(error_a),
	
	.a_state_b(a_state_b),
	.cp_state_b(cp_state_b),
	.web_state_b(web_state_b),
	.reb_state_b(reb_state_b),
	.oeb_state_b(oeb_state_b),
	.csb_state_b(csb_state_b),
	.i_state_b(i_state_b),
	.int_bus_b(int_bus_b),
	.sh_a_error_b(sh_a_error_b),
	.sh_cp_error_b(sh_cp_error_b),
	.sh_web_error_b(sh_web_error_b),
	.sh_reb_error_b(sh_reb_error_b),
//	.sh_oeb_error_b(sh_oeb_error_b),
	.sh_csb_error_b(sh_csb_error_b),
	.sh_i_error_b(sh_i_error_b),
	.outctrl_b(outctrl_b),
	.error_b(error_b),

	.confa(confa),
	.confb(confb),
	.cm_cp_error(cm_cp_error)
	);
	
specify
  specparam df    = 1.0,
	    tacr  = 2.70*df,  // rise access time @Cload=0.0pF
	    tacf  = 2.70*df,  // fall access time @Cload=0.0pF
            tcyc  = 6.00*df,  // cycle time
            twh   = 3.00*df,  // minimum clock high time.
	    twl   = 3.00*df,  // minimum clock low time.
	    twes  = 0.75*df,  // web setup time
	    tweh  = 0.35*df,  // web hold time
	    tres  = 0.75*df,  // reb setup time
	    treh  = 0.35*df,  // reb hold time
	    tcs   = 0.75*df,  // csb setup time
	    tch   = 0.35*df,  // csb hold time
	    tadds = 0.50*df,  // address setup time
	    taddh = 0.65*df,  // address hold time
	    tis   = 0.40*df,  // data setup time
	    tih   = 1.30*df,  // data hold time
	    toh   = 1.50*df,  // oeb disbale time
	    tcm   = 4.65*df;  // cp conflict margin (if AA=AB && WEBA=WEBB="L")

  if (!error_a) (CPA => OA[0]) = (tacr,tacf);
  if (!error_a) (CPA => OA[1]) = (tacr,tacf);
  if (!error_a) (CPA => OA[2]) = (tacr,tacf);
  if (!error_a) (CPA => OA[3]) = (tacr,tacf);
  if (!error_a) (CPA => OA[4]) = (tacr,tacf);
  if (!error_a) (CPA => OA[5]) = (tacr,tacf);
  if (!error_a) (CPA => OA[6]) = (tacr,tacf);
  if (!error_a) (CPA => OA[7]) = (tacr,tacf);
  if (!error_a) (OEBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  
  if (!error_b) (CPB => OB[0]) = (tacr,tacf);
  if (!error_b) (CPB => OB[1]) = (tacr,tacf);
  if (!error_b) (CPB => OB[2]) = (tacr,tacf);
  if (!error_b) (CPB => OB[3]) = (tacr,tacf);
  if (!error_b) (CPB => OB[4]) = (tacr,tacf);
  if (!error_b) (CPB => OB[5]) = (tacr,tacf);
  if (!error_b) (CPB => OB[6]) = (tacr,tacf);
  if (!error_b) (CPB => OB[7]) = (tacr,tacf);
  if (!error_a) (OEBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);

  $setup(posedge WEBA,posedge CPA,twes,sh_web_error_a);
  $setup(negedge WEBA,posedge CPA,twes,sh_web_error_a);
  $hold(posedge CPA,negedge WEBA,tweh,sh_web_error_a);
  $hold(posedge CPA,posedge WEBA,tweh,sh_web_error_a);
  $setup(posedge REBA,posedge CPA,tres,sh_reb_error_a);
  $setup(negedge REBA,posedge CPA,tres,sh_reb_error_a);
  $hold(posedge CPA,posedge REBA,treh,sh_reb_error_a);
  $hold(posedge CPA,negedge REBA,treh,sh_reb_error_a);
//  $setup(posedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $setup(negedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $hold(posedge CPA,posedge OEBA,toeh,sh_oeb_error_a);
//  $hold(posedge CPA,negedge OEBA,toeh,sh_oeb_error_a);
  $setup(posedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[0],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[0],taddh,sh_a_error_a);
  $setup(posedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[1],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[1],taddh,sh_a_error_a);
  $setup(posedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[2],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[2],taddh,sh_a_error_a);
  $setup(posedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[3],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[3],taddh,sh_a_error_a);
  $setup(posedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[4],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[4],taddh,sh_a_error_a);
  $setup(posedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[5],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[5],taddh,sh_a_error_a);
  $setup(posedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[6],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[6],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[6],taddh,sh_a_error_a);
  $setup(posedge AA[7],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[7],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[7],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[7],taddh,sh_a_error_a);
  $setup(posedge AA[8],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[8],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[8],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[8],taddh,sh_a_error_a);
  $setup(posedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $setup(negedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $hold(posedge CPA,posedge CSBA,tch,sh_csb_error_a);
  $hold(posedge CPA,negedge CSBA,tch,sh_csb_error_a);
  $setup(posedge IA[0],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[0],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[0],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[0],tih,sh_i_error_a);
  $setup(posedge IA[1],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[1],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[1],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[1],tih,sh_i_error_a);
  $setup(posedge IA[2],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[2],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[2],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[2],tih,sh_i_error_a);
  $setup(posedge IA[3],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[3],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[3],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[3],tih,sh_i_error_a);
  $setup(posedge IA[4],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[4],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[4],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[4],tih,sh_i_error_a);
  $setup(posedge IA[5],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[5],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[5],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[5],tih,sh_i_error_a);
  $setup(posedge IA[6],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[6],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[6],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[6],tih,sh_i_error_a);
  $setup(posedge IA[7],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[7],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[7],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[7],tih,sh_i_error_a);
  $width(posedge CPA,twh,0,sh_cp_error_a);
  $width(negedge CPA,twl,0,sh_cp_error_a);
  $period(posedge CPA,tcyc,sh_cp_error_a);
  $period(negedge CPA,tcyc);

  $setup(posedge WEBB,posedge CPB,twes,sh_web_error_b);
  $setup(negedge WEBB,posedge CPB,twes,sh_web_error_b);
  $hold(posedge CPB,negedge WEBB,tweh,sh_web_error_b);
  $hold(posedge CPB,posedge WEBB,tweh,sh_web_error_b);
  $setup(posedge REBB,posedge CPB,tres,sh_reb_error_b);
  $setup(negedge REBB,posedge CPB,tres,sh_reb_error_b);
  $hold(posedge CPB,posedge REBB,treh,sh_reb_error_b);
  $hold(posedge CPB,negedge REBB,treh,sh_reb_error_b);
//  $setup(posedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $setup(negedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $hold(posedge CPB,posedge OEBB,toeh,sh_oeb_error_b);
//  $hold(posedge CPB,negedge OEBB,toeh,sh_oeb_error_b);
  $setup(posedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[0],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[0],taddh,sh_a_error_b);
  $setup(posedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[1],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[1],taddh,sh_a_error_b);
  $setup(posedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[2],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[2],taddh,sh_a_error_b);
  $setup(posedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[3],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[3],taddh,sh_a_error_b);
  $setup(posedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[4],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[4],taddh,sh_a_error_b);
  $setup(posedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[5],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[5],taddh,sh_a_error_b);
  $setup(posedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[6],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[6],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[6],taddh,sh_a_error_b);
  $setup(posedge AB[7],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[7],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[7],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[7],taddh,sh_a_error_b);
  $setup(posedge AB[8],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[8],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[8],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[8],taddh,sh_a_error_b);
  $setup(posedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $setup(negedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $hold(posedge CPB,posedge CSBB,tch,sh_csb_error_b);
  $hold(posedge CPB,negedge CSBB,tch,sh_csb_error_b);
  $setup(posedge IB[0],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[0],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[0],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[0],tih,sh_i_error_b);
  $setup(posedge IB[1],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[1],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[1],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[1],tih,sh_i_error_b);
  $setup(posedge IB[2],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[2],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[2],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[2],tih,sh_i_error_b);
  $setup(posedge IB[3],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[3],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[3],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[3],tih,sh_i_error_b);
  $setup(posedge IB[4],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[4],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[4],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[4],tih,sh_i_error_b);
  $setup(posedge IB[5],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[5],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[5],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[5],tih,sh_i_error_b);
  $setup(posedge IB[6],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[6],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[6],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[6],tih,sh_i_error_b);
  $setup(posedge IB[7],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[7],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[7],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[7],tih,sh_i_error_b);
  $width(posedge CPB,twh,0,sh_cp_error_b);
  $width(negedge CPB,twl,0,sh_cp_error_b);
  $period(posedge CPB,tcyc,sh_cp_error_b);
  $period(negedge CPB,tcyc);
  
  $setup(posedge confa,posedge confb,tcm,cm_cp_error);
  $setup(posedge confb,posedge confa,tcm,cm_cp_error);
  $hold(posedge confa,posedge confb,tcm,cm_cp_error);
  $hold(posedge confb,posedge confa,tcm,cm_cp_error);

endspecify

`undef numaddr
`undef numout
`undef worddepth
`undef verbose
endmodule
`nosuppress_faults
`disable_portfaults
`endcelldefine

`timescale 1ns/10ps
module rdpb18_64x16_g1_behave(
	a_state_a,
	cp_state_a,
	web_state_a,
	reb_state_a,
	oeb_state_a,
	csb_state_a,
	i_state_a,
	int_bus_a,
	sh_a_error_a,
	sh_cp_error_a,
	sh_web_error_a,
	sh_reb_error_a,
//	sh_oeb_error_a,
	sh_csb_error_a,
	sh_i_error_a,
	outctrl_a,
	error_a,
	a_state_b,
	cp_state_b,
	web_state_b,
	reb_state_b,
	oeb_state_b,
	csb_state_b,
	i_state_b,
	int_bus_b,
	sh_a_error_b,
	sh_cp_error_b,
	sh_web_error_b,
	sh_reb_error_b,
//	sh_oeb_error_b,
	sh_csb_error_b,
	sh_i_error_b,
	outctrl_b,
	error_b,
	confa,
	confb,
	cm_cp_error
	);

`define numaddr 6
`define numout 16
`define worddepth 64

`define verbose 2
`ifdef verbose_0
`undef verbose
`define verbose 0
`else
`endif
`ifdef verbose_1
`undef verbose
`define  verbose 1
`endif
`ifdef verbose_2
`undef verbose
`define verbose 2
`endif

input [`numaddr-1:0] a_state_a;
input cp_state_a;
input web_state_a;
input reb_state_a;
input oeb_state_a;
input csb_state_a;
input [`numout-1:0] i_state_a;
output [`numout-1:0] int_bus_a;
input sh_a_error_a;
input sh_web_error_a;
input sh_reb_error_a;
//input sh_oeb_error_a;
input sh_cp_error_a;
input sh_csb_error_a;
input sh_i_error_a;
output outctrl_a;
output error_a;

input [`numaddr-1:0] a_state_b;
input cp_state_b;
input web_state_b;
input reb_state_b;
input oeb_state_b;
input csb_state_b;
input [`numout-1:0] i_state_b;
output [`numout-1:0] int_bus_b;
input sh_a_error_b;
input sh_web_error_b;
input sh_reb_error_b;
//input sh_oeb_error_b;
input sh_cp_error_b;
input sh_csb_error_b;
input sh_i_error_b;
output outctrl_b;
output error_b;

output confa;
output confb;
input cm_cp_error;

reg [`numout-1:0] memory[`worddepth-1:0];
reg [`numout-1:0] int_bus_a;
reg outctrl_a;
reg error_a;
reg web_reg_a;
reg reb_reg_a;
reg oeb_reg_a;
reg csb_reg_a;
reg [`numaddr-1:0] a_reg_a;
reg [`numout-1:0] i_reg_a;
reg [`numout-1:0] out_bus_a;
integer n;
integer address_a;

reg [`numout-1:0] int_bus_b;
reg outctrl_b;
reg error_b;
reg web_reg_b;
reg reb_reg_b;
reg oeb_reg_b;
reg csb_reg_b;
reg [`numaddr-1:0] a_reg_b;
reg [`numout-1:0] i_reg_b;
reg [`numout-1:0] out_bus_b;
integer address_b;

reg confa;
reg confb;

initial
begin : initialize
  error_a = 1'b0;
  web_reg_a = 1'bx;
  reb_reg_a = 1'bx;
  oeb_reg_a = 1'bx;
  csb_reg_a = 1'bx;
  a_reg_a = `numaddr'bx;
  i_reg_a = `numout'bx;
  int_bus_a = `numout'bx;
  out_bus_a = `numout'bx;
  error_b = 1'b0;
  web_reg_b = 1'bx;
  reb_reg_b = 1'bx;
  oeb_reg_b = 1'bx;
  csb_reg_b = 1'bx;
  a_reg_b = `numaddr'bx;
  i_reg_b = `numout'bx;
  int_bus_b = `numout'bx;
  out_bus_b = `numout'bx;
  confa = 1'b0;
  confb = 1'b0;
  for (n=0; n < `worddepth; n = n + 1)
    memory[n] = `numout'bx;
end

task memoryerror_a;
  begin
    if (`verbose == 2)
    begin
      if (address_a == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_a] = `numout'bx;
      end
    end
  end
endtask

task memoryerror_b;
  begin
    if (`verbose == 2)
    begin
      if (address_b == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_b] = `numout'bx;
      end
    end
  end
endtask

task warning;
  input [1024:1] msg;
  begin
    if ($realtime != 0 && `verbose != 0)
    begin
      $display("%.1f : %m : %0s",$realtime,msg);
    end
  end
endtask

always @(negedge cp_state_a)
begin
  confa = 0;
end

always @(negedge cp_state_b)
begin
  confb = 0;
end

always @(cp_state_a or csb_state_a)
begin
  if ((cp_state_a === 1'bx || cp_state_a === 1'bz) && csb_state_a === 1'b0)
  begin
    warning("CPA is unknown.");
    address_a = -1;
    memoryerror_a;
    int_bus_a = `numout'bx;
    error_a = 1;
  end
end

always @(cp_state_b or csb_state_b)
begin
  if ((cp_state_b === 1'bx || cp_state_b === 1'bz) && csb_state_b === 1'b0)
  begin
    warning("CPB is unknown.");
    address_b = -1;
    memoryerror_b;
    int_bus_b = `numout'bx;
    error_b = 1;
  end
end

always @(oeb_state_a or csb_state_a)
begin
  outctrl_a = oeb_state_a | csb_state_a;
end

always @(oeb_state_b or csb_state_b)
begin
  outctrl_b = oeb_state_b | csb_state_b;
end

always @(posedge cp_state_a)
begin : ck_active_edge_a
  web_reg_a = web_state_a;
  reb_reg_a = reb_state_a;
  oeb_reg_a = oeb_state_a;
  csb_reg_a = csb_state_a;
  a_reg_a = a_state_a;
  i_reg_a = i_state_a;

  if ((csb_reg_a === 1'bx || csb_reg_a === 1'bz) && web_reg_a != 1'b1)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((web_reg_a === 1'bx || web_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((oeb_reg_a === 1'bx || oeb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((reb_reg_a === 1'bx || reb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ( ^a_reg_a === 1'bx || ^a_reg_a === 1'bz)
  begin
    address_a = -1;
    error_a = 1;
    warning("AA is unknown.");
    if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
    begin
      memoryerror_a;
    end
  end

  else if (address_a >= `worddepth)
  begin
    warning("AA is out of range.");
    error_a = 1;
  end

  else
  begin
    address_a = a_reg_a;
    error_a = 0;
  end

  if (!error_a)
  begin
    if (csb_reg_a === 1'b0)
    begin
      if (web_reg_a === 1'b0 && reb_reg_a === 1'b1)
      begin
	memory[address_a] = i_reg_a;
      end
      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b0)
      begin
        int_bus_a <= memory[address_a];
      end
      else if (web_reg_a === 1'b0 && reb_reg_a === 1'b0)
      begin
	memory[address_a] = i_reg_a;
        int_bus_a = i_reg_a;
      end
//      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b1)
//      begin
//	warning("both WEBA and REBA are not active.");
//      end
    end
  end
end

always @(posedge cp_state_b)
begin : ck_active_edge_b
  web_reg_b = web_state_b;
  reb_reg_b = reb_state_b;
  oeb_reg_b = oeb_state_b;
  csb_reg_b = csb_state_b;
  a_reg_b = a_state_b;
  i_reg_b = i_state_b;

  if ((csb_reg_b === 1'bx || csb_reg_b === 1'bz) && web_reg_b != 1'b1)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ((web_reg_b === 1'bx || web_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((oeb_reg_b === 1'bx || oeb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((reb_reg_b === 1'bx || reb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ( ^a_reg_b === 1'bx || ^a_reg_b === 1'bz)
  begin
    address_b = -1;
    error_b = 1;
    warning("AB is unknown.");
    if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
    begin
      memoryerror_b;
    end
  end

  else if (address_b >= `worddepth)
  begin
    warning("AB is out of range.");
    error_b = 1;
  end

  else
  begin
    address_b = a_reg_b;
    error_b = 0;
  end

  if (!error_b)
  begin
    if (csb_reg_b === 1'b0)
    begin
      if (web_reg_b === 1'b0 && reb_reg_b === 1'b1)
      begin
	memory[address_b] = i_reg_b;
      end
      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b0)
      begin
        int_bus_b <= memory[address_b];
      end
      else if (web_reg_b === 1'b0 && reb_reg_b === 1'b0)
      begin
	memory[address_b] = i_reg_b;
        int_bus_b = i_reg_b;
      end
//      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b1)
//      begin
//	warning("both WEBB and REBB are not active.");
//      end
    end
  end
end

always @(posedge cp_state_a)
begin
  if (a_state_a == a_state_b &&
//    web_state_a === 1'b0 &&
      csb_state_a === 1'b0 &&
      ~(web_state_a === 1'b1 && reb_state_a === 1'b1))
  begin
    confa = 1'b1;
  end
  else
  begin
    confa = 1'b0;
  end
end

always @(posedge cp_state_b)
begin
  if (a_state_a == a_state_b &&
//    web_state_b === 1'b0 &&
      csb_state_b === 1'b0 &&
      ~(web_state_b === 1'b1 && reb_state_b === 1'b1))
  begin
    confb = 1'b1;
  end
  else
  begin
    confb = 1'b0;
  end
end

always @(cm_cp_error)
begin : Write_conflict_Error
  if (reb_state_a === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_a = `numout'bx;
  end
  if (reb_state_b === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_b = `numout'bx;
  end
  if (web_state_a === 1'b0 && web_state_b === 1'b0)
  begin
    address_a = -1;
    address_b = -1;
    memoryerror_a;
  end
end

always @(sh_cp_error_a)
begin : setup_ck_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_csb_error_a)
begin : setup_csb_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_a_error_a)
begin : setuphold_address_error_a
  if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_i_error_a)
begin : setuphold_i_error_a
  if (web_state_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_web_error_a)
begin : setuphold_web_error_a
  if (csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_reb_error_a)
begin : setuphold_reb_error_a
  if (csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
  end
end

//always @(sh_oeb_error_a)
//begin : setuphold_oeb_error_a
//  if (csb_reg_a === 1'b0)
//  begin
//    #0.01 int_bus_a = `numout'bx;
//  end
//end

always @(sh_cp_error_b)
begin : setup_ck_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_csb_error_b)
begin : setup_csb_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_a_error_b)
begin : setuphold_address_error_b
  if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_i_error_b)
begin : setuphold_i_error_b
  if (web_state_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_web_error_b)
begin : setuphold_web_error_b
  if (csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_reb_error_b)
begin : setuphold_reb_error_b
  if (csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
  end
end

//always @(sh_oeb_error_b)
//begin : setuphold_oeb_error_b
//  if (csb_reg_b === 1'b0)
//  begin
//    #0.01 int_bus_b = `numout'bx;
//  end
//end

endmodule

`celldefine
`suppress_faults
`enable_portfaults

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

wire [`numaddr-1:0] AA;
wire CPA;
wire WEBA;
wire REBA;
wire OEBA;
wire CSBA;
wire [`numout-1:0] IA;
wire [`numout-1:0] OA;
wire [`numaddr-1:0] a_state_a;
wire cp_state_a;
wire web_state_a;
wire reb_state_a;
wire oeb_state_a;
wire csb_state_a;
wire [`numout-1:0] i_state_a;
wire [`numout-1:0] int_bus_a;

wire [`numaddr-1:0] AB;
wire CPB;
wire WEBB;
wire REBB;
wire OEBB;
wire CSBB;
wire [`numout-1:0] IB;
wire [`numout-1:0] OB;
wire [`numaddr-1:0] a_state_b;
wire cp_state_b;
wire web_state_b;
wire reb_state_b;
wire oeb_state_b;
wire csb_state_b;
wire [`numout-1:0] i_state_b;
wire [`numout-1:0] int_bus_b;

buf (a_state_a[5],AA[5]),
    (a_state_a[4],AA[4]),
    (a_state_a[3],AA[3]),
    (a_state_a[2],AA[2]),
    (a_state_a[1],AA[1]),
    (a_state_a[0],AA[0]);

buf (a_state_b[5],AB[5]),
    (a_state_b[4],AB[4]),
    (a_state_b[3],AB[3]),
    (a_state_b[2],AB[2]),
    (a_state_b[1],AB[1]),
    (a_state_b[0],AB[0]);

buf (cp_state_a,CPA);
buf (web_state_a,WEBA);
buf (reb_state_a,REBA);
buf (oeb_state_a,OEBA);
buf (csb_state_a,CSBA);

buf (cp_state_b,CPB);
buf (web_state_b,WEBB);
buf (reb_state_b,REBB);
buf (oeb_state_b,OEBB);
buf (csb_state_b,CSBB);

buf (i_state_a[15],IA[15]),
    (i_state_a[14],IA[14]),
    (i_state_a[13],IA[13]),
    (i_state_a[12],IA[12]),
    (i_state_a[11],IA[11]),
    (i_state_a[10],IA[10]),
    (i_state_a[9],IA[9]),
    (i_state_a[8],IA[8]),
    (i_state_a[7],IA[7]),
    (i_state_a[6],IA[6]),
    (i_state_a[5],IA[5]),
    (i_state_a[4],IA[4]),
    (i_state_a[3],IA[3]),
    (i_state_a[2],IA[2]),
    (i_state_a[1],IA[1]),
    (i_state_a[0],IA[0]);

buf (i_state_b[15],IB[15]),
    (i_state_b[14],IB[14]),
    (i_state_b[13],IB[13]),
    (i_state_b[12],IB[12]),
    (i_state_b[11],IB[11]),
    (i_state_b[10],IB[10]),
    (i_state_b[9],IB[9]),
    (i_state_b[8],IB[8]),
    (i_state_b[7],IB[7]),
    (i_state_b[6],IB[6]),
    (i_state_b[5],IB[5]),
    (i_state_b[4],IB[4]),
    (i_state_b[3],IB[3]),
    (i_state_b[2],IB[2]),
    (i_state_b[1],IB[1]),
    (i_state_b[0],IB[0]);

bufif0 (OA[15],int_bus_a[15],outctrl_a),
       (OA[14],int_bus_a[14],outctrl_a),
       (OA[13],int_bus_a[13],outctrl_a),
       (OA[12],int_bus_a[12],outctrl_a),
       (OA[11],int_bus_a[11],outctrl_a),
       (OA[10],int_bus_a[10],outctrl_a),
       (OA[9],int_bus_a[9],outctrl_a),
       (OA[8],int_bus_a[8],outctrl_a),
       (OA[7],int_bus_a[7],outctrl_a),
       (OA[6],int_bus_a[6],outctrl_a),
       (OA[5],int_bus_a[5],outctrl_a),
       (OA[4],int_bus_a[4],outctrl_a),
       (OA[3],int_bus_a[3],outctrl_a),
       (OA[2],int_bus_a[2],outctrl_a),
       (OA[1],int_bus_a[1],outctrl_a),
       (OA[0],int_bus_a[0],outctrl_a);

bufif0 (OB[15],int_bus_b[15],outctrl_b),
       (OB[14],int_bus_b[14],outctrl_b),
       (OB[13],int_bus_b[13],outctrl_b),
       (OB[12],int_bus_b[12],outctrl_b),
       (OB[11],int_bus_b[11],outctrl_b),
       (OB[10],int_bus_b[10],outctrl_b),
       (OB[9],int_bus_b[9],outctrl_b),
       (OB[8],int_bus_b[8],outctrl_b),
       (OB[7],int_bus_b[7],outctrl_b),
       (OB[6],int_bus_b[6],outctrl_b),
       (OB[5],int_bus_b[5],outctrl_b),
       (OB[4],int_bus_b[4],outctrl_b),
       (OB[3],int_bus_b[3],outctrl_b),
       (OB[2],int_bus_b[2],outctrl_b),
       (OB[1],int_bus_b[1],outctrl_b),
       (OB[0],int_bus_b[0],outctrl_b);

reg sh_a_error_a;
reg sh_cp_error_a;
reg sh_web_error_a;
reg sh_reb_error_a;
//reg sh_oeb_error_a;
reg sh_csb_error_a;
reg sh_i_error_a;
wire error_a;

reg sh_a_error_b;
reg sh_cp_error_b;
reg sh_web_error_b;
reg sh_reb_error_b;
//reg sh_oeb_error_b;
reg sh_csb_error_b;
reg sh_i_error_b;
wire error_b;

reg cm_cp_error;

rdpb18_64x16_g1_behave u1 (
	.a_state_a(a_state_a),
	.cp_state_a(cp_state_a),
	.web_state_a(web_state_a),
	.reb_state_a(reb_state_a),
	.oeb_state_a(oeb_state_a),
	.csb_state_a(csb_state_a),
	.i_state_a(i_state_a),
	.int_bus_a(int_bus_a),
	.sh_a_error_a(sh_a_error_a),
	.sh_cp_error_a(sh_cp_error_a),
	.sh_web_error_a(sh_web_error_a),
	.sh_reb_error_a(sh_reb_error_a),
//	.sh_oeb_error_a(sh_oeb_error_a),
	.sh_csb_error_a(sh_csb_error_a),
	.sh_i_error_a(sh_i_error_a),
	.outctrl_a(outctrl_a),
	.error_a(error_a),

	.a_state_b(a_state_b),
	.cp_state_b(cp_state_b),
	.web_state_b(web_state_b),
	.reb_state_b(reb_state_b),
	.oeb_state_b(oeb_state_b),
	.csb_state_b(csb_state_b),
	.i_state_b(i_state_b),
	.int_bus_b(int_bus_b),
	.sh_a_error_b(sh_a_error_b),
	.sh_cp_error_b(sh_cp_error_b),
	.sh_web_error_b(sh_web_error_b),
	.sh_reb_error_b(sh_reb_error_b),
//	.sh_oeb_error_b(sh_oeb_error_b),
	.sh_csb_error_b(sh_csb_error_b),
	.sh_i_error_b(sh_i_error_b),
	.outctrl_b(outctrl_b),
	.error_b(error_b),

	.confa(confa),
	.confb(confb),
	.cm_cp_error(cm_cp_error)
	);

specify
  specparam df    = 1.0,
	    tacr  = 2.55*df,  // rise access time @Cload=0.0pF
	    tacf  = 2.55*df,  // fall access time @Cload=0.0pF
            tcyc  = 6.00*df,  // cycle time
            twh   = 3.00*df,  // minimum clock high time.
	    twl   = 3.00*df,  // minimum clock low time.
	    twes  = 0.75*df,  // web setup time
	    tweh  = 0.35*df,  // web hold time
	    tres  = 0.75*df,  // reb setup time
	    treh  = 0.35*df,  // reb hold time
	    tcs   = 0.75*df,  // csb setup time
	    tch   = 0.35*df,  // csb hold time
	    tadds = 0.50*df,  // address setup time
	    taddh = 0.65*df,  // address hold time
	    tis   = 0.40*df,  // data setup time
	    tih   = 1.30*df,  // data hold time
	    toh   = 1.50*df,  // oeb disbale time
	    tcm   = 4.65*df;  // cp conflict margin (if AA=AB && WEBA=WEBB="L")

  if (!error_a) (CPA => OA[0]) = (tacr,tacf);
  if (!error_a) (CPA => OA[1]) = (tacr,tacf);
  if (!error_a) (CPA => OA[2]) = (tacr,tacf);
  if (!error_a) (CPA => OA[3]) = (tacr,tacf);
  if (!error_a) (CPA => OA[4]) = (tacr,tacf);
  if (!error_a) (CPA => OA[5]) = (tacr,tacf);
  if (!error_a) (CPA => OA[6]) = (tacr,tacf);
  if (!error_a) (CPA => OA[7]) = (tacr,tacf);
  if (!error_a) (CPA => OA[8]) = (tacr,tacf);
  if (!error_a) (CPA => OA[9]) = (tacr,tacf);
  if (!error_a) (CPA => OA[10]) = (tacr,tacf);
  if (!error_a) (CPA => OA[11]) = (tacr,tacf);
  if (!error_a) (CPA => OA[12]) = (tacr,tacf);
  if (!error_a) (CPA => OA[13]) = (tacr,tacf);
  if (!error_a) (CPA => OA[14]) = (tacr,tacf);
  if (!error_a) (CPA => OA[15]) = (tacr,tacf);
  if (!error_a) (OEBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);

  if (!error_a) (CPB => OB[0]) = (tacr,tacf);
  if (!error_a) (CPB => OB[1]) = (tacr,tacf);
  if (!error_a) (CPB => OB[2]) = (tacr,tacf);
  if (!error_a) (CPB => OB[3]) = (tacr,tacf);
  if (!error_a) (CPB => OB[4]) = (tacr,tacf);
  if (!error_a) (CPB => OB[5]) = (tacr,tacf);
  if (!error_a) (CPB => OB[6]) = (tacr,tacf);
  if (!error_a) (CPB => OB[7]) = (tacr,tacf);
  if (!error_a) (CPB => OB[8]) = (tacr,tacf);
  if (!error_a) (CPB => OB[9]) = (tacr,tacf);
  if (!error_a) (CPB => OB[10]) = (tacr,tacf);
  if (!error_a) (CPB => OB[11]) = (tacr,tacf);
  if (!error_a) (CPB => OB[12]) = (tacr,tacf);
  if (!error_a) (CPB => OB[13]) = (tacr,tacf);
  if (!error_a) (CPB => OB[14]) = (tacr,tacf);
  if (!error_a) (CPB => OB[15]) = (tacr,tacf);
  if (!error_a) (OEBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);


  $setup(posedge WEBA,posedge CPA,twes,sh_web_error_a);
  $setup(negedge WEBA,posedge CPA,twes,sh_web_error_a);
  $hold(posedge CPA,negedge WEBA,tweh,sh_web_error_a);
  $hold(posedge CPA,posedge WEBA,tweh,sh_web_error_a);
  $setup(posedge REBA,posedge CPA,tres,sh_reb_error_a);
  $setup(negedge REBA,posedge CPA,tres,sh_reb_error_a);
  $hold(posedge CPA,posedge REBA,treh,sh_reb_error_a);
  $hold(posedge CPA,negedge REBA,treh,sh_reb_error_a);
//  $setup(posedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $setup(negedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $hold(posedge CPA,posedge OEBA,toeh,sh_oeb_error_a);
//  $hold(posedge CPA,negedge OEBA,toeh,sh_oeb_error_a);
  $setup(posedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[0],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[0],taddh,sh_a_error_a);
  $setup(posedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[1],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[1],taddh,sh_a_error_a);
  $setup(posedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[2],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[2],taddh,sh_a_error_a);
  $setup(posedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[3],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[3],taddh,sh_a_error_a);
  $setup(posedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[4],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[4],taddh,sh_a_error_a);
  $setup(posedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[5],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[5],taddh,sh_a_error_a);
  $setup(posedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $setup(negedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $hold(posedge CPA,posedge CSBA,tch,sh_csb_error_a);
  $hold(posedge CPA,negedge CSBA,tch,sh_csb_error_a);
  $setup(posedge IA[0],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[0],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[0],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[0],tih,sh_i_error_a);
  $setup(posedge IA[1],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[1],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[1],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[1],tih,sh_i_error_a);
  $setup(posedge IA[2],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[2],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[2],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[2],tih,sh_i_error_a);
  $setup(posedge IA[3],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[3],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[3],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[3],tih,sh_i_error_a);
  $setup(posedge IA[4],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[4],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[4],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[4],tih,sh_i_error_a);
  $setup(posedge IA[5],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[5],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[5],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[5],tih,sh_i_error_a);
  $setup(posedge IA[6],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[6],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[6],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[6],tih,sh_i_error_a);
  $setup(posedge IA[7],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[7],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[7],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[7],tih,sh_i_error_a);
  $setup(posedge IA[8],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[8],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[8],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[8],tih,sh_i_error_a);
  $setup(posedge IA[9],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[9],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[9],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[9],tih,sh_i_error_a);
  $setup(posedge IA[10],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[10],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[10],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[10],tih,sh_i_error_a);
  $setup(posedge IA[11],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[11],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[11],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[11],tih,sh_i_error_a);
  $setup(posedge IA[12],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[12],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[12],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[12],tih,sh_i_error_a);
  $setup(posedge IA[13],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[13],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[13],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[13],tih,sh_i_error_a);
  $setup(posedge IA[14],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[14],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[14],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[14],tih,sh_i_error_a);
  $setup(posedge IA[15],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[15],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[15],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[15],tih,sh_i_error_a);
  $width(posedge CPA,twh,0,sh_cp_error_a);
  $width(negedge CPA,twl,0,sh_cp_error_a);
  $period(posedge CPA,tcyc,sh_cp_error_a);
  $period(negedge CPA,tcyc);

  $setup(posedge WEBB,posedge CPB,twes,sh_web_error_b);
  $setup(negedge WEBB,posedge CPB,twes,sh_web_error_b);
  $hold(posedge CPB,negedge WEBB,tweh,sh_web_error_b);
  $hold(posedge CPB,posedge WEBB,tweh,sh_web_error_b);
  $setup(posedge REBB,posedge CPB,tres,sh_reb_error_b);
  $setup(negedge REBB,posedge CPB,tres,sh_reb_error_b);
  $hold(posedge CPB,posedge REBB,treh,sh_reb_error_b);
  $hold(posedge CPB,negedge REBB,treh,sh_reb_error_b);
//  $setup(posedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $setup(negedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $hold(posedge CPB,posedge OEBB,toeh,sh_oeb_error_b);
//  $hold(posedge CPB,negedge OEBB,toeh,sh_oeb_error_b);
  $setup(posedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[0],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[0],taddh,sh_a_error_b);
  $setup(posedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[1],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[1],taddh,sh_a_error_b);
  $setup(posedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[2],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[2],taddh,sh_a_error_b);
  $setup(posedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[3],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[3],taddh,sh_a_error_b);
  $setup(posedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[4],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[4],taddh,sh_a_error_b);
  $setup(posedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[5],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[5],taddh,sh_a_error_b);
  $setup(posedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $setup(negedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $hold(posedge CPB,posedge CSBB,tch,sh_csb_error_b);
  $hold(posedge CPB,negedge CSBB,tch,sh_csb_error_b);
  $setup(posedge IB[0],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[0],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[0],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[0],tih,sh_i_error_b);
  $setup(posedge IB[1],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[1],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[1],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[1],tih,sh_i_error_b);
  $setup(posedge IB[2],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[2],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[2],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[2],tih,sh_i_error_b);
  $setup(posedge IB[3],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[3],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[3],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[3],tih,sh_i_error_b);
  $setup(posedge IB[4],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[4],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[4],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[4],tih,sh_i_error_b);
  $setup(posedge IB[5],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[5],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[5],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[5],tih,sh_i_error_b);
  $setup(posedge IB[6],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[6],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[6],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[6],tih,sh_i_error_b);
  $setup(posedge IB[7],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[7],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[7],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[7],tih,sh_i_error_b);
  $setup(posedge IB[8],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[8],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[8],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[8],tih,sh_i_error_b);
  $setup(posedge IB[9],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[9],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[9],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[9],tih,sh_i_error_b);
  $setup(posedge IB[10],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[10],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[10],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[10],tih,sh_i_error_b);
  $setup(posedge IB[11],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[11],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[11],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[11],tih,sh_i_error_b);
  $setup(posedge IB[12],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[12],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[12],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[12],tih,sh_i_error_b);
  $setup(posedge IB[13],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[13],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[13],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[13],tih,sh_i_error_b);
  $setup(posedge IB[14],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[14],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[14],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[14],tih,sh_i_error_b);
  $setup(posedge IB[15],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[15],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[15],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[15],tih,sh_i_error_b);
  $width(posedge CPB,twh,0,sh_cp_error_b);
  $width(negedge CPB,twl,0,sh_cp_error_b);
  $period(posedge CPB,tcyc,sh_cp_error_b);
  $period(negedge CPB,tcyc);

  $setup(posedge confa,posedge confb,tcm,cm_cp_error);
  $setup(posedge confb,posedge confa,tcm,cm_cp_error);
  $hold(posedge confa,posedge confb,tcm,cm_cp_error);
  $hold(posedge confb,posedge confa,tcm,cm_cp_error);

endspecify

`undef numaddr
`undef numout
`undef worddepth
`undef verbose
endmodule
`nosuppress_faults
`disable_portfaults
`endcelldefine

`timescale 1ns/10ps
module rdpb18_64x8_g1_behave(
	a_state_a,
	cp_state_a,
	web_state_a,
	reb_state_a,
	oeb_state_a,
	csb_state_a,
	i_state_a,
	int_bus_a,
	sh_a_error_a,
	sh_cp_error_a,
	sh_web_error_a,
	sh_reb_error_a,
//	sh_oeb_error_a,
	sh_csb_error_a,
	sh_i_error_a,
	outctrl_a,
	error_a,
	a_state_b,
	cp_state_b,
	web_state_b,
	reb_state_b,
	oeb_state_b,
	csb_state_b,
	i_state_b,
	int_bus_b,
	sh_a_error_b,
	sh_cp_error_b,
	sh_web_error_b,
	sh_reb_error_b,
//	sh_oeb_error_b,
	sh_csb_error_b,
	sh_i_error_b,
	outctrl_b,
	error_b,
	confa,
	confb,
	cm_cp_error
	);

`define numaddr 6
`define numout 8
`define worddepth 64

`define verbose 2
`ifdef verbose_0
`undef verbose
`define verbose 0
`else
`endif
`ifdef verbose_1
`undef verbose
`define  verbose 1
`endif
`ifdef verbose_2
`undef verbose
`define verbose 2
`endif

input [`numaddr-1:0] a_state_a;
input cp_state_a;
input web_state_a;
input reb_state_a;
input oeb_state_a;
input csb_state_a;
input [`numout-1:0] i_state_a;
output [`numout-1:0] int_bus_a;
input sh_a_error_a;
input sh_web_error_a;
input sh_reb_error_a;
//input sh_oeb_error_a;
input sh_cp_error_a;
input sh_csb_error_a;
input sh_i_error_a;
output outctrl_a;
output error_a;

input [`numaddr-1:0] a_state_b;
input cp_state_b;
input web_state_b;
input reb_state_b;
input oeb_state_b;
input csb_state_b;
input [`numout-1:0] i_state_b;
output [`numout-1:0] int_bus_b;
input sh_a_error_b;
input sh_web_error_b;
input sh_reb_error_b;
//input sh_oeb_error_b;
input sh_cp_error_b;
input sh_csb_error_b;
input sh_i_error_b;
output outctrl_b;
output error_b;

output confa;
output confb;
input cm_cp_error;

reg [`numout-1:0] memory[`worddepth-1:0];
reg [`numout-1:0] int_bus_a;
reg outctrl_a;
reg error_a;
reg web_reg_a;
reg reb_reg_a;
reg oeb_reg_a;
reg csb_reg_a;
reg [`numaddr-1:0] a_reg_a;
reg [`numout-1:0] i_reg_a;
reg [`numout-1:0] out_bus_a;
integer n;
integer address_a;

reg [`numout-1:0] int_bus_b;
reg outctrl_b;
reg error_b;
reg web_reg_b;
reg reb_reg_b;
reg oeb_reg_b;
reg csb_reg_b;
reg [`numaddr-1:0] a_reg_b;
reg [`numout-1:0] i_reg_b;
reg [`numout-1:0] out_bus_b;
integer address_b;

reg confa;
reg confb;

initial
begin : initialize
  error_a = 1'b0;
  web_reg_a = 1'bx;
  reb_reg_a = 1'bx;
  oeb_reg_a = 1'bx;
  csb_reg_a = 1'bx;
  a_reg_a = `numaddr'bx;
  i_reg_a = `numout'bx;
  int_bus_a = `numout'bx;
  out_bus_a = `numout'bx;
  error_b = 1'b0;
  web_reg_b = 1'bx;
  reb_reg_b = 1'bx;
  oeb_reg_b = 1'bx;
  csb_reg_b = 1'bx;
  a_reg_b = `numaddr'bx;
  i_reg_b = `numout'bx;
  int_bus_b = `numout'bx;
  out_bus_b = `numout'bx;
  confa = 1'b0;
  confb = 1'b0;
  for (n=0; n < `worddepth; n = n + 1)
    memory[n] = `numout'bx;
end

task memoryerror_a;
  begin
    if (`verbose == 2)
    begin
      if (address_a == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_a] = `numout'bx;
      end
    end
  end
endtask

task memoryerror_b;
  begin
    if (`verbose == 2)
    begin
      if (address_b == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_b] = `numout'bx;
      end
    end
  end
endtask

task warning;
  input [1024:1] msg;
  begin
    if ($realtime != 0 && `verbose != 0)
    begin
      $display("%.1f : %m : %0s",$realtime,msg);
    end
  end
endtask

always @(negedge cp_state_a)
begin
  confa = 0;
end

always @(negedge cp_state_b)
begin
  confb = 0;
end

always @(cp_state_a or csb_state_a)
begin
  if ((cp_state_a === 1'bx || cp_state_a === 1'bz) && csb_state_a === 1'b0)
  begin
    warning("CPA is unknown.");
    address_a = -1;
    memoryerror_a;
    int_bus_a = `numout'bx;
    error_a = 1;
  end
end

always @(cp_state_b or csb_state_b)
begin
  if ((cp_state_b === 1'bx || cp_state_b === 1'bz) && csb_state_b === 1'b0)
  begin
    warning("CPB is unknown.");
    address_b = -1;
    memoryerror_b;
    int_bus_b = `numout'bx;
    error_b = 1;
  end
end

always @(oeb_state_a or csb_state_a)
begin
  outctrl_a = oeb_state_a | csb_state_a;
end

always @(oeb_state_b or csb_state_b)
begin
  outctrl_b = oeb_state_b | csb_state_b;
end

always @(posedge cp_state_a)
begin : ck_active_edge_a
  web_reg_a = web_state_a;
  reb_reg_a = reb_state_a;
  oeb_reg_a = oeb_state_a;
  csb_reg_a = csb_state_a;
  a_reg_a = a_state_a;
  i_reg_a = i_state_a;

  if ((csb_reg_a === 1'bx || csb_reg_a === 1'bz) && web_reg_a != 1'b1)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((web_reg_a === 1'bx || web_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((oeb_reg_a === 1'bx || oeb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((reb_reg_a === 1'bx || reb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ( ^a_reg_a === 1'bx || ^a_reg_a === 1'bz)
  begin
    address_a = -1;
    error_a = 1;
    warning("AA is unknown.");
    if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
    begin
      memoryerror_a;
    end
  end

  else if (address_a >= `worddepth)
  begin
    warning("AA is out of range.");
    error_a = 1;
  end

  else
  begin
    address_a = a_reg_a;
    error_a = 0;
  end

  if (!error_a)
  begin
    if (csb_reg_a === 1'b0)
    begin
      if (web_reg_a === 1'b0 && reb_reg_a === 1'b1)
      begin
	memory[address_a] = i_reg_a;
      end
      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b0)
      begin
        int_bus_a <= memory[address_a];
      end
      else if (web_reg_a === 1'b0 && reb_reg_a === 1'b0)
      begin
	memory[address_a] = i_reg_a;
        int_bus_a = i_reg_a;
      end
//      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b1)
//      begin
//	warning("both WEBA and REBA are not active.");
//      end
    end
  end
end

always @(posedge cp_state_b)
begin : ck_active_edge_b
  web_reg_b = web_state_b;
  reb_reg_b = reb_state_b;
  oeb_reg_b = oeb_state_b;
  csb_reg_b = csb_state_b;
  a_reg_b = a_state_b;
  i_reg_b = i_state_b;

  if ((csb_reg_b === 1'bx || csb_reg_b === 1'bz) && web_reg_b != 1'b1)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ((web_reg_b === 1'bx || web_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((oeb_reg_b === 1'bx || oeb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((reb_reg_b === 1'bx || reb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ( ^a_reg_b === 1'bx || ^a_reg_b === 1'bz)
  begin
    address_b = -1;
    error_b = 1;
    warning("AB is unknown.");
    if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
    begin
      memoryerror_b;
    end
  end

  else if (address_b >= `worddepth)
  begin
    warning("AB is out of range.");
    error_b = 1;
  end

  else
  begin
    address_b = a_reg_b;
    error_b = 0;
  end

  if (!error_b)
  begin
    if (csb_reg_b === 1'b0)
    begin
      if (web_reg_b === 1'b0 && reb_reg_b === 1'b1)
      begin
	memory[address_b] = i_reg_b;
      end
      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b0)
      begin
        int_bus_b <= memory[address_b];
      end
      else if (web_reg_b === 1'b0 && reb_reg_b === 1'b0)
      begin
	memory[address_b] = i_reg_b;
        int_bus_b = i_reg_b;
      end
//      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b1)
//      begin
//	warning("both WEBB and REBB are not active.");
//      end
    end
  end
end

always @(posedge cp_state_a)
begin
  if (a_state_a == a_state_b &&
//    web_state_a === 1'b0 &&
      csb_state_a === 1'b0 &&
      ~(web_state_a === 1'b1 && reb_state_a === 1'b1))
  begin
    confa = 1'b1;
  end
  else
  begin
    confa = 1'b0;
  end
end

always @(posedge cp_state_b)
begin
  if (a_state_a == a_state_b &&
//    web_state_b === 1'b0 &&
      csb_state_b === 1'b0 &&
      ~(web_state_b === 1'b1 && reb_state_b === 1'b1))
  begin
    confb = 1'b1;
  end
  else
  begin
    confb = 1'b0;
  end
end

always @(cm_cp_error)
begin : Write_conflict_Error
  if (reb_state_a === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_a = `numout'bx;
  end
  if (reb_state_b === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_b = `numout'bx;
  end
  if (web_state_a === 1'b0 && web_state_b === 1'b0)
  begin
    address_a = -1;
    address_b = -1;
    memoryerror_a;
  end
end  

always @(sh_cp_error_a)
begin : setup_ck_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_csb_error_a)
begin : setup_csb_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_a_error_a)
begin : setuphold_address_error_a
  if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_i_error_a)
begin : setuphold_i_error_a
  if (web_state_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_web_error_a)
begin : setuphold_web_error_a
  if (csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_reb_error_a)
begin : setuphold_reb_error_a
  if (csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
  end
end

//always @(sh_oeb_error_a)
//begin : setuphold_oeb_error_a
//  if (csb_reg_a === 1'b0)
//  begin
//    #0.01 int_bus_a = `numout'bx;
//  end
//end

always @(sh_cp_error_b)
begin : setup_ck_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_csb_error_b)
begin : setup_csb_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_a_error_b)
begin : setuphold_address_error_b
  if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_i_error_b)
begin : setuphold_i_error_b
  if (web_state_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_web_error_b)
begin : setuphold_web_error_b
  if (csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_reb_error_b)
begin : setuphold_reb_error_b
  if (csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
  end
end

//always @(sh_oeb_error_b)
//begin : setuphold_oeb_error_b
//  if (csb_reg_b === 1'b0)
//  begin
//    #0.01 int_bus_b = `numout'bx;
//  end
//end

endmodule

`celldefine
`suppress_faults
`enable_portfaults

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

wire [`numaddr-1:0] AA;
wire CPA;
wire WEBA;
wire REBA;
wire OEBA;
wire CSBA;
wire [`numout-1:0] IA;
wire [`numout-1:0] OA;
wire [`numaddr-1:0] a_state_a;
wire cp_state_a;
wire web_state_a;
wire reb_state_a;
wire oeb_state_a;
wire csb_state_a;
wire [`numout-1:0] i_state_a;
wire [`numout-1:0] int_bus_a;

wire [`numaddr-1:0] AB;
wire CPB;
wire WEBB;
wire REBB;
wire OEBB;
wire CSBB;
wire [`numout-1:0] IB;
wire [`numout-1:0] OB;
wire [`numaddr-1:0] a_state_b;
wire cp_state_b;
wire web_state_b;
wire reb_state_b;
wire oeb_state_b;
wire csb_state_b;
wire [`numout-1:0] i_state_b;
wire [`numout-1:0] int_bus_b;

buf (a_state_a[5],AA[5]),
    (a_state_a[4],AA[4]),
    (a_state_a[3],AA[3]),
    (a_state_a[2],AA[2]),
    (a_state_a[1],AA[1]),
    (a_state_a[0],AA[0]);

buf (a_state_b[5],AB[5]),
    (a_state_b[4],AB[4]),
    (a_state_b[3],AB[3]),
    (a_state_b[2],AB[2]),
    (a_state_b[1],AB[1]),
    (a_state_b[0],AB[0]);

buf (cp_state_a,CPA);
buf (web_state_a,WEBA);
buf (reb_state_a,REBA);
buf (oeb_state_a,OEBA);
buf (csb_state_a,CSBA);

buf (cp_state_b,CPB);
buf (web_state_b,WEBB);
buf (reb_state_b,REBB);
buf (oeb_state_b,OEBB);
buf (csb_state_b,CSBB);

buf (i_state_a[7],IA[7]),
    (i_state_a[6],IA[6]),
    (i_state_a[5],IA[5]),
    (i_state_a[4],IA[4]),
    (i_state_a[3],IA[3]),
    (i_state_a[2],IA[2]),
    (i_state_a[1],IA[1]),
    (i_state_a[0],IA[0]);

buf (i_state_b[7],IB[7]),
    (i_state_b[6],IB[6]),
    (i_state_b[5],IB[5]),
    (i_state_b[4],IB[4]),
    (i_state_b[3],IB[3]),
    (i_state_b[2],IB[2]),
    (i_state_b[1],IB[1]),
    (i_state_b[0],IB[0]);

bufif0 (OA[7],int_bus_a[7],outctrl_a),
       (OA[6],int_bus_a[6],outctrl_a),
       (OA[5],int_bus_a[5],outctrl_a),
       (OA[4],int_bus_a[4],outctrl_a),
       (OA[3],int_bus_a[3],outctrl_a),
       (OA[2],int_bus_a[2],outctrl_a),
       (OA[1],int_bus_a[1],outctrl_a),
       (OA[0],int_bus_a[0],outctrl_a);

bufif0 (OB[7],int_bus_b[7],outctrl_b),
       (OB[6],int_bus_b[6],outctrl_b),
       (OB[5],int_bus_b[5],outctrl_b),
       (OB[4],int_bus_b[4],outctrl_b),
       (OB[3],int_bus_b[3],outctrl_b),
       (OB[2],int_bus_b[2],outctrl_b),
       (OB[1],int_bus_b[1],outctrl_b),
       (OB[0],int_bus_b[0],outctrl_b);

reg sh_a_error_a;
reg sh_cp_error_a;
reg sh_web_error_a;
reg sh_reb_error_a;
//reg sh_oeb_error_a;
reg sh_csb_error_a;
reg sh_i_error_a;
wire error_a;

reg sh_a_error_b;
reg sh_cp_error_b;
reg sh_web_error_b;
reg sh_reb_error_b;
//reg sh_oeb_error_b;
reg sh_csb_error_b;
reg sh_i_error_b;
wire error_b;

reg cm_cp_error;

rdpb18_64x8_g1_behave u1 (
	.a_state_a(a_state_a),
	.cp_state_a(cp_state_a),
	.web_state_a(web_state_a),
	.reb_state_a(reb_state_a),
	.oeb_state_a(oeb_state_a),
	.csb_state_a(csb_state_a),
	.i_state_a(i_state_a),
	.int_bus_a(int_bus_a),
	.sh_a_error_a(sh_a_error_a),
	.sh_cp_error_a(sh_cp_error_a),
	.sh_web_error_a(sh_web_error_a),
	.sh_reb_error_a(sh_reb_error_a),
//	.sh_oeb_error_a(sh_oeb_error_a),
	.sh_csb_error_a(sh_csb_error_a),
	.sh_i_error_a(sh_i_error_a),
	.outctrl_a(outctrl_a),
	.error_a(error_a),
	
	.a_state_b(a_state_b),
	.cp_state_b(cp_state_b),
	.web_state_b(web_state_b),
	.reb_state_b(reb_state_b),
	.oeb_state_b(oeb_state_b),
	.csb_state_b(csb_state_b),
	.i_state_b(i_state_b),
	.int_bus_b(int_bus_b),
	.sh_a_error_b(sh_a_error_b),
	.sh_cp_error_b(sh_cp_error_b),
	.sh_web_error_b(sh_web_error_b),
	.sh_reb_error_b(sh_reb_error_b),
//	.sh_oeb_error_b(sh_oeb_error_b),
	.sh_csb_error_b(sh_csb_error_b),
	.sh_i_error_b(sh_i_error_b),
	.outctrl_b(outctrl_b),
	.error_b(error_b),

	.confa(confa),
	.confb(confb),
	.cm_cp_error(cm_cp_error)
	);
	
specify
  specparam df    = 1.0,
	    tacr  = 2.55*df,  // rise access time @Cload=0.0pF
	    tacf  = 2.55*df,  // fall access time @Cload=0.0pF
            tcyc  = 6.00*df,  // cycle time
            twh   = 3.00*df,  // minimum clock high time.
	    twl   = 3.00*df,  // minimum clock low time.
	    twes  = 0.75*df,  // web setup time
	    tweh  = 0.35*df,  // web hold time
	    tres  = 0.75*df,  // reb setup time
	    treh  = 0.35*df,  // reb hold time
	    tcs   = 0.75*df,  // csb setup time
	    tch   = 0.35*df,  // csb hold time
	    tadds = 0.50*df,  // address setup time
	    taddh = 0.65*df,  // address hold time
	    tis   = 0.40*df,  // data setup time
	    tih   = 1.30*df,  // data hold time
	    toh   = 1.50*df,  // oeb disbale time
	    tcm   = 4.65*df;  // cp conflict margin (if AA=AB && WEBA=WEBB="L")

  if (!error_a) (CPA => OA[0]) = (tacr,tacf);
  if (!error_a) (CPA => OA[1]) = (tacr,tacf);
  if (!error_a) (CPA => OA[2]) = (tacr,tacf);
  if (!error_a) (CPA => OA[3]) = (tacr,tacf);
  if (!error_a) (CPA => OA[4]) = (tacr,tacf);
  if (!error_a) (CPA => OA[5]) = (tacr,tacf);
  if (!error_a) (CPA => OA[6]) = (tacr,tacf);
  if (!error_a) (CPA => OA[7]) = (tacr,tacf);
  if (!error_a) (OEBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  
  if (!error_a) (CPB => OB[0]) = (tacr,tacf);
  if (!error_a) (CPB => OB[1]) = (tacr,tacf);
  if (!error_a) (CPB => OB[2]) = (tacr,tacf);
  if (!error_a) (CPB => OB[3]) = (tacr,tacf);
  if (!error_a) (CPB => OB[4]) = (tacr,tacf);
  if (!error_a) (CPB => OB[5]) = (tacr,tacf);
  if (!error_a) (CPB => OB[6]) = (tacr,tacf);
  if (!error_a) (CPB => OB[7]) = (tacr,tacf);
  if (!error_a) (OEBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  
 
  $setup(posedge WEBA,posedge CPA,twes,sh_web_error_a);
  $setup(negedge WEBA,posedge CPA,twes,sh_web_error_a);
  $hold(posedge CPA,negedge WEBA,tweh,sh_web_error_a);
  $hold(posedge CPA,posedge WEBA,tweh,sh_web_error_a);
  $setup(posedge REBA,posedge CPA,tres,sh_reb_error_a);
  $setup(negedge REBA,posedge CPA,tres,sh_reb_error_a);
  $hold(posedge CPA,posedge REBA,treh,sh_reb_error_a);
  $hold(posedge CPA,negedge REBA,treh,sh_reb_error_a);
//  $setup(posedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $setup(negedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $hold(posedge CPA,posedge OEBA,toeh,sh_oeb_error_a);
//  $hold(posedge CPA,negedge OEBA,toeh,sh_oeb_error_a);
  $setup(posedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[0],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[0],taddh,sh_a_error_a);
  $setup(posedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[1],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[1],taddh,sh_a_error_a);
  $setup(posedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[2],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[2],taddh,sh_a_error_a);
  $setup(posedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[3],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[3],taddh,sh_a_error_a);
  $setup(posedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[4],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[4],taddh,sh_a_error_a);
  $setup(posedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[5],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[5],taddh,sh_a_error_a);
  $setup(posedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $setup(negedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $hold(posedge CPA,posedge CSBA,tch,sh_csb_error_a);
  $hold(posedge CPA,negedge CSBA,tch,sh_csb_error_a);
  $setup(posedge IA[0],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[0],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[0],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[0],tih,sh_i_error_a);
  $setup(posedge IA[1],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[1],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[1],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[1],tih,sh_i_error_a);
  $setup(posedge IA[2],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[2],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[2],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[2],tih,sh_i_error_a);
  $setup(posedge IA[3],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[3],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[3],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[3],tih,sh_i_error_a);
  $setup(posedge IA[4],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[4],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[4],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[4],tih,sh_i_error_a);
  $setup(posedge IA[5],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[5],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[5],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[5],tih,sh_i_error_a);
  $setup(posedge IA[6],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[6],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[6],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[6],tih,sh_i_error_a);
  $setup(posedge IA[7],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[7],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[7],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[7],tih,sh_i_error_a);
  $width(posedge CPA,twh,0,sh_cp_error_a);
  $width(negedge CPA,twl,0,sh_cp_error_a);
  $period(posedge CPA,tcyc,sh_cp_error_a);
  $period(negedge CPA,tcyc);

  $setup(posedge WEBB,posedge CPB,twes,sh_web_error_b);
  $setup(negedge WEBB,posedge CPB,twes,sh_web_error_b);
  $hold(posedge CPB,negedge WEBB,tweh,sh_web_error_b);
  $hold(posedge CPB,posedge WEBB,tweh,sh_web_error_b);
  $setup(posedge REBB,posedge CPB,tres,sh_reb_error_b);
  $setup(negedge REBB,posedge CPB,tres,sh_reb_error_b);
  $hold(posedge CPB,posedge REBB,treh,sh_reb_error_b);
  $hold(posedge CPB,negedge REBB,treh,sh_reb_error_b);
//  $setup(posedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $setup(negedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $hold(posedge CPB,posedge OEBB,toeh,sh_oeb_error_b);
//  $hold(posedge CPB,negedge OEBB,toeh,sh_oeb_error_b);
  $setup(posedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[0],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[0],taddh,sh_a_error_b);
  $setup(posedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[1],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[1],taddh,sh_a_error_b);
  $setup(posedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[2],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[2],taddh,sh_a_error_b);
  $setup(posedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[3],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[3],taddh,sh_a_error_b);
  $setup(posedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[4],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[4],taddh,sh_a_error_b);
  $setup(posedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[5],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[5],taddh,sh_a_error_b);
  $setup(posedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $setup(negedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $hold(posedge CPB,posedge CSBB,tch,sh_csb_error_b);
  $hold(posedge CPB,negedge CSBB,tch,sh_csb_error_b);
  $setup(posedge IB[0],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[0],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[0],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[0],tih,sh_i_error_b);
  $setup(posedge IB[1],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[1],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[1],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[1],tih,sh_i_error_b);
  $setup(posedge IB[2],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[2],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[2],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[2],tih,sh_i_error_b);
  $setup(posedge IB[3],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[3],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[3],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[3],tih,sh_i_error_b);
  $setup(posedge IB[4],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[4],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[4],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[4],tih,sh_i_error_b);
  $setup(posedge IB[5],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[5],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[5],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[5],tih,sh_i_error_b);
  $setup(posedge IB[6],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[6],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[6],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[6],tih,sh_i_error_b);
  $setup(posedge IB[7],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[7],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[7],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[7],tih,sh_i_error_b);
  $width(posedge CPB,twh,0,sh_cp_error_b);
  $width(negedge CPB,twl,0,sh_cp_error_b);
  $period(posedge CPB,tcyc,sh_cp_error_b);
  $period(negedge CPB,tcyc);
  
  $setup(posedge confa,posedge confb,tcm,cm_cp_error);
  $setup(posedge confb,posedge confa,tcm,cm_cp_error);
  $hold(posedge confa,posedge confb,tcm,cm_cp_error);
  $hold(posedge confb,posedge confa,tcm,cm_cp_error);

endspecify

`undef numaddr
`undef numout
`undef worddepth
`undef verbose
endmodule
`nosuppress_faults
`disable_portfaults
`endcelldefine

`timescale 1ns/10ps
module rdpb18_64x18_g1_behave(
	a_state_a,
	cp_state_a,
	web_state_a,
	reb_state_a,
	oeb_state_a,
	csb_state_a,
	i_state_a,
	int_bus_a,
	sh_a_error_a,
	sh_cp_error_a,
	sh_web_error_a,
	sh_reb_error_a,
//	sh_oeb_error_a,
	sh_csb_error_a,
	sh_i_error_a,
	outctrl_a,
	error_a,
	a_state_b,
	cp_state_b,
	web_state_b,
	reb_state_b,
	oeb_state_b,
	csb_state_b,
	i_state_b,
	int_bus_b,
	sh_a_error_b,
	sh_cp_error_b,
	sh_web_error_b,
	sh_reb_error_b,
//	sh_oeb_error_b,
	sh_csb_error_b,
	sh_i_error_b,
	outctrl_b,
	error_b,
	confa,
	confb,
	cm_cp_error
	);

`define numaddr 6
`define numout 18
`define worddepth 64

`define verbose 2
`ifdef verbose_0
`undef verbose
`define verbose 0
`else
`endif
`ifdef verbose_1
`undef verbose
`define  verbose 1
`endif
`ifdef verbose_2
`undef verbose
`define verbose 2
`endif

input [`numaddr-1:0] a_state_a;
input cp_state_a;
input web_state_a;
input reb_state_a;
input oeb_state_a;
input csb_state_a;
input [`numout-1:0] i_state_a;
output [`numout-1:0] int_bus_a;
input sh_a_error_a;
input sh_web_error_a;
input sh_reb_error_a;
//input sh_oeb_error_a;
input sh_cp_error_a;
input sh_csb_error_a;
input sh_i_error_a;
output outctrl_a;
output error_a;

input [`numaddr-1:0] a_state_b;
input cp_state_b;
input web_state_b;
input reb_state_b;
input oeb_state_b;
input csb_state_b;
input [`numout-1:0] i_state_b;
output [`numout-1:0] int_bus_b;
input sh_a_error_b;
input sh_web_error_b;
input sh_reb_error_b;
//input sh_oeb_error_b;
input sh_cp_error_b;
input sh_csb_error_b;
input sh_i_error_b;
output outctrl_b;
output error_b;

output confa;
output confb;
input cm_cp_error;

reg [`numout-1:0] memory[`worddepth-1:0];
reg [`numout-1:0] int_bus_a;
reg outctrl_a;
reg error_a;
reg web_reg_a;
reg reb_reg_a;
reg oeb_reg_a;
reg csb_reg_a;
reg [`numaddr-1:0] a_reg_a;
reg [`numout-1:0] i_reg_a;
reg [`numout-1:0] out_bus_a;
integer n;
integer address_a;

reg [`numout-1:0] int_bus_b;
reg outctrl_b;
reg error_b;
reg web_reg_b;
reg reb_reg_b;
reg oeb_reg_b;
reg csb_reg_b;
reg [`numaddr-1:0] a_reg_b;
reg [`numout-1:0] i_reg_b;
reg [`numout-1:0] out_bus_b;
integer address_b;

reg confa;
reg confb;

initial
begin : initialize
  error_a = 1'b0;
  web_reg_a = 1'bx;
  reb_reg_a = 1'bx;
  oeb_reg_a = 1'bx;
  csb_reg_a = 1'bx;
  a_reg_a = `numaddr'bx;
  i_reg_a = `numout'bx;
  int_bus_a = `numout'bx;
  out_bus_a = `numout'bx;
  error_b = 1'b0;
  web_reg_b = 1'bx;
  reb_reg_b = 1'bx;
  oeb_reg_b = 1'bx;
  csb_reg_b = 1'bx;
  a_reg_b = `numaddr'bx;
  i_reg_b = `numout'bx;
  int_bus_b = `numout'bx;
  out_bus_b = `numout'bx;
  confa = 1'b0;
  confb = 1'b0;
  for (n=0; n < `worddepth; n = n + 1)
    memory[n] = `numout'bx;
end

task memoryerror_a;
  begin
    if (`verbose == 2)
    begin
      if (address_a == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_a] = `numout'bx;
      end
    end
  end
endtask

task memoryerror_b;
  begin
    if (`verbose == 2)
    begin
      if (address_b == -1)
      begin
	for (n=0; n < `worddepth; n = n + 1)
          memory[n] = `numout'bx;
      end
      else
      begin
	memory[address_b] = `numout'bx;
      end
    end
  end
endtask

task warning;
  input [1024:1] msg;
  begin
    if ($realtime != 0 && `verbose != 0)
    begin
      $display("%.1f : %m : %0s",$realtime,msg);
    end
  end
endtask

always @(negedge cp_state_a)
begin
  confa = 0;
end

always @(negedge cp_state_b)
begin
  confb = 0;
end

always @(cp_state_a or csb_state_a)
begin
  if ((cp_state_a === 1'bx || cp_state_a === 1'bz) && csb_state_a === 1'b0)
  begin
    warning("CPA is unknown.");
    address_a = -1;
    memoryerror_a;
    int_bus_a = `numout'bx;
    error_a = 1;
  end
end

always @(cp_state_b or csb_state_b)
begin
  if ((cp_state_b === 1'bx || cp_state_b === 1'bz) && csb_state_b === 1'b0)
  begin
    warning("CPB is unknown.");
    address_b = -1;
    memoryerror_b;
    int_bus_b = `numout'bx;
    error_b = 1;
  end
end

always @(oeb_state_a or csb_state_a)
begin
  outctrl_a = oeb_state_a | csb_state_a;
end

always @(oeb_state_b or csb_state_b)
begin
  outctrl_b = oeb_state_b | csb_state_b;
end

always @(posedge cp_state_a)
begin : ck_active_edge_a
  web_reg_a = web_state_a;
  reb_reg_a = reb_state_a;
  oeb_reg_a = oeb_state_a;
  csb_reg_a = csb_state_a;
  a_reg_a = a_state_a;
  i_reg_a = i_state_a;

  if ((csb_reg_a === 1'bx || csb_reg_a === 1'bz) && web_reg_a != 1'b1)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((web_reg_a === 1'bx || web_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((oeb_reg_a === 1'bx || oeb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ((reb_reg_a === 1'bx || reb_reg_a === 1'bz) && csb_reg_a === 1'b0)
  begin
    int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
    error_a = 1;
  end

  else if ( ^a_reg_a === 1'bx || ^a_reg_a === 1'bz)
  begin
    address_a = -1;
    error_a = 1;
    warning("AA is unknown.");
    if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
    begin
      memoryerror_a;
    end
  end

  else if (address_a >= `worddepth)
  begin
    warning("AA is out of range.");
    error_a = 1;
  end

  else
  begin
    address_a = a_reg_a;
    error_a = 0;
  end

  if (!error_a)
  begin
    if (csb_reg_a === 1'b0)
    begin
      if (web_reg_a === 1'b0 && reb_reg_a === 1'b1)
      begin
	memory[address_a] = i_reg_a;
      end
      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b0)
      begin
        int_bus_a <= memory[address_a];
      end
      else if (web_reg_a === 1'b0 && reb_reg_a === 1'b0)
      begin
	memory[address_a] = i_reg_a;
        int_bus_a = i_reg_a;
      end
//      else if (web_reg_a === 1'b1 && reb_reg_a === 1'b1)
//      begin
//	warning("both WEBA and REBA are not active.");
//      end
    end
  end
end

always @(posedge cp_state_b)
begin : ck_active_edge_b
  web_reg_b = web_state_b;
  reb_reg_b = reb_state_b;
  oeb_reg_b = oeb_state_b;
  csb_reg_b = csb_state_b;
  a_reg_b = a_state_b;
  i_reg_b = i_state_b;

  if ((csb_reg_b === 1'bx || csb_reg_b === 1'bz) && web_reg_b != 1'b1)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ((web_reg_b === 1'bx || web_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((oeb_reg_b === 1'bx || oeb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end
  else if ((reb_reg_b === 1'bx || reb_reg_b === 1'bz) && csb_reg_b === 1'b0)
  begin
    int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
    error_b = 1;
  end

  else if ( ^a_reg_b === 1'bx || ^a_reg_b === 1'bz)
  begin
    address_b = -1;
    error_b = 1;
    warning("AB is unknown.");
    if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
    begin
      memoryerror_b;
    end
  end

  else if (address_b >= `worddepth)
  begin
    warning("AB is out of range.");
    error_b = 1;
  end

  else
  begin
    address_b = a_reg_b;
    error_b = 0;
  end

  if (!error_b)
  begin
    if (csb_reg_b === 1'b0)
    begin
      if (web_reg_b === 1'b0 && reb_reg_b === 1'b1)
      begin
	memory[address_b] = i_reg_b;
      end
      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b0)
      begin
        int_bus_b <= memory[address_b];
      end
      else if (web_reg_b === 1'b0 && reb_reg_b === 1'b0)
      begin
	memory[address_b] = i_reg_b;
        int_bus_b = i_reg_b;
      end
//      else if (web_reg_b === 1'b1 && reb_reg_b === 1'b1)
//      begin
//	warning("both WEBB and REBB are not active.");
//      end
    end
  end
end

always @(posedge cp_state_a)
begin
  if (a_state_a == a_state_b &&
//    web_state_a === 1'b0 &&
      csb_state_a === 1'b0 &&
      ~(web_state_a === 1'b1 && reb_state_a === 1'b1))
  begin
    confa = 1'b1;
  end
  else
  begin
    confa = 1'b0;
  end
end

always @(posedge cp_state_b)
begin
  if (a_state_a == a_state_b &&
//    web_state_b === 1'b0 &&
      csb_state_b === 1'b0 &&
      ~(web_state_b === 1'b1 && reb_state_b === 1'b1))
  begin
    confb = 1'b1;
  end
  else
  begin
    confb = 1'b0;
  end
end

always @(cm_cp_error)
begin : Write_conflict_Error
  if (reb_state_a === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_a = `numout'bx;
  end
  if (reb_state_b === 1'b0 && (web_state_a === 1'b0 || web_state_b === 1'b0))
  begin
    #0.01 int_bus_b = `numout'bx;
  end
  if (web_state_a === 1'b0 && web_state_b === 1'b0)
  begin
    address_a = -1;
    address_b = -1;
    memoryerror_a;
  end
end  

always @(sh_cp_error_a)
begin : setup_ck_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_csb_error_a)
begin : setup_csb_error_a
  address_a = -1;
  memoryerror_a;
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
  #0.01 int_bus_a = `numout'bx;
  end
end

always @(sh_a_error_a)
begin : setuphold_address_error_a
  if (web_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
  if (reb_reg_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_i_error_a)
begin : setuphold_i_error_a
  if (web_state_a === 1'b0 && csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_web_error_a)
begin : setuphold_web_error_a
  if (csb_reg_a === 1'b0)
  begin
    address_a = -1;
    memoryerror_a;
  end
end

always @(sh_reb_error_a)
begin : setuphold_reb_error_a
  if (csb_reg_a === 1'b0)
  begin
    #0.01 int_bus_a = `numout'bx;
  end
end

//always @(sh_oeb_error_a)
//begin : setuphold_oeb_error_a
//  if (csb_reg_a === 1'b0)
//  begin
//    #0.01 int_bus_a = `numout'bx;
//  end
//end

always @(sh_cp_error_b)
begin : setup_ck_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_csb_error_b)
begin : setup_csb_error_b
  address_b = -1;
  memoryerror_b;
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
  #0.01 int_bus_b = `numout'bx;
  end
end

always @(sh_a_error_b)
begin : setuphold_address_error_b
  if (web_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
  if (reb_reg_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_i_error_b)
begin : setuphold_i_error_b
  if (web_state_b === 1'b0 && csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_web_error_b)
begin : setuphold_web_error_b
  if (csb_reg_b === 1'b0)
  begin
    address_b = -1;
    memoryerror_b;
  end
end

always @(sh_reb_error_b)
begin : setuphold_reb_error_b
  if (csb_reg_b === 1'b0)
  begin
    #0.01 int_bus_b = `numout'bx;
  end
end

//always @(sh_oeb_error_b)
//begin : setuphold_oeb_error_b
//  if (csb_reg_b === 1'b0)
//  begin
//    #0.01 int_bus_b = `numout'bx;
//  end
//end

endmodule

`celldefine
`suppress_faults
`enable_portfaults

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

wire [`numaddr-1:0] AA;
wire CPA;
wire WEBA;
wire REBA;
wire OEBA;
wire CSBA;
wire [`numout-1:0] IA;
wire [`numout-1:0] OA;
wire [`numaddr-1:0] a_state_a;
wire cp_state_a;
wire web_state_a;
wire reb_state_a;
wire oeb_state_a;
wire csb_state_a;
wire [`numout-1:0] i_state_a;
wire [`numout-1:0] int_bus_a;

wire [`numaddr-1:0] AB;
wire CPB;
wire WEBB;
wire REBB;
wire OEBB;
wire CSBB;
wire [`numout-1:0] IB;
wire [`numout-1:0] OB;
wire [`numaddr-1:0] a_state_b;
wire cp_state_b;
wire web_state_b;
wire reb_state_b;
wire oeb_state_b;
wire csb_state_b;
wire [`numout-1:0] i_state_b;
wire [`numout-1:0] int_bus_b;

buf (a_state_a[5],AA[5]),
    (a_state_a[4],AA[4]),
    (a_state_a[3],AA[3]),
    (a_state_a[2],AA[2]),
    (a_state_a[1],AA[1]),
    (a_state_a[0],AA[0]);

buf (a_state_b[5],AB[5]),
    (a_state_b[4],AB[4]),
    (a_state_b[3],AB[3]),
    (a_state_b[2],AB[2]),
    (a_state_b[1],AB[1]),
    (a_state_b[0],AB[0]);

buf (cp_state_a,CPA);
buf (web_state_a,WEBA);
buf (reb_state_a,REBA);
buf (oeb_state_a,OEBA);
buf (csb_state_a,CSBA);

buf (cp_state_b,CPB);
buf (web_state_b,WEBB);
buf (reb_state_b,REBB);
buf (oeb_state_b,OEBB);
buf (csb_state_b,CSBB);

buf (i_state_a[17],IA[17]),
    (i_state_a[16],IA[16]),
    (i_state_a[15],IA[15]),
    (i_state_a[14],IA[14]),
    (i_state_a[13],IA[13]),
    (i_state_a[12],IA[12]),
    (i_state_a[11],IA[11]),
    (i_state_a[10],IA[10]),
    (i_state_a[9],IA[9]),
    (i_state_a[8],IA[8]),
    (i_state_a[7],IA[7]),
    (i_state_a[6],IA[6]),
    (i_state_a[5],IA[5]),
    (i_state_a[4],IA[4]),
    (i_state_a[3],IA[3]),
    (i_state_a[2],IA[2]),
    (i_state_a[1],IA[1]),
    (i_state_a[0],IA[0]);

buf (i_state_b[17],IB[17]),
    (i_state_b[16],IB[16]),
    (i_state_b[15],IB[15]),
    (i_state_b[14],IB[14]),
    (i_state_b[13],IB[13]),
    (i_state_b[12],IB[12]),
    (i_state_b[11],IB[11]),
    (i_state_b[10],IB[10]),
    (i_state_b[9],IB[9]),
    (i_state_b[8],IB[8]),
    (i_state_b[7],IB[7]),
    (i_state_b[6],IB[6]),
    (i_state_b[5],IB[5]),
    (i_state_b[4],IB[4]),
    (i_state_b[3],IB[3]),
    (i_state_b[2],IB[2]),
    (i_state_b[1],IB[1]),
    (i_state_b[0],IB[0]);

bufif0 (OA[17],int_bus_a[17],outctrl_a),
       (OA[16],int_bus_a[16],outctrl_a),
       (OA[15],int_bus_a[15],outctrl_a),
       (OA[14],int_bus_a[14],outctrl_a),
       (OA[13],int_bus_a[13],outctrl_a),
       (OA[12],int_bus_a[12],outctrl_a),
       (OA[11],int_bus_a[11],outctrl_a),
       (OA[10],int_bus_a[10],outctrl_a),
       (OA[9],int_bus_a[9],outctrl_a),
       (OA[8],int_bus_a[8],outctrl_a),
       (OA[7],int_bus_a[7],outctrl_a),
       (OA[6],int_bus_a[6],outctrl_a),
       (OA[5],int_bus_a[5],outctrl_a),
       (OA[4],int_bus_a[4],outctrl_a),
       (OA[3],int_bus_a[3],outctrl_a),
       (OA[2],int_bus_a[2],outctrl_a),
       (OA[1],int_bus_a[1],outctrl_a),
       (OA[0],int_bus_a[0],outctrl_a);

bufif0 (OB[17],int_bus_b[17],outctrl_b),
       (OB[16],int_bus_b[16],outctrl_b),
       (OB[15],int_bus_b[15],outctrl_b),
       (OB[14],int_bus_b[14],outctrl_b),
       (OB[13],int_bus_b[13],outctrl_b),
       (OB[12],int_bus_b[12],outctrl_b),
       (OB[11],int_bus_b[11],outctrl_b),
       (OB[10],int_bus_b[10],outctrl_b),
       (OB[9],int_bus_b[9],outctrl_b),
       (OB[8],int_bus_b[8],outctrl_b),
       (OB[7],int_bus_b[7],outctrl_b),
       (OB[6],int_bus_b[6],outctrl_b),
       (OB[5],int_bus_b[5],outctrl_b),
       (OB[4],int_bus_b[4],outctrl_b),
       (OB[3],int_bus_b[3],outctrl_b),
       (OB[2],int_bus_b[2],outctrl_b),
       (OB[1],int_bus_b[1],outctrl_b),
       (OB[0],int_bus_b[0],outctrl_b);

reg sh_a_error_a;
reg sh_cp_error_a;
reg sh_web_error_a;
reg sh_reb_error_a;
//reg sh_oeb_error_a;
reg sh_csb_error_a;
reg sh_i_error_a;
wire error_a;

reg sh_a_error_b;
reg sh_cp_error_b;
reg sh_web_error_b;
reg sh_reb_error_b;
//reg sh_oeb_error_b;
reg sh_csb_error_b;
reg sh_i_error_b;
wire error_b;

reg cm_cp_error;

rdpb18_64x18_g1_behave u1 (
	.a_state_a(a_state_a),
	.cp_state_a(cp_state_a),
	.web_state_a(web_state_a),
	.reb_state_a(reb_state_a),
	.oeb_state_a(oeb_state_a),
	.csb_state_a(csb_state_a),
	.i_state_a(i_state_a),
	.int_bus_a(int_bus_a),
	.sh_a_error_a(sh_a_error_a),
	.sh_cp_error_a(sh_cp_error_a),
	.sh_web_error_a(sh_web_error_a),
	.sh_reb_error_a(sh_reb_error_a),
//	.sh_oeb_error_a(sh_oeb_error_a),
	.sh_csb_error_a(sh_csb_error_a),
	.sh_i_error_a(sh_i_error_a),
	.outctrl_a(outctrl_a),
	.error_a(error_a),
	
	.a_state_b(a_state_b),
	.cp_state_b(cp_state_b),
	.web_state_b(web_state_b),
	.reb_state_b(reb_state_b),
	.oeb_state_b(oeb_state_b),
	.csb_state_b(csb_state_b),
	.i_state_b(i_state_b),
	.int_bus_b(int_bus_b),
	.sh_a_error_b(sh_a_error_b),
	.sh_cp_error_b(sh_cp_error_b),
	.sh_web_error_b(sh_web_error_b),
	.sh_reb_error_b(sh_reb_error_b),
//	.sh_oeb_error_b(sh_oeb_error_b),
	.sh_csb_error_b(sh_csb_error_b),
	.sh_i_error_b(sh_i_error_b),
	.outctrl_b(outctrl_b),
	.error_b(error_b),

	.confa(confa),
	.confb(confb),
	.cm_cp_error(cm_cp_error)
	);
	
specify
  specparam df    = 1.0,
	    tacr  = 2.55*df,  // rise access time @Cload=0.0pF
	    tacf  = 2.55*df,  // fall access time @Cload=0.0pF
            tcyc  = 6.00*df,  // cycle time
            twh   = 3.00*df,  // minimum clock high time.
	    twl   = 3.00*df,  // minimum clock low time.
	    twes  = 0.75*df,  // web setup time
	    tweh  = 0.35*df,  // web hold time
	    tres  = 0.75*df,  // reb setup time
	    treh  = 0.35*df,  // reb hold time
	    tcs   = 0.75*df,  // csb setup time
	    tch   = 0.35*df,  // csb hold time
	    tadds = 0.50*df,  // address setup time
	    taddh = 0.65*df,  // address hold time
	    tis   = 0.40*df,  // data setup time
	    tih   = 1.30*df,  // data hold time
	    toh   = 1.50*df,  // oeb disbale time
	    tcm   = 4.65*df;  // cp conflict margin (if AA=AB && WEBA=WEBB="L")

  if (!error_a) (CPA => OA[0]) = (tacr,tacf);
  if (!error_a) (CPA => OA[1]) = (tacr,tacf);
  if (!error_a) (CPA => OA[2]) = (tacr,tacf);
  if (!error_a) (CPA => OA[3]) = (tacr,tacf);
  if (!error_a) (CPA => OA[4]) = (tacr,tacf);
  if (!error_a) (CPA => OA[5]) = (tacr,tacf);
  if (!error_a) (CPA => OA[6]) = (tacr,tacf);
  if (!error_a) (CPA => OA[7]) = (tacr,tacf);
  if (!error_a) (CPA => OA[8]) = (tacr,tacf);
  if (!error_a) (CPA => OA[9]) = (tacr,tacf);
  if (!error_a) (CPA => OA[10]) = (tacr,tacf);
  if (!error_a) (CPA => OA[11]) = (tacr,tacf);
  if (!error_a) (CPA => OA[12]) = (tacr,tacf);
  if (!error_a) (CPA => OA[13]) = (tacr,tacf);
  if (!error_a) (CPA => OA[14]) = (tacr,tacf);
  if (!error_a) (CPA => OA[15]) = (tacr,tacf);
  if (!error_a) (CPA => OA[16]) = (tacr,tacf);
  if (!error_a) (CPA => OA[17]) = (tacr,tacf);
  if (!error_a) (OEBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBA => OA[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBA => OA[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  
  if (!error_a) (CPB => OB[0]) = (tacr,tacf);
  if (!error_a) (CPB => OB[1]) = (tacr,tacf);
  if (!error_a) (CPB => OB[2]) = (tacr,tacf);
  if (!error_a) (CPB => OB[3]) = (tacr,tacf);
  if (!error_a) (CPB => OB[4]) = (tacr,tacf);
  if (!error_a) (CPB => OB[5]) = (tacr,tacf);
  if (!error_a) (CPB => OB[6]) = (tacr,tacf);
  if (!error_a) (CPB => OB[7]) = (tacr,tacf);
  if (!error_a) (CPB => OB[8]) = (tacr,tacf);
  if (!error_a) (CPB => OB[9]) = (tacr,tacf);
  if (!error_a) (CPB => OB[10]) = (tacr,tacf);
  if (!error_a) (CPB => OB[11]) = (tacr,tacf);
  if (!error_a) (CPB => OB[12]) = (tacr,tacf);
  if (!error_a) (CPB => OB[13]) = (tacr,tacf);
  if (!error_a) (CPB => OB[14]) = (tacr,tacf);
  if (!error_a) (CPB => OB[15]) = (tacr,tacf);
  if (!error_a) (CPB => OB[16]) = (tacr,tacf);
  if (!error_a) (CPB => OB[17]) = (tacr,tacf);
  if (!error_a) (OEBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (OEBB => OB[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[0]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[1]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[2]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[3]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[4]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[5]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[6]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[7]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[8]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[9]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[10]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[11]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[12]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[13]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[14]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[15]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[16]) = (tacr,tacf,toh,tacr,toh,tacf);
  if (!error_a) (CSBB => OB[17]) = (tacr,tacf,toh,tacr,toh,tacf);
  
 
  $setup(posedge WEBA,posedge CPA,twes,sh_web_error_a);
  $setup(negedge WEBA,posedge CPA,twes,sh_web_error_a);
  $hold(posedge CPA,negedge WEBA,tweh,sh_web_error_a);
  $hold(posedge CPA,posedge WEBA,tweh,sh_web_error_a);
  $setup(posedge REBA,posedge CPA,tres,sh_reb_error_a);
  $setup(negedge REBA,posedge CPA,tres,sh_reb_error_a);
  $hold(posedge CPA,posedge REBA,treh,sh_reb_error_a);
  $hold(posedge CPA,negedge REBA,treh,sh_reb_error_a);
//  $setup(posedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $setup(negedge OEBA,posedge CPA,toes,sh_oeb_error_a);
//  $hold(posedge CPA,posedge OEBA,toeh,sh_oeb_error_a);
//  $hold(posedge CPA,negedge OEBA,toeh,sh_oeb_error_a);
  $setup(posedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[0],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[0],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[0],taddh,sh_a_error_a);
  $setup(posedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[1],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[1],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[1],taddh,sh_a_error_a);
  $setup(posedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[2],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[2],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[2],taddh,sh_a_error_a);
  $setup(posedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[3],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[3],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[3],taddh,sh_a_error_a);
  $setup(posedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[4],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[4],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[4],taddh,sh_a_error_a);
  $setup(posedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $setup(negedge AA[5],posedge CPA,tadds,sh_a_error_a);
  $hold(posedge CPA,posedge AA[5],taddh,sh_a_error_a);
  $hold(posedge CPA,negedge AA[5],taddh,sh_a_error_a);
  $setup(posedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $setup(negedge CSBA,posedge CPA,tcs,sh_csb_error_a);
  $hold(posedge CPA,posedge CSBA,tch,sh_csb_error_a);
  $hold(posedge CPA,negedge CSBA,tch,sh_csb_error_a);
  $setup(posedge IA[0],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[0],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[0],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[0],tih,sh_i_error_a);
  $setup(posedge IA[1],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[1],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[1],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[1],tih,sh_i_error_a);
  $setup(posedge IA[2],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[2],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[2],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[2],tih,sh_i_error_a);
  $setup(posedge IA[3],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[3],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[3],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[3],tih,sh_i_error_a);
  $setup(posedge IA[4],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[4],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[4],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[4],tih,sh_i_error_a);
  $setup(posedge IA[5],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[5],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[5],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[5],tih,sh_i_error_a);
  $setup(posedge IA[6],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[6],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[6],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[6],tih,sh_i_error_a);
  $setup(posedge IA[7],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[7],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[7],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[7],tih,sh_i_error_a);
  $setup(posedge IA[8],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[8],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[8],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[8],tih,sh_i_error_a);
  $setup(posedge IA[9],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[9],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[9],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[9],tih,sh_i_error_a);
  $setup(posedge IA[10],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[10],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[10],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[10],tih,sh_i_error_a);
  $setup(posedge IA[11],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[11],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[11],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[11],tih,sh_i_error_a);
  $setup(posedge IA[12],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[12],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[12],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[12],tih,sh_i_error_a);
  $setup(posedge IA[13],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[13],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[13],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[13],tih,sh_i_error_a);
  $setup(posedge IA[14],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[14],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[14],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[14],tih,sh_i_error_a);
  $setup(posedge IA[15],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[15],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[15],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[15],tih,sh_i_error_a);
  $setup(posedge IA[16],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[16],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[16],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[16],tih,sh_i_error_a);
  $setup(posedge IA[17],posedge CPA,tis,sh_i_error_a);
  $setup(negedge IA[17],posedge CPA,tis,sh_i_error_a);
  $hold(posedge CPA,posedge IA[17],tih,sh_i_error_a);
  $hold(posedge CPA,negedge IA[17],tih,sh_i_error_a);
  $width(posedge CPA,twh,0,sh_cp_error_a);
  $width(negedge CPA,twl,0,sh_cp_error_a);
  $period(posedge CPA,tcyc,sh_cp_error_a);
  $period(negedge CPA,tcyc);

  $setup(posedge WEBB,posedge CPB,twes,sh_web_error_b);
  $setup(negedge WEBB,posedge CPB,twes,sh_web_error_b);
  $hold(posedge CPB,negedge WEBB,tweh,sh_web_error_b);
  $hold(posedge CPB,posedge WEBB,tweh,sh_web_error_b);
  $setup(posedge REBB,posedge CPB,tres,sh_reb_error_b);
  $setup(negedge REBB,posedge CPB,tres,sh_reb_error_b);
  $hold(posedge CPB,posedge REBB,treh,sh_reb_error_b);
  $hold(posedge CPB,negedge REBB,treh,sh_reb_error_b);
//  $setup(posedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $setup(negedge OEBB,posedge CPB,toes,sh_oeb_error_b);
//  $hold(posedge CPB,posedge OEBB,toeh,sh_oeb_error_b);
//  $hold(posedge CPB,negedge OEBB,toeh,sh_oeb_error_b);
  $setup(posedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[0],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[0],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[0],taddh,sh_a_error_b);
  $setup(posedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[1],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[1],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[1],taddh,sh_a_error_b);
  $setup(posedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[2],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[2],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[2],taddh,sh_a_error_b);
  $setup(posedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[3],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[3],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[3],taddh,sh_a_error_b);
  $setup(posedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[4],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[4],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[4],taddh,sh_a_error_b);
  $setup(posedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $setup(negedge AB[5],posedge CPB,tadds,sh_a_error_b);
  $hold(posedge CPB,posedge AB[5],taddh,sh_a_error_b);
  $hold(posedge CPB,negedge AB[5],taddh,sh_a_error_b);
  $setup(posedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $setup(negedge CSBB,posedge CPB,tcs,sh_csb_error_b);
  $hold(posedge CPB,posedge CSBB,tch,sh_csb_error_b);
  $hold(posedge CPB,negedge CSBB,tch,sh_csb_error_b);
  $setup(posedge IB[0],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[0],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[0],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[0],tih,sh_i_error_b);
  $setup(posedge IB[1],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[1],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[1],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[1],tih,sh_i_error_b);
  $setup(posedge IB[2],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[2],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[2],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[2],tih,sh_i_error_b);
  $setup(posedge IB[3],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[3],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[3],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[3],tih,sh_i_error_b);
  $setup(posedge IB[4],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[4],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[4],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[4],tih,sh_i_error_b);
  $setup(posedge IB[5],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[5],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[5],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[5],tih,sh_i_error_b);
  $setup(posedge IB[6],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[6],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[6],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[6],tih,sh_i_error_b);
  $setup(posedge IB[7],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[7],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[7],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[7],tih,sh_i_error_b);
  $setup(posedge IB[8],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[8],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[8],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[8],tih,sh_i_error_b);
  $setup(posedge IB[9],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[9],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[9],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[9],tih,sh_i_error_b);
  $setup(posedge IB[10],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[10],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[10],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[10],tih,sh_i_error_b);
  $setup(posedge IB[11],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[11],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[11],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[11],tih,sh_i_error_b);
  $setup(posedge IB[12],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[12],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[12],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[12],tih,sh_i_error_b);
  $setup(posedge IB[13],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[13],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[13],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[13],tih,sh_i_error_b);
  $setup(posedge IB[14],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[14],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[14],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[14],tih,sh_i_error_b);
  $setup(posedge IB[15],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[15],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[15],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[15],tih,sh_i_error_b);
  $setup(posedge IB[16],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[16],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[16],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[16],tih,sh_i_error_b);
  $setup(posedge IB[17],posedge CPB,tis,sh_i_error_b);
  $setup(negedge IB[17],posedge CPB,tis,sh_i_error_b);
  $hold(posedge CPB,posedge IB[17],tih,sh_i_error_b);
  $hold(posedge CPB,negedge IB[17],tih,sh_i_error_b);
  $width(posedge CPB,twh,0,sh_cp_error_b);
  $width(negedge CPB,twl,0,sh_cp_error_b);
  $period(posedge CPB,tcyc,sh_cp_error_b);
  $period(negedge CPB,tcyc);
  
  $setup(posedge confa,posedge confb,tcm,cm_cp_error);
  $setup(posedge confb,posedge confa,tcm,cm_cp_error);
  $hold(posedge confa,posedge confb,tcm,cm_cp_error);
  $hold(posedge confb,posedge confa,tcm,cm_cp_error);

endspecify

`undef numaddr
`undef numout
`undef worddepth
`undef verbose
endmodule
`nosuppress_faults
`disable_portfaults
`endcelldefine
