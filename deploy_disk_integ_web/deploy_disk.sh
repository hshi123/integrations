#!/usr/bin/bash
sudo -k
mima="caros"
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
sed -i "/rsync -a \/mnt_iso\/umk\/ \/mnt_root\//r $file_dir/post_install_content" init
find . | cpio -oH newc > ../initrd
cd ..
lzma -zvfk9 initrd
mv initrd.lzma initrd.lz
sudo cp initrd.lz /mnt/casper/
sync
sudo umount /mnt
