require 'spec_helper'

describe 'collectd::plugin::disk', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present and :disks => [\'sda\']' do
    let :params do
      {:disks => ['sda']}
    end
    it 'Will create /etc/collectd.d/10-disk.conf' do
      should contain_file('disk.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-disk.conf',
        :content => /Disk  "sda"/,
      })
    end
  end

  context ':ensure => absent' do
    let :params do
      {:disks => ['sda'], :ensure => 'absent'}
    end
    it 'Will not create /etc/collectd.d/10-disk.conf' do
      should contain_file('disk.load').with({
        :ensure => 'absent',
        :path   => '/etc/collectd.d/10-disk.conf',
      })
    end
  end

  context ':disks is not an array' do
    let :params do
      {:disks => 'sda'}
    end
    it 'Will raise an error about :disks being a String' do
      expect {should}.to raise_error(Puppet::Error,/String/)
    end
  end
end

