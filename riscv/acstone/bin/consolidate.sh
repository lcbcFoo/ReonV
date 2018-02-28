#!/bin/bash

rm "$ARCH.stats"
awk -F", " 'BEGIN { OFS = ";"} {print $1}' "000.main.$ARCH.stats" > "$ARCH.stats"

for I in `ls *.${ARCH}`; do
	echo "Processing:" "$I.stats"
	VAR=`awk -F", " 'BEGIN { OFS = ", "} FNR==NR{a[$1]=$0; next}{print a[$1],$2}' "$ARCH.stats" "$I.stats"`
	echo "$VAR" > "$ARCH.stats"
done

VAR=`awk -F", " 'BEGIN { OFS = ", "} NR > 1 { sum=0; for(i = 2; i <= NF; i++) { sum+=$i; }; print $1, sum; }' "$ARCH.stats"`
echo "$VAR" > "$ARCH.stats"

echo "UNTESTED INSTRUCTIONS:"
VAR=`awk -F", " '{ if($2 == 0) print $1 }' "$ARCH.stats"`

echo "$VAR"

COUNT_TESTED=`awk '$2 > 0 { count++ } END { print count }' "$ARCH.stats"`
COUNT_UNTESTED=`awk '$2 == 0 { count++ } END { print count }' "$ARCH.stats"`
echo "COUNT_TESTED: $COUNT_TESTED" 
echo "COUNT_UNTESTED: $COUNT_UNTESTED" 
DIV=`bc <<< "scale=2; ($COUNT_TESTED / ($COUNT_UNTESTED+$COUNT_TESTED))*100"`
echo "Coverage: $DIV%" 