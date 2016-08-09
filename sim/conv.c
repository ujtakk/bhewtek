#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define LEN 25
#define N_INPUT 10000

int conv (int x[LEN], int w[LEN])
{
  int sum = 0;
  int pro = 0;

  for (int i=0; i<LEN; i++) {
    pro = x[i] * w[i];
    if (pro >= 0)
      sum += pro / (int)pow(2,8);
    else
      sum += pro / (int)pow(2,8) - 1;
  }

  return sum;
}

int main (void)
{
  FILE *fp, *gp;
  int x[LEN], w[LEN];
  char file_x[256], file_w[256];
  char file_out[256] = "output_true.dat";

  if ((gp = fopen(file_out, "w")) == NULL) {
    fprintf(stderr, "failed to open '%s'\n", file_out);
    exit(EXIT_FAILURE);
  }

  for (int n = 1; n <= N_INPUT; n++) {
    sprintf(file_x, "input/input_x_%d.dat", n);
    if ((fp = fopen(file_x, "r")) == NULL) {
      fprintf(stderr, "failed to open '%s'\n", file_x);
      exit(EXIT_FAILURE);
    }
    for (int i = 0; i < LEN; i++) fscanf(fp, "%d", &x[i]);
    fclose(fp);

    sprintf(file_w, "input/input_w_%d.dat", n);
    if ((fp = fopen(file_w, "r")) == NULL) {
      fprintf(stderr, "failed to open '%s'\n", file_w);
      exit(EXIT_FAILURE);
    }
    for (int i = 0; i < LEN; i++) fscanf(fp, "%d", &w[i]);
    fclose(fp);

    int sum = conv(x, w);

    fprintf(gp, "%5d\n", sum);
  }
  fclose(gp);

  return 0;
}
