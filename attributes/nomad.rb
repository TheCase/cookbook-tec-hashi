default['nomad']['region'] = 'global'
default['nomad']['datacenter'] = node['consul']['datacenter']

default['nomad']['bootstrap_expect'] = 1

default['nomad']['data_dir'] = '/var/lib/nomad'

default['docker']['data_dir'] = '/var/lib/docker'

default['nomad']['servers'] = [ ]
default['nomad']['consul_addr'] = 'localhost:8500'

default['nomad']['source_url'] = 'https://releases.hashicorp.com/nomad'
default['nomad']['version'] = '0.6.3'
default['nomad']['package'] = "#{node['nomad']['version']}/nomad_#{node['nomad']['version']}_linux_amd64.zip"
default['nomad']['checksum'] = '908ee049bda380dc931be2c8dc905e41b58e59f68715dce896d69417381b1f4e'

default['nomad']['server_enabled'] = 'false'
default['nomad']['client_enabled'] = 'true'

default['nomad']['service_args'] = ''

default['nomad']['node_class'] = ''
