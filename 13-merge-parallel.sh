#!/bin/bash

orig_src=$(basename $1)
merged_src=$orig_src.merged
mkdir $merged_src

for i in {0..9}; do
    python3 13-merge-parallel.py $orig_src $merged_src ${i} > /tmp/$(basename $orig_src).merged-${i}.sh
    # bash -x /tmp/$(basename $orig_src).merged-${i}.sh &
done

