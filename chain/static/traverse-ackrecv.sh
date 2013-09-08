#!/bin/sh
# This script traverses the second level diretorise and extracts the max acked seqence number information

  ls | while read i
  do
    if [ -d "$i" ]; then
      cd "$i"
        ls | while read j
        do
          cd $j
          pwd
          gawk -f /home/lab/paper/trace2stats_v05b/brief.awk flag="ackrecv" HopsResultAvg.txt > ackrecv
          cd ..
        done
      cd ..
     fi
  done

