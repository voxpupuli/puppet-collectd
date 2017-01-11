require 'spec_helper'

describe 'collectd::plugin::threshold', type: :class do
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
      it 'Will create /etc/collectd/conf.d/10-threshold.conf to load the plugin' do
        is_expected.to contain_file('threshold.load').
          with(ensure: 'present',
               path: '/etc/collectd/conf.d/10-threshold.conf',
               content: %r{LoadPlugin threshold})
      end
    end
  end
end
