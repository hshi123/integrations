
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LAST_SPACE=`df 2>/dev/null |grep "/dev/nvme1n1" |awk '{print int($3)}'`
sleep 10
NOW_SPACE=`df 2>/dev/null |grep "/dev/nvme1n1" |awk '{print int($3)}'`
echo "一分钟落盘数据："$(((NOW_SPACE-LAST_SPACE) * 6 /1000000))
echo "SUCCESSED"
