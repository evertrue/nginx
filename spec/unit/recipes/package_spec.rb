# encoding: utf-8
require 'spec_helper'

describe 'et_nginx::package' do
  before do
    stub_command('which nginx').and_return(nil)
  end

  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      :platform => 'debian',
      :version => '7.0'
    ).converge(described_recipe)
  end

  shared_examples_for 'all platforms' do
    it 'includes the ohai_plugin recipe' do
      expect(chef_run).to include_recipe('et_nginx::ohai_plugin')
    end

    it 'includes the commons recipe' do
      expect(chef_run).to include_recipe('et_nginx::commons')
    end

    it 'enables the nginx service' do
      expect(chef_run).to enable_service('nginx')
    end
  end

  shared_examples_for 'nginx repo' do
    it 'includes the nginx repo recipe' do
      expect(chef_run).to include_recipe('et_nginx::repo')
    end
  end

  shared_examples_for 'package resource' do
    it 'installs the nginx package' do
      expect(chef_run).to install_package('nginx-extras')
    end
  end

  context 'default attributes' do
    it_behaves_like 'all platforms'
    it_behaves_like 'package resource'
  end

  context 'debian platform family' do
    context 'default attributes' do
      it_behaves_like 'all platforms'
      it_behaves_like 'package resource'
    end
  end
end
