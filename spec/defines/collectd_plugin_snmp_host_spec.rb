require 'spec_helper'

describe 'collectd::plugin::snmp::host', type: :define do
  let :facts do
    {
      osfamily: 'Debian',
      collectd_version: '4.8.0'
    }
  end

  let(:title) { 'foo.example.com' }
  let(:required_params) do
    {
      collect: 'foo'
    }
  end

  let(:filename) { 'snmp-host-foo.example.com.conf' }

  context 'default params' do
    let(:params) { required_params }

    it do
      should contain_file(filename).with(
        ensure: 'present',
        path: '/etc/collectd/conf.d/25-snmp-host-foo.example.com.conf'
      )
    end

    it { should contain_file(filename).that_notifies('Service[collectd]') }
    it { should contain_file(filename).with_content(%r{<Plugin snmp>}) }
    it { should contain_file(filename).with_content(%r{<Host "foo\.example\.com">}) }
    it { should contain_file(filename).with_content(%r{Address "foo\.example\.com"}) }
    it { should contain_file(filename).with_content(%r{Version 1}) }
    it { should contain_file(filename).with_content(%r{Community "public"}) }
    it { should contain_file(filename).without_content(%r{Interval \d+}) }
  end

  context 'all params set' do
    let(:params) do
      required_params.merge(address: 'bar.example.com',
                            version: '2',
                            community: 'opensesame',
                            interval: '30')
    end
    it { should contain_file(filename).with_content(%r{Address "bar\.example\.com"}) }
    it { should contain_file(filename).with_content(%r{Version 2}) }
    it { should contain_file(filename).with_content(%r{Community "opensesame"}) }
    it { should contain_file(filename).with_content(%r{Interval 30}) }
  end

  context 'collect is an array' do
    let(:params) do
      {
        collect: %w( foo bar baz )
      }
    end
    it { should contain_file(filename).with_content(%r{Collect "foo" "bar" "baz"}) }
  end

  context 'collect is just a string' do
    let(:params) do
      {
        collect: 'bat'
      }
    end
    it { should contain_file(filename).with_content(%r{Collect "bat"}) }
  end
end
