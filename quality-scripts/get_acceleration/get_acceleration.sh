#/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
case $1 in
    start)
        cyber_channel echo /pnc/carstatus > ${SCRIPT_ROOT}/carstatus &
        pid1=$!
        sleep 60
        if [ ! -s carstatus ]
        then
            echo "请检查/pnc/carstatus是否有输出"
            exit 3
        fi
        kill -TERM $pid1
        cat carstatus | grep acc:| awk -F ":" '{print $2}' | awk '{print $1}' >${SCRIPT_ROOT}/acceleration
        python get_max_acceleration.py >$0.log &
        pid=$!
        echo "pid=$pid" >$0.pid
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
        echo "Usage: bash ${BAHS_SOURCE[0]} start|stop|status"
        ;;
esac
