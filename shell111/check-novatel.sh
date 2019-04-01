#!/bin/bash
declare -A dic
dic=([/sensor/novatel/CorrImu]="CorrImu" [/sensor/novatel/Heading]="Heading" [/sensor/novatel/Imu]="Imu" [/sensor/novatel/Odometry]="Odometry" [/sensor/novatel/bestgnsspos]="bestgnsspos" [/sensor/novatel/bestgnsspos]="bestgnsspos" [/sensor/novatel/bestpos]="bestpos" [/sensor/novatel/bestxyz]="bestxyz" [/sensor/novatel/corrimudata]="corrimudata" [/sensor/novatel/inspva]="inspva" [/sensor/novatel/rawimu]="rawimu")
for key in $(echo ${!dic[*]})
do
cyber_channel hz $key > `echo ${dic["$key"]}` &
done
