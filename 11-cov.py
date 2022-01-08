#!/usr/bin/python3
"""
/media/hdd0/qiliu/workdir_qemu-legacy_ne2000-0/corpus/timeout/cnt_860_1640809331.bin
target=legacy_ne2000
round=0
timeout=1640809331
"""

import os
import sys

def main(argv):
    filepath = argv[1]
    basename = os.path.basename(filepath)
    _, _, timestamp = basename.strip('.bin').split('_')
    _, target, round_ = filepath.split('/')[-4].split('-')
    print(target, round_, timestamp)

if __name__ == '__main__':
    main(sys.argv)
