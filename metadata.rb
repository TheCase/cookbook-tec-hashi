name             'tec-hashi'
maintainer       '311cub'
maintainer_email 'chef@repulsor.net'
license          'All rights reserved'
description      'Installs/Configures hashi bits'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.3'

depends 'apt'
depends 'docker'

depends 'ark'
depends 'systemd', '= 2.1.3'

depends 'sysctl'

depends 'ntp'
depends 'rsyslog'
