#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pkill mainboard 
cyber_launch start canbus_proxy.launch 1>/dev/null 2>&1
cyber_launch start controller.launch 1>/dev/null 2>&1

cd ${SCRIPT_ROOT}/../../rtk_tools
python recorder_path_cyber.py &
pid=$!
sleep 3
kill -TERM $pid
cd ${SCRIPT_ROOT}
echo "SUCCESSED"
