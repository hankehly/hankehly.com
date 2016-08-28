default[:authorization][:sudo][:include_sudoers_d] = true

default[:apache][:listen] = %w(*:80 *:443)
default[:apache][:contact] = 'henry.ehly@gmail.com'

default[:php][:install_method] = 'source'
default[:php][:url] = 'http://jp2.php.net/get'
default[:php][:version] = '7.0.10'
default[:php][:checksum] = '46216e05db09c0fffbf832e3b64f3722ccbdd6d4ae16d9791e41adf0a4b00641'

default[:php][:configure_options] -= ['--with-mysql']
default[:php][:configure_options] -= ['--with-mysqli=/usr/bin/mysql_config']
default[:php][:configure_options] -= ['--with-mysql-sock']
default[:php][:configure_options] -= ['--with-sqlite3']
default[:php][:configure_options] -= ['--with-pdo-mysql']
default[:php][:configure_options] -= ['--with-pdo-sqlite']

default[:user][:name] = 'hankehly'
default[:user][:primary_group][:name] = 'hankehly'
default[:user][:uid] = 5230
default[:user][:primary_group][:gid] = 5230
default[:user][:home] = "/home/#{node[:user][:name]}"
default[:user][:bashrc] = "#{node[:user][:home]}/.bashrc"
default[:user][:bash_aliases] = "#{node[:user][:home]}/.bash_aliases"
