#!/bin/bash


#use nvidia tool nvprof to profile your program
#the profiling result is saved to file NVPROF_RESULT_FILE

export NVPROF_RESULT_FILE=result.nvvp
echo "Your command is "
echo "	"$*
echo "The profiling result is saved to file: "$NVPROF_RESULT_FILE

nvprof -o $NVPROF_RESULT_FILE $*

#for intel mpi
#mpirun -np 5 nvprof -o mpi-1000.%q{PMI_RANK}.nvvp ./exe
#for openmpi
#mpirun -np 5 nvprof -f -o mpi-1000.%q{OMPI_COMM_WORLD_RANK}.nvvp ./exe
