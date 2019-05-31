#!/bin/bash

#get pose1
grep -A 4 "position {" localization_pose-static1 >pose
sed -i '/--/d' pose
sed -i '/z:/d' pose
sed -i '/position {/d' pose
sed -i '/}/d' pose
sed -i 's/^[ \t]*//g' pose
cat pose | awk '{print $2}' >pose1
sed -i 'N;s/\n/ /g' pose1

#get obstacles position
sed -i '/polygon_point/,+4d' obstacles-static1
sed -i '/position_covariance:/d' obstacles-static1
sed -i '/velocity_covariance:/d' obstacles-static1
sed -i '/acceleration_covariance:/d' obstacles-static1
sed -i '/anchor_point {/,+4d' obstacles-static1
sed -i '/bbox2d {/,+5d' obstacles-static1
sed -i '/light_status {/,+7d' obstacles-static1
sed -i '/height_above_ground:/d' obstacles-static1
sed -i '/brake_light:/d' obstacles-static1
sed -i '/acceleration {/,+4d' obstacles-static1
sed -i '/box {/,+5d' obstacles-static1
sed -i '/measurements {/,+18d' obstacles-static1
cat obstacles-static1 |grep -B 19 "sub_type: CAR" | grep -A 3 "position {" >obstacles-position
sed -i '/--/d' obstacles-position
sed -i '/position {/d' obstacles-position
sed -i '/z:/d' obstacles-position
cat obstacles-position | awk -F ":" '{print $2}'| awk '{print $1}' >obstacles-position1
sed -i 'N;s/\n/ /g' obstacles-position1
