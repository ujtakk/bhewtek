/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE            |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite  Configurable only in HW design
 *   ps7_uart  115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <limits.h>
#include <unistd.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"

#include "cnn.h"
#include "pmap1_flat.h"
//#include "pmap2_flat.h"
#include "w_conv2_flat.h"
#include "b_conv2.h"
#include "w_hidden.h"
#include "b_hidden.h"
#include "w_output.h"
#include "b_output.h"

/*
 * TODO: We use stupid loading method (array initialization for specific data)
 *     for temporal working.
 * TODO: Therefore, high dimentional load functions are not implemented.
 */
void load_images(s16 ***image_map,
         const int i1, const int i2, const int i3)
{
}

void load_images_flat(s16 *image_map,
         const int i1, const int i2, const int i3)
{
}

void load_weight(s16 **weight_matrix,
         const int i1, const int i2)
{
}

void load_weight_flat(s16 *weight_matrix,
         const int i1, const int i2, const int i3, const int i4)
{
}

void load_bias(s16 *bias_vector,
         const int i1)
{
}

// TODO: Give the address of two dim. array To two dim. pointer
//       (Dont want to implement as dynamic array)
//        => flat the array
void full_connect(s16 *input, s16 *output, s16 *weight,
          s16 *bias, const int ilen, const int olen)
{
  int i,j;
  int base = 0;
  s32 pro;
  s16 sum=0;
  for (i=0; i<olen; i++)
  {
    for (j=0; j<ilen; j++)
    {
      pro = input[j] * weight[base+j] / (int)pow(2,8);
      sum += (s16)pro;
    }

    output[i] = sum + bias[i];
    sum=0;
    base += ilen;
  }
}

void activate_1d(s16 *input,const int ilen){
  int i;
  for(i=0;i<ilen;i++){
    if(input[i]<0){
      input[i] = 0;
    }
  }
}

int softmax(double *output,int len)
{
  int i;
  double expsum=0.0;

  for (i=0; i<len; i++)
  {
    expsum += exp(output[i]);
  }

  if (expsum == 0)
  {
    return 1;
  }
  else
  {
    for (i=0; i<len; i++)
    {
      output[i] = exp(output[i])/expsum;
    }

    return 0;
  }
}

u32 concat8_32(u8 data0, u8 data1, u8 data2, u8 data3)
{
  u32 total = (data0 << 24) | (data1 << 16) | (data2 << 8) | data3;

  return total;
}

u32 concat16_32(u16 upper, u16 lower)
{
  u32 total = (upper << 16) | lower;

  return total;
}

u32 concat32_64(u16 upper, u16 lower)
{
  u32 total = (upper << 16) | lower;

  return total;
}

void print_port()
{
  int port[8];

  port[0] = Xil_In32(reg_req);
  port[1] = Xil_In32(reg_enable);
  port[2] = Xil_In32(reg_param);
  port[3] = Xil_In32(reg_input);
  port[4] = Xil_In32(reg_weight);
  port[5] = Xil_In32(reg_out_addr);
  port[6] = Xil_In32(reg_out_val);
  port[7] = Xil_In32(reg_ack);

  //printf("%04x : %3x : %8x : %8x : %8x : %4x : %8x a: %1x\n",
  printf("%x : %x : %x : %x : %x : %x @@ %x : %x\n",
          port[0], port[1], port[2], port[3], port[4], port[5], port[6], port[7]);
  usleep(1000);
}

void probe_data(void)
{
  const int faccum = 128;
  int i;
  int tmp;

  Xil_Out32(reg_req, (0x1 << 8));
  for (i=0; i<faccum; i++)
  {
    Xil_Out32(reg_enable, (i << 16));
    tmp = rand()%256;
    Xil_Out32(reg_req, ((tmp << 16) | 0x1 << 8));
  }
  Xil_Out32(reg_req, (0x0 << 8));
}

void post_data(s16 *input, s16 *weight)
{
  const int in_size  = N_F1 * PM1HEI * PM1WID;
  const int w_unit   = N_F1 * FHEI * FWID;
  const int w_size   = N_F2 * w_unit;

  int i;
  int w_mem_addr, core_num;
  int enables, data;
  int params;

  enables = 0x1;
  Xil_Out32(reg_enable, enables);

  /* write input */
  for (i=0; i<in_size; i++)
  {
    data = concat16_32(i, input[i]);
    Xil_Out32(reg_input, data);
    print_port();
  }

  enables = 0x0;
  Xil_Out32(reg_enable, enables);

  /* write weight */
  for (i=0; i<w_size; i++)
  {
    // Give enables
    w_mem_addr = i % w_unit;
    if (w_mem_addr == 0)
    {
      core_num = (i / w_unit) % CORE + 1;
      enables = core_num << 1;
      Xil_Out32(reg_enable, enables);
    }
    data = concat16_32(w_mem_addr, weight[i]);
    Xil_Out32(reg_weight, data);
    print_port();
  }

  enables = 0x0;
  Xil_Out32(reg_enable, enables);

  /* write parameters */
  params = concat8_32(N_F2, N_F1, PM1HEI, FSIZE);
  Xil_Out32(reg_param, params);
}

