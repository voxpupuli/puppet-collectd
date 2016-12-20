require 'spec_helper'

describe 'collectd::plugin::filter::rule', type: :define do
  let :facts do
    {
      osfamily: 'Debian',
      concat_basedir: '/dne',
      id: 'root',
      kernel: 'Linux',
      path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      collectd_version: '5.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  let(:title) { 'MyRule' }
  let(:params) { { chain: 'MyChain' } }

  context 'Add rule' do
    it 'create header and footer of rule' do
      is_expected.to contain_concat__fragment('/etc/collectd/conf.d/filter-chain-MyChain.conf_10_MyRule_0').with(
        order: '10_MyRule_0',
        content: '  <Rule "MyRule">',
        target: '/etc/collectd/conf.d/filter-chain-MyChain.conf'
      )
      is_expected.to contain_concat__fragment('/etc/collectd/conf.d/filter-chain-MyChain.conf_10_MyRule_99').with(
        order: '10_MyRule_99',
        content: '  </Rule>',
        target: '/etc/collectd/conf.d/filter-chain-MyChain.conf'
      )
    end
  end
end
