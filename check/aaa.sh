#!/bin/bash

gnome-terminal -x bash -c "
echo \"百度ok,已配置请输入回车关闭该终端\"


echo -e '\033[31m新浪网络is not ok \033[0m'

ls; read
" 


if [ ping www.baidu.com ] && [ ping www.sohu.com ] && [ ping www.sina.com ]
then 
    echo "ok"
fi
