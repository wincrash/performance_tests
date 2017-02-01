#!/bin/bash
# paleidimas
# curl http://uig.grid.vgtu.lt:8282/testai/cloud_testas.sh >cloud_testas.sh
# chmod +x cloud_testas.sh
# ./cloud_testas.sh
wget http://uig.grid.vgtu.lt:8282/testai/iozone3_405.tar
wget http://uig.grid.vgtu.lt:8282/testai/stream.c
wget http://uig.grid.vgtu.lt:8282/testai/pbzip2-1.1.6.tar.gz
wget http://uig.grid.vgtu.lt:8282/testai/pbzip2_run.sh


gcc -O2 -DSTREAM_ARRAY_SIZE=30000000 -fopenmp stream.c -o stream-bin
#mv a.out stream-bin


tar xf iozone3_405.tar
cd iozone3_405/src/current
make linux-AMD64
cd ../../../



tar xzf pbzip2-1.1.6.tar.gz
cd pbzip2-1.1.6
make
cd ..



sleep 3
./iozone3_405/src/current/iozone -e -r 4k -s 512M -i0 -i1 >main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 4k -s 512M -i0 -i1 >>main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 4k -s 512M -i0 -i1 >>main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 4k -s 512M -i0 -i1 >>main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 4k -s 512M -i0 -i1 >>main_iozone.txt


sleep 3
./iozone3_405/src/current/iozone -e -r 64k -s 512M -i0 -i1 >>main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 64k -s 512M -i0 -i1 >>main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 64k -s 512M -i0 -i1 >>main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 64k -s 512M -i0 -i1 >>main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 64k -s 512M -i0 -i1 >>main_iozone.txt

sleep 3
./iozone3_405/src/current/iozone -e -r 1024k -s 512M -i0 -i1 >>main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 1024k -s 512M -i0 -i1 >>main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 1024k -s 512M -i0 -i1 >>main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 1024k -s 512M -i0 -i1 >>main_iozone.txt
sleep 3
./iozone3_405/src/current/iozone -e -r 1024k -s 512M -i0 -i1 >>main_iozone.txt




##./iozone3_405/src/current/iozone -e -r 4k -s 512M -i0 -i1 >volume_iozone.txt
##./iozone3_405/src/current/iozone -e -r 4k -s 512M -i0 -i1 >>volume_iozone.txt
##./iozone3_405/src/current/iozone -e -r 4k -s 512M -i0 -i1 >>volume_iozone.txt
##./iozone3_405/src/current/iozone -e -r 4k -s 512M -i0 -i1 >>volume_iozone.txt
##./iozone3_405/src/current/iozone -e -r 4k -s 512M -i0 -i1 >>volume_iozone.txt




##cat volume_iozone.txt | grep "524288       4"| awk '{print $3}' >colume_write.txt
##cat volume_iozone.txt | grep "524288       4"| awk '{print $5}' >volume_read.txt



sleep 3
hdparm -Tt /dev/vda >main.txt
sleep 3
hdparm -Tt /dev/vda >>main.txt
sleep 3
hdparm -Tt /dev/vda >>main.txt
sleep 3
hdparm -Tt /dev/vda >>main.txt
sleep 3
hdparm -Tt /dev/vda >>main.txt


##hdparm -Tt /dev/vdb >volume.txt
##hdparm -Tt /dev/vdb >>volume.txt
##hdparm -Tt /dev/vdb >>volume.txt
##hdparm -Tt /dev/vdb >>volume.txt
##hdparm -Tt /dev/vdb >>volume.txt

sleep 3
./stream-bin >out1.txt
sleep 3
./stream-bin >out2.txt
sleep 3
./stream-bin >out3.txt
sleep 3
./stream-bin >out4.txt
sleep 3
./stream-bin >out5.txt




dd if=/dev/urandom of=compressfile bs=1M count=256
chmod +x pbzip2_run.sh

