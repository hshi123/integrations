#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cyber_channel echo /perception/obstacles > ${SCRIPT_ROOT}/obstacles &
pid=$!
OBTACLES=obstacles
sleep 10
kill -TERM $pid
if [ ! -s ${OBTACLES} ]
then
    echo "Error: there is no data in /perception/obtacles,please check the channel"
    return $?
fi
sed -i '/polygon_point/,+4d' obstacles
sed -i '/position_covariance:/d' obstacles
sed -i '/velocity_covariance:/d' obstacles
sed -i '/acceleration_covariance:/d' obstacles
sed -i '/anchor_point {/,+4d' obstacles
sed -i '/bbox2d {/,+5d' obstacles
sed -i '/light_status {/,+7d' obstacles
sed -i '/height_above_ground:/d' obstacles
sed -i '/brake_light:/d' obstacles
sed -i '/acceleration {/,+4d' obstacles
sed -i '/box {/,+5d' obstacles
sed -i '/measurements {/,+18d' obstacles
grep -B 19 "sub_type: CAR" obstacles >obstacles2

#need Determine which is the obstacle vehicle?
# Get vehicle location information and speed information
grep -A 3 "velocity {" obstacles2 >velocity
sed -i '/--/d' velocity
sed -i '/velocity {/d' velocity
cat velocity |awk -F ":" '{print $2}'|awk '{print $1}' >velocity1
sed -i 'N;N;s/\n/ /g' velocity1
python get_velocity.py 
