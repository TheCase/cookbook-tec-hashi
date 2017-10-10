

if node['platform_family'] == 'rhel'
  yum_repository 'elastic-5.x' do
    description 'Elastic repository for 5.x packages'
    baseurl 'https://artifacts.elastic.co/packages/5.x/yum'
    gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
    action :create
  end
end

if node['platform_family'] == 'debian'
  package 'apt-transport-https'
  execute 'filebeat repo' do
    command <<-EOF
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
apt-get update
    EOF
    action :run
    not_if ('ls /etc/apt/sources.list.d/elastic-5.x.list')
  end
end

package 'filebeat'

template '/etc/filebeat/filebeat.yml' do
  source 'filebeat.yml.erb'
  action :create
  notifies :restart, 'service[filebeat]'
end

service 'filebeat' do
  action [ :enable, :start ]
end

