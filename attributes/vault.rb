
default['vault']['source_url'] = 'https://releases.hashicorp.com/vault'
default['vault']['version'] = '0.8.3'
default['vault']['package'] = "/#{node['vault']['version']}/vault_#{node['vault']['version']}_linux_amd64.zip"
default['vault']['checksum'] = 'a3b687904cd1151e7c7b1a3d016c93177b33f4f9ce5254e1d4f060fca2ac2626'
