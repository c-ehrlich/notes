#!/usr/bin/env python3
# ^ uses env to find python in the path
import sys

for arg in reversed(sys.argv[1:]):
    print(arg)
# foobar
