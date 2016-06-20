//
// Copyright (c) 2003 ROHM CO.,LTD.
// CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ROHM CO.,LTD.
// +------------------------------------------------------------+
// | ROHM BU40N1 0.18um 1.8V/3.3V process Single port RAM library |
// +------------------------------------------------------------+
//  Verilog model with Timing
//
//  Library Name    :  RV18RS182
//  Revision        :  1.0
//  Date            :  06-Apr-2004
//
//  Operating_conditions
//      Process     :  TT
//      Temperature :  25`C
//      Voltage     :  1.8V
//
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 13:22:41 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_128x16m8_g1
// Memory Size:       128 words x 16 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [6:0]
//                 D  [15:0]
//                 WEM  [1:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [15:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_128x16m8_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [15:0] Q;
wire [15:0] Q;

input [6:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [15:0]    Q_tmp;
wire [6:0]    ADR_buf;
wire [15:0]    D_buf;
wire [1:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [6:0] ADR_buf_L;
reg [6:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [1:0] WEMbus;
wire [1:0] WEMbus_eff;
wire [1:0] WEMbus_eff_L;
reg [1:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_128x16m8_g1 #(MES_ALL,7, 16, 128,2) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [6:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 6; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 127) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 127) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.388,
        Tcqx =  0.605,

        Toq  =  0.422,
        Toqz =  0.428,

        Tcc  =  1.402,
        Tcl  =  0.563,
        Tch  =  0.521,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.048,

        Twmc  =  0.352,
        Tcwmx =  0.048,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_128x16m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=7, I_bit=16, I_word=128, bsel_bit=2;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_128x16m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_128x16m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_128x16m8_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_128x16m8_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_128x16m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_128x16m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 2'b00) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_128x16m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 127\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_128x16m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_128x16m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 13:26:22 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_128x24m4_g1
// Memory Size:       128 words x 24 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [6:0]
//                 D  [23:0]
//                 WEM  [2:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [23:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_128x24m4_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [23:0] Q;
wire [23:0] Q;

input [6:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [23:0]    Q_tmp;
wire [6:0]    ADR_buf;
wire [23:0]    D_buf;
wire [2:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [6:0] ADR_buf_L;
reg [6:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [2:0] WEMbus;
wire [2:0] WEMbus_eff;
wire [2:0] WEMbus_eff_L;
reg [2:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_128x24m4_g1 #(MES_ALL,7, 24, 128,3) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [6:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 6; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 127) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 127) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.386,
        Tcqx =  0.624,

        Toq  =  0.386,
        Toqz =  0.397,

        Tcc  =  1.400,
        Tcl  =  0.588,
        Tch  =  0.561,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.032,

        Twmc  =  0.352,
        Tcwmx =  0.032,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_128x24m4_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=7, I_bit=24, I_word=128, bsel_bit=3;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_128x24m4_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_128x24m4_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_128x24m4_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_128x24m4_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_128x24m4_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_128x24m4_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 3'b000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_128x24m4_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 127\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_128x24m4_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_128x24m4_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 13:30:16 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_128x32m4_g1
// Memory Size:       128 words x 32 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [6:0]
//                 D  [31:0]
//                 WEM  [3:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [31:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_128x32m4_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [31:0] Q;
wire [31:0] Q;

input [6:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [31:0]    Q_tmp;
wire [6:0]    ADR_buf;
wire [31:0]    D_buf;
wire [3:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [6:0] ADR_buf_L;
reg [6:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [3:0] WEMbus;
wire [3:0] WEMbus_eff;
wire [3:0] WEMbus_eff_L;
reg [3:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );
buf D_buf_u24 ( D_buf[24], D[24] );
buf D_buf_u25 ( D_buf[25], D[25] );
buf D_buf_u26 ( D_buf[26], D[26] );
buf D_buf_u27 ( D_buf[27], D[27] );
buf D_buf_u28 ( D_buf[28], D[28] );
buf D_buf_u29 ( D_buf[29], D[29] );
buf D_buf_u30 ( D_buf[30], D[30] );
buf D_buf_u31 ( D_buf[31], D[31] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );
buf WEM_buf_u3 ( WEM_buf[3], WEM[3] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_128x32m4_g1 #(MES_ALL,7, 32, 128,4) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [6:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 6; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 127) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 127) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
bufif1 u_Q_24 (Q[24], Q_tmp[24], OEeff_del);
bufif1 u_Q_25 (Q[25], Q_tmp[25], OEeff_del);
bufif1 u_Q_26 (Q[26], Q_tmp[26], OEeff_del);
bufif1 u_Q_27 (Q[27], Q_tmp[27], OEeff_del);
bufif1 u_Q_28 (Q[28], Q_tmp[28], OEeff_del);
bufif1 u_Q_29 (Q[29], Q_tmp[29], OEeff_del);
bufif1 u_Q_30 (Q[30], Q_tmp[30], OEeff_del);
bufif1 u_Q_31 (Q[31], Q_tmp[31], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.430,
        Tcqx =  0.644,

        Toq  =  0.419,
        Toqz =  0.439,

        Tcc  =  1.445,
        Tcl  =  0.588,
        Tch  =  0.562,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.051,

        Twmc  =  0.352,
        Tcwmx =  0.051,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[24] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[25] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[26] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[27] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[28] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[29] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[30] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[31] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[24] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[25] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[26] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[27] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[28] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[29] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[30] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[31] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_128x32m4_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=7, I_bit=32, I_word=128, bsel_bit=4;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[3]}},{8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_128x32m4_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_128x32m4_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_128x32m4_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_128x32m4_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_128x32m4_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_128x32m4_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 4'b0000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_128x32m4_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 127\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_128x32m4_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_128x32m4_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 13:19:13 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_128x8m8_g1
// Memory Size:       128 words x 8 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [6:0]
//                 D  [7:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [7:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_128x8m8_g1 ( Q, ADR, D,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [7:0] Q;
wire [7:0] Q;

input [6:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [7:0]    Q_tmp;
wire [6:0]    ADR_buf;
wire [7:0]    D_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  ME_buf_L;
reg  WE_buf_L;
reg [6:0] ADR_buf_L;
reg [6:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_128x8m8_g1 #(MES_ALL,7, 8, 128) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [6:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 6; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 127) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 127) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf );
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.268,
        Tcqx =  0.574,

        Toq  =  0.335,
        Toqz =  0.352,

        Tcc  =  1.281,
        Tcl  =  0.561,
        Tch  =  0.518,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.357,
        Tcdx =  0.010,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_128x8m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk); 
parameter MES_ALL = "ON", A_bit=7, I_bit=8, I_word=128;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg MElatched;
reg ME_chk;
real CLKA_T;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok} ) // only 1 and 0

  3'b111   : ;                                                // everything ok!!!

  3'b101,
  3'b100   : corrupt_cur_loc(ADRlatched);          // WE is unstable

  3'b110   : if (WElatched !== 1'b0)
              corrupt_cur_loc(ADRlatched);         // Data is unstable
  3'b000,
  3'b001   : corrupt_all_loc(flaga_range_ok);            // ADR and WE unstable
  3'b010,
  3'b011   : if (WElatched !== 1'b0)    // ADR unstable, WE stable
              corrupt_all_loc(flaga_range_ok);
 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_128x8m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_128x8m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_128x8m8_g1_core)",$realtime);
    end  
   end 
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_128x8m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_128x8m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_128x8m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 127\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_128x8m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        if (flaga_we_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         mem_core_array[ADRlatched] = Dlatched;  // write data in
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_128x8m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 15:49:45 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_16kx16m16_g1
// Memory Size:       16384 words x 16 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [13:0]
//                 D  [15:0]
//                 WEM  [1:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [15:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_16kx16m16_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [15:0] Q;
wire [15:0] Q;

input [13:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [15:0]    Q_tmp;
wire [13:0]    ADR_buf;
wire [15:0]    D_buf;
wire [1:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [13:0] ADR_buf_L;
reg [13:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [1:0] WEMbus;
wire [1:0] WEMbus_eff;
wire [1:0] WEMbus_eff_L;
reg [1:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );
buf ADR_buf_u12 ( ADR_buf[12], ADR[12] );
buf ADR_buf_u13 ( ADR_buf[13], ADR[13] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_16kx16m16_g1 #(MES_ALL,14, 16, 16384,2) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [13:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 13; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 16383) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 16383) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  2.509,
        Tcqx =  0.696,

        Toq  =  0.459,
        Toqz =  0.480,

        Tcc  =  2.534,
        Tcl  =  0.561,
        Tch  =  0.520,

        Tac  =  0.505,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.071,

        Twmc  =  0.352,
        Tcwmx =  0.071,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[13] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[13] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_16kx16m16_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=14, I_bit=16, I_word=16384, bsel_bit=2;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_16kx16m16_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_16kx16m16_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_16kx16m16_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_16kx16m16_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_16kx16m16_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_16kx16m16_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 2'b00) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_16kx16m16_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 16383\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_16kx16m16_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_16kx16m16_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 16:02:06 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_16kx24m16_g1
// Memory Size:       16384 words x 24 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [13:0]
//                 D  [23:0]
//                 WEM  [2:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [23:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_16kx24m16_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [23:0] Q;
wire [23:0] Q;

input [13:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [23:0]    Q_tmp;
wire [13:0]    ADR_buf;
wire [23:0]    D_buf;
wire [2:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [13:0] ADR_buf_L;
reg [13:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [2:0] WEMbus;
wire [2:0] WEMbus_eff;
wire [2:0] WEMbus_eff_L;
reg [2:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );
buf ADR_buf_u12 ( ADR_buf[12], ADR[12] );
buf ADR_buf_u13 ( ADR_buf[13], ADR[13] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_16kx24m16_g1 #(MES_ALL,14, 24, 16384,3) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [13:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 13; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 16383) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 16383) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  2.540,
        Tcqx =  0.701,

        Toq  =  0.491,
        Toqz =  0.503,

        Tcc  =  2.565,
        Tcl  =  0.564,
        Tch  =  0.517,

        Tac  =  0.504,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.084,

        Twmc  =  0.352,
        Tcwmx =  0.084,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[13] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[13] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_16kx24m16_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=14, I_bit=24, I_word=16384, bsel_bit=3;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_16kx24m16_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_16kx24m16_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_16kx24m16_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_16kx24m16_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_16kx24m16_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_16kx24m16_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 3'b000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_16kx24m16_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 16383\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_16kx24m16_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_16kx24m16_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 16:16:44 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_16kx32m16_g1
// Memory Size:       16384 words x 32 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [13:0]
//                 D  [31:0]
//                 WEM  [3:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [31:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_16kx32m16_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [31:0] Q;
wire [31:0] Q;

input [13:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [31:0]    Q_tmp;
wire [13:0]    ADR_buf;
wire [31:0]    D_buf;
wire [3:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [13:0] ADR_buf_L;
reg [13:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [3:0] WEMbus;
wire [3:0] WEMbus_eff;
wire [3:0] WEMbus_eff_L;
reg [3:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );
buf ADR_buf_u12 ( ADR_buf[12], ADR[12] );
buf ADR_buf_u13 ( ADR_buf[13], ADR[13] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );
buf D_buf_u24 ( D_buf[24], D[24] );
buf D_buf_u25 ( D_buf[25], D[25] );
buf D_buf_u26 ( D_buf[26], D[26] );
buf D_buf_u27 ( D_buf[27], D[27] );
buf D_buf_u28 ( D_buf[28], D[28] );
buf D_buf_u29 ( D_buf[29], D[29] );
buf D_buf_u30 ( D_buf[30], D[30] );
buf D_buf_u31 ( D_buf[31], D[31] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );
buf WEM_buf_u3 ( WEM_buf[3], WEM[3] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_16kx32m16_g1 #(MES_ALL,14, 32, 16384,4) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [13:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 13; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 16383) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 16383) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
bufif1 u_Q_24 (Q[24], Q_tmp[24], OEeff_del);
bufif1 u_Q_25 (Q[25], Q_tmp[25], OEeff_del);
bufif1 u_Q_26 (Q[26], Q_tmp[26], OEeff_del);
bufif1 u_Q_27 (Q[27], Q_tmp[27], OEeff_del);
bufif1 u_Q_28 (Q[28], Q_tmp[28], OEeff_del);
bufif1 u_Q_29 (Q[29], Q_tmp[29], OEeff_del);
bufif1 u_Q_30 (Q[30], Q_tmp[30], OEeff_del);
bufif1 u_Q_31 (Q[31], Q_tmp[31], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  2.580,
        Tcqx =  0.712,

        Toq  =  0.501,
        Toqz =  0.532,

        Tcc  =  2.605,
        Tcl  =  0.562,
        Tch  =  0.513,

        Tac  =  0.506,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.090,

        Twmc  =  0.352,
        Tcwmx =  0.090,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[24] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[25] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[26] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[27] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[28] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[29] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[30] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[31] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[24] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[25] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[26] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[27] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[28] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[29] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[30] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[31] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[13] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[13] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_16kx32m16_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=14, I_bit=32, I_word=16384, bsel_bit=4;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[3]}},{8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_16kx32m16_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_16kx32m16_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_16kx32m16_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_16kx32m16_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_16kx32m16_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_16kx32m16_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 4'b0000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_16kx32m16_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 16383\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_16kx32m16_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_16kx32m16_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 15:39:35 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_16kx8m16_g1
// Memory Size:       16384 words x 8 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [13:0]
//                 D  [7:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [7:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_16kx8m16_g1 ( Q, ADR, D,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [7:0] Q;
wire [7:0] Q;

input [13:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [7:0]    Q_tmp;
wire [13:0]    ADR_buf;
wire [7:0]    D_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  ME_buf_L;
reg  WE_buf_L;
reg [13:0] ADR_buf_L;
reg [13:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );
buf ADR_buf_u12 ( ADR_buf[12], ADR[12] );
buf ADR_buf_u13 ( ADR_buf[13], ADR[13] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_16kx8m16_g1 #(MES_ALL,14, 8, 16384) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [13:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 13; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 16383) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 16383) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf );
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  2.467,
        Tcqx =  0.660,

        Toq  =  0.369,
        Toqz =  0.386,

        Tcc  =  2.491,
        Tcl  =  0.571,
        Tch  =  0.521,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.029,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[13] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[13] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_16kx8m16_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk); 
parameter MES_ALL = "ON", A_bit=14, I_bit=8, I_word=16384;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg MElatched;
reg ME_chk;
real CLKA_T;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok} ) // only 1 and 0

  3'b111   : ;                                                // everything ok!!!

  3'b101,
  3'b100   : corrupt_cur_loc(ADRlatched);          // WE is unstable

  3'b110   : if (WElatched !== 1'b0)
              corrupt_cur_loc(ADRlatched);         // Data is unstable
  3'b000,
  3'b001   : corrupt_all_loc(flaga_range_ok);            // ADR and WE unstable
  3'b010,
  3'b011   : if (WElatched !== 1'b0)    // ADR unstable, WE stable
              corrupt_all_loc(flaga_range_ok);
 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_16kx8m16_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_16kx8m16_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_16kx8m16_g1_core)",$realtime);
    end  
   end 
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_16kx8m16_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_16kx8m16_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_16kx8m16_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 16383\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_16kx8m16_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        if (flaga_we_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         mem_core_array[ADRlatched] = Dlatched;  // write data in
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_16kx8m16_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:09:44 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_1kx16m8_g1
// Memory Size:       1024 words x 16 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [9:0]
//                 D  [15:0]
//                 WEM  [1:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [15:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_1kx16m8_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [15:0] Q;
wire [15:0] Q;

input [9:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [15:0]    Q_tmp;
wire [9:0]    ADR_buf;
wire [15:0]    D_buf;
wire [1:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [9:0] ADR_buf_L;
reg [9:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [1:0] WEMbus;
wire [1:0] WEMbus_eff;
wire [1:0] WEMbus_eff_L;
reg [1:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_1kx16m8_g1 #(MES_ALL,10, 16, 1024,2) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [9:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 9; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 1023) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 1023) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.506,
        Tcqx =  0.599,

        Toq  =  0.422,
        Toqz =  0.428,

        Tcc  =  1.521,
        Tcl  =  0.564,
        Tch  =  0.522,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.046,

        Twmc  =  0.352,
        Tcwmx =  0.046,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_1kx16m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=10, I_bit=16, I_word=1024, bsel_bit=2;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_1kx16m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_1kx16m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_1kx16m8_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_1kx16m8_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_1kx16m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_1kx16m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 2'b00) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_1kx16m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 1023\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_1kx16m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_1kx16m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:13:59 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_1kx24m8_g1
// Memory Size:       1024 words x 24 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [9:0]
//                 D  [23:0]
//                 WEM  [2:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [23:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_1kx24m8_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [23:0] Q;
wire [23:0] Q;

input [9:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [23:0]    Q_tmp;
wire [9:0]    ADR_buf;
wire [23:0]    D_buf;
wire [2:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [9:0] ADR_buf_L;
reg [9:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [2:0] WEMbus;
wire [2:0] WEMbus_eff;
wire [2:0] WEMbus_eff_L;
reg [2:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_1kx24m8_g1 #(MES_ALL,10, 24, 1024,3) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [9:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 9; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 1023) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 1023) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.525,
        Tcqx =  0.607,

        Toq  =  0.427,
        Toqz =  0.437,

        Tcc  =  1.540,
        Tcl  =  0.560,
        Tch  =  0.526,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.054,

        Twmc  =  0.352,
        Tcwmx =  0.054,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_1kx24m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=10, I_bit=24, I_word=1024, bsel_bit=3;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_1kx24m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_1kx24m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_1kx24m8_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_1kx24m8_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_1kx24m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_1kx24m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 3'b000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_1kx24m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 1023\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_1kx24m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_1kx24m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:18:36 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_1kx32m8_g1
// Memory Size:       1024 words x 32 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [9:0]
//                 D  [31:0]
//                 WEM  [3:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [31:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_1kx32m8_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [31:0] Q;
wire [31:0] Q;

input [9:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [31:0]    Q_tmp;
wire [9:0]    ADR_buf;
wire [31:0]    D_buf;
wire [3:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [9:0] ADR_buf_L;
reg [9:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [3:0] WEMbus;
wire [3:0] WEMbus_eff;
wire [3:0] WEMbus_eff_L;
reg [3:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );
buf D_buf_u24 ( D_buf[24], D[24] );
buf D_buf_u25 ( D_buf[25], D[25] );
buf D_buf_u26 ( D_buf[26], D[26] );
buf D_buf_u27 ( D_buf[27], D[27] );
buf D_buf_u28 ( D_buf[28], D[28] );
buf D_buf_u29 ( D_buf[29], D[29] );
buf D_buf_u30 ( D_buf[30], D[30] );
buf D_buf_u31 ( D_buf[31], D[31] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );
buf WEM_buf_u3 ( WEM_buf[3], WEM[3] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_1kx32m8_g1 #(MES_ALL,10, 32, 1024,4) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [9:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 9; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 1023) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 1023) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
bufif1 u_Q_24 (Q[24], Q_tmp[24], OEeff_del);
bufif1 u_Q_25 (Q[25], Q_tmp[25], OEeff_del);
bufif1 u_Q_26 (Q[26], Q_tmp[26], OEeff_del);
bufif1 u_Q_27 (Q[27], Q_tmp[27], OEeff_del);
bufif1 u_Q_28 (Q[28], Q_tmp[28], OEeff_del);
bufif1 u_Q_29 (Q[29], Q_tmp[29], OEeff_del);
bufif1 u_Q_30 (Q[30], Q_tmp[30], OEeff_del);
bufif1 u_Q_31 (Q[31], Q_tmp[31], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.566,
        Tcqx =  0.614,

        Toq  =  0.437,
        Toqz =  0.455,

        Tcc  =  1.582,
        Tcl  =  0.557,
        Tch  =  0.522,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.059,

        Twmc  =  0.352,
        Tcwmx =  0.059,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[24] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[25] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[26] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[27] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[28] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[29] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[30] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[31] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[24] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[25] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[26] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[27] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[28] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[29] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[30] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[31] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_1kx32m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=10, I_bit=32, I_word=1024, bsel_bit=4;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[3]}},{8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_1kx32m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_1kx32m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_1kx32m8_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_1kx32m8_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_1kx32m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_1kx32m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 4'b0000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_1kx32m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 1023\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_1kx32m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_1kx32m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:05:31 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_1kx8m8_g1
// Memory Size:       1024 words x 8 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [9:0]
//                 D  [7:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [7:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_1kx8m8_g1 ( Q, ADR, D,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [7:0] Q;
wire [7:0] Q;

input [9:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [7:0]    Q_tmp;
wire [9:0]    ADR_buf;
wire [7:0]    D_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  ME_buf_L;
reg  WE_buf_L;
reg [9:0] ADR_buf_L;
reg [9:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_1kx8m8_g1 #(MES_ALL,10, 8, 1024) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [9:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 9; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 1023) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 1023) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf );
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.400,
        Tcqx =  0.566,

        Toq  =  0.335,
        Toqz =  0.352,

        Tcc  =  1.432,
        Tcl  =  0.563,
        Tch  =  0.527,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.009,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_1kx8m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk); 
parameter MES_ALL = "ON", A_bit=10, I_bit=8, I_word=1024;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg MElatched;
reg ME_chk;
real CLKA_T;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok} ) // only 1 and 0

  3'b111   : ;                                                // everything ok!!!

  3'b101,
  3'b100   : corrupt_cur_loc(ADRlatched);          // WE is unstable

  3'b110   : if (WElatched !== 1'b0)
              corrupt_cur_loc(ADRlatched);         // Data is unstable
  3'b000,
  3'b001   : corrupt_all_loc(flaga_range_ok);            // ADR and WE unstable
  3'b010,
  3'b011   : if (WElatched !== 1'b0)    // ADR unstable, WE stable
              corrupt_all_loc(flaga_range_ok);
 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_1kx8m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_1kx8m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_1kx8m8_g1_core)",$realtime);
    end  
   end 
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_1kx8m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_1kx8m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_1kx8m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 1023\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_1kx8m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        if (flaga_we_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         mem_core_array[ADRlatched] = Dlatched;  // write data in
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_1kx8m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 13:37:27 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_256x16m8_g1
// Memory Size:       256 words x 16 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [7:0]
//                 D  [15:0]
//                 WEM  [1:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [15:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_256x16m8_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [15:0] Q;
wire [15:0] Q;

input [7:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [15:0]    Q_tmp;
wire [7:0]    ADR_buf;
wire [15:0]    D_buf;
wire [1:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [7:0] ADR_buf_L;
reg [7:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [1:0] WEMbus;
wire [1:0] WEMbus_eff;
wire [1:0] WEMbus_eff_L;
reg [1:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_256x16m8_g1 #(MES_ALL,8, 16, 256,2) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [7:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 7; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 255) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 255) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.401,
        Tcqx =  0.608,

        Toq  =  0.422,
        Toqz =  0.428,

        Tcc  =  1.415,
        Tcl  =  0.566,
        Tch  =  0.525,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.047,

        Twmc  =  0.352,
        Tcwmx =  0.047,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_256x16m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=8, I_bit=16, I_word=256, bsel_bit=2;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_256x16m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_256x16m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_256x16m8_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_256x16m8_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_256x16m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_256x16m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 2'b00) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_256x16m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 255\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_256x16m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_256x16m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 13:41:23 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_256x24m4_g1
// Memory Size:       256 words x 24 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [7:0]
//                 D  [23:0]
//                 WEM  [2:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [23:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_256x24m4_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [23:0] Q;
wire [23:0] Q;

input [7:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [23:0]    Q_tmp;
wire [7:0]    ADR_buf;
wire [23:0]    D_buf;
wire [2:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [7:0] ADR_buf_L;
reg [7:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [2:0] WEMbus;
wire [2:0] WEMbus_eff;
wire [2:0] WEMbus_eff_L;
reg [2:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_256x24m4_g1 #(MES_ALL,8, 24, 256,3) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [7:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 7; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 255) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 255) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.421,
        Tcqx =  0.627,

        Toq  =  0.386,
        Toqz =  0.397,

        Tcc  =  1.435,
        Tcl  =  0.593,
        Tch  =  0.563,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.031,

        Twmc  =  0.352,
        Tcwmx =  0.031,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_256x24m4_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=8, I_bit=24, I_word=256, bsel_bit=3;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_256x24m4_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_256x24m4_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_256x24m4_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_256x24m4_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_256x24m4_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_256x24m4_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 3'b000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_256x24m4_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 255\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_256x24m4_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_256x24m4_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 13:45:19 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_256x32m4_g1
// Memory Size:       256 words x 32 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [7:0]
//                 D  [31:0]
//                 WEM  [3:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [31:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_256x32m4_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [31:0] Q;
wire [31:0] Q;

input [7:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [31:0]    Q_tmp;
wire [7:0]    ADR_buf;
wire [31:0]    D_buf;
wire [3:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [7:0] ADR_buf_L;
reg [7:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [3:0] WEMbus;
wire [3:0] WEMbus_eff;
wire [3:0] WEMbus_eff_L;
reg [3:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );
buf D_buf_u24 ( D_buf[24], D[24] );
buf D_buf_u25 ( D_buf[25], D[25] );
buf D_buf_u26 ( D_buf[26], D[26] );
buf D_buf_u27 ( D_buf[27], D[27] );
buf D_buf_u28 ( D_buf[28], D[28] );
buf D_buf_u29 ( D_buf[29], D[29] );
buf D_buf_u30 ( D_buf[30], D[30] );
buf D_buf_u31 ( D_buf[31], D[31] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );
buf WEM_buf_u3 ( WEM_buf[3], WEM[3] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_256x32m4_g1 #(MES_ALL,8, 32, 256,4) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [7:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 7; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 255) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 255) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
bufif1 u_Q_24 (Q[24], Q_tmp[24], OEeff_del);
bufif1 u_Q_25 (Q[25], Q_tmp[25], OEeff_del);
bufif1 u_Q_26 (Q[26], Q_tmp[26], OEeff_del);
bufif1 u_Q_27 (Q[27], Q_tmp[27], OEeff_del);
bufif1 u_Q_28 (Q[28], Q_tmp[28], OEeff_del);
bufif1 u_Q_29 (Q[29], Q_tmp[29], OEeff_del);
bufif1 u_Q_30 (Q[30], Q_tmp[30], OEeff_del);
bufif1 u_Q_31 (Q[31], Q_tmp[31], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.450,
        Tcqx =  0.647,

        Toq  =  0.419,
        Toqz =  0.439,

        Tcc  =  1.464,
        Tcl  =  0.586,
        Tch  =  0.559,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.051,

        Twmc  =  0.352,
        Tcwmx =  0.051,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[24] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[25] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[26] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[27] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[28] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[29] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[30] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[31] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[24] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[25] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[26] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[27] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[28] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[29] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[30] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[31] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_256x32m4_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=8, I_bit=32, I_word=256, bsel_bit=4;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[3]}},{8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_256x32m4_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_256x32m4_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_256x32m4_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_256x32m4_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_256x32m4_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_256x32m4_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 4'b0000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_256x32m4_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 255\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_256x32m4_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_256x32m4_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 13:33:49 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_256x8m8_g1
// Memory Size:       256 words x 8 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [7:0]
//                 D  [7:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [7:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_256x8m8_g1 ( Q, ADR, D,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [7:0] Q;
wire [7:0] Q;

input [7:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [7:0]    Q_tmp;
wire [7:0]    ADR_buf;
wire [7:0]    D_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  ME_buf_L;
reg  WE_buf_L;
reg [7:0] ADR_buf_L;
reg [7:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_256x8m8_g1 #(MES_ALL,8, 8, 256) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [7:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 7; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 255) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 255) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf );
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.279,
        Tcqx =  0.569,

        Toq  =  0.335,
        Toqz =  0.352,

        Tcc  =  1.292,
        Tcl  =  0.566,
        Tch  =  0.521,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.010,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_256x8m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk); 
parameter MES_ALL = "ON", A_bit=8, I_bit=8, I_word=256;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg MElatched;
reg ME_chk;
real CLKA_T;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok} ) // only 1 and 0

  3'b111   : ;                                                // everything ok!!!

  3'b101,
  3'b100   : corrupt_cur_loc(ADRlatched);          // WE is unstable

  3'b110   : if (WElatched !== 1'b0)
              corrupt_cur_loc(ADRlatched);         // Data is unstable
  3'b000,
  3'b001   : corrupt_all_loc(flaga_range_ok);            // ADR and WE unstable
  3'b010,
  3'b011   : if (WElatched !== 1'b0)    // ADR unstable, WE stable
              corrupt_all_loc(flaga_range_ok);
 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_256x8m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_256x8m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_256x8m8_g1_core)",$realtime);
    end  
   end 
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_256x8m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_256x8m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_256x8m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 255\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_256x8m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        if (flaga_we_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         mem_core_array[ADRlatched] = Dlatched;  // write data in
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_256x8m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:27:59 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_2kx16m8_g1
// Memory Size:       2048 words x 16 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [10:0]
//                 D  [15:0]
//                 WEM  [1:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [15:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_2kx16m8_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [15:0] Q;
wire [15:0] Q;

input [10:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [15:0]    Q_tmp;
wire [10:0]    ADR_buf;
wire [15:0]    D_buf;
wire [1:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [10:0] ADR_buf_L;
reg [10:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [1:0] WEMbus;
wire [1:0] WEMbus_eff;
wire [1:0] WEMbus_eff_L;
reg [1:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_2kx16m8_g1 #(MES_ALL,11, 16, 2048,2) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [10:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 10; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 2047) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 2047) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.650,
        Tcqx =  0.617,

        Toq  =  0.376,
        Toqz =  0.381,

        Tcc  =  1.666,
        Tcl  =  0.573,
        Tch  =  0.548,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.028,

        Twmc  =  0.352,
        Tcwmx =  0.028,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_2kx16m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=11, I_bit=16, I_word=2048, bsel_bit=2;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_2kx16m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_2kx16m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_2kx16m8_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_2kx16m8_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_2kx16m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_2kx16m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 2'b00) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_2kx16m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 2047\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_2kx16m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_2kx16m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:33:09 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_2kx24m8_g1
// Memory Size:       2048 words x 24 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [10:0]
//                 D  [23:0]
//                 WEM  [2:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [23:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_2kx24m8_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [23:0] Q;
wire [23:0] Q;

input [10:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [23:0]    Q_tmp;
wire [10:0]    ADR_buf;
wire [23:0]    D_buf;
wire [2:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [10:0] ADR_buf_L;
reg [10:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [2:0] WEMbus;
wire [2:0] WEMbus_eff;
wire [2:0] WEMbus_eff_L;
reg [2:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_2kx24m8_g1 #(MES_ALL,11, 24, 2048,3) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [10:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 10; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 2047) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 2047) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.727,
        Tcqx =  0.633,

        Toq  =  0.442,
        Toqz =  0.450,

        Tcc  =  1.745,
        Tcl  =  0.572,
        Tch  =  0.537,

        Tac  =  0.372,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.054,

        Twmc  =  0.352,
        Tcwmx =  0.054,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_2kx24m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=11, I_bit=24, I_word=2048, bsel_bit=3;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_2kx24m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_2kx24m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_2kx24m8_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_2kx24m8_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_2kx24m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_2kx24m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 3'b000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_2kx24m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 2047\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_2kx24m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_2kx24m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:39:19 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_2kx32m4_g1
// Memory Size:       2048 words x 32 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [10:0]
//                 D  [31:0]
//                 WEM  [3:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [31:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_2kx32m4_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [31:0] Q;
wire [31:0] Q;

input [10:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [31:0]    Q_tmp;
wire [10:0]    ADR_buf;
wire [31:0]    D_buf;
wire [3:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [10:0] ADR_buf_L;
reg [10:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [3:0] WEMbus;
wire [3:0] WEMbus_eff;
wire [3:0] WEMbus_eff_L;
reg [3:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );
buf D_buf_u24 ( D_buf[24], D[24] );
buf D_buf_u25 ( D_buf[25], D[25] );
buf D_buf_u26 ( D_buf[26], D[26] );
buf D_buf_u27 ( D_buf[27], D[27] );
buf D_buf_u28 ( D_buf[28], D[28] );
buf D_buf_u29 ( D_buf[29], D[29] );
buf D_buf_u30 ( D_buf[30], D[30] );
buf D_buf_u31 ( D_buf[31], D[31] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );
buf WEM_buf_u3 ( WEM_buf[3], WEM[3] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_2kx32m4_g1 #(MES_ALL,11, 32, 2048,4) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [10:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 10; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 2047) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 2047) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
bufif1 u_Q_24 (Q[24], Q_tmp[24], OEeff_del);
bufif1 u_Q_25 (Q[25], Q_tmp[25], OEeff_del);
bufif1 u_Q_26 (Q[26], Q_tmp[26], OEeff_del);
bufif1 u_Q_27 (Q[27], Q_tmp[27], OEeff_del);
bufif1 u_Q_28 (Q[28], Q_tmp[28], OEeff_del);
bufif1 u_Q_29 (Q[29], Q_tmp[29], OEeff_del);
bufif1 u_Q_30 (Q[30], Q_tmp[30], OEeff_del);
bufif1 u_Q_31 (Q[31], Q_tmp[31], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.784,
        Tcqx =  0.649,

        Toq  =  0.401,
        Toqz =  0.419,

        Tcc  =  1.802,
        Tcl  =  0.577,
        Tch  =  0.542,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.050,

        Twmc  =  0.352,
        Tcwmx =  0.050,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[24] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[25] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[26] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[27] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[28] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[29] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[30] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[31] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[24] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[25] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[26] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[27] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[28] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[29] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[30] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[31] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_2kx32m4_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=11, I_bit=32, I_word=2048, bsel_bit=4;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[3]}},{8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_2kx32m4_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_2kx32m4_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_2kx32m4_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_2kx32m4_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_2kx32m4_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_2kx32m4_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 4'b0000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_2kx32m4_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 2047\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_2kx32m4_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_2kx32m4_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:23:06 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_2kx8m16_g1
// Memory Size:       2048 words x 8 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [10:0]
//                 D  [7:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [7:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_2kx8m16_g1 ( Q, ADR, D,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [7:0] Q;
wire [7:0] Q;

input [10:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [7:0]    Q_tmp;
wire [10:0]    ADR_buf;
wire [7:0]    D_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  ME_buf_L;
reg  WE_buf_L;
reg [10:0] ADR_buf_L;
reg [10:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_2kx8m16_g1 #(MES_ALL,11, 8, 2048) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [10:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 10; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 2047) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 2047) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf );
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.488,
        Tcqx =  0.649,

        Toq  =  0.366,
        Toqz =  0.376,

        Tcc  =  1.503,
        Tcl  =  0.561,
        Tch  =  0.514,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.028,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_2kx8m16_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk); 
parameter MES_ALL = "ON", A_bit=11, I_bit=8, I_word=2048;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg MElatched;
reg ME_chk;
real CLKA_T;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok} ) // only 1 and 0

  3'b111   : ;                                                // everything ok!!!

  3'b101,
  3'b100   : corrupt_cur_loc(ADRlatched);          // WE is unstable

  3'b110   : if (WElatched !== 1'b0)
              corrupt_cur_loc(ADRlatched);         // Data is unstable
  3'b000,
  3'b001   : corrupt_all_loc(flaga_range_ok);            // ADR and WE unstable
  3'b010,
  3'b011   : if (WElatched !== 1'b0)    // ADR unstable, WE stable
              corrupt_all_loc(flaga_range_ok);
 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_2kx8m16_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_2kx8m16_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_2kx8m16_g1_core)",$realtime);
    end  
   end 
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_2kx8m16_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_2kx8m16_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_2kx8m16_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 2047\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_2kx8m16_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        if (flaga_we_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         mem_core_array[ADRlatched] = Dlatched;  // write data in
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_2kx8m16_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:49:59 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_4kx16m8_g1
// Memory Size:       4096 words x 16 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [11:0]
//                 D  [15:0]
//                 WEM  [1:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [15:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_4kx16m8_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [15:0] Q;
wire [15:0] Q;

input [11:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [15:0]    Q_tmp;
wire [11:0]    ADR_buf;
wire [15:0]    D_buf;
wire [1:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [11:0] ADR_buf_L;
reg [11:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [1:0] WEMbus;
wire [1:0] WEMbus_eff;
wire [1:0] WEMbus_eff_L;
reg [1:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_4kx16m8_g1 #(MES_ALL,12, 16, 4096,2) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [11:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 11; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 4095) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 4095) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.754,
        Tcqx =  0.621,

        Toq  =  0.376,
        Toqz =  0.381,

        Tcc  =  1.771,
        Tcl  =  0.573,
        Tch  =  0.540,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.030,

        Twmc  =  0.352,
        Tcwmx =  0.030,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_4kx16m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=12, I_bit=16, I_word=4096, bsel_bit=2;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_4kx16m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_4kx16m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_4kx16m8_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_4kx16m8_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_4kx16m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_4kx16m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 2'b00) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_4kx16m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 4095\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_4kx16m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_4kx16m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:56:19 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_4kx24m8_g1
// Memory Size:       4096 words x 24 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [11:0]
//                 D  [23:0]
//                 WEM  [2:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [23:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_4kx24m8_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [23:0] Q;
wire [23:0] Q;

input [11:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [23:0]    Q_tmp;
wire [11:0]    ADR_buf;
wire [23:0]    D_buf;
wire [2:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [11:0] ADR_buf_L;
reg [11:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [2:0] WEMbus;
wire [2:0] WEMbus_eff;
wire [2:0] WEMbus_eff_L;
reg [2:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_4kx24m8_g1 #(MES_ALL,12, 24, 4096,3) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [11:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 11; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 4095) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 4095) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.811,
        Tcqx =  0.643,

        Toq  =  0.442,
        Toqz =  0.456,

        Tcc  =  1.829,
        Tcl  =  0.572,
        Tch  =  0.545,

        Tac  =  0.360,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.056,

        Twmc  =  0.352,
        Tcwmx =  0.056,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_4kx24m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=12, I_bit=24, I_word=4096, bsel_bit=3;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_4kx24m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_4kx24m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_4kx24m8_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_4kx24m8_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_4kx24m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_4kx24m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 3'b000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_4kx24m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 4095\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_4kx24m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_4kx24m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 15:02:56 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_4kx32m8_g1
// Memory Size:       4096 words x 32 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [11:0]
//                 D  [31:0]
//                 WEM  [3:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [31:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_4kx32m8_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [31:0] Q;
wire [31:0] Q;

input [11:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [31:0]    Q_tmp;
wire [11:0]    ADR_buf;
wire [31:0]    D_buf;
wire [3:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [11:0] ADR_buf_L;
reg [11:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [3:0] WEMbus;
wire [3:0] WEMbus_eff;
wire [3:0] WEMbus_eff_L;
reg [3:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );
buf D_buf_u24 ( D_buf[24], D[24] );
buf D_buf_u25 ( D_buf[25], D[25] );
buf D_buf_u26 ( D_buf[26], D[26] );
buf D_buf_u27 ( D_buf[27], D[27] );
buf D_buf_u28 ( D_buf[28], D[28] );
buf D_buf_u29 ( D_buf[29], D[29] );
buf D_buf_u30 ( D_buf[30], D[30] );
buf D_buf_u31 ( D_buf[31], D[31] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );
buf WEM_buf_u3 ( WEM_buf[3], WEM[3] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_4kx32m8_g1 #(MES_ALL,12, 32, 4096,4) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [11:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 11; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 4095) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 4095) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
bufif1 u_Q_24 (Q[24], Q_tmp[24], OEeff_del);
bufif1 u_Q_25 (Q[25], Q_tmp[25], OEeff_del);
bufif1 u_Q_26 (Q[26], Q_tmp[26], OEeff_del);
bufif1 u_Q_27 (Q[27], Q_tmp[27], OEeff_del);
bufif1 u_Q_28 (Q[28], Q_tmp[28], OEeff_del);
bufif1 u_Q_29 (Q[29], Q_tmp[29], OEeff_del);
bufif1 u_Q_30 (Q[30], Q_tmp[30], OEeff_del);
bufif1 u_Q_31 (Q[31], Q_tmp[31], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.783,
        Tcqx =  0.646,

        Toq  =  0.447,
        Toqz =  0.467,

        Tcc  =  1.801,
        Tcl  =  0.571,
        Tch  =  0.535,

        Tac  =  0.363,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.062,

        Twmc  =  0.352,
        Tcwmx =  0.062,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[24] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[25] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[26] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[27] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[28] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[29] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[30] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[31] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[24] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[25] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[26] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[27] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[28] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[29] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[30] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[31] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_4kx32m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=12, I_bit=32, I_word=4096, bsel_bit=4;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[3]}},{8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_4kx32m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_4kx32m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_4kx32m8_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_4kx32m8_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_4kx32m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_4kx32m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 4'b0000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_4kx32m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 4095\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_4kx32m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_4kx32m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:44:14 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_4kx8m16_g1
// Memory Size:       4096 words x 8 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [11:0]
//                 D  [7:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [7:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_4kx8m16_g1 ( Q, ADR, D,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [7:0] Q;
wire [7:0] Q;

input [11:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [7:0]    Q_tmp;
wire [11:0]    ADR_buf;
wire [7:0]    D_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  ME_buf_L;
reg  WE_buf_L;
reg [11:0] ADR_buf_L;
reg [11:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_4kx8m16_g1 #(MES_ALL,12, 8, 4096) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [11:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 11; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 4095) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 4095) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf );
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.655,
        Tcqx =  0.651,

        Toq  =  0.371,
        Toqz =  0.389,

        Tcc  =  1.671,
        Tcl  =  0.565,
        Tch  =  0.524,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.031,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_4kx8m16_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk); 
parameter MES_ALL = "ON", A_bit=12, I_bit=8, I_word=4096;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg MElatched;
reg ME_chk;
real CLKA_T;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok} ) // only 1 and 0

  3'b111   : ;                                                // everything ok!!!

  3'b101,
  3'b100   : corrupt_cur_loc(ADRlatched);          // WE is unstable

  3'b110   : if (WElatched !== 1'b0)
              corrupt_cur_loc(ADRlatched);         // Data is unstable
  3'b000,
  3'b001   : corrupt_all_loc(flaga_range_ok);            // ADR and WE unstable
  3'b010,
  3'b011   : if (WElatched !== 1'b0)    // ADR unstable, WE stable
              corrupt_all_loc(flaga_range_ok);
 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_4kx8m16_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_4kx8m16_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_4kx8m16_g1_core)",$realtime);
    end  
   end 
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_4kx8m16_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_4kx8m16_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_4kx8m16_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 4095\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_4kx8m16_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        if (flaga_we_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         mem_core_array[ADRlatched] = Dlatched;  // write data in
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_4kx8m16_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 13:52:48 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_512x16m8_g1
// Memory Size:       512 words x 16 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [8:0]
//                 D  [15:0]
//                 WEM  [1:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [15:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_512x16m8_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [15:0] Q;
wire [15:0] Q;

input [8:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [15:0]    Q_tmp;
wire [8:0]    ADR_buf;
wire [15:0]    D_buf;
wire [1:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [8:0] ADR_buf_L;
reg [8:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [1:0] WEMbus;
wire [1:0] WEMbus_eff;
wire [1:0] WEMbus_eff_L;
reg [1:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_512x16m8_g1 #(MES_ALL,9, 16, 512,2) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [8:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 8; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 511) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 511) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.422,
        Tcqx =  0.601,

        Toq  =  0.422,
        Toqz =  0.431,

        Tcc  =  1.436,
        Tcl  =  0.565,
        Tch  =  0.520,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.045,

        Twmc  =  0.352,
        Tcwmx =  0.045,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_512x16m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=9, I_bit=16, I_word=512, bsel_bit=2;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_512x16m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_512x16m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_512x16m8_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_512x16m8_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_512x16m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_512x16m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 2'b00) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_512x16m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 511\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_512x16m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_512x16m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 13:56:56 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_512x24m4_g1
// Memory Size:       512 words x 24 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [8:0]
//                 D  [23:0]
//                 WEM  [2:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [23:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_512x24m4_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [23:0] Q;
wire [23:0] Q;

input [8:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [23:0]    Q_tmp;
wire [8:0]    ADR_buf;
wire [23:0]    D_buf;
wire [2:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [8:0] ADR_buf_L;
reg [8:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [2:0] WEMbus;
wire [2:0] WEMbus_eff;
wire [2:0] WEMbus_eff_L;
reg [2:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_512x24m4_g1 #(MES_ALL,9, 24, 512,3) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [8:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 8; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 511) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 511) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.507,
        Tcqx =  0.629,

        Toq  =  0.386,
        Toqz =  0.397,

        Tcc  =  1.522,
        Tcl  =  0.596,
        Tch  =  0.568,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.030,

        Twmc  =  0.352,
        Tcwmx =  0.030,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_512x24m4_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=9, I_bit=24, I_word=512, bsel_bit=3;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_512x24m4_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_512x24m4_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_512x24m4_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_512x24m4_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_512x24m4_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_512x24m4_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 3'b000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_512x24m4_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 511\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_512x24m4_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_512x24m4_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 14:01:20 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_512x32m4_g1
// Memory Size:       512 words x 32 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [8:0]
//                 D  [31:0]
//                 WEM  [3:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [31:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_512x32m4_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [31:0] Q;
wire [31:0] Q;

input [8:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [31:0]    Q_tmp;
wire [8:0]    ADR_buf;
wire [31:0]    D_buf;
wire [3:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [8:0] ADR_buf_L;
reg [8:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [3:0] WEMbus;
wire [3:0] WEMbus_eff;
wire [3:0] WEMbus_eff_L;
reg [3:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );
buf D_buf_u24 ( D_buf[24], D[24] );
buf D_buf_u25 ( D_buf[25], D[25] );
buf D_buf_u26 ( D_buf[26], D[26] );
buf D_buf_u27 ( D_buf[27], D[27] );
buf D_buf_u28 ( D_buf[28], D[28] );
buf D_buf_u29 ( D_buf[29], D[29] );
buf D_buf_u30 ( D_buf[30], D[30] );
buf D_buf_u31 ( D_buf[31], D[31] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );
buf WEM_buf_u3 ( WEM_buf[3], WEM[3] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_512x32m4_g1 #(MES_ALL,9, 32, 512,4) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [8:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 8; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 511) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 511) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
bufif1 u_Q_24 (Q[24], Q_tmp[24], OEeff_del);
bufif1 u_Q_25 (Q[25], Q_tmp[25], OEeff_del);
bufif1 u_Q_26 (Q[26], Q_tmp[26], OEeff_del);
bufif1 u_Q_27 (Q[27], Q_tmp[27], OEeff_del);
bufif1 u_Q_28 (Q[28], Q_tmp[28], OEeff_del);
bufif1 u_Q_29 (Q[29], Q_tmp[29], OEeff_del);
bufif1 u_Q_30 (Q[30], Q_tmp[30], OEeff_del);
bufif1 u_Q_31 (Q[31], Q_tmp[31], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.531,
        Tcqx =  0.646,

        Toq  =  0.419,
        Toqz =  0.439,

        Tcc  =  1.546,
        Tcl  =  0.587,
        Tch  =  0.565,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.054,

        Twmc  =  0.352,
        Tcwmx =  0.054,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[24] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[25] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[26] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[27] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[28] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[29] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[30] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[31] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[24] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[25] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[26] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[27] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[28] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[29] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[30] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[31] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_512x32m4_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=9, I_bit=32, I_word=512, bsel_bit=4;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[3]}},{8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_512x32m4_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_512x32m4_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_512x32m4_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_512x32m4_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_512x32m4_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_512x32m4_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 4'b0000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_512x32m4_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 511\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_512x32m4_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_512x32m4_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 13:49:02 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_512x8m8_g1
// Memory Size:       512 words x 8 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [8:0]
//                 D  [7:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [7:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_512x8m8_g1 ( Q, ADR, D,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [7:0] Q;
wire [7:0] Q;

input [8:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [7:0]    Q_tmp;
wire [8:0]    ADR_buf;
wire [7:0]    D_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  ME_buf_L;
reg  WE_buf_L;
reg [8:0] ADR_buf_L;
reg [8:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_512x8m8_g1 #(MES_ALL,9, 8, 512) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [8:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 8; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 511) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 511) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf );
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.315,
        Tcqx =  0.567,

        Toq  =  0.335,
        Toqz =  0.352,

        Tcc  =  1.328,
        Tcl  =  0.558,
        Tch  =  0.531,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.009,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_512x8m8_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk); 
parameter MES_ALL = "ON", A_bit=9, I_bit=8, I_word=512;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg MElatched;
reg ME_chk;
real CLKA_T;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok} ) // only 1 and 0

  3'b111   : ;                                                // everything ok!!!

  3'b101,
  3'b100   : corrupt_cur_loc(ADRlatched);          // WE is unstable

  3'b110   : if (WElatched !== 1'b0)
              corrupt_cur_loc(ADRlatched);         // Data is unstable
  3'b000,
  3'b001   : corrupt_all_loc(flaga_range_ok);            // ADR and WE unstable
  3'b010,
  3'b011   : if (WElatched !== 1'b0)    // ADR unstable, WE stable
              corrupt_all_loc(flaga_range_ok);
 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_512x8m8_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_512x8m8_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_512x8m8_g1_core)",$realtime);
    end  
   end 
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_512x8m8_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_512x8m8_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_512x8m8_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 511\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_512x8m8_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        if (flaga_we_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         mem_core_array[ADRlatched] = Dlatched;  // write data in
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_512x8m8_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 15:15:05 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_8kx16m16_g1
// Memory Size:       8192 words x 16 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [12:0]
//                 D  [15:0]
//                 WEM  [1:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [15:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_8kx16m16_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [15:0] Q;
wire [15:0] Q;

input [12:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [15:0]    Q_tmp;
wire [12:0]    ADR_buf;
wire [15:0]    D_buf;
wire [1:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [12:0] ADR_buf_L;
reg [12:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [1:0] WEMbus;
wire [1:0] WEMbus_eff;
wire [1:0] WEMbus_eff_L;
reg [1:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );
buf ADR_buf_u12 ( ADR_buf[12], ADR[12] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_8kx16m16_g1 #(MES_ALL,13, 16, 8192,2) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [12:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 12; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 8191) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 8191) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.819,
        Tcqx =  0.694,

        Toq  =  0.461,
        Toqz =  0.478,

        Tcc  =  1.837,
        Tcl  =  0.566,
        Tch  =  0.521,

        Tac  =  0.348,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.070,

        Twmc  =  0.352,
        Tcwmx =  0.070,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_8kx16m16_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=13, I_bit=16, I_word=8192, bsel_bit=2;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 2'b00)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_8kx16m16_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_8kx16m16_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_8kx16m16_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_8kx16m16_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_8kx16m16_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_8kx16m16_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 2'b00) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_8kx16m16_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 8191\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_8kx16m16_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_8kx16m16_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 15:22:51 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_8kx24m16_g1
// Memory Size:       8192 words x 24 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [12:0]
//                 D  [23:0]
//                 WEM  [2:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [23:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_8kx24m16_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [23:0] Q;
wire [23:0] Q;

input [12:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [23:0]    Q_tmp;
wire [12:0]    ADR_buf;
wire [23:0]    D_buf;
wire [2:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [12:0] ADR_buf_L;
reg [12:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [2:0] WEMbus;
wire [2:0] WEMbus_eff;
wire [2:0] WEMbus_eff_L;
reg [2:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );
buf ADR_buf_u12 ( ADR_buf[12], ADR[12] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_8kx24m16_g1 #(MES_ALL,13, 24, 8192,3) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [12:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 12; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 8191) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 8191) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.860,
        Tcqx =  0.693,

        Toq  =  0.484,
        Toqz =  0.506,

        Tcc  =  1.878,
        Tcl  =  0.565,
        Tch  =  0.517,

        Tac  =  0.350,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.083,

        Twmc  =  0.352,
        Tcwmx =  0.083,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_8kx24m16_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=13, I_bit=24, I_word=8192, bsel_bit=3;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 3'b000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_8kx24m16_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_8kx24m16_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_8kx24m16_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_8kx24m16_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_8kx24m16_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_8kx24m16_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 3'b000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_8kx24m16_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 8191\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_8kx24m16_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_8kx24m16_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 15:31:09 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_8kx32m16_g1
// Memory Size:       8192 words x 32 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [12:0]
//                 D  [31:0]
//                 WEM  [3:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [31:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_8kx32m16_g1 ( Q, ADR, D, WEM,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [31:0] Q;
wire [31:0] Q;

input [12:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [31:0]    Q_tmp;
wire [12:0]    ADR_buf;
wire [31:0]    D_buf;
wire [3:0]    WEM_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  notif_a_wem;
reg  ME_buf_L;
reg  WE_buf_L;
reg [12:0] ADR_buf_L;
reg [12:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;
wire WEM_active;
wire WEM_active_eff;
wire WEM_active_eff_L;
reg WEM_active_L;
wire [3:0] WEMbus;
wire [3:0] WEMbus_eff;
wire [3:0] WEMbus_eff_L;
reg [3:0] WEMbus_L;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );
buf ADR_buf_u12 ( ADR_buf[12], ADR[12] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );
buf D_buf_u8 ( D_buf[8], D[8] );
buf D_buf_u9 ( D_buf[9], D[9] );
buf D_buf_u10 ( D_buf[10], D[10] );
buf D_buf_u11 ( D_buf[11], D[11] );
buf D_buf_u12 ( D_buf[12], D[12] );
buf D_buf_u13 ( D_buf[13], D[13] );
buf D_buf_u14 ( D_buf[14], D[14] );
buf D_buf_u15 ( D_buf[15], D[15] );
buf D_buf_u16 ( D_buf[16], D[16] );
buf D_buf_u17 ( D_buf[17], D[17] );
buf D_buf_u18 ( D_buf[18], D[18] );
buf D_buf_u19 ( D_buf[19], D[19] );
buf D_buf_u20 ( D_buf[20], D[20] );
buf D_buf_u21 ( D_buf[21], D[21] );
buf D_buf_u22 ( D_buf[22], D[22] );
buf D_buf_u23 ( D_buf[23], D[23] );
buf D_buf_u24 ( D_buf[24], D[24] );
buf D_buf_u25 ( D_buf[25], D[25] );
buf D_buf_u26 ( D_buf[26], D[26] );
buf D_buf_u27 ( D_buf[27], D[27] );
buf D_buf_u28 ( D_buf[28], D[28] );
buf D_buf_u29 ( D_buf[29], D[29] );
buf D_buf_u30 ( D_buf[30], D[30] );
buf D_buf_u31 ( D_buf[31], D[31] );

buf WEM_buf_u0 ( WEM_buf[0], WEM[0] );
buf WEM_buf_u1 ( WEM_buf[1], WEM[1] );
buf WEM_buf_u2 ( WEM_buf[2], WEM[2] );
buf WEM_buf_u3 ( WEM_buf[3], WEM[3] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_8kx32m16_g1 #(MES_ALL,13, 32, 8192,4) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [12:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 12; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 8191) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;
  WEM_active_L = WEM_active;
  WEMbus_L = WEMbus;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 8191) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
bufif1 u_Q_8 (Q[8], Q_tmp[8], OEeff_del);
bufif1 u_Q_9 (Q[9], Q_tmp[9], OEeff_del);
bufif1 u_Q_10 (Q[10], Q_tmp[10], OEeff_del);
bufif1 u_Q_11 (Q[11], Q_tmp[11], OEeff_del);
bufif1 u_Q_12 (Q[12], Q_tmp[12], OEeff_del);
bufif1 u_Q_13 (Q[13], Q_tmp[13], OEeff_del);
bufif1 u_Q_14 (Q[14], Q_tmp[14], OEeff_del);
bufif1 u_Q_15 (Q[15], Q_tmp[15], OEeff_del);
bufif1 u_Q_16 (Q[16], Q_tmp[16], OEeff_del);
bufif1 u_Q_17 (Q[17], Q_tmp[17], OEeff_del);
bufif1 u_Q_18 (Q[18], Q_tmp[18], OEeff_del);
bufif1 u_Q_19 (Q[19], Q_tmp[19], OEeff_del);
bufif1 u_Q_20 (Q[20], Q_tmp[20], OEeff_del);
bufif1 u_Q_21 (Q[21], Q_tmp[21], OEeff_del);
bufif1 u_Q_22 (Q[22], Q_tmp[22], OEeff_del);
bufif1 u_Q_23 (Q[23], Q_tmp[23], OEeff_del);
bufif1 u_Q_24 (Q[24], Q_tmp[24], OEeff_del);
bufif1 u_Q_25 (Q[25], Q_tmp[25], OEeff_del);
bufif1 u_Q_26 (Q[26], Q_tmp[26], OEeff_del);
bufif1 u_Q_27 (Q[27], Q_tmp[27], OEeff_del);
bufif1 u_Q_28 (Q[28], Q_tmp[28], OEeff_del);
bufif1 u_Q_29 (Q[29], Q_tmp[29], OEeff_del);
bufif1 u_Q_30 (Q[30], Q_tmp[30], OEeff_del);
bufif1 u_Q_31 (Q[31], Q_tmp[31], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf , WEM_active);
and u_CHKEN7A_0 ( CHKEN7A, ME_buf, ADRFLAGA, WE_buf);
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );
assign WEMbus = { WEM_buf };
assign WEM_active = ((|(WEMbus)===0)?1'b0:1'b1);
assign WEM_active_eff = WEM_active;
assign WEM_active_eff_L = WEM_active_L;

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.912,
        Tcqx =  0.702,

        Toq  =  0.505,
        Toqz =  0.529,

        Tcc  =  1.931,
        Tcl  =  0.563,
        Tch  =  0.515,

        Tac  =  0.351,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.092,

        Twmc  =  0.352,
        Tcwmx =  0.092,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[8] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[9] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[10] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[11] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[12] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[13] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[14] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[15] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[16] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[17] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[18] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[19] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[20] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[21] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[22] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[23] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[24] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[25] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[26] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[27] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[28] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[29] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[30] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[31] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[8] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[9] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[10] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[11] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[12] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[13] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[14] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[15] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[16] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[17] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[18] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[19] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[20] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[21] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[22] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[23] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[24] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[25] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[26] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[27] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[28] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[29] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[30] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[31] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[8] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[9] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[10] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[11] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[12] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[13] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[14] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[15] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[16] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[17] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[18] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[19] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[20] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[21] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[22] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[23] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[24] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[25] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[26] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[27] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[28] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[29] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[30] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[31] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );

    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[0] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[1] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[2] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, posedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );
    $setuphold (posedge CLK &&& CHKEN7A, negedge WEM[3] &&& CHKEN7A, Twmc, Tcwmx, notif_a_wem );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_8kx32m16_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WEM_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_wem, notif_a_clk); 
parameter MES_ALL = "ON", A_bit=13, I_bit=32, I_word=8192, bsel_bit=4;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input  [bsel_bit -1:0]  WEM_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
input notif_a_wem;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg[ bsel_bit -1:0] WEMlatched;
reg MElatched;
reg ME_chk;
real CLKA_T;
wire [I_bit -1:0] WEMall;
reg [I_bit -1:0] WEMbuslatched;
integer wem_bit_cnt_a;
integer count_a;
integer cnt_a;
reg  [I_bit -1:0] mask_a;
reg  [I_bit -1:0] tmp_array_element_a;
reg  [I_bit -1:0] tmp_din_a;
integer wem_bit_a_corrupt;
integer count_a_corrupt;
integer cnt_a_corrupt;
reg  [I_bit -1:0] mask_a_corrupt;
reg  [I_bit -1:0] tmp_array_a_corrupt;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok,flaga_wem_ok} ) // only 1 and 0

  4'b1111   : ;                                               // everything ok!!!

  4'b1011,
  4'b1001,
  4'b1010,
  4'b1000   : corrupt_cur_loc(ADRlatched);         // WE is unstable

  4'b1101   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)
               corrupt_cur_loc(ADRlatched);        // Data is unstable

  4'b0001,
  4'b0011,
  4'b0000,
  4'b0010   : corrupt_all_loc(flaga_range_ok);           // ADR and WE unstable

  4'b0100,
  4'b0110   : if (WElatched !== 1'b0)
              corrupt_all_loc(flaga_range_ok);

  4'b0101,
  4'b0111   : if (WElatched === 1'b1 && WEMlatched !== 4'b0000)   // ADR unstable, WE stable
               corrupt_all_loc(flaga_range_ok);

  4'b1100,
  4'b1110   : if (WElatched !== 1'b0)
               corrupt_cur_loc(ADRlatched);        // WEM is unstable

 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

assign WEMall = { {8{WEM_buf[3]}},{8{WEM_buf[2]}},{8{WEM_buf[1]}},{8{WEM_buf[0]}} };
always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(notif_a_wem)               //PORT A WEM violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
    flaga_wem_ok  = `False;
    checkSanityOnAport;
   end
 end

always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_8kx32m16_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_8kx32m16_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
  WEMlatched = WEM_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_8kx32m16_g1_core)",$realtime);
    end  
   end 
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(WEMlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin 
      $display("<<WEM unknown>>"); 
      $display("      time=%t; instance=%m (rspb18_8kx32m16_g1_core)",$realtime); 
    end   
   end  
  WEMbuslatched = WEMall;
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_8kx32m16_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_8kx32m16_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      if (is_adr_Valid(ADRlatched) != `True && WEMlatched == 4'b0000) 
          flaga_range_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_8kx32m16_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 8191\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_8kx32m16_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        for ( wem_bit_cnt_a = 0; ((wem_bit_cnt_a < bsel_bit) && (flaga_wem_ok != `False));wem_bit_cnt_a = wem_bit_cnt_a + 1)
         begin
          if ( WEMlatched[wem_bit_cnt_a] === 1'bx ) begin
           flaga_wem_ok = `False;
           if ( WE_buf == 1'b1 )
            flaga_read_ok = `False;
          end
         end

        if (flaga_we_ok && flaga_wem_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         begin
          tmp_array_element_a = mem_core_array[ADRlatched];
          mem_core_array[ADRlatched] = ((mem_core_array[ADRlatched] & ~WEMbuslatched) | ( Dlatched & WEMbuslatched)) ^ ( WEMbuslatched ^ WEMbuslatched);
         end
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_8kx32m16_g1_core)",$realtime);
      end
  end
 end


endmodule
//---------------------------------------------------------------------
//               Copyright(c) Virage Logic Corporation.                
//     All Rights reserved - Unpublished -rights reserved under        
//     the Copyright laws of the United States of America.             
//                                                                     
//  This file includes the Confidential information of Virage Logic    
//  The receiver of this Confidential Information shall not disclose   
//  it to any third party and shall protect its confidentiality by     
//  using the same degree of care, but not less then a reasonable      
//  degree of care, as the receiver uses to protect receiver's own     
//  Confidential Information.                                          
//                                                                     
//                    Virage Logic Corporation.                        
//                    46501 Landing Parkway                            
//                    Fremont , California 94538.                      
//                                                                     
//---------------------------------------------------------------------
//                                                                     
//  Software           : Rev: 3.2.0 (build REL-3-2-0-2002-09-27)       
//  Library Format     : Rev: 1.05.00                                  
//  Compiler Name      : ts18s1p11hdsb04p4                             
//  Date of Generation : Thu Feb 27 15:08:39 JST 2003                  
//                                                                     
//---------------------------------------------------------------------
//   --------------------------------------------------------------     
//                       Template Revision : 1.1.9                      
//   --------------------------------------------------------------     
//  ************************************************************
//     *    Synchronous, 1-Port Read/Write RAM      *
//            *  Verilog Behavioral Model  *
// *************************************************************
//
// THIS IS A SYNCHRONOUS 1-PORT MEMORY MODEL
// WHICH TAKES BOTH TIMING CHECKS AND DELAY DATA FROM SDF ONLY
//
// Memory Name:       rspb18_8kx8m16_g1
// Memory Size:       8192 words x 8 bits
//
//                 PORT NAME
//                 ---------
// Input Ports:
//
//                 ADR [12:0]
//                 D  [7:0]
//                 WE
//                 OE
//                 ME
//                 CLK

// Output Ports:
//
//                 Q [7:0]
//
// *************************************************************
`resetall 

`timescale 1 ns / 1 ps 
`celldefine 
`suppress_faults 
`enable_portfaults 

`define True    1'b1
`define False   1'b0
module rspb18_8kx8m16_g1 ( Q, ADR, D,WE, OE, ME,  CLK);

parameter MES_ALL = "ON";

output [7:0] Q;
wire [7:0] Q;

input [12:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

// Local registers, wires, etc

wire [7:0]    Q_tmp;
wire [12:0]    ADR_buf;
wire [7:0]    D_buf;
wire OE_eff;
wire OEeff_del;
reg  notif_a_we, notif_a_adr, notif_a_d, notif_a_clk, notif_a_me;
reg  ME_buf_L;
reg  WE_buf_L;
reg [12:0] ADR_buf_L;
reg [12:0] preADR;
reg ADRFLAGA;
wire CHKEN1A;
wire CHKEN2A;
wire CHKEN3A;
wire CHKEN4A;
wire CHKEN7A;

buf ADR_buf_u0 ( ADR_buf[0], ADR[0] );
buf ADR_buf_u1 ( ADR_buf[1], ADR[1] );
buf ADR_buf_u2 ( ADR_buf[2], ADR[2] );
buf ADR_buf_u3 ( ADR_buf[3], ADR[3] );
buf ADR_buf_u4 ( ADR_buf[4], ADR[4] );
buf ADR_buf_u5 ( ADR_buf[5], ADR[5] );
buf ADR_buf_u6 ( ADR_buf[6], ADR[6] );
buf ADR_buf_u7 ( ADR_buf[7], ADR[7] );
buf ADR_buf_u8 ( ADR_buf[8], ADR[8] );
buf ADR_buf_u9 ( ADR_buf[9], ADR[9] );
buf ADR_buf_u10 ( ADR_buf[10], ADR[10] );
buf ADR_buf_u11 ( ADR_buf[11], ADR[11] );
buf ADR_buf_u12 ( ADR_buf[12], ADR[12] );

buf D_buf_u0 ( D_buf[0], D[0] );
buf D_buf_u1 ( D_buf[1], D[1] );
buf D_buf_u2 ( D_buf[2], D[2] );
buf D_buf_u3 ( D_buf[3], D[3] );
buf D_buf_u4 ( D_buf[4], D[4] );
buf D_buf_u5 ( D_buf[5], D[5] );
buf D_buf_u6 ( D_buf[6], D[6] );
buf D_buf_u7 ( D_buf[7], D[7] );

buf WE_buf_u0 ( WE_buf, WE );
buf OE_buf_u0 ( OE_buf, OE );
buf ME_buf_u0 ( ME_buf, ME );
buf CLK_buf_u0 ( CLK_buf, CLK );

IntComp_rspb18_8kx8m16_g1 #(MES_ALL,13, 8, 8192) u0  ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk);
and u_OE_0 (OE_eff, OE_buf, 1'b1);
function is_adr_Valid;  // 1-bit return value

 input [12:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= 12; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1))
    ret_value = `False;
   if((addr_to_check > 8191) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction


initial
 begin
  ME_buf_L = 1'b0;
  ADRFLAGA = 1;
 end

always @( ADR_buf or negedge CLK_buf)
 begin
   if ( CLK_buf == 1'b0) preADR = ADR_buf;
 end

always @( posedge CLK_buf)
 begin
  ME_buf_L = ME_buf;
  WE_buf_L = WE_buf;

 end



always @ ( ADR_buf )
 begin
  if ( $realtime != 0) begin
   if (( ADR_buf > 8191) || (ADR_buf < 0 ))
    ADRFLAGA = 0;
   else
    ADRFLAGA = 1;
  end
 end

buf #0.001 u_OEeff_del_0 ( OEeff_del, OE_eff );

bufif1 u_Q_0 (Q[0], Q_tmp[0], OEeff_del);
bufif1 u_Q_1 (Q[1], Q_tmp[1], OEeff_del);
bufif1 u_Q_2 (Q[2], Q_tmp[2], OEeff_del);
bufif1 u_Q_3 (Q[3], Q_tmp[3], OEeff_del);
bufif1 u_Q_4 (Q[4], Q_tmp[4], OEeff_del);
bufif1 u_Q_5 (Q[5], Q_tmp[5], OEeff_del);
bufif1 u_Q_6 (Q[6], Q_tmp[6], OEeff_del);
bufif1 u_Q_7 (Q[7], Q_tmp[7], OEeff_del);
and u_CHKEN1A_0 ( CHKEN1A, ME_buf, ADRFLAGA);
and u_CHKEN4A_0 ( CHKEN4A, ME_buf, ADRFLAGA, WE_buf );
buf u_CHKEN3A_0 ( CHKEN3A, ME_buf );

buf u_CHKEN2A_0 ( CHKEN2A, ADRFLAGA );

// The following is Timing-dependent section of this model

specify

    specparam PATHPULSE$OE$Q = ( 0, 0.001 );
    specparam
        Tcq  =  1.750,
        Tcqx =  0.646,

        Toq  =  0.371,
        Toqz =  0.389,

        Tcc  =  1.767,
        Tcl  =  0.562,
        Tch  =  0.525,

        Tac  =  0.347,
        Tcax =  0.000,

        Twc  =  0.351,
        Tcwx =  0.000,
        Tdc  =  0.352,
        Tcdx =  0.033,

        Tmc  =  0.344,
        Tcmx =  0.000;

                                            /* using the Z transition place holder for Tcqx so that we
                                               can control the X-transition of the output */

    if (  OE )
       ( posedge CLK => ( Q[0] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[1] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[2] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[3] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[4] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[5] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[6] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);
    if (  OE )
       ( posedge CLK => ( Q[7] : 1'bx )) = (Tcq, Tcq, Tcqx, Tcq, Tcqx, Tcq);

       ( OE => Q[0] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[1] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[2] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[3] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[4] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[5] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[6] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);
       ( OE => Q[7] ) = (Toq, Toq, Toqz, Toq, Toqz, Toq);

// Timing Checks
    $width (negedge CLK, Tcl, 0, notif_a_clk);
    $width (posedge CLK, Tch, 0, notif_a_clk);
    $period (negedge CLK, Tcc, notif_a_clk);
    $period (posedge CLK, Tcc, notif_a_clk);
    $setuphold (posedge CLK &&& ME, posedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[0] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[1] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[2] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[3] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[4] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[5] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[6] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[7] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[8] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[9] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[10] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[11] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, posedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );
    $setuphold (posedge CLK &&& ME, negedge ADR[12] &&& ME, Tac, Tcax, notif_a_adr );

    $setuphold (posedge CLK &&& CHKEN2A, posedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );
    $setuphold (posedge CLK &&& CHKEN2A, negedge ME &&& CHKEN2A, Tmc, Tcmx, notif_a_me );

    $setuphold (posedge CLK &&& CHKEN1A, posedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );
    $setuphold (posedge CLK &&& CHKEN1A, negedge WE &&& CHKEN1A, Twc, Tcwx, notif_a_we );

    $setuphold (posedge CLK &&& CHKEN4A, posedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[0] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[1] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[2] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[3] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[4] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[5] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[6] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, posedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );
    $setuphold (posedge CLK &&& CHKEN4A, negedge D[7] &&& CHKEN4A, Tdc, Tcdx, notif_a_d );


endspecify

endmodule

`disable_portfaults 
`nosuppress_faults 
`endcelldefine

// The following is the sub-module used in definition of overall memory module
// ===========================================================================
module IntComp_rspb18_8kx8m16_g1   ( Q_tmp, CLK_buf,  ADR_buf, D_buf, WE_buf, OE_buf, ME_buf, notif_a_we, notif_a_adr, notif_a_d, notif_a_me,   notif_a_clk); 
parameter MES_ALL = "ON", A_bit=13, I_bit=8, I_word=8192;

output  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_tmp;
reg  [I_bit -1:0]  Q_local;


wire   [I_bit -1:0]  Q_temp;
reg [I_bit-1:0] allX , allZ ;

input CLK_buf;
input  [A_bit -1:0]  ADR_buf;
input  [I_bit -1:0]  D_buf;
input WE_buf;
input OE_buf;
input ME_buf;

input notif_a_we, notif_a_adr, notif_a_d, notif_a_me, notif_a_clk;
integer i;
initial begin
        for ( i=0; i < I_bit ; i=i+1 ) begin
                allX[i] = 1'bx ; allZ[i] = 1'bz ;
        end
end 
reg [I_bit -1:0] mem_core_array [0:I_word -1];
reg [I_bit -1:0] X_a_corrupt;

reg
        flaga_read_ok,
        flaga_we_ok,
        flaga_d_ok,
        flaga_wem_ok,
        flaga_adr_ok,
        flaga_range_ok;
reg     flaga_adr_viol;
reg     flaga_clk_valid;
reg     flaga_adr_x;

event   ev_read_out_a_port;

reg[A_bit -1:0] ADRlatched;
reg[I_bit -1:0] Dlatched;
reg WElatched;
reg MElatched;
reg ME_chk;
real CLKA_T;

function is_adr_Valid;  // 1-bit return value

 input [A_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `True;
  for (addr_bit_count = 0; addr_bit_count <= A_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    flaga_adr_x = `True;
    ret_value = `False;
   end
   if((addr_to_check > I_word -1) || (addr_to_check < 0))
    begin
     ret_value = `False;
    end
   is_adr_Valid = ret_value;
 end

endfunction

function is_x;  // 1-bit return value

 input [I_bit -1:0] addr_to_check;

 integer addr_bit_count;
 reg     ret_value;
 begin
  ret_value = `False;
  for (addr_bit_count = 0; addr_bit_count <= I_bit -1; addr_bit_count = addr_bit_count +1)
   if ((addr_to_check[addr_bit_count] !== 1'b0) && (addr_to_check[addr_bit_count] !== 1'b1)) begin
    ret_value = `True;
   end
   is_x = ret_value;
 end

endfunction

// -------------------------------------------------------------------
// Common tasks
// -------------------------------------------------------------------


task corrupt_all_loc;

 input flag_range_ok;
 integer addr_index;
 begin
                                     // do not corrupt entire memory if write to
                                    // out of range address, for all other cases
                                    // flag_range_ok is true, therefore corruption
                                    // will occur as before
  if( flag_range_ok == `True)
   begin
    for( addr_index = 0; addr_index < I_word; addr_index = addr_index + 1) begin
     mem_core_array[ addr_index] = allX;
    end
   end
 end

endtask

task corrupt_cur_loc;

 input[A_bit -1:0] loc_to_corrupt;

 if (is_adr_Valid (loc_to_corrupt))
  mem_core_array[loc_to_corrupt] = allX;
 else
  corrupt_all_loc(`True);

endtask




// Perform Sanity Check on Port A, Corrupt memory if required

task checkSanityOnAport;

 #0                // let CLOCK and NOTIFIER stuff execute first
 case ( {flaga_adr_ok, flaga_we_ok, flaga_d_ok} ) // only 1 and 0

  3'b111   : ;                                                // everything ok!!!

  3'b101,
  3'b100   : corrupt_cur_loc(ADRlatched);          // WE is unstable

  3'b110   : if (WElatched !== 1'b0)
              corrupt_cur_loc(ADRlatched);         // Data is unstable
  3'b000,
  3'b001   : corrupt_all_loc(flaga_range_ok);            // ADR and WE unstable
  3'b010,
  3'b011   : if (WElatched !== 1'b0)    // ADR unstable, WE stable
              corrupt_all_loc(flaga_range_ok);
 endcase
endtask

// PORT A FUNCTIONALITY (Handle violation behavior)

initial
 begin
  flaga_adr_ok  = `True;
  flaga_range_ok = `True;
  flaga_we_ok   = `True;
  flaga_d_ok    = `True;
  flaga_wem_ok   = `True;
  flaga_read_ok = `True;
  flaga_adr_viol = `True;
  flaga_clk_valid = `True;
  flaga_adr_x = `False;
 end

always @(notif_a_we)            // PORT A WE violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_we_ok = `False;
    checkSanityOnAport;
    disable OUTPUT_a;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end

always @(notif_a_clk)            // PORT A CLK violation
 begin
  disable OUTPUT_a;
  flaga_adr_ok = `False;
  flaga_we_ok  = `False;
  checkSanityOnAport;
  flaga_read_ok = `False;     // irrespective of WE
  -> ev_read_out_a_port;
 end

always @(notif_a_me)            // PORT A ME violation
 begin
  flaga_adr_ok = `False;
  flaga_read_ok = `False;     // irrespective of WE
  disable OUTPUT_a;
  checkSanityOnAport;
  -> ev_read_out_a_port;
 end

always @(notif_a_adr)           // PORT A ADR violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    if (WElatched === 1'b0)
      begin
    corrupt_all_loc(`True);
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    -> ev_read_out_a_port;
      end
     else  begin
    flaga_adr_ok = `False;
    flaga_read_ok = `False; // irrespective of WE
    disable OUTPUT_a;
    checkSanityOnAport;
    -> ev_read_out_a_port;
      end
   end
 end

always @(notif_a_d)             // PORT A D violation
 begin
  if ( $realtime == CLKA_T )
   ME_chk = ME_buf;
  else
   ME_chk = MElatched;
  if (ME_chk !== 1'b0)
   begin
    flaga_d_ok = `False;
    disable OUTPUT_a;
    checkSanityOnAport;
    flaga_read_ok = `False;
    -> ev_read_out_a_port;
   end
 end




always @(negedge CLK_buf)          // reset for next cycle
 begin
  if ( CLK_buf !== 1'bx ) begin
   #0.001;
   flaga_range_ok  = `True;
   flaga_read_ok = `True;
   flaga_adr_viol = `True;
   flaga_clk_valid = `True;
   flaga_adr_x = `False;
  end
  else
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_8kx8m16_g1_core)",$realtime);
    end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
   end
 end

// PORT A FUNCTIONALITY (Handle normal read/write)

always @(posedge CLK_buf)
 begin
   flaga_adr_ok  = `True;
   flaga_we_ok   = `True;
   flaga_d_ok    = `True;
   flaga_wem_ok   = `True;
  if ( CLK_buf === 1'bx) begin
   if( MES_ALL=="ON" && $realtime != 0) begin
    $display("<<CLK unknown>>");
    $display("      time=%t; instance=%m (rspb18_8kx8m16_g1_core)",$realtime);
   end
    flaga_clk_valid = `False;
    Q_local = allX;
    corrupt_all_loc(`True);
  end
  CLKA_T = $realtime;
  MElatched = ME_buf;
  WElatched = WE_buf;
  ADRlatched = ADR_buf;
  Dlatched = D_buf;
   if( MES_ALL=="ON" && $realtime != 0) begin
    if ( is_x(Dlatched) && WElatched == 1'b1 && MElatched == 1'b1) begin
      $display("<<D unknown>>");
      $display("      time=%t; instance=%m (rspb18_8kx8m16_g1_core)",$realtime);
    end  
   end 
  if (!flaga_clk_valid)
   Q_local = allX;
  else if ( CLK_buf === 1'bx )
   begin
    if( MES_ALL=="ON" && $realtime != 0) begin
     $display("<<CLK unknown>>");
     $display("      time=%t; instance=%m (rspb18_8kx8m16_g1_core)",$realtime);
    end
    Q_local = allX;
    corrupt_all_loc(flaga_range_ok);
   end
  else
   begin
    if (ME_buf !== 1'b0)
     begin
      if (WE_buf === 1'bx) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<WE unknown>>");
          $display("      time=%t; instance=%m (rspb18_8kx8m16_g1_core)",$realtime);
        end
       flaga_we_ok = `False;
      end
      if (ME_buf !== 1'b1)
       flaga_we_ok = `False;       // don't know if cycle is On or Off
      if (is_adr_Valid(ADRlatched) != `True ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
         if ( flaga_adr_x ) begin
           $display("<<ADR unknown>>");
           $display("      time=%t; instance=%m (rspb18_8kx8m16_g1_core)",$realtime);
         end
        end
       flaga_adr_ok = `False;
      if(((ADRlatched > I_word -1)|| ( ADRlatched < 0)) && (MElatched != 1'b0))
       begin
        $display("\n%m WARNING:address is out of range\n RANGE:0 to 8191\n");
        flaga_range_ok = `False;
       end
      else begin
        if (WElatched === 1'b0 && ME_buf === 1'b1 )
         corrupt_all_loc(`True);
      end
      end
      if ( ME_buf === 1'bx ) begin
        if( MES_ALL=="ON" && $realtime != 0) begin
          $display("<<ME unknown>>");
          $display("      time=%t; instance=%m (rspb18_8kx8m16_g1_core)",$realtime);
        end
       Q_local = allX;
      if (WE_buf !== 1'b0)
       corrupt_all_loc(flaga_range_ok);
      end
      else
       begin
        if (flaga_we_ok && flaga_adr_ok && flaga_d_ok && (WE_buf == 1'b1))
         mem_core_array[ADRlatched] = Dlatched;  // write data in
        else
         begin
          checkSanityOnAport;
         end
        -> ev_read_out_a_port;
       end
     end
   end
 end


// PORT A READ-OUT

always @(ev_read_out_a_port)
 begin
  #0                // let CLOCK and NOTIFIER module execute first
  if (flaga_adr_ok && (ADRlatched <= I_word -1) && flaga_read_ok) begin : OUTPUT_a
   if (WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    begin
     Q_local = allX;
     #0.001
      Q_local = mem_core_array[ADRlatched];
    end
  end
  else
   begin
        if (is_adr_Valid(ADRlatched) != `True && WElatched == 1'b1) begin
    Q_local = allX;
    #0.001
    Q_local = Dlatched;
   end
   else
    Q_local = allX;
    flaga_read_ok = `True;
   end
 end
assign Q_temp = Q_local;

always @( Q_temp or OE_buf )
 begin
  if ( OE_buf == 1'b1 )
   Q_tmp = Q_temp;
  else if ( OE_buf == 1'b0 )
   begin
    Q_tmp = allX;
    #0.001;
    if ( OE_buf == 1'b1 )
      Q_tmp = Q_temp;
    else if ( OE_buf == 1'b0 )
      Q_tmp = allZ;
    else begin
      Q_tmp = allX;
    end
   end
  else begin
   Q_tmp = allX;
  end
 end
always @( OE_buf )
 begin
  if ( OE_buf ===  1'bx )
  begin
      if( MES_ALL=="ON" && $realtime != 0) begin
        $display("<<OE unknown>>");
        $display("      time=%t; instance=%m (rspb18_8kx8m16_g1_core)",$realtime);
      end
  end
 end


endmodule
