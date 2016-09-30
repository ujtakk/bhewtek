/*
 * This source declares functions to work on PL
 */

#ifndef __FUNC_PL_H_
#define __FUNC_PL_H_

#include "xil_types.h"
#include "xparameters.h"
#include "copro.h"

// input reg
#define reg_req          XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG0_OFFSET
#define reg_output_re    XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG1_OFFSET
#define reg_weight_we    XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG2_OFFSET
#define reg_input_we     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG3_OFFSET
#define reg_total_out    XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG4_OFFSET
#define reg_total_in     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG5_OFFSET
#define reg_img_size     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG6_OFFSET
#define reg_fil_size     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG7_OFFSET
#define reg_pool_size    XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG8_OFFSET
#define reg_input_addr   XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG9_OFFSET
#define reg_write_input  XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG10_OFFSET
#define reg_weight_addr  XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG11_OFFSET
#define reg_write_weight XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG12_OFFSET
#define reg_output_addr  XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG13_OFFSET

// output reg
#define reg_ack          XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG255_OFFSET
#define reg_read_output  XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG254_OFFSET
#define reg_probe_in     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG253_OFFSET
#define reg_probe_w0     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG252_OFFSET
#define reg_probe_w1     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG251_OFFSET
#define reg_probe_w2     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG250_OFFSET
#define reg_probe_w3     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG249_OFFSET
#define reg_probe_w4     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG248_OFFSET
#define reg_probe_w5     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG247_OFFSET
#define reg_probe_w6     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG246_OFFSET
#define reg_probe_w7     XPAR_COPRO_0_S_AXI_BASEADDR + COPRO_s_axi_SLV_REG245_OFFSET

void post_input(s16 *input, const u16 total_in, const u16 img_size);
void post_weight(s16 *weight,
    const u16 total_out, const u16 total_in, const u16 fil_size);
void post_parameter(const u16 total_out, const u16 total_in,
    const u16 img_size, const u16 fil_size, const u16 pool_size);
void post_data(s16 *input, s16 *weight,
    const u16 total_out, const u16 total_in,
    const u16 img_size, const u16 fil_size, const u16 pool_size);
void exec_core(void);
void get_data(s16 *output, const u16 total_out, const u16 img_size);
void post_process(s16 *pmap, s16 *bias,
    const u16 total_out, const u16 img_size);
void test_platform(void);

#endif
