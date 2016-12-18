require 'spec_helper'

describe 'collectd::plugin::write_prometheus', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '5.7.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present and :port => \'9103\'' do
    let :params do
      { port: '9103' }
    end
    it 'Will create /etc/collectd.d/10-write_prometheus.conf' do
      is_expected.to contain_file('write_prometheus.load').with(ensure: 'present')
      is_expected.to contain_file('write_prometheus.load').with(path: '/etc/collectd.d/10-write_prometheus.conf')
      is_expected.to contain_file('write_prometheus.load').with(content: %r{Port "9103"})
    end
  end

  context ':ensure => absent' do
    let :params do
      { ensure: 'absent' }
    end
    it 'Will not create ' do
      is_expected.to contain_file('write_prometheus.load').with(ensure: 'absent',
                                                                path: '/etc/collectd.d/10-write_prometheus.conf')
    end
  end
end
