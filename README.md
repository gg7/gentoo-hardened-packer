# Gentoo Hardened - Minimal Vagrant Box

This is the most minimal stage3 installation of Gentoo Hardened (amd64,
nomultilib) that is possible to package into a Vagrant box file. Only VirtualBox
is supported for now.

## Usage

This is a [Packer](https://packer.io/) template. Install the latest version of
Packer, then:

    ./generate-packer.sh
    packer build gentoo-hardened-latest.json

This will chew for a bit and finally output a Vagrant box file.

## Optional tweaks

* Set MAKEOPTS in files/etc/portage/make.conf

* Change the number of CPUs/memory size of the VM (search for 'vboxmanage' in
  meta/gentoo-hardened.json)

### Installation without Packer

If you have Vagrant installed, you can use the scripts provided here to build a
stage3 installation manually.

  1. Download the amd64 stage3 ISO from http://distfiles.gentoo.org/
  2. Create a new "Gentoo64" virtual machine in VirtualBox, named "GentooBuild"
    - Memory 1024MB
    - Disk, 60GB dynamically allocated
    - Everything else default (unless you know what you're doing)
  3. Attach the downloaded ISO to the CD drive in the virtual machine settings
  4. Boot the virtual machine using "gentoo-nofb" and the default keymap.
  5. `wget https://github.com/d11wtq/gentoo-packer/archive/master.zip`
    - From the livecd prompt in the VM
  6. `unzip master.zip`
    - From the livecd prompt in the VM
  7. `cd gentoo-packer`
    - From the livecd prompt in the VM
  8. `export STAGE3=20140227`
    - From the livecd prompt in the VM
    - Change to whichever stage3 you want to use
  9. `./provision.sh`
    - From the livecd prompt in the VM
    - This does the heavy lifting
  10. `shutdown -hP now`
    - From the livecd prompt in the VM
  11. Back on the host machine, remove the ISO from the CD drive in the virtual
      machine settings.
  12. `vagrant package --base GentooBuild`
    - This will emit a package.box file.

## On your first boot

Because keeping the portage tree in the image would be costly in terms of file
size, and because it gets out of date quickly, it is not present in the image.
Perform an initial `emerge-webrsync` to generate the portage tree.

    emerge-webrsync

**Do not** run `emerge --sync` before you do this, because you will add
unnecessary strain on the portage mirror and may even get yourself banned by
the mirror.

## Disk size

The disk is a 20GB sparse disk. You do not need 20GB of free space initially.
The disk will grow as disk usage increases.

## What's installed?

Short answer, nothing that's not in the stage3, with the exception of the
following things that are needed for Vagrant to work:

  - app-emulation/virtualbox-guest-additions
  - net-fs/nfs-utils
  - app-admin/sudo

## What's configured?

Everything is left as the defaults. The time zone is set to UTC.
