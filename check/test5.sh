#!/bin/bash
expect ./test4.sh > info2
a=`cat info2 | grep '^[1-9]'`
echo $a
