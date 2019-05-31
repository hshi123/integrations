#!/bin/bash
#cyber_channel echo /sensor/frontradar/radardata >frontradar &
cyber_channel echo /perception/obstacles >obstacles-static &
cyber_channel echo /localization/100hz/localization_pose >localization_pose-static &
cyber_channel echo /pnc/carstatus >carstatus &
sleep 60
ps -ef | grep "cyber_channel echo " | grep -v "grep" | awk '{print $2}' |xargs kill

