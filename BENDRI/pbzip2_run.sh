#!/bin/sh
num_cpus=`grep -c ^processor /proc/cpuinfo`
time ./pbzip2-1.1.6/pbzip2 -c -p$num_cpus -r -5 ./compressfile > /dev/null 2>bla
