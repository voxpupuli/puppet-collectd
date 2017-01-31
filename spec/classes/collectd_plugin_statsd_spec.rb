require 'spec_helper'

describe 'collectd::plugin::statsd', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  let :pre_condition do
    'include ::collectd'
  end

  context ':ensure => present' do
    context ':ensure => present and default parameters' do
      it 'Will create /etc/collectd.d/10-statsd.conf' do
        is_expected.to contain_file('statsd.load').with(ensure: 'present',
                                                        path: '/etc/collectd.d/10-statsd.conf',
                                                        content: %r{<Plugin statsd>\n</Plugin>})
      end
    end

    context ':ensure => present and hostname and port' do
      let :params do
        {
          ensure: 'present',
          host: '192.0.0.1',
          port: '9876'
        }
      end
      it 'Will create /etc/collectd.d/10-statsd.conf' do
        is_expected.to contain_file('statsd.load').with(ensure: 'present',
                                                        path: '/etc/collectd.d/10-statsd.conf',
                                                        content: %r{Host "192.0.0.1".+Port 9876}m)
      end
    end

    context ':ensure => present and countersum' do
      let :params do
        {
          ensure: 'present',
          countersum: true
        }
      end
      it 'Will create /etc/collectd.d/10-statsd.conf' do
        is_expected.to contain_file('statsd.load').with(ensure: 'present',
                                                        path: '/etc/collectd.d/10-statsd.conf',
                                                        content: %r{CounterSum true}m)
      end
    end
  end

  context ':ensure => absent' do
    let :params do
      {
        ensure: 'absent'
      }
    end
    it 'Will not create /etc/collectd.d/10-statsd.conf' do
      is_expected.to contain_file('statsd.load').with(ensure: 'absent',
                                                      path: '/etc/collectd.d/10-statsd.conf')
    end
  end
end
