#/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cyber_channel echo /pnc/carstatus > ${SCRIPT_ROOT}/carstatus &
pid1=$!
sleep 60
if [ ! -s carstatus ]
then
    echo "Error: there is no data in /pnc/carstatus,please check the channel"
    return $?
fi
kill -TERM $pid1
cat carstatus | grep acc:| awk -F ":" '{print $2}' | awk '{print $1}' >${SCRIPT_ROOT}/acceleration
python get_max_acceleration.py 
