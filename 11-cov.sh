#!/bin/bash
QEMU=qemu-5.1.0/x86_64-softmmu/qemu-system-x86_64
target=$1

# usage: bash -x ./11-cov.sh /qiliu/workdir_qemu-legacy_intel_hda-

# choose a target, generate iso, test it, and collect coverage
for bin in `find ${target}* -name *bin`; do
    # bin=/qiliu/workdir_qemu-legacy_ne2000-1/corpus/timeout/cnt_617_1640728834.bin  # with target round timestamp
    read target round timestamp < <(python3 11-cov.py $bin)
    # generate ISO
    pushd nyx_fuzzer/hypervisor_spec/build/hypertrash_os/
    cp $bin misc/crash.hexa
    make clean
    make hypertrash_os_crash.bin -j
    popd
    ISO=nyx_fuzzer/hypervisor_spec/build/hypertrash_os/iso/hypertrash_os_bios_crash.iso
    
    RESULTS_DIR=/qiliu/nyx-${target}-profiles
    mkdir $RESULTS_DIR
    export LLVM_PROFILE_FILE=$RESULTS_DIR/profile-nyx-${target}-${round}-${timestamp}
    
    if [ $target = "legacy_ac97" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -device AC97
    elif [ $target = "legacy_cs4231a" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -device cs4231a
    elif [ $target = "legacy_e1000" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -device e1000,netdev=net0 -netdev tap,id=net0,ifname=tap0,script=no,downscript=no
    elif [ $target = "legacy_ee100pro" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -device i82550,netdev=net0 -netdev tap,id=net0,ifname=tap0,script=no,downscript=no
    elif [ $target = "legacy_es1370" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -device ES1370
    elif [ $target = "legacy_floppy" ]; then
        dd if=/dev/zero of=floppy.img bs=1024 count=1440
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -fda floppy.img
    elif [ $target = "legacy_ide_core" ]; then
        qemu-img create hdd.img 10M
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -hda hdd.img
    elif [ $target = "legacy_intel_hda" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -device intel-hda -device hda-duplex
    elif [ $target = "legacy_ne2000" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -device ne2k_pci,netdev=net0 -netdev tap,id=net0,ifname=tap0,script=no,downscript=no
    elif [ $target = "legacy_parallel" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -parallel file:/tmp/A
    elif [ $target = "legacy_pcnet" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -device pcnet,netdev=net0 -netdev tap,id=net0,ifname=tap0,script=no,downscript=no
    elif [ $target = "legacy_rtl8139" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -device rtl8139,netdev=net0 -netdev tap,id=net0,ifname=tap0,script=no,downscript=no
    elif [ $target = "legacy_sb16" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -device sb16
    elif [ $target = "legacy_sdhci" ]; then
        qemu-img create sd-card.img 10M
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -device sdhci-pci -drive format=raw,file=sd-card.img,if=none,id=disk,cache=writeback,discard=unmap -device sd-card,drive=disk
    elif [ $target = "legacy_serial" ]; then
        $QEMU -cdrom $ISO -enable-kvm -m 100 -net none -nographic -serial file:/tmp/A
    elif [ $target = "legacy_xhci" ]; then
        $QEMU -cdrom $ISO -enable-kvm -net none -nographic -device nec-usb-xhci
    elif [ $target = "qemu_xhci" ]; then
        $QEMU -cdrom $ISO -enable-kvm -net none -nographic -device nec-usb-xhci
    fi
done
