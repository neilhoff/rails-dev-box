This box was created from the blog [Developing Ruby on Rails on Windows](http://manuel.manuelles.nl/blog/2013/07/23/developing-ruby-on-rails-on-windows/)

Steps
==========

- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Install [Vagrant](http://downloads.vagrantup.com/)
- Install [Ruby](http://rubyinstaller.org/downloads/)
- Install the [Ruby DevKit](http://rubyinstaller.org/downloads/)
  - Extract to: <ruby_path>\devkit
- Setup the [Ruby Dev Kit](http://stackoverflow.com/questions/8100891/the-json-native-gem-requires-installed-build-tools)
  - `cd <ruby_path>\devkit`
  - `ruby dk.rb init`
  - `ruby dk.rb review`
  - `ruby dk.rb install`
- Install a base box
  - `vagrant box add precise64 http://files.vagrantup.com/precise64.box`
- Clone this repository
  - `git clone https://github.com/neilhoff/rails-dev-box.git`
- Install Librarian
  - `gem install librarian-chef`
- Make sure all the cookbooks are good to go
  - `cd chef`
  - `librarian-chef install`
- Setup Vagrant
  - `vagrant init precise64`
- Start the vagrant box
  - `vagrant up`
  - This will take a while
- SSH into the box
  - `vagrant ssh`
- Install gems and run rails migrations on the server
- Editing files can be done in Windows because the root of the project is binded to the /vagrant/ folder on the box
- Shutdown the box
  - `vagrant halt`


  
  
  