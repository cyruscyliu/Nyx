#!/bin/bash

qemu-system-x86_64 \
     -m 1024 -hda qemu.qcow2  -nic user,hostfwd=tcp::2223-:22 -vnc :0
