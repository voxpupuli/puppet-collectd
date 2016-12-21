require 'spec_helper'

describe 'collectd::plugin::oracle', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present, default host and port' do
    it 'Will create /etc/collectd.d/10-oracle.conf' do
      is_expected.to contain_file('oracle.load').with(ensure: 'present',
                                                         path: '/etc/collectd.d/10-oracle.conf',
                                                         content: %r{<LoadPlugin oracle>})
    end
  end

  context ':ensure => absent' do
    let :params do
      { ensure: 'absent' }
    end
    it 'Will not create /etc/collectd.d/10-oracle.conf' do
      is_expected.to contain_file('memcached.load').with(ensure: 'absent',
                                                         path: '/etc/collectd.d/10-oracle.conf')
    end
  end
end
