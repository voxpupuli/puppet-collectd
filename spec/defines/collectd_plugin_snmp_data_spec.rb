require 'spec_helper'

describe 'collectd::plugin::snmp::data', type: :define do
  let :facts do
    {
      osfamily: 'Debian',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  let(:title) { 'foo' }
  let(:required_params) do
    {
      type: 'bar',
      instance: 'baz',
      values: 'bat'
    }
  end

  let(:filename) { 'snmp-data-foo.conf' }

  context 'required params' do
    let(:params) { required_params }

    it do
      is_expected.to contain_file(filename).with(
        ensure: 'present',
        path: '/etc/collectd/conf.d/15-snmp-data-foo.conf'
      )
    end

    it { is_expected.to contain_file('snmp-data-foo.conf').that_notifies('Service[collectd]') }
    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{<Plugin snmp>}) }
    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{<Data "foo">}) }
    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{Type "bar"}) }
    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{Instance "baz"}) }
  end

  context 'values is an array' do
    let(:params) do
      required_params.merge(values: %w(foo bar baz))
    end
    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{Values "foo" "bar" "baz"}) }
  end

  context 'values is just a string' do
    let(:params) do
      required_params.merge(values: 'bat')
    end
    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{Values "bat"}) }
  end

  context 'Ignore is an array' do
    let(:params) do
      required_params.merge(ignore: %w(hamilton burr jefferson))
    end
    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{Ignore "hamilton" "burr" "jefferson"}) }
  end

  context 'Ignore is just a string' do
    let(:params) do
      required_params.merge(ignore: 'washington')
    end
    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{Ignore "washington"}) }
  end

  context 'table is true' do
    let(:params) do
      {
        table: true
      }.merge(required_params)
    end

    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{Table true}) }
  end

  context 'table is false' do
    let(:params) do
      {
        table: false
      }.merge(required_params)
    end

    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{Table false}) }
  end

  context 'InvertMatch is true' do
    let(:params) do
      {
        invertmatch: true
      }.merge(required_params)
    end

    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{InvertMatch true}) }
  end

  context 'InvertMatch is false' do
    let(:params) do
      {
        invertmatch: false
      }.merge(required_params)
    end

    it { is_expected.to contain_file('snmp-data-foo.conf').with_content(%r{InvertMatch false}) }
  end
end
