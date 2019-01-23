#!/bin/bash

sudo -k
mima="caros"
echo $mima | sudo -S echo " " &> /dev/null
dir_sdb=`sudo blkid | grep vfat | awk -F ":" '{print $1}'`
sudo mount $dir_sdb /mnt
file_dir=$(cd `dirname $0`;pwd)
cp /mnt/casper/filesystem.squashfs $file_dir
cp filesystem.squashfs filesystem.squashfs.old


