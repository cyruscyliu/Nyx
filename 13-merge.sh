#!/bin/bash

orig_src=$1
saved_src=$orig_src.orig
mv $orig_src $saved_src
merged_src=$orig_src

python3 13-merge.py $saved_src $merged_src > /tmp/$(basename $orig_src).merged.sh

parallel --bar -j < /tmp/$(basename $orig_src).merged.sh

