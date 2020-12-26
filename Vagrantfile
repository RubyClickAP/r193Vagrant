# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_check_update = false
  config.ssh.insert_key = false

  config.vm.network "forwarded_port", guest: 3000, host: 3000 # rack
  config.vm.network "forwarded_port", guest: 4567, host: 4567 # rack
  config.vm.network "forwarded_port", guest: 9292, host: 9292 # rack
  
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 4
    vb.memory = "4096"
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    #vb.check_guest_additions = false
		#vb.customize ["modifyvm", :id, "--natnet1", "10.10.10/24"]
  end
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y tar unzip apache2 unoconv
    # ref: https://docs.moodle.org/all/es/Universal_Office_Converter_(unoconv)
    # mkdir /var/www/.config
    # chown www-data:www-data /var/www/.config
    # cp /vagrant/unoconvd /etc/init.d/unoconvd
    # chown +x /etc/init.d/unoconvd
  SHELL
  
  config.vm.provision "shell", :path => "vagrant/provision.sh"
  
  #sudo -H -u root /bin/bash << 'SCRIPT'
  #export PATH=/opt/rubies/ruby-1.9.3-p547/bin:$PATH
  #  gem install thin --no-ri --no-rdoc
  #SCRIPT
end


