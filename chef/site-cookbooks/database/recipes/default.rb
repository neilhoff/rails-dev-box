# Setup database servers
#
# 1. Setup PostgreSQL
# 2. Create a postgres user, vagrant, with password vagrant that has full control

# PostgreSQL
template "#{node[:postgresql][:dir]}/pg_hba.conf" do
  source "pg_hba.conf.erb"
  notifies :restart, "service[postgresql]", :immediately
end

postgresql_connection_info = {
  :host     => "localhost",
  :password => node['postgresql']['password']['postgres']
}

postgresql_database_user 'vagrant' do
  connection postgresql_connection_info
  password 'vagrant'
  role_attributes :superuser => true, :createdb => true
  action :create
end