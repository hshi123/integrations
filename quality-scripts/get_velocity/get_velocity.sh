#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
function get_velocity() {
cyber_channel echo /perception/obstacles > ${SCRIPT_ROOT}/obstacles &
OBTACLES=obstacles
pid=$!
sleep 10
kill -TERM $pid
if [ ! -s ${OBTACLES} ]
then
    echo "请检查/perception/obstacles是否有输出"
fi
cp obstacles obstacles1
sed -i '/polygon_point/,+4d' obstacles1
sed -i '/position_covariance:/d' obstacles1
sed -i '/velocity_covariance:/d' obstacles1
sed -i '/acceleration_covariance:/d' obstacles1
sed -i '/anchor_point {/,+4d' obstacles1
sed -i '/bbox2d {/,+5d' obstacles1
sed -i '/light_status {/,+7d' obstacles1
sed -i '/height_above_ground:/d' obstacles1
sed -i '/brake_light:/d' obstacles1
sed -i '/acceleration {/,+4d' obstacles1
sed -i '/box {/,+5d' obstacles1
sed -i '/measurements {/,+18d' obstacles1
grep -B 19 "sub_type: CAR" obstacles1 >obstacles2

#need Determine which is the obstacle vehicle?
# Get vehicle location information and speed information
grep -A 3 "velocity {" obstacles2 >velocity
sed -i '/--/d' velocity
sed -i '/velocity {/d' velocity
cat velocity |awk -F ":" '{print $2}'|awk '{print $1}' >velocity1
sed -i 'N;N;s/\n/ /g' velocity1

python get_velocity.py >$0.log &
pid=$!
echo "pid=$pid" >$0.pid
}
case $1 in
    start)
        get_velocity 
        ;;
    stop)
        source ${SCRIPT_ROOT}/$0.pid
        kill -TERM ${pid}
        ;;
    status)
        source ${SCRIPT_ROOT}/$0.pid
        ps -ef | grep $pid
        echo $?
        ;;
    *)
        echo "Usage: bash ${BASH_SOURCE[0]} start|stop|status"
        ;;
esac
