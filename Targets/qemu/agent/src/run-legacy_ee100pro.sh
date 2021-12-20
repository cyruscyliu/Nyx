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

./set_ip_range 0x1000 0x7ffffffff000 0

echo 0 > /proc/sys/kernel/printk

brctl addbr br0
ip addr flush dev eth0
brctl addif br0 eth0
tunctl -t tap0 -u `whoami`
brctl addif br0 tap0
ifconfig eth0 up
ifconfig tap0 up
ifconfig br0 up

clear

LD_PRELOAD=./hypertrash_crash_detector \
    /home/user/qemu-5.1.0/x86_64-softmmu/qemu-system-x86_64 -cdrom hypertrash.iso -enable-kvm -m 100 -net none -nographic -device i82550,netdev=net0 \
    -netdev tap,id=net0,ifname=tap0,script=no,downscript=no 2> /tmp/data.log