require 'spec_helper'

describe 'collectd::plugin::java', :type => :class do
  let :facts do
    {
      :osfamily => 'RedHat',
      :collectd_version => '4.8.0',
    }
  end

  context ':ensure => present, defaults' do
    it 'Will load the plugin' do
      should contain_collectd__plugin('java').with(:ensure => 'present',)
    end
  end

  context ':ensure => absent' do
    let(:params) do
      {
        :ensure => 'absent',
      }
    end

    it 'will not load the plugin' do
      should contain_collectd__plugin('java').with(:ensure => 'absent')
    end
  end

  context 'jvmarg parameter array' do
    let(:params) do
      {
        :jvmarg => %w( foo bar baz )
      }
    end

    it 'will have multiple jvmarg parameters' do
      should contain_collectd__plugin('java').with_content(/JVMArg "foo".+JVMArg "bar".+JVMArg "baz"/m)
    end
  end

  context 'jvmarg parameter string' do
    let(:params) do
      {
        :jvmarg => 'bat'
      }
    end

    it 'will have a JVMArg parameter' do
      should contain_collectd__plugin('java').with_content(/JVMArg "bat"/)
    end

    it 'will only have one JVMArg parameter' do
      should contain_collectd__plugin('java').without_content(/(.*JVMArg.*){2,}/m)
    end
  end

  context 'jvmarg parameter string & loadplugin java hash with no options' do
    let(:params) do
      {
        :jvmarg => 'dog',
        :loadplugin => { 'name.java' => [] }
      }
    end

    it 'will have a JVMArg parameter' do
      should contain_collectd__plugin('java').with_content(/JVMArg "dog"/)
    end

    it 'will have a java plugin' do
      should contain_collectd__plugin('java').with_content(/LoadPlugin "name.java"/)
    end
  end

  context 'jvmarg parameter string & loadplugin java hash with options' do
    let(:params) do
      {
        :jvmarg     => 'dog',
        :loadplugin => { 'name.java' => ['key = value'] }
      }
    end

    it 'will have a java plugin option' do
      should contain_collectd__plugin('java').with_content(/key = value/)
    end
  end

  context 'jvmarg parameter empty' do
    let(:params) do
      {
        :jvmarg => [],
      }
    end

    it 'will not have a <Plugin java> stanza' do
      should contain_collectd__plugin('java').without_content(/<Plugin java>/)
    end
    it 'will not have any jvmarg parameters' do
      should contain_collectd__plugin('java').without_content(/JVMArg/)
    end
  end

  context 'jvmarg parameter empty & java plugin option provided' do
    let(:params) do
      {
        :jvmarg     => [],
        :loadplugin => { 'name.java' => ['key = value'] }
      }
    end

    it 'will not have a java plugin load stanza' do
      should contain_collectd__plugin('java').without_content(/name.java/)
    end

    it 'will not have java plugin options stanza' do
      should contain_collectd__plugin('java').without_content(/key = value/)
    end
  end
end
