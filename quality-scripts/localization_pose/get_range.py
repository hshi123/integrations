#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
#   Author  :   hshi
#   E-mail  :   snapwings3190@163.com
#   Date    :   19/05/22 11:12:45
#   Desc    :   

import sys

result = []
with open('position', 'r') as f:
        for line in f:
                    result.append(list(line.strip('\n').split(',')))
                    print(result)


