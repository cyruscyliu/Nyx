#!/bin/bash

qemu-system-x86_64 \
     -m 10240 -smp 4 -hda qemu.qcow2  -nic user,hostfwd=tcp::2223-:22 -vnc :0
