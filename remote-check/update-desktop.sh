#!/bin/bash

declare -r check_path=$(cd `dirname $0`; pwd)
declare -r check_name=$check_path/check.sh
echo $check_name
sed -i "s#^Exec=.*#Exec=${check_name}#g" check.desktop
