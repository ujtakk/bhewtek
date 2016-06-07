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
#include <math.h>
#include <limits.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"

#include "cnn.h"
#include "pmap1_flat.h"
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

void full_connect(u16 *input, u16 *output, u16 **weight,
          u16 *bias, const int ilen, const int olen)
{
  int i,j;
  u32 pro;
  u16 sum=0;

  for (i=0; i<olen; i++)
  {
    for (j=0; j<ilen; j++)
    {
      pro = input[j] * weight[i][j] / (int)pow(2,8);
      sum += (u16)pro;
      xil_printf("%d : %d : %d : %d\n\r", i, j, pro, sum);
    }

    output[i] = sum + bias[i];
    sum=0;
  }
}

void activate_1d(u16 *input,const int ilen){
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

void post_data(s16 *input, s16 *weight)
{
  const int in_size    = N_F1 * PM1HEI * PM1WID;
  const int w_unit     = N_F1 * FHEI * FWID;
  const int w_size     = N_F2 * w_unit;
  const int min_size     = w_size > in_size ? in_size : w_size;
  const int max_size     = w_size > in_size ? w_size : in_size;

  int i;
  int core_num;
  int enables, option, data;

  UINTPTR addr_input = 0x0;

  for (i=0; i<max_size; i++)
  {
    // Give enables
    if (i % w_unit == 0)
    {
      addr_input &= mask_enable;
      core_num = (i / w_unit) % CORE + 1;
      enables = 0x2 | (core_num << 2);
      Xil_Out32(addr_input, enables);
    }

    addr_input = (i << INSIZE) | i;
    addr_input &= mask_address;

    if (i < min_size)
      data = (weight[i] << 16) | input[i];
    else if (w_size > in_size)
      data = (weight[i] << 16) | 0;
    else
      data = input[i];

    Xil_Out32(addr_input, data);
  }

  addr_input &= mask_parameter;
  option = concat8_32(N_F2, N_F1, PM1HEI, FSIZE);
  Xil_Out32(addr_input, option);

}

void get_data(s16 *output)
{
  //TODO: split the address of each core.
  const int out_size = N_F2 * PM2HEI * PM2WID;

  int i;
  int data;

  UINTPTR addr_output = 0x0;

  for (i=0; i<out_size; i++)
  {
    addr_output = i;
    addr_output &= mask_address;
    data = Xil_In32(addr_output);
    output[i] = data & 0x0000FFFF;
  }

}

void exec_core()
{
  int req = 0x1;
  //int i=0;

  UINTPTR addr_input = 0x0;

  addr_input &= mask_enable;
  Xil_Out32(addr_input, req);

  // when pl returns ack, return control to main.
  //while (1)
  //{
    if (Xil_In32(0) & mask_ack)
      return;
    //printf("%d\n", i); i++;
  //};
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
}

int main()
{
  //s16 pmap1[N_F1][PM1HEI][PM1WID];
  //s16 pmap2[N_F2][PM2HEI][PM2WID];
  //s16 w_conv2[N_F2][N_F1][FHEI][FWID];
  u16 pmap2_flat[N_F2*PM2HEI*PM2WID];
  u16 hidden[N_HL];
  u16 output[LABEL];

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

  // : wait until PL finishes calculation
  //  => wait until both valid and ready raise
  exec_core();
  xil_printf("exec_core ended\n\r");

  get_data(pmap2_flat);
  xil_printf("get_data ended\n\r");

  // TODO: insert activate of conv2 to pl
  activate_1d(pmap2_flat, N_F2*PM2HEI*PM2WID);
  xil_printf("classification ended\n\r");
  printf("aa %d\n", pmap2_flat[10]);

  /*
   * calculate fully connected layers on CPU
   * because these layers has tendency to be data intensive.
   */
  full_connect(pmap2_flat, hidden,
                w_hidden, b_hidden, PM2HEI*PM2WID*N_F2, N_HL);
  xil_printf("classification ended\n\r");
  activate_1d(hidden, N_HL);

  full_connect(hidden, output,
                w_output, b_output, N_HL, LABEL);

  print_result(output);
  xil_printf("classification ended\n\r");

  cleanup_platform();

  return 0;
}
