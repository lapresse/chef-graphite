#
# Cookbook Name:: graphite
# Recipe:: whisper
#
# Copyright 2013, La Presse
#
# All rights reserved - Do Not Redistribute

if node[:platform_family] == 'rhel'
  package 'git' do
  end

  git '/var/tmp/whisper' do
    repository 'git://github.com/graphite-project/whisper.git'
    revision node[:whisper][:version]
  end

  execute 'install_whisper' do
    cwd '/var/tmp'
    command 'pushd whisper && sudo python setup.py install && popd'
    creates '/usr/bin/whisper-resize.py'
  end
else
  log('ERROR: your distribution is currently not supported..')
end
