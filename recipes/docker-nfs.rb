# allows containers to mount NFS volumes
#
# docker run -i -t --volume-driver=nfs -v nfshost/path:/mount ubuntu /bin/bash
#

include_recipe 'ark'

if node['platform_family'] == 'rhel'
  package 'nfs-utils'
end
if node['platform_family'] == 'debian'
  package 'nfs-common'
end

directory '/etc/docker/plugins'

file '/etc/docker/plugins/nfs.spec' do
 content 'unix:///var/run/docker/plugins/.sock'
 action :create
end

ark 'docker-volume-netshare' do
  url node['nfs-driver']['artifact']
#  checksum nomad['checksum']
  version node['nfs-driver']['artifact'].match(/\d+\.\d+/).to_s
  strip_components 1
  has_binaries %w(docker-volume-netshare)
  action :install
end

systemd_service 'docker-volume-netshare' do
  description 'docker-volume-netshare'
  documentation 'https://github.com/ContainX/docker-volume-netshare'
  install do
    wanted_by %w(multi-user.target)
  end
  service do
    exec_start "/usr/local/bin/docker-volume-netshare nfs"
    restart 'on-failure'
  end
  action :create
  only_if do
    File.exist?('/proc/1/comm') && IO.read('/proc/1/comm').chomp == 'systemd'
  end
end

service 'docker-volume-netshare' do
  action [:enable, :start]
end

# mount synology NFS
directory '/mnt/syn-docker'
mount '/mnt/syn-docker' do
  device 'synology.311cub.net:/volume1/docker'
  fstype 'nfs'
  options 'rw'
  action [ :enable, :mount ]
  not_if 'mount | grep /mnt/syn-docker'
end

# mount drive for zoneminder
directory '/mnt/syn-zoneminder'
mount '/mnt/syn-zoneminder' do
  device 'synology.311cub.net:/volumeUSB2/usbshare'
  fstype 'nfs'
  options 'rw'
  action [ :enable, :mount ]
  not_if 'mount | grep /mnt/syn-zoneminder'
end

