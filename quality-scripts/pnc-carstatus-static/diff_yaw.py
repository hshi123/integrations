#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
#   Author  :   hshi
#   E-mail  :   snapwings3190@163.com
#   Date    :   19/05/14 18:50:14
#   Desc    :   

import sys

result = []
with open('export/yaw', 'r') as f:
    for line in f:
        result.append(list(line.strip('\n').split(',')))
print(result)
asd = [6,3,2]
def fun(ls):
    for k in ls:
        if k > 5:
            print "failed"
            print k
            return 1
        else:
            print "pass"

fun(asd)


