target=$1

bash compile.sh
for idx in {0..9}; do
    mkdir ../sharedir-${target}-${idx}
    mkdir ../sharedir_asan-${target}-${idx}

    cp bin/req_data ../sharedir-${target}-${idx}/req_data
    cp bin/hypertrash_crash_detector ../sharedir-${target}-${idx}/hypertrash_crash_detector
    cp bin/hypertrash_crash_detector_asan ../sharedir-${target}-${idx}/hypertrash_crash_detector_asan
    cp bin/set_ip_range ../sharedir-${target}-${idx}/set_ip_range
    cp bin/set_kvm_ip_range ../sharedir-${target}-${idx}/set_kvm_ip_range
    cp src/run-${target}.sh ../sharedir-${target}-${idx}/run.sh
    cp bin/req_data ../sharedir-${target}-${idx}/req_data

    cp bin/req_data ../sharedir_asan-${target}-${idx}/req_data
    cp bin/hypertrash_crash_detector ../sharedir_asan-${target}-${idx}/hypertrash_crash_detector
    cp bin/hypertrash_crash_detector_asan ../sharedir_asan-${target}-${idx}/hypertrash_crash_detector_asan
    cp bin/set_ip_range ../sharedir_asan-${target}-${idx}/set_ip_range
    cp bin/set_kvm_ip_range ../sharedir_asan-${target}-${idx}/set_kvm_ip_range
    cp src/run_asan-${target}.sh ../sharedir_asan-${target}-${idx}/run.sh
    cp bin/req_data ../sharedir_asan-${target}-${idx}/req_data
done
