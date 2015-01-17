require 'spec_helper'

describe 'collectd::plugin::genericjmx', :type => :class do
  let (:facts) {{
    :osfamily       => 'RedHat',
    :concat_basedir => tmpfilename('collectd-genericjmx'),
  }}

  let (:config_filename) { '/etc/collectd.d/15-genericjmx.conf' }

  context ':ensure => present, defaults' do
    it 'will include the java plugin' do
      should contain_class('collectd::plugin::java')
    end

    it 'will load the genericjmx plugin' do
      should contain_concat(config_filename).with({
        :ensure         => 'present',
        :mode           => '0640',
        :owner          => 'root',
        :group          => 'root',
        :ensure_newline => true
      })
    end

    it { should contain_concat(config_filename).that_notifies('Service[collectd]') }

    it do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_header').with({
        :order   => '00',
        :target  => config_filename,
        :content => /<Plugin "java">\s+LoadPlugin "org\.collectd\.java\.GenericJMX"\s+<Plugin "GenericJMX">/s
      })
    end

    it do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_footer').with({
        :order   => '99',
        :target  => config_filename,
        :content => %r{</Plugin>\s+</Plugin>}s,
      })
    end

  end

  context ':ensure => absent' do
    let (:params) {{ :ensure => 'absent' }}
    it 'should not load the plugin' do
      should contain_concat(config_filename).with({
        :ensure => 'absent',
      })
    end
  end

  context 'jvmarg parameter array' do
    let (:params) {{ :jvmarg => %w{ foo bar baz } }}
    it 'should have multiple jvmarg parameters' do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_header').with_content(/JVMArg "foo"\s*JVMArg "bar"\s*JVMArg "baz"/s)
    end
  end

  context 'jvmarg parameter string' do
    let (:params) {{ :jvmarg => "bat" }}
    it 'should have one jvmarg parameter' do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_header').with_content(/JVMArg "bat"/)
    end
    it 'should have ONLY one jvmarg parameter' do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_header').without_content(/(.*JVMArg.*){2,}/s)
    end
  end

  context 'jvmarg parameter empty' do
    let (:params) {{ :jvmarg => [] }}
    it 'should not have any jvmarg parameters' do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_header').without_content(/JVMArg/)
    end
  end
end

