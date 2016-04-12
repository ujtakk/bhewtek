#!/usr/bin/env python
# -*- coding: utf-8 -*-

n_f2 = 50
n_f1   = 20
core   = 4

for i in range(n_f2/core):
    for j in range(n_f1):
        for k in range(core):
            print('data{}_{}.bin'.format(core*i+k, j))

if n_f2 % core != 0:
    for j in range(n_f1):
        for k in range(core):
            if (n_f2 - n_f2%core + k) < n_f2:
                print('data{}_{}.bin'.format((n_f2 - n_f2%core + k), j))
            else:
                print('null.bin')
