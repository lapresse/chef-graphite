
# Cookbook Name:: graphite
# Recipe:: carbon
#
# Copyright 2013, La Presse
#
# All rights reserved - Do Not Redistribute

if node[:platform_family] == 'rhel'
  package 'git' do
  end

  git '/var/tmp/carbon' do
    repository 'git://github.com/graphite-project/carbon.git'
    revision node[:carbon][:version]
  end

  execute 'install_carbon' do
    cwd '/var/tmp'
    command 'pushd carbon && python setup.py install && popd'
    creates '/opt/graphite/storage'
  end

  execute 'configure_carbon' do
    command 'pushd /opt/graphite/conf && cp carbon.conf.example carbon.conf && cp storage-schemas.conf.example storage-schemas.conf'
    creates '/opt/graphite/conf/carbon.conf'
  end

  template '/opt/graphite/conf/storage-schemas.conf' do
    mode 0644
  end

  package 'monit' do
  end

  service 'monit' do
    action [ :start, :enable ]
  end

  template '/etc/monit.d/carbon' do
    source 'carbon.monit.erb'
    mode 0644
    notifies :restart, 'service[monit]'
  end

else
  log('ERROR: your distribution is currently not supported..')
end