sleep 3
perf stat -r 5 ./pbzip2_run.sh  2>pbzip2.txt















###############

cat out1.txt | grep "Copy:" >copy.txt
cat out2.txt | grep "Copy:" >>copy.txt
cat out3.txt | grep "Copy:" >>copy.txt
cat out4.txt | grep "Copy:" >>copy.txt
cat out5.txt | grep "Copy:" >>copy.txt

cat out1.txt | grep "Scale:" >scale.txt
cat out2.txt | grep "Scale:" >>scale.txt
cat out3.txt | grep "Scale:" >>scale.txt
cat out4.txt | grep "Scale:" >>scale.txt
cat out5.txt | grep "Scale:" >>scale.txt

cat out1.txt | grep "Add:" >add.txt
cat out2.txt | grep "Add:" >>add.txt
cat out3.txt | grep "Add:" >>add.txt
cat out4.txt | grep "Add:" >>add.txt
cat out5.txt | grep "Add:" >>add.txt

cat out1.txt | grep "Triad:" >triad.txt
cat out2.txt | grep "Triad:" >>triad.txt
cat out3.txt | grep "Triad:" >>triad.txt
cat out4.txt | grep "Triad:" >>triad.txt
cat out5.txt | grep "Triad:" >>triad.txt





###strean rez
awk '{ total += $2; count++ } END { print total/count }' copy.txt >RAM_rez.txt
awk '{ total += $2; count++ } END { print total/count }' scale.txt >>RAM_rez.txt
awk '{ total += $2; count++ } END { print total/count }' add.txt >>RAM_rez.txt
awk '{ total += $2; count++ } END { print total/count }' triad.txt >>RAM_rez.txt









#//hd param rez
cat main.txt | grep "Timing cached reads" |  awk '{print $10}'>cache_read.txt
cat main.txt | grep "Timing buffered disk reads" |  awk '{print $11}' >buffered_read.txt
awk '{ total += $1; count++ } END { print total/count }' cache_read.txt >HDParm_rez.txt
awk '{ total += $1; count++ } END { print total/count }' buffered_read.txt >>HDParm_rez.txt



#//iozone rez

cat main_iozone.txt | grep "524288       4"| awk '{print $5}' >main_read_4.txt
cat main_iozone.txt | grep "524288      64"| awk '{print $5}' >main_read_64.txt
cat main_iozone.txt | grep "524288    1024"| awk '{print $5}' >main_read_1024.txt

cat main_iozone.txt | grep "524288       4"| awk '{print $3}' >main_write_4.txt
cat main_iozone.txt | grep "524288      64"| awk '{print $3}' >main_write_64.txt
cat main_iozone.txt | grep "524288    1024"| awk '{print $3}' >main_write_1024.txt


awk '{ total += $1; count++ } END { print (total/count)/1024 }' main_read_4.txt >iozone_rez.txt
awk '{ total += $1; count++ } END { print (total/count)/1024 }' main_read_64.txt >>iozone_rez.txt
awk '{ total += $1; count++ } END { print (total/count)/1024 }' main_read_1024.txt >>iozone_rez.txt
awk '{ total += $1; count++ } END { print (total/count)/1024 }' main_write_4.txt >>iozone_rez.txt
awk '{ total += $1; count++ } END { print (total/count)/1024 }' main_write_64.txt >>iozone_rez.txt
awk '{ total += $1; count++ } END { print (total/count)/1024 }' main_write_1024.txt >>iozone_rez.txt




##// pbzip2 rez

sed 's/,/./g' pbzip2.txt | grep "seconds time elapsed" | awk '{print $1}' >pbzip2_rez.txt





##bendri rez
cat HDParm_rez.txt>Bendri_rez.txt
cat iozone_rez.txt>>Bendri_rez.txt
echo "">>Bendri_rez.txt
cat RAM_rez.txt>>Bendri_rez.txt
echo "">>Bendri_rez.txt
cat pbzip2_rez.txt>>Bendri_rez.txt






