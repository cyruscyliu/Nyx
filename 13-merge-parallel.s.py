import os
import sys

src_dir = os.path.abspath(sys.argv[1])
dst_dir = os.path.abspath(sys.argv[2])
idx = sys.argv[3]

# sprofile-nyx-qemu-legacy_ac97-none-0-1662964432

src_files = []
for src_file in os.listdir(src_dir):
    if src_file.startswith('sprofile') and '-none-{}-'.format(idx) in src_file:
        src_files.append(os.path.join(src_dir, src_file))
src_files = sorted(src_files)

cmd = '../evaluation/statecovmerge {} {}'

for index, src_file in enumerate(src_files):
    if index == 0:
        previous = ''
    else:
        previous = os.path.join(dst_dir, os.path.basename(src_files[index - 1]))
    dst_file = os.path.join(dst_dir, os.path.basename(src_file))
    print(cmd.format(dst_file, ' '.join([previous, src_file])))

