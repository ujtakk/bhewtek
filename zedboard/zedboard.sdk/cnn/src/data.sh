#!/bin/zsh

LABEL=$1
NAME=$2

cat << EOS > data/input_flat.h
#ifndef __INPUT_FLAT_H_
#define __INPUT_FLAT_H_

// PATH: ../../../../data/mnist/binput/${LABEL}/data${NAME}.bin
s16 input_flat[784] = {
`
cat ../../../../data/mnist/binput/${LABEL}/data${NAME}.bin \
  | awk '{print "0b" $0 ","}'
`
};

#endif
EOS

cat << EOS > data/pmap1_flat.h
#ifndef __PMAP1_FLAT_H_
#define __PMAP1_FLAT_H_

// PATH: ../../../../data/mnist/bpmap1/${LABEL}/data${NAME}_*.bin
s16 pmap1_flat[2880] = {
`
for i in $(seq 0 19)
do
  cat ../../../../data/mnist/bpmap1/${LABEL}/data${NAME}_${i}.bin \
    | awk '{print "0b" $0 ","}'
done
`
};

#endif
EOS

cat << EOS > data/pmap1_flat_true.h
#ifndef __PMAP1_FLAT_TRUE_H_
#define __PMAP1_FLAT_TRUE_H_

// PATH: ../../../../data/mnist/bpmap1_true/${LABEL}/data${NAME}_*.bin
s16 pmap1_flat_true[2880] = {
`
for i in $(seq 0 19)
do
  cat ../../../../data/mnist/bpmap1_true/${LABEL}/data${NAME}_${i}.bin \
    | awk '{print "0b" $0 ","}'
done
`
};

#endif
EOS

cat << EOS > data/pmap2_flat_true.h
#ifndef __PMAP2_FLAT_TRUE_H_
#define __PMAP2_FLAT_TRUE_H_

// PATH: ../../../../data/mnist/bpmap2_true/${LABEL}/data${NAME}_*.bin
s16 pmap2_flat_true[800] = {
`
for i in $(seq 0 49)
do
  cat ../../../../data/mnist/bpmap2_true/${LABEL}/data${NAME}_${i}.bin \
    | awk '{print "0b" $0 ","}'
done
`
};

#endif
EOS

cat << EOS > data/w_conv1_flat.h
#ifndef __W_CONV1_FLAT_H_
#define __W_CONV1_FLAT_H_

// PATH: ../../../../data/mnist/lenet/bwb_1/data*_*.bin
s16 w_conv1_flat[500] = {
`
for i in $(seq 0 19)
do
  for j in $(seq 0 0)
  do
    cat ../../../../data/mnist/lenet/bwb_1/data${i}_${j}.bin \
      | awk '{print "0b" $0 ","}'
  done
done
`
};

#endif
EOS

cat << EOS > data/b_conv1.h
#ifndef __B_CONV1_H_
#define __B_CONV1_H_

// PATH: ../../../../data/mnist/lenet/bwb_1/data*.bin
s16 b_conv1[20] = {
`
for i in $(seq 0 19)
do
  cat ../../../../data/mnist/lenet/bwb_1/data${i}.bin \
    | awk '{print "0b" $0 ","}'
done
`
};

#endif
EOS

cat << EOS > data/w_conv2_flat.h
#ifndef __W_CONV2_FLAT_H_
#define __W_CONV2_FLAT_H_

// PATH: ../../../../data/mnist/lenet/bwb_2/data*_*.bin
s16 w_conv2_flat[25000] = {
`
for i in $(seq 0 49)
do
  for j in $(seq 0 19)
  do
    cat ../../../../data/mnist/lenet/bwb_2/data${i}_${j}.bin \
      | awk '{print "0b" $0 ","}'
  done
done
`
};

#endif
EOS

cat << EOS > data/b_conv2.h
#ifndef __B_CONV2_H_
#define __B_CONV2_H_

// PATH: ../../../../data/mnist/lenet/bwb_2/data*.bin
s16 b_conv2[50] = {
`
for i in $(seq 0 49)
do
  cat ../../../../data/mnist/lenet/bwb_2/data${i}.bin \
    | awk '{print "0b" $0 ","}'
done
`
};

#endif
EOS

cat << EOS > data/w_hidden.h
#ifndef __W_HIDDEN_H_
#define __W_HIDDEN_H_

// PATH: ../../../../data/mnist/lenet/bwb_3/data*.bin
s16 w_hidden[400000] = {
`
for i in $(seq 0 499)
do
  #echo "{"
  cat ../../../../data/mnist/lenet/bwb_3/data${i}.bin \
    | awk '{print "0b" $0 ","}' \
    | head -n 800
  #echo "},"
done
`
};

#endif
EOS

cat << EOS > data/b_hidden.h
#ifndef __B_HIDDEN_H_
#define __B_HIDDEN_H_

// PATH: ../../../../data/mnist/lenet/bwb_3/data*.bin
s16 b_hidden[500] = {
`for i in $(seq 0 499)
do
  cat ../../../../data/mnist/lenet/bwb_3/data${i}.bin \
    | awk '{print "0b" $0 ","}' \
    | tail -n 1
done
`
};

#endif
EOS

cat << EOS > data/w_output.h
#ifndef __W_OUTPUT_H_
#define __W_OUTPUT_H_

// PATH: ../../../../data/mnist/lenet/bwb_4/data*.bin
s16 w_output[5000] = {
`
for i in $(seq 0 9)
do
  #echo "{"
  cat ../../../../data/mnist/lenet/bwb_4/data${i}.bin \
    | awk '{print "0b" $0 ","}' \
    | head -n 500
  #echo "},"
done
`
};

#endif
EOS

cat << EOS > data/b_output.h
#ifndef __B_OUTPUT_H_
#define __B_OUTPUT_H_

// PATH: ../../../../data/mnist/lenet/bwb_4/data*.bin
s16 b_output[10] = {
`for i in $(seq 0 9)
do
  cat ../../../../data/mnist/lenet/bwb_4/data${i}.bin \
    | awk '{print "0b" $0 ","}' \
    | tail -n 1
done
`
};

#endif
EOS

