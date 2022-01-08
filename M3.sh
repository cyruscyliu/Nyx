# parallel -j 32 --bar < /tmp/workdir_qemu-legacy_serial-.sh
# parallel -j 32 --bar < /tmp/workdir_qemu-legacy_floppy-.sh
# parallel -j 32 --bar < /tmp/workdir_qemu-legacy_ide_core-.sh
parallel -j 32 --bar < /tmp/workdir_qemu-legacy_rtl8139-.sh
parallel -j 32 --bar < /tmp/workdir_qemu-legacy_xhci-.sh
