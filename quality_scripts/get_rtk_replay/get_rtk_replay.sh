#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd ${SCRIPT_ROOT}/../../rtk_tools
python player_path_cyber.py &
pid=$!
sleep 60
kill -TERM $pid
cd ${SCRIPT_ROOT}
echo "SUCCESSED"
