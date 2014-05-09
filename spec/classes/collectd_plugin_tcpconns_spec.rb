require 'spec_helper'

describe 'collectd::plugin::tcpconns', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present and :localports => [22,25]' do
    let :params do
      {:localports => [22,25]}
    end
    it 'Will create /etc/collectd.d/10-tcpconns.conf' do
      should contain_file('tcpconns.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-tcpconns.conf',
        :content => /LocalPort "22".+LocalPort "25"/m,
      })
    end
  end

  context ':ensure => present, :localports => [22,25] and :remoteports => [3306]' do
    let :params do
      {:localports => [22,25], :remoteports => [3306]}
    end
    it 'Will create /etc/collectd.d/10-tcpconns.conf' do
      should contain_file('tcpconns.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-tcpconns.conf',
        :content => /LocalPort "22".+LocalPort "25".+RemotePort "3306"/m,
      })
    end
  end

  context ':ensure => absent' do
    let :params do
      {:localports => [22], :ensure => 'absent'}
    end
    it 'Will not create /etc/collectd.d/10-tcpconns.conf' do
      should contain_file('tcpconns.load').with({
        :ensure => 'absent',
        :path   => '/etc/collectd.d/10-tcpconns.conf',
      })
    end
  end

  context ':localports is not an array' do
    let :params do
      {:localports => '22'}
    end
    it 'Will raise an error about :localports being a String' do
      expect {should}.to raise_error(Puppet::Error,/String/)
    end
  end

  context ':remoteports is not an array' do
    let :params do
      {:remoteports => '22'}
    end
    it 'Will raise an error about :remoteports being a String' do
      expect {should}.to raise_error(Puppet::Error,/String/)
    end
  end
end

