# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Ubuntu 14.04
  config.vm.box = "ubuntu/trusty64"
  
  config.vm.provider "virtualbox" do |v|     
	 # Customize the amount of memory on the VM:
     v.memory = "2048"
  end
  
  config.vm.synced_folder "vagrant", "/vagrant"
  
  config.vm.network :forwarded_port, guest: 3000, host: 3000    # default rails port
  config.vm.network :forwarded_port, guest: 5432, host: 5432    # PostgreSQL port
  config.vm.network :forwarded_port, guest: 4567, host: 4567    # Sinatra port
  config.vm.network :forwarded_port, guest: 28017, host: 28017  # MongoDB port
  config.vm.network :forwarded_port, guest: 4000, host: 4000    # Jekyll port
  config.vm.network :forwarded_port, guest: 3030, host: 3030 	# Dashing port


   # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "nodejs"    
	chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::system"
    chef.add_recipe "rbenv::vagrant"
	chef.add_recipe "postgresql"
	chef.add_recipe "postgresql::server"
	
    chef.json = {
		"postgresql" => {
			"version" => "9.3",
			"enable_pgdg_apt" => "true",
			"password" => {
				"postgres" => "password"
			}
		},
        rbenv: {
			rubies: ["2.1.2", "2.3.1"],
			global: "2.1.2",
			gems: {
				"2.1.2": [
					{ name: 'bundler' }
				],
				"2.3.1": [
					{ name: 'bundler' }
				]
			}
		} 
    }
  end
end
