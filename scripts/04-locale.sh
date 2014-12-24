#!/bin/bash

set -o errexit
set -o nounset

chroot /mnt/gentoo /bin/bash <<-EOF
	sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
	locale-gen
	eselect locale set en_US.utf8
EOF
