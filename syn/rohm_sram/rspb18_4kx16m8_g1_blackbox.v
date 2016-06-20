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

input [11:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

endmodule
