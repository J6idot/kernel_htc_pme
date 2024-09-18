export ARCH=arm64
export CROSS_COMPILE="/home/j6idot/HTC/gcc-linaro-4.9.4/bin/aarch64-linux-gnu-"
export LOCALVERSION="-$(date +%Y-%m-%d-%H-%M-%S)"

make clean
make pme_defconfig O=out -j$(nproc --all) || { echo 'build failed!' ; exit 1; }
make O=out || { echo 'build failed!' ; exit 1; }

echo -
echo -
echo #  Copying kernel
cp out/arch/arm64/boot/Image.gz-dtb ~/HTC/KernelBuilds/LiteEKernel-$(date +%Y-%m-%d--%H-%M-%S)
echo #  Done !
