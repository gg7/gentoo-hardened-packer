#!/bin/bash

set -o errexit
set -o nounset

chroot /mnt/gentoo /bin/bash <<-EOF
	mkdir -p /usr/portage
	emerge-webrsync
	eselect profile set hardened/linux/amd64/no-multilib/selinux
	emerge -quN portage
	emerge -quDN world

	emerge --noreplace app-editors/nano
	emerge --depclean
EOF
