#ifndef __KERNEL_H_
#define __KERNEL_H_

// initilization
extern "C" void init();

// free buffer
extern "C" void end();

// ffma kernel
extern "C" void UTIL_None(int streamId);

// Get GPU Utilization
extern "C" int getUtilization();
#endif
