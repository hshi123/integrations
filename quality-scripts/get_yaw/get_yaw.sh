#!/bin/bash
dir_path=$(cd `dirname $0`; pwd )
cyber_channel echo /pnc/carstatus >${dir_path}/carstatus &
pid1=$!
sleep 180
if [ ! -s carstatus ]
then
    echo "Error: there is no data in /pnc/carstatus,please check the channel"
    return $?
fi
kill -TERM $pid1
cat carstatus | grep yaw: | awk -F ":" '{print $2}' | awk '{print $1}' >yaw

python get_yaw.py 

