#!/bin/bash
#author v_shihui01@baidu.com
#Tel:16619803190

echo "不要关闭该终端，执行完毕10s后自动关闭！"
routerIP="192.168.10.1"
computeIP="192.168.10.6"
controlIP="192.168.10.7"
pp7IP="192.168.10.4"
velodyne128IP="192.168.20.13"
velodyne16IP="192.168.20.14"
extranet="www.baidu.com"
otaIP="180.149.145.158"

#ping routerIP 192.168.10.1
ping -c 5 $routerIP > /dev/null 2>&1
if [ $? -eq 0 ]
then
#    gnome-terminal -e 'bash -c "echo '计算到路由ok!!'; exec bash"'
    gnome-terminal -x bash -c "echo \"路由器网关192.168.10.1,已配置请输入回车关闭该终端\"; read" 
    sleep 5
else
    gnome-terminal -x bash -c "echo \"请检查路由器！请输入回车关闭该终端\"; read" 
#    gnome-terminal -e 'bash -c "echo '请检查路由器！！'; exec bash"'
    exit 1
fi

#ping compute 192.168.10.6
ping -c 5 $computeIP > /dev/null 2>&1
if [ $? -eq 0 ]
then
    gnome-terminal -x bash -c "echo \"计算节点192.168.10.6网络已OK,请输入回车关闭该终端\"; read" 
    sleep 5
else
    gnome-terminal -x bash -c "echo \"请检查计算节点是否已开机或系统已安装完成，请输入回车关闭该终端\"; read" 
    exit 1
fi


#ping control 192.168.10.7
ping -c 5 $computeIP > /dev/null 2>&1
if [ $? -eq 0 ]
then
    gnome-terminal -x bash -c "echo \"控制节点192.168.10.7网络已OK,请输入回车关闭该终端\"; read" 
    sleep 5
else
    gnome-terminal -x bash -c "echo \"请检查控制节点是否已开机或系统已安装完成，请输入回车关闭该终端\"; read" 
    exit 1
fi


#ping pp7 192.168.10.4
ping -c 5 $pp7IP > /dev/null 2>&1
if [ $? -eq 0 ]
then
    gnome-terminal -x bash -c "echo \"pp7ip 192.168.10.4已OK,请输入回车关闭该终端\"; read" 
    sleep 5
else
    gnome-terminal -x bash -c "echo \"请检查pp7是否已配置或pp7网线，请输入回车关闭该终端\"; read" 
    exit 1
fi


#ping www.baidu.com
ping -c 5 $extranet > /dev/null 2>&1
if [ $? -eq 0 ]
then
    gnome-terminal -x bash -c "echo \"已可以跟外网进行通信,请输入回车关闭该终端\"; read" 
    sleep 5
else
    gnome-terminal -x bash -c "echo \"不能跟外网通信，请查看路由器是否有SIM卡或者路由器供电问题\"; read" 
    exit 1
fi



echo "Please wait a moment!"
num=100

ping -c $num $otaIP > usenet.txt

usenet=`cat usenet.txt |grep "packet loss" | awk -F "," '{print $3}' | awk -F " " '{print $1}' | awk -F "%" '{print $1}'`

delaynet=`cat usenet.txt | grep "min/avg/max/mdev"`

echo "网络丢包率(%): $usenet"

echo "网络延迟: $delaynet"


if [ $usenet -ge 10 ]
then
    echo "The Internet is bad!!"
else
    echo "The Internet is ok!!"
fi
sleep 10
#检测pp7是否配置
#/usr/bin/expect >/dev/null 2>&1 <<EOF



 


#disksize=`df -h /home | awk -F " " '{print $2}' | grep "G"`
#diskavail=`df -h /home | awk -F " " '{print $4}' | grep "G"`
#echo "磁盘总可用空间：$disksize"
#echo "磁盘未用空间：$diskavail"
