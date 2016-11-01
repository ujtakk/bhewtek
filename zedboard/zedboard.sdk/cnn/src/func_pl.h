/*
 * This source declares functions to work on PL
 */

#ifndef __FUNC_PL_H_
#define __FUNC_PL_H_

#include "xil_types.h"
#include "xparameters.h"
#include "copro.h"

// reg macro
#define REG_BASE          XPAR_COPRO_0_S_AXI_BASEADDR
#define REG_COPRO(num)    REG_BASE + COPRO_s_axi_SLV_REG##num##_OFFSET

// input reg
#define reg_req           REG_COPRO(0)
#define reg_total_out     REG_COPRO(1)
#define reg_total_in      REG_COPRO(2)
#define reg_img_size      REG_COPRO(3)
#define reg_fil_size      REG_COPRO(4)
#define reg_pool_size     REG_COPRO(5)
#define reg_input_we      REG_COPRO(6)
#define reg_input_addr    REG_COPRO(7)
#define reg_write_input   REG_COPRO(8)
#define reg_weight_we     REG_COPRO(9)
#define reg_weight_addr   REG_COPRO(10)
#define reg_write_weight  REG_COPRO(11)
#define reg_bias_we       REG_COPRO(12)
#define reg_bias_addr     REG_COPRO(13)
#define reg_write_bias    REG_COPRO(14)
#define reg_output_re     REG_COPRO(15)
#define reg_output_addr   REG_COPRO(16)

// output reg
#define reg_ack           REG_COPRO(255)
#define reg_read_output   REG_COPRO(254)
#define reg_probe_in      REG_COPRO(253)
#define reg_probe_w0      REG_COPRO(252)
#define reg_probe_w1      REG_COPRO(251)
#define reg_probe_w2      REG_COPRO(250)
#define reg_probe_w3      REG_COPRO(249)
#define reg_probe_w4      REG_COPRO(248)
#define reg_probe_w5      REG_COPRO(247)
#define reg_probe_w6      REG_COPRO(246)
#define reg_probe_w7      REG_COPRO(245)

void post_input(s16 *input, const u16 total_in, const u16 img_size);
void post_weight(s16 *weight,
    const u16 total_out, const u16 total_in, const u16 fil_size);
void assign_weight(s16 *weight, const u16 offset,
    const u16 total_out, const u16 total_in, const u16 fil_size);
void assign_bias(s16 *bias, const u16 offset, const u16 total_out);
void post_parameter(const u16 total_out, const u16 total_in,
    const u16 img_size, const u16 fil_size, const u16 pool_size);
void post_data(s16 *input, s16 *weight,
    const u16 total_out, const u16 total_in,
    const u16 img_size, const u16 fil_size, const u16 pool_size);
void assign_data(s16 *input, const u16 weight_addr,
    const u16 total_out, const u16 total_in,
    const u16 img_size, const u16 fil_size, const u16 pool_size);
void exec_core(void);
void get_data(s16 *output, const u16 total_out, const u16 img_size);
void post_process(s16 *pmap, s16 *bias,
    const u16 total_out, const u16 img_size);
void test_platform(void);

#endif
