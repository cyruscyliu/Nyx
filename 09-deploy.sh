#!/bin/bash
cd ./Targets/qemu && python3 gen_config.py && cd $OLDPWD
python3 -m pip install jinja2 msgpack
sudo apt-get install -y libc6-dev:i386 libisoburn-dev
cd ./nyx_fuzzer/hypervisor_spec && bash -x gen_all.sh && cd $OLDPWD
cd ./Targets/qemu/agent && bash -x gen_all.sh && $OLDPWN
