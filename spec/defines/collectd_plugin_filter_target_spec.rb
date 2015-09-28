require 'spec_helper'

describe 'collectd::plugin::filter::target', type: :define do
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

  let(:title) { 'MyTarget' }
  let(:default_params) { { chain: 'MyChain' } }
  let(:concat_fragment_target) { '/etc/collectd/conf.d/filter-chain-MyChain.conf' }

  context 'Add target set to rule with options' do
    let(:concat_fragment_order) { '10_MyRule_30_MyTarget' }
    let(:concat_fragment_name) { '/etc/collectd/conf.d/filter-chain-MyChain.conf_10_MyRule_30_MyTarget' }
    let(:params) do
      default_params.merge(plugin: 'set',
                           rule: 'MyRule',
                           options: {
                             'PluginInstance' => 'coretemp',
                             'TypeInstance'   => 'core3'
                           })
    end
    it 'Will ensure that plugin is loaded' do
      should contain_collectd__plugin('target_set').with(order: '02')
    end
    it 'Will add target to rule' do
      should contain_concat__fragment(concat_fragment_name).with(
        order: concat_fragment_order,
        target: concat_fragment_target
      )
      should contain_concat__fragment(concat_fragment_name).with(content: /<Target "set">/)
      should contain_concat__fragment(concat_fragment_name).with(content: /PluginInstance "coretemp"/)
      should contain_concat__fragment(concat_fragment_name).with(content: /TypeInstance "core3"/)
    end
  end

  context 'Add builtin target return without rule to chain' do
    let(:concat_fragment_order) { '20_50_MyTarget' }
    let(:concat_fragment_name) { '/etc/collectd/conf.d/filter-chain-MyChain.conf_20_50_MyTarget' }
    let(:params) do
      default_params.merge(plugin: 'return')
    end
    it 'Builtin plugin should not be tried to load' do
      should_not contain_collectd__plugin('target_return')
    end
    it 'Will add target to chain' do
      should contain_concat__fragment(concat_fragment_name).with(
        order: concat_fragment_order,
        target: concat_fragment_target
      )
      should contain_concat__fragment(concat_fragment_name).with(content: /Target "return"/)
    end
  end
end
