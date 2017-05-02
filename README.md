- This box was created from the blog [Developing Ruby on Rails on Windows](http://manuel.manuelles.nl/blog/2013/07/23/developing-ruby-on-rails-on-windows/)
- Updated using [GoRails - Setting up Vagrant for Rails](https://gorails.com/guides/using-vagrant-for-rails-development) as a guide

Steps
==========

- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Install [Vagrant](http://downloads.vagrantup.com/)
- Install 2 plugins for Vagrant
 - `vagrant plugin install vagrant-vbguest` - Automatically installs the VirtualBox guest additions
 - `vagrant plugin install vagrant-librarian-chef-nochef` - Automatically run Chef when box is started
- NOTE: You might not have to install Ruby on Windows anymore. I haven't tested it yet.
- Install [Ruby](http://rubyinstaller.org/downloads/)
- Install the [Ruby DevKit](http://rubyinstaller.org/downloads/)
  - Extract to: <ruby_path>\devkit
- Setup the [Ruby Dev Kit](http://stackoverflow.com/questions/8100891/the-json-native-gem-requires-installed-build-tools)
  - `cd <ruby_path>\devkit`
  - `ruby dk.rb init`
  - `ruby dk.rb review`
  - `ruby dk.rb install`
- Clone this repository
  - `git clone https://github.com/neilhoff/rails-dev-box.git`
- If you are on a Domain that will be used in areas with a network `%HOMEDRIVE%`
  - Add the `VAGRANT_HOME` environment variable to Windows and set it somewhere local
  - See [Is there a way to change the .vagrant.d location?](http://stackoverflow.com/questions/13368869/is-there-a-way-to-change-the-vagrand-d-location-the-location-for-vagrant-boxes)
- Start the vagrant box
  - `vagrant up`
  - This will take a while
- SSH into the box
  - `vagrant ssh`
- Install a ruby version with Rbenv
 - `rbenv install 2.3.1`
 - `rbenv rehash`
- Install bundler
 - `gem install bundler`
 - This will be used to install all the dependencies in a Rails or Sinatra projects
- Editing files can be done in Windows because the root of the project is binded to the /vagrant/ folder on the box
 - `cd /vagrant`
 - From here you can setup a new project or clone an existing one down
- Shutdown the box
  - `vagrant halt`

Vagrant Options
=========
- Set the memory or CPUs
````
config.vm.provider "virtualbox" do |v|
  v.memory = 1024
  v.cpus = 2
end
````

RubyMine Setup
==========
- Setup Remote SDK
  - Ruby Interpreter path:
    - `rbenv which ruby` should display something like: `/usr/local/rbenv/versions/2.1.0/bin/ruby`
- Setup Remote Deployment
- See [Rubymine and Vagrant](http://youtu.be/5KQUhMM_99Y)

  
PostgreSQL Notes
==========
- If running `rake db:setup` fails
  - In config/database.yml you need to add `host: localhost`
- Create a new user
  - `sudo -u postgres createuser username -s`
- Set the password
  - `sudo -u postgres psql`
  - `\password username` 
- [PostgreSQL Command Cheat Sheet](http://blog.jasonmeridth.com/posts/postgresql-command-line-cheat-sheet/)

Install MongoDB
==========
- http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

Troubleshooting
==========

- If you are having issues with `rbenv`
  - [See this thread](https://github.com/bundler/bundler/issues/4260)
  - Uninstall the system Ruby `sudo apt-get remove ruby`
  - `rbenv global 2.1.2`
  - `rbenv rehash`
- Run this command if you are running into an issue with installing 'therubyracer' gem
  - `sudo apt-get install g++ build-essential`
- If you get an error while logging into your new VM with vagrant ssh along the lines of "syntax error on line 7" of /etc/profile.d/rbenv.sh 
 - The solution is this:
  - `sudo apt-get install dos2unix`
  - `sudo dos2unix /etc/profile.d/rbenv.sh`
  - `exit`
- If you get this error: `PG::InvalidParameterValue: ERROR:  encoding UTF8 does not match locale en_US DETAIL:  The chosen LC_CTYPE setting requires encoding LATIN1`.
  - See this [StackOverflow thread](http://stackoverflow.com/questions/13115692/encoding-utf8-does-not-match-locale-en-us-the-chosen-lc-ctype-setting-requires)
- If you get the psql error `FATAL: Peer authentication failed for user...`
  - See this [StackOverflow thread](http://stackoverflow.com/questions/17443379/psql-fatal-peer-authentication-failed-for-user-dev)
  - Example of a good `/etc/postgresql/9.1/main/pg_hba.conf`
````    
    # Database administrative login by Unix domain socket
    local   all             postgres                                peer
    # TYPE  DATABASE        USER            ADDRESS                 METHOD
    local   all             all                                     md5
    # IPv4 local connections:
    host    all             all             127.0.0.1/32            md5
    # IPv6 local connections:
    host    all             all             ::1/128                 md5
````
