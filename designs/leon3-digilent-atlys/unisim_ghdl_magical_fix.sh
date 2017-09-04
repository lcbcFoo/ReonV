#!/bin/sh

#
# There is a bug in GHDL 0.29 which is triggered by entities
# having an output port with a default value.
# This script strips the default values from Unisim library entities.
#

for f in ../../lib/tech/unisim/ise/*.vhd ; do
  echo Fixing $f
  sed -e "s/out std_ulogic := '.'/out std_ulogic/" < "$f" > "${f}_new"
  mv "${f}_new" "$f"
done
