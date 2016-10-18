/*
 * Test Condition:
 *  XXH_littleEndian
 *  XXH_unaligned
 */
#ifndef MY_XXHASH
#define MY_XXHASH

#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cstring>

typedef uint8_t  BYTE;
typedef uint32_t U32;
typedef enum { XXH_bigEndian=0, XXH_littleEndian=1 } XXH_endianess;
typedef enum { XXH_aligned, XXH_unaligned } XXH_alignment;
typedef enum { XXH_OK=0, XXH_ERROR } XXH_errorcode;
struct XXH32_state_s {
  unsigned long long total_len;
  unsigned seed;
  unsigned v1;
  unsigned v2;
  unsigned v3;
  unsigned v4;
  unsigned mem32[4];   /* buffer defined as U32 for alignment */
  unsigned memsize;
};   /* typedef'd to XXH32_state_t */
typedef struct XXH32_state_s XXH32_state_t;   /* incomplete type */

#define KB *( 1<<10)
#define MB *( 1<<20)
#define GB *(1U<<30)
#define DISPLAY(...)   fprintf(stderr, __VA_ARGS__)
#define DISPLAYRESULT(...)   fprintf(stdout, __VA_ARGS__)
#define DISPLAYLEVEL(l, ...) if (g_displayLevel>=l) DISPLAY(__VA_ARGS__);
static U32 g_displayLevel = 1;
#define XXH_PUBLIC_API static inline

//int check_count_1 = 0;
//#define _debug_1 printf("check_1 %d: OK\n", check_count_1); check_count_1++;
//int check_count_2 = 0;
//#define _debug_2 printf("check_2 %d: OK\n", check_count_2); check_count_2++;

static size_t g_sampleSize = 100 KB;

static const U32 PRIME32_1 = 2654435761U;
static const U32 PRIME32_2 = 2246822519U;
static const U32 PRIME32_3 = 3266489917U;
static const U32 PRIME32_4 =  668265263U;
static const U32 PRIME32_5 =  374761393U;

XXH_PUBLIC_API XXH_errorcode XXH32_reset(XXH32_state_t* statePtr, unsigned int seed)
{
  XXH32_state_t state;   /* using a local state to memcpy() in order to avoid strict-aliasing warnings */
  memset(&state, 0, sizeof(state));
  state.seed = seed;
  state.v1 = seed + PRIME32_1 + PRIME32_2;
  state.v2 = seed + PRIME32_2;
  state.v3 = seed + 0;
  state.v4 = seed - PRIME32_1;
  memcpy(statePtr, &state, sizeof(state));
  return XXH_OK;
}

static U32 XXH_read32(const void* memPtr)
{
  U32 val;
  memcpy(&val, memPtr, sizeof(val));
  return val;
}

XXH_PUBLIC_API U32 XXH_readLE32_align(const void* ptr, XXH_endianess endian, XXH_alignment align)
{
  return XXH_read32(ptr);
}

#define XXH_rotl32(x,r) ((x << r) | (x >> (32 - r)))
#define XXH_get32bits(p) XXH_readLE32_align(p, endian, align)

static U32 XXH32_round(U32 seed, U32 input)
{
  seed += input * PRIME32_2;
  seed  = XXH_rotl32(seed, 13);
  seed *= PRIME32_1;
  return seed;
}

XXH_PUBLIC_API U32 XXH32_endian_align(const void* input, size_t len, U32 seed, XXH_endianess endian, XXH_alignment align)
{
  const BYTE* p = (const BYTE*)input;
  const BYTE* bEnd = p + len;
  U32 h32;

  if (len>=16) {
    const BYTE* const limit = bEnd - 16;
    U32 v1 = seed + PRIME32_1 + PRIME32_2;
    U32 v2 = seed + PRIME32_2;
    U32 v3 = seed + 0;
    U32 v4 = seed - PRIME32_1;

    do {
      v1 = XXH32_round(v1, XXH_get32bits(p)); p+=4;
      v2 = XXH32_round(v2, XXH_get32bits(p)); p+=4;
      v3 = XXH32_round(v3, XXH_get32bits(p)); p+=4;
      v4 = XXH32_round(v4, XXH_get32bits(p)); p+=4;
    } while (p<=limit);

    h32 = XXH_rotl32(v1, 1) + XXH_rotl32(v2, 7) + XXH_rotl32(v3, 12) + XXH_rotl32(v4, 18);
  } else {
    h32  = seed + PRIME32_5;
  }

  h32 += (U32) len;

  while (p+4<=bEnd) {
    h32 += XXH_get32bits(p) * PRIME32_3;
    h32  = XXH_rotl32(h32, 17) * PRIME32_4 ;
    p+=4;
  }

  while (p<bEnd) {
    h32 += (*p) * PRIME32_5;
    h32 = XXH_rotl32(h32, 11) * PRIME32_1 ;
    p++;
  }

  h32 ^= h32 >> 15;
  h32 *= PRIME32_2;
  h32 ^= h32 >> 13;
  h32 *= PRIME32_3;
  h32 ^= h32 >> 16;

  return h32;
}

