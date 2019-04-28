#!/bin/bash


dir_path=$(cd `dirname $0`; pwd)
carid=`cat /home/caros/adu/car-env.sh | awk '{print $2}' | awk -F "=" '{print $2}'`
echo $dir_path
echo $carid
rm -rf /home/caros/ros/share/params/*yaml
rm -rf /home/caros/ros/share/params/*txt
params_date=`otaclient -s params-$carid-pioneer | grep $carid | awk -F "|" '{ print $3 }' | awk '{print $1}' | sed -n '1p'`
echo $params_date | grep "^*"
if [ $? -eq 0 ]
	then
	params_date1=`echo $params_date | awk -F "*" '{print $2}'`
	otaclient -i params-$carid-pioneer\,$params_date1
	else 
	otaclient -i params-$carid-pioneer\,$params_date
fi

otaclient -i intensitymap-HaiDianJiaXiao-XiaoYuan-pioneer,1.5.0.4
otaclient -i hdmap-HaiDianJiaXiao-XiaoYuan-pioneer,1.5.7.3

