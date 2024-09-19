# Personal Build Script

# Build Counter
touch ~/HTC/KernelBuilds/count
COUNTER=$(cat ~/HTC/KernelBuilds/count)
next_n=$[$COUNTER+1]
echo $next_n > ~/HTC/KernelBuilds/count
#

export ARCH=arm64
export CROSS_COMPILE="/home/j6idot/HTC/gcc-linaro-4.9.4/bin/aarch64-linux-gnu-"
export LOCALVERSION="-$(date +%Y-%m-%d-%H-%M-%S)-build-$COUNTER"
export PMEVERSION="TESTING"
export ROOTDIR="/home/j6idot/HTC/HTCStock"

# Make clean
read -p "Do you know to clean the output folder? (y/n) " RESP
if [ "$RESP" = "y" ]; then
 make clean
else
 echo Too bad...
 exit
fi
#

make pme_defconfig O=out -j$(nproc --all) || { echo 'build failed!' ; exit 1; }
make O=out || { echo 'build failed!' ; exit 1; }

echo -
echo -
echo - Making an anykernel compatible zip
cp $ROOTDIR/out/arch/arm64/boot/Image.gz-dtb ~/HTC/KernelBuilds/AnyKernel/zImage || { echo 'build failed!' ; exit 1; }
bash ~/HTC/KernelBuilds/anykernel.sh || { echo 'build failed!' ; exit 1; }
cd ~/HTC/HTCStock
