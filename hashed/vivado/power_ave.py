#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import os

top_path = "reports/power/"

top = re.compile(r"^\| top_hash\s+\|\s+([0-9\.]+) \|$", re.MULTILINE)

top_power = []
for i in range(10):
    for j in range(1, 11):
        top_report = os.path.join(top_path, "top_hash{}_{}.power.rpt".format(i, j))
        with open(top_report, "r") as f:
            power = re.findall(top, f.read())
            print(power[0])
            top_power.append(float(power[0]))

print("top_power_ave: {}".format(sum(top_power)/len(top_power)))
