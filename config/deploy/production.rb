server '52.14.242.90', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/app/.ssh/id_rsa'
