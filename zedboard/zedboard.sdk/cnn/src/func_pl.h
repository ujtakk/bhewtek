/*
 * This source declares functions to work on PL
 */

#ifndef __FUNC_PL_H_
#define __FUNC_PL_H_

// input reg
#define reg_req          XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG0_OFFSET
#define reg_output_re    XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG1_OFFSET
#define reg_weight_we    XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG2_OFFSET
#define reg_input_we     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG3_OFFSET
#define reg_total_out    XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG4_OFFSET
#define reg_total_in     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG5_OFFSET
#define reg_img_size     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG6_OFFSET
#define reg_fil_size     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG7_OFFSET
#define reg_input_addr   XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG8_OFFSET
#define reg_write_input  XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG9_OFFSET
#define reg_weight_addr  XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG10_OFFSET
#define reg_write_weight XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG11_OFFSET
#define reg_output_addr  XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG12_OFFSET

// output reg
#define reg_ack          XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG255_OFFSET
#define reg_read_output  XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG254_OFFSET
#define reg_probe_in     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG253_OFFSET
#define reg_probe_w0     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG252_OFFSET
#define reg_probe_w1     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG251_OFFSET
#define reg_probe_w2     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG250_OFFSET
#define reg_probe_w3     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG249_OFFSET
#define reg_probe_w4     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG248_OFFSET
#define reg_probe_w5     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG247_OFFSET
#define reg_probe_w6     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG246_OFFSET
#define reg_probe_w7     XPAR_AAAASD_0_S_AXI_BASEADDR + AAAASD_S_AXI_SLV_REG245_OFFSET

#include "xil_types.h"

void post_input (s16 *input, int total_in, int img_size);
void post_weight (s16 *weight, int total_out, int total_in, int fil_size);
void post_parameter (int total_out, int total_in, int img_size, int fil_size);
void post_data (s16 *input, s16 *weight,
    int total_out, int total_in, int img_size, int fil_size);
void exec_core (void);
void get_data(s16 *output, int total_out, int img_size);
void post_process (s16 *pmap, s16 *bias, int total_out, int img_size);
void test_platform (void);

#endif
