#!/bin/bash

orig_src=$(basename $1)
merged_src=$orig_src.merged
mkdir $merged_src

python3 13-merge.py $orig_src $merged_src > /tmp/$(basename $orig_src).merged.sh

bash -x /tmp/$(basename $orig_src).merged.sh
