# Personal Build Script

export ARCH=arm64
export CROSS_COMPILE="/home/j6idot/HTC/gcc-linaro-4.9.4/bin/aarch64-linux-gnu-"
export LOCALVERSION="-$(date +%Y-%m-%d-%H-%M-%S)"
export PMEVERSION="TESTING"
export ROOTDIR="/home/j6idot/HTC/HTCStock"

make clean
make pme_defconfig O=out -j$(nproc --all) || { echo 'build failed!' ; exit 1; }
make O=out || { echo 'build failed!' ; exit 1; }

echo -
echo -
echo #  Making an anykernel compatible zip
cp $ROOTDIR/out/arch/arm64/boot/Image.gz-dtb ~/HTC/KernelBuilds/AnyKernel/zImage
bash ~/HTC/KernelBuilds/anykernel.sh
cd ~/HTC/HTCStock
