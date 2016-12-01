require 'spec_helper'

describe 'collectd::plugin::memcached', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present, default host and port' do
    it 'Will create /etc/collectd.d/memcached.conf' do
      is_expected.to contain_file('memcached.load').with(ensure: 'present',
                                                         path: '/etc/collectd.d/10-memcached.conf',
                                                         content: %r{Host "127.0.0.1"\n.+Port 11211})
    end
  end

  context ':ensure => present, multiple ports' do
    let :params do
      {
        'instances' => {
          'sessions1' => {
            'host' => '127.0.0.1',
            'port' => '11211'
          },
          'cache1' => {
            'host' => '127.0.0.1',
            'port' => '11212'
          }
        }
      }
    end
    it 'Will create /etc/collectd.d/memcached.conf' do
      content = <<EOS
  <Instance "sessions1">
    Host "127.0.0.1"
    Port 11211
  </Instance>
  <Instance "cache1">
    Host "127.0.0.1"
    Port 11212
  </Instance>
EOS
      is_expected.to contain_file('memcached.load').with(ensure: 'present',
                                                         path: '/etc/collectd.d/10-memcached.conf',
                                                         content: %r{#{content}})
    end
  end

  context ':ensure => present, multiple sockets' do
    let :params do
      {
        'instances' => {
          'sessions2' => {
            'socket' => '/var/run/memcached.sessions.sock'
          },
          'cache2' => {
            'socket' => '/var/run/memcached.cache.sock'
          }
        }
      }
    end
    it 'Will create /etc/collectd.d/memcached.conf' do
      content = <<EOS
  <Instance "sessions2">
    Socket "/var/run/memcached.sessions.sock"
  </Instance>
  <Instance "cache2">
    Socket "/var/run/memcached.cache.sock"
  </Instance>
EOS
      is_expected.to contain_file('memcached.load').with(ensure: 'present',
                                                         path: '/etc/collectd.d/10-memcached.conf',
                                                         content: %r{#{content}})
    end
  end

  context ':ensure => absent' do
    let :params do
      { ensure: 'absent' }
    end
    it 'Will not create /etc/collectd.d/memcached.conf' do
      is_expected.to contain_file('memcached.load').with(ensure: 'absent',
                                                         path: '/etc/collectd.d/10-memcached.conf')
    end
  end
end
