#!/bin/bash

set -o errexit
set -o nounset

chroot /mnt/gentoo /bin/bash <<-EOF
	cp -rfv /tmp/files/* /mnt/gentoo/
EOF
