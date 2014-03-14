require 'spec_helper'

describe 'collectd::plugin::interface', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present and :interfaces => [\'eth0\']' do
    let :params do
      {:interfaces => ['eth0']}
    end
    it 'Will create /etc/collectd.d/10-interface.conf' do
      should contain_file('interface.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-interface.conf',
        :content => /Interface  "eth0"/,
      })
    end
  end

  context ':ensure => absent' do
    let :params do
      {:interfaces => ['eth0'], :ensure => 'absent'}
    end
    it 'Will not create /etc/collectd.d/10-interface.conf' do
      should contain_file('interface.load').with({
        :ensure => 'absent',
        :path   => '/etc/collectd.d/10-interface.conf',
      })
    end
  end

  context ':interfaces is not an array' do
    let :params do
      {:interfaces => 'eth0'}
    end
    it 'Will raise an error about :interfaces being a String' do
      expect {should}.to raise_error(Puppet::Error,/String/)
    end
  end
end

