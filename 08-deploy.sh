#!/bin/bash
# prepare a pre-snapshot and move it to Nyx-images
target=$1

if [[ ! -d ../Nyx-images/pre_snapshot ]]; then
    echo "Please prepare a pre-snapshot in ../Nyx-images"
    exit
fi

cd ../Nyx-images
for idx in {0..1}; do
    rm -rf pre_snapshot-${target}-${idx}
    cp -r pre_snapshot pre_snapshot-${target}-${idx}
done
