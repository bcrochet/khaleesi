#!/bin/bash
poolpath=${1}
virsh pool-destroy default
virsh pool-define-as --name default --type dir --target $poolpath
virsh pool-autostart default
virsh pool-build default
virsh pool-start default
