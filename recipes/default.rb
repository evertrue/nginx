#
# Cookbook Name:: nginx
# Recipe:: default
#
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

unless node['nginx']['source']['use_existing_user']
  user node['nginx']['user'] do
    system true
    shell  '/usr/sbin/nologin'
    home   '/var/www'
  end
end

directory node['nginx']['log_dir'] do
  mode      '0755'
  owner     node['nginx']['user']
  action    :create
  recursive true
end

include_recipe "et_nginx::#{node['nginx']['install_method']}"

ruby_block 'start nginx' do
  block {}
  notifies :start, 'service[nginx]'
end

node['nginx']['modules'].each do |ngx_module|
  include_recipe "et_nginx::#{ngx_module}"
end
