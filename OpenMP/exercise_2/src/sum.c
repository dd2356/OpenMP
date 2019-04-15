#include "sum.h"

void omp_sum(double *sum_ret)
{
	double sum = 0;
    #pragma omp parallel for
	for (int i = 0; i < size; i++){
		sum += x[i];
	}
	*sum_ret = sum;
}

void omp_critical_sum(double *sum_ret)
{
	double sum = 0;
    #pragma omp parallel for
	for (int i = 0; i < size; i++){
        #pragma omp critical
		sum += x[i];
	}
	*sum_ret = sum;
}

void omp_atomic_sum(double *sum_ret)
{
	double sum = 0;
    #pragma omp parallel for
	for (int i = 0; i < size; i++){
        #pragma omp atomic
		sum += x[i];
	}
	*sum_ret = sum;
}

void omp_local_sum(double *sum_ret)
{
    int threads = omp_get_max_threads(); 
    double sum[threads]; 
    for (int i = 0; i < threads; i++) sum[i]=0; 
    #pragma omp parallel for
    for (int i = 0; i < size; i++){
        int tid = omp_get_thread_num(); 
        sum[tid] += x[i];
    }
    *sum_ret = 0; 
    for (int i = 0; i < threads; i++) {
        *sum_ret += sum[i];
    }
}

void omp_padded_sum(double *sum_ret)
{
    int threads = omp_get_max_threads(); 
    double sum[threads*8]; 
    for (int i = 0; i < threads; i++) sum[i*8]=0; 
    #pragma omp parallel for
    for (int i = 0; i < size; i++){
        int tid = omp_get_thread_num(); 
        sum[tid*8] += x[i];
    }
    *sum_ret = 0; 
    for (int i = 0; i < threads; i++) {
        *sum_ret += sum[i*8];
    }
}

void omp_private_sum(double *sum_ret)
{
    int threads = omp_get_max_threads(); 
    double thread_sum;
    *sum_ret = 0; 

    #pragma omp parallel private(thread_sum)
    {
        int tid = omp_get_thread_num();
        for (int i = tid; i < size; i += threads){
            thread_sum += x[i];
        }
        #pragma omp critical
        *sum_ret += thread_sum;
    }
}

void omp_reduction_sum(double *sum_ret)
{
    *sum_ret = 0;
    double sum = 0;
    #pragma omp parallel for reduction(+ : sum)
    for (int i = 0; i < size; i++) {
        sum += x[i];
    }
    *sum_ret = sum;
}
