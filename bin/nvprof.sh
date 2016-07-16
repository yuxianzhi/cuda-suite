#!/bin/bash


#use nvidia tool nvprof to profile your program
#the profiling result is saved to file NVPROF_RESULT_FILE

export NVPROF_RESULT_FILE=result.nvvp
echo "Your command is "
echo "	"$*
echo "The profiling result is saved to file: "$NVPROF_RESULT_FILE

nvprof -o $NVPROF_RESULT_FILE $*
