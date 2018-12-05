#/bin/bash
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



sudo -k
password=$1
echo $password | sudo -S echo " " &> /dev/null


dir_path=$(cd `dirname $0`; pwd )
echo $dir_path
tar xvf $dir_path/remote-check.tar.gz
check_name=$dir_path/remote-check/check.sh
sed -i "s#^Exec=.*#Exec=${check_name}#g" ${dir_path}/remote-check/check.desktop
cd $dir_path/remote-check
cp check.desktop $dir_path/
echo "桌面会有check的图标，点击这个图标！"

#update & install expect
sudo cp /etc/apt/sources.list /etc/apt/sources.list.old
cd $dir_path
sudo cp -p sources-list/163.sources.list /etc/apt/sources.list
sudo chown root:root /etc/apt/sources.list
sudo chmod 664 /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -f expect


