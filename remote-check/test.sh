#!/bin/bash

time1=`stat -c %Y get-inttime.exp`
time2=`stat -c %Y ssh-compute.exp`
echo $time1
echo $time2
time3=43200
aaa=$[($time1-$time2)/$time3]
echo $aaa
