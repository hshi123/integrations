#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
#   Author  :   hshi
#   E-mail  :   snapwings3190@163.com
#   Date    :   19/05/24 17:15:04
#   Desc    :   

def GetMaxAcceleration(rootdir):
    lines = []
    with open (rootdir, 'r') as file_to_read:
        while True:
            line = file_to_read.readline()
            if not line:
                break
            line = line.strip('\n')
            float_line = abs(float(line))
            lines.append(float_line)
            num = len(lines)
            for i in 
    print lines
    print max(lines)
GetMaxAcceleration('acceleration')
#GetMaxAcceleration('test_acceleration')



