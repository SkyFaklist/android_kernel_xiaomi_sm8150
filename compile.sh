#!/bin/bash
starttime=`date +'%Y-%m-%d %H:%M:%S'`
export ARCH=arm64
export SUBARCH=arm64
TC_DIR="/workdir/tc-build"
PATH="$TC_DIR/install/bin/:$PATH"
make O=out cepheus_defconfig
make -j$(nproc --all) O=out \ CROSS_COMPILE=aarch64-linux-gnu- \ CROSS_COMPILE_ARM32=arm-linux-gnueabi- \ 
    NM=llvm-nm \
    OBJCOPY=llvm-objcopy \
    LD=ld.lld \
        CROSS_COMPILE=aarch64-linux-gnu- \
        CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
        CC=clang \
        AR=llvm-ar \
        OBJDUMP=llvm-objdump \
        STRIP=llvm-strip
        2>&1 | tee error.log
endtime=`date +'%Y-%m-%d %H:%M:%S'`
start_seconds=$(date --date=" $starttime" +%s);
end_seconds=$(date --date="$endtime" +%s);
echo Start: $starttime.
echo End: $endtime.
echo "Build Time: "$((end_seconds-start_seconds))"s."
