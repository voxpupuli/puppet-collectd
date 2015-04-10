require 'spec_helper'

describe 'collectd::plugin::python::module', :type => :define do

  context ':ensure => present' do
    let :facts do
      {
          :osfamily         => 'Debian'
      }
    end
    let (:title) {'elasticsearch'}
    let :params do
      {
        :module        => 'elasticsearch',
        :script_source => 'puppet:///modules/myorg/elasticsearch_collectd_python.py',
        :config        => {'Cluster' => 'elasticsearch'},
      }
    end

    #it 'Will create /etc/collectd/conf.d/python-modules.conf' do
    # FIXME - handle concat & fragments?
    #end

    it 'Will create /usr/share/collectd/python/elasticsearch.py' do
      should contain_file('elasticsearch.script').with({
        :ensure  => 'present',
        :path    => '/usr/share/collectd/python/elasticsearch.py',
      })
    end
  end

  context ':ensure => absent' do
    let :facts do
      {
        :osfamily         => 'Debian'
      }
    end
    let (:title) {'elasticsearch'}
    let :params do
      {
        :ensure        => 'absent',
        :modulepath    => '/usr/share/collectd/python',
        :module        => 'elasticsearch',
        :script_source => 'puppet:///modules/myorg/elasticsearch_collectd_python.py',
        :config        => {'Cluster' => 'elasticsearch'},
      }
    end
    it 'Will not create /usr/share/collectd/python/elasticsearch.py' do
      should contain_file('elasticsearch.script').with({
        :ensure => 'absent',
        :path    => '/usr/share/collectd/python/elasticsearch.py',
      })
    end
  end

end
