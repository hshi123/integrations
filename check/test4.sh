#!/usr/bin/expect
    spawn ssh  ubuntu@188.131.148.179 "stat -c %Y /home/ubuntu/MotorDriver.tar.gz"
    expect "ubuntu@188.131.148.179's password:"
    send "caros\r"
    expect eof ;
