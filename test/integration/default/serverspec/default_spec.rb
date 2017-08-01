require 'spec_helper'

describe 'Nginx' do
  describe file('/tmp/nginx_log') do
    it { is_expected.to be_directory }
  end

  describe file('/var/log/nginx') do
    it { is_expected.to be_symlink }
  end

  %w(common full).each do |pkg_name|
    describe file "/etc/apt/preferences.d/nginx-#{pkg_name}.pref" do
      it { is_expected.to contain "Package: nginx-#{pkg_name}" }
    end
  end

  describe service 'nginx' do
    it { should be_running }
    it { should be_enabled }
  end

  describe port '80' do
    it { should be_listening }
  end
end
