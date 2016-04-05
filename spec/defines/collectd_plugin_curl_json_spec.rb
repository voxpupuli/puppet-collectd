require 'spec_helper'

describe 'collectd::plugin::curl_json', :type => :define do
  let :facts do
    {
      :osfamily => 'Debian',
      :collectd_version => '4.8.0',
    }
  end

  let(:title) { 'rabbitmq_overview' }
  let(:my_params) do
    {
      :url => 'http://localhost:55672/api/overview',
      :instance => 'rabbitmq_overview',
      :header   => 'Accept: application/json',
      :keys     => {
        'message_stats/publish' => {
          'type'     => 'gauge',
          'instance' => 'overview'
        }
      }
    }
  end

  let(:filename) { 'rabbitmq_overview.load' }

  context 'default params' do
    let(:params) { my_params }

    it do
      should contain_file(filename).with(
        :path => '/etc/collectd/conf.d/10-rabbitmq_overview.conf'
      )
    end

    it { should contain_file(filename).that_notifies('Service[collectd]') }
    it { should contain_file(filename).with_content(/LoadPlugin "curl_json"/) }
    it { should contain_file(filename).with_content(%r{URL "http://localhost:55672/api/overview">}) }
    it { should contain_file(filename).with_content(%r{Header "Accept: application/json"}) }
    it { should contain_file(filename).with_content(%r{Key "message_stats/publish">}) }
    it { should contain_file(filename).with_content(/Type "gauge"/) }
    it { should contain_file(filename).with_content(/Instance "overview"/) }
  end
end
