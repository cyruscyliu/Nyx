#!/bin/bash
target=$1

for idx in {0..9}; do
    rm -rf pre_snapshot-${target}-${idx}
    cp -r pre_snapshot pre_snapshot-${target}-${idx}
done
