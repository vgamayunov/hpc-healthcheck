#!/bin/bash
install_dir=/anfhome/apps/hpc-healthcheck
pdsh=pdsh


source /etc/profile.d/modules.sh
module use /usr/share/Modules/modulefiles
module add gcc-9.2.0 mpi/hpcx

cd $install_dir
numnodes=$(sort -u $PBS_NODEFILE | wc -l)
vm_size=$(curl -sH Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | jq '.compute.vmSize')


echo Running STREAM ...
$pdsh -w $(sort -u $PBS_NODEFILE | tr '\n' ',') "cd $PWD/stream; ./run.sh" | grep Triad | sort -g -k3 -r

echo Running IMB-MPI1 sendrecv ...
mpiexec -x PATH -x LD_LIBRARY_PATH -hostfile $PBS_NODEFILE -npernode 1 IMB-MPI1 sendrecv -npmin $numnodes | grep "t_max\|processes\|          8 \|    4194304 "
