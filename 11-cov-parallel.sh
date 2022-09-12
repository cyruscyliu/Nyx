#!/bin/bash
QEMU=$PWD/Targets/qemu/VM/qemu-nyx/out-cov/qemu-system-x86_64

bin=$1
# bin=/qiliu/workdir_qemu-legacy_ne2000-1/corpus/timeout/cnt_617_1640728834.bin  # with target round timestamp
read target round cnt timestamp < <(python3 11-cov.py $bin)

# generate ISO
nyx_fuzzer=/tmp/nyx_fuzzer-${target}-${round}-${timestamp}
if [ -d ${nyx_fuzzer} ]; then
    echo "[-] Duplicated: let's skip this"
    exit 1
fi
mkdir -p ${nyx_fuzzer}
hypervisor_spec=${nyx_fuzzer}/hypervisor_spec
cp -r nyx_fuzzer/hypervisor_spec/ ${nyx_fuzzer}
cp -r nyx_fuzzer/structured_fuzzer/ ${nyx_fuzzer}
pushd ${hypervisor_spec}
pushd build/hypertrash_os && make clean -j && popd
python3 gen_spec.py $target
pushd build && cp bytecode_spec.template.h bytecode_spec.h && popd
pushd build/hypertrash_os && cp $bin misc/crash.hexa && make hypertrash_os_crash.bin -j && popd
popd
ISO=${hypervisor_spec}/build/hypertrash_os/iso/hypertrash_os_bios_crash.iso

RESULTS_DIR=nyx-qemu-${target}-none-profiles
mkdir ${RESULTS_DIR}
export LLVM_PROFILE_FILE=$RESULTS_DIR/profile-nyx-qemu-${target}-none-${round}-${timestamp}

if [ $target = "legacy_ac97" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine q35 \
    -device ac97,audiodev=snd0 -audiodev none,id=snd0
elif [ $target = "legacy_cs4231a" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine q35 \
    -device cs4231a,audiodev=snd0 -audiodev none,id=snd0
elif [ $target = "legacy_e1000" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine q35 \
    -device e1000,netdev=net0 -netdev user,id=net0
elif [ $target = "legacy_ee100pro" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine q35 \
    -device i82550,netdev=net0 -netdev user,id=net0
elif [ $target = "legacy_es1370" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine q35 \
    -device es1370,audiodev=snd0 -audiodev none,id=snd0
elif [ $target = "legacy_floppy" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine pc \
    -drive id=disk0,file=null-co://,file.read-zeroes=on,if=none,format=raw -device floppy,unit=0,drive=disk0
elif [ $target = "legacy_intelhda" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine q35 \
    -device intel-hda,id=hda0 -device hda-output,bus=hda0.0 -device hda-micro,bus=hda0.0 -device hda-duplex,bus=hda0.0
elif [ $target = "legacy_ne2000" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine q35 \
    -device ne2k_pci,netdev=net0 -netdev user,id=net0
elif [ $target = "legacy_pcnet" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine q35 \
    -device pcnet,netdev=net0 -netdev user,id=net0
elif [ $target = "legacy_rtl8139" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine q35 \
    -device rtl8139,netdev=net0 -netdev user,id=net0
elif [ $target = "legacy_sb16" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine q35 \
    -device sb16,audiodev=snd0 -audiodev none,id=snd0
elif [ $target = "legacy_sdhci" ]; then
    $QEMU -cdrom $ISO -m 100 -net none -nographic -machine q35 \
    -device sdhci-pci,sd-spec-version=3 -device sd-card,drive=mydrive -drive if=none,index=0,file=null-co://,format=raw,id=mydrive
elif [ $target = "legacy_xhci" ]; then
    $QEMU -cdrom $ISO -net none -nographic -machine q35 \
    -drive file=null-co://,if=none,format=raw,id=disk0 -device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 \
    -device usb-bot -device usb-storage,drive=disk0 -chardev null,id=cd0 -chardev null,id=cd1 \
    -device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid -device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 \
    -device usb-tablet -device usb-wacom-tablet -device usb-audio
elif [ $target = "qemu_xhci" ]; then
    $QEMU -cdrom $ISO -net none -nographic -machine q35 \
    -drive file=null-co://,if=none,format=raw,id=disk0 -device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 \
    -device usb-bot -device usb-storage,drive=disk0 -chardev null,id=cd0 -chardev null,id=cd1 \
    -device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid -device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 \
    -device usb-tablet -device usb-wacom-tablet -device usb-audio
fi

# clean
rm -rf ${nyx_fuzzer}
