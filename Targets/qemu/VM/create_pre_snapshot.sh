mkdir -p pre_snapshot
../../../QEMU-PT/qemu/x86_64-softmmu/qemu-system-x86_64 -hda /home/qiliu/Nyx-images/qemu.qcow2 -serial mon:stdio -enable-kvm -net none -m 1024 -machine kAFL64-v1 -cpu kAFL64-Hypervisor-v1 -vnc :0 -fast_vm_reload pre_path=pre_snapshot/,load=off
