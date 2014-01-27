#!/bin/bash
network_name=${1}
network_number=${2}
virsh net-info ${network_name}_${network_number} && exit 0
virsh net-define /tmp/${network_name}_${network_number}.xml
virsh net-start ${network_name}_${network_number}
virsh net-autostart ${network_name}_${network_number}
