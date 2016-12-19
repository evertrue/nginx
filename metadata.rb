name              'et_nginx'
maintainer        'EverTrue, Inc.'
maintainer_email  'devops@evertrue.com'
license           'Apache 2.0'
description       'Installs and configures nginx'
version           '6.0.1'

recipe 'nginx', 'Installs nginx package and sets up configuration with ' \
                'Debian apache style with sites-enabled/sites-available'

depends 'apt',             '~> 2.2'
depends 'ohai',            '~> 4.1'

supports 'debian'
supports 'ubuntu'
