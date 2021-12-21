#!/bin/bash
# first please update deb-src in your /etc/apt/sources.list and then apt-get update
sudo apt-get install gcc-8 libisoburn1 libgcc-8-dev-i386-cross libx32gcc-8-dev-i386-cross build-essential curl qemu-utils python3-pip python-is-python3
pip install msgpack
sudo apt-get remove libcapstone3

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install capstone-v4
git clone https://github.com/aquynh/capstone.git && \
	cd capstone && \
	git checkout v4 && \
	make && \
	sudo make install && \
	cd -

# install all QEMU build dependencies (requires deb-src URIs in your /etc/apt/sources.list file)
sudo apt-get build-dep qemu -y
