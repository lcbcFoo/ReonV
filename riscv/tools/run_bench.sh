#!/bin/sh
################################################################################
#
# Author: Lucas Castro
# Last modification: april/2018
#
# 	Bash script for running benchmark programs on ReonV
#
################################################################################

echo ""
if [ ! -d "wcet_benchmark" ]; then
    echo "Benchmark repository not found!"
    exit
else
    echo "Beginning benchmarks"
fi
echo ""
echo "Command used to run grmon, change it's parameters on Makefile if needed:"
echo $@
echo ""
rm -f wcet_benchmark/*.log tools/bench_res.txt
gcc tools/to_text.c -o tools/to_text
echo "01000000" > tools/res.txt
for input in `ls -1 wcet_benchmark/*.out`; do
    echo "Running:" ${input}
    n=10
    correct=true
    for i in $(seq 1 $n); do
        rm -f tools/grmon_norun tools/grmon_run
        # Generate grmon_norun
        echo "bload " ${input} >> tools/grmon_norun
        echo "ep 0x40001000" >> tools/grmon_norun
        echo "dump -binary 0x44000000 1 res.bin" >> tools/grmon_norun
        echo "quit" >> tools/grmon_norun

        # Generate grmon_run
        echo "bload " ${input} >> tools/grmon_run
        echo "ep 0x40001000" >> tools/grmon_run
        echo "run" >> tools/grmon_run
        echo "dump -binary 0x44000000 1 res.bin" >> tools/grmon_run
        echo "quit" >> tools/grmon_run

        echo "Test" $i
        # Format log file
        output="${input#wcet_benchmark/}"
        output="${output%.out}"
        /usr/bin/time -f "%e" $@ -c tools/grmon_norun -abaud 115200 > /dev/null 2>> wcet_benchmark/${output}_norun.log
        /usr/bin/time -f "%e" $@ -c tools/grmon_run -abaud 115200 > /dev/null 2>> wcet_benchmark/${output}_run.log

        ./tools/to_text res.bin tools/res.read
        cmp=$(diff tools/res.txt tools/res.read)
        if [ "$cmp" != "" ]; then
            echo "Test Failed"
            correct=0
        else
            echo "Test Passed"
        fi
    done
    total=0
    if [ "$correct" == "true" ]; then
        correct=CORRECT
    else
        correct=INCORRECT
        exit
    fi
    echo "Test ${output}: ${correct}" >> tools/bench_res.txt
    echo "" >> tools/bench_res.txt

    while read p; do
        total=`echo $p + $total | bc`
    done < wcet_benchmark/${output}_run.log
    echo "Total running time: " ${total} "s" >> tools/bench_res.txt
    total_no=0
    while read p; do
        total_no=`echo $total_no + $p | bc`
    done < wcet_benchmark/${output}_norun.log
    echo "Total time used by grmon:" ${total_no} "s" >> tools/bench_res.txt
    total=`echo $total - $total_no | bc | awk '{printf "%.2f", $0}'`
    echo "Total" ${output} "test running time: " ${total} "s" >> tools/bench_res.txt
    total=`echo $total / $n | bc -l | awk '{printf "%.2f", $0}'`
    echo "Average execution time: " $total "s" >> tools/bench_res.txt
    echo "" >> tools/bench_res.txt
    echo "" >> tools/bench_res.txt
    echo ""
done
rm -f tools/res* tools/to_text tools/grmon_norun tools/grmon_run
