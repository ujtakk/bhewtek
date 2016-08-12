#include "func_pl.h"
#include "xil_io.h"
#include "cnn.h"
#include "func_ps.h"





void post_input (s16 *input, int total_in, int img_size)
{
  int i;
  const int in_size  = total_in * img_size * img_size;

  for (i=0; i<in_size; i++) {
    Xil_Out32(reg_input_addr, i);
    Xil_Out32(reg_write_input, input[i]);
    Xil_Out32(reg_input_we, 0x1);
    Xil_Out32(reg_input_we, 0x0);
  }
  Xil_Out32(reg_input_addr, 0x0);
  Xil_Out32(reg_write_input, 0x0);
}





void post_weight (s16 *weight, int total_out, int total_in, int fil_size)
{
  int i;
  int w_mem_addr, core_num;
  const int w_unit   = total_in * fil_size * fil_size;
  const int w_size   = total_out * w_unit;

  for (i=0; i<w_size; i++) {
    if (i % w_unit == 0)
      core_num = (i / w_unit) % CORE + 1;
    w_mem_addr = (i / (w_unit * CORE)) * w_unit + i % w_unit;
    Xil_Out32(reg_weight_addr, w_mem_addr);
    Xil_Out32(reg_write_weight, weight[i]);
    Xil_Out32(reg_weight_we, core_num);
    Xil_Out32(reg_weight_we, 0x0);
  }
  Xil_Out32(reg_weight_addr, 0x0);
  Xil_Out32(reg_write_weight, 0x0);
}





void post_parameter (int total_out, int total_in, int img_size, int fil_size)
{
  Xil_Out32(reg_total_out, total_out);
  Xil_Out32(reg_total_in, total_in);
  Xil_Out32(reg_img_size, img_size);
  Xil_Out32(reg_fil_size, fil_size);
}





void post_data (s16 *input, s16 *weight,
    int total_out, int total_in, int img_size, int fil_size)
{
  post_input(input, total_in, img_size);
  post_weight(weight, total_out, total_in, fil_size);
  post_parameter(total_out, total_in, img_size, fil_size);
}





void exec_core (void)
{
  Xil_Out32(reg_req, 0x1);
  Xil_Out32(reg_req, 0x0);
  // Blocking till PL finishing the operation
  do {} while (!Xil_In32(reg_ack));
}





void get_data(s16 *output, int total_out, int img_size)
{
  //TODO: split the address of each core.
  const int o_unit = img_size * img_size;
  const int o_size = total_out * o_unit;

  int i;
  int o_offset, o_index;
  int o_mem_addr;
  int core_num, data;

  for (i = 0; i < o_size; i++) {
    o_offset = i % o_unit;
    o_index  = i / o_unit;
    if (o_offset == 0)
      core_num = o_index % CORE + 1;
    o_mem_addr = o_offset + o_unit * (o_index / CORE);

    Xil_Out32(reg_output_addr, o_mem_addr);
    Xil_Out32(reg_output_re, core_num);
    data = Xil_In32(reg_read_output);
    Xil_Out32(reg_output_re, 0x0);

    output[i] = data;
  }
  Xil_Out32(reg_output_addr, 0x0);
}





// TODO: insert this process to pl
void post_process (s16 *pmap, s16 *bias, int total_out, int img_size)
{
  int i, j;
  int img_area = img_size * img_size;

  for (i = 0; i < total_out; i++)
    for (j = 0; j < img_area; j++)
      pmap[img_area*i+j] = pmap[img_area*i+j] + bias[i];

  activate_1d(pmap, total_out*img_size*img_size);
}





// TODO: Observe How values are influenced
//        by reading and writing on interface registers.
void test_platform (void)
{
  //AAAASD_Reg_SelfTest((int *)XPAR_AAAASD_0_S_AXI_BASEADDR);

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





