require 'spec_helper'

describe 'collectd::plugin', :type => :define do
  context 'loading a plugin on collectd <= 4.9.4' do
    let(:title) { 'test' }
    let :facts do
      {
        :collectd_version => '5.3',
        :osfamily         => 'Debian',
      }
    end

    it 'Will create /etc/collectd/conf.d/10-test.conf with the LoadPlugin syntax with brackets' do
      should contain_file('test.load').with_content(/<LoadPlugin/)
    end
  end

  context 'loading a plugin on collectd => 4.9.3' do
    let(:title) { 'test' }
    let :facts do
      {
        :collectd_version => '4.9.3',
        :osfamily         => 'Debian',
      }
    end

    it 'Will create /etc/collectd/conf.d/10-test.conf with the LoadPlugin syntax without brackets' do
      should contain_file('test.load').without_content(/<LoadPlugin/)
    end
  end
end
