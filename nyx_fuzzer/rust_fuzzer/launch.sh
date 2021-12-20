#!/bin/bash
target=$1
run=$2

cargo run --release -- -c ../../Targets/qemu/config.ron-${target}-${run}
