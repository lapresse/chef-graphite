#
# Cookbook Name:: graphite
# Recipe:: default
#
# Copyright 2013, La Presse
#
# All rights reserved - Do Not Redistribute

include_recipe 'apache2'

# Pull the code from Github
if node[:platform_family] == 'rhel'
  package 'git' do
  end

  git '/var/tmp/graphite' do
    repository 'git://github.com/graphite-project/graphite-web.git'
    revision node[:graphite][:version]
  end
else
  log('Oh noes ... your distro isnt supported!')
end

# Install dependencies
if node[:platform_family] == 'rhel'
  [ 'mod_wsgi', 'cairo', 'pixman', 'freetype', 'fontconfig', 'libpng', 'libXrender',  'pycairo', 'bitmap', 'bitmap-fonts', 'python-memcached', 'python-txamqp', 'python-ldap', 'pycairo', 'pytz', 'pyparsing', 'django-tagging', 'Django' ].each do |p|
    package p do
    end
  end
else
  log('Oh noes ... your distro isnt supported!')
end

execute 'install_graphite_web' do
  cwd '/var/tmp'
  command 'pushd graphite && python setup.py install && popd'
  creates '/opt/graphite/webapp/content/css/'
end

execute 'copy_graphite_cfg' do
  command 'cp /opt/graphite/conf/graphite.wsgi.example /opt/graphite/conf/graphite.wsgi'
  creates '/opt/graphite/conf/graphite.wsgi'
end

directory '/opt/graphite/storage/log/webapp' do
  owner 'apache'
  group 'apache'
end

execute 'change_owner' do
  command 'chown -R apache. /opt/graphite/storage/'
end

apache_module 'wsgi' do
  enable true
end

template "/etc/httpd/sites-available/#{node[:fqdn]}" do
  source 'vhost.erb'
  mode 0644
end

apache_site 'default' do
  enable false
end

apache_site node[:fqdn] do
  enable true
end

file '/opt/graphite/storage/graphite.db' do
  owner 'apache'
  group 'apache'
end
