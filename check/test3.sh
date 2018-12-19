#/bin/bash
ST=$(date +%s)
SR=$(stat -c %Y test2.sh)
echo $ST
echo $SR
ONEDAY=86400 #one day seconds
asd=$[($ST-$SR)/$ONEDAY] 
echo $asd 
if [ $asd -gt 1 ]
then 
   echo "wudi"
else
   echo "caiji"
fi
 
