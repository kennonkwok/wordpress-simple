include_recipe 'selinux::disabled'
include_recipe 'wordpress-simple::disable_iptables'

package 'httpd'
package 'php'
package 'php-mysql'

directory '/var/www/wordpress' do
  action :create
  recursive true
  owner 'apache'
  group 'apache'
  mode '0755'
end

tar_extract 'https://wordpress.org/wordpress-latest.tar.gz' do
  target_dir '/var/www/wordpress'
  creates '/var/www/wordpress/index.php'
  user 'apache'
  group 'apache'
  tar_flags ['--strip-components 1']
end

template '/etc/httpd/conf.d/wordpress.conf' do
  source 'wordpress.conf.erb'
  notifies :restart, 'service[httpd]'
end

template '/var/www/wordpress/wp-config.php' do
  source 'wp-config.php.erb'
  mode '0644'
end

service 'httpd' do
  action [:enable, :start]
end
