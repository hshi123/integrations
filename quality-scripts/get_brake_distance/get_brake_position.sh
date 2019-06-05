#/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#source ${SCRIPT_ROOT}/../common/log_function.sh
function get_brake_distance() {
CARSTATUS_FILE=carstatus1
BRAKE_POSITION=brake_position
BRAKE_POSITION1=brake_position1
OBSTACLES_FILE=obstacles1
OBSTACLES_FILE2=obstacles2
OBSTACLES_POSITION=obstacles_position
OBSTACLES_POSITION1=obstacles_position1
cp carstatus carstatus1
cp obstacles obstacles1
sed -i '/pose {/,+27d' ${CARSTATUS_FILE}
sed -i '/msf_status {/,+13d' ${CARSTATUS_FILE}
sed -i '/average_wheel_speed:/,+4d' ${CARSTATUS_FILE}
grep -A 3 "brake_torque:" ${CARSTATUS_FILE} >${BRAKE_POSITION}
sed -i '/--/d' ${BRAKE_POSITION}
cat ${BRAKE_POSITION} | awk -F ":" '{print $2}' | awk '{print $1}' >${BRAKE_POSITION1}
sed -i 'N;N;N;s/\n/ /g' ${BRAKE_POSITION1}
#get obstacles_car position
sed -i '/polygon_point/,+4d' ${OBSTACLES_FILE}
sed -i '/position_covariance:/d' ${OBSTACLES_FILE}
sed -i '/velocity_covariance:/d' ${OBSTACLES_FILE}
sed -i '/acceleration_covariance:/d' ${OBSTACLES_FILE}
sed -i '/anchor_point {/,+4d' ${OBSTACLES_FILE}
sed -i '/bbox2d {/,+5d' ${OBSTACLES_FILE}
sed -i '/light_status {/,+7d' ${OBSTACLES_FILE}
sed -i '/height_above_ground:/d' ${OBSTACLES_FILE}
sed -i '/brake_light:/d' ${OBSTACLES_FILE}
sed -i '/acceleration {/,+4d' ${OBSTACLES_FILE}
sed -i '/box {/,+5d' ${OBSTACLES_FILE}
sed -i '/measurements {/,+18d' ${OBSTACLES_FILE}
grep -B 19 "sub_type: CAR" ${OBSTACLES_FILE} >${OBSTACLES_FILE2}
grep -A 3 "position {" ${OBSTACLES_FILE2} >${OBSTACLES_POSITION}
sed -i '/--/d' ${OBSTACLES_POSITION}
sed -i '/position {/d' ${OBSTACLES_POSITION}
cat ${OBSTACLES_POSITION} | awk -F ":" '{print $2}' | awk '{print $1}' >${OBSTACLES_POSITION1}
sed -i 'N;N;s/\n/ /g' ${OBSTACLES_POSITION1}
python get_brake_distance.py  >$0.log &
pid=$!
echo "pid=$pid" >$0.pid
}
case $1 in
    start)
        get_brake_distance
        ;;
    stop)
        source ${SCRIPT_ROOT}/$0.pid
        kill -TERM ${pid}
        ;;
    status)
        source ${SCRIPT_ROOT}/$0.pid
        ps -ef | grep $pid | grep -v grep > /dev/null
        echo $?
        ;;
    *)
        echo "Usage: bash ${BASH_SOURCE[0]} start|stop|status"
        ;;
esac
