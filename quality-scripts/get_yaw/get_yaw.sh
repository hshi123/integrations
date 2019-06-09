#!/bin/bash
dir_path=$(cd `dirname $0`; pwd )
function get_yaw() {
cyber_channel echo /pnc/carstatus >${dir_path}/carstatus &
pid1=$!
sleep 180
if [ ! -s carstatus ]
then
    echo "请检查/pnc/carstatus是否有输出"
    exit 3
fi
kill -TERM $pid1
cat carstatus | grep yaw: | awk -F ":" '{print $2}' | awk '{print $1}' >yaw

python get_yaw.py >$0.log &
pid=$!
echo "pid=$pid" >$0.pid
}
case $1 in 
    start)
        get_yaw
        ;;
    stop)
        source ${dir_path}/$0.pid
        kill -TERM ${pid}
        ;;
    status)
        source ${dir_path}/$0.pid
        ps -ef | grep $pid | grep -v grep > /dev/null
        echo $?
        ;;
    *)
        echo "Usage: bash ${BASH_SOURCE[0]} start|stop|status"
esac

