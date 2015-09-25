nginx Cookbook
==============

Installs nginx from package and sets up configuration handling.

Requirements
------------
### Cookbooks
The following cookbooks are direct dependencies because they're used for common "default" functionality.

- ohai (for nginx::ohai_plugin)

The following cookbook is not a strict dependency because its use can be controlled by an attribute, so it may not be a common "default."

- When using Nginx.org's stable package, `recipe[apt::default]` is required.


### Platforms
The following platforms are supported and tested under test kitchen:

- Ubuntu 14.04

Other Debian family distributions are assumed to work.


Attributes
----------
Node attributes for this cookbook are logically separated into different files. Some attributes are set only via a specific recipe.

### default
Generally used attributes. Some have platform specific values. See `attributes/default.rb`. "The Config" refers to "nginx.conf" the main config file.

## default.rb

Generally used attributes. Some have platform specific values. See
`attributes/default.rb`. "The Config" refers to "nginx.conf" the main
config file.

**v0.101.0 - Attribute Change**: `node['nginx']['url']` is now
  `node['nginx']['source']['url']` as the URL was only used when
  retrieving the source to build Nginx.

- `node['nginx']['dir']` - Location for Nginx configuration.
- `node['nginx']['conf_template']` - The `source` template to use when creating the `nginx.conf`.
- `node['nginx']['conf_cookbook']` - The cookbook where `node['nginx']['conf_template']` resides.
- `node['nginx']['log_dir']` - Location for Nginx logs.
- `node['nginx']['log_dir_perm']` - Permissions for Nginx logs folder.
- `node['nginx']['user']` - User that Nginx will run as.
- `node['nginx']['group]` - Group for Nginx.
- `node['nginx']['port']` - Port for nginx to listen on.
- `node['nginx']['binary']` - Path to the Nginx binary.
- `node['nginx']['upstart']['foreground']` - Set this to true if you
  want upstart to run nginx in the foreground, set to false if you
  want upstart to detach and track the process via pid.
- `node['nginx']['upstart']['runlevels']` - String of runlevels in the
  format '2345' which determines which runlevels nginx will start at
  when entering and stop at when leaving.
- `node['nginx']['upstart']['respawn_limit']` - Respawn limit in upstart
  stanza format, count followed by space followed by interval in seconds.
- `node['nginx']['pid']` - Location of the PID file.
- `node['nginx']['keepalive']` - Whether to use `keepalive_timeout`,
  any value besides "on" will leave that option out of the config.
- `node['nginx']['keepalive_requests']` - used for config value of
  `keepalive_requests`.
- `node['nginx']['keepalive_timeout']` - used for config value of
  `keepalive_timeout`.
- `node['nginx']['worker_processes']` - used for config value of
  `worker_processes`.
- `node['nginx']['worker_connections']` - used for config value of
  `events { worker_connections }`
- `node['nginx']['worker_rlimit_nofile']` - used for config value of
  `worker_rlimit_nofile`. Can replace any "ulimit -n" command. The
  value depend on your usage (cache or not) but must always be
  superior than worker_connections.
- `node['nginx']['multi_accept']` - used for config value of `events {
  multi_accept }`. Try to accept() as many connections as possible.
  Disable by default.
- `node['nginx']['event']` - used for config value of `events { use
  }`. Set the event-model. By default nginx looks for the most
  suitable method for your OS.
- `node['nginx']['accept_mutex_delay']` - used for config value of
  `accept_mutex_delay`
- `node['nginx']['server_tokens']` - used for config value of
  `server_tokens`.
- `node['nginx']['server_names_hash_bucket_size']` - used for config
  value of `server_names_hash_bucket_size`.
- `node['nginx']['disable_access_log']` - set to true to disable the
  general access log, may be useful on high traffic sites.
- `node['nginx']['access_log_options']` - Set to a string of additional options
  to be appended to the access log directive
- `node['nginx']['error_log_options']` - Set to a string of additional options
  to be appended to the error log directive
- `node['nginx']['default_site_enabled']` - enable the default site
- `node['nginx']['sendfile']` - Whether to use `sendfile`. Defaults to "on".
- `node['nginx']['tcp_nopush']` - Whether to use `tcp_nopush`. Defaults to "on".
- `node['nginx']['tcp_nodelay']` - Whether to use `tcp_nodelay`. Defaults to "on".
- `node['nginx']['types_hash_max_size']` - Used for the
  `types_hash_max_size` configuration directive.
- `node['nginx']['types_hash_bucket_size']` - Used for the
  `types_hash_bucket_size` configuration directive.
- `node['nginx']['proxy_read_timeout']` - defines a timeout (between two
  successive read operations) for reading a response from the proxied server.
- `node['nginx']['client_body_buffer_size']` - used for config value of
  `client_body_buffer_size`.
- `node['nginx']['client_max_body_size']` - specifies the maximum accepted body
  size of a client request, as indicated by the request header Content-Length.
