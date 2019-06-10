#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCALIZATION_POSE=localization_pose
POSITION=position
POSITION1=position1
cyber_channel echo /localization/100hz/localization_pose >${SCRIPT_ROOT}/${LOCALIZATION_POSE} &
pid=$!
sleep 180
kill -TERM $pid
if [ ! -s ${LOCALIZATION_POSE} ]
then
    echo "Error: there is no data in /localization/100hz/localization_pose,please check the channel"
    return $?
fi
grep -A 4 "position {" ${LOCALIZATION_POSE} >${POSITION}
sed -i '/--/d' ${POSITION}
sed -i '/position {/d' ${POSITION}
sed -i '/}/d' ${POSITION}
sed -i 's/^[ \t]*//g' ${POSITION}
cat ${POSITION} | awk '{print $2}' >${POSITION1}
sed -i 'N;N;s/\n/ /g' ${POSITION1}
python get_max_distance.py 
