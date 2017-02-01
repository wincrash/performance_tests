#!/bin/bash

cp HPL_DAT/1x4.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots -np 4   xhpl_sequental
cp HPL_DAT/1x8.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots_8 -np 8   xhpl_sequental


cp HPL_DAT/2x4.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots -np 8   xhpl_sequental
cp HPL_DAT/2x8.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots_8 -np 16   xhpl_sequental


cp HPL_DAT/3x4.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots -np 12   xhpl_sequental
cp HPL_DAT/3x8.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots_8 -np 24   xhpl_sequental


cp HPL_DAT/4x4.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots -np 16   xhpl_sequental
cp HPL_DAT/4x8.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots_8 -np 32   xhpl_sequental


cp HPL_DAT/5x4.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots -np 20   xhpl_sequental
cp HPL_DAT/5x8.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots_8 -np 40   xhpl_sequental

mkdir -p sequental

mv *.out sequental


cp HPL_DAT/1x4.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots -np 4   xhpl
cp HPL_DAT/1x8.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots_8 -np 8   xhpl


cp HPL_DAT/2x4.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots -np 8   xhpl
cp HPL_DAT/2x8.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots_8 -np 16   xhpl


cp HPL_DAT/3x4.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots -np 12   xhpl
cp HPL_DAT/3x8.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots_8 -np 24   xhpl


cp HPL_DAT/4x4.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots -np 16   xhpl
cp HPL_DAT/4x8.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots_8 -np 32   xhpl


cp HPL_DAT/5x4.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots -np 20   xhpl
cp HPL_DAT/5x8.dat HPL.dat
mpirun   --allow-run-as-root  --hostfile hosts_slots_8 -np 40   xhpl

mkdir -p not_sequental

mv *.out not_sequental
