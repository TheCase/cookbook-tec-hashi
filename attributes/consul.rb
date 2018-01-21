
default['consul']['datacenter']       = 'dc1'
default['consul']['tls']              = false
default['consul']['node_name']        = node.name
default['consul']['data_dir']         = '/var/lib/consul'
default['consul']['cert_dir']         = '/etc/consul.d/ssl'
default['consul']['dns_port']         = 8600
default['consul']['server']           = false 
default['consul']['ui']               = false 
default['consul']['start_server']     = 'localhost:8500' 
default['consul']['bootstrap_expect'] = 1

default['consul']['source_url'] = 'https://releases.hashicorp.com/consul'
default['consul']['version'] = '0.9.3'
default['consul']['package'] = "/#{node['consul']['version']}/consul_#{node['consul']['version']}_linux_amd64.zip"
default['consul']['checksum'] = '9c6d652d772478d9ff44b6decdd87d980ae7e6f0167ad0f7bd408de32482f632'
