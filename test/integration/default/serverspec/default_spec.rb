require 'spec_helper'

describe 'Nginx' do
  describe file('/tmp/nginx_log') do
    it { is_expected.to be_directory }
  end

  describe file('/var/log/nginx') do
    it { is_expected.to be_symlink }
  end

  describe service 'nginx' do
    it { should be_running }
    it { should be_enabled }
  end

  describe port '80' do
    it { should be_listening }
  end
end
