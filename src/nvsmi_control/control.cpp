#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<omp.h>

#include"kernel.h"


int main(int argc, char *argv[]){
    init();
    int rate = 100;
    if(argc > 1)
        rate = atoi(argv[1]);
    if(rate > 100) 
        rate = 100;
    printf("Set utilization: %d\%\n", rate);
    long base = 10000 * 100 / rate;
    long delay = base;
    #pragma omp parallel num_threads(2)
    {
        int threadId = omp_get_thread_num();
        // thread0 is responsible for launch kernel
        if(threadId == 0){
            while(1){
                UTIL_None(1);
                usleep(delay);
            }
        }
        // thread1 is responsible to monitor the GPU utilization and adapt the waiting time
        // we want to use the last 100 times result to update the waiting time
        else{
            usleep(300000);
            int count = 0;
            long rate_sum = 0;
            while(1){
                int rate_t = getUtilization();
                rate_sum += rate_t;
                count++;
#ifdef SMOOTH
                if(count == 100){
                    int rate_avg = (int)((float)(rate_sum) / count);
                    long delay_t = base + (rate_avg - rate) * 1000;
                    if(abs(base-delay_t) < 10000)
                        delay = delay_t;
                    count = 0;
                    rate_sum = 0;
                }
#endif
                usleep(delay);
            }
        }
    }
    end();
    return 0;
}
