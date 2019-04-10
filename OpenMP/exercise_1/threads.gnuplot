#!/usr/bin/gnuplot
reset
datafile = "static.dat"
set title "STREAM benchmark for the copy kernel"
set xlabel "Number of Threads"
set ylabel "Bandwidth (MB/s)"
set offsets 0.1, 0.1, 0, 0
set terminal png
set style data linespoints
plot datafile using (log($1)):2:3:xtic(1) with yerrorbars notitle
