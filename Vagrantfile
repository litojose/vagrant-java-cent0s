# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file("#{current_dir}/config.yaml")
vagrant_config = configs['configs'][configs['configs']['use']]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "puphpet/centos65-x64"
    config.vm.box_version = ">=1.0"
    config.vm.hostname = "#{configs['hostname']}"
    config.vm.box_check_update = false

    config.vm.network "forwarded_port", guest: 80, host: 50101, auto_correct: true
    config.vm.network "forwarded_port", guest: 3306, host: 50102, auto_correct: true
    config.vm.network "forwarded_port", guest: 22, host: 50103, auto_correct: true
    config.vm.network "forwarded_port", guest: 9990, host: 50104, auto_correct: true
    config.vm.network "forwarded_port", guest: 8080, host: 50105, auto_correct: true

    config.ssh.port = 50103
    config.ssh.guest_port = 50103

    config.vm.network "private_network", ip: vagrant_config['private_ip']
    config.vm.network "public_network", bridge: vagrant_config['connection'], ip: vagrant_config['public_ip']

    config.vm.provider "virtualbox" do |vb|
        vb.name = "#{configs['hostname']}"
        vb.memory = "2048"
    end

    config.vbguest.auto_update = false

    config.vm.synced_folder ".", "/vagrant", :nfs => true

    config.bindfs.bind_folder "/vagrant", "/vagrant",
      :owner => "vagrant",
      :group => "www-data",
      :perms => "775"

    config.vm.provision "shell", path:"install-files/setup.sh"
end
