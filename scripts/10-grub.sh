#!/bin/bash

set -o errexit
set -o nounset

chroot /mnt/gentoo /bin/bash <<-EOF
	emerge "sys-boot/grub:2"
	echo "set timeout=1" >> /etc/grub.d/40_custom
	sed -i 's/^#?\s*GRUB_CMDLINE_LINUX=".*"/GRUB_CMDLINE_LINUX="net.ifnames=0"/' /etc/default/grub
	grub2-install /dev/sda
	grub2-mkconfig -o /boot/grub/grub.cfg
EOF
