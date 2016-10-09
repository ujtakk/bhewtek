#define ENABLE_COPRO
#define ASSIGN

#include "cnn.h"

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

// #include "data/pmap1_flat.h"
// #include "data/pmap1_flat_true.h"
// #include "data/pmap2_flat_true.h"
#include "data/input.h"
#include "data/input_flat.h"
#include "data/w_conv1.h"
#include "data/w_conv1_flat.h"
#include "data/b_conv1.h"
#include "data/w_conv2.h"
#include "data/w_conv2_flat.h"
#include "data/b_conv2.h"
#include "data/w_hidden.h"
#include "data/b_hidden.h"
#include "data/w_output.h"
#include "data/b_output.h"

// latency analysis
#include "xtime_l.h"
#define INIT  XTime begin, end;
#define BEGIN XTime_GetTime(&begin);
#define END   XTime_GetTime(&end);        \
  printf("%10.6f [ms]\n\n", \
      (double)(end-begin) / COUNTS_PER_SECOND * 1000);

int main(void)
{
  INIT

  // TODO: load data from the SD card using Linux
  //        => (standalone may be enough)

#ifdef ENABLE_COPRO
  s16 pmap1_flat[N_F1*PM1HEI*PM1WID];
  s16 pmap2_flat[N_F2*PM2HEI*PM2WID];
#else
  s16 fmap1[N_F1][FM1HEI][FM1WID];
  s16 pmap1[N_F1][PM1HEI][PM1WID];
  s16 fmap2[N_F2][FM2HEI][FM2WID];
  s16 pmap2[N_F2][PM2HEI][PM2WID];
  s16 pmap2_flat[N_F2*PM2HEI*PM2WID];
#endif

  s16 hidden[N_HL];
  s16 output[LABEL];

  init_platform();

  // Clear the screen
  // for (int i = 0; i < 100; i++) xil_printf("\r\n");
  xil_printf("BEGIN\n\r");

#ifdef ENABLE_COPRO
#ifdef ASSIGN
  assign_weight(w_conv1_flat, 0, N_F1, 1, FHEI);
  assign_weight(w_conv2_flat, 75, N_F2, N_F1, FHEI);

  // printf("assign_data(input_flat);\n");
  // BEGIN
  assign_data(input_flat, 0, N_F1, 1, IMHEI, FHEI, PHEI);
  // END
  // printf("exec_core()\n");
  // BEGIN
  exec_core();
  // END
  // printf("get_data(pmap1_flat)\n");
  // BEGIN
  get_data(pmap1_flat, N_F1, PM1HEI);
  // END
  // printf("post_process(pmap1_flat, b_conv1)\n");
  // BEGIN
  post_process(pmap1_flat, b_conv1, N_F1, PM1HEI);
  // END

  // printf("assign_data(pmap1_flat);\n");
  // BEGIN
  assign_data(pmap1_flat, 75, N_F2, N_F1, PM1HEI, FHEI, PHEI);
  // END
  // printf("exec_core()\n");
  // BEGIN
  exec_core();
  // END
  // printf("get_data(pmap2_flat)\n");
  // BEGIN
  get_data(pmap2_flat, N_F2, PM2HEI);
  // END
  // printf("post_process(pmap2_flat, b_conv2)\n");
  // BEGIN
  post_process(pmap2_flat, b_conv2, N_F2, PM2HEI);
  // END
#else
  // First Layer
  printf("post_data(input_flat, w_conv1_flat)\n");
  BEGIN
  post_data(input_flat, w_conv1_flat, N_F1, 1, IMHEI, FHEI, PHEI);
  END
  printf("exec_core()\n");
  BEGIN
  exec_core();
  END
  printf("get_data(pmap1_flat)\n");
  BEGIN
  get_data(pmap1_flat, N_F1, PM1HEI);
  END
  printf("post_process(pmap1_flat, b_conv1)\n");
  BEGIN
  post_process(pmap1_flat, b_conv1, N_F1, PM1HEI);
  END

  // Second Layer
  printf("post_data(pmap1_flat, w_conv2_flat)\n");
  BEGIN
  post_data(pmap1_flat, w_conv2_flat, N_F2, N_F1, PM1HEI, FHEI, PHEI);
  END
  printf("exec_core()\n");
  BEGIN
  exec_core();
  END
  printf("get_data(pmap2_flat)\n");
  BEGIN
  get_data(pmap2_flat, N_F2, PM2HEI);
  END
  printf("post_process(pmap2_flat, b_conv2)\n");
  BEGIN
  post_process(pmap2_flat, b_conv2, N_F2, PM2HEI);
  END
#endif
#else
  /*
   * For simplication of impl and retainment of performance,
   * we use multi-dimentional fixed-length array.
   * (Therefore iterations are not functionalized.)
   */
  /* layer1 */
  printf("conv(input, w_conv1, fmap1)\n");
  printf("max_pooling(fmap1, pmap1)\n");
  printf("add_bias(pmap1, b_conv1)\n");
  printf("activate(pmap1)\n");
  BEGIN
  for (int i = 0; i < N_F1; i++) {
    // printf("conv(input, w_conv1[i], fmap1[i])\n");
    for (int j = 0; j < 1; j++) {
      for (int k = 0; k < FM1HEI; k++) {
        for (int l = 0; l < FM1WID; l++) {
          s16 sum = 0;
          for (int m = 0; m < FHEI; m++)
            for (int n = 0; n < FWID; n++)
              sum += mul(input[j][k+m][l+n], w_conv1[i][j][m][n]);
          if (j == 0)
            fmap1[i][k][l] = sum;
          else
            fmap1[i][k][l] += sum;
        }
      }
    }
    // printf("max_pooling(fmap1[i], pmap1[i])\n");
    for (int k = 0; k < FM1HEI; k += PHEI) {
      for (int l = 0; l < FM1WID; l += PWID) {
        int max = INT_MIN;
        for (int m = 0;  m < PHEI; m++)
          for (int n = 0; n < PWID; n++)
            if (fmap1[i][k+m][l+n] > max)
              max = fmap1[i][k+m][l+n];
        pmap1[i][k/PHEI][l/PWID] = max;
      }
    }
    // printf("add_bias(pmap1[i], b_conv1[i])\n");
    for (int k = 0; k < PM1HEI; k++)
      for (int l = 0; l < PM1WID; l++)
        pmap1[i][k][l] += b_conv1[i];
    // printf("activate(pmap1[i])\n");
    for (int k = 0; k < PM1HEI; k++)
      for (int l = 0; l < PM1WID; l++)
        if (pmap1[i][k][l] < 0)
          pmap1[i][k][l] = 0;
  }
  END

  /* layer2 */
  printf("conv(pmap1, w_conv2, fmap2)\n");
  printf("max_pooling(fmap2, pmap2)\n");
  printf("add_bias(pmap2, b_conv2)\n");
  printf("activate(pmap2)\n");
  BEGIN
  for (int i = 0; i < N_F2; i++) {
    // printf("conv(pmap1, w_conv2[i], fmap2[i])\n");
    for (int j = 0; j < N_F1; j++) {
      for (int k = 0; k < FM2HEI; k++) {
        for (int l = 0; l < FM2WID; l++) {
          s32 sum = 0;
          for (int m = 0; m < FHEI; m++)
            for (int n = 0; n < FWID; n++)
              sum += mul(pmap1[j][k+m][l+n], w_conv2[i][j][m][n]);
          if (j == 0)
            fmap2[i][k][l] = sum;
          else
            fmap2[i][k][l] += sum;
        }
      }
    }
    // printf("max_pooling(fmap2[i], pmap2[i])\n");
    for (int k = 0; k < FM2HEI; k += PHEI) {
      for (int l = 0; l < FM2WID; l += PWID) {
        int max = INT_MIN;
        for (int m = 0;  m < PHEI; m++)
          for (int n = 0; n < PWID; n++)
            if (fmap2[i][k+m][l+n] > max)
              max = fmap2[i][k+m][l+n];
        pmap2[i][k/PHEI][l/PWID] = max;
      }
    }
    // printf("add_bias(pmap2[i], b_conv2[i])\n");
    for (int k = 0; k < PM2HEI; k++)
      for (int l = 0; l < PM2WID; l++)
        pmap2[i][k][l] += b_conv2[i];
    // printf("activate(pmap2[i])\n");
    for (int k = 0; k < PM2HEI; k++)
      for (int l = 0; l < PM2WID; l++)
        if (pmap2[i][k][l] < 0)
          pmap2[i][k][l] = 0;
  }
  END

  printf("flatten(pmap2, pmap2_flat)\n");
  BEGIN
  for (int i = 0; i < N_F2; i++)
    for (int j = 0; j < PM2HEI; j++)
      for (int k = 0;  k < PM2WID; k++)
        pmap2_flat[i*PM2HEI*PM2WID+j*PM2WID+k] = pmap2[i][j][k];
  END
#endif
  /************************************************************
   * calculate fully connected layers on CPU
   * because these layers has tendency to be data intensive.
   ************************************************************/
  // printf("full_connect(pmap2_flat, hidden)\n");
  // BEGIN
  full_connect(pmap2_flat, hidden,
                w_hidden, b_hidden, PM2HEI*PM2WID*N_F2, N_HL);
  // END

  // printf("activate_1d(hidden)\n");
  // BEGIN
  activate_1d(hidden, N_HL);
  // END

  // printf("full_connect(hidden, output)\n");
  // BEGIN
  full_connect(hidden, output,
                w_output, b_output, N_HL, LABEL);
  // END
  xil_printf("END\n\r");

  print_result(output);

  cleanup_platform();

  return 0;
}
