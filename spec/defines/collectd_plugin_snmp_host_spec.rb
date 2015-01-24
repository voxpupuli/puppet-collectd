require 'spec_helper'

describe 'collectd::plugin::snmp::host', :type => :define do
  let :facts do
    {:osfamily => 'Debian'}
  end

  let (:title) { 'foo.example.com' }
  let (:required_params) {{
    :collect => 'foo'
  }}

  let (:filename) { 'snmp-host-foo.example.com.conf' }

  context 'default params' do
    let (:params) { required_params }

    it { should contain_file(filename).with(
      :ensure => 'present',
      :path   => '/etc/collectd/conf.d/25-snmp-host-foo.example.com.conf'
    ) }

    it { should contain_file(filename).that_notifies('Service[collectd]') }
    it { should contain_file(filename).with_content(/<Plugin snmp>/) }
    it { should contain_file(filename).with_content(/<Host "foo\.example\.com">/) }
    it { should contain_file(filename).with_content(/Address "foo\.example\.com"/) }
    it { should contain_file(filename).with_content(/Version 1/) }
    it { should contain_file(filename).with_content(/Community "public"/) }
    it { should contain_file(filename).without_content(/Interval \d+/) }
  end

  context 'all params set' do
    let (:params) {
      required_params.merge({
        :address   => 'bar.example.com',
        :version   => '2',
        :community => 'opensesame',
        :interval  => '30',
      })
    }
    it { should contain_file(filename).with_content(/Address "bar\.example\.com"/) }
    it { should contain_file(filename).with_content(/Version 2/) }
    it { should contain_file(filename).with_content(/Community "opensesame"/) }
    it { should contain_file(filename).with_content(/Interval 30/) }
  end

  context 'collect is an array' do
    let (:params) {{
      :collect => %w{ foo bar baz }
    }}
    it { should contain_file(filename).with_content(/Collect "foo" "bar" "baz"/) }
  end

  context 'collect is just a string' do
    let (:params) {{
      :collect => 'bat'
    }}
    it { should contain_file(filename).with_content(/Collect "bat"/) }
  end
end
