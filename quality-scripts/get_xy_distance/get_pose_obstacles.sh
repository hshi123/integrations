#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#get pose1
LOCALIZATION_POSE_STATIC=localization_pose_static
POSE=pose
POSE1=pose1
OBSTACLES_STATIC=obstacles_static
OBSTACLES_POSITION=obstacles_position
OBSTACLES_POSITION1=obstacles_position1
cyber_channel echo /localization/100hz/localization_pose >${SCRIPT_ROOT}/${LOCALIZATION_POSE_STATIC} &
pid1=$!
cyber_channel echo /perception/obstacles >${SCRIPT_ROOT}/${OBSTACLES_STATIC} &
pid2=$!
sleep 60
if [ ! -s ${LOCALIZATION_POSE_STATIC} ]
then
    echo "Error: there is no data in /localization/100hz/localization_pose,please check the channel"
    return $?
fi
if [ ! -s ${OBSTACLES_STATIC} ]
then
    echo "Error: there is no data in /perception/obstacles,please check the channel"
    return $?
fi
kill -TERM $pid1
kill -TERM $pid2
grep -A 4 "position {" ${LOCALIZATION_POSE_STATIC} >"${POSE}"
sed -i '/--/d' ${POSE}
sed -i '/z:/d' ${POSE}
sed -i '/position {/d' ${POSE}
sed -i '/}/d' ${POSE}
sed -i 's/^[ \t]*//g' ${POSE}
cat ${POSE} | awk '{print $2}' >${POSE1}
sed -i 'N;s/\n/ /g' ${POSE1}
#get obstacles position
sed -i '/polygon_point/,+4d' ${OBSTACLES_STATIC}
sed -i '/position_covariance:/d' ${OBSTACLES_STATIC}
sed -i '/velocity_covariance:/d' ${OBSTACLES_STATIC}
sed -i '/acceleration_covariance:/d' ${OBSTACLES_STATIC}
sed -i '/anchor_point {/,+4d' ${OBSTACLES_STATIC}
sed -i '/bbox2d {/,+5d' ${OBSTACLES_STATIC}
sed -i '/light_status {/,+7d' ${OBSTACLES_STATIC}
sed -i '/height_above_ground:/d' ${OBSTACLES_STATIC}
sed -i '/brake_light:/d' ${OBSTACLES_STATIC}
sed -i '/acceleration {/,+4d' ${OBSTACLES_STATIC}
sed -i '/box {/,+5d' ${OBSTACLES_STATIC}
sed -i '/measurements {/,+18d' ${OBSTACLES_STATIC}
cat ${OBSTACLES_STATIC} |grep -B 19 "sub_type: CAR" | grep -A 3 "position {" >${OBSTACLES_POSITION}
sed -i '/--/d' ${OBSTACLES_POSITION}
sed -i '/position {/d' ${OBSTACLES_POSITION}
sed -i '/z:/d' ${OBSTACLES_POSITION}
cat ${OBSTACLES_POSITION} | awk -F ":" '{print $2}'| awk '{print $1}' >${OBSTACLES_POSITION1}
sed -i 'N;s/\n/ /g' ${OBSTACLES_POSITION1}

python get_xy_distance.py 
