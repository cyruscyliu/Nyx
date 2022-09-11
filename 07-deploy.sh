#!/bin/bash
# prepare a Ubuntu image and move it to Nyx-images
target=$1

if [[ ! -f ../Nyx-images/qemu.qcow2 ]]; then
    echo "Please prepare a Ubuntu image in ../Nyx-images"
    exit
fi

cd ../Nyx-images
for idx in {0..0}; do
    mkdir ${target}-${idx}
    cp qemu.qcow2 ${target}-${idx}/
done
