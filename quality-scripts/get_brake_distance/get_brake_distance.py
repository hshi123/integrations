#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
#   Author  :   hshi
#   E-mail  :   snapwings3190@163.com
#   Date    :   19/05/29 15:52:53
#   Desc    :   

import numpy as np
#import time
#time.sleep(50)
def GetBrakeDistance(position_file,obstacles_file):
    car_position = np.loadtxt(position_file)
    num = len(car_position)
    for i in range(num):
        if car_position[i][0] >= 4:
            #  print "x:,y:,z:",car_position[i][1],car_position[i][2],car_position[i][3]
            break
    obstacles_position = np.loadtxt(obstacles_file)
    vec1 = np.mean(obstacles_position,0)
    l = [car_position[i][1], car_position[i][2], car_position[i][3]]
    vec2 = np.array(l)
    distance = np.sqrt(np.sum(np.square(vec1-vec2)))
    print "开始刹车距离为:(m)",distance
GetBrakeDistance('brake_position1', 'obstacles_position1')
print "\nSUCCESSED"
