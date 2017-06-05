//-----------------------------------------------------------------------------
// GPU 上不支持的double类型函数的替代方法
//-----------------------------------------------------------------------------
//-----------------------------------
// double类型数据的原子加
//-----------------------------------
__device__ double atomicAdd(double* address, double val)
{
   	unsigned long long int* address_as_ull = (unsigned long long int*)address;
    	unsigned long long int old = *address_as_ull, assumed;

    	do {
        	assumed = old;
        	old = atomicCAS(address_as_ull, assumed, __double_as_longlong(val + __longlong_as_double(assumed)));

    	// Note: uses integer comparison to avoid hang in case of NaN (since NaN != NaN)
    	} while (assumed != old);

    	return __longlong_as_double(old);
}
//-----------------------------------
// float类型数据的原子加
//-----------------------------------
__device__ float atomicAdd(float* address, float val)
{
   	  unsigned int* address_as_ull = (unsigned int*)address;
    	unsigned int old = *address_as_ull, assumed;

    	do {
        	assumed = old;
        	old = atomicCAS(address_as_ull, assumed, __float_as_int(val + __int_as_float(assumed)));

    	// Note: uses integer comparison to avoid hang in case of NaN (since NaN != NaN)
    	} while (assumed != old);

    	return __int_as_float(old);
}
//-----------------------------------
// double类型数据的原子取最小值
//-----------------------------------
__device__ double atomicMin(double* address, double val)
{
    unsigned long long int* address_as_i = (unsigned long long int*) address;
    unsigned long long int old = *address_as_i, assumed;
    do {
        assumed = old;
        old = ::atomicCAS(address_as_i, assumed, __double_as_longlong(::fmin(val, __longlong_as_double(assumed))));
    } while (assumed != old);
    return __longlong_as_double(old);
}
//-----------------------------------
// float类型数据的原子取最小值
//-----------------------------------
__device__ float atomicMin(float* address, float val)
{
    int* address_as_i = (int*) address;
    int old = *address_as_i, assumed;
    do {
        assumed = old;
        old = ::atomicCAS(address_as_i, assumed, __float_as_int(::fminf(val, __int_as_float(assumed))));
    } while (assumed != old);
    return __int_as_float(old);
}
