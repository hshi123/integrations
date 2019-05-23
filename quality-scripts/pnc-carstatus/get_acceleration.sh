#/bin/bash
cat carstatus | grep acc:| awk -F ":" '{print $2}' | awk '{print $1}' >acceleration


