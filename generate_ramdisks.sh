#!/bin/bash

set -e

for device in "$@"; do
    echo "=== Device: $device ==="
    pmbootstrap -y zap
    pmbootstrap config device "$device"
    pmbootstrap initfs hook_add debug-shell
    # Due to postmarketos-bootsplash only getting pulled in through the UI
    # package, build the rootfs first, then grab the boot.img from there.
    # Otherwise pbsplash will be missing from the ramdisk
    # https://gitlab.postmarketos.org/postmarketOS/pmbootstrap/-/issues/2617
    pmbootstrap install --no-image --password 0
    pmbootstrap export
    cp -v /tmp/postmarketOS-export/initramfs "ramdisk-$device.cpio.gz_debug"
done
