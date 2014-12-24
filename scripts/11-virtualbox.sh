#!/bin/bash

set -o errexit
set -o nounset

chroot /mnt/gentoo /bin/bash <<-EOF
	emerge -q1 '=virtual/linux-sources-1'
	emerge -q 'app-emulation/virtualbox-guest-additions'
	rc-update add virtualbox-guest-additions default
EOF
