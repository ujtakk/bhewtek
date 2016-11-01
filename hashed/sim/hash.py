#!/usr/bin/env python
# -*- coding: utf-8 -*-

def prime_decomposition(n):
    print str(n) + " ",
    i = 2
    table = []
    while i * i <= n:
        while n % i == 0:
            n /= i
            table.append(i)
        i += 1
    if n > 1:
        table.append(n)
    return table

def test(n):
    for i in range(1, 20, 1):
        print "{:10d} : {:2d}".format(n, i) ,
        print(prime_decomposition(n-i))
    print(prime_decomposition(n-1-n/4))
    print

PRIME32_1 = 2654435761
PRIME32_2 = 2246822519
PRIME32_3 = 3266489917
PRIME32_4 =  668265263
PRIME32_5 =  374761393

test(PRIME32_1)
test(PRIME32_2)
test(PRIME32_3)
test(PRIME32_4)
test(PRIME32_5)

for i in range(32):
    print(2**i)
print

print(format(PRIME32_1, '032b'))
print(format(PRIME32_2, '032b'))
print(format(PRIME32_3, '032b'))
print(format(PRIME32_4, '032b'))
print(format(PRIME32_5, '032b'))
print

print 2**32
print((((((2**32/2**15)*PRIME32_2)/2**13)*PRIME32_3)/2**16))
