#include <cuda_runtime.h>
#include<stdio.h>
#include<stdlib.h>
#include <sys/time.h>

#include "kernel.h"

const int NUM  = 2;
const int SIZE = 1;
#define DATATYPE float
cudaStream_t UTIL_GPU_Stream[NUM+1];


DATATYPE *A;

void UTIL_CreateStreams(){
    UTIL_GPU_Stream[0] = 0;
    int i;
    for(i = 1; i <= NUM; i++) {
        cudaStreamCreate(&UTIL_GPU_Stream[i]);
    }
}
void UTIL_deleteStreams(){
    int i;
    for(i = 1; i <= NUM; i++) {
        cudaStreamDestroy(UTIL_GPU_Stream[i]);
    }
}

void UTIL_MallocMem(){
    cudaMalloc(&A, sizeof(DATATYPE)*SIZE);
}
void UTIL_FreeMem(){
    cudaFree(A);
}


extern "C" void init(){
    UTIL_CreateStreams();
    UTIL_MallocMem();
}
extern "C" void end(){
    UTIL_deleteStreams();
    UTIL_FreeMem();
}

#define N_ITERATIONS (1024000)
__global__ void FFMA(DATATYPE *dst, DATATYPE half){
    DATATYPE a1 = 1;
    DATATYPE a2 = 2;
    DATATYPE a3 = 3;
    DATATYPE a4 = 4;
    DATATYPE a5 = 5;
    DATATYPE a6 = 6;
    DATATYPE b = half+1;

    #pragma unroll 128
    for( int i = 0; i < N_ITERATIONS; i ++ )
    {
      a1 = a1*b+b;
      a2 = a2*b+b;
      a3 = a3*b+b;
      a4 = a4*b+b;
      a5 = a1*a3+a5;
      a6 = a2*a4+a6;
    }
    dst[threadIdx.x + blockDim.x*blockIdx.x] = a5+a6;
}

extern "C" void UTIL_None(int streamId){
    FFMA<<<1, 1, 0, UTIL_GPU_Stream[streamId]>>>(A, 0.5);
}

extern "C" int getUtilization()
{
    FILE * fp;
    char buffer[100];
    fp = popen("nvidia-smi | grep \"%\" | awk '{print $13}'","r");
    fgets(buffer, sizeof(buffer), fp);
    printf("GPU Utilization: %s", buffer);
    pclose(fp);
    return atoi(buffer);
}
