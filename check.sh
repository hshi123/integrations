#!/bin/bash
#check_cyber_channel_list
stty erase ^H
stty erase ^?
cmd="cyber_channel"

check_camera(){
  echo -e "\033[32m Check camera,check next one please use "CTRL+C"\033[0m"
  for i in $($cmd list | egrep "^/sensor.*compressed$");
    do
      $cmd hz $i;
    done
}

check_radar(){
  echo -e "\033[32m Check front and rear radar ,please wait...\033[0m"
  $cmd echo /sensor/frontradar/radardata >> /home/caros/front_radar_result &
  $cmd echo /sensor/rearradar/radardata >> /home/caros/rear_radar_result &
  sleep 10
  front_file_size=$(ls -l /home/caros/front_radar_result | awk '{print $5}')
  rear_file_size=$(ls -l /home/caros/rear_radar_result | awk '{print $5}')
    if [[ $front_file_size -gt 500 ]];then
      echo -e "\033[32m front radar is ok!\033[0m"
    else
      echo -e "\033[31m front radar is error!\033[0m"
    fi
    if [[ $rear_file_size -gt 500 ]];then
      echo -e "\033[32m rear radar is ok!\033[0m"
    else
      echo -e "\033[31m rear radar is error!\033[0m"
    fi
    #rm /home/caros/rear_radar_result
    #rm /home/caros/front_radar_result
}

check_velodyne(){
  echo -e "\033[32m Check velodyne and pointcloud2,please wait...\033[0m"
  $cmd list > /home/caros/cyber_channel_list 
  res=$(cat cyber_channel_list | egrep -o "velodyne[0-9]{2,3}" | head -n 1)
  $cmd echo /sensor/velodyne"${res:8}"/PointCloud2 >> /home/caros/velo"${res:8}"_pointcloud2 &
  $cmd echo /sensor/velodyne"${res:8}"/VelodyneScan >> /home/caros/velo"${res:8}"_scan &
 # $cmd echo /sensor/velodyne"${res:8}"/compensator/PointCloud2 >> /home/caros/compensator_pointcloud2 &
  sleep 10
  pointcloud2_size=$(ls -l /home/caros/velo"${res:8}"_pointcloud2 | awk '{print $5}')
  scan_size=$(ls -l /home/caros/velo"${res:8}"_scan | awk '{print $5}')
  #compensator_size=$(ls -l /home/caros/compensator_pointcloud2 | awk '{print $5}')
    if [[ $pointcloud2_size -gt 500 ]];then
      echo -e "\033[32m /sensor/velodyne"${res:8}"/PointCloud2 is ok!\033[0m"
    else
      echo -e "\033[31m /sensor/velodyne"${res:8}"/PointCloud2 is error\033[0m"
    fi
    if [[ $scan_size -gt 500 ]];then
      echo -e "\033[32m /sensor/velodyne"${res:8}"/VelodyneScan is ok!\033[0m"
    else
      echo -e "\033[31m /sensor/velodyne"${res:8}"/VelodyneScan is error\033[0m"
    fi
   # if [[ $compensator_size -gt 500 ]];then
   #   echo -e "\033[32m /sensor/velodyne"${res:8}"/compensator/PointCloud2 is ok!\033[0m"
   # else
   #   echo -e "\033[31m /sensor/velodyne"${res:8}"/compensator/PointCloud2 is error\033[0m"
   # fi
    #rm /home/caros/compensator_pointcloud2
    #rm /home/caros/velo"${res:8}"_pointcloud2
    #rm /home/caros/velo"${res:8}"_scan
    #rm /home/caros/cyber_channel_list
}

check_bestpos(){
  echo -e "\033[32m Check bestpos and inspva ,please wait...\033[0m"
  $cmd echo /sensor/novatel/bestpos > /home/caros/bestpos &
  $cmd echo /sensor/novatel/inspva > /home/caros/inspva &
  sleep 10
  result_bestpos=$(cat /home/caros/bestpos | grep -i "Position_type" | head -n 1)
  result_inspva=$(cat /home/caros/inspva | grep -i "ins_status" | head -n 1)
  echo -e "\033[32m novatel_bestpos\n $result_bestpos\033[0m"
  echo -e "\033[32m novatel_inspva\n $result_inspva\033[0m"
  #rm /home/caros/bestpos
  #rm /home/caros/inspva
}

kill_process(){
  ps aux | grep "$cmd echo /sensor/novatel/inspva" | grep -v "grep" |awk '{print $2 }' | xargs kill -9
  ps aux | grep "$cmd echo /sensor/novatel/bestpos" | grep -v "grep" |awk '{print $2 }' | xargs kill -9
  ps aux | grep "$cmd echo /sensor/velodyne"${res:8}"/PointCloud2" | grep -v "grep" | awk '{print $2}' | xargs kill -9
  ps aux | grep "$cmd echo /sensor/velodyne"${res:8}"/VelodyneScan" | grep -v "grep" |awk '{print $2}'| xargs kill -9
  ps aux | grep "$cmd echo /sensor/frontradar/radardata" | grep -v "grep" | awk '{print $2}' | xargs kill -9
  ps aux | grep "$cmd echo /sensor/rearradar/radardata" | grep -v "grep" | awk '{print $2}' | xargs kill -9
  ps aux | grep "$cmd echo /sensor/velodyne"${res:8}"/compensator/PointCloud2" | grep -v "grep" |awk '{print $2}'| xargs kill -9
  rm /home/caros/compensator_pointcloud2
  rm /home/caros/bestpos
  rm /home/caros/inspva
  rm /home/caros/velo"${res:8}"_pointcloud2
  rm /home/caros/velo"${res:8}"_scan
  rm /home/caros/cyber_channel_list
  rm /home/caros/rear_radar_result
  rm /home/caros/front_radar_result
}

while true
  do
  echo -e "\033[33m Check camera(hz) enter\033[0m \033[32m1;\033[0m" 
  echo -e "\033[33m Check radar(echo) enter\033[0m \033[32m2;\033[0m"
  echo -e "\033[33m Check velodyne(echo) and pointcloud2(echo) enter\033[0m \033[32m3;\033[0m"
  echo -e "\033[33m Check bestpos and inspva enter\033[0m \033[32m4;\033[0m"
  echo -e "\033[33m Check all enter\033[0m \033[32ma;\033[0m"
  echo -e "\033[33m Exit script please enter\033[0m \033[32mq;\033[0m"
  echo -n -e "\033[33m Please enter your choice\033[0m \033[32m(1/2/3/4/a/q):\033[0m" 
  read choice
    case $choice in
    1)
      check_camera
      exit 0
      ;;
    2)
      check_radar
      kill_process >/dev/null 2>&1
      exit 0
      ;;
    3)
      check_velodyne
      kill_process >/dev/null 2>&1
      exit 0
      ;;
    4)
      check_bestpos
      kill_process >/dev/null 2>&1
      exit 0
      ;;
    a | A)
      check_camera
      check_radar
      check_velodyne
      check_bestpos
      kill_process >/dev/null 2>&1
      exit 0
      ;;
    q | Q)
      echo -e "\033[33m Quit scripts\033[0m"
      exit 0 
      ;;
    *)
      echo -e "\033[31m Enter error!\033[0m"
      ;;
    esac
  done 
