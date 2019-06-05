#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_ROOT}/../common/log_function.sh
cyber_channel echo /pnc/carstatus > ${SCRIPT_ROOT}/carstatus &
sleep 1
pid1=$!
echo "pid1=$pid1" >$0.pid1
cyber_channel echo /perception/obstacles > ${SCRIPT_ROOT}/obstacles-static &
sleep 1
pid2=$!
echo "pid2=$pid2" >$0.pid2
#ps -ef | grep "cyber_channel echo " | grep -v "grep" | awk '{print $2}' |xargs kill
if [ ! -s carstatus ]
then
        echo "请检查/pnc/carstatus是否有输出"
    fi
if [ ! -s obstacles-static ]
then
        echo "请检查/erception/obstacles是否有输出"
    fi
