name              'et_nginx'
maintainer        'EverTrue, Inc.'
maintainer_email  'devops@evertrue.com'
license           'Apache 2.0'
description       'Installs and configures nginx'
version           '4.0.0'

recipe 'nginx', 'Installs nginx package and sets up configuration with ' \
                'Debian apache style with sites-enabled/sites-available'

depends 'apt',             '~> 2.2'
depends 'ohai',            '~> 2.0'
depends 'yum-epel',        '~> 0.3'

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'oracle'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'
