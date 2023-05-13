#!/usr/bin/env python

import os

for dir in os.listdir("/nix/store"):
    print(dir[33:])

