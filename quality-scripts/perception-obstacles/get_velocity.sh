#!/bin/bash
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#sed -i '/acceleration_covariance:/d' obstacles1


#grep -A 163 "perception_obstacle {" obstacles1 >obstacles2
sed -i '/polygon_point/,+4d' obstacles1
sed -i '/position_covariance:/d' obstacles1
sed -i '/velocity_covariance:/d' obstacles1
sed -i '/acceleration_covariance:/d' obstacles1
sed -i '/anchor_point {/,+4d' obstacles1
sed -i '/bbox2d {/,+5d' obstacles1
sed -i '/light_status {/,+7d' obstacles1
sed -i '/height_above_ground:/d' obstacles1
sed -i '/brake_light:/d' obstacles1
sed -i '/acceleration {/,+4d' obstacles1
sed -i '/box {/,+5d' obstacles1
sed -i '/measurements {/,+18d' obstacles1
grep -B 19 "sub_type: CAR" obstacles1 >obstacles2



#need Determine which is the obstacle vehicle?




# Get vehicle location information and speed information
grep -A 2 "position {" obstacles2 >position
grep -A 3 "velocity {" obstacles2 >velocity

sed -i '/--/d' velocity
sed -i '/velocity {/d' velocity
cat velocity |awk -F ":" '{print $2}'|awk '{print $1}' >velocity1
sed -i 'N;N;s/\n/ /g' velocity1
