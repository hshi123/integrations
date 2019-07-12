#!/bin/bash
# CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# cd $CUR_PATH
AOS_OK=0
AOS_ERR=1

source ~/adu/car-env.sh
vin=$CARID

which otaclient > /dev/null || (echo "Error: otaclient is not installed!" >&2 && exit ${AOS_ERR})

local_version=`otaclient --local 2>/dev/null |grep params-${vin}-pioneer |awk '{print $4}'`
newest_version=`otaclient -s params-${vin}-pioneer 2>/dev/null | grep params-${vin}-pioneer | head -n1 |awk '{print $4}'`

if [[ x"${newest_version}" != x"*${local_version}" ]]; then
    #statements
    otaclient -i params-${vin}-pioneer,${newest_version} 1>/dev/null 2>&1
fi
echo "OTA Update Done!"
echo "SUCCESSED"
exit ${AOS_OK}
