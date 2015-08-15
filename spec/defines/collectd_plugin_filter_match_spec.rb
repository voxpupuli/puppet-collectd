require 'spec_helper'

describe 'collectd::plugin::filter::match', type: :define do
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

  let(:title) { 'MyMatch' }
  let(:default_params) { { chain: 'MyChain', rule: 'MyRule' } }
  let(:concat_fragment_target) { '/etc/collectd/conf.d/filter-chain-MyChain.conf' }
  let(:concat_fragment_order) { '10_MyRule_1_MyMatch' }
  let(:concat_fragment_name) { '/etc/collectd/conf.d/filter-chain-MyChain.conf_10_MyRule_1_MyMatch' }

  context 'Add match regex to rule with options' do
    let(:params) do
      default_params.merge(plugin: 'regex',
                           options: {
                             'Host'   => 'customer[0-9]+',
                             'Plugin' => '^foobar$'
                           })
    end
    it 'Will ensure that plugin is loaded' do
      should contain_collectd__plugin('match_regex').with(order: '02')
    end
    it 'Will add match to rule' do
      should contain_concat__fragment(concat_fragment_name).with(
        order: concat_fragment_order,
        target: concat_fragment_target
      )
      should contain_concat__fragment(concat_fragment_name).with(content: /<Match "regex">/)
      should contain_concat__fragment(concat_fragment_name).with(content: /Host "customer\[0-9\]\+"/)
      should contain_concat__fragment(concat_fragment_name).with(content: /Plugin "\^foobar\$"/)
    end
  end

  context 'Add match empty_counter to rule without options' do
    let(:params) do
      default_params.merge(plugin: 'empty_counter')
    end
    it 'Will ensure that plugin is loaded' do
      should contain_collectd__plugin('match_empty_counter').with(order: '02')
    end
    it 'Will add match to rule' do
      should contain_concat__fragment(concat_fragment_name).with(
        order: concat_fragment_order,
        target: concat_fragment_target
      )
      should contain_concat__fragment(concat_fragment_name).with(content: /Match "empty_counter"/)
    end
  end
end
