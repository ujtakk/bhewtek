#!/bin/bash

function verilog-auto(){
    #emacs --batch $1 -f verilog-batch-indent
    emacs --batch $1 -f verilog-batch-auto
}

if [ -n "$1" ]
then
    erb $1.v.erb > $1.v
    verilog-auto $1.v
else
    for i in *.erb
    do
        erb $i > `echo $i | awk -F . '{print $1 "." $2}'`
    done

    for i in *.v
    do
        verilog-auto $i
    done
fi

exit
