#!/bin/bash
gnome-terminal -x bash -c "

remote-cp-compute(){
    /usr/bin/expect <<-EOF
    spawn ssh ubuntu@188.131.148.179
    expect eof
EOF
     echo "11aa1"
     check
}


check(){
    echo "aaaa"

}
remote-cp-compute
read
"
