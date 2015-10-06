require 'spec_helper'

describe 'collectd::plugin::protocols', :type => :class do
  let :facts do
    { :osfamily => 'RedHat' }
  end

  context ':ensure => present, default params' do
    it 'Will create /etc/collectd.d/10-protocols.conf' do
      should contain_file('protocols.load')
        .with(:ensure  => 'present',
              :path    => '/etc/collectd.d/10-protocols.conf',
              :content => //,)
    end
  end

  context ':ensure => present, specific params' do
    let :params do
      { :values => %w(protocol1 protocol2),
      }
    end

    it 'Will create /etc/collectd.d/10-protocols.conf' do
      should contain_file('protocols.load')
        .with(:ensure  => 'present',
              :path    => '/etc/collectd.d/10-protocols.conf',
              :content => %r{<Plugin "protocols">\n\s*Value "protocol1"\n\s*Value "protocol2"\n</Plugin>},)
    end
  end

  context ':ensure => absent' do
    let :params do
      { :ensure => 'absent' }
    end

    it 'Will not create /etc/collectd.d/10-protocols.conf' do
      should contain_file('protocols.load')
        .with(:ensure => 'absent',
              :path   => '/etc/collectd.d/10-protocols.conf',)
    end
  end
end
