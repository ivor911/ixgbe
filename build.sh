#!/bin/bash
pushd ./ixgbe-5.20.3/src/
make CFLAGS_MODULE="-Wno-error=incompatible-pointer-types" -j1
popd
cp ./ixgbe-5.20.3/src/ixgbe.ko ./
xz -z ixgbe.ko
ls -al ixgbe.ko.xz
echo "################################"
echo "# Done "
echo " Copy ixgbe.ko.xz to E8300/E8100 /lib/modules/5.14.0-503.16.1.el9_5.x86_64/kernel/drivers/net/ethernet/intel/ixgbe"
echo " And 'sudo dracut -f /boot/initramfs-$(uname -r).img $(uname -r)' to update initramfs"
echo "################################"
