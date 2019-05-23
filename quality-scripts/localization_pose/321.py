#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
#   Author  :   hshi
#   E-mail  :   snapwings3190@163.com
#   Date    :   19/05/22 16:36:25
#   Desc    :   
import numpy as np

vec1 = [3,4]
vec2 = [2,1]
array1=np.array(vec1)
array2=np.array(vec2)

dist = np.sqrt(np.sum(np.square(array1 - array2)))
print(dist)
