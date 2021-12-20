#!/bin/bash -x
./make_standalone.sh qemu qemu_xhci
./make_standalone.sh qemu legacy_ac97
./make_standalone.sh qemu legacy_cs4231a
./make_standalone.sh qemu legacy_es1370
./make_standalone.sh qemu legacy_intel_hda
./make_standalone.sh qemu legacy_sb16
./make_standalone.sh qemu legacy_parallel
./make_standalone.sh qemu legacy_serial
./make_standalone.sh qemu legacy_floppy
./make_standalone.sh qemu legacy_ide_core
./make_standalone.sh qemu legacy_sdhci
./make_standalone.sh qemu legacy_ee100pro
./make_standalone.sh qemu legacy_e1000
./make_standalone.sh qemu legacy_ne2000
./make_standalone.sh qemu legacy_pcnet
./make_standalone.sh qemu legacy_rtl8139
./make_standalone.sh qemu legacy_xhci
