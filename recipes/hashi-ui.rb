directory node['hashi-ui']['dir']

log("artifact: #{node['hashi-ui']['url']}")

remote_file File.join( node['hashi-ui']['dir'], node['hashi-ui']['exec']) do
  source node['hashi-ui']['url']
  mode 0755
  action :create
  notifies :restart, 'service[hashi-ui]'
end

nomad = consul = ''
if node['hashi-ui'].include?('nomad_addr')
  nomad = '-nomad-enable -nomad-address '+  node['hashi-ui']['nomad_addr']
end
if node['hashi-ui'].include?('consul_addr')
  consul = '-consul-enable -consul-address ' +  node['hashi-ui']['consul_addr']
newrelic = "-newrelic-app-name hashi-ui -newrelic-license #{node['newrelic']['application_monitoring']['license']}"
end
exec = File.join(node['hashi-ui']['dir'],node['hashi-ui']['exec'])

file '/etc/systemd/system/hashi-ui.service' do
  content <<-EOF
[Unit]
Description=hashi-ui
Wants=network.target
After=network.target

[Service]
Environment="GOMAXPROCS=2" "PATH=/usr/local/bin:/usr/bin:/bin"
ExecStart=#{exec} #{nomad} #{consul}
ExecReload=/bin/kill -HUP $MAINPID
KillSignal=TERM
User=root
WorkingDirectory=#{node['hashi-ui']['dir']}

[Install]
WantedBy=multi-user.target
  EOF
  notifies :restart, 'service[hashi-ui]'
end

service 'hashi-ui' do
  provider Chef::Provider::Service::Systemd
  action [ :enable, :start ]
end
