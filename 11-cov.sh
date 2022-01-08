#!/bin/bash
QEMU=./qemu-5.1.0/x86_64-softmmu/qemu-system-x86_64
target=$1

# usage: bash -x ./11-cov.sh /qiliu/workdir_qemu-legacy_intel_hda-

# choose a target, generate iso, test it, and collect coverage
parallel_script=/tmp/$(basename ${target}).sh
rm -f ${parallel_script}
for bin in `find ${target}* -name *bin`; do
    echo bash -x ./11-cov-parallel.sh $bin >> ${parallel_script}
done
