#!/bin/bash

AOS_OK=0
AOS_ERR=1

STA_NOUSE=0
STA_DOING=1
STA_SUCES=2
STA_FAULT=3

usage() {
    echo "Usage: $0 <start|stop|status>" >&2
    exit ${AOS_ERR}
}

if [ "$#" -ne 1 ]
then
    usage
fi

path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" && cd $path

stop() {
    if [[ -e "./$0.pid" ]]; then
        source ./$0.pid
        kill -TERM ${pid} 2> /dev/null
    fi
    check
    if [[ $? -eq ${AOS_OK} ]]; then
        return ${AOS_ERR}
    fi
    return ${AOS_OK}
}
start() {
    bash run10s.sh >$0.log &
    pid=$!
    echo "pid=$pid" >$0.pid
    return ${AOS_OK}
}
check() {
    if [[ -e "./$0.pid" ]]; then
        source ./$0.pid
        ps -ef | grep " $pid " | grep run10s.sh |grep -v grep > /dev/null
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