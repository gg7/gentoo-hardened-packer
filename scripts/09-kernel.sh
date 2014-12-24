#!/bin/bash

set -o errexit
set -o nounset

cp /tmp/scripts/kernel.config /mnt/gentoo/tmp/

chroot /mnt/gentoo /bin/bash <<-EOF
	USE="symlink" emerge sys-kernel/hardened-sources sys-kernel/genkernel
	cd /usr/src/linux
	make defconfig
	cat /boot/config/overrides.config >> .config
	make olddefconfig
	make prepare
	genkernel --install --symlink --oldconfig all
EOF
