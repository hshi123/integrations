#/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#source ${SCRIPT_ROOT}/../common/log_function.sh
case $1 in
    start)
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
