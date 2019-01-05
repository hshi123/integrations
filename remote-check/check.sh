#!/bin/bash

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
intedir=$(cd `dirname $0`; cd ..; pwd)
testfile="integration-integ-web.tar.gz"


#不进行拷贝只执行脚本
bash-run(){
    /usr/bin/expect <<-EOF
    spawn ssh -X $user@${computeIP}
    expect "caros@192.168.10.6's password:"
    send "$passwd\r"
    expect "caros@computing:~$" 
    send "bash /home/caros/8080-check.sh\r"
    send "cd /home/caros/integration-integ-web/output/install\r"
    send "nohup bash run_autointeg_web.sh &\r"
    expect "caros@computing:~$" 
    expect eof ;
EOF
}


#拷贝文件
remote-cp-compute(){
    /usr/bin/expect <<-EOF
    spawn scp ${intedir}/${testfile} ${user}@${computeIP}:~
    expect {
    "yes/no"{send "yes\r";exp_continue}
    }
    expect "caros@192.168.10.6's password:"
    send "$passwd\r"
     
    expect 100%
    expect eof ;
                    
    spawn scp ${intedir}/8080-check.sh $user@${computeIP}:~
    expect "caros@192.168.10.6's password:"
    send "$passwd\r"
    expect 100%
    expect eof ;
    
    spawn ssh -X $user@${computeIP}
    expect "caros@192.168.10.6's password:"
    send "$passwd\r"
    expect "caros@computing:~$" 
    send "bash /home/caros/8080-check.sh\r"
    send "tar xvf $testfile\r"
    send "cd /home/caros/integration-integ-web/output/install\r"
    send "nohup bash run_autointeg_web.sh &\r"
    expect "caros@computing:~$" 
    expect eof ;
EOF
}

check-internet(){
    echo 'Please wait a moment!'
    num=10
    ping -c $num $otaIP > usenet.txt
    usenet=`cat usenet.txt |grep 'packet loss' | awk -F "," '{print $3}' | awk -F " " '{print $1}' | awk -F "%" '{print $1}'`
    delaynet=`cat usenet.txt | grep 'min/avg/max/mdev'`
    echo "网络丢包率(%): ${usenet}"
    echo "网络延迟: ${delaynet}"
    if [ $usenet -le 10 ]
    then
        echo 'The Internet is stable!!'
        #获取计算节点的unix时间戳和integration-integ-web.tar.gz文件的时间戳
        expect $intedir/remote-check/check-interfile.exp >$intedir/remote-check/check-interfile.txt
        cat $interdir/remote-check/check-interfile.txt |grep "such file or dicetory"
        if [ $? -eq 0 ]
        then
            remote-cp-compute
        else
            expect $intedir/remote-check/get-inttime.exp >$intedir/remote-check/get-inttime.txt
            expect $intedir/remote-check/get-systime.exp >$intedir/remote-check/get-systime.txt
            inttime=`cat get-inttime.txt | grep '^[0-9]'`
            systime=`cat get-systime.txt | grep '^[0-9]'`
            twelvehours=43200
            timeinterval=$[($systime-$inttime)/$twelvehours]
            if [ $timeinterval -ge 1 ]
            then  
                remote-cp-compute
            else
                bash-run
            fi
        fi
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
#            firefox 192.168.10.6:8080
            gnome-terminal -x bash -c "
                cd $intedir/remote-check
                expect ssh-compute.exp
                read
                "
            google-chrome 192.168.10.6:8080 
        else
            echo -e '\033[31m执行check-internet时发生未知错误\033[0m'
        fi
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

read -p "输入回车关闭当前终端:"

#disksize=`df -h /home | awk -F " " '{print $2}' | grep "G"`
#diskavail=`df -h /home | awk -F " " '{print $4}' | grep "G"`
#echo "磁盘总可用空间：$disksize"
#echo "磁盘未用空间：$diskavail"
