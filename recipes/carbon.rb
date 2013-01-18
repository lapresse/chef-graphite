#
# Cookbook Name:: graphite
# Recipe:: carbon
#
# Copyright 2013, La Presse
#
# All rights reserved - Do Not Redistribute

if node[:platform_family] == 'rhel'
  package 'python-carbon' do
  end

  template '/etc/carbon/carbon.conf' do
    mode 0644
    notifies :restart, 'service[carbon-aggregator]'
    notifies :restart, 'service[carbon-cache]'
  end

  service 'carbon-aggregator' do
    action [ :start, :enable ]
  end

  service 'carbon-cache' do
    action [ :start, :enable ]
  end

else
  log('ERROR: your distribution is currently not supported..')
end
