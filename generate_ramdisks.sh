#!/bin/bash

set -e

# Select mainline kernel variant (if available)
pmbootstrap config kernel mainline

for device in "$@"; do
    echo "=== Device: $device ==="
    pmbootstrap -y zap
    pmbootstrap config device "$device"
    pmbootstrap initfs hook_add debug-shell
    pmbootstrap export
    cp -v /tmp/postmarketOS-export/initramfs "ramdisk-$device.cpio.gz_debug"
done
