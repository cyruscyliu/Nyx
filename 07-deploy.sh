#!/bin/bash
# prepare a Ubuntu image and move it to Nyx-images
target=$1

cd ../Nyx-images
for idx in {0..9}; do
    mkdir ${target}-${idx}
    cp qemu.qcow2 ${target}-${idx}/
done
