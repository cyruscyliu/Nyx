#!/bin/bash -x
# qemu_xhci legacy_ac97 legacy_cs4231a legacy_es1370 legacy_intelhda
# legacy_sb16 legacy_parallel legacy_serial legacy_floppy legacy_ide_core
# legacy_sdhci legacy_ee100pro legacy_e1000 legacy_ne2000 legacy_pcnet
# legacy_rtl8139 legacy_xhci
target=$1
cd nyx_fuzzer/rust_fuzzer
for idx in {0..9}; do
    bash -x launch.sh ${target} ${idx} &
    sleep 60
done
