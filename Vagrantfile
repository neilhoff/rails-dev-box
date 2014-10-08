# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "1024"]
  end
  
  config.vm.network :forwarded_port, guest: 3000, host: 3000   # default rails port
  config.vm.network :forwarded_port, guest: 3306, host: 3306   # MySQL port
  config.vm.network :forwarded_port, guest: 5432, host: 5432   # PostgreSQL port
  config.vm.network :forwarded_port, guest: 4567, host: 4567   # Sinatra port
  config.vm.network :forwarded_port, guest: 28017, host: 28017 # MongoDB port

  config.vm.provision :shell, :inline => "gem install chef --version 11.6.0"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["chef/cookbooks", "chef/site-cookbooks"]
    chef.roles_path     = [[:host, "chef/roles"]]

    chef.add_role "rails-dev"
    chef.json = {
      "postgresql" => {
        "password" => {
          "postgres" => ""
        }
      },
      "rbenv" => {
        "global" => "2.1.2",
        "rubies" => ["2.1.2"],
        "gems" => {
          "2.1.2" => [
            { "name" => "bundler" }
          ]
        }
      }
    }
  end
end
