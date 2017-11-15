

default['hashi-ui']['dir'] = '/opt/hashi-ui'
default['hashi-ui']['exec'] = 'hashi-ui'
default['hashi-ui']['listend_address'] = '0.0.0.0:3000'
default['hashi-ui']['version'] = '0.13.4'
default['hashi-ui']['url'] = "https://github.com/jippi/hashi-ui/releases/download/v#{node['hashi-ui']['version']}/hashi-ui-linux-amd64"


default['hashi-ui']['nomad_addr']  = 'http://nomad.service.consul:4646'
default['hashi-ui']['consul_addr'] = 'consul.service.consul:8500'

