#!/bin/bash -x

hypervisor=$1 # qemu bhyve
target=$2
cd build/hypertrash_os
make clean
cd -
python3 gen_spec.py $target
cd build
cp bytecode_spec.template.h bytecode_spec.h
cd hypertrash_os
make

cd ../../

for idx in {0..9}; do
    mkdir ../../Targets/$hypervisor/sharedir-${target}-${idx}
    mkdir ../../Targets/$hypervisor/sharedir_asan-${target}-${idx}
    cp build/hypertrash_os/iso/hypertrash_os_bios.iso ../../Targets/$hypervisor/sharedir-${target}-${idx}/hypertrash.iso
    cp build/hypertrash_os/iso/hypertrash_os_bios.iso ../../Targets/$hypervisor/sharedir_asan-${target}-${idx}/hypertrash.iso
    cp spec.msgp ../../Targets/$hypervisor/sharedir-${target}-${idx}/spec.msgp
    cp spec.msgp ../../Targets/$hypervisor/sharedir_asan-${target}-${idx}/spec.msgp
done
