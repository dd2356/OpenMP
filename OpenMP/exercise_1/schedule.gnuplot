#!/usr/bin/gnuplot
reset
datafile = "schedules.dat"
set title "STREAM benchmark for different scheduling policies"
set xlabel "Scheduling policy"
set xtics rotate 
set ylabel "Bandwidth (MB/s)"
set offsets 1, 1, 0, 0
set terminal png
plot datafile using 0:2:3:xtic(1) with yerrorbars notitle
