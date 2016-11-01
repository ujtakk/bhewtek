#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>
#include <unistd.h>
#include <assert.h>

bool hash_mode = false;
char *filepath;

void q88_bin(FILE *fp, double x)
{
  int num = round(x * pow(2, 8));

  if(num >= 0)
    for(int b = 0; b < 16; b++)
      fprintf(fp, "%d", (num >> (15-b)) % 2);
  else
    for(int b = 0; b < 16; b++)
      fprintf(fp, "%d", (((-num ^ 0xFFFF)+1) >> (15-b)) % 2);
  fprintf(fp, "\n");
}

void q88_dec(FILE *fp, double x)
{
  int num = round(x * pow(2, 8));
  fprintf(fp, "%d\n", num);
}

void join_xi_idx(FILE *fp, int xi, int idx, int fsize)
{
  assert(xi == 1 || xi == -1);

  int bwidth = (int)ceil(log(fsize)/log(2));

  if (xi == 1)
    fprintf(fp, "0");
  else if (xi == -1)
    fprintf(fp, "1");

  for(int b = 0; b < bwidth; b++)
    fprintf(fp, "%d", ((idx % fsize) >> (bwidth-1-b)) % 2);

  fprintf(fp, "\n");
}

void make_1d(int index, int out_c)
{
  char cmd[256], filename[256];
  FILE *in_float, *out_dec, *out_bin;
  double dnum = 0.0;

  sprintf(cmd, "mkdir -p %s/iwb_%d", filepath, index);
  system(cmd);

  sprintf(cmd, "mkdir -p %s/bwb_%d", filepath, index);
  system(cmd);

  for (int i = 0; i < out_c; i++) {
    sprintf(filename, "%s/wb_%d/data%d.txt", filepath, index, i);
    in_float = fopen(filename, "r");

    sprintf(filename, "%s/iwb_%d/data%d.dat", filepath, index, i);
    out_dec = fopen(filename, "w");

    sprintf(filename, "%s/bwb_%d/data%d.bin", filepath, index, i);
    out_bin = fopen(filename, "w");

    while (fscanf(in_float, "%lf", &dnum) != EOF) {
      q88_dec(out_dec, dnum);
      q88_bin(out_bin, dnum);
    }

    fclose(in_float);
    fclose(out_dec);
    fclose(out_bin);
  }
}



void make_2d(int index, int in_c, int out_c)
{
  char cmd[256], filename[256];
  FILE *in_float, *out_dec, *out_bin, *null_dec, *null_bin;
  double dnum = 0.0;

  sprintf(cmd, "mkdir -p %s/iwb_%d", filepath, index);
  system(cmd);

  sprintf(cmd, "mkdir -p %s/bwb_%d", filepath, index);
  system(cmd);

  for (int i = 0; i < out_c; i++) {
    for (int j = 0; j < in_c; j++) {
      sprintf(filename, "%s/wb_%d/data%d_%d.txt", filepath, index, i, j);
      in_float = fopen(filename, "r");

      sprintf(filename, "%s/iwb_%d/data%d_%d.dat", filepath, index, i, j);
      out_dec = fopen(filename, "w");

      sprintf(filename, "%s/bwb_%d/data%d_%d.bin", filepath, index, i, j);
      out_bin = fopen(filename, "w");

      if (i == 0 && j == 0) {
        sprintf(filename, "%s/iwb_%d/null_w.dat", filepath, index);
        null_dec = fopen(filename, "w");

        sprintf(filename, "%s/bwb_%d/null_w.bin", filepath, index);
        null_bin = fopen(filename, "w");
      }

      while (fscanf(in_float, "%lf", &dnum) != EOF) {
        q88_dec(out_dec, dnum);
        q88_bin(out_bin, dnum);
        if (i == 0 && j == 0) {
          q88_dec(null_dec, 0.0);
          q88_bin(null_bin, 0.0);
        }
      }

      fclose(in_float);
      fclose(out_dec);
      fclose(out_bin);
      if (i == 0 && j == 0) {
        fclose(null_dec);
        fclose(null_bin);
      }
    }

    sprintf(filename, "%s/wb_%d/data%d.txt", filepath, index, i);
    in_float = fopen(filename, "r");

    sprintf(filename, "%s/iwb_%d/data%d.dat", filepath, index, i);
    out_dec = fopen(filename, "w");

    sprintf(filename, "%s/bwb_%d/data%d.bin", filepath, index, i);
    out_bin = fopen(filename, "w");

    if (i == 0) {
      sprintf(filename, "%s/iwb_%d/null_b.dat", filepath, index);
      null_dec = fopen(filename, "w");

      sprintf(filename, "%s/bwb_%d/null_b.bin", filepath, index);
      null_bin = fopen(filename, "w");
    }

    while (fscanf(in_float, "%lf", &dnum) != EOF) {
      q88_dec(out_dec, dnum);
      q88_bin(out_bin, dnum);
      if (i == 0) {
        q88_dec(null_dec, 0.0);
        q88_bin(null_bin, 0.0);
      }
    }

    fclose(in_float);
    fclose(out_dec);
    fclose(out_bin);
    if (i == 0) {
      fclose(null_dec);
      fclose(null_bin);
    }
  }
}