void exec_core()
{
  int ack;
  Xil_Out32(reg_req, 0x1);
  Xil_Out32(reg_req, 0x0);

  // when pl returns ack, return control to main.
  while (1)
  {
    probe_data();
    ack = Xil_In32(reg_ack);
    if (ack) return;
    //sleep(10);
  }
}

void get_data(s16 *output)
{
  //TODO: split the address of each core.
  const int o_size = N_F2 * PM2HEI * PM2WID;
  const int o_unit   = PM2HEI * PM2WID;

  int i;
  int o_offset, o_index;
  int o_mem_addr;
  int enables, data;

  for (i=0; i<o_size; i++)
  {
    o_offset = i % o_unit;
    o_index  = i / o_unit;
    if (o_offset == 0)
    {
      enables = (o_index % CORE + 1) << 5;
      Xil_Out32(reg_enable, enables);
    }
    o_mem_addr = o_offset + o_unit*(o_index/CORE);
    //Xil_Out32(reg_weight, concat16_32(o_mem_addr, 0x0000));
    Xil_Out32(reg_out_addr, o_mem_addr);
    //sleep(1);
    data = Xil_In32(reg_out_val);
    output[i] = data;
    print_port();
  }

  enables = 0x0;
  Xil_Out32(reg_enable, enables);
}

void print_result(s16 *output)
{
  int i;
  int number = -1;
  int temp = INT_MIN;

  //xil_printf("Hello World\n\r");

  for (i=0; i<LABEL; i++)
  {
    xil_printf("%d\n\r",output[i]);

    if (temp < output[i])
    {
      temp = output[i];
      number = i;
    }
  }

  xil_printf("the answer is %d.\n\r", number);
  //for (i=0; i<500; i++)
  //  for (j=0; j<800; j++)
  //    xil_printf("(%d, %d): %d\n\r", i, j, (pmap2_flat[j] * w_hidden[i][j])/(int)pow(2,8));
}

int main()
{
  //s16 pmap1[N_F1][PM1HEI][PM1WID];
  //s16 pmap2[N_F2][PM2HEI][PM2WID];
  //s16 w_conv2[N_F2][N_F1][FHEI][FWID];
  s16 pmap2_flat[N_F2*PM2HEI*PM2WID] = {};
  s16 hidden[N_HL];
  s16 output[LABEL];

  // These arrays are defined as global variables.
  /*
  s16 pmap1_flat[N_F1*PM1HEI*PM1WID];
  s16 w_conv2_flat[N_F2*N_F1*FHEI*FWID];
  s16 b_conv2[N_F2];
  s16 w_hidden[N_HL][PM2HEI*PM2WID*N_F2];
  s16 b_hidden[N_HL];
  s16 w_output[LABEL][N_HL];
  s16 b_output[LABEL];
  */

  //UINTPTR addr_base = XPAR_AXI_SLAVE_TOP_WRAPPER_0_BASEADDR;
  int i;
  init_platform();
  for (i=0; i<60; i++)
    xil_printf("\n\r");
  xil_printf("init_platform ended\n\r");

  MYIP_Reg_SelfTest((int *)XPAR_MYIP_0_S_AXI_BASEADDR);
  xil_printf("test_platform ended\n\r");

  // TODO: load data from the SD card using Linux
  //load_images_flat(pmap1_flat, N_F1, PM1HEI, PM1WID);

  //load_weight_flat(w_conv2_flat, N_F2, N_F1, FHEI, FWID);
  //load_bias(b_conv2, N_F2);
  //load_weight(w_hidden, N_HL, PM2HEI*PM2WID*N_F2);
  //load_bias(b_hidden, N_HL);
  //load_weight(w_output, LABEL, N_HL);
  //load_bias(b_hidden, LABEL);


  post_data(pmap1_flat, w_conv2_flat);
  xil_printf("post_data ended\n\r");
  probe_data();

  // : wait until PL finishes calculation
  //  => wait until both valid and ready raise
  exec_core();
  xil_printf("exec_core ended\n\r");

  get_data(pmap2_flat);
  xil_printf("get_data ended\n\r");

  // TODO: insert activate of conv2 to pl
  activate_1d(pmap2_flat, N_F2*PM2HEI*PM2WID);
  xil_printf("activation ended\n\r");

  /*
   * calculate fully connected layers on CPU
   * because these layers has tendency to be data intensive.
   */
  full_connect(pmap2_flat, hidden,
                w_hidden, b_hidden, PM2HEI*PM2WID*N_F2, N_HL);
  xil_printf("fully-connect ended\n\r");
  activate_1d(hidden, N_HL);

  full_connect(hidden, output,
                w_output, b_output, N_HL, LABEL);

  print_result(output);
  xil_printf("classification ended\n\r");

  cleanup_platform();

  return 0;
}
