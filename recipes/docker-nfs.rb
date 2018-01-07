# allows containers to mount NFS volumes
#
# docker run -i -t --volume-driver=nfs -v nfshost/path:/mount ubuntu /bin/bash
#

apt_package 'nfs-common'

remote_file Chef::Config[:file_cache_path] + '/docker-volume-netshare.pkg' do
  source node['docker-nfs']['package']
end

dpkg_package 'docker-volume-netshare' do
  source Chef::Config[:file_cache_path] + '/docker-volume-netshare.pkg'
  notifies :restart, 'service[docker-volume-netshare]'
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

# mount drive for crashplan
directory '/mnt/syn-crashplan'
mount '/mnt/syn-crashplan' do
  device 'synology.311cub.net:/volumeUSB3/usbshare'
  fstype 'nfs'
  options 'rw'
  action [ :enable, :mount ]
  not_if 'mount | grep /mnt/syn-crashplan'
end

