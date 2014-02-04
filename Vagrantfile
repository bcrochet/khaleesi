# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos65"

  config.vm.define :foreman do |foreman|
    foreman.vm.network :private_network,
        ip: "192.168.142.101"
    foreman.vm.provider :libvirt do |domain|
      domain.memory = 2048
      domain.cpus = 2
      domain.volume_cache = 'none'
    end
    foreman.ssh.username = "cloud-user"
  end

  config.vm.define :controller do |controller|
    controller.vm.network :private_network,
        ip: "192.168.142.102"
    controller.vm.provider :libvirt do |domain|
      domain.memory = 2048
      domain.cpus = 2
      domain.volume_cache = 'none'
    end
    controller.ssh.username = "cloud-user"
  end

  config.vm.define :compute do |compute|
    compute.vm.network :private_network,
        ip: "192.168.142.103"
    compute.vm.provider :libvirt do |domain|
      domain.memory = 8196
      domain.cpus = 4
      domain.nested = true
      domain.volume_cache = 'none'
    end
    compute.ssh.username = "cloud-user"
  end

  # Provider-specific configuration
  config.vm.provider :libvirt do |libvirt|
      libvirt.driver = "qemu"
      libvirt.host = "localhost"
      libvirt.connect_via_ssh = true
      libvirt.username = "root"
      libvirt.id_ssh_key_file = "id_dsa"
      libvirt.storage_pool_name = "default"
  end

  # Enable provisioning with ansible
  config.vm.provision :shell, path: "util/vagrant-cloud-init.sh"
  config.vm.provision :ansible do |ansible|
      ansible.playbook = "playbooks/foreman/foreman.yml"
      ansible.groups = {
        "foreman" => ["foreman"],
        "controller" => ["controller"],
        "compute" => ["compute"],
        "tempest" => ["controller"],
        "foreman_installer:children" => ["foreman", "controller", "compute"],
        "all_groups:children" => ["foreman", "foreman_installer", "controller", "tempest", "compute"]
      }
      ansible.host_key_checking = false
  end
end
