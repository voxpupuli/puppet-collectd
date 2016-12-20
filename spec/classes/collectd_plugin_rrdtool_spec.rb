require 'spec_helper'

describe 'collectd::plugin::rrdtool', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present, default args' do
    it 'Will create /etc/collectd.d/10-rrdtool.conf' do
      is_expected.to contain_file('rrdtool.load').
        with(ensure: 'present',
             path: '/etc/collectd.d/10-rrdtool.conf',
             content: %r{DataDir "/var/lib/collectd/rrd})
    end

    it do
      is_expected.to contain_package('collectd-rrdtool').with(
        ensure: 'present'
      )
    end
  end

  context ':ensure => absent' do
    let :params do
      { ensure: 'absent' }
    end
    it 'Will not create /etc/collectd.d/10-rrdtool.conf' do
      is_expected.to contain_file('rrdtool.load').
        with(ensure: 'absent',
             path: '/etc/collectd.d/10-rrdtool.conf')
    end
  end
end
