#!/usr/bin/gnuplot
reset
datafile = "chunk-size.dat"
set title "STREAM benchmark for various chunk sizes for dynamic scheduling"
set xlabel "Chunk Size"
set xtics rotate 
set logscale y
set ylabel "Bandwidth (MB/s)"
set offsets 1, 1, 0, 0
set terminal png
plot datafile using log(1):2:3:xtic(1) with yerrorbars notitle
