#!/bin/bash

set -o errexit
set -o nounset

cd /mnt/gentoo/

echo "copying and extracting $STAGE3TARBALL..."
mv "/tmp/$STAGE3TARBALL" ./
tar xjpf "$STAGE3TARBALL" && rm "$STAGE3TARBALL"
