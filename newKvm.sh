#!/bin/bash -e

DIR=`pwd`
VM_SRC=http://ftp.au.debian.org/ubuntu-releases/18.04.1.0/ubuntu-18.04.1-live-server-amd64.iso
CONFIG_NAME=VM_${basename $VM_SRC}.xml
VM_NAME=some_vm

DISK_TYPE=qcow2	
DISK_SIZE=128G
DOSK_DIR=

sudo apt update \ 
	&& sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system

echo "downloading VM iso into $DIR/${basename $VM_SRC}"
if [ wget $VM_SRC -O $DIR/${basename $VM_SRC} ]; then
	echo "VM downloaded."
else 
	echo "Exit."
	return -1
fi

if [[ -n $DISK_DIR ]]; then
else
	DISK_DIR=$DIR
fi

echo "creating $DISK_TYPE vm disk: $DISK_DIR/$VM_NAME_$DISK_TYPE.img"
qemu-img create -f $DISK_TYPE $DISK_DIR/$VM_NAME_$DISK_TYPE.img DISK_SIZE

cat > $DIR/$CONFIG_NAME << EOF
<domain type='kvm'>
  <name>$VM_NAME</name>
  <memory unit='KiB'>8470528</memory> <!-- 8GB in KiB -->
  <vcpu placement='static'>4</vcpu>
  <os>
    <type arch='x86_64' machine='pc-i440fx-2.9'>hvm</type>
    <boot dev='cdrom'/>
  </os>
  <devices>
    <disk type='file' device='cdrom'>
      <driver name='qemu' type='raw'/>
      <source file='$DIR/${basename $VM_SRC}'/>
      <target dev='hdc' bus='ide'/>
      <readonly/>
      <address type='drive' controller='0' bus='0' target='0' unit='0'/>
    </disk>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='$DISK_DIR/$VM_NAME_$DISK_TYPE.img'/>
      <target dev='vda' bus='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
    </disk>
    <interface type='network'>
      <mac address='52:54:00:XX:XX:XX'/>
      <source network='default'/> <!-- Assuming 'default' is your NAT network -->
      <model type='virtio'/>
    </interface>
    <graphics type='vnc' port='-1' autoport='yes'/>
  </devices>
</domain>
EOF

sudo virsh define $DIR/$CONFIG_NAME \
	$$ sudo virsh start $VM_NAME

echo "Connect to the vm from 127.0.0.1:5900" 
