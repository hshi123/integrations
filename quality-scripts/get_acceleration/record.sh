#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_ROOT}/../common/log_function.sh
cyber_channel echo /pnc/carstatus > ${SCRIPT_ROOT}/carstatus &
#sleep 10 &
pid=$!
echo "pid=$pid" >$0.pid
#sleep 2
if [ ! -s carstatus ]
then
    echo "请检查/pnc/carstatus是否有输出"
fi

