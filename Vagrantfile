# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_BOX = 'bento/ubuntu-18.04'.freeze
VM_BASE_IP = '192.168.0.'.freeze

def create_vm(config, ip, name, ssh_host)
  config.vm.define name do |object|
    object.vm.box = VM_BOX
    object.vm.network 'private_network', ip: "#{VM_BASE_IP}#{ip}"
    object.vm.hostname = name
    object.vm.provision :shell, inline: provision_script
    object.vm.network 'forwarded_port', guest: 22, host: ssh_host
  end
end

def provision_script
  public_key = File.read("#{ENV['HOME']}/.ssh/id_rsa.pub")
  script = <<SCRIPT
    apt install -y python
    echo "#{public_key}" >> /home/vagrant/.ssh/authorized_keys
SCRIPT
  script
end

Vagrant.configure('2') do |config|
  create_vm(config, 200, 'db', 2222)
  create_vm(config, 200, 'docker', 2223)
end
