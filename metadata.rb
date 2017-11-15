name             'tec-hashi'
maintainer       '311cub'
maintainer_email 'chef@repulsor.net'
license          'All rights reserved'
description      'Installs/Configures hashi bits'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.12'

depends 'docker'

depends 'ark'
depends 'systemd'

depends 'sysctl'
