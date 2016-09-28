#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <unistd.h>
#include "platform.h"
#include "xil_printf.h"

#include "cnn.h"
#include "func_ps.h"
#include "func_pl.h"
#include "show.h"
#include "misc.h"

#include "data/input_flat.h"
// #include "data/pmap1_flat.h"
// #include "data/pmap1_flat_true.h"
// #include "data/pmap2_flat_true.h"

#include "data/w_conv1_flat.h"
#include "data/b_conv1.h"
#include "data/w_conv2_flat.h"
#include "data/b_conv2.h"
#include "data/w_hidden.h"
#include "data/b_hidden.h"
#include "data/w_output.h"
#include "data/b_output.h"

int main(void)
{
  // s16 pmap1[N_F1][PM1HEI][PM1WID];
  // s16 pmap2[N_F2][PM2HEI][PM2WID];
  // s16 w_conv2[N_F2][N_F1][FHEI][FWID];
  s16 pmap1_flat[N_F1*PM1HEI*PM1WID] = {};
  s16 pmap2_flat[N_F2*PM2HEI*PM2WID] = {};
  s16 hidden[N_HL];
  s16 output[LABEL];

  // These arrays are defined as global variables.
  /*
   * s16 input_flat[IMHEI*IMWID];
   * s16 pmap1_flat[N_F1*PM1HEI*PM1WID];
   * s16 w_conv1_flat[N_F1*1*FHEI*FWID];
   * s16 b_conv1[N_F1]
   * s16 w_conv2_flat[N_F2*N_F1*FHEI*FWID];
   * s16 b_conv2[N_F2]
   * s16 w_hidden[N_HL][PM2HEI*PM2WID*N_F2];
   * s16 b_hidden[N_HL];
   * s16 w_output[LABEL][N_HL];
   * s16 b_output[LABEL];
   */

  // Clear the screen
  for (int i=0; i<100; i++) xil_printf("\n\r");

  init_platform();

  // TODO: load data from the SD card using Linux
  /*
   * load_images_flat(pmap1_flat, N_F1, PM1HEI, PM1WID);

   * load_weight_flat(w_conv2_flat, N_F2, N_F1, FHEI, FWID);
   * load_bias(b_conv2, N_F2);
   * load_weight(w_hidden, N_HL, PM2HEI*PM2WID*N_F2);
   * load_bias(b_hidden, N_HL);
   * load_weight(w_output, LABEL, N_HL);
   * load_bias(b_hidden, LABEL);
   */

  // First Layer
  post_data(input_flat, w_conv1_flat, N_F1, 1, IMHEI, FHEI, PHEI);
  exec_core();
  get_data(pmap1_flat, N_F1, PM1HEI);
  post_process(pmap1_flat, b_conv1, N_F1, PM1HEI);

  // Second Layer
  post_data(pmap1_flat, w_conv2_flat, N_F2, N_F1, PM1HEI, FHEI, PHEI);
  exec_core();
  get_data(pmap2_flat, N_F2, PM2HEI);
  post_process(pmap2_flat, b_conv2, N_F2, PM2HEI);

  /************************************************************
   * calculate fully connected layers on CPU
   * because these layers has tendency to be data intensive.
   ************************************************************/
  full_connect(pmap2_flat, hidden,
                w_hidden, b_hidden, PM2HEI*PM2WID*N_F2, N_HL);
  activate_1d(hidden, N_HL);

  full_connect(hidden, output,
                w_output, b_output, N_HL, LABEL);

  print_result(output);

  cleanup_platform();

  return 0;
}
