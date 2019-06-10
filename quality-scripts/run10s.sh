#!/bin/bash
echo 'launching '$1
declare -i n=0
while [[ $n -lt 20 ]]; do
    echo $n
    n=$n+1
    sleep 1
done
echo 'launched '$1
exit 0