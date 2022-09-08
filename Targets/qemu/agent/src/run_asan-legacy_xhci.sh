chmod +x req_data
du -hs req_data
sha1sum req_data

./req_data hypertrash.iso hypertrash.iso
./req_data hypertrash_crash_detector hypertrash_crash_detector
./req_data hypertrash_crash_detector_asan hypertrash_crash_detector_asan
./req_data set_kvm_ip_range set_kvm_ip_range
./req_data set_ip_range set_ip_range

chmod +x hypertrash_crash_detector
chmod +x hypertrash_crash_detector_asan
chmod +x set_kvm_ip_range
chmod +x set_ip_range

#./set_kvm_ip_range
#./set_ip_range 0x1000 0x7ffffffff000 1

# disable ASLR
echo 0 > /proc/sys/kernel/randomize_va_space

./set_ip_range 0x1000 0x6ffffffff000 0

echo 0 > /proc/sys/kernel/printk


clear

LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libasan.so.4:./hypertrash_crash_detector ASAN_OPTIONS=abort_on_error=true:detect_leaks=false \
    /home/user/qemu-nyx/out-cov/qemu-system-x86_64 -cdrom hypertrash.iso -enable-kvm -net none -nographic -machine q35 \
    -drive file=null-co://,if=none,format=raw,id=disk0 -device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 \
    -device usb-bot -device usb-storage,drive=disk0 -chardev null,id=cd0 -chardev null,id=cd1 \
    -device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid -device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 \
    -device usb-tablet -device usb-wacom-tablet -device usb-audio \
    2> /tmp/data.log
