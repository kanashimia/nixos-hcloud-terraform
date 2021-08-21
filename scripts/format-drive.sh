#!/bin/sh -e

echo Formatting disk...

echo "${PART_SCHEME}" | sfdisk /dev/sda -w always
mkfs.ext4 -F -L nixos /dev/sda1
mount /dev/sda1 /mnt
