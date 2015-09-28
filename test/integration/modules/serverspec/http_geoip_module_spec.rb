# Encoding: utf-8
require_relative 'spec_helper'

describe file('/etc/nginx/conf.d/http_geoip.conf') do
  it { should be_a_file }

  its(:content) { should match(%r{/srv/geoip/GeoIP.dat}) }
end

# FIXME: This will not sustain a version update
describe command('/usr/sbin/nginx -V') do
  its(:stderr) { should match(/--with-http_geoip_module/) }
end

describe service('nginx') do
  it { should be_running }
end
