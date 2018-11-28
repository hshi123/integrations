#!/bin/bash
remote-cp-compute(){
    /usr/bin/expect <<-EOF
    spawn ssh ubuntu@188.131.148.179
    expect eof
EOF
     echo '11aa1'
}
remote-cp-compute
