#!/bin/bash
target=$1
run=$2

timeout 86400 cargo run --release -- -c ../../Targets/qemu/config.ron-${target}-${run}
