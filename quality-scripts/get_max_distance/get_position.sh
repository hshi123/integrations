#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
function get_max_distance() {
LOCALIZATION_POSE=localization_pose
POSITION=position
POSITION1=position1
cyber_channel echo /localization/100hz/localization_pose >${SCRIPT_ROOT}/${LOCALIZATION_POSE} &
pid=$!
sleep 180
kill -TERM $pid
if [ ! -s ${LOCALIZATION_POSE} ]
then
    echo "请检查/localization/100hz/localization_pose是否有输出"
    exit 3
fi
grep -A 4 "position {" ${LOCALIZATION_POSE} >${POSITION}
sed -i '/--/d' ${POSITION}
sed -i '/position {/d' ${POSITION}
sed -i '/}/d' ${POSITION}
sed -i 's/^[ \t]*//g' ${POSITION}
cat ${POSITION} | awk '{print $2}' >${POSITION1}
sed -i 'N;N;s/\n/ /g' ${POSITION1}
python get_max_distance.py >$0.log &
pid1=$!
echo "pid1=$pid1" >$0.pid
}
case $1 in
    start)
        get_max_distance
        ;;
    stop)
        source ${SCRIPT_ROOT}/$0.pid
        kill -TERM ${pid1}
        ;;
    status)
        source ${SCRIPT_ROOT}/$0.pid
        ps -ef | grep $pid1 | grep -v grep >/dev/null
        echo $?
        ;;
    *)
        echo "Usage: bash ${BAHS_SOURCE[0]} start|stop|status"
        ;;
esac
