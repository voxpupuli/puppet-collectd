require 'spec_helper'

describe 'collectd::plugin::write_graphite', :type => :class do

  let :facts do
    {
      :osfamily         => 'Debian',
      :concat_basedir   => tmpfilename('collectd-write_graphite'),
      :id               => 'root',
      :kernel           => 'Linux',
      :path             => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      :collectd_version => '5.0'
    }
  end


  context 'single carbon writer' do

    let :params do
      {
        :carbons => { 'graphite_tcp' => {} },
      }
    end

    it 'Will create /etc/collectd.d/conf.d/write_graphite-config.conf' do
      should contain_concat__fragment('collectd_plugin_write_graphite_conf_header').with({
        :content => /<Plugin write_graphite>/,
        :target  => '/etc/collectd/conf.d/write_graphite-config.conf',
        :order   => '00'
      })
    end

    it 'Will create /etc/collectd.d/conf.d/write_graphite-config' do
      should contain_concat__fragment('collectd_plugin_write_graphite_conf_footer').with({
        :content => /<\/Plugin>/,
        :target  => '/etc/collectd/conf.d/write_graphite-config.conf',
        :order   => '99'
      })
    end

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
