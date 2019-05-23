#!/bin/bash
dir_path=$(cd `dirname $0`;pwd)
mkdir -p $dir_path/cyber_node_text
cd $dir_path/cyber_node_text
cyber_node list >>cyber_node_list
for i in $(cat cyber_node_list)
do
	cyber_node info $i >>$i.txt
done

mkdir -p $dir_path/cyber_channel_text
cd $dir_path/cyber_channel_text
cyber_channel list >>cyber_channel_text
for i in $(cat cyber_channel_text)
do 
        cyber_channel info $i >>cyber_channel_info
done

#mkdir -p $dir_path/cyber_channel_echo
#cp $dir_path/cyber_channel_text/cyber_channel_text $dir_path/cyber_channel_echo
#cd $dir_path/cyber_channel_echo
#sed -i 's/-/\//g' cyber_channel_text
#sed -i 's/^-//g' cyber_channel_text

