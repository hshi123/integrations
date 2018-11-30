#/bin/bash


passwd="caros"
user="ubuntu"
iptx="188.131.148.179"
dir="/home/caros/integrations"
testfile="8080-check.sh"
remote-cp-cloudtx(){

    /usr/bin/expect <<-EOF
    spawn scp ${dir}/${testfile} ${user}@${iptx}:~
    expect {
    "yes/no"{send "yes\r";exp_continue}
    }
    expect "ubuntu@188.131.148.179's password"
    send "${passwd}\r"
    set timeout 10
    expect 100%
    expect eof ;
EOF
}

remote-cp-cloudtx
