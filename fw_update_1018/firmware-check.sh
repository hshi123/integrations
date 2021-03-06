#!/bin/bash
file_dir=$(cd `dirname $0`;pwd)

#file_dir=/home/caros/fw_update_1018
cd /dev
ls video* >/$file_dir/videolist
for i in $(ls /dev/video*)
do 
$HOME/plat-sw/bin/adv_cam_tool -d $i -r reg=8002 > /$file_dir/reg8002 2>/dev/null
$HOME/plat-sw/bin/adv_cam_tool -d $i -r reg=8000 > /$file_dir/reg8000 2>/dev/null
video8002=`cat $file_dir/reg8002 | grep "Camera register read" |awk -F "=" '{print $2}' |awk -F "x" '{print $2}'`
echo $i reg8002=${video8002}
video8000=`cat $file_dir/reg8000 | grep "Camera register read" |awk -F "=" '{print $2}' |awk -F "x" '{print $2}'`
echo "           " reg8000=${video8000}
done
