# encoding: utf-8

describe 'nginx::repo' do
  context 'Debian' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:platform => 'debian', :version => '7.0').converge(described_recipe)
    end

    it 'includes apt recipe' do
      expect(chef_run).to include_recipe('apt::default')
    end

    it 'adds apt repository' do
      expect(chef_run).to add_apt_repository('nginx')
    end
  end
end
