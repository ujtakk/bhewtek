#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Queue import Queue
import numpy as np
import random

img_w = 32
img_h = 32
fil_w = 5
fil_h = 5

linebuf = []
length = (img_w * (fil_h-1) + fil_w)

#image = np.random.randint(0, 256, img_w*img_h).reshape((img_w,img_h))
image = [[i+img_w*j if i<12 and j<12 else 0 for i in range(img_w)] for j in range(img_h)]

with open('image.txt', 'w') as f:
    for j in range(img_h):
        for i in range(img_w):
            f.write(' {:>4}'.format(image[j][i]))
        f.write('\n')

with open('whole.txt', 'w') as g:
    for j in range(img_h):
        for i in range(img_w):
            linebuf.append(image[j][i])
            if len(linebuf) == length:
                g.write('sliding times: {:>4}\n'.format(i+img_w*j))
                whole = linebuf + [-1 for k in range(img_w-fil_w)]
                for a in range(fil_h):
                    for b in range(img_w):
                        g.write(' {:>4}'.format(whole[b+img_w*a]))
                    g.write('\n')
                g.write('\n')
                linebuf.pop(0)
