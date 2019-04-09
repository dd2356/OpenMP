#!/bin/bash
echo -e "[#thr]\t[mean]\t[\xCF\x83]"
for N in 1 2 4 8 16 32
do
    arr=()
    for I in 1 2 3 4 5
    do
        output=`OMP_NUM_THREADS=$N ./stream.out | grep Copy:`
        output=($output)
        bandwidth=${output[1]}
        arr+=($bandwidth)
    done
    mean=`echo "${arr[@]}" | awk '{for(i=1;i<=NF;i++){sum+=$i};print sum/NF}'`
    std=`echo "${arr[@]}" | awk -vM=$mean '{for(i=1;i<=NF;i++){sum+=($i-M)*($i-M)};print sqrt(sum/NF)}'`
    echo -e "${N}\t${mean}\t${std}"
done
