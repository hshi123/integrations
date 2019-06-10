#!/bin/bash

AOS_OK=0
AOS_ERR=1

usage() {
    echo "Usage: bash ${BAHS_SOURCE[0]} <start|stop|status>" >&2
    exit ${AOS_ERR}
}

if [ "$#" -ne 1 ]
then
    usage
fi

path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" && cd $path
killProcess() {
    for child in `ps --ppid $1 | grep -v PID | awk '{print $1}'`
    do
        killProcess "$child"
    done
    kill -9 $1
}
stop() {
    if [[ -e "./$0.pid" ]]; then
        source ./$0.pid
        killProcess ${pid} 2> /dev/null
        echo "INTERUPTED" >>$0.log
    fi
    check
    if [[ $? -eq ${AOS_OK} ]]; then
        return ${AOS_ERR}
    fi
    return ${AOS_OK}
}
start() {
    bash get_pose_obstacles.sh >$0.log 2>&1 &
    pid=$!
    echo "pid=$pid" >$0.pid
    return ${AOS_OK}
}
check() {
    if [[ -e "./$0.pid" ]]; then
        source ./$0.pid
        ps -ef | grep " $pid " | grep get_pose_obstacles.sh |grep -v grep > /dev/null
        return $?
    fi
    return ${AOS_ERR}
}

if [ "$1" = "stop" ];then
    stop
elif [ "$1" = "start" ];then
    stop
    sleep 3
    start
elif [ "$1" = "status" ]; then
    check
else
    usage
fi
exit $?
