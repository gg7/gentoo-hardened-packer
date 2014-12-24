#!/bin/bash

set -o errexit
set -o nounset

sgdisk \
  -n 1:0:+128M -t 1:8300 -c 1:"boot"      \
  -n 2:0:+32M  -t 2:ef02 -c 2:"bios-boot" \
  -n 3:0:+256M -t 3:8200 -c 3:"swap"      \
  -n 4:0:0     -t 4:8300 -c 4:"gentoo"    \
  -p /dev/sda

sync

mkswap /dev/sda3 && swapon /dev/sda3

mkfs.ext2  -L boot   /dev/sda1
mkfs.btrfs -L gentoo /dev/sda4

echo 'partitioned!'
