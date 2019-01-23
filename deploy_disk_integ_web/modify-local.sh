#!/bin/bash
sudo -k
mima="caros"
echo $mima | sudo -S echo " " &> /dev/null
cat /etc/rc.local | grep "bash run_autointeg_web.sh" 2>&1 >/dev/null
#cat rc.local | grep "bash run_autointeg_web.sh" 2>&1 >/dev/null
if [ $? -eq 1 ]
then
    for((i=1;i<6;i++)); 
    do 
    sudo sed -i '$d' /etc/rc.local
    done
    echo "已恢复完全"
else
    echo "没有找到相应项"
fi

