#
# Cookbook Name:: nginx
# Recipe:: package
# Author:: AJ Christensen <aj@junglist.gen.nz>
#
# Copyright 2008-2013, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'et_nginx::ohai_plugin'
include_recipe 'et_nginx::repo'

file '/usr/sbin/policy-rc.d' do
  mode    '0755'
  owner   'root'
  group   'root'
  content <<-EOF
#!/bin/sh
echo "All runlevel operations denied by policy" >&2
exit 101
EOF
end

Chef::Log.debug "Value of log_dir: #{node['nginx']['log_dir']}"

unless node['nginx']['log_dir'] == '/var/log/nginx' ||
       File.symlink?('/var/log/nginx')
  link '/var/log/nginx' do
    to node['nginx']['log_dir']
  end
end

package node['nginx']['package']['name'] do
  version node['nginx']['version']
  notifies :reload, 'ohai[reload_nginx]', :immediately
end

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action   :enable
end

include_recipe 'et_nginx::commons'
