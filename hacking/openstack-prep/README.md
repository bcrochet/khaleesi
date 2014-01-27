Copy group_vars/all.sample to group_vars/all, and edit.

Add a target host to your inventory, and run.

    ansible-playbook -i hosts site.yml

You will end up with an inventory file pointing to your new VMs in /tmp/inventory.