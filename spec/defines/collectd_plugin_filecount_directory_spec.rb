require 'spec_helper'

describe 'collectd::plugin::filecount::directory', :type => :define do
  let :facts do
    { :osfamily => 'Debian' }
  end

  context 'simple case' do
    let(:title) { 'test' }
    let :params do
      {
        :path => '/var/tmp/test',
      }
    end
    it 'Will create /etc/collectd/conf.d/15-filecount-test.conf' do
      should contain_file('/etc/collectd/conf.d/15-filecount-test.conf').with_content("<Plugin \"filecount\">\n  <Directory \"/var/tmp/test\">\n    Instance \"test\"\n  </Directory>\n</Plugin>\n")
    end
  end

  context 'advanced case' do
    let(:title) { 'test' }
    let :params do
      {
        :path          => '/path/to/dir',
        :pattern       => '*.conf',
        :mtime         => '-5m',
        :recursive     => true,
        :includehidden => false,
      }
    end
    it 'Will create /etc/collectd/conf.d/15-filecount-test.conf' do
      should contain_file('/etc/collectd/conf.d/15-filecount-test.conf').with_content("<Plugin \"filecount\">\n  <Directory \"/path/to/dir\">\n    Instance \"test\"\n    Name \"*.conf\"\n    MTime \"-5m\"\n    Recursive true\n    IncludeHidden false\n  </Directory>\n</Plugin>\n")
    end
  end

  context 'recursive and includehidden false' do
    let(:title) { 'test' }
    let :params do
      {
        :path          => '/var/tmp/test',
        :recursive     => false,
        :includehidden => false,
      }
    end
    it 'Will create /etc/collectd/conf.d/15-filecount-test.conf' do
      should contain_file('/etc/collectd/conf.d/15-filecount-test.conf').with_content("<Plugin \"filecount\">\n  <Directory \"/var/tmp/test\">\n    Instance \"test\"\n    Recursive false\n    IncludeHidden false\n  </Directory>\n</Plugin>\n")
    end
  end

  context 'ensure => absent' do
    let(:title) { 'test' }
    let :params do
      {
        :ensure => 'absent',
        :path   => '/var/tmp/test',
      }
    end
    it 'Will create /etc/collectd/conf.d/15-filecount-test.conf' do
      should contain_file('/etc/collectd/conf.d/15-filecount-test.conf').with(:ensure => 'absent',
                                                                              :path   => '/etc/collectd/conf.d/15-filecount-test.conf',)
    end
  end
end
