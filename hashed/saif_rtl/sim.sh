#!/bin/zsh

CORE=8

rm -r tb

for i in `seq 0 9`
do
  for j in `seq 1 10`
  do
    mkdir -p tb/tb${i}_${j}
    sed -e "s|{NUM}|${i}|g" \
        -e "s|{FILE}|${j}|g" \
        rtl_top_hash.v > tb/tb${i}_${j}/tb${i}_${j}.v
    for n in *.v *.vh
    do
      ln -s ${PWD}/${n} tb/tb${i}_${j}/${n}
    done
    rm tb/tb${i}_${j}/rtl_top_hash.v
    rm tb/tb${i}_${j}/test_top_hash.v
  done
  echo "linked ${i}"
done

rm -r saif${CORE}
mkdir saif${CORE}

rm maborosi.sh

for i in `seq 0 9`
do
  for j in `seq 1 10`
  do
    echo "( \
cd tb/tb${i}_${j} ; \
vcs -full64 -R -PP -timescale=1ns/1ps +v2k +neg_tchk *.v | tee vcs${i}_${j}.log; \
mv rtl_top_hash${i}_${j}.saif ../../saif${CORE} \
)" \
    >> maborosi.sh
  done
  echo "scripted ${i}"
done

cat maborosi.sh | xargs -P 24 -t -I {} bash -c '{}'
rm maborosi.sh

rm -r tb

exit
