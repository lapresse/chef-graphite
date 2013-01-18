#
# Cookbook Name:: graphite
# Recipe:: whisper
#
# Copyright 2013, La Presse
#
# All rights reserved - Do Not Redistribute

if node[:platform_family] == 'rhel'
  package 'python-whisper' do
  end
else
  log('ERROR: your distribution is currently not supported..')
end
