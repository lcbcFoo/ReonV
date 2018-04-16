#!/bin/sh
################################################################################
#
# Author: Lucas Castro
# Last modification: april/2018
#
# 	Bash script for running benchmark programs on ReonV
#
################################################################################

echo $@

if [ ! -d "wcet_benchmark" ]; then
    echo "Benchmark repository not found!"
    exit
else
    echo "Beginning benchmarks"
fi

for input in `ls -1 wcet_benchmark/*.out`; do
    echo "Running:" ${input}
    rm -f tools/grmon_norun tools/grmon_run
    # Generate grmon_norun
    echo "bload " ${input} >> tools/grmon_norun
    echo "ep 0x40001000" >> tools/grmon_norun
    echo "dump -binary 0x44000000 1 res.bin" >> tools/grmon_norun
    echo "quit" >> tools/grmon_norun

    # Generate grmon_run
    echo "bload " ${input} >> tools/grmon_run
    echo "ep 0x40001000" >> tools/grmon_run
    echo "bload " ${input} >> tools/grmon_run
    echo "dump -binary 0x44000000 1 res.bin" >> tools/grmon_run
    echo "quit" >> tools/grmon_run

    output="${input#wcet_benchmark/}"
    output="${output%.out}"
    norun_time=$(time $@ -c tools/grmon_norun -log tools/grmon_${output}_log.txt -abaud 115200 > /dev/null)
    run_time=$(time $@ -c tools/grmon_run -log tools/grmon_${output}_log.txt -abaud 115200 > /dev/null)
    done
