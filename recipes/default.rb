#
# Cookbook Name:: graphite
# Recipe:: default
#
# Copyright 2013, La Presse
#
# All rights reserved - Do Not Redistribute

if node[:graphite][:components][:web] == true
  include_recipe 'lapresse-graphite::web'
end
if node[:graphite][:components][:carbon] == true
  include_recipe 'lapresse-graphite::carbon'
end
if node[:graphite][:components][:whisper] == true
  include_recipe 'lapresse-graphite::whisper'
end
