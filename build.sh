#!/usr/bin/bash
iso_url=https://iso.pop-os.org/26.04/amd64/generic/8/pop-os_26.04_amd64_generic_8.iso
iso_name=popos.iso
dockerhub_img=nycticoracs/pop_os:latest

mkdir rootfs unsquashfs
wget -O $iso_name $iso_url
sudo mount -o loop $iso_name rootfs
fs=$(find . -type f | grep filesystem.squashfs)
sudo unsquashfs -f -d unsquashfs/ $fs
sudo tar -C unsquashfs -c . | docker import - $dockerhub_img
