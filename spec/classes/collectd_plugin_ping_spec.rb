require 'spec_helper'

describe 'collectd::plugin::ping' do
  let :facts do
    { :osfamily => 'RedHat' }
  end

  context ':hosts => [\'google.com\']' do
    let :params do
      { :hosts => ['google.com'] }
    end
    it 'Will create /etc/collectd.d/10-ping.conf' do
      should contain_file('ping.load').with(:ensure  => 'present',
                                            :path    => '/etc/collectd.d/10-ping.conf',
                                            :content => /Host "google.com"/,)
    end
  end

  context ':hosts => [\'google.com\', \'puppetlabs.com\']' do
    let :params do
      { :hosts => ['google.com', 'puppetlabs.com'] }
    end
    it 'Will create /etc/collectd.d/10-ping.conf' do
      should contain_file('ping.load').with(:ensure  => 'present',
                                            :path    => '/etc/collectd.d/10-ping.conf'
                                           ).with_content(
                                             /Host "google.com"/
                                           ).with_content(
                                             /Host "puppetlabs.com"/
                                           )
    end
  end

  context ':ensure => absent' do
    let :params do
      { :hosts => ['google.com'], :ensure => 'absent' }
    end
    it 'Will not create /etc/collectd.d/10-ping.conf' do
      should contain_file('ping.load').with(:ensure => 'absent',
                                            :path   => '/etc/collectd.d/10-ping.conf',)
    end
  end

  context ':hosts is not an array' do
    let :params do
      { :hosts => 'google.com' }
    end
    it 'Will raise an error about :interfaces being a String' do
      should compile.and_raise_error(/String/)
    end
  end
end
