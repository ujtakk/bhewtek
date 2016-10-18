#include <iostream>
#include <string>
#include "my_xxhash.cpp"

inline char *str2char(char *dest, const std::string &src, size_t num)
{
  strncpy(dest, src.c_str(), num-1);
  *(dest+num-1) = '\0';
  return 0;
}

int hashFunc(int hN, int size_out, int size_in, std::string extra_str_in)
{
  const int Nall = size_out * size_in;
  const int rep = 3;
  const int max = hN;
  const int min = 1;
  const int range = max - min + 1;

  int hashSeed = 1691;
  int count = 0;
  int key_i_size, key_j_size;
  int idx[Nall];

  std::string extra_str = extra_str_in;
  std::string key_i, key_j;
  std::string key;

  for (int i = 0; i < size_out; i++) {
    for (int j = 0; j < size_in; j++) {
      count++;
      key_i = "";
      key_j = "";
      for (int r = 0; r < rep; r++) {
        key_i += std::to_string(i+r);
        key_j += std::to_string(j+r);
      }
      //key = key_i .. '_' .. key_j .. extra_str
      key = key_i + "_" + key_j + extra_str;
      //std::cout << key << std::endl;
      const int len = key.length();
      char query[len+1];
      str2char(query, key, len);
      idx[count] = XXH32((void *)query, key.length(), hashSeed) % (range) + min;
      //idx[count] = XXH32((void *)count, 32, hashSeed) % (range);
      std::cout << count << " " << idx[count] << std::endl;
    }
  }

  return 0;
}

int main (int argc, char *argv[])
{
  BMK_sanityCheck();

  size_t const benchedSize = g_sampleSize;
  void* const buffer = malloc(benchedSize);
  BMK_benchHash(buffer, benchedSize);
  free(buffer);

  hashFunc(5,5,5, "xi_W");
  //printf("done.\n");

  return 0;
}
