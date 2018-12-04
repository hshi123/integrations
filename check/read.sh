#!/bin/bash
/usr/bin/expect <<-EOF
   spawn ssh -X ubuntu@188.131.148.179
   expect "ubuntu@188.131.148.179's password:"
   send "caros\r"
   expect "*]#"
   send "ls\r"
   send "id\r"
   expect "*]#"
   expect eof
EOF
