#!/bin/bash
#author v_shihui01@baidu.com
#Tel:16619803190

baiduIP=220.181.112.244
sinaIP=218.30.114.37
sohuIP=220.181.90.8

ping -c 5 $baiduIP > /dev/null 2>&1
if [ $? -eq 0 ]
then
    gnome-terminal -x bash -c "
    echo \"百度ok,已配置请输入回车关闭该终端\"

    ping -c 5 $sinaIP > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        echo '新浪网络已ok'
        sleep 3
    else
        echo -e '\033[31m 新浪网络is not ok \033[0m'
    fi

    ping -c 5 $sohuIP > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        sleep 2
        echo '搜狐网络已OK,请输入回车关闭该终端'
    else
        echo -e '\033[31m 搜狐网络is not ok \033[0m'
    fi
    read
    " 
else
    gnome-terminal -x bash -c "
    echo -e '\033[31m 百度is not ok \033[0m'
    
    ping -c 5 $sinaIP > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        echo '新浪网络已ok'
    else
        echo -e '\033[31m 新浪网络is not ok \033[0m'
    fi

    ping -c 5 $sohuIP > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        echo '搜狐网络已OK,请输入回车关闭该终端'
    else
        echo -e '\033[31m 搜狐网络is not ok \033[0m'
    fi
    read
    " 
fi








