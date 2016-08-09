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
            -e "s|{CORE}|${CORE}|g" \
            rtl_top.v > tb/tb${i}_${j}/tb${i}_${j}.v
        for n in *.v *.vh
        do
            ln -s ${PWD}/${n} tb/tb${i}_${j}/${n}
        done
        rm tb/tb${i}_${j}/rtl_top.v
    done
done

rm -r saif${CORE}
mkdir saif${CORE}

rm maborosi.sh

for i in `seq 0 9`
do
    for j in `seq 1 10`
    do
        echo "(cd tb/tb${i}_${j} ; vcs -full64 -R -PP -timescale=1ns/1ps +v2k +neg_tchk *.v | tee vcs${i}_${j}.log)" >> maborosi.sh
    done
done

cat maborosi.sh | xargs -P 24 -I {} -t bash -c '{}'
rm maborosi.sh

#rm -r tb

exit
