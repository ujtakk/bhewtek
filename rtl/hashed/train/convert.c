#include <stdio.h>
#include <stdlib.h>
#include <math.h>

const char *filepath = "lh_t";



void q88_bin(FILE *fp, double x)
{
  int ix = (int)round(x * pow(2, 8));
  if(ix >= 0)
    for(int b = 0; b < 16; b++)
      fprintf(fp, "%d", (ix >> (15-b)) % 2);
  else
    for(int b = 0; b < 16; b++)
      fprintf(fp, "%d", (((-ix ^ 0xFFFF)+1) >> (15-b)) % 2);
  fprintf(fp, "\n");
}



void q88_dec(FILE *fp, double x)
{
  int num = (int)round(x * pow(2, 8));
  fprintf(fp, "%d\n", num);
}



void make_1d(int index, int out_channels)
{
  char cmd[256], filename[256];
  FILE *in_float, *out_dec, *out_bin;
  double dnum = 0.0;

  sprintf(cmd, "mkdir -p %s/iwb_%d", filepath, index);
  system(cmd);

  sprintf(cmd, "mkdir -p %s/bwb_%d", filepath, index);
  system(cmd);

  for (int i = 0; i < out_channels; i++) {
    sprintf(filename, "%s/wb_%d/data%d.txt", filepath, index, i);
    in_float = fopen(filename, "r");

    sprintf(filename, "%s/iwb_%d/data%d.dat", filepath, index, i);
    out_dec = fopen(filename, "w");

    sprintf(filename, "%s/bwb_%d/data%d.bin", filepath, index, i);
    out_bin = fopen(filename, "w");

    while (fscanf(in_float, "%lf\n", &dnum) != EOF) {
      q88_dec(out_dec, dnum);
      q88_bin(out_bin, dnum);
    }

    fclose(in_float);
    fclose(out_dec);
    fclose(out_bin);
  }
}



void make_2d(int index, int in_channels, int out_channels)
{
  char cmd[256], filename[256];
  FILE *in_float, *out_dec, *out_bin;
  double dnum = 0.0;

  sprintf(cmd, "mkdir -p %s/iwb_%d", filepath, index);
  system(cmd);

  sprintf(cmd, "mkdir -p %s/bwb_%d", filepath, index);
  system(cmd);

  for (int i = 0; i < out_channels; i++) {
    for (int j = 0; j < in_channels; j++) {
      sprintf(filename, "%s/wb_%d/data%d_%d.txt", filepath, index, i, j);
      in_float = fopen(filename, "r");

      sprintf(filename, "%s/iwb_%d/data%d_%d.dat", filepath, index, i, j);
      out_dec = fopen(filename, "w");

      sprintf(filename, "%s/bwb_%d/data%d_%d.bin", filepath, index, i, j);
      out_bin = fopen(filename, "w");

      while (fscanf(in_float, "%lf\n", &dnum) != EOF) {
        q88_dec(out_dec, dnum);
        q88_bin(out_bin, dnum);
      }

      fclose(in_float);
      fclose(out_dec);
      fclose(out_bin);
    }

    sprintf(filename, "%s/wb_%d/data%d.txt", filepath, index, i);
    in_float = fopen(filename, "r");

    sprintf(filename, "%s/iwb_%d/data%d.dat", filepath, index, i);
    out_dec = fopen(filename, "w");

    sprintf(filename, "%s/bwb_%d/data%d.bin", filepath, index, i);
    out_bin = fopen(filename, "w");

    while (fscanf(in_float, "%lf\n", &dnum) != EOF) {
      q88_dec(out_dec, dnum);
      q88_bin(out_bin, dnum);
    }

    fclose(in_float);
    fclose(out_dec);
    fclose(out_bin);
  }
}



int main(void)
{
  make_1d(1, 20);
  make_2d(2, 20, 50);
  make_1d(3, 500);
  make_1d(4, 10);

  return 0;
}
