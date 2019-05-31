#!/bin/bash
grep -A 4 "position {" localization_pose >position
sed -i '/--/d' position
#sed -i '/z:/d' position
sed -i '/position {/d' position
sed -i '/}/d' position
sed -i 's/^[ \t]*//g' position
#grep "x:" position >position-x
#grep "y:" position >position-y
cat position | awk '{print $2}' >position1
sed -i 'N;N;s/\n/ /g' position1