XXH_PUBLIC_API U32 XXH32 (const void* input, size_t len, unsigned int seed)
{
  return XXH32_endian_align(input, len, seed, XXH_littleEndian, XXH_unaligned);
}

static void BMK_testSequence(const void* sequence, size_t len, U32 seed, U32 Nresult)
{
  U32 Dresult;
  Dresult = XXH32(sequence, len, seed);
  if (Dresult != Nresult) printf("wrong\n");
}

#define SANITY_BUFFER_SIZE 101
static void BMK_sanityCheck(void)
{
#ifdef DEBUG
  printf("begin BMK_sanityCheck()...\n");
#endif

  static const U32 prime = 2654435761U;
  BYTE sanityBuffer[SANITY_BUFFER_SIZE];
  U32 byteGen = prime;

  int i;
  for (i=0; i<SANITY_BUFFER_SIZE; i++) {
  sanityBuffer[i] = (BYTE)(byteGen>>24);
  byteGen *= byteGen;
  }

  BMK_testSequence(NULL,    0, 0,   0x02CC5D05);
  BMK_testSequence(NULL,    0, prime, 0x36B78AE7);
  BMK_testSequence(sanityBuffer,  1, 0,   0xB85CBEE5);
  BMK_testSequence(sanityBuffer,  1, prime, 0xD5845D64);
  BMK_testSequence(sanityBuffer, 14, 0,   0xE5AA0AB4);
  BMK_testSequence(sanityBuffer, 14, prime, 0x4481951D);
  BMK_testSequence(sanityBuffer, SANITY_BUFFER_SIZE, 0,   0x1F1AA412);
  BMK_testSequence(sanityBuffer, SANITY_BUFFER_SIZE, prime, 0x498EC8E2);

#ifdef DEBUG
  printf("finished BMK_sanityCheck()\n");
#endif
}

static clock_t BMK_clockSpan( clock_t start )
{
    return clock() - start;   /* works even if overflow; Typical max span ~ 30 mn */
}

#define TIMELOOP_S 1
#define TIMELOOP  (TIMELOOP_S * CLOCKS_PER_SEC)
#define NBLOOPS    3
static U32 g_nbIterations = NBLOOPS;

static void BMK_benchHash(const void* buffer, size_t bufferSize)
{
#ifdef DEBUG
  printf("begin BMK_benchHash()...\n");
#endif

  static const U32 nbh_perloop = 100;
  U32 iterationNb;
  double fastestH = 100000000.;

  FILE *fp;
  const char *filename_out = "xxhash_true.dat";
  if ((fp = fopen(filename_out, "w")) == NULL) {
    fprintf(stderr, "fail to open '%s'\n", filename_out);
    exit(EXIT_FAILURE);
  }

  if (g_nbIterations<1) g_nbIterations=1;
  for (iterationNb = 1; iterationNb <= g_nbIterations; iterationNb++) {

    U32 nbHashes = 0, r = 0;

    clock_t cStart;

    cStart = clock();
    while (clock() == cStart);   /* starts clock() at its exact beginning */
    cStart = clock();

    while (BMK_clockSpan(cStart) < TIMELOOP) {
      U32 i;
      for (i=0; i<nbh_perloop; i++) {
        r = XXH32(buffer, bufferSize, i);
        fprintf(fp, "%d\n", r);
      }
      nbHashes += nbh_perloop;
    }
  }
  fclose(fp);

#ifdef DEBUG
  printf("finished BMK_benchHash()\n");
#endif
}

#endif
