#!/bin/bash

sudo -k
mima=$1
echo $mima | sudo -S echo " " &> /dev/null
dir_sdb=`sudo blkid | grep vfat | awk -F ":" '{print $1}'`
sudo mount $dir_sdb /mnt

file_dir=$(cd `dirname $0`;pwd)
cp /mnt/casper/initrd.lz $file_dir/initrd.lz.old
cp initrd.lz.old initrd.lzma
lzma -dvfk initrd.lzma
mkdir decompressed_initrd
cd decompressed_initrd
cpio -idvm < ../initrd
#sed -i "/rsync/r $file_dir/post_install_content" init
sed -i "/rsync -a \/rootfs\/ \/mnt_root\//r $file_dir/post_install_content" init
#sed -i "/rsync -a \/mnt_iso\/umk\/ \/mnt_root\//r post_install_content" init
find . | cpio -oH newc > ../initrd
cd ..
lzma -zvfk9 initrd
mv initrd.lzma initrd.lz
cp initrd.lz /mnt/casper/
cp -r integration-integ-web /mnt
rm -rf decompressed_initrd
rm initrd 
rm initrd.lz
sync
sudo umount /mnt
