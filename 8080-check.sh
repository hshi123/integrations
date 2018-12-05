#!/bin/bash
#author v_shihui01@baidu.com
#Tel:16619803190

port=8080
sudo -k
mima="caros"
echo $mima | sudo -S echo " " &> /dev/null

#根据端口号查询对应的pid
pid=$(sudo netstat -nlp | grep :$port | awk '{print $7}' | awk -F"/" '{ print $1 }');

#杀掉对应的进程
#if [  -n  "$pid"  ]
#then
#    kill  -9  $pid
#    echo "port 8080  is using,now has been closed"
#else
#    echo "port 8080 is not using"
#
#    fi

if [ -n "$pid" ]
then
    sudo kill $(sudo lsof -t -i:8080)
    echo "port 8080  is using,now has been closed"
else
    echo "port 8080 is not using"

    fi
