require 'spec_helper'

describe 'collectd::plugin::memcached', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present, default host and port' do
    it 'Will create /etc/collectd.d/memcached.conf' do
      should contain_file('memcached.conf').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/memcached.conf',
        :content => /Host "127.0.0.1"\n.+Port "11211"/,
      })
    end
  end

  context ':ensure => absent' do
    let :params do
      {:ensure => 'absent'}
    end
    it 'Will not create /etc/collectd.d/memcached.conf' do
      should contain_file('memcached.conf').with({
        :ensure => 'absent',
        :path   => '/etc/collectd.d/memcached.conf',
      })
    end
  end
end

