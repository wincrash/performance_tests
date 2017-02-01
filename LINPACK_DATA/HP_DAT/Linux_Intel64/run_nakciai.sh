#!/bin/bash

mpirun -np 20 --allow-run-as-root  --hostfile hosts_slots ./xhpl

