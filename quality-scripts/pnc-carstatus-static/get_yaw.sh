#!/bin/bash
dir_path=$(cd `dirname $0`; pwd )
cat carstatus | grep yaw: | awk -F ":" '{print $2}' | awk '{print $1}' >yaw
k=0
for i in $(cat yaw)
do 
    if [ `echo $i | awk -v tem=0 '{print($1<tem)? "1":"0"}'` -eq "0" ]
    then
        let i=0-$i
        echo $i
    fi
    if [ `echo "$i > 5" | bc` -eq 1 ]
    then
        ((k++))
        while [ $k -ge 3 ]
        do
            break
        done
    fi
done
echo $k
if [ $k -le 20 ]
then
    echo "OK"
else
    echo "静态角度过大"
fi
