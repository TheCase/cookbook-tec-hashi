
include_recipe 'ark'

ark 'vault' do
  url ::File.join(node['vault']['source_url'], node['vault']['package'])
  checksum node['vault']['checksum']
  version node['vault']['package'].match(/\d+\.\d+\.\d+/).to_s
  strip_components 0
  has_binaries %w(vault)
  action :install
end

template '/etc/vault.json' do
  source 'vault.json.erb'
	variables ({
    bootstrap_expect: node['vault']['bootstrap_expect'],
    node_name:        node['vault']['node_name'],
    datacenter:       node['vault']['datacenter'],
    data_dir:         node['vault']['data_dir'],
    dns_port:         node['vault']['dns_port'],
    server:           node['vault']['server'],
    ui:               node['vault']['ui'],
    start_server:     node['vault']['start_server']
  })
  action :create
  notifies :restart, 'service[vault]'
end

systemd_service 'vault' do
  description 'Consul'
  documentation 'https://vault.io/'
  install do
    wanted_by %w(multi-user.target)
  end
  service do
    exec_start "/usr/local/bin/vault server -config=/etc/vault.json"
    restart 'on-failure'
  end
  action :create
end

service 'vault' do
  action [:enable, :start]
end

#execute 'init vault' do
#  command "vault init -address=http://#{node['ipaddress']}:8200"
#  action :run
#end
