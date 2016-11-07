require 'spec_helper'

describe 'collectd::plugin::write_graphite', type: :class do
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

  context 'single carbon writer' do
    let :params do
      {
        carbons: { 'graphite' => {} }
      }
    end

    it 'Will create /etc/collectd.d/conf.d/write_graphite-config.conf' do
      is_expected.to contain_concat('/etc/collectd/conf.d/write_graphite-config.conf').
        that_requires('File[collectd.d]')
      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_header').
        with(content: %r{<Plugin write_graphite>},
             target: '/etc/collectd/conf.d/write_graphite-config.conf',
             order: '00')
    end

    it 'Will create /etc/collectd.d/conf.d/write_graphite-config' do
      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_footer').
        with(content: %r{</Plugin>},
             target: '/etc/collectd/conf.d/write_graphite-config.conf',
             order: '99')
    end

    it 'includes carbon configuration' do
      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_tcp_2003').
        with(content: %r{<Carbon>},
             target: '/etc/collectd/conf.d/write_graphite-config.conf')

      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_tcp_2003').
        with(content: %r{Host "localhost"})

      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_tcp_2003').
        with(content: %r{Port "2003"})
    end
  end

  context 'multiple carbon writers, collectd <= 5.2' do
    let :params do
      {
        carbons: {
          'graphite_one' => { 'graphitehost' => '192.168.1.1', 'graphiteport' => 2004 },
          'graphite_two' => { 'graphitehost' => '192.168.1.2', 'graphiteport' => 2005 }
        }
      }
    end

    it 'includes graphite_one configuration' do
      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_one_tcp_2004').
        with(content: %r{<Carbon>},
             target: '/etc/collectd/conf.d/write_graphite-config.conf')

      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_one_tcp_2004').with(content: %r{Host "192.168.1.1"})

      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_one_tcp_2004').with(content: %r{Port "2004"})
    end

    it 'includes graphite_two configuration' do
      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_two_tcp_2005').
        with(content: %r{<Carbon>},
             target: '/etc/collectd/conf.d/write_graphite-config.conf')

      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_two_tcp_2005').
        with(content: %r{Host "192.168.1.2"})

      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_two_tcp_2005').
        with(content: %r{Port "2005"})
    end
  end

  context 'collectd >= 5.3' do
    let :facts do
      {
        osfamily: 'Debian',
        concat_basedir: '/dne',
        id: 'root',
        kernel: 'Linux',
        path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        collectd_version: '5.3',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      {
        carbons: { 'graphite' => {} }
      }
    end

    it 'includes <Node "name"> syntax' do
      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_tcp_2003').
        with(content: %r{<Node "graphite">},
             target: '/etc/collectd/conf.d/write_graphite-config.conf')
    end
  end

  context 'ensure is absent' do
    let :params do
      {
        ensure: 'absent'
      }
    end

    it 'Will not create /etc/collectd.d/conf.d/write_graphite-config.conf' do
      is_expected.not_to contain_concat__fragment('collectd_plugin_write_graphite_conf_header').
        with(content: %r{<Plugin write_graphite>},
             target: '/etc/collectd/conf.d/write_graphite-config.conf',
             order: '00')
    end

    it 'Will not create /etc/collectd.d/conf.d/write_graphite-config' do
      is_expected.not_to contain_concat__fragment('collectd_plugin_write_graphite_conf_footer').
        with(content: %r{</Plugin>},
             target: '/etc/collectd/conf.d/write_graphite-config.conf',
             order: '99')
    end
  end
end
