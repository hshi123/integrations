#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
#   Author  :   hshi
#   E-mail  :   snapwings3190@163.com
#   Date    :   19/05/28 13:16:31
#   Desc    :   

#import time
import numpy as np
#time.sleep(50)
a = np.loadtxt('pose1')
b = np.loadtxt('obstacles_position1')
ava_pose = np.mean(a,0)
ava_obstacles = np.mean(b,0)
l = []
#print ava_pose
#print ava_obstacles
distance_x = ava_pose - ava_obstacles
#print distance_x
num = len(distance_x)
for i in range(num):
     vec = np.array(distance_x[i])
     l.append(vec)
#print l
print "横向距离x(m):",l[0]
print "纵向距离y(m):",l[1]

