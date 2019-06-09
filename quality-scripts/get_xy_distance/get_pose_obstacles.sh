#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#get pose1
function get_xy_distance() {
LOCALIZATION_POSE_STATIC=localization_pose_static
POSE=pose
POSE1=pose1
OBSTACLES_STATIC=obstacles_static
#OBSTACLES_STATIC1=obstacles_static1
OBSTACLES_POSITION=obstacles_position
OBSTACLES_POSITION1=obstacles_position1
#cp localization_pose_static localization_pose_static1
cyber_channel echo /localization/100hz/localization_pose >${SCRIPT_ROOT}/${LOCALIZATION_POSE_STATIC} &
pid1=$!
cyber_channel echo /perception/obstacles >${SCRIPT_ROOT}/${OBSTACLES_STATIC} &
pid2=$!
sleep 60
if [ ! -s ${LOCALIZATION_POSE_STATIC} ]
then
    echo "请检查/localization/100hz/localization_pose是否有输出"
    exit 3
fi
if [ ! -s ${OBSTACLES_STATIC} ]
then
    echo "请检查/perception/obstacles是否有输出"
    exit 3
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
cp obstacles_static obstacles_static1
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

python get_xy_distance.py >$0.log &
pid=$!
echo "pid=$pid" >$0.pid
}
case $1 in 
    start)
        get_xy_distance
        ;;
    stop)
        source ${SCRIPT_ROOT}/$0.pid
        kill -TERM $pid
        ;;
    status)
        source ${SCRIPT_ROOT}/$0.pid
        ps -ef | grep $pid | grep -v grep >/dev/null
        echo $?
        ;;
    *)
        echo "Usage: bash ${BASH_SOURCE[0]} start|stop|status"
        ;;
esac
