require 'spec_helper'

describe 'collectd::plugin::write_graphite::carbon', :type => :define do
  let :facts do
    {
      :osfamily       => 'Debian',
      :id             => 'root',
      :concat_basedir => tmpfilename('collectd-graphite'),
      :path           => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    }
  end

  context 'protocol should not be include with version < 5.4' do
    let(:title) { 'graphite_udp' }
    let :facts do
      { :osfamily => 'RedHat',
        :collectd_version => '5.3',
      }
    end
    let :params do
      { :protocol => 'udp',
      }
    end

    it 'Should not include protocol in /etc/collectd.d/write_graphite.conf for collectd < 5.4' do
      should_not contain_concat__fragment(
        'collectd_plugin_write_graphite_conf_localhost_2003'
      ).with_content(/.*Protocol \"udp\".*/)
    end
  end

  context 'protocol should be include with version >= 5.4' do
    let(:title) { 'graphite_udp' }
    let :facts do
      { :osfamily => 'RedHat',
        :collectd_version => '5.4',
      }
    end
    let :params do
      { :protocol => 'udp',
      }
    end

    it 'Should include protocol in /etc/collectd.d/write_graphite.conf for collectd >= 5.4' do
      should contain_concat__fragment(
        'collectd_plugin_write_graphite_conf_localhost_2003'
      ).with_content(/.*Protocol \"udp\".*/)
    end
  end

  context 'default configuration' do

    it 'includes carbon configuration' do
      should contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_tcp').with({
        :content => /<Carbon>/,
        :target  => '/etc/collectd/conf.d/write_graphite-config.conf',
      })

      should contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_tcp').with({
        :content => /Host "localhost"/,
      })

      should contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_tcp').with({
        :content => /Port "2003"/,
      })
    end

  end

end