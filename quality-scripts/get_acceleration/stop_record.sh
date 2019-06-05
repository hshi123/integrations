#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_ROOT}/record.sh.pid
echo $pid
kill -TERM $pid
