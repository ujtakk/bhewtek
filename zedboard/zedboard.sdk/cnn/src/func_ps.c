/*
 * TODO: We use stupid loading method (array initialization for specific data)
 *     for temporal working.
 * TODO: Therefore, high dimentional load functions are not implemented.
 */
#include "func_ps.h"
#include <math.h>
#include "xil_types.h"





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
  for (i=0; i<olen; i++) {
    for (j=0; j<ilen; j++) {
      pro = input[j] * weight[base+j] / (int)pow(2,8);
      sum += (s16)pro;
    }

    output[i] = sum + bias[i];
    sum = 0;
    base += ilen;
  }
}





void activate_1d(s16 *input,const int ilen)
{
  int i;
  for (i=0; i<ilen ;i++)
    if (input[i] < 0)
      input[i] = 0;
}





int softmax(double *output,int len)
{
  int i;
  double expsum=0.0;

  for (i=0; i<len; i++)
    expsum += exp(output[i]);

  if (expsum == 0)
    return 1;
  else
    for (i=0; i<len; i++)
      output[i] = exp(output[i]) / expsum;

  return 0;
}





