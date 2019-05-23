#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
#   Author  :   hshi
#   E-mail  :   snapwings3190@163.com
#   Date    :   19/05/22 14:55:29
#   Desc    :   


def bubble_sort(alist):
    n = len(alist)
    for j in range(n-1):
        count = 0
        for i in range(0, n-1-j):
            if alist[i] > alist[i+1]:
                alist[i], alist[i+1] =alist[i+1],alist[i]
                count += 1
        if 0 == count:
            break
if __name__ == '__main__':
    alist = [54, 26, 93, 77, 44, 31, 55, 20]
    print("原列表:%s" % alist)
    bubble_sort(alist)
    print("新列表为:%s" % alist)

