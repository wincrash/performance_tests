#!/bin/bash

sarasas=$(ls *.1 | awk -F. '{print $1"."$2}')
rm -rf *.REZ
for x in $sarasas
do
for y in 1 2 4 8 16 20
do
if [ !  -f $x.$y.txt ]; then
	echo $x.$y.txt
	echo "File not found!"
else

cat $x.$y.txt | grep "Mop/s total" | awk -v xx=$y '{print xx" "$4}' >>$x.REZ
fi
done

done
