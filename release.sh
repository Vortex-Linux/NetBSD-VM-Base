#!/bin/bash 

echo "Shutting down the NetBSD VM..." 

echo y | ship --vm shutdown netbsd-vm-base 

echo "Compressing the NetBSD VM disk image..."

ship --vm compress netbsd-vm-base 

echo "Copying the NetBSD VM disk image to generate the release package for 'netbsd-vm-base'..."

DISK_IMAGE=$(sudo virsh domblklist netbsd-vm-base | grep .qcow2 | awk '{print $2}')

cp "$DISK_IMAGE" output/netbsd.qcow2

echo "Splitting the copied disk image into two parts..."

split -b $(( $(stat -c%s "output/netbsd.qcow2") / 2 )) -d -a 3 "output/netbsd.qcow2" "output/netbsd.qcow2."

echo "The release package for 'netbsd-vm-base' has been generated and split successfully!"

