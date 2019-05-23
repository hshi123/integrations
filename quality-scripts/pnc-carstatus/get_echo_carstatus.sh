#!/bin/bash

dir_path=$(cd `dirname $0`; pwd )
cyber_channel hz /pnc/carstatus &
if [ $? -eq 0 ]
then
    cyber_channel echo /pnc/carstatus >>$dir_path/carstatus &
    sleep 300
    ps -ef | grep "cyber_channel echo /pnc/carstatus" | grep -v "grep" |awk '{print $2}' | xargs kill
else
    print "Please check /pnc/carstatus"
fi
