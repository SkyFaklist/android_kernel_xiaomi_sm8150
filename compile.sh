#!/bin/bash
starttime=`date +'%Y-%m-%d %H:%M:%S'`
#mkdir -p out
export ARCH=arm64
export SUBARCH=arm64
PATH="/workdir/toolchain/bin/:$PATH"
#make O=out CC=clang $DEVICE ARCH=arm64
make mrproper
make -j$(nproc --all) O=out \ CROSS_COMPILE=aarch64-linux-gnu- \ CROSS_COMPILE_ARM32=arm-linux-gnueabi- \ 
CC=clang \
AR=llvm-ar \
OBJDUMP=llvm-objdump \
STRIP=llvm-strip \
NM=llvm-nm \
OBJCOPY=llvm-objcopy \
LD=ld.lld \
2>&1 | tee error.log 
endtime=`date +'%Y-%m-%d %H:%M:%S'`
start_seconds=$(date --date=" $starttime" +%s);
end_seconds=$(date --date="$endtime" +%s);
echo Start: $starttime.
echo End: $endtime.
echo "Build Time: "$((end_seconds-start_seconds))"s."
