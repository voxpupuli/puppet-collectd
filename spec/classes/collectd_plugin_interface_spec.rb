require 'spec_helper'

describe 'collectd::plugin::interface', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present and :interfaces => [\'eth0\']' do
    let :params do
      {:interfaces => ['eth0']}
    end
    it 'Will create /etc/collectd.d/interface.conf' do
      should contain_file('interface.conf').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/interface.conf',
        :content => /Interface  "eth0"/,
      })
    end
  end

  context ':ensure => absent' do
    let :params do
      {:interfaces => ['eth0'], :ensure => 'absent'}
    end
    it 'Will not create /etc/collectd.d/interface.conf' do
      should contain_file('interface.conf').with({
        :ensure => 'absent',
        :path   => '/etc/collectd.d/interface.conf',
      })
    end
  end

  context ':interfaces is not an array' do
    let :params do
      {:interfaces => 'sda'}
    end
    it 'Will raise an error about :disks being a String' do
      expect {should}.to raise_error(Puppet::Error,/String/)
    end
  end
end

