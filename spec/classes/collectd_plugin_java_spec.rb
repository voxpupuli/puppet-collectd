require 'spec_helper'

describe 'collectd::plugin::java', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present, defaults' do
    it 'Will load the plugin' do
      should contain_collectd__plugin('java').with({
        :ensure => 'present',
      })
    end
  end

  context ':ensure => absent' do
    let (:params) {{
      :ensure => 'absent',
    }}

    it 'will not load the plugin' do
      should contain_collectd__plugin('java').with({
        :ensure => 'absent'
      })
    end
  end

  context 'jvmarg parameter array' do
    let (:params) {{
      :jvmarg => %w{ foo bar baz }
    }}

    it 'will have multiple jvmarg parameters' do
      should contain_collectd__plugin('java').with_content(/JVMArg "foo".+JVMArg "bar".+JVMArg "baz"/m)
    end
  end

  context 'jvmarg parameter string' do
    let (:params) {{
      :jvmarg => 'bat'
    }}

    it 'will have a JVMArg parameter' do
      should contain_collectd__plugin('java').with_content(/JVMArg "bat"/)
    end

    it 'will only have one JVMArg parameter' do
      should contain_collectd__plugin('java').without_content(/(.*JVMArg.*){2,}/m)
    end
  end

  context 'jvmarg parameter empty' do
    let (:params) {{
      :jvmarg => [],
    }}

    it 'will not have a <Plugin java> stanza' do
      should contain_collectd__plugin('java').without_content(/<Plugin java>/)
    end
    it 'will not have any jvmarg parameters' do
      should contain_collectd__plugin('java').without_content(/JVMArg/)
    end
  end
end
