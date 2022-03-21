#!/bin/bash
source /anfhome/apps/amd/setenv_AOCC.sh
wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c
clang -O3 -mcmodel=medium -DSTREAM_TYPE=double -mavx2 -DSTREAM_ARRAY_SIZE=250000000 -DNTIMES=10 -ffp-contract=fast -fnt-store -fopenmp stream.c -o streamcp-aocc

icc -O3 -mcmodel=medium -mtune=core-avx2 -DSTREAM_TYPE=double -DSTREAM_ARRAY_SIZE=250000000 -DNTIMES=10 -fopenmp stream.c -o streamcp-icc
