require 'spec_helper'

describe 'collectd::plugin::genericjmx', :type => :class do
  let(:facts) do
    {
      :osfamily       => 'Debian',
      :id             => 'root',
      :concat_basedir => tmpfilename('collectd-genericjmx'),
      :path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    }
  end

  let(:config_filename) { '/etc/collectd/conf.d/15-genericjmx.conf' }

  context 'defaults' do
    it 'will include the java plugin' do
      should contain_class('collectd::plugin::java')
    end

    it 'will load the genericjmx plugin' do
      should contain_concat(config_filename)
        .with(:ensure         => 'present',
              :mode           => '0640',
              :owner          => 'root',
              :group          => 'root',
              :ensure_newline => true)
    end

    it { should contain_concat(config_filename).that_notifies('Service[collectd]') }

    it do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_header')
        .with(:order   => '00',
              :target  => config_filename,
              :content => /<Plugin "java">.+LoadPlugin "org\.collectd\.java\.GenericJMX".+<Plugin "GenericJMX">/m)
    end

    it do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_footer')
        .with(:order   => '99',
              :target  => config_filename,
              :content => %r{</Plugin>.+</Plugin>}m,)
    end
  end

  context 'jvmarg parameter array' do
    let(:params) { { :jvmarg => %w( foo bar baz ) } }
    it 'should have multiple jvmarg parameters' do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_header')
        .with_content(/JVMArg "foo".*JVMArg "bar".*JVMArg "baz"/m)
    end
  end

  context 'jvmarg parameter string' do
    let(:params) { { :jvmarg => 'bat' } }
    it 'should have one jvmarg parameter' do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_header').with_content(/JVMArg "bat"/)
    end
    it 'should have ONLY one jvmarg parameter other than classpath' do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_header').without_content(/(.*JVMArg.*){3,}/m)
    end
  end

  context 'jvmarg parameter empty' do
    let(:params) { { :jvmarg => [] } }
    it 'should not have any jvmarg parameters other than classpath' do
      should contain_concat__fragment('collectd_plugin_genericjmx_conf_header').without_content(/(.*JVMArg.*){2,}/m)
    end
  end
end
