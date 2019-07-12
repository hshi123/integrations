#!/bin/bash

AOS_OK=0
AOS_ERR=1

usage() {
    echo "Usage: bash ${BAHS_SOURCE[0]} <status>" >&2
    exit ${AOS_ERR}
}

if [ "$#" -ne 1 ]
then
    usage
fi

path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" && cd $path
check() {
    echo "" > $0.log
    grep "x(m)" ./result.sh.log > $0.log
    grep "Error" ./result.sh.log >> $0.log
    grep "INTERUPTED" ./result.sh.log >> $0.log
    grep "SUCCESSED" ./result.sh.log >> $0.log
    if [[ -e "./result.sh.pid" ]]; then
        source ./result.sh.pid
        ps -ef | grep " $pid " | grep get_pose_obstacles.sh |grep -v grep > /dev/null
        return $?
    fi
    return ${AOS_ERR}
}

if [ "$1" = "status" ]; then
    check
else
    usage
fi
exit $?
