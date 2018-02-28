#!/bin/bash

# For each compiled program construct a gdb's
# command file and call gdb

# Compute the number lines of inicial first commands file
NLCFG=`cat gdb/firstcommands.gdb | wc -l`

#Make a loop for each file
for I in `ls *.${ARCH}`; do

    NAME=`echo ${I} | cut -f '1 2' -d '.'`
    NL=`cat gdb/${NAME}.gdb | wc -l`
    NLSHOW=`expr ${NL} - 2`

    rm -f ${NAME}.cmd
    cat gdb/firstcommands.gdb > ${NAME}.cmd
    sed -i "s@\$GDBPORT@$GDBPORT@g" ${NAME}.cmd
    tail -n ${NLSHOW} gdb/${NAME}.gdb >> ${NAME}.cmd

    echo "${GDB} ${I} --command=${NAME}.cmd -batch"
    ${GDB} ${I} --command=${NAME}.cmd -batch | cut -s -f 2 -d '$' | cut -f 2 -d '=' > ${NAME}.${ARCH}.out

    if [ -e ${ARCH}_lastrun_stats.csv ]
    then
        mv ${ARCH}_lastrun_stats.csv ${I}.stats
    fi

    sleep 0.25

done

