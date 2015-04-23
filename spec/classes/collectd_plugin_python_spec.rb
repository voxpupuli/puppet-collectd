require 'spec_helper'

describe 'collectd::plugin::python', :type => :class do

  let :facts do
    {
      :osfamily         => 'Debian',
      :concat_basedir   => tmpfilename('collectd-python'),
      :id               => 'root',
      :kernel           => 'Linux',
      :path             => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      :collectd_version => '5.0'
    }
  end

  context ':ensure => present' do
    context ':ensure => present and default parameters' do

      it 'ensures that $modulepaths exits' do
        should contain_file('/usr/share/collectd/python').with({
          :ensure  => 'directory'
        })
      end

      it 'Will create /etc/collectd/conf.d/10-python.conf to load the plugin' do
        should contain_file('python.load').with({
          :ensure  => 'present',
          :path    => '/etc/collectd/conf.d/10-python.conf',
          :content => /LoadPlugin python/,
        })
      end

      it 'Will create /etc/collectd.d/conf.d/python-config.conf' do
        should contain_concat__fragment('collectd_plugin_python_conf_header').with({
          :content => /<Plugin "python">/,
          :target  => '/etc/collectd/conf.d/python-config.conf',
          :order   => '00'
        })
      end

      it 'set default Python module path' do
        should contain_concat__fragment('collectd_plugin_python_conf_header').with({
          :content => /ModulePath "\/usr\/share\/collectd\/python"/,
          :target  => '/etc/collectd/conf.d/python-config.conf',
        })
      end

      it 'Will create /etc/collectd.d/conf.d/python-config.conf' do
        should contain_concat__fragment('collectd_plugin_python_conf_footer').with({
          :content => /<\/Plugin>/,
          :target  => '/etc/collectd/conf.d/python-config.conf',
          :order   => '99'
        })
      end
    end

    context ':ensure => present and multiple $modulepaths' do
      let :params do
        {
            :modulepaths => ['/tmp/', '/data/']
        }
      end
      it 'will ensure the two directories are here' do
        should contain_file('/tmp/')
        should contain_file('/data/')
      end
      it 'will set two modulepath in the module conf' do
        should contain_concat__fragment('collectd_plugin_python_conf_header').with(
                   {
                       :content => /ModulePath "\/tmp\/"/,
                       :target  => '/etc/collectd/conf.d/python-config.conf',
                   })
        should contain_concat__fragment('collectd_plugin_python_conf_header').with(
                   {
                       :content => /ModulePath "\/data\/"/,
                       :target  => '/etc/collectd/conf.d/python-config.conf',
                   })
      end
    end

    context ':ensure => present and configure elasticsearch module' do
      let :params do
        {
          :modules => {
            'elasticsearch' => {
              'script_source' => 'puppet:///modules/myorg/elasticsearch_collectd_python.py',
              'config'        => {'Cluster' => 'ES-clust'}
            },
            'foo' => {
              'config' => {'Verbose' => true, 'Bar' => '"bar"' }
            }
          }
        }
      end

      it 'imports elasticsearch module' do
        should contain_concat__fragment('collectd_plugin_python_conf_elasticsearch').with({
          :content => /Import "elasticsearch"/,
          :target  => '/etc/collectd/conf.d/python-config.conf',
        })
      end

      it 'includes elasticsearch module configuration' do
        should contain_concat__fragment('collectd_plugin_python_conf_elasticsearch').with({
          :content => /<Module "elasticsearch">/,
          :target  => '/etc/collectd/conf.d/python-config.conf',
        })
      end

      it 'includes elasticsearch Cluster name' do
        should contain_concat__fragment('collectd_plugin_python_conf_elasticsearch').with({
          :content => /Cluster ES-clust/,
          :target  => '/etc/collectd/conf.d/python-config.conf',
        })
      end

      it 'created collectd plugin file' do
        should contain_file('elasticsearch.script').with({
          :ensure  => 'present',
          :path    => '/usr/share/collectd/python/elasticsearch.py',
        })
      end

      # test foo module
      it 'imports foo module' do
        should contain_concat__fragment('collectd_plugin_python_conf_foo').with({
          :content => /Import "foo"/,
          :target  => '/etc/collectd/conf.d/python-config.conf',
        })
      end

      it 'includes foo module configuration' do
        should contain_concat__fragment('collectd_plugin_python_conf_foo').with({
          :content => /<Module "foo">/,
          :target  => '/etc/collectd/conf.d/python-config.conf',
        })
        should contain_concat__fragment('collectd_plugin_python_conf_foo').with({
          :content => /Verbose true/,
        })
        should contain_concat__fragment('collectd_plugin_python_conf_foo').with({
          :content => /Bar "bar"/,
        })
      end
    end

    context 'allow changing module path' do
      let :params do
        {
          :modulepaths => ['/var/lib/collectd/python', '/usr/collectd'],
          :modules    => {
            'elasticsearch' => {
              'script_source' => 'puppet:///modules/myorg/elasticsearch_collectd_python.py',
              'config'        => {'Cluster' => 'ES-clust'},
              'modulepath'    => '/var/lib/collectd/python',
            }
          }
        }
      end

      it 'ensures that each directory on $modulepaths exits' do
        should contain_file('/var/lib/collectd/python').with({
          :ensure  => 'directory'
        })

        should contain_file('/usr/collectd').with({
          :ensure  => 'directory'
        })
      end

      it 'set default Python module paths' do
        should contain_concat__fragment('collectd_plugin_python_conf_header').with({
          :content => /ModulePath "\/var\/lib\/collectd\/python"/,
          :target  => '/etc/collectd/conf.d/python-config.conf',
        })

        should contain_concat__fragment('collectd_plugin_python_conf_header').with({
          :content => /ModulePath "\/usr\/collectd"/,
        })

        should contain_concat__fragment('collectd_plugin_python_conf_header').with({
          :content => /ModulePath "\/var\/lib\/collectd\/python"/,
        })
      end

      it 'created collectd plugin file' do
        should contain_file('elasticsearch.script').with({
          :ensure  => 'present',
          :path    => '/var/lib/collectd/python/elasticsearch.py',
        })
      end
    end
  end

  context 'change globals parameter' do
    let :params do
      {
        :globals => false
      }
    end

    it 'will change $globals settings' do
      should contain_file('python.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd/conf.d/10-python.conf',
        :content => /Globals false/,
      })
    end
  end

  context 'allow passing shared options for all modules' do
    let :params do
      {
        :logtraces  => true,
        :interactive => true,
        :encoding    => 'utf-8',
      }
    end

    it 'sets options' do
      should contain_concat__fragment('collectd_plugin_python_conf_header').with({
        :content => /LogTraces true/,
      })

      should contain_concat__fragment('collectd_plugin_python_conf_header').with({
        :content => /Interactive true/,
      })

      should contain_concat__fragment('collectd_plugin_python_conf_header').with({
        :content => /Encoding utf-8/,
      })
    end
  end

  context ':ensure => absent' do
    let (:title) {'elasticsearch'}
    let :params do
      {
        :ensure        => 'absent',
        :modules => {
          'elasticsearch' => {
            'script_source' => 'puppet:///modules/myorg/elasticsearch_collectd_python.py',
            'config'        => {'Cluster' => 'ES-clust'}
          }
        }
      }
    end

    it 'will remove /etc/collectd/conf.d/10-python.conf' do
      should contain_file('python.load').with({
        :ensure  => 'absent',
        :path    => '/etc/collectd/conf.d/10-python.conf',
        :content => /LoadPlugin python/,
      })
    end

    it 'won\'t create /etc/collectd.d/conf.d/python-config.conf (no modules defined)' do
      should_not contain_concat__fragment('collectd_plugin_python_conf_header').with({
        :ensure  => 'absent',
        :target  => '/etc/collectd/conf.d/python-config.conf',
        :order   => '00'
      })
    end
  end

end
