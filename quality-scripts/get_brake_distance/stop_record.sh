#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_ROOT}/record.sh.pid1
source ${SCRIPT_ROOT}/record.sh.pid2
echo $pid1
echo $pid2
kill -TERM $pid1
kill -TERM $pid2
