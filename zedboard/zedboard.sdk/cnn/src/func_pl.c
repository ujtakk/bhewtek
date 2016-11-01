#include <unistd.h>
#include "xil_io.h"

#include "cnn.h"
#include "func_ps.h"
#include "func_pl.h"
#include "show.h"

#include "xtime_l.h"
#define INIT XTime begin, end;
#define BEGIN XTime_GetTime(&begin);
#define END   XTime_GetTime(&end); printf("\t%10.6f [ms]\n\n", (double)(end-begin) / COUNTS_PER_SECOND * 1000);





void post_input(s16 *input, const u16 total_in, const u16 img_size)
{
  const u16 in_size  = total_in * img_size * img_size;

  Xil_Out32(reg_input_we, 0x1);
  for (u16 i = 0; i < in_size; i++) {
    // Order "addr -> write_input" is important.
    Xil_Out32(reg_input_addr,  i);
    Xil_Out32(reg_write_input, input[i]);
  }
  Xil_Out32(reg_input_we, 0x0);
  Xil_Out32(reg_input_addr, 0x0);
  Xil_Out32(reg_write_input, 0x0);
}





void post_weight(s16 *weight,
    const u16 total_out, const u16 total_in, const u16 fil_size)
{
  u16 w_offset      = 0;
  u16 w_index       = 0;
  u16 w_mem_addr    = 0;
  u16 core_num      = 0;
  const u16 w_unit  = total_in * fil_size * fil_size;
  const u16 w_size  = total_out * w_unit;

  for (u16 i = 0; i < w_size; i++) {
    w_offset = i % w_unit;
    w_index  = i / w_unit;
    if (w_offset == 0)
      // Xil_Out32(reg_weight_we, w_index % CORE + 1);
      core_num = w_index % CORE + 1;
    w_mem_addr = w_offset + w_unit * (w_index / CORE);
    Xil_Out32(reg_weight_addr,  w_mem_addr);
    Xil_Out32(reg_write_weight, weight[i]);
    Xil_Out32(reg_weight_we,    core_num);
    Xil_Out32(reg_weight_we,    0x0);
  }
  // Xil_Out32(reg_weight_we,    0x0);
  Xil_Out32(reg_weight_addr,  0x0);
  Xil_Out32(reg_write_weight, 0x0);
}





void assign_weight(s16 *weight, const u16 offset,
    const u16 total_out, const u16 total_in, const u16 fil_size)
{
  u16 w_offset      = 0;
  u16 w_index       = 0;
  u16 w_mem_addr    = 0;
  u16 core_num      = 0;
  const u16 w_unit  = total_in * fil_size * fil_size;
  const u16 w_size  = total_out * w_unit;

  for (u16 i = 0; i < w_size; i++) {
    w_offset = i % w_unit;
    w_index  = i / w_unit;
    if (w_offset == 0)
      // Xil_Out32(reg_weight_we, w_index % CORE + 1);
      core_num = w_index % CORE + 1;
    w_mem_addr = offset + w_offset + w_unit * (w_index / CORE);
    Xil_Out32(reg_weight_addr,  w_mem_addr);
    Xil_Out32(reg_write_weight, weight[i]);
    Xil_Out32(reg_weight_we,    core_num);
    Xil_Out32(reg_weight_we,    0x0);
  }
  // Xil_Out32(reg_weight_we,    0x0);
  Xil_Out32(reg_weight_addr,  0x0);
  Xil_Out32(reg_write_weight, 0x0);
}





void assign_bias(s16 *bias, const u16 offset, const u16 total_out)
{
  u16 b_mem_addr    = 0;
  u16 core_num      = 0;

  for (u16 i = 0; i < total_out; i++) {
    // Xil_Out32(reg_bias_we, i % CORE + 1);
    core_num = i % CORE + 1;
    b_mem_addr = offset + i / CORE;
    Xil_Out32(reg_bias_addr,  b_mem_addr);
    Xil_Out32(reg_write_bias, bias[i]);
    Xil_Out32(reg_bias_we,    core_num);
    Xil_Out32(reg_bias_we,    0x0);
  }
  // Xil_Out32(reg_bias_we,    0x0);
  Xil_Out32(reg_bias_addr,  0x0);
  Xil_Out32(reg_write_bias, 0x0);
}





