require 'spec_helper'

describe 'collectd::plugin::processes', type: :class do
  let :facts do
    {
      osfamily: 'Debian',
      concat_basedir: '/dne',
      id: 'root',
      kernel: 'Linux',
      path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      collectd_version: '5.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present' do
    context ':ensure => present and default parameters' do
      it 'Will create /etc/collectd/conf.d/10-processes.conf to load the plugin' do
        is_expected.to contain_file('processes.load').
          with(ensure: 'present',
               path: '/etc/collectd/conf.d/10-processes.conf',
               content: %r{LoadPlugin processes})
      end

      it 'Will create /etc/collectd.d/conf.d/processes-config.conf' do
        is_expected.to contain_concat('/etc/collectd/conf.d/processes-config.conf').that_requires('File[collectd.d]')
        is_expected.to contain_concat__fragment('collectd_plugin_processes_conf_header').
          with(content: %r{<Plugin processes>},
               target: '/etc/collectd/conf.d/processes-config.conf',
               order: '00')
      end

      it 'Will create /etc/collectd.d/conf.d/processes-config.conf' do
        is_expected.to contain_concat__fragment('collectd_plugin_processes_conf_footer').
          with(content: %r{</Plugin>},
               target: '/etc/collectd/conf.d/processes-config.conf',
               order: '99')
      end
    end
  end
end
