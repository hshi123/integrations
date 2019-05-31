#!/bin/bash

dir_path=$(cd `dirname $0`; pwd )
cyber_channel hz /pnc/carstatus &
if [ $? -eq 0 ]
then
    cyber_channel echo /pnc/carstatus >>$dir_path/carstatus &
    sleep 60
    ps -ef | grep "cyber_channel echo /pnc/carstatus" | grep -v "grep" |awk '{print $2}' | xargs kill
else
    echo "Please check /pnc/carstatus"
fi
cat carstatus | grep yaw: | awk -F ":" '{print $2}' | awk '{print $1}' >yaw
