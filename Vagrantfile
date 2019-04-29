# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_BOX = 'bento/ubuntu-18.04'.freeze
VM_BASE_IP = '192.168.0.'.freeze

def create_vm(config, ip, name)
  config.vm.define name do |object|
    object.vm.box = VM_BOX
    object.vm.network 'private_network', ip: "#{VM_BASE_IP}#{ip}"
    object.vm.hostname = name
  end
end

Vagrant.configure('2') do |config|
  create_vm(config, 200, 'first-vm')
  create_vm(config, 200, 'second-vm')
end
