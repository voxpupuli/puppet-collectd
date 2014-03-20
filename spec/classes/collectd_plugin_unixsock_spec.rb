require 'spec_helper'

describe 'collectd::plugin::unixsock', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present and default parameters' do
    it 'Will create /etc/collectd.d/10-unixsock.conf' do
      should contain_file('unixsock.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-unixsock.conf',
        :content => /SocketFile  \"\/var\/run\/collectd-socket\".+SocketGroup \"collectd\".+SocketPerms \"0770"/m,
      })
    end
  end

  context ':ensure => absent' do
    let :params do
      {:ensure => 'absent'}
    end
    it 'Will not create /etc/collectd.d/10-unixsock.conf' do
      should contain_file('unixsock.load').with({
        :ensure => 'absent',
        :path   => '/etc/collectd.d/10-unixsock.conf',
      })
    end
  end

  context ':socketfile is not an absolute path' do
    let :params do
      {:socketfile => 'var/run/socket'}
    end
    it 'Will raise an error about :socketfile' do
      expect {should}.to raise_error(Puppet::Error,/absolute path/)
    end
  end
end

