#!/bin/bash
echo -e "[sch]\t[mean]\t[\xCF\x83]"
threads=32
for S in static dynamic guided
do
    arr=()
    for I in 1 2 3 4 5
    do
        output=`OMP_SCHEDULE=$S OMP_NUM_THREADS=$threads ./stream.out | grep Copy:`
        output=($output)
        bandwidth=${output[1]}
        arr+=($bandwidth)
    done
    mean=`echo "${arr[@]}" | awk '{for(i=1;i<=NF;i++){sum+=$i};print sum/NF}'`
    std=`echo "${arr[@]}" | awk -vM=$mean '{for(i=1;i<=NF;i++){sum+=($i-M)*($i-M)};print sqrt(sum/NF)}'`
    echo -e "${S}\t${mean}\t${std}"
done
