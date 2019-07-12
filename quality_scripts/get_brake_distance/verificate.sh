#!/bin/bash
#grep -A 1 "perception_obstacle {" obstacles | grep -v "perception_obstacle" | grep id:|awk -F ":" '{print $2}' | awk '{print $1}'  | sort |uniq -c | sort -n
obstaclesid=`grep -A 1 "perception_obstacle {" obstacles | grep -v "perception_obstacle" | grep id:|awk -F ":" '{print $2}' | awk '{print $1}'  | sort |uniq -c | sort -n |tail -n 1 | awk '{print $2}'`
echo $obstaclesid
