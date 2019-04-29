# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_BOX = 'bento/ubuntu-18.04'.freeze
VM_BASE_IP = '192.168.0.'.freeze

Vagrant.configure('2') do |config|
  config.vm.define 'first_vm' do |object|
    object.vm.box = VM_BOX
    object.vm.network 'private_network', ip: "#{VM_BASE_IP}200"
    object.vm.hostname = 'first-vm'
  end

  config.vm.define 'second_vm' do |object|
    object.vm.box = VM_BOX
    object.vm.network 'private_network', ip: "#{VM_BASE_IP}201"
    object.vm.hostname = 'second-vm'
  end
end
