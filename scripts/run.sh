#!/bin/bash
export LD_LIRBRARY_PATH=/opt/intel/compilers_and_libraries_2017.0.098/linux/mpi/intel64/lib/
export PATH=/opt/intel/compilers_and_libraries_2017.0.098/linux/mpi/intel64/bin/:$PATH


proc=1
for x in *.$proc
do
echo "mpirun -np $proc ./$x"
mpirun -np $proc ./$x >$x.txt
done


proc=2
for x in *.$proc
do
echo "mpirun -np $proc ./$x"
mpirun -np $proc ./$x >$x.txt
done



proc=4
for x in *.$proc
do
echo "mpirun -np $proc ./$x"
mpirun -np $proc ./$x >$x.txt
done


proc=8
for x in *.$proc
do
echo "mpirun -np $proc ./$x"
mpirun -np $proc ./$x >$x.txt
done
