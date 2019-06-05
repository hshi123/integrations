#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
#   Author  :   hshi
#   E-mail  :   snapwings3190@163.com
#   Date    :   19/05/22 13:40:33
#   Desc    :   

import numpy as np
import sys
import time
time.sleep(50)
try:
    open('position1', 'r')
except Exception:
    print 'cannot find file'
    sys.exit(0)
a = np.loadtxt('position1')
num = len(a)
i = 0
l = []
#for i in range(num):
while i < num-1:
    j = i + 1
    while j < num:
        vec1 = np.array(a[i])
        vec2 = np.array(a[j])
        distance = np.sqrt(np.sum(np.square(vec1-vec2)))
        l.append(distance)
        j += 1
#    print("===================")
    i += 1
#print(l)
R = max(l)*100/2
print '最大波动半径R(cm):',R
#def bubble_sort(alist):
#    n = len(alist)
#    for j in range(n-1):
#        count = 0
#        for i in range(0,n-1-j):
#            if alist[i] > alist[i+1]:
#                alist[i], alist[i+1] =alist[i+1],alist[i]
#                count += 1
#        if 0 == count:
#            break
#bubble_sort(l)
#print(l)
#print(l[len(l)-1])
