#!/bin/sh

for I in `ls *.x86`
do
    NAME=`echo ${I} | cut -f '1 2' -d '.'`
#    gdb ${I} --command=gdb/${NAME}.gdb > ${I}.out
    gdb ${I} --command=gdb/${NAME}.gdb | cut -s -f 2 -d '$' | cut -f 2 -d '=' > ${I}.out 

done

