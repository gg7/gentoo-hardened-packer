#!/bin/bash

set -o errexit
set -o nounset

mount --label gentoo --options compress=zlib /mnt/gentoo
mount /dev/sda1    /mnt/gentoo/boot
mount -t proc proc /mnt/gentoo/proc
mount --rbind /dev /mnt/gentoo/dev
mount --rbind /sys /mnt/gentoo/sys
mount --rbind /tmp /mnt/gentoo/tmp
