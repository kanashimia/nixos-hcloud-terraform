#!/bin/sh -e
#
echo Formatting disk...

cat /root/part_scheme| sfdisk /dev/sda -w always
mkfs.ext4 -F -L nixos /dev/sda1
mount /dev/sda1 /mnt
