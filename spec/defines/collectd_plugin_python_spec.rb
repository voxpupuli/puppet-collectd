require 'spec_helper'

describe 'collectd::plugin::python', :type => :define do

  context ':ensure => present' do
    let :facts do
      {
          :osfamily         => 'Debian'
      }
    end
    let (:title) {'python'}

    it 'Will create /etc/collectd/conf.d/10-python.conf' do
      should contain_file('python.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd/conf.d/10-python.conf',
        :content => "<LoadPlugin \"python\">\n    Globals true\n</LoadPlugin>\n\n\n",
      })
    end
  end

  context ':ensure => absent' do
    let :facts do
      {
        :osfamily         => 'Debian'
      }
    end
    let (:title) {'python'}
    it 'Will not create /etc/collectd/conf.d/10-python.conf' do
      should contain_file('python.load').with({
        :ensure => 'absent',
        :path    => '/etc/collectd/conf.d/10-elasticsearch.conf',
      })
    end
  end
end
