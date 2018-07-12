#!/bin/sh
#virt-install --connect qemu:///system --virt-type kvm --name glance --vcpus 2 --ram 1024 --location=/tmp/CentOS-7-x86_64-DVD-1611.iso --disk path=/opt/sdc1/glance.qcow2,size=10,format=qcow2 --network  bridge=br0  --graphics none  --extra-args "console=tty0 console=ttyS0,115200 ip=10.26.17.100 netmask=255.255.254.0 gateway=10.26.17.1" --force  

#example : sh create_one_vm.sh  10.26.17.80 compute1


ip="$1"

image="/opt/$2.qcow2"

size=100
qemu-img create -f qcow2 $image  "$size"G

virt-install \
              --connect qemu:///system \
              --name $ip \
              --memory 4000 \
	      --vcpus 4   \
              --location /tmp/CentOS-7-x86_64-DVD-1708.iso \
              --disk path="$image",size=$size \
              --network bridge=br0 \
              --virt-type kvm \
              --graphics none \
             --extra-args "console=tty0 console=ttyS0,115200 ip=$ip netmask=255.255.255.0 gateway=10.26.17.1" \
	      --force


virt-clone -o 10.26.17.80 -n sample  -f /opt/openstack/sample.qcow2  --force