void make_hash(char *layer)
{
  char cmd[256], filename[256];
  FILE *in_float, *out_dec, *out_bin;
  double dnum = 0.0;

  sprintf(cmd, "mkdir -p %s/ihash", filepath);
  system(cmd);

  sprintf(cmd, "mkdir -p %s/bhash", filepath);
  system(cmd);

  sprintf(filename, "%s/hash/%s_hashW.txt", filepath, layer);
  in_float = fopen(filename, "r");

  sprintf(filename, "%s/ihash/%s_hashW.dat", filepath, layer);
  out_dec = fopen(filename, "w");

  sprintf(filename, "%s/bhash/%s_hashW.bin", filepath, layer);
  out_bin = fopen(filename, "w");

  while (fscanf(in_float, "%lf", &dnum) != EOF) {
    q88_dec(out_dec, dnum);
    q88_bin(out_bin, dnum);
  }

  fclose(in_float);
  fclose(out_dec);
  fclose(out_bin);
}

void make_idx(char *layer, int in_c, int out_c, int wsize, int bsize)
{
  char cmd[256], filename[256];
  FILE *in_idx, *in_xi, *out_join, *out_null;
  int idx, xi;

  sprintf(cmd, "mkdir -p %s/xi_idx", filepath);
  system(cmd);

  for (int i = 1; i <= out_c; i++) {
    for (int j = 1; j <= in_c; j++) {
      sprintf(filename, "%s/idx/%s_idxW_%d_%d.txt", filepath, layer, i, j);
      in_idx = fopen(filename, "r");

      sprintf(filename, "%s/idx/%s_xi_W_%d_%d.txt", filepath, layer, i, j);
      in_xi = fopen(filename, "r");

      sprintf(filename, "%s/xi_idx/%s_joinW_%d_%d.bin", filepath, layer, i-1, j-1);
      out_join = fopen(filename, "w");

      if (i == 1 && j == 1) {
        sprintf(filename, "%s/xi_idx/%s_nullW.bin", filepath, layer);
        out_null = fopen(filename, "w");
      }

      while (
           fscanf(in_idx, "%d", &idx) != EOF
        && fscanf(in_xi, "%d", &xi) != EOF
      ) {
        join_xi_idx(out_join, xi, idx-1, wsize);
        if (i == 1 && j == 1)
          join_xi_idx(out_null, 1, 0, wsize);
      }

      fclose(in_idx);
      fclose(in_xi);
      fclose(out_join);
      if (i == 1 && j == 1)
        fclose(out_null);
    }
  }

  sprintf(filename, "%s/idx/%s_idxB.txt", filepath, layer);
  in_idx = fopen(filename, "r");

  sprintf(filename, "%s/idx/%s_xi_B.txt", filepath, layer);
  in_xi = fopen(filename, "r");

  sprintf(filename, "%s/xi_idx/%s_joinB.bin", filepath, layer);
  out_join = fopen(filename, "w");

  sprintf(filename, "%s/xi_idx/%s_nullB.bin", filepath, layer);
  out_null = fopen(filename, "w");

  while (
       fscanf(in_idx, "%d", &idx) != EOF
    && fscanf(in_xi, "%d", &xi) != EOF
  ) {
    join_xi_idx(out_join, xi, idx-1, bsize);
    join_xi_idx(out_null, 1, 0, bsize);
  }

  fclose(in_idx);
  fclose(in_xi);
  fclose(out_join);
  fclose(out_null);
}

void parseopt(int argc, char **argv)
{
  int opt;

  while((opt = getopt(argc, argv, "h")) != -1) {
    switch (opt) {
      case 'h':
        hash_mode = true;
        break;
      default:
        break;
    }
  }

  if (optind != argc - 1) {
    fprintf(stderr,
            "Usage: %s [-h] <target folder>\n"
            "-h: convert hash index and signs\n"
            "\n"
    , argv[0]);
    exit(1);
  }

  filepath = argv[argc-1];
}

int main(int argc, char **argv)
{
  parseopt(argc, argv);

  make_2d(1,  1, 20);
  make_2d(2, 20, 50);
  make_1d(3, 500);
  make_1d(4, 10);

  if (hash_mode) {
    make_hash("conv1");
    make_hash("conv2");
    make_idx("conv1",  1, 20, 5, 10);
    make_idx("conv2", 20, 50, 5, 10);
  }

  return 0;
}
