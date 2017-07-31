lock '3.4.0'

set :application, 'hankehly.com'
set :repo_url, 'git@github.com:hank-ehly/hankehly.com.git'
set :deploy_to, '/var/www/hankehly.com'
set :scm, :git
set :use_sudo, false
set :keep_releases, 3

server 'hankehly.com', user: 'hank', ssh_options: { forward_agent: false }, keys: %W(~/.ssh/hankehly.com/hank)

