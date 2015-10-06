require 'spec_helper'

describe 'collectd::plugin::snmp::data', :type => :define do
  let :facts do
    { :osfamily => 'Debian' }
  end

  let(:title) { 'foo' }
  let(:required_params) do
    {
      :type     => 'bar',
      :instance => 'baz',
      :values   => 'bat',
    }
  end

  let(:filename) { 'snmp-data-foo.conf' }

  context 'required params' do
    let(:params) { required_params }

    it do
      should contain_file(filename).with(
        :ensure => 'present',
        :path   => '/etc/collectd/conf.d/15-snmp-data-foo.conf'
      )
    end

    it { should contain_file('snmp-data-foo.conf').that_notifies('Service[collectd]') }
    it { should contain_file('snmp-data-foo.conf').with_content(/<Plugin snmp>/) }
    it { should contain_file('snmp-data-foo.conf').with_content(/<Data "foo">/) }
    it { should contain_file('snmp-data-foo.conf').with_content(/Type "bar"/) }
    it { should contain_file('snmp-data-foo.conf').with_content(/Instance "baz"/) }
  end

  context 'values is an array' do
    let(:params) do
      required_params.merge(:values => %w( foo bar baz ))
    end
    it { should contain_file('snmp-data-foo.conf').with_content(/Values "foo" "bar" "baz"/) }
  end

  context 'values is just a string' do
    let(:params) do
      required_params.merge(:values => 'bat')
    end
    it { should contain_file('snmp-data-foo.conf').with_content(/Values "bat"/) }
  end

  context 'table is true' do
    let(:params) do
      {
        :table => true
      }.merge(required_params)
    end

    it { should contain_file('snmp-data-foo.conf').with_content(/Table true/) }
  end

  context 'table is false' do
    let(:params) do
      {
        :table => false
      }.merge(required_params)
    end

    it { should contain_file('snmp-data-foo.conf').with_content(/Table false/) }
  end
end
