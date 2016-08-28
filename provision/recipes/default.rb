#
# Cookbook Name:: hankehly.com
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

execute 'yum-update' do
    command 'sudo yum update -y'
end

#####################
#### Environment ####
#####################

include_recipe 'locale::default'

group node[:user][:primary_group][:name] do
    gid node[:user][:primary_group][:gid]
end

user node[:user][:name] do
    comment 'The manager of hankehly.com source files'
    shell '/bin/bash'
    uid node[:user][:uid]
    gid node[:user][:primary_group][:name]
    password 'hankehly'
    manage_home true
    supports manage_home: true
end

include_recipe 'sudo::default'

sudo node[:user][:name] do
    user node[:user][:name]
    nopasswd true
    commands %w(/etc/httpd /usr/bin/php)
end

template 'bashrc' do
    path "#{node[:user][:home]}/.bashrc"
    source 'bashrc.erb'
    owner node[:user][:name]
    group node[:user][:primary_group][:name]
    mode '0644'
end

template 'bash_aliases' do
    path "#{node[:user][:bash_aliases]}"
    source 'bash_aliases.erb'
    owner node[:user][:name]
    group node[:user][:primary_group][:name]
    mode '0644'
end

package 'git'

################
#### Apache ####
################

include_recipe 'apache2::default'
include_recipe 'apache2::mod_ssl'

web_app '443-hankehly.com' do
    template '443-hankehly.com.conf.erb'
    server_name 'hankehly.com'
    server_aliases %w(www.hankehly.com)
    docroot '/var/www/hankehly.com/production/current'
    application_name 'hankehly.com'
    directory_options %w(+FollowSymLinks -MultiViews)
end


###############
##### PHP #####
###############

setup_ius_script_path = "#{Chef::Config[:file_cache_path]}/setup-ius.sh"

remote_file setup_ius_script_path do
    source 'https://setup.ius.io/'
    notifies :run, 'execute[setup-ius]', :immediately
end

execute 'setup-ius' do
    command "sudo bash #{setup_ius_script_path}"
    action :nothing
end

%w(mod_php70u php70u-cli).each do |pkg|
    yum_package pkg
end

include_recipe 'php::default'
