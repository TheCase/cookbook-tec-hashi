
# system tuning
node.default['sysctl']['params']['vm']['max_map_count'] = 262144
include_recipe 'sysctl::apply'

include_recipe 'ark'

ark 'nomad' do
  url ::File.join(node['nomad']['source_url'], node['nomad']['package'])
  checksum node['nomad']['checksum']
  version node['nomad']['package'].match(/\d+\.\d+\.\d+/).to_s
  strip_components 0
  has_binaries %w(nomad)
  action :install
  notifies :restart, 'service[nomad]'
end

template '/etc/nomad.json' do
  source 'nomad.json.erb'
	variables ({
    datacenter:       node['nomad']['datacenter'],
    region:           node['nomad']['region'],
    bootstrap_expect: node['nomad']['bootstrap_expect'],
    data_dir:         node['nomad']['data_dir'],
    servers:          node['nomad']['servers'],
    consul_addr:      node['nomad']['consul_addr'],
    server_enabled:   node['nomad']['server_enabled'],
    client_enabled:   node['nomad']['client_enabled'],
  })
  action :create
  notifies :restart, 'service[nomad]'
end

systemd_service 'nomad' do
  description 'Nomad System Scheduler'
  documentation 'https://nomadproject.io/docs/index.html'
  install do
    wanted_by %w(multi-user.target)
  end
  service do
    exec_start "/usr/local/bin/nomad agent -config=/etc/nomad.json #{node['nomad']['service_args']}"
    restart 'on-failure'
  end
  action :create
end

service 'nomad' do
  action [:enable, :start]
end

if node['nomad']['client_enabled'] 
  include_recipe 'tec-hashi::docker'
  include_recipe 'tec-hashi::docker-nfs'
#  include_recipe 'tec-hashi::filebeat'
end
