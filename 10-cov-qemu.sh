#!/bin/bash
target=$1

# compile a QEMU 5.1.0
wget -nc https://download.qemu.org/qemu-5.1.0.tar.xz
rm -rf qemu-5.1.0 && tar xf qemu-5.1.0.tar.xz
# patch here
cp 10-cov-qemu-vl.c qemu-5.1.0/softmmu/vl.c
# let's go
pushd qemu-5.1.0
CC=clang CXX=clang++ ./configure --disable-werror --disable-sanitizers --target-list="x86_64-softmmu"
make CFLAGS="-fprofile-instr-generate -fcoverage-mapping" -j$(nproc) x86_64-softmmu/all
popd
