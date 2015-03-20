mysql2_chef_gem 'default' do
  action :install
end

mysql_service 'default' do
  bind_address '0.0.0.0'
  action [:create, :start]
  initial_root_password 'change meeeee'
end

mysql_connection_info = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => 'change meeeee'
}

mysql_database node['wordpress-simple']['dbname'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['wordpress-simple']['dbuser'] do
  connection mysql_connection_info
  password node['wordpress-simple']['dbpassword']
  host 'localhost'
  database_name node['wordpress-simple']['dbname']
  action :create
end

mysql_database_user 'wordpressuser' do
  connection mysql_connection_info
  database_name 'wordpressdb'
  privileges [:all]
  action :grant
end
