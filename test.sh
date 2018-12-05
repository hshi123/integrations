#!/bin/bash
google-chrome www.baidu.com
gnome-terminal -x bash -c "
    cd /home/caros/integrations
    expect ssh-cloudtx.exp
     read
    " 
read -p "ssssss"
