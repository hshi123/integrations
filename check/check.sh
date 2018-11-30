#!/bin/bash
#author v_shihui01@baidu.com
#Tel:16619803190

routerIP="192.168.10.1"
computeIP="192.168.10.6"
controlIP="192.168.10.7"
pp7IP="192.168.10.4"
velodyne128IP="192.168.20.13"
velodyne16IP="192.168.20.14"
extranet="www.baidu.com"
otaIP="180.149.145.158"

ipaddr="192.168.10.6"
passwd="caros"
user="caros"
intedir="/home/caros/Desktop"
testfile="integration-integ-web.tar.gz"

remote-cp-compute(){
    /usr/bin/expect <<-EOF
    spawn scp ${intedir}/${testfile} ${user}@${computeIP}:~
    expect {
    "yes/no"{send "yes\r";exp_continue}
    }
    expect "caros@192.168.10.6's password:"
    send "$passwd\r"
     
    set timeout 300
    expect 100%
    expect eof ;
                    
    spawn scp ${intedir}/8080-check.sh $user@${computeIP}:~
    expect "caros@192.168.10.6's password:"
    send "$passwd\r"
    expect 100%
    expect eof ;
    
    spawn ssh $user@${computeIP}
    expect "caros@192.168.10.6's passwd:"
    set timeout 3
    send "$passwd\r"
    expect '*]#'
    send "bash /home/caros/8080-check.sh"
    send "tar xvf $testfile\r"
    send "cd /home/caros/integration-integ-web/output/install\r"
    send "nohup bash run_autointeg_web.sh 2>&1 \r"
    interact
EOF
}

check-internet(){
    echo 'Please wait a moment!'
    num=100
    ping -c $num $otaIP > usenet.txt
    usenet=`cat usenet.txt |grep 'packet loss' | awk -F "," '{print $3}' | awk -F " " '{print $1}' | awk -F "%" '{print $1}'`
    delaynet=`cat usenet.txt | grep 'min/avg/max/mdev'`
    echo '网络丢包率(%): $usenet'
    echo '网络延迟: $delaynet'
    if [ $usenet -le 10 ]
    then
        echo 'The Internet is stable!!'
        remote-cp-compute
    else
        echo -e '\033[31m 与ota服务器通信不稳定 \033[0m'
fi
}

#ping computeIP 192.168.10.6

echo "wait a moment"
ping -c 5 $computeIP > /dev/null 2>&1
if [ $? -eq 0 ]
then
#    gnome-terminal -x bash -c "
#    echo \"本机与计算节点通信正常\"
    echo "本机与计算节点通信正常"
    ping -c 5 $extranet > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        echo '可以跟外网通信'
        check-internet
        if [ $? -eq 0 ]
        then
        firefox 192.168.10.6:8080
        else
            echo -e '\033[31m执行check-internet时发生未知错误\033[0m'
    else
        echo -e '\033[31m 不能连接到外网，请检查是否插入sim卡 \033[0m'
    fi
#   read
#   " 
else
#    gnome-terminal -x bash -c "
    echo -e '\033[31m 本机不能跟计算节点通信 \033[0m'
    ping -c 5 $extranet > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        echo '可以跟外网通信'
    else
        echo -e '\033[31m 不能连接到外网，请检查是否插入sim卡 \033[0m'
    fi
#    read
#    "    
fi
echo "20s后会关闭"
sleep 20















#disksize=`df -h /home | awk -F " " '{print $2}' | grep "G"`
#diskavail=`df -h /home | awk -F " " '{print $4}' | grep "G"`
#echo "磁盘总可用空间：$disksize"
#echo "磁盘未用空间：$diskavail"
