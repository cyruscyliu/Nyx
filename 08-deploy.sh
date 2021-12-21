#!/bin/bash
# prepare a pre-snapshot and move it to Nyx-images
target=$1

cd ../Nyx-images
for idx in {0..9}; do
    rm -rf pre_snapshot-${target}-${idx}
    cp -r pre_snapshot pre_snapshot-${target}-${idx}
done
