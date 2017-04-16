require 'spec_helper'

describe 'collectd::plugin::oracle', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  let(:config_filename) { '/etc/collectd.d/15-oracle.conf' }

  context ':ensure => present, default host and port' do
    it 'Will create /etc/collectd.d/10-oracle.conf' do
      is_expected.to contain_file('oracle.load').with(ensure: 'present',
                                                      path: '/etc/collectd.d/10-oracle.conf',
                                                      content: %r{LoadPlugin oracle})
    end

    it 'Will create /etc/collectd.d/15-oracle.conf' do
      is_expected.to contain_concat(config_filename).with(ensure: 'present',
                                                          path: config_filename)
    end

    it { is_expected.to contain_concat__fragment('collectd_plugin_oracle_conf_header').with_content(%r{<Plugin oracle>}) }
    it { is_expected.to contain_concat__fragment('collectd_plugin_oracle_conf_footer').with_content(%r{</Plugin>}) }
  end

  context ':ensure => absent' do
    let :params do
      { ensure: 'absent' }
    end

    it 'Will not create /etc/collectd.d/10-oracle.conf' do
      is_expected.to contain_file('oracle.load').with(ensure: 'absent',
                                                      path: '/etc/collectd.d/10-oracle.conf')
    end

    it 'Will not create /etc/collectd.d/15-oracle.conf' do
      is_expected.to contain_concat(config_filename).with(ensure: 'absent',
                                                          path: config_filename)
    end
  end
end
