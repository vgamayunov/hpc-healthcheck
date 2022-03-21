#!/bin/bash
source /anfhome/apps/amd/setenv_AOCC.sh
numproc=$(grep processor /proc/cpuinfo |wc -l)
if (( numproc <= 32 )) ; then
    threads=$numproc
    export OMP_NUM_THREADS=$threads
    export OMP_PLACES="{0}:$threads"
else
    threads=$(( numproc / 2 ))
    export OMP_NUM_THREADS=$threads
    export OMP_PLACES="{0}:$threads:2"
fi
./streamcp-aocc
