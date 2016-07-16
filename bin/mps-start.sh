#!/bin/bash

#The bash script to enable MPS on multi-user system.
#Introduction:
#		MPS(Multi-Process Service)
#   The Multi-Process Service takes advantage of the inter-MPI rank
# parallelism, increasing the overall GPU utilization.

#see also:http: //docs.nvidia.com/deploy/mps/index.html



export NVIDIA_GPU_DEVICE="0,1"
export CUDA_VISIBLE_DEVICES=${NVIDIA_GPU_DEVICE}
nvidia-smi -i ${NVIDIA_GPU_DEVICE} -c EXCLUSIVE_PROCESS
nvidia-cuda-mps-control -d

#afer you have run the mps-start bash. when you run your program, you will find that nvidia-cuda-mps-server process when you open nvidia-smi.
#and you will not find the real your program process.
