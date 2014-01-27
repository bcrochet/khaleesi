#!/bin/bash
for vm in $VMSET; do
    MAC=$(virsh domiflist ${vm} | awk '/ovsbr0/ {print $5;}')
    virsh destroy ${vm}
    virt-clone -o foreman-gold -n ${vm} -f /var/lib/libvirt/images/${vm}.qcow2 -m ${MAC} --replace --force
    virsh start ${vm}
done