void post_parameter(const u16 total_out, const u16 total_in,
    const u16 img_size, const u16 fil_size, const u16 pool_size)
{
  Xil_Out32(reg_total_out,  total_out);
  Xil_Out32(reg_total_in,   total_in);
  Xil_Out32(reg_img_size,   img_size);
  Xil_Out32(reg_fil_size,   fil_size);
  Xil_Out32(reg_pool_size,  pool_size);
}





void post_data(s16 *input, s16 *weight,
    const u16 total_out, const u16 total_in,
    const u16 img_size, const u16 fil_size, const u16 pool_size)
{
  // printf("\tpost_input()\n");
  post_input(input, total_in, img_size);
  // printf("\tpost_weight()\n");
  post_weight(weight, total_out, total_in, fil_size);
  // printf("\tpost_parameter()\n");
  post_parameter(total_out, total_in, img_size, fil_size, pool_size);
}





void assign_data(s16 *input, const u16 weight_addr,
    const u16 total_out, const u16 total_in,
    const u16 img_size, const u16 fil_size, const u16 pool_size)
{
  // printf("\tpost_input()\n");
  post_input(input, total_in, img_size);
  // printf("\tpost_weight()\n");
  Xil_Out32(reg_weight_addr,  weight_addr);
  // printf("\tpost_parameter()\n");
  post_parameter(total_out, total_in, img_size, fil_size, pool_size);
}





void exec_core(void)
{
  Xil_Out32(reg_req, 0x1);
  Xil_Out32(reg_req, 0x0);
  // Blocking till PL finishing the operation
  do {
    // Nop
  } while (!Xil_In32(reg_ack));
}





void get_data(s16 *output, const u16 total_out, const u16 img_size)
{
  u16 o_offset    = 0;
  u16 o_index     = 0;
  u16 o_mem_addr  = 0;
  u16 core_num    = 0;

  //TODO: split the address of each core.
  const u16 o_unit = img_size * img_size;
  const u16 o_size = total_out * o_unit;

  for (u16 i = 0; i < o_size; i++) {
    o_offset = i % o_unit;
    o_index  = i / o_unit;
    if (o_offset == 0)
      core_num = o_index % CORE + 1;
    o_mem_addr = o_offset + o_unit * (o_index / CORE);
    Xil_Out32(reg_output_addr,  o_mem_addr);
    Xil_Out32(reg_output_re,    core_num);
    output[i] = Xil_In32(reg_read_output);
    Xil_Out32(reg_output_re, 0x0);
  }
  Xil_Out32(reg_output_addr, 0x0);
}





// TODO: insert this process to pl
void post_process(s16 *pmap, s16 *bias, const u16 total_out, const u16 img_size)
{
  const u16 img_area = img_size * img_size;

  for (int i = 0; i < total_out; i++)
    for (int j = 0; j < img_area; j++)
      pmap[img_area*i+j] = pmap[img_area*i+j] + bias[i];

  activate_1d(pmap, total_out*img_size*img_size);
}





void test_platform(void)
{
  COPRO_Reg_SelfTest((int *)XPAR_COPRO_0_S_AXI_BASEADDR);

  Xil_Out32(reg_req         , 0);
  Xil_Out32(reg_output_re   , 0);
  Xil_Out32(reg_weight_we   , 0);
  Xil_Out32(reg_input_we    , 0);
  Xil_Out32(reg_total_out   , 0);
  Xil_Out32(reg_total_in    , 0);
  Xil_Out32(reg_img_size    , 0);
  Xil_Out32(reg_fil_size    , 0);
  Xil_Out32(reg_input_addr  , 0);
  Xil_Out32(reg_write_input , 0);
  Xil_Out32(reg_weight_addr , 0);
  Xil_Out32(reg_write_weight, 0);
  Xil_Out32(reg_output_addr , 0);
  Xil_Out32(reg_ack         , 0);
  Xil_Out32(reg_read_output , 0);
  Xil_Out32(reg_probe_in    , 0);
}





