#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

cp sources.list /etc/apt/sources.list

apt-get update
apt-get install qemu-system gcc -y
apt-get build-dep qemu-system -y

wget https://download.qemu.org/qemu-5.1.0.tar.xz

tar xf qemu-5.1.0.tar.xz
cd qemu-5.1.0

./configure --target-list=x86_64-softmmu --disable-werror --disable-capstone --disable-sanitizers
# ./configure --target-list=x86_64-softmmu --disable-werror --disable-capstone --enable-sanitizers
make

cd -

modprobe kvm
modprobe kvm-intel

cp grub.cfg /etc/default/grub

update-grub

shutdown -h now
