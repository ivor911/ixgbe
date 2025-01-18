#!/bin/bash


if [ "$#" -eq 0 ] || [ "$1" == "all" ]; then
    echo "Building all..."
    pushd ./ixgbe-5.20.3/src/
    make CFLAGS_MODULE="-Wno-error=incompatible-pointer-types" -j1
    popd
    cp ./ixgbe-5.20.3/src/ixgbe.ko ./
    xz -z ixgbe.ko
    ls -al ixgbe.ko.xz
    echo "################################"
    echo "# Done "
    echo " Copy ixgbe.ko.xz to /lib/modules/5.14.0-503.16.1.el9_5.x86_64/kernel/drivers/net/ethernet/intel/ixgbe"
    echo " And 'sudo dracut -f /boot/initramfs-$(uname -r).img $(uname -r)' to update initramfs"
    echo "################################"
elif [ "$1" == "clean" ]; then
    echo "Clean all..."
    rm -f ./ixgbe-5.20.3/src/*.o
    rm -f ./ixgbe-5.20.3/src/.*.cmd
    rm -f ./ixgbe-5.20.3/src/Module.symvers
    rm -f ./ixgbe-5.20.3/src/.ixgbe_main.o.d
    rm -f ./ixgbe-5.20.3/src/ixgbe.ko
    rm -f ./ixgbe-5.20.3/src/ixgbe.mod
    rm -f ./ixgbe-5.20.3/src/ixgbe.mod.c
    rm -f ./ixgbe-5.20.3/src/kcompat_generated_defs.h
    rm -f ./ixgbe-5.20.3/src/modules.order
    rm -f ./ixgbe.ko.xz
else
    echo "Invalid option. Usage: ./build.sh [all|clean]"
fi
