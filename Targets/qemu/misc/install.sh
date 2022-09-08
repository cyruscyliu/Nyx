#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

cp sources.list /etc/apt/sources.list

apt-get update
apt-get install qemu-system gcc -y
apt-get build-dep qemu-system -y

rm -rf qemu-nyx
tar xf qemu-nyx.tar.gz
mkdir -p qemu-nyx/out-cov
cd qemu-nyx/out-cov

../configure --disable-werror --disable-sanitizers \
    --target-list="x86_64-softmmu"
make CFLAGS="-DVIDEZZO_LESS_CRASHES" \
    -j$(nproc) x86_64-softmmu/all
    cp x86_64-softmmu/qemu-system-x86_64 .
cd -

modprobe kvm
modprobe kvm-intel

cp grub.cfg /etc/default/grub

update-grub

# shutdown -h now
