export ARCH=arm64
export CROSS_COMPILE="/home/j6idot/HTC/gcc-linaro-4.9.4/bin/aarch64-linux-gnu-"
export LOCALVERSION="$(date +%Y-%m-%d--%H-%M-%S)-j6idot"

make clean || { echo 'build failed!' ; exit 1; }
make pme_defconfig O=out -j$(nproc --all) || { echo 'build failed!' ; exit 1; }
make || { echo 'build failed!' ; exit 1; }

cp out/arch/arm64/boot/Image.gz-dtb ~/HTC/KernelBuilds/LiteEKernel-$(date +%Y-%m-%d--%H-%M-%S)
