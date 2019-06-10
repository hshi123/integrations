#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
#   Author  :   hshi
#   E-mail  :   snapwings3190@163.com
#   Date    :   19/05/24 15:26:20
#   Desc    :   
import numpy as np
a = np.loadtxt('velocity1')
num = len(a)
multiple = 3.6
l = []
b = [0,0,0]
vec2 = np.array(b)
for i in range(num):
    vec1 = np.array(a[i])
    vel = np.sqrt(np.sum(np.square(vec1-vec2)))
    l.append(vel)
aver_velo_arr = np.array(l)
aver_velo = np.mean(aver_velo_arr,0)*multiple
print '测试车的速度(km/h):','%.3f' % aver_velo
print '\nSUCCESSED'
#print "障碍车最大速度(km/h):",max(l)*multiple
#print "障碍车最小速度(km/h):",min(l)*multiple
