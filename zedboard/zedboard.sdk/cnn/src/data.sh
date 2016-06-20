#!/bin/zsh

LABEL=3
NAME=4

# pmap1_flat
cat << EOS > pmap1_flat.h
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
EOS

cat << EOS > pmap2_flat.h
// PATH: ../../../../data/mnist/bpmap2/${LABEL}/data${NAME}_*.bin
s16 pmap2_flat[800] = {
`
for i in $(seq 0 49)
do
  cat ../../../../data/mnist/bpmap2/${LABEL}/data${NAME}_${i}.bin \
    | awk '{print "0b" $0 ","}'
done
`
};
EOS

cat << EOS > w_conv2_flat.h
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
EOS

cat << EOS > b_conv2.h
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
EOS

cat << EOS > w_hidden.h
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
EOS

cat << EOS > b_hidden.h
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
EOS

cat << EOS > w_output.h
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
EOS

cat << EOS > b_output.h
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
EOS

