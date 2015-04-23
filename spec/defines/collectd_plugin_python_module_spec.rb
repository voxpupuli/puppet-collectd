require 'spec_helper'

describe 'collectd::plugin::python::module', :type => :define do
  let :facts do
    {
      :osfamily       => 'Debian',
      :id             => 'root',
      :concat_basedir => tmpfilename('collectd-python'),
      :path           => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    }
  end

  context 'spam module' do
    let(:title) { 'spam' }
    let :params do
      {
        :config     => { 'spam' => '"wonderful" "lovely"' },
        :modulepath => '/var/lib/collectd/python',
      }
    end

    it 'imports spam module' do
      should contain_concat__fragment('collectd_plugin_python_conf_spam').with({
        :content => /Import "spam"/,
        :target  => '/etc/collectd/conf.d/python-config.conf',
      })
    end

    it 'includes spam module configuration' do
      should contain_concat__fragment('collectd_plugin_python_conf_spam').with({
        :content => /<Module "spam">/,
        :target  => '/etc/collectd/conf.d/python-config.conf',
      })

      should contain_concat__fragment('collectd_plugin_python_conf_spam').with({
        :content => /spam "wonderful" "lovely"/,
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

  context 'module without modulepath' do
    let(:title) { 'foo' }
    let :params do
      {
        :script_source => 'puppet:///modules/myorg/foo.py',
        :config        => { 'bar' => 'baz' },
      }
    end

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
        :content => /bar baz/,
      })
    end

    it 'created collectd plugin file on Debian default path' do
      should contain_file('foo.script').with({
        :ensure  => 'present',
        :path    => '/usr/share/collectd/python/foo.py',
      })
    end

  end
end
