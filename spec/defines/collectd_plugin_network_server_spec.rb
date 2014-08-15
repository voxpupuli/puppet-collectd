require 'spec_helper'

describe 'collectd::plugin::network::server', :type => :define do

  context ':ensure => present, create one complex server, collectd 5.1.0' do
    let :facts do
      {
          :osfamily         => 'Redhat',
          :collectd_version => '5.1.0'
      }
    end
    let (:title) {'node1'}
    let :params do
      {
        :port          => '1234',
        :interface     => 'eth0',
        :securitylevel => 'Encrypt',
        :username      => 'foo',
        :password      => 'bar',
      }
    end

    it 'Will create /etc/collectd.d/network-server-node1.conf for collectd >= 4.7' do
      should contain_file('/etc/collectd.d/network-server-node1.conf').with({
         :ensure  => 'present',
         :path    => '/etc/collectd.d/network-server-node1.conf',
         :content => "<Plugin network>\n  <Server \"node1\" \"1234\">\n    SecurityLevel \"Encrypt\"\n    Username \"foo\"\n    Password \"bar\"\n    Interface \"eth0\"\n\n  </Server>\n</Plugin>\n",
       })
    end
  end

  context ':ensure => absent' do
    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end
    let (:title) {'node1'}
    let :params do
      {
        :ensure => 'absent'
      }
    end

    it 'Will not create /etc/collectd.d/network-server-node1.conf' do
      should contain_file('/etc/collectd.d/network-server-node1.conf').with({
        :ensure => 'absent',
      })
    end
  end

end
