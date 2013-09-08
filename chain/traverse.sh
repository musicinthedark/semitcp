#!/bin/sh
# This script traverses the second level diretorise and extracts the max acked seqence number information

  ls | while read i
  do
    if [ -d "$i" ]; then
      cd "$i"
        ls | while read j
        do
			if [ -d "$j" ]; then
	          cd $j
	          pwd
	          ./chain.sh
	          cd ..
			fi
        done
      cd ..
     fi
  done

