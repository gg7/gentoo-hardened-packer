#!/bin/bash

set -o errexit
set -o nounset

chroot /mnt/gentoo /bin/bash <<-EOF
	set -o errexit
	set -o nounset

	cd /usr/src/linux && make clean && make mrproper
	emerge -C sys-kernel/hardened-sources sys-kernel/genkernel
	emerge --depclean
EOF

rm -rf /mnt/gentoo/usr/portage
rm -rf /mnt/gentoo/tmp/*
rm -rf /mnt/gentoo/var/log/*
rm -rf /mnt/gentoo/var/tmp/*
rm -f  /mnt/gentoo/root/.bash_history
rm -f  /mnt/gentoo/root/.viminfo

swapoff /dev/sda3
dd if=/dev/zero of=/dev/sda3
mkswap /dev/sda3
