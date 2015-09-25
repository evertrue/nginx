# encoding: utf-8

describe 'et_nginx::default' do
  before do
    stub_command('which nginx').and_return(nil)
  end

  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  shared_examples_for 'default recipe' do
  end

  context 'unmodified attributes' do
    it 'includes the package recipe' do
      expect(chef_run).to include_recipe('et_nginx::package')
    end

    it 'does not include a module recipe' do
      expect(chef_run).to_not include_recipe('module_http_stub_status')
    end

    it_behaves_like 'default recipe'
  end

  context 'installs modules based on attributes' do
    it 'includes a module recipe when specified' do
      chef_run.node.set['nginx']['modules'] = ['module_http_geoip']
      chef_run.converge(described_recipe)

      expect(chef_run).to include_recipe('et_nginx::module_http_geoip')
    end
  end
end
