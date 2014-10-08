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
- If you are on a Domain that will be used in areas with a network `%HOMEDRIVE%`
  - Add the `VAGRANT_HOME` environment variable to Windows and set it somewhere local
  - See [Is there a way to change the .vagrant.d location?](http://stackoverflow.com/questions/13368869/is-there-a-way-to-change-the-vagrand-d-location-the-location-for-vagrant-boxes)
- Start the vagrant box
  - `vagrant up`
  - This will take a while
- SSH into the box
  - `vagrant ssh`
- Follow [Go Rails: Setup Ruby on Rails on Ubuntu](http://gorails.com/setup/ubuntu/13.10)
  - Install Rbenv
  - Setup Git
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

- If you get an error while logging into your new VM with vagrant ssh along the lines of "syntax error on line 7" of /etc/profile.d/rbenv.sh 
 - The solution is this:
  - `sudo apt-get install dos2unix`
  - `sudo dos2unix /etc/profile.d/rbenv.sh`
  - `exit`
- If you get this error: `PG::InvalidParameterValue: ERROR:  encoding UTF8 does not match locale en_US DETAIL:  The chosen LC_CTYPE setting requires encoding LATIN1`.
  - See this [StackOverflow thread](http://stackoverflow.com/questions/13115692/encoding-utf8-does-not-match-locale-en-us-the-chosen-lc-ctype-setting-requires)
- If you get the psql error `FATAL: Peer authentication failed for user...`
  - See this [StackOverflow thread](http://stackoverflow.com/questions/17443379/psql-fatal-peer-authentication-failed-for-user-dev)
