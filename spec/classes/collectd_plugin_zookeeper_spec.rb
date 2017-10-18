require 'spec_helper'

describe 'collectd::plugin::zookeeper', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '5.5.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present and :zookeeper_host => \'myhost\'' do
    let :params do
      { zookeeper_host: 'myhost', zookeeper_port: '2181' }
    end

    it 'Will create /etc/collectd.d/10-zookeeper.conf' do
      is_expected.to contain_file('write_riemann.load').with(ensure: 'present')
      is_expected.to contain_file('write_riemann.load').with(path: '/etc/collectd.d/10-zookeeper.conf')
      is_expected.to contain_file('write_riemann.load').with(content: %r{Host "myhost"})
      is_expected.to contain_file('write_riemann.load').with(content: %r{Port "2181"})
    end
  end

  context ':ensure => absent' do
    let :params do
      { zookeeper_host: ['myhost'], ensure: 'absent' }
    end

    it 'Will not create ' do
      is_expected.to contain_file('zookeeper.load').with(ensure: 'absent',
                                                         path: '/etc/collectd.d/10-zookeeper.conf')
    end
  end
end
