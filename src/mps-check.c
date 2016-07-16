/***************************
 * a method by check file exist to 
 * check MPS is running.
 *
 * ************************/


#include <unistd.h>
#include <stdio.h>


int main()
{
    int result;
    const char *filename = "/tmp/nvidia-mps/control"; // only available if nvidia-cuda-mps-control daemon is running
    result = access (filename, F_OK); // F_OK tests existence also (R_OK,W_OK,X_OK).
                                      //            for readable, writeable, executable
    if (result == 0)
    {
       printf("%s MPS demon is running!!\n",filename);
    }
    else
    {
       printf("%s MPS demon doesn't exist!\n",filename);
    }
    return 0;
}
