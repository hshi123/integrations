#!/usr/bin/bash

file_dir=$(cd `dirname $0`;pwd)
cp $1/casper/initrd.lz $file_dir
mv initrd.lz initrd.lzma
lzma -dvfk initrd.lzma
mkdir decompressed_initrd
cd decompressed_initrd
cpio -idvm < ../initrd
sed -i "/rsync/r $file_dir/post_install_content" init
find . | cpio -oH newc > ../initrd
cd ..
lzma -zvfk9 initrd
mv initrd.lzma initrd.lz
cp initrd.lz $1/casper/

