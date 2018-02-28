#!/bin/bash

for I in *.x86.out ; do

  TMP=`echo $I | cut -d '.' -f '1 2'`
  #diff --brief --report-identical-files ${TMP}.${ARCH}.out  data/$TMP.data
  diff --brief --report-identical-files ${TMP}.${ARCH}.out  ${TMP}.x86.out

done
