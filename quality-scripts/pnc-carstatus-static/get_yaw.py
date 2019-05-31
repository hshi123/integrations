#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
#   Author  :   hshi
#   E-mail  :   snapwings3190@163.com
#   Date    :   19/05/27 13:53:21
#   Desc    :   


import numpy as np
a = np.loadtxt('yaw')
#a = np.loadtxt('test_yaw')
l = []
myarray = np.array(l)
num = len(a)
for i in range(len(a)):
    vec = abs(np.array(a[i]))
    myarray = np.append(myarray,vec)
print '最大yaw:',myarray.max()
print '平均yaw:',myarray.mean()




#for i in range(len(a)):
#    vec = abs(np.array(a[i]))
#    l.append(vec)
#print l
#print max(l)



