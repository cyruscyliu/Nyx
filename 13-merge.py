import os
import sys

src_dir = os.path.abspath(sys.argv[1])
dst_dir = os.path.abspath(sys.argv[2])

src_files = [os.path.join(src_dir, src_file) for src_file in sorted(os.listdir(src_dir))]
cmd = 'llvm-profdata merge -output={} {}'

for index, src_file in enumerate(src_files):
    dst_files = src_files[0: index]
    dst_files.append(src_file)
    dst_file = os.path.join(dst_dir, os.path.basename(src_file))
    print(cmd.format(dst_file, ' '.join(dst_files)))

