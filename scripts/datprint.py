#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import math

def datprint(filename):
    l = []

    with open(filename) as f:
        p = 0
        for line in f:
            p += 1
            l.append(line.split('\n')[0])

    size = int(math.sqrt(p))

    for i in range(size):
        for j in range(size):
            print "%5d" % int(l[i*size+j]) ,
        print ''

if __name__ == '__main__':
    args = sys.argv
    datprint(args[1])

