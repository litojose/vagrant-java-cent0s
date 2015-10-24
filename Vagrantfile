# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "puphpet/centos65-x64"
    config.vm.box_version = ">=1.0"
    config.vm.hostname = "javacent0s"
    config.vm.box_check_update = false

    config.vm.network "forwarded_port", guest: 80, host: 50101, auto_correct: true
    config.vm.network "forwarded_port", guest: 3306, host: 50102, auto_correct: true
    
    config.vm.network "private_network", type: "dhcp"
    config.vm.network "public_network", bridge: "eth0", type: "dhcp"

    config.vm.provider "virtualbox" do |vb|
        vb.name = "vagrant-javacent0s"
        vb.memory = "2048"
    end

    config.vbguest.auto_update = false

    config.vm.synced_folder ".", "/vagrant", :nfs => true
    
    config.vm.provision "shell", path:"install-files/setup.sh"
end
