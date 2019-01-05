#!/bin/bash
dir_path=$(cd `dirname $0`; pwd )
radar_front_name1=radar_front_novatel_extrinsics.yaml
radar_rear_name1=radar_rear_novatel_extrinsics.yaml
radar_front_name2=radar_front_extrinsics.yaml
radar_rear_name2=radar_rear_extrinsics.yaml
echo $dir_path
ls -d $dir_path/params/MKZ* >MKZ.txt
ls -d $dir_path/params/HQ*  >HQ.txt
for i in $(cat MKZ.txt)
do
    cd $i/latest
    if [ -f $radar_front_name1 ] || [ -f $radar_rear_name1 ]; then
        ln -s -f $radar_front_name1 $radar_front_name2
        ln -s -f $radar_rear_name1 $radar_rear_name2
        MKZ_path=`pwd`
        echo ${MKZ_path##*params/} >>$dir_path/modify_MKZ_radar_number.txt
    elif [ -f $radar_front_name2 ] || [ -f $radar_rear_name2 ]; then
        ln -s -f $radar_front_name2 $radar_front_name1
        ln -s -f $radar_rear_name2 $radar_rear_name1
        MKZ_path=`pwd`
        echo ${MKZ_path##*params/} >>$dir_path/modify_MKZ_radar_number.txt
    else
        MKZ_path=`pwd`
        echo ${MKZ_path##*params/} >>$dir_path/no_MKZ_radar_number.txt
            
    fi
done

cd $dir_path
for i in $(cat HQ.txt)
do
    cd $i/latest
    if [ -f $radar_front_name1 ] || [ -f $radar_rear_name1 ]; then
        ln -s -f $radar_front_name1 $radar_front_name2
        ln -s -f $radar_rear_name1 $radar_rear_name2
        MKZ_path=`pwd`
        echo ${MKZ_path##*params/} >>$dir_path/modify_HQ_radar_number.txt
    elif [ -f $radar_front_name2 ] || [ -f $radar_rear_name2 ]; then
        ln -s -f $radar_front_name2 $radar_front_name1
        ln -s -f $radar_rear_name2 $radar_rear_name1
        MKZ_path=`pwd`
        echo ${MKZ_path##*params/} >>$dir_path/modify_HQ_radar_number.txt
    else
        MKZ_path=`pwd`
        echo ${MKZ_path##*params/} >>$dir_path/no_HQ_radar_number.txt
            
    fi
done
