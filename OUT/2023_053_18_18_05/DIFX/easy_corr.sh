#!/bin/bash
# author: Jakob Gruber, TU Wien
# bash scrip for correlation and fringe-fitting of simulated data
# correlation: DiFX
# fringe-fitting: fourfit
# 
# default setup: 
#   station label: S1,S2, 
#   experiment label: sim
#
# machines: rename user name in machines file according to the log in user name (e.g. jakob, jgruber1)
#
# v2d file: is provided by VieRDS, ajdust v2d settings if desired
# vex file: is provided by VieRDS, adjust vex file settings if desired
#
# difx2mark4: adjust frequency range if required/desired
#
# difx2fits: uncomment if you want to create a fits database

rm *.calc
rm *.input
rm *.flag
rm *.im
rm -r *.difx
rm -r 1234

errormon 3 &

vsum -s S1*.vdif > S1.filelist
vsum -s S2*.vdif > S2.filelist

cp DIFX/threads sim_1.threads
cp DIFX/machines machines

vex2difx sim.v2d

startCalcServer &
sleep 1

calcif2 sim_1.calc

mpirun -np 4 -machinefile machines mpifxcorr sim_1.input

difx2mark4 -b X 1000 20000 sim_1

fourfit -tx -bLW -m1 1234/SIM001 set pc_mode manual dr_win -100 100 sb_win -100000 100000 mb_win -100 100
#fourfit -tx -m1 -bLW 1234 set pc_mode manual

#difx2fits sim_1
