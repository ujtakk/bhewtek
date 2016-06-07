#!/bin/zsh

LABEL=2
NAME=4

# pmap1_flat
cat << EOS > pmap1_flat.h
// PATH: /home/work/takau/bhewtek/data/mnist/bpmap1/${LABEL}/data${NAME}_*.bin
u16 pmap1_flat[2880] = {
`
for i in $(seq 0 19)
do
  cat /home/work/takau/bhewtek/data/mnist/bpmap1/${LABEL}/data${NAME}_${i}.bin \
    | awk '{print "0b" $0 ","}'
done
`
};
EOS

cat << EOS > w_conv2_flat.h
// PATH: /home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data*_*.bin
u16 w_conv2_flat[25000] = {
`
for i in $(seq 0 49)
do
  for j in $(seq 0 19)
  do
    cat /home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data${i}_${j}.bin \
      | awk '{print "0b" $0 ","}'
  done
done
`
};
EOS

cat << EOS > b_conv2.h
// PATH: /home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data*.bin
u16 b_conv2[50] = {
`
for i in $(seq 0 49)
do
  cat /home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data${i}.bin \
    | awk '{print "0b" $0 ","}'
done
`
};
EOS

cat << EOS > w_hidden.h
// PATH: /home/work/takau/bhewtek/data/mnist/lenet/bwb_3/data*.bin
u16 w_hidden[500][800] = {
`
for i in $(seq 0 499)
do
  echo "{"
  cat /home/work/takau/bhewtek/data/mnist/lenet/bwb_3/data${i}.bin \
    | awk '{print "0b" $0 ","}' \
    | head -n 800
  echo "},"
done
`
};
EOS

cat << EOS > b_hidden.h
// PATH: /home/work/takau/bhewtek/data/mnist/lenet/bwb_3/data*.bin
u16 b_hidden[500] = {
`for i in $(seq 0 499)
do
  cat /home/work/takau/bhewtek/data/mnist/lenet/bwb_3/data${i}.bin \
    | awk '{print "0b" $0 ","}' \
    | tail -n 1
done
`
};
EOS

cat << EOS > w_output.h
// PATH: /home/work/takau/bhewtek/data/mnist/lenet/bwb_4/data*.bin
u16 w_output[10][500] = {
`
for i in $(seq 0 9)
do
  echo "{"
  cat /home/work/takau/bhewtek/data/mnist/lenet/bwb_4/data${i}.bin \
    | awk '{print "0b" $0 ","}' \
    | head -n 500
  echo "},"
done
`
};
EOS

cat << EOS > b_output.h
// PATH: /home/work/takau/bhewtek/data/mnist/lenet/bwb_4/data*.bin
u16 b_output[10] = {
`for i in $(seq 0 9)
do
  cat /home/work/takau/bhewtek/data/mnist/lenet/bwb_4/data${i}.bin \
    | awk '{print "0b" $0 ","}' \
    | tail -n 1
done
`
};
EOS

