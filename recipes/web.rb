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
else
  log('Oh noes ... your distro isnt supported!')
end

directory node[:graphite][:doc_root] do
  owner node[:graphite][:user]
  group node[:graphite][:group]
end

git node[:graphite][:doc_root] do
  repository 'https://github.com/graphite-project/graphite-web.git'
  revision 'master'
  user node[:graphite][:user]
  group node[:graphite][:group]
end

# Install Ceres
git '/usr/share/python-ceres' do
  repository 'https://github.com/graphite-project/ceres.git'
  revision 'master'
end

execute 'install_ceres' do
  cwd '/usr/share/python-ceres'
  command 'python setup.py install'
end

# Install dependencies
if node[:platform_family] == 'rhel'
  [ 'bitmap', 'bitmap-fonts', 'python-memcached', 'python-txamqp', 'python-ldap', 'pycairo', 'pytz', 'pyparsing', 'django-tagging', 'Django' ].each do |p|
    package p do
    end
  end
else
  log('Oh noes ... your distro isnt supported!')
end
