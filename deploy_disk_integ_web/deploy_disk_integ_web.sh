#!/usr/bin/env bash

if [ ! -e "integration-integ-web" ]; then
    echo "No integratino-integ-web directory here"
    exit 1
fi
if [ ! -e $1 ] || [ $# -eq 0 ]; then
    echo "Please input options like \"/dev/sdb1\""
    exit 1
fi

#copy integration-integ-web
#rsync -av integration-integ-web post_install_content "$1/"

#modify initrd.lz
cd $1/casper
mkdir tmp_initrd
cd tmp_initrd
cp ../initrd.lz .
mv initrd.lz initrd.lzma
lzma -dvfk initrd.lzma
mkdir decompressed_initrd
cd decompressed_initrd
cpio -idvm < ../initrd
sed -i "/rsync/r $1/post_install_content" "$1/casper/tmp_initrd/decompressed_initrd/init"
find . | cpio -oH newc > initrd
mv initrd ..
cd ..
lzma -zvfk9 initrd
mv initrd.lzma ../initrd.lz
cd ..
#rm -rf tmp_initrd
