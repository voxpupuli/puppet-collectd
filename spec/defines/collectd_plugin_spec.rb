require 'spec_helper'

describe 'collectd::plugin', type: :define do
  context 'loading a plugin on collectd <= 4.9.4' do
    let(:title) { 'test' }
    let :facts do
      {
        collectd_version: '5.3',
        osfamily: 'Debian',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end

    it 'Will create /etc/collectd/conf.d/10-test.conf with the LoadPlugin syntax with brackets' do
      is_expected.to contain_file('test.load').with_content(%r{<LoadPlugin})
    end
  end

  context 'loading a plugin on collectd => 4.9.3' do
    let(:title) { 'test' }
    let :facts do
      {
        collectd_version: '4.9.3',
        osfamily: 'Debian',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end

    it 'Will create /etc/collectd/conf.d/10-test.conf with the LoadPlugin syntax without brackets' do
      is_expected.to contain_file('test.load').without_content(%r{<LoadPlugin})
    end
  end
end
