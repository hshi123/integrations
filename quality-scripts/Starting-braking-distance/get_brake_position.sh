#/bin/bash

cp carstatus carstatus1
sed -i '/pose {/,+27d' carstatus1
sed -i '/msf_status {/,+13d' carstatus1
sed -i '/average_wheel_speed:/,+4d' carstatus1
grep -A 3 "brake_torque:" carstatus1 >brake_position
sed -i '/--/d' brake_position
cat brake_position | awk -F ":" '{print $2}' | awk '{print $1}' >brake_position1
sed -i 'N;N;N;s/\n/ /g' brake_position1
