#!/bin/bash

function verilog-auto(){
    #emacs --batch $1 -f verilog-batch-indent
    emacs --batch $1 -f verilog-batch-auto
}

if [ -n "$1" ]
then
    erb -T - $1.erb > $1
    verilog-auto $1
else
    for i in *.erb
    do
        erb -T - $i > `echo $i | awk -F . '{print $1 "." $2}'`
    done

    for i in *.v
    do
        verilog-auto $i
    done
fi

exit
