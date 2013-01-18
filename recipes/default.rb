#
# Cookbook Name:: graphite
# Recipe:: default
#
# Copyright 2013, La Presse
#
# All rights reserved - Do Not Redistribute

if node[:graphite][:components][:web] == true
  include_recipe 'lapresse-graphite::web'
elsif node[:graphite][:components][:carbon] == true
  include_recipe 'lapresse-graphite::carbon'
elsif node[:graphite][:components][:whisper] == true
  include_recipe 'lapresse-graphite::whisper'
else
  log('ERROR: you have forgotten to configure your node... big badaboom!@')
end
