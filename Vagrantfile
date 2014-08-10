# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu-server-trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.network :private_network, ip: "192.168.33.10"
  # config.vm.network :public_network
  # config.vm.synced_folder "~/Projects", "/vagrant"
  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--memory", "512"
    ]
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "vagrant/puppet/manifests"
    puppet.module_path    = "vagrant/puppet/modules"
    puppet.manifest_file  = "main.pp"
    puppet.options        = [
                              '--verbose',
                              #'--debug',
                            ]
  end
end