* `node['nginx']['sts_max_age']` - Enable Strict Transport Security for all apps (See: http://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security).  This attribute adds the following header:

  Strict-Transport-Security max-age=SECONDS

to all incoming requests and takes an integer (in seconds) as its argument.
* `node['nginx']['default']['modules']` - Array specifying which
modules to enable via the conf-enabled config include function.
Currently the only valid value is "socketproxy".

Other configurations

- `node['nginx']['extra_configs']` - a Hash of key/values to nginx configuration.

Rate Limiting

- `node['nginx']['enable_rate_limiting']` - set to true to enable rate
  limiting (`limit_req_zone` in nginx.conf)
- `node['nginx']['rate_limiting_zone_name']` - sets the zone in
  `limit_req_zone`.
- `node['nginx']['rate_limiting_backoff']` - sets the backoff time for
  `limit_req_zone`.
- `node['nginx']['rate_limit']` - set the rate limit amount for
  `limit_req_zone`.

### gzip module

- `node['nginx']['gzip']` - Whether to use gzip, can be "on" or "off"
- `node['nginx']['gzip_http_version']` - used for config value of `gzip_http_version`.
- `node['nginx']['gzip_comp_level']` - used for config value of `gzip_comp_level`.
- `node['nginx']['gzip_proxied']` - used for config value of `gzip_proxied`.
- `node['nginx']['gzip_vary']` - used for config value of `gzip_vary`.
- `node['nginx']['gzip_buffers']` - used for config value of `gzip_buffers`.
- `node['nginx']['gzip_types']` - used for config value of `gzip_types` - must be an Array.
- `node['nginx']['gzip_min_length']` - used for config value of `gzip_min_length`.
- `node['nginx']['gzip_disable']` - used for config value of `gzip_disable`.
- `node['nginx']['gzip_static']` - used for config value of `gzip_static` (`http_gzip_static_module` must be enabled)
### Attributes set in recipes

#### nginx::authorized_ips
- `node['nginx']['remote_ip_var']` - The remote ip variable name to
  use.
- `node['nginx']['authorized_ips']` - IPs authorized by the module

#### nginx::http_realip_module
From: http://nginx.org/en/docs/http/ngx_http_realip_module.html

- `node['nginx']['realip']['header']` - Header to use for the RealIp
  Module; only accepts "X-Forwarded-For" or "X-Real-IP"
- `node['nginx']['realip']['addresses']` - Addresses to use for the
  `http_realip` configuration.
- `node['nginx']['realip']['real_ip_recursive']` - If recursive search is enabled, the original client address that matches one of the trusted addresses is replaced by the last non-trusted address sent in the request header field. Can be on "on" or "off" (default).

### geoip
These attributes are used in the `nginx::http_geoip_module` recipe.
Please note that the `country_dat_checksum` and `city_dat_checksum`
are based on downloads from a datacenter in Fremont, CA, USA. You
really should override these with checksums for the geo tarballs from
your node location.

**Note** The upstream, maxmind.com, may block access for repeated
  downloads of the data files. It is recommended that you download and
  host the data files, and change the URLs in the attributes.

- `node['nginx']['geoip']['enable_city']` - Whether to enable City
  data
- `node['nginx']['geoip']['country_dat_url']` - Country data tarball
  URL
- `node['nginx']['geoip']['country_dat_checksum']` - Country data
  tarball checksum
- `node['nginx']['geoip']['city_dat_url']` - City data tarball URL
- `node['nginx']['geoip']['city_dat_checksum']` - City data tarball
  checksum

### upload_progress
These attributes are used in the `nginx::upload_progress_module`
recipe.

- `node['nginx']['upload_progress']['url']` - URL for the tarball.
- `node['nginx']['upload_progress']['checksum']` - Checksum of the
  tarball.
- `node['nginx']['upload_progress']['javascript_output']` - Output in javascript.
  Default is `true` for backwards compatibility.
- `node['nginx']['upload_progress']['zone_name']` - Zone name which will
  be used to store the per-connection tracking information.
  Default is `proxied`.
- `node['nginx']['upload_progress']['zone_size']` - Zone size in bytes.
  Default is `1m` (1 megabyte).

### passenger
These attributes are used in the `nginx::passenger` recipe.

- `node['nginx']['passenger']['version']` - passenger gem version
- `node['nginx']['passenger']['root']` - passenger gem root path
- `node['nginx']['passenger']['install_rake']` - set to false if rake already present on system
- `node['nginx']['passenger']['max_pool_size']` - maximum passenger
  pool size (default=10)
- `node['nginx']['passenger']['ruby']` - Ruby path for Passenger to
  use (default=`$(which ruby)`)
- `node['nginx']['passenger']['spawn_method']` - passenger spawn
  method to use (default=`smart-lv2`)
- `node['nginx']['passenger']['buffer_response']` - turns on or off
  response buffering (default=`on`)
- `node['nginx']['passenger']['max_pool_size']` - passenger maximum
  pool size (default=`6`)
- `node['nginx']['passenger']['min_instances']` - minimum instances
  (default=`1`)
- `node['nginx']['passenger']['max_instances_per_app']` - maximum
  instances per app (default=`0`)
- `node['nginx']['passenger']['pool_idle_time']` - passenger pool idle
  time (default=`300`)
- `node['nginx']['passenger']['max_requests']` - maximum requests
  (default=`0`)
- `node['nginx']['passenger']['nodejs']` - Nodejs path for Passenger to
  use (default=nil)

Basic configuration to use the official Phusion Passenger repositories:
- `node['nginx']['package_name']` - 'nginx-extras'
- `node['nginx']['passenger']['install_method']` - 'package'

### status
These attributes are used in the `nginx::http_stub_status_module` recipe.

- `node['nginx']['status']['port']` - The port on which nginx will
  serve the status info (default: 8090)

## socketproxy.rb

These attributes are used in the `nginx::socketproxy` recipe.

* `node['nginx']['socketproxy']['root']` - The directory (on your server) where socketproxy apps are deployed.
* `node['nginx']['socketproxy']['default_app']` - Static assets directory for requests to "/" that don't meet any proxy_pass filter requirements.
* `node['nginx']['socketproxy']['apps']['app_name']['prepend_slash']` - Prepend a slash to requests to app "app_name" before sending them to the socketproxy socket.
* `node['nginx']['socketproxy']['apps']['app_name']['context_name']` - URI (e.g. "app_name" in order to achieve "http://mydomain.com/app_name") at which to host the application "app_name"
* `node['nginx']['socketproxy']['apps']['app_name']['subdir']` - Directory (under `node['nginx']['socketproxy']['root']`) in which to find the application.

Recipes
-------
This cookbook provides three main recipes for installing Nginx.

- `default.rb` - *Use this recipe* if you have a native package for
  Nginx.
- `repo.rb` - The developer of Nginx also maintain
  [stable packages](http://nginx.org/en/download.html) for several
  platforms.

### default
The default recipe will install Nginx as a native package for the
system through the package manager and sets up the configuration
according to the Debian site enable/disable style with `sites-enabled`
using the `nxensite` and `nxdissite` scripts. The nginx service will
be managed with the normal init scripts that are presumably included
in the native package.

Includes the `ohai_plugin` recipe so the plugin is available.

### socketproxy

This will add socketproxy support to your nginx proxy setup.  Do not
include this recipe directly.  Instead, add it to the
`node['nginx']['default']['modules']` array (see below).

### ohai_plugin

This recipe provides an Ohai plugin as a template. It is included by the `default` recipe.

### authorized_ips
Sets up configuration for the `authorized_ip` nginx module.

Definitions
-----------

The cookbook provides a new definition. At some point in the future this definition may be refactored into a lightweight resource and provider as suggested by [foodcritic rule FC015](http://acrmp.github.com/foodcritic/#FC015).

### nginx\_site

Enable or disable a Server Block in
`#{node['nginx']['dir']}/sites-available` by calling nxensite or
nxdissite (introduced by this cookbook) to manage the symbolic link in
`#{node['nginx']['dir']}/sites-enabled`.

The template for the site must be managed as a separate resource.

### Parameters:

* `name` - Name of the site.
* `enable` - Default true, which uses `nxensite` to enable the site. If false, the site will be disabled with `nxdissite`.


Ohai Plugin
-----------
The `ohai_plugin` recipe includes an Ohai plugin. It will be
automatically installed and activated, providing the following
attributes via ohai:

- `node['nginx']['version']` - version of nginx
- `node['nginx']['configure_arguments']` - options passed to
  `./configure` when nginx was built
- `node['nginx']['prefix']` - installation prefix
- `node['nginx']['conf_path']` - configuration file path

Usage
-----
Include the recipe on your node or role that fits how you wish to
install Nginx on your system per the recipes section above. Modify the
attributes as required in your role to change how various
configuration is applied per the attributes section above. In general,
override attributes in the role should be used when changing
attributes.

There's some redundancy in that the config handling hasn't been
separated from the installation method (yet), so use only one of the
recipes, or default.


License & Authors
-----------------
### Current Maintainers
- Author:: Eric Herot (<eric.herot@evertrue.com>)
- Author:: Jeff Byrnes (<jeff@evertrue.com>)

### Original Authors
- Author:: Joshua Timberman (<joshua@chef.io>)
- Author:: Adam Jacob (<adam@chef.io>)
- Author:: AJ Christensen (<aj@chef.io>)
- Author:: Jamie Winsor (<jamie@vialstudios.com>)
- Author:: Mike Fiedler (<miketheman@gmail.com>)

```text
Copyright 2014-2015, EverTrue, Inc and
Copyright 2008-2014, Chef Software, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
