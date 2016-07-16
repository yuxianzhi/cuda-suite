#!/bin/bash

#The bash script to stop MPS on multi-user system.
#Introduction:
#		MPS(Multi-Process Service)
#   The Multi-Process Service takes advantage of the inter-MPI rank
# parallelism, increasing the overall GPU utilization.

#see also:http: //docs.nvidia.com/deploy/mps/index.html



export NVIDIA_GPU_DEVICE="0,1"
nvidia-smi -i ${NVIDIA_GPU_DEVICE} -c DEFAULT
echo quit | nvidia-cuda-mps-control
