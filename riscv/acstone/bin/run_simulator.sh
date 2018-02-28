#!/bin/bash

#Make a loop for each file
for I in `ls *.${ARCH}`
  do
 
  echo ${SIMULATOR}${I} --port=${GDBPORT}
  ${SIMULATOR}${I} --port=${GDBPORT}

done

