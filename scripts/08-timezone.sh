#!/bin/bash

set -o errexit
set -o nounset

chroot /mnt/gentoo /bin/bash <<-EOF
	ln -snf /usr/share/zoneinfo/UTC /etc/localtime
	echo UTC > /etc/timezone
EOF
