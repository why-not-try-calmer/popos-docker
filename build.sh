#!/usr/bin/bash env
iso_url=https://iso.pop-os.org/22.04/amd64/intel/37/pop-os_22.04_amd64_intel_37.iso
iso_name=popos.iso
dockerhub_img=nycticoracs/pop_os:latest

mkdir rootfs unsquashfs
wget -O $iso_name $iso_url
sudo mount -o loop $iso_name rootfs
fs=$(find . -type f | grep filesystem.squashfs)
sudo unsquashfs -f -d unsquashfs/ $fs
sudo tar -C unsquashfs -c . | docker import - $dockerhub_dst
docker push $dockerhub_img