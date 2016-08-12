#include "show.h"
#include <limits.h>
#include "xil_io.h"
#include "xil_printf.h"
#include "cnn.h"
#include "func_pl.h"





void probe_in (s16 *input_true, int total_in, int img_size)
{
  int i;
  const int in_size = total_in * img_size * img_size;
  int tmp;
  for (i=0; i<in_size; i++) {
    Xil_Out32(reg_input_addr, i);
    tmp = Xil_In32(reg_probe_in);
    if (tmp != input_true[i])
      xil_printf("fail_in: %d\t%d\t%d\n\r", i, tmp, input_true[i]);
  }
  Xil_Out32(reg_input_addr, 0x0);
  xil_printf("probe_in done\n\r");
}





void probe_w (s16 *weight_true, int total_out, int total_in, int fil_size)
{
  int i;
  int w_mem_addr, core_num;
  const int w_unit = total_in * fil_size * fil_size;
  const int w_size = total_out * w_unit;
  int tmp;

  for (i=0; i<w_size; i++) {
    if (i % w_unit == 0)
      core_num = (i / w_unit) % CORE + 1;
    w_mem_addr = (i / (w_unit * CORE)) * w_unit + i % w_unit;

    Xil_Out32(reg_weight_addr, w_mem_addr);

    switch (core_num) {
      case 1: tmp = Xil_In32(reg_probe_w0); break;
      case 2: tmp = Xil_In32(reg_probe_w1); break;
      case 3: tmp = Xil_In32(reg_probe_w2); break;
      case 4: tmp = Xil_In32(reg_probe_w3); break;
      case 5: tmp = Xil_In32(reg_probe_w4); break;
      case 6: tmp = Xil_In32(reg_probe_w5); break;
      case 7: tmp = Xil_In32(reg_probe_w6); break;
      case 8: tmp = Xil_In32(reg_probe_w7); break;
      default: tmp = 0; break;
    }

    if (tmp != weight_true[i])
      xil_printf("fail_w: %d\t%d\t%d\n\r", i, tmp, weight_true[i]);
  }
  Xil_Out32(reg_weight_addr, 0x0);
  xil_printf("probe_w done\n\r");
}





void print_port (void)
{
  int port[256];

  port[0]  = Xil_In32(reg_req);
  port[1]  = Xil_In32(reg_output_re);
  port[2]  = Xil_In32(reg_weight_we);
  port[3]  = Xil_In32(reg_input_we);
  port[4]  = Xil_In32(reg_total_out);
  port[5]  = Xil_In32(reg_total_in);
  port[6]  = Xil_In32(reg_img_size);
  port[7]  = Xil_In32(reg_fil_size);
  port[8]  = Xil_In32(reg_input_addr);
  port[9]  = Xil_In32(reg_write_input);
  port[10] = Xil_In32(reg_weight_addr);
  port[11] = Xil_In32(reg_write_weight);
  port[12] = Xil_In32(reg_output_addr);

  port[255] = Xil_In32(reg_ack);
  port[254] = Xil_In32(reg_read_output);
  port[253] = Xil_In32(reg_probe_in);

  xil_printf("%x : %x : %x : %x : %x : %x : %x : %x : %x : %x : %x : %x : %x @@ %x : %x : %x\n\r",
      port[0], port[1], port[2], port[3], port[4], port[5], port[6], port[7], port[8], port[9], port[10], port[11], port[12], port[255], port[254], port[253]);
}





void print_result(s16 *output)
{
  int i;
  int number = -1;
  int temp = INT_MIN;

  for (i=0; i<LABEL; i++) {
    xil_printf("%d\n\r",output[i]);

    if (temp < output[i]) {
      temp = output[i];
      number = i;
    }
  }

  xil_printf("the answer is %d.\n\r", number);
}





