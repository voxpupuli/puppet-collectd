require 'spec_helper'

describe 'collectd::plugin::write_graphite::carbon', type: :define do
  let :facts do
    {
      osfamily: 'Debian',
      id: 'root',
      concat_basedir: '/dne',
      path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context 'protocol should not be include with version < 5.4' do
    let(:title) { 'graphite_udp' }
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.3',
        concat_basedir: '/dne',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      {
        protocol: 'udp'
      }
    end

    it 'does not include protocol in /etc/collectd.d/write_graphite.conf for collectd < 5.4' do
      is_expected.not_to contain_concat__fragment(
        'collectd_plugin_write_graphite_conf_localhost_2003'
      ).with_content(%r{.*Protocol \"udp\".*})
    end
  end

  context 'protocol should be include with version >= 5.4' do
    let(:title) { 'wg' }
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        concat_basedir: '/dne',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      {
        protocol: 'udp'
      }
    end

    it 'includes protocol in /etc/collectd.d/write_graphite.conf for collectd >= 5.4' do
      is_expected.to contain_concat__fragment(
        'collectd_plugin_write_graphite_conf_wg_udp_2003'
      ).with_content(%r{.*Protocol \"udp\".*})
    end

    it 'uses Node definition' do
      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_wg_udp_2003').with(content: %r{<Node "wg">},
                                                                                                      target: '/etc/collectd.d/write_graphite-config.conf')
    end
  end

  context 'default configuration (undefined collectd version)' do
    let(:title) { 'graphite_default' }

    it 'includes carbon configuration' do
      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_default_tcp_2003').with(content: %r{<Carbon>},
                                                                                                                    target: '/etc/collectd/conf.d/write_graphite-config.conf')

      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_default_tcp_2003').with(content: %r{Host "localhost"})

      is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_default_tcp_2003').with(content: %r{Port "2003"})
    end
  end
end
