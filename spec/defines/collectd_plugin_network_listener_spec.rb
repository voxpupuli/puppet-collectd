require 'spec_helper'

describe 'collectd::plugin::network::listener', :type => :define do

  context ':ensure => present, collectd version 4.6' do
    let :facts do
      {
        :osfamily         => 'Redhat',
        :collectd_version => '4.6'
      }
    end
    let (:title) {'mylistener'}
    let :params do
      {
        :port => '1234',
      }
    end

    it 'Will create /etc/collectd.d/network-listener-mylistener.conf for collectd < 4.7' do
      should contain_file('/etc/collectd.d/network-listener-mylistener.conf').with({
         :ensure  => 'present',
         :path    => '/etc/collectd.d/network-listener-mylistener.conf',
         :content => "<Plugin network>\n  Listen \"mylistener\" \"1234\"\n</Plugin>\n",
       })
    end
  end

  context ':ensure => present, collectd version 5.1.0' do
    let :facts do
      {
        :osfamily         => 'Redhat',
        :collectd_version => '5.1.0'
      }
    end
    let (:title) {'mylistener'}
    let :params do
      {
        :port => '1234',
      }
    end

    it 'Will create /etc/collectd.d/network-listener-mylistener.conf for collectd >= 4.7' do
      should contain_file('/etc/collectd.d/network-listener-mylistener.conf').with({
         :ensure  => 'present',
         :path    => '/etc/collectd.d/network-listener-mylistener.conf',
         :content => "<Plugin network>\n  <Listen \"mylistener\" \"1234\">\n\n  </Listen>\n</Plugin>\n",
       })
    end
  end
end
