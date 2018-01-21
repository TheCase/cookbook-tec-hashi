
include_recipe 'apt'

include_recipe 'ark'

ark 'consul' do
  url ::File.join(node['consul']['source_url'], node['consul']['package'])
  checksum node['consul']['checksum']
  version node['consul']['package'].match(/\d+\.\d+\.\d+/).to_s
  strip_components 0
  has_binaries %w(consul)
  action :install
end

template '/etc/consul.json' do
  source 'consul.json.erb'
	variables ({
    bootstrap_expect: node['consul']['bootstrap_expect'],
    node_name:        node['consul']['node_name'],
    datacenter:       node['consul']['datacenter'],
    data_dir:         node['consul']['data_dir'],
    dns_port:         node['consul']['dns_port'],
    server:           node['consul']['server'],
    ui:               node['consul']['ui'],
    start_server:     node['consul']['start_server'],
    encrypt:           node['consul']['encrypt'],
    tls:              node['consul']['tls'],
    ca_file:          File.join(node['consul']['cert_dir'],'ca.cert'),
    cert_file:        File.join(node['consul']['cert_dir'],'consul.cert'),
    key_file:         File.join(node['consul']['cert_dir'],'consul.key')
  })
  action :create
  notifies :restart, 'service[consul]'
end

systemd_service 'consul' do
  description 'Consul'
  documentation 'https://consul.io/'
  install do
    wanted_by %w(multi-user.target)
  end
  service do
    exec_start "/usr/local/bin/consul agent -config-file=/etc/consul.json"
    restart 'on-failure'
  end
  action :create
end

service 'consul' do
  action [:enable, :start]
end
