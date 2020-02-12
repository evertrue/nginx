name              'et_nginx'
maintainer        'EverTrue, Inc.'
maintainer_email  'devops@evertrue.com'
license           'Apache 2.0'
description       'Installs and configures nginx'
version           '6.1.2'

recipe 'nginx', 'Installs nginx package and sets up configuration with ' \
                'Debian apache style with sites-enabled/sites-available'

depends 'apt'
depends 'ohai'

supports 'debian'
supports 'ubuntu'
