# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "debian/buster64"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.define "balanceadorwebjosemacano" do |m1|
	m1.vm.hostname = "josemacbalanceweb"
	m1.vm.network "forwarded_port", guest: 80, host: 8001
        m1.vm.provision "shell", path: "balanceweb.sh"
        m1.vm.network "private_network", ip:  "192.168.3.3",
                 virtualbox_intnet: "lan"
         m1.vm.network "private_network", ip:  "192.168.4.2",
                 virtualbox_intnet: "inet"  
   end

  config.vm.define "serverweb1josemacano" do |m2|
	m2.vm.hostname = "josemacweb1"
        m2.vm.provision "shell", path: "serverweb.sh"
        m2.vm.network "private_network", ip:  "192.168.3.4",
                 virtualbox_intnet: "lan"
        m2.vm.network "private_network", ip:  "192.168.4.3",
                 virtualbox_intnet: "inet"
   end

  config.vm.define "serverweb2josemacano" do |m3|
 	m3.vm.hostname = "josemacweb2"
        m3.vm.provision "shell", path: "serverweb.sh"
        m3.vm.network "private_network", ip:  "192.168.3.5",
                 virtualbox_intnet: "lan"
        m3.vm.network "private_network", ip:  "192.168.4.4",
                 virtualbox_intnet: "inet"
   end

  config.vm.define "servernfsjosemacano" do |m7|
 	m7.vm.hostname = "josemacnfs"
        m7.vm.provision "shell", path: "servernfs.sh"
        m7.vm.network "private_network", ip:  "192.168.3.6",
                 virtualbox_intnet: "lan"
        m7.vm.network "private_network", ip:  "192.168.4.5",
                 virtualbox_intnet: "datos"
   end


   config.vm.define "balanceadormysqljosemacano" do |m4|
	m4.vm.hostname = "josemacbalancemysql"
        m4.vm.provision "shell", path: "balancemysql.sh"
        m4.vm.network "private_network", ip:  "192.168.4.6",
                 virtualbox_intnet: "inet"
        m4.vm.network "private_network", ip:  "192.168.5.3",
                 virtualbox_intnet: "datos"
   end


   config.vm.define "serverdatos1josemacano" do |m5|
	m5.vm.hostname = "josemacdatos1"
        m5.vm.provision "shell", path: "serverdatos1.sh"
        m5.vm.network "private_network", ip:  "192.168.5.4",
                 virtualbox_intnet: "datos"
        m5.vm.network "private_network", ip:  "192.168.4.7",
                 virtualbox_intnet: "inet"
  end


config.vm.define "serverdatos2josemacano" do |m6|
	m6.vm.hostname = "josemacdatos2"
        m6.vm.provision "shell", path: "serverdatos1.sh"
        m6.vm.network "private_network", ip:  "192.168.5.5",
                 virtualbox_intnet: "datos"
        m6.vm.network "private_network", ip:  "192.168.4.8",
                 virtualbox_intnet: "inet"
end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Disable the default share of the current code directory. Doing this
  # provides improved isolation between the vagrant box and your host
  # by making sure your Vagrantfile isn't accessable to the vagrant box.
  # If you use this you may want to enable additional shared subfolders as
  # shown above.
  # config.vm.synced_folder ".", "/vagrant", disabled: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
