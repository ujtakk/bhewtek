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

input [6:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [6:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [6:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [6:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

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

input [13:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [13:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [13:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [13:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

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

input [9:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [9:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [9:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [9:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

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

input [7:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [7:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [7:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [7:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

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

input [10:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [10:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [10:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [10:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

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

input [11:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [11:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [11:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [11:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

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

input [8:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [8:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [8:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [8:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

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

input [12:0] ADR;
input [15:0] D;
input [1:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [12:0] ADR;
input [23:0] D;
input [2:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [12:0] ADR;
input [31:0] D;
input [3:0] WEM;
input WE;
input OE;
input ME;
input CLK;

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

input [12:0] ADR;
input [7:0] D;
input WE;
input OE;
input ME;
input CLK;

endmodule
