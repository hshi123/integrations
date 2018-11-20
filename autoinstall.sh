#/bin/bash


dir_path=$(cd `dirname $0`; pwd )
echo $dir_path
tar xvf $dir_path/remote-check.tar.gz
cd $dir_path/remote-check
cp remote-cp-compute.desktop $dir_path/
cp check-net.desktop $dir_path/
echo "桌面会有check-net和remote-cp-compute的图标，依次点击这两个图标！"


sudo /etc/apt/sources.list /etc/apt/sources.list.old
cd $dir_path
sudo cp -p /sources-list/163.sources.list /etc/apt/sources.list
sudo chown root:root /etc/apt/sources.list
sudo chmod 664 /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -f expect
