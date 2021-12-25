#!/usr/bin/python3
targets = ['qemu_xhci', 'legacy_ac97', 'legacy_cs4231a', 'legacy_es1370', 'legacy_intel_hda',
    'legacy_sb16', 'legacy_parallel', 'legacy_serial', 'legacy_floppy', 'legacy_ide_core',
    'legacy_sdhci', 'legacy_ee100pro', 'legacy_e1000', 'legacy_ne2000', 'legacy_pcnet',
    'legacy_rtl8139', 'legacy_xhci']


for target in targets:
    for idx in range(0, 10):
        config = """(
    runner: QemuSnapshot((
        qemu_binary: "/media/hdd0/qiliu/Nyx/QEMU-PT/qemu/x86_64-softmmu/qemu-system-x86_64",
        hda: "/media/hdd0/qiliu/Nyx-images/{0}-{1}/qemu.qcow2",
        sharedir: "/media/hdd0/qiliu/Nyx/Targets/qemu/sharedir_asan-{0}-{1}/",
        presnapshot: "/media/hdd0/qiliu/Nyx-images/pre_snapshot-{0}-{1}/",
	snapshot_path: DefaultPath,
	// snapshot_path: Reuse("/snapshot"),
        debug: false,
    )),
    fuzz: (
        spec_path: "/media/hdd0/qiliu/Nyx/Targets/qemu/sharedir_asan-{0}-{1}/spec.msgp",
        workdir_path: "/media/hdd0/qiliu/workdir_qemu-{0}-{1}/",
        bitmap_size: 65536,
        mem_limit: 1024,
        time_limit: (
            secs: 0,
            nanos: 800000000,
        ),
        target_binary: None,
        threads: 1,
        thread_id: 0,
        cpu_pin_start_at: {1},
    ),
)
""".format(target, idx)
        config_filename = 'config.ron-{}-{}'.format(target, idx)
        with open(config_filename, 'w') as f:
            f.write(config)
        print('[+] gen {}'.format(config_filename))
