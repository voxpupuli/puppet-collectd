require 'spec_helper'

describe 'collectd::plugin::filter::chain', type: :define do
  let :facts do
    {
      osfamily: 'Debian',
      concat_basedir: tmpfilename('collectd-filter'),
      id: 'root',
      kernel: 'Linux',
      path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      collectd_version: '5.0'
    }
  end

  context ':ensure => present and default parameters' do
    let(:title) { 'MyChain' }
    it 'Will create /etc/collectd/conf.d/filter-chain-MyChain.conf' do
      should contain_concat('/etc/collectd/conf.d/filter-chain-MyChain.conf').with(ensure: 'present')
      should contain_concat__fragment('/etc/collectd/conf.d/filter-chain-MyChain.conf_MyChain_head').with(
        order: '00',
        content: '<Chain "MyChain">',
        target: '/etc/collectd/conf.d/filter-chain-MyChain.conf'
      )
      should contain_concat__fragment('/etc/collectd/conf.d/filter-chain-MyChain.conf_MyChain_footer').with(
        order: '99',
        content: '</Chain>',
        target: '/etc/collectd/conf.d/filter-chain-MyChain.conf'
      )
    end
    it { should_not contain_collectd__plugin__filter__target('z_chain-MyChain-target') }
  end

  context ':ensure => present and set a default target' do
    let(:title) { 'MyChain' }
    let(:params) do
      {
        target: 'set',
        target_options: {
          'PluginInstance' => 'coretemp',
          'TypeInstance'   => 'core3'
        }
      }
    end
    it 'Will add a default target with plugin set and options' do
      should contain_collectd__plugin__filter__target('z_chain-MyChain-target').with(
        chain: 'MyChain',
        plugin: 'set',
        options: {
          'PluginInstance' => 'coretemp',
          'TypeInstance'   => 'core3'
        }
      )
    end
  end

  context ':ensure => absent' do
    let(:title) { 'MyChain' }
    let(:params) do
      {
        ensure: 'absent'
      }
    end
    it 'Will remove file /etc/collectd/conf.d/filter-chain-MyChain.conf' do
      should contain_concat('/etc/collectd/conf.d/filter-chain-MyChain.conf').with(ensure: 'absent')
    end
  end
end
