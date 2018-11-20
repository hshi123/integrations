#!/bin/bash

if [ "$1" = "" ]
then
    echo "请在脚本后面输入当前用户密码"
    exit 1
fi



ping www.baidu.com -c5 > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "可以跟外网通"
else
    echo "不能跟外网通信，请检查路由器是否正常"
fi
